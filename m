Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D492BC33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 02:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EACE20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 02:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uRmU8IrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EACE20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irBX4-0004RG-5H
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 21:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1irBVJ-00033V-Ir
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 21:00:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1irBVI-0001ir-Ft
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 21:00:25 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:37808)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1irBVH-0001fI-CB; Mon, 13 Jan 2020 21:00:24 -0500
Received: by mail-lf1-x144.google.com with SMTP id b15so8477053lfc.4;
 Mon, 13 Jan 2020 18:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8TABIaesLWHDdS8DK0RdBcbOgWuOS8JDBz9kVGBhjg8=;
 b=uRmU8IrV2Kwgz/8qAURHetLcRDt3Xpz+7Q+UEKS2zWcNKTiiWfpPHx5mdVxEnoixfX
 36yfOm0yDR879p/RKRBHVx8EtNtQJ5qBPMyzweYPSU2w+444J8Jt9SRsRZG0wvAu9hQu
 TauGzJurlrQNCk4DOMnvefBI8pHg2UTDjnnbZcoTeTZtYnTGE6HYxiAN5+0wQmhB3I+n
 o4c7A5cNIUw0C+gAcNQHLOeJ9jUE9sSW0fPJgXejwbEVaD6zo5fCH+HvVYL1Jf6Of71+
 Rjmp2ryhqLzn2vcPE2we56FnkGK8xyLaeHLN5XaF7oeaqGv5nHLLzbbx3EBoF93P34/N
 bkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8TABIaesLWHDdS8DK0RdBcbOgWuOS8JDBz9kVGBhjg8=;
 b=qZnxLBJadSuiMZB6VdBdpM9MPOeqKMZLnmlE+829GnQQy2PF2N+j2u3dmcdGrsdY/1
 27lDhmjK8dgTSz7IaVubfdwfqp66GYvhK5LV7E6TlhCFHZf4bSvD0eePXHSVXJePnwei
 OAxaIB84KSvTSBxmamW5YoFWpLgn6PVItcdlSDmVit33QaMdVOZAc8CJNyEdlQO87Cre
 5vZxQLHx4RSJtQHb36zfJfveLT1ubTT6c4mcCO3SNe0agN3seLD08nolaw4fEVUMAY7N
 5BV20kyIpFD+vOFvVTfj1R0mBDQPjqS6PXyuStnchjljIXJHbC4NRTPVfEhW+jr77EUG
 p4FA==
X-Gm-Message-State: APjAAAVbYp7IqDeMEwz/QpNUxNkNn4ZF0dHchjVk3kzgZThuGIUW6vlY
 lrVU9tiXjzkZVmQR2LO/pz6kcsCwh/Nh/e+Thkw=
X-Google-Smtp-Source: APXvYqwUIQSiQcj1gBt1vZS9VSYTqmqQ5Z0LwWrxO9JJb50ZRngJxt2wHTwfjP90rCFRNHVqaZezjew947fjp7tLGnk=
X-Received: by 2002:ac2:5498:: with SMTP id t24mr250782lfk.84.1578967222098;
 Mon, 13 Jan 2020 18:00:22 -0800 (PST)
MIME-Version: 1.0
References: <20200109152133.23649-1-philmd@redhat.com>
 <20200109152133.23649-15-philmd@redhat.com>
In-Reply-To: <20200109152133.23649-15-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 Jan 2020 11:59:55 +1000
Message-ID: <CAKmqyKPa0F6B1PR3O4-Tsz64guywyLxHO5FSQVZAw4D3KNrGZA@mail.gmail.com>
Subject: Re: [PATCH 14/15] accel/accel: Replace current_machine by
 qdev_get_machine()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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

On Fri, Jan 10, 2020 at 1:40 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> As we want to remove the global current_machine,
> replace 'current_machine' by MACHINE(qdev_get_machine()).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

I feel like this could be squashed with the one that adds this
function, but either way:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  accel/accel.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/accel/accel.c b/accel/accel.c
> index cb555e3b06..777d6ba119 100644
> --- a/accel/accel.c
> +++ b/accel/accel.c
> @@ -65,7 +65,9 @@ int accel_init_machine(AccelState *accel, MachineState =
*ms)
>
>  AccelState *current_accel(void)
>  {
> -    return current_machine->accelerator;
> +    MachineState *ms =3D MACHINE(qdev_get_machine());
> +
> +    return ms->accelerator;
>  }
>
>  void accel_setup_post(MachineState *ms)
> --
> 2.21.1
>
>

