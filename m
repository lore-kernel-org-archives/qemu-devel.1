Received: from eggs.gnu.org ([2001:4830:134:3::10]:58536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ej6FQ-0003U7-BH
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:37:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ej6FN-0003Fh-Nu
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:37:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56626
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1ej6FN-0003FR-Gp
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:37:29 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16Ga1DG045449
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 11:37:28 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyfr1s2dc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 11:37:27 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 11:37:26 -0500
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
	<1517864246-11101-12-git-send-email-walling@linux.vnet.ibm.com>
	<0024946c-b47e-14cd-0b30-3a8009f76342@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 6 Feb 2018 11:37:22 -0500
MIME-Version: 1.0
In-Reply-To: <0024946c-b47e-14cd-0b30-3a8009f76342@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <d81608e4-9c74-e0e7-bf25-ccfb59b80204@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 11/12] s390-ccw: clear
 pending irqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

On 02/06/2018 05:07 AM, Thomas Huth wrote:
> On 05.02.2018 21:57, Collin L. Walling wrote:
>> It is possible while waiting for multiple types of external
>> interrupts that we might have pending irqs remaining between
>> irq consumption and irq disabling. Those interrupts could
>> propagate to the guest after IPL completes and cause unwanted
>> behavior.
>>
>> To avoid this, we clear the write event mask to prevent further
>> service interrupts from ASCII events and then consume all pending
>> irqs for a miniscule duration. Once finished, we reset the write
>> event mask and resume business as usual.
>>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> ---
>>   pc-bios/s390-ccw/menu.c | 16 ++++++++++++++++
>>   pc-bios/s390-ccw/sclp.c | 12 ++++++++++++
>>   2 files changed, 28 insertions(+)
>>
>> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
>> index 85d285f..971f6b6 100644
>> --- a/pc-bios/s390-ccw/menu.c
>> +++ b/pc-bios/s390-ccw/menu.c
>> @@ -64,6 +64,20 @@ static inline bool check_clock_int(void)
>>       return *code =3D=3D 0x1004;
>>   }
>>  =20
>> +static void clear_pending_irqs(void)
>> +{
>> +    uint64_t time =3D 50 * TOD_CLOCK_SECOND / 0x3e8;
> s/0x3e8/1000/ please.


Agreed.


>
>> +    sclp_clear_write_mask();
>> +
>> +    set_clock_comparator(get_clock() + time);
>> +    enable_clock_int();
>> +    consume_sclp_int();
>> +    disable_clock_int();
>> +
>> +    sclp_setup(); /* re-enable write mask */
>> +}
> I'm pretty much confused by this code. First, isn't there a small chanc=
e
> that there is a clock int between consume_sclp_int() and
> disable_clock_int() (if consume_sclp_int() has consumed an SCLP
> interrupt instead of a clock interrupt) ?


By clearing the write mask, we can no longer send nor receive ASCII event=
s
(such as prints or keystrokes). Therefore we will not have any service
interrupts originating from keystrokes.

Theoretically, the only interrupt we should be waiting for in this case
is from the clock.


> Second, if you finally enable the SCLP write mask again, doesn't that
> mean that there could be interrupts pending again afterwards?


Yes.=C2=A0 When the write mask is re-enabled for cp_receive mask, we can =
still
get pending service interrupts originating from keystrokes (or other=20
external,
ASCII related interruptions). Hopefully the user does not fall asleep
and smack their head on the keyboard during the IPL process. (joking)

Ideally (as it was suggested in a previous review), we should refactor
the consume_sclp_int so we can manually enable / disable service interrup=
ts,
but I think this is a good first step, no?

We also might be able to get away with just not setting the receive mask =
at
all when we re-enable the write mask. That will prevent any interrupts fr=
om
keystrokes.


>
>   Thomas
>


--=20
- Collin L Walling
