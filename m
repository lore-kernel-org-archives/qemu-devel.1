Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C38DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52DC2206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tM7aGjd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DC2206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Nxh-0002Mn-HY
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 07:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1k0Nvu-0000b0-FS
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 07:38:10 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:37007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1k0Nvs-0002X3-K5
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 07:38:10 -0400
Received: by mail-wm1-x32f.google.com with SMTP id k8so7527267wma.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 04:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=GtCXrUyMcdfUK9u5L9780Nv/+GQh+rPlWS9tXEVEQ1E=;
 b=tM7aGjd0FQT3yaT7+031Tlnysibz7ocdgILc/qNcllesimpWOyi1Ny6a4L/hDJnr6K
 llwf0E9RA0hHT4WNR/XM88aVBh5S1/P8YX2Sm4gohXauAAR5fNremiNKDoN9a0RLMGvb
 hqMDnJaxM8MJ5kjXyaNPVZOZKVUJ2uNSPyGLUQBEVKBKzR14DtyKpOCWkEwOl9MtCmg6
 W6Hn/X7KlpZdQCj+hnM4LkQQkibiFPMM5SfTvW/u06BBR9GmLXgS+vWlr2M3o8dOMG3J
 30QOlaozpUpSqkYfZPsl7FiCN+4XiPh+pyBGxt9h/DC5penPyMY0RFiii1wAn3eGREBX
 zXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=GtCXrUyMcdfUK9u5L9780Nv/+GQh+rPlWS9tXEVEQ1E=;
 b=kU9QN18eq8bLSkZd+9kIAw9hQz/+qkiKWHhabCfhJWiWqu1ovxVJgiJcoj7PJYM+Mn
 ji85Bsf02AQU+eyaPY3CJHPKDLI5GGlLAlwFt4zfIMmgOmRGup4Tb5aJgo6bs2Dd71v4
 c8P09IO7KMzqBi7r6KBrvB2UnqfFnL1zP9/XcecQh6zGlDmFz7Q0hF152iQVjFJUkdHL
 HcKeV03Qo/qxsmLUBNZF+qpA6MBq391cTO7Q+gBxozsTRr7LYGd5AgpmssoS6GAc60Bb
 M2YGrzfJZYltnH9MXuYVyup9CMDmcBtWbpdHAvkMzKwb1KJJ9G27HhRFDVPP8uOfuY33
 Rwdw==
X-Gm-Message-State: AOAM5326927UEfMaYsbjlTafsrK+h8TjpTlV+8d0PfNpAZ58EN5jOFcd
 bXBp3ZQxH3HDNbXAOsBH9dE=
X-Google-Smtp-Source: ABdhPJz/rLdReHCjDfI4CPt0oZx4S9Edc53mF4qYVIcJnJHvTAYUGj9wZfJjhvhtT6hUxywQ/eS0bw==
X-Received: by 2002:a1c:a9c6:: with SMTP id s189mr3429083wme.166.1595936285688; 
 Tue, 28 Jul 2020 04:38:05 -0700 (PDT)
Received: from CBGR90WXYV0 (host86-143-223-30.range86-143.btcentralplus.com.
 [86.143.223.30])
 by smtp.gmail.com with ESMTPSA id x11sm3521703wmc.33.2020.07.28.04.38.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 28 Jul 2020 04:38:05 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: =?utf-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <philmd@redhat.com>,
 <qemu-devel@nongnu.org>
References: <20200728100925.10454-1-philmd@redhat.com>
In-Reply-To: <20200728100925.10454-1-philmd@redhat.com>
Subject: RE: [PATCH-for-5.1] accel/xen: Fix xen_enabled() behavior on
 target-agnostic objects
Date: Tue, 28 Jul 2020 12:37:42 +0100
Message-ID: <000501d664d3$8e72bed0$ab583c70$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQENRsOLIapjYfI4XdI3JVM2u0h2V6qvGVsw
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: paul@xen.org
Cc: 'Peter Maydell' <peter.maydell@linaro.org>,
 'Stefano Stabellini' <sstabellini@kernel.org>,
 'Paul Durrant' <pdurrant@amazon.com>, xen-devel@lists.xenproject.org,
 'Anthony Perard' <anthony.perard@citrix.com>,
 'Paolo Bonzini' <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Sent: 28 July 2020 11:09
> To: qemu-devel@nongnu.org
> Cc: Paul Durrant <paul@xen.org>; Paolo Bonzini <pbonzini@redhat.com>; =
xen-devel@lists.xenproject.org;
> Stefano Stabellini <sstabellini@kernel.org>; Anthony Perard =
<anthony.perard@citrix.com>; Philippe
> Mathieu-Daud=C3=A9 <philmd@redhat.com>; Paul Durrant =
<pdurrant@amazon.com>; Peter Maydell
> <peter.maydell@linaro.org>
> Subject: [PATCH-for-5.1] accel/xen: Fix xen_enabled() behavior on =
target-agnostic objects
>=20
> CONFIG_XEN is generated by configure and stored in "config-target.h",
> which is (obviously) only include for target-specific objects.
> This is a problem for target-agnostic objects as CONFIG_XEN is never
> defined and xen_enabled() is always inlined as 'false'.
>=20
> Fix by following the KVM schema, defining CONFIG_XEN_IS_POSSIBLE
> when we don't know to force the call of the non-inlined function,
> returning the xen_allowed boolean.
>=20
> Fixes: da278d58a092 ("accel: Move Xen accelerator code under =
accel/xen/")
> Reported-by: Paul Durrant <pdurrant@amazon.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Tested-by: Paul Durrant <paul@xen.org>

> ---
>  include/sysemu/xen.h | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
> index 1ca292715e..385a1fa2bf 100644
> --- a/include/sysemu/xen.h
> +++ b/include/sysemu/xen.h
> @@ -8,7 +8,15 @@
>  #ifndef SYSEMU_XEN_H
>  #define SYSEMU_XEN_H
>=20
> -#ifdef CONFIG_XEN
> +#ifdef NEED_CPU_H
> +# ifdef CONFIG_XEN
> +#  define CONFIG_XEN_IS_POSSIBLE
> +# endif
> +#else
> +# define CONFIG_XEN_IS_POSSIBLE
> +#endif
> +
> +#ifdef CONFIG_XEN_IS_POSSIBLE
>=20
>  bool xen_enabled(void);
>=20
> @@ -18,7 +26,7 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t =
size,
>                     struct MemoryRegion *mr, Error **errp);
>  #endif
>=20
> -#else /* !CONFIG_XEN */
> +#else /* !CONFIG_XEN_IS_POSSIBLE */
>=20
>  #define xen_enabled() 0
>  #ifndef CONFIG_USER_ONLY
> @@ -33,6 +41,6 @@ static inline void xen_ram_alloc(ram_addr_t =
ram_addr, ram_addr_t size,
>  }
>  #endif
>=20
> -#endif /* CONFIG_XEN */
> +#endif /* CONFIG_XEN_IS_POSSIBLE */
>=20
>  #endif
> --
> 2.21.3



