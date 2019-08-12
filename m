Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4881FC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 10:57:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D0220820
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 10:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yO3iQyk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D0220820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx811-00089G-9T
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 06:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57632)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hx7zU-00068b-2u
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 06:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hx7zT-0001Oc-0t
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 06:55:52 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55656)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hx7zS-0001Nx-QU
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 06:55:50 -0400
Received: by mail-wm1-x342.google.com with SMTP id f72so11697964wmf.5
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 03:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=LZxRUJy2ggN3DXh4yMY+ZYe5o4Zbld/CtGFq0f3YH7g=;
 b=yO3iQyk4ht0Elc8Bt6bt6kzTjuxITmtxe/DablmNT5UhY1pRilHEiewbefWyWKofbV
 FVm1G5sjmrJauKvVfKNevXF74L7OUzCj8EsA7n32vndt8a/MpE8xoHv6Lr4qizXyECtw
 4KF/RFX9175pWSzW7Yl0css6zD7FowjOIEbpRxe3joSkkPRpvrV4lgtfXcsHldNVIuF6
 X+0SvzAlVuNORpuZJBSP8N96KpXoBNotMrOJDqUQ/3TVgZ4PtZ4oK3kbUzjZWrPmM2mq
 NOTz7+DosFgYr/UaPLx1LsW/ubvgin14zImhUwVjCslqzgTHbBl848kjtxPlZU3K4xWm
 kkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=LZxRUJy2ggN3DXh4yMY+ZYe5o4Zbld/CtGFq0f3YH7g=;
 b=V7CI34/gFMSuMB3DYS9+/UdgN3V/ET+P1u2AhftwqJcc5Mcy0ZLXeFwVn6RvjR11ng
 5PJpRRZibFcS0fz0bqXWz9a/RHURTiWu3Ox2mz4RJ3pBRncfsgBfS8Dk38X1LihaPWKS
 Ts6fUjlTQNzodgpR1CsvwUEzTGS8wdZ690krug20cBVu64sCrhUJWHlpej1d0mwm8nRh
 2qs/hKiLIBmhK0IllObYNbTPXE0xWy1TZSQt847A0Tq3QH+X/F/5UN5saacDmzPEMCsx
 2broHf+zVQicB5E0dGiDG8cLLhDc1ry7Ot9yZ1ojdiUGl6AApWE3ueCRHEADSgv6ukh/
 LZeQ==
X-Gm-Message-State: APjAAAULotYIwkXfe6sr+0uEfUsRIRfKlF9fb+Mpt+nZtq1R3jOl8wpl
 SfXcotmMvo6oD0kjlzbmbEQGYbvgS6I=
X-Google-Smtp-Source: APXvYqx72mbM5qTmgN7w6sFga8EEbMsHIIO6AdTduOjHsoh4rO7wvyfEtzdcjc/HA1Wy833ElLreig==
X-Received: by 2002:a1c:3142:: with SMTP id x63mr27148540wmx.169.1565607349220; 
 Mon, 12 Aug 2019 03:55:49 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g15sm16922686wrp.29.2019.08.12.03.55.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 12 Aug 2019 03:55:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CB6231FF87;
 Mon, 12 Aug 2019 11:55:46 +0100 (BST)
References: <20190812052359.30071-1-armbru@redhat.com>
 <20190812052359.30071-12-armbru@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190812052359.30071-12-armbru@redhat.com>
Date: Mon, 12 Aug 2019 11:55:46 +0100
Message-ID: <87blwuodot.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v4 11/29] typedefs: Separate incomplete
 types and function types
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Markus Armbruster <armbru@redhat.com> writes:

> While there, drop the obsolete file comment.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/qemu/typedefs.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index fcdaae58c4..29346648d4 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -1,10 +1,10 @@
>  #ifndef QEMU_TYPEDEFS_H
>  #define QEMU_TYPEDEFS_H
>
> -/* A load of opaque types so that device init declarations don't have to
> -   pull in all the real definitions.  */
> -
> -/* Please keep this list in case-insensitive alphabetical order */
> +/*
> + * Incomplete struct types

Maybe expand this a little...

  "Incomplete struct types for modules that don't need the complete
  definitions but still pass around typed variables."?

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> + * Please keep this list in case-insensitive alphabetical order.
> + */
>  typedef struct AdapterInfo AdapterInfo;
>  typedef struct AddressSpace AddressSpace;
>  typedef struct AioContext AioContext;
> @@ -101,6 +101,10 @@ typedef struct SHPCDevice SHPCDevice;
>  typedef struct SSIBus SSIBus;
>  typedef struct VirtIODevice VirtIODevice;
>  typedef struct Visitor Visitor;
> +
> +/*
> + * Function types
> + */
>  typedef void SaveStateHandler(QEMUFile *f, void *opaque);
>  typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);


--
Alex Benn=C3=A9e

