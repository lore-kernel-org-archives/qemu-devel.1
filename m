Received: from eggs.gnu.org ([2001:4830:134:3::10]:52812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsTxY-0001B1-Qk
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsTxX-0005QV-F9
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:13:36 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:47490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dsTxX-0005PH-86
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:13:35 -0400
Received: by mail-wm0-x229.google.com with SMTP id 13so303409wmq.2
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 06:13:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a9891f10-9643-96ee-7f99-7a384b9ea302@amsat.org>
References: <1504812251-23438-1-git-send-email-sundeep.lkml@gmail.com>
	<1504812251-23438-3-git-send-email-sundeep.lkml@gmail.com>
	<a9891f10-9643-96ee-7f99-7a384b9ea302@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 14:13:13 +0100
Message-ID: <CAFEAcA8KUtG=2Cr_PndUqOxp5PN6bTJR_t=s+Ch+Y2WVfHVjQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu devel v8 PATCH 2/5] msf2: Microsemi
 Smartfusion2 System Register block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair23@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 14 September 2017 at 05:36, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
> On 09/07/2017 04:24 PM, Subbaraya Sundeep wrote:
>> +static uint64_t msf2_sysreg_read(void *opaque, hwaddr offset,
>> +    unsigned size)
>> +{
>> +    MSF2SysregState *s =3D opaque;
>> +    uint32_t ret =3D 0;
>> +
>> +    offset >>=3D 2;
>> +    if (offset < ARRAY_SIZE(s->regs)) {
>
>
> This comment is controversial, I'll let Peter nod.
>
> The SYSREG behaves differently regarding which bus access it (CPU, AHB).
> You are implementing CPU access to the SYSREG, the registers have differe=
nt
> permissions when accessed by the CPU. (see the SmartFusion2 User Guide:
> Table 21-1 "Register Types" and Table 21-2 "Register Map").
>
> I'd think of this stub:
>
> switch(reg) {
> case register_supported1:
> case register_supported2:
> case register_supported3:
>            ret =3D s->regs[offset];
>            trace_msf2_sysreg_read(offset, ret);
>            break;
> case RO-U:
>            qemu_log_mask(LOG_GUEST_ERROR, "Illegal AHB access 0x%08"...
>            break;
> case W1P:
>            qemu_log_mask(LOG_GUEST_ERROR, "Illegal read access ...
>            break;
> case RW:
> case RW-P:
> case RO:
> case RO-P:
> default:
>            ret =3D s->regs[offset];
>            qemu_log_mask(LOG_UNIMP, "...
>            break;
> }

This doesn't look entirely right, since this is the read interface.
Shouldn't we be allowing pretty much all of these register types
except maybe W1P to do a read?

On the other hand, in the write function we should probably not allow
writes to registers documented as read only.

thanks
-- PMM
