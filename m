Received: from eggs.gnu.org ([2001:4830:134:3::10]:46141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1e1YXW-0006ab-Os
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:56:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1e1YXR-0007yD-RA
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:56:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47168
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1e1YXR-0007w6-LK
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:56:09 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v99Dsj9w057019
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 09:56:03 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dg4cec4p2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 09:56:03 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 14:56:00 +0100
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1507124979-8880-3-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171009101714.5b52d432.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Mon, 9 Oct 2017 15:55:57 +0200
MIME-Version: 1.0
In-Reply-To: <20171009101714.5b52d432.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <419c3fc1-638a-9bf1-d0f3-4d9fc40ed426@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/5] s390x/css: Use AIS AIRQ injection
 only if adapter support AIS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, qemu-s390x@nongnu.org

On 09/10/2017 10:17, Cornelia Huck wrote:
> On Wed,  4 Oct 2017 15:49:36 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>=20
>> Testing to use Adapter Interrupt suppression or not depend on AIS
>> being enabled in the kernel.
>> To implement AIS emulation we must move this test inside the FLIC
>> dedicated irq_inject function.
>>
>> Furthermore, a test to verify that the adapter is subject to the AIS
>> must be added.
>>
>> Last, there is no need to crash QEMU if the injection failed, the
>> guest may recover from it.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/css.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>> index 901dc6a..6e74a5c 100644
>> --- a/hw/s390x/css.c
>> +++ b/hw/s390x/css.c
>> @@ -672,10 +672,12 @@ void css_adapter_interrupt(CssIoAdapterType type=
, uint8_t isc)
>>       }
>>  =20
>>       trace_css_adapter_interrupt(isc);
>> -    if (fs->ais_supported) {
>> +    /* Use standard IRQ injection for adapters not supporting AIS */
>=20
> I'd move that comment to the else branch.

yes, clear.

>=20
>> +    if (adapter->flags & S390_ADAPTER_SUPPRESSIBLE) {
>> +        /* Use AIRQ injection for adapters subject to AIS */
>>           if (fsc->inject_airq(fs, type, isc, adapter->flags)) {
>>               error_report("Failed to inject airq with AIS supported")=
;
>> -            exit(1);
>> +            /* Report error - guest will handle not receiving interru=
pts */
>=20
> I'm not 100% sure that this is the right thing to do. I have always
> operated under the assumption "if the hardware (host) accepts the I/O,
> it owes you an interrupt". (Don't the other failed interrupt injection
> paths do a hard stop as well? Is there any reasonable way for an
> injection failure to be transient?)

You are right and it is out of scope.
So I will let this untouch.

>=20
>>           }
>>       } else {
>>           s390_io_interrupt(0, 0, 0, io_int_word);
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
