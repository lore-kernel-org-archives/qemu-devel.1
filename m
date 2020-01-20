Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08601C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:15:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF5A20674
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bB2PwQNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF5A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itV1b-0001Pm-Ia
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 06:15:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1itUql-0002Ll-Ff
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1itUqj-0002nw-W2
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:04:06 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44879)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1itUqj-0002mN-Aq
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:04:05 -0500
Received: by mail-wr1-x441.google.com with SMTP id q10so29065716wrm.11
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 03:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=p09tWZi6Mh/PoVmwFymJ2qeSGzN3KJdANk+Jh54lTUU=;
 b=bB2PwQNSTnWELk0dsE4vJ4CHtcieOwbMLgaJBFICbmk7LvoGp4YncbZXDHTBs1s2rB
 zJi0paCxKAo5OtzwHczFK0SZbpRwUUgKC1OJe1S/7B7lGlNkF+aIo9w7N1E7XzI8K6F5
 2i7L9B803pKOsGOYd1IgTrkr5t/QGAHxW8unE9p62K/kIQipSaCJDvp/19x5PI+6NDgp
 qA61bMRRUQUS84H9nPEDYVOx4p2XuQ/NWo+ZwlanKSGy0MisacoHjzIpDnhaBqXu+g29
 IoU7uL4CC91K0vnJ4kmiFLV2W2Y4gNCFla/X/M9/+fhk6mdEaZabSbpccXCLN6TKVtoQ
 bhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=p09tWZi6Mh/PoVmwFymJ2qeSGzN3KJdANk+Jh54lTUU=;
 b=LkxHyIkjZfn0qIxOvij+DqVMFXJUifFiW2oGl6RRjqsoRPPjT7+/rOiTQL/HmmyXMn
 h8nERq3PyfV8jCw0/yVAsgo/Pgi8/8o9wiRMFkth8RLXA0D27BID6SvdgOLC9DmN1YNL
 k0ifmsQAsgBlgogpg5uBwpTK0QV1AkGJPqAijyo0ysLCg42Zx/TVM5zjTZv8DZlGXjo6
 5RH4q/kTJ/sG7+AiAwsHgC8wHQp015JKa7r59O8ngromRK9uIJeSWa8O1P6INgG8wfVV
 o4NDfyKbeQ66LAYPGn05W6jFQG73sICKosKwzqbTKTg+ONFl3H09nxCFeluh5/aFQ+Ch
 pj7g==
X-Gm-Message-State: APjAAAXEsN3whDeLIIGqoTkFzh+bxvPcTwFLeuI1uRvSPGC2eH0zpZjg
 WjJqBXcAj8NktQG/BLEMckerDw==
X-Google-Smtp-Source: APXvYqz/ox3BECn0pY+hcnGnNUEjD8toU+b0rHuvWp0XX98ExUsMvlLYvI+gAjWRky/B8qEf8Buj8w==
X-Received: by 2002:a5d:4d0e:: with SMTP id z14mr17825578wrt.208.1579518244109; 
 Mon, 20 Jan 2020 03:04:04 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 124sm23537668wmc.29.2020.01.20.03.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 03:04:02 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 206281FF87;
 Mon, 20 Jan 2020 11:04:02 +0000 (GMT)
References: <20200118140619.26333-1-philmd@redhat.com>
 <20200118140619.26333-5-philmd@redhat.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 4/6] Makefile: Remove unhelpful comment
In-reply-to: <20200118140619.26333-5-philmd@redhat.com>
Date: Mon, 20 Jan 2020 11:04:02 +0000
Message-ID: <87a76i4cf1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> It is pointless to keep qapi/ object separate from the other
> common-objects. Drop the comment.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  Makefile.objs | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile.objs b/Makefile.objs
> index 395dd1e670..c6321d0465 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -71,11 +71,9 @@ qemu-seccomp.o-libs :=3D $(SECCOMP_LIBS)
>=20=20
>  common-obj-$(CONFIG_FDT) +=3D device_tree.o
>=20=20
> -######################################################################
> -# qapi
> -
>  common-obj-y +=3D qapi/
> -endif
> +
> +endif # CONFIG_SOFTMMU
>=20=20
>  #######################################################################
>  # Target-independent parts used in system and user emulation


--=20
Alex Benn=C3=A9e

