Received: from eggs.gnu.org ([2001:4830:134:3::10]:55706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eS258-0003ju-Bs
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eS255-00034j-9H
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:44:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60254
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eS255-00033v-0A
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:44:19 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBLEgIDV121647
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 09:44:16 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2f0bwurvxh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 09:44:15 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 21 Dec 2017 09:44:14 -0500
References: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510323112-2207-7-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CKg3G-JUZDPOK66GDwmL7d=JsjechKd=Xin7CvAVo0UuA@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 21 Dec 2017 09:44:11 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKg3G-JUZDPOK66GDwmL7d=JsjechKd=Xin7CvAVo0UuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <a587de86-84cc-72f5-e541-1c7597c0f1dc@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 06/13] tpm_tis: move r/w_offsets to
 TPMState
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

On 12/21/2017 09:41 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Fri, Nov 10, 2017 at 3:11 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> Now that we have a single buffer, we also only need a single set of
>> read/write offsets into that buffer. This works since only one
>> locality can be active.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> ---
>>   hw/tpm/tpm_tis.c | 57 +++++++++++++++++++++++++++-------------------=
----------
>>   1 file changed, 27 insertions(+), 30 deletions(-)
>>
>> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
>> index 0b6dd7f..dfdddd3 100644
>> waddr addr,
>>               }
>>
>>               while ((s->loc[locty].sts & TPM_TIS_STS_EXPECT) && size =
> 0) {
>> -                if (s->loc[locty].w_offset < s->be_buffer_size) {
>> -                    s->buffer[s->loc[locty].w_offset++] =3D
>> +                if (s->w_offset < s->be_buffer_size) {
>> +                    s->buffer[s->w_offset++] =3D
>>                           (uint8_t)val;
>>                       val >>=3D 8;
>>                       size--;
>> @@ -931,13 +928,13 @@ static void tpm_tis_mmio_write(void *opaque, hwa=
ddr addr,
>>               }
>>
>>               /* check for complete packet */
>> -            if (s->loc[locty].w_offset > 5 &&
>> +            if (s->w_offset > 5 &&
>>                   (s->loc[locty].sts & TPM_TIS_STS_EXPECT)) {
>>                   /* we have a packet length - see if we have all of i=
t */
>>                   bool need_irq =3D !(s->loc[locty].sts & TPM_TIS_STS_=
VALID);
>>
>>                   len =3D tpm_cmd_get_size(&s->buffer);
>> -                if (len > s->loc[locty].w_offset) {
>> +                if (len > s->w_offset) {
>>                       tpm_tis_sts_set(&s->loc[locty],
>>                                       TPM_TIS_STS_EXPECT | TPM_TIS_STS=
_VALID);
>>                   } else {
>> @@ -1022,8 +1019,8 @@ static void tpm_tis_reset(DeviceState *dev)
>>           s->loc[c].ints =3D 0;
>>           s->loc[c].state =3D TPM_TIS_STATE_IDLE;
>>
>> -        s->loc[c].w_offset =3D 0;
>> -        s->loc[c].r_offset =3D 0;
>> +        s->w_offset =3D 0;
>> +        s->r_offset =3D 0;
>>       }
>>
>>       tpm_tis_do_startup_tpm(s, s->be_buffer_size);
>> --
>> 2.5.5
>>
>>
> Looks good, but I wonder why it's not part of "tpm_tis: move buffers
> from localities into common location"
>
> Not a big deal though, so
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

I thought it may be easier to review/follow if I do all these steps=20
separately. I could squash it together.


    Stefan

>
>
>
