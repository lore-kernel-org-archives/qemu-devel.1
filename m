Return-Path: <SRS0=tUBQ=3B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57E8C32771
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 09:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD9E822314
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 09:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKOX3vVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9E822314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqZs7-0006LJ-PO
	for qemu-devel@archiver.kernel.org; Sun, 12 Jan 2020 04:49:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iqZr4-0005OJ-Vf
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 04:48:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iqZr4-0000LN-02
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 04:48:22 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:40948)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iqZr3-0000Gp-MR; Sun, 12 Jan 2020 04:48:21 -0500
Received: by mail-lj1-x242.google.com with SMTP id u1so6731350ljk.7;
 Sun, 12 Jan 2020 01:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6A7m8uUuskjk4YfDXph5Jgqp4FV13cMYZFjnVcCuU7M=;
 b=iKOX3vVx4v0vqY89u18l3f/O8aaFVZACifdHS0HkCeg9jvY4igvjG7zFHsUAU4UqZs
 5+DQZU+AN9vrz4MLav+6hZNq/8tt9s/yhSFeLcJn9CyLDQGKK1th4oIy8xHl0ryMXH4y
 /mbAu7hW2dNI4XR5FJANO4R7ig+0CebYjweHVUsEe/vmLpQT4HCBMRtpwy2RG9lWXgmM
 2OWt032JzrBBcWnR4YbQsa8VwXrv+TpCBJjNiMC9ngYd3PNXADpNeqI3XNTNuuAgtVwt
 csECqcs0NY3wylQiIbc1XdM20B3x30XfLJcL6TIkj/a1cVQtTgUaf9XkaOicGbpub3vQ
 Efpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6A7m8uUuskjk4YfDXph5Jgqp4FV13cMYZFjnVcCuU7M=;
 b=Na9Hiu4ApR+gg8XhFWTTUDbcm42DdMjpHoKkSWjWQ+noQHgt+yvJXRIva2oGgBdM9d
 a5SVrSWoPjwTFhS8WBTIZYddV6GrZvzJo6+hdGH6e9oEA+mJDgI6dvTPPWGOR+iscIkW
 5cHDGJI3XVSixH70B6D8Wg8nDVScqAn+13BLWFfJ0UMo+0s8UpOXp0uMnqxfoiiBJUJe
 /Zg+obxh4G28YehXX13R19roYyi06E0qkE3rWZ0UpqkR5MhPo0NjGSBW2mtBoZTFtBbF
 K9mCXUibI8LKUGSCgrIygX+H10aUxOYzWMMdFnt0o3ZeSCbXtf/GGfbJwmLeeKtAA3H1
 8gGw==
X-Gm-Message-State: APjAAAWCWuD99gDoEmoK3DovB2yCsxoo1nP8OONi1Rl0QO0oC7AJA+ol
 EoRjMXujccRRiORLPKt1OWSXTMivpyG6082LewQ=
X-Google-Smtp-Source: APXvYqzxEpyEDY0W+Rak+A9WVun0/sslJHPrmhpVq7UVtIbOk/OdhPOlZeo7krLOxKRghpuLKfUqIquJOp1o582vFDU=
X-Received: by 2002:a2e:8755:: with SMTP id q21mr7697606ljj.156.1578822500350; 
 Sun, 12 Jan 2020 01:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20200109152133.23649-1-philmd@redhat.com>
 <20200109152133.23649-10-philmd@redhat.com>
In-Reply-To: <20200109152133.23649-10-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sun, 12 Jan 2020 17:47:52 +0800
Message-ID: <CAKmqyKPyBp84HN2ARaVKZH7a1ebho9LnK=D9Bj=cpiajx6Lx0w@mail.gmail.com>
Subject: Re: [PATCH 09/15] device_tree: Replace current_machine by
 qdev_get_machine()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "open list:Overall" <kvm@vger.kernel.org>, Juan Quintela <quintela@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 9, 2020 at 11:34 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> As we want to remove the global current_machine,
> replace 'current_machine' by MACHINE(qdev_get_machine()).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  device_tree.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/device_tree.c b/device_tree.c
> index f8b46b3c73..665ea2f586 100644
> --- a/device_tree.c
> +++ b/device_tree.c
> @@ -466,7 +466,9 @@ uint32_t qemu_fdt_alloc_phandle(void *fdt)
>       * which phandle id to start allocating phandles.
>       */
>      if (!phandle) {
> -        phandle =3D machine_phandle_start(current_machine);
> +        MachineState *ms =3D MACHINE(qdev_get_machine());
> +
> +        phandle =3D machine_phandle_start(ms);
>      }
>
>      if (!phandle) {
> --
> 2.21.1
>
>

