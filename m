Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9B4ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3692089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQbbOJh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3692089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL4bM-0000MP-8n
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 08:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL4aK-0007tk-Q4
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL4aJ-0002CL-NJ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:08:52 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL4aJ-0002CC-IQ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:08:51 -0400
Received: by mail-oi1-x242.google.com with SMTP id g81so1902944oib.8
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 05:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Kvz+9MVpfKERSKaM+4J6RmraJtKLQBXbMl09w0KPDTU=;
 b=xQbbOJh6xvgdMpoE27wv2kVjUjT+Y5rlgKjytOAqsI2A817WCyBZ9IQg6+v+UOmlM6
 DcqZkij3waOeQmFdWHFnkVHZtbkNY6WQ+WWD6jdKz4W2WQojiqNcC0T93iq1WRhnovLo
 GV5F4KrMqQXfobfsYO8t7at9fpsj87NJNyThVKvJzSZR+vvUe5wdkp8wO90/CgXw3ApT
 LcdINWS4p/yMm29iRrgBdBphdxdhq65XyY60oUmRx7O/a5zoQrYtMk/uc7qPEMIx6PjG
 eLkR4fS7mLAUpta+V7L3E/ZqqUUTPNSKUmSYZVutTqE/uBt7TtOOugDKsWs5dtyhM9cl
 kgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Kvz+9MVpfKERSKaM+4J6RmraJtKLQBXbMl09w0KPDTU=;
 b=d9AzWJu5BG0gO9EOxnRioKhl6h/NUBTGmg8HFaHUhDhysoGbWIFMrkwfftsLGFHKBw
 4FUN5BvT1ETqOIrJG3minOc6laodLrJpxGAt89Th1nyJRDEUtSLEHSP8gHhc8iFkHHwM
 zbSkeDLct9707gVfG955NbsE8fqSqgA7SEWliSpQFCC29GXKi6fqaYR1aKBW0yBm8UaG
 +unHd17SUqTTiRw+81rQBCfeIy0ff1ARlMsUnwlIbEUoIZn8zZcoU8zvwRDL0HS5Xkhv
 zy6zKzk06TI7ojYHD9FId7jZ4bHEGfNOUlA1pVF0GNIED1cI9p82e5lqTSxa2PgHdPQr
 wpUA==
X-Gm-Message-State: APjAAAUtG5MKy3QFMh4pxzSmvRi6StCrNrtV3PNkfKjAXdqdnCVxryB+
 foKpW0c/pOoj2uEzuRNx0WVi/baPiV/YD3OW2cmp2g==
X-Google-Smtp-Source: APXvYqy1lKWqn51y5cSlCxIoQ7xEJnScUnQwveT+GoXiLh0slojCIfAQLzvRyi5Tx1HC+4afschr0VJeOj3WAeJFbNA=
X-Received: by 2002:a05:6808:9:: with SMTP id u9mr2923634oic.98.1571314130588; 
 Thu, 17 Oct 2019 05:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <07ef5d368b4bbada15eaae0d23378a323969026b.1570121723.git.alistair.francis@wdc.com>
In-Reply-To: <07ef5d368b4bbada15eaae0d23378a323969026b.1570121723.git.alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 13:08:39 +0100
Message-ID: <CAFEAcA_Sk2VFxxHV92RpaaRt3MLY2n_xYYM7CSwTTcxLDVtsgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] riscv/boot: Fix possible memory leak
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping? It would be nice to see this patch get into master
to silence the coverity errors.

thanks
-- PMM

On Thu, 3 Oct 2019 at 18:05, Alistair Francis <alistair.francis@wdc.com> wr=
ote:
>
> Coverity (CID 1405786) thinks that there is a possible memory leak as
> we don't guarantee that the memory allocated from riscv_find_firmware()
> is freed. This is a false positive, but let's tidy up the code to fix
> the warning.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2:
>  - Fix commit typos
>
>  hw/riscv/boot.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 2e92fb0680..7fee98d2f8 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -38,7 +38,7 @@ void riscv_find_and_load_firmware(MachineState *machine=
,
>                                    const char *default_machine_firmware,
>                                    hwaddr firmware_load_addr)
>  {
> -    char *firmware_filename;
> +    char *firmware_filename =3D NULL;
>
>      if (!machine->firmware) {
>          /*
> @@ -70,14 +70,11 @@ void riscv_find_and_load_firmware(MachineState *machi=
ne,
>           * if no -bios option is set without breaking anything.
>           */
>          firmware_filename =3D riscv_find_firmware(default_machine_firmwa=
re);
> -    } else {
> -        firmware_filename =3D machine->firmware;
> -        if (strcmp(firmware_filename, "none")) {
> -            firmware_filename =3D riscv_find_firmware(firmware_filename)=
;
> -        }
> +    } else if (strcmp(machine->firmware, "none")) {
> +        firmware_filename =3D riscv_find_firmware(machine->firmware);
>      }
>
> -    if (strcmp(firmware_filename, "none")) {
> +    if (firmware_filename) {
>          /* If not "none" load the firmware */
>          riscv_load_firmware(firmware_filename, firmware_load_addr);
>          g_free(firmware_filename);
> --
> 2.23.0

