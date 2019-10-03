Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCA0C32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 07:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C5BD222C7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 07:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HmnvQikA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C5BD222C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFvBP-0001DI-Kn
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 03:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFvAa-0000b7-2e
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 03:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFvAX-00048g-EZ
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 03:04:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34522
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFvAX-00048S-2M
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 03:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570086295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C6ltcGQLZfldS8yXWHTgjtks/bc5B9SoVXaYQ5Gcnwo=;
 b=HmnvQikAolI9hBz6tu/bCa0pyqKVF5ZyEo6SC49n38Fg8Y9QRyBPHkmIT4BRNXmIMST1oi
 DxBgoLEkMaRyIWte1B4scQgJnz+O2pWKDpPIaAVxg+UFxSxUX1gX4huZFe+pM9pulPgdcu
 obl2okkDx/wNO8SKxc8PXSv95zJXHxs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-MJ7J5hozOPODRkbOnvDUDA-1; Thu, 03 Oct 2019 03:04:54 -0400
Received: by mail-wm1-f71.google.com with SMTP id k184so732594wmk.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 00:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ehvHZDO8kG+zG/2KzYQqnzm1x88Z2sej/c5l+4eo2l4=;
 b=iOcuFKy5X3a7DnivbxGeklkZD2I57qN/sIFr9Q+PSurvjKy/s71jQieS4sZ5NUuVbn
 /5hKcy5vM5GfCqNA8iwTLZy5Qc6GquaY0xrF8Sc7zo7RLYcHEX6su6phujXmLxdKWOnc
 nKMMqmQj7tnLpEr/kQN0up5jwioiP8KVZn62Kya4KPvCmTz4uMF+ylHkxnY9VKTlHeji
 CenKx+/5Ot//9KGnFmQtMq+8fyQ6B5aOay27MvVSi9n8QeRluZSN+lB7fFHbkOhtdBxY
 nkBaSwrzWwf/QMrsz7PdfK2MsMTJEkEq5BNcT7cF/k+U/nkevCN5AV7A5NV/IECdV5u3
 +MuQ==
X-Gm-Message-State: APjAAAWREOkKihVvrpbF0TUiUwt5fO2SVNlfa71sM35nbu1gbO/G/lct
 s88Gl+wpnCn0eMrCWCc1MChC5NyRhl+QeQON0hZIIAy5puVUUV+k/mFphwgMdL6Vd62z/rP60DU
 hoLIFK4X+2XYSOr4=
X-Received: by 2002:adf:eec5:: with SMTP id a5mr1720122wrp.191.1570086293035; 
 Thu, 03 Oct 2019 00:04:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxyMkMIF21P9FdlT28VM+54ZAxwp7xiHRhi4Ff1yPBYYGOniGnwlSAlf6AmRK47Sf1TfmWPkA==
X-Received: by 2002:adf:eec5:: with SMTP id a5mr1720094wrp.191.1570086292716; 
 Thu, 03 Oct 2019 00:04:52 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b15sm1557775wmb.28.2019.10.03.00.04.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2019 00:04:52 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] riscv/boot: Fix possible memory leak
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <4cba4d80e570372183b6685a26c72fa3e907bb51.1570051975.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b26817c1-c2ae-6637-1cb2-81187b6682bc@redhat.com>
Date: Thu, 3 Oct 2019 09:04:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <4cba4d80e570372183b6685a26c72fa3e907bb51.1570051975.git.alistair.francis@wdc.com>
Content-Language: en-US
X-MC-Unique: MJ7J5hozOPODRkbOnvDUDA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, alistair23@gmail.com, palmer@sifive.com,
 bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/19 11:34 PM, Alistair Francis wrote:
> Coverity (CID 1405786) thinks that there is a possible memory leak as
> we don't guarentee that the memory allocatd from riscv_find_firmware()

typos: 'guarantee', 'allocated'

> is freed. This is a false positive, but let's tidy up the code to fix
> the warning.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   hw/riscv/boot.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 2e92fb0680..7fee98d2f8 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -38,7 +38,7 @@ void riscv_find_and_load_firmware(MachineState *machine=
,
>                                     const char *default_machine_firmware,
>                                     hwaddr firmware_load_addr)
>   {
> -    char *firmware_filename;
> +    char *firmware_filename =3D NULL;
>  =20
>       if (!machine->firmware) {
>           /*
> @@ -70,14 +70,11 @@ void riscv_find_and_load_firmware(MachineState *machi=
ne,
>            * if no -bios option is set without breaking anything.
>            */
>           firmware_filename =3D riscv_find_firmware(default_machine_firmw=
are);
> -    } else {
> -        firmware_filename =3D machine->firmware;
> -        if (strcmp(firmware_filename, "none")) {
> -            firmware_filename =3D riscv_find_firmware(firmware_filename)=
;
> -        }
> +    } else if (strcmp(machine->firmware, "none")) {
> +        firmware_filename =3D riscv_find_firmware(machine->firmware);
>       }
>  =20
> -    if (strcmp(firmware_filename, "none")) {
> +    if (firmware_filename) {
>           /* If not "none" load the firmware */
>           riscv_load_firmware(firmware_filename, firmware_load_addr);
>           g_free(firmware_filename);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


