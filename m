Received: from eggs.gnu.org ([2001:4830:134:3::10]:58448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eyK0A-0003b0-0d
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eyK06-0002v4-GZ
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:20:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44518
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eyK06-0002uZ-Ad
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:20:38 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2KGDKVB110602
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 12:20:37 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gu4xvarwb-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 12:20:37 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 20 Mar 2018 10:20:36 -0600
References: <1521476505-30584-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CK2uEhbQ6UaPY5JTiXxRD==OyqBXTBzQpzrh-ud1NcaDQ@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 20 Mar 2018 12:20:33 -0400
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CK2uEhbQ6UaPY5JTiXxRD==OyqBXTBzQpzrh-ud1NcaDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <4c85990d-5c3a-b785-7603-0f5a0f9d332c@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tpm: Set tpmRegValidSts flag to '1' in
 device reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stephen Douthit <stephend@silicom-usa.com>

On 03/20/2018 10:52 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Mon, Mar 19, 2018 at 5:21 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> Fix the initialization of the tpmRegValidSts flag and set it to '1'
>> during device reset without expecting a write to another register.
>> This seems to also be the default behavior of real hardware.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> ---
>>   hw/tpm/tpm_crb.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
>> index d8917cb..114b66e 100644
>> --- a/hw/tpm/tpm_crb.c
>> +++ b/hw/tpm/tpm_crb.c
>> @@ -145,8 +145,6 @@ static void tpm_crb_mmio_write(void *opaque, hwadd=
r addr,
>>                                beenSeized, 0);
>>               ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
>>                                locAssigned, 1);
>> -            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
>> -                             tpmRegValidSts, 1);
>>               break;
>>           }
>>           break;
>> @@ -210,6 +208,8 @@ static void tpm_crb_reset(void *dev)
>>
>>       tpm_backend_reset(s->tpmbe);
>>
>> +    ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
>> +                     tpmRegValidSts, 1);
>>       ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
>>                        InterfaceType, CRB_INTF_TYPE_CRB_ACTIVE);
>>       ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> Hmm, the specification says they default to 0. Except tpmEstablished
> to 1, which we should probably manipulate somehow ("The TPM clears
> this bit to 0 upon receipt of _TPM_Hash_End The TPM sets this bit to a
> 1 when the TPM_LOC_CTRL_x.resetEstablishment field is set to 1.").
> Help welcome!

Right. We would have to set this flag to '1' -- maybe in a separate=20
patch. We don't support DRTM, which is initiated by CPU instructions,=20
that would then cause the _TPM_Hash_End. So there's no need to=20
manipulate it.
>
> Shouldn't it also set locAssigned to 1 in this case ?

Stephen Douthit did some experiments with a hardware TPM and posted a=20
patch to SeaBIOS mailing list:

https://mail.coreboot.org/pipermail/seabios/2018-March/012221.html

A hardware TPM would see the tpmRegValidSts bit set but not the=20
locAssigned bit. I think our method of setting the locAssigned bit=20
following the requestAccess bit being set is correct.

Also, in the following spec on pdf page 67 it indicates that after 500=20
usec the tpmRegValidSts bit is set to a valid value. This means that no=20
other register needs to be written to so that this happens. The text=20
later on near Table 24 is a little more vague about that I find.

https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platfo=
rm_TPM_Profile_PTP_Specification_Family_2.0_Revision_1.3v22.pdf




>
> I am not very familiar with the locality support, since I didn't
> implement it for CRB. You may have more clues what is expected here.
>
