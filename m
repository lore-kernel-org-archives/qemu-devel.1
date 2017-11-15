Received: from eggs.gnu.org ([2001:4830:134:3::10]:34726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eEmM7-0005ft-Rb
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 20:19:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eEmM4-0003A6-GG
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 20:19:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44928
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eEmM4-00039s-AE
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 20:19:04 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAF1IovP091342
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 20:18:58 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e8a9budbw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 20:18:57 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 14 Nov 2017 18:18:57 -0700
References: <1510696349-5151-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510696349-5151-4-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CLEUxM=BRnxOtni2-VU10Ho7mvzcSAMP3S2MLQtjwSbrA@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 14 Nov 2017 20:18:53 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLEUxM=BRnxOtni2-VU10Ho7mvzcSAMP3S2MLQtjwSbrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <8f332ba7-87f3-2f7e-1549-ba2435e090d1@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11 3/3] tpm_tis: Return 0 for
 every register in case of failure mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Amarnath Valluri <amarnath.valluri@intel.com>

On 11/14/2017 06:47 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Tue, Nov 14, 2017 at 10:52 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> Rather than returning ~0, return 0 for every register in case of
>> failure mode. The '0' is better to indicate that there's no device
>> there.
> For most registers, 0 makes more sense. However, I wonder if we
> shouldn't just fail to start qemu in this case...
>
> Not convincing me this is 2.11 material either. Does this fix a specifi=
c bug?

Yes, SeaBIOS detects the ~0 when it probes and thinks there's a device=20
there. It then hangs trying to set flags and read registers to be able=20
to use the device.

    Stefan

>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> ---
>>   hw/tpm/tpm_tis.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
>> index fec2fc6..42d647d 100644
>> --- a/hw/tpm/tpm_tis.c
>> +++ b/hw/tpm/tpm_tis.c
>> @@ -545,7 +545,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hw=
addr addr,
>>       uint8_t v;
>>
>>       if (tpm_backend_had_startup_error(s->be_driver)) {
>> -        return val;
>> +        return 0;
>>       }
>>
>>       switch (offset) {
>> --
>> 2.5.5
>>
>
>
