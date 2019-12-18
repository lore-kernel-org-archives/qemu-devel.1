Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798A7C2D0C3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:12:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46FC2218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WT0D+obG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FC2218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihURK-0003FV-FV
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:12:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ihUQd-0002oP-A4
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:11:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ihUQb-0008Uv-BR
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:11:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48428
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ihUQb-0008R8-7F
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:11:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576656687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=tVhKJEuSPLOXhaKPiHrpLwAD8wgUZoTebgN9SwCdQW8=;
 b=WT0D+obGb/flw8+AO2WxBwtwFf6Wbv9E7zq37IbN6DF2g2sHE7pW29OveZZ5Heh27xNiI6
 r3lReK5FAcw+9mrGCL95OK101XnIihJOhjnOSiT1u67ZlgsBbkjm43G2m5TbmjANHLhXTP
 bpSoPGDGAXRpcbV20h7FmCmfc2tObU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-tivi4ZyKOWiRwLVpABYDjg-1; Wed, 18 Dec 2019 03:11:26 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 141D61800D42;
 Wed, 18 Dec 2019 08:11:25 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-150.ams2.redhat.com [10.36.116.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB05C60C18;
 Wed, 18 Dec 2019 08:11:20 +0000 (UTC)
Subject: Re: [PATCH 5/7] configure: Unnest detection of -z,relro and -z,now
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191218031920.6414-1-richard.henderson@linaro.org>
 <20191218031920.6414-6-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <881dff30-a729-6d7b-f823-5f136125ac0b@redhat.com>
Date: Wed, 18 Dec 2019 09:11:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191218031920.6414-6-richard.henderson@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: tivi4ZyKOWiRwLVpABYDjg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: berrange@redhat.com, i@maskray.me, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/12/2019 04.19, Richard Henderson wrote:
> There is nothing about these options that is related to PIE.
> Nor is there anything that specifically ties them to each other.
> Use them unconditionally.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  configure | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index 972ce7396f..f8981eec15 100755
> --- a/configure
> +++ b/configure
> @@ -2034,9 +2034,6 @@ if test "$pie" != "no" ; then
>      QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
>      LDFLAGS="-pie $LDFLAGS"
>      pie="yes"
> -    if compile_prog "" "-Wl,-z,relro -Wl,-z,now" ; then
> -      LDFLAGS="-Wl,-z,relro -Wl,-z,now $LDFLAGS"
> -    fi
>    else
>      if test "$pie" = "yes"; then
>        error_exit "PIE not available due to missing toolchain support"
> @@ -2047,6 +2044,16 @@ if test "$pie" != "no" ; then
>    fi
>  fi
>  
> +# Detect support for DT_BIND_NOW.
> +if compile_prog "" "-Wl,-z,now" ; then
> +  LDFLAGS="-Wl,-z,now $LDFLAGS"
> +fi
> +
> +# Detect support for PT_GNU_RELRO.
> +if compile_prog "" "-Wl,-z,relro" ; then
> +  LDFLAGS="-Wl,-z,relro $LDFLAGS"
> +fi

Looking at
https://mudongliang.github.io/2016/07/11/relro-a-not-so-well-known-memory-corruption-mitigation-technique.html
the idea of specifying these two options together was likely to get
"Full RELRO" instead of only "Partial RELRO".
Thus, does it make sense to have "-Wl,-z,now" without "-Wl,-z,relro" in
QEMU? Or should this rather check whether both are possible, then use
both, otherwise just try to use "relro" alone?

 Thomas


