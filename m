Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0D0C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E13206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7JGC4U5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E13206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1PZy-00012Y-J7
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 02:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1PYj-0000Gn-Uc
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1PYh-00058N-Op
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:02:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48742
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1PYh-00057r-LL
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581404531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/fGu+rVGQEgLbDd2sBJCU6XCrAt5V+OPAWwNq0lQOA=;
 b=P7JGC4U51m4Ub+68iPeWsznSSIfOis+UYqijFKqWjkzgf86xmWeokvy+E5HNlNxJDdZQzD
 BDaKnU484sq0K82bEij/gjy3KDhMEZ6ZaPjIteOVP26JczrQX7Up0ZB5Jgwr5Y8+oLPrB8
 UNrIzeEOj8sCjNPGPlarBPRelGi/Ao0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-RLp5uO_XP7SDXWhVUWUVuA-1; Tue, 11 Feb 2020 02:02:06 -0500
Received: by mail-wr1-f71.google.com with SMTP id a12so6408139wrn.19
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 23:02:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a/fGu+rVGQEgLbDd2sBJCU6XCrAt5V+OPAWwNq0lQOA=;
 b=mJ3Kx4siwxgezYbhqip9uuth1QqJ3XewN8lAnezwhjd/6eFpVYC78y7jsPoV78UI0d
 Ux2I9OTf4mPcOWLdikNWP9/FrACtxnjc2nN+ZQGKlTQSi8kknbTuDCoM1BShMvIY3C01
 4kKdbHLOWaUygCTKs7GxArs3sthxma+w91KsOgSPu0Sq6nWhW1DI3lb66698Ue+MI7MX
 OCTrO13JODWsAqB1nAz6ffgZIJg5TujB3SCZfpwBWhSeFQFCPBNBFUqIpDr0pJC+GGlq
 PykC42QCPz7S2d7kWLKBxE10uhy850eEPBQpVEGRi2EaCASYLqgLNQfD+tDen6Imvo9v
 iaSQ==
X-Gm-Message-State: APjAAAUm/kymBZIS9ECfckMdCEf+Co31M15HTOl7iuhfHdcwlN/mPUTN
 wSALtiGLYiwqsClUv684RmbMfQsHC5rXkWcE2JSKgQpXThvoSWhoVYlRImsErKGiHYJwoUQtoVN
 FZj+G0cvCpvKWHII=
X-Received: by 2002:a1c:2282:: with SMTP id i124mr3592874wmi.109.1581404525270; 
 Mon, 10 Feb 2020 23:02:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqzCglemMruW9yz9EgQKYJNDV8vyqDxLp6A2zil5TFvst5lB4A2CPWxYGb2k0pairA14qz6//Q==
X-Received: by 2002:a1c:2282:: with SMTP id i124mr3592828wmi.109.1581404524869; 
 Mon, 10 Feb 2020 23:02:04 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id s65sm2486298wmf.48.2020.02.10.23.02.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 23:02:04 -0800 (PST)
Subject: Re: [RFC PATCH 55/66] Hexagon HVX import instruction encodings
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
 <1581381644-13678-56-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fd38e134-8314-f206-9a04-0e41119105f6@redhat.com>
Date: Tue, 11 Feb 2020 08:02:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581381644-13678-56-git-send-email-tsimpson@quicinc.com>
Content-Language: en-US
X-MC-Unique: RLp5uO_XP7SDXWhVUWUVuA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Taylor,

On 2/11/20 1:40 AM, Taylor Simpson wrote:
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>   target/hexagon/imported/allextenc.def        |  20 +
>   target/hexagon/imported/encode.def           |   1 +
>   target/hexagon/imported/mmvec/encode_ext.def | 830 +++++++++++++++++++++++++++
>   3 files changed, 851 insertions(+)
>   create mode 100644 target/hexagon/imported/allextenc.def
>   create mode 100644 target/hexagon/imported/mmvec/encode_ext.def
> 
> diff --git a/target/hexagon/imported/allextenc.def b/target/hexagon/imported/allextenc.def
> new file mode 100644
> index 0000000..c194cc8
> --- /dev/null
> +++ b/target/hexagon/imported/allextenc.def
> @@ -0,0 +1,20 @@
> +/*
> + *  Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#define EXTNAME mmvec
> +#include "mmvec/encode_ext.def"
> +#undef EXTNAME
> diff --git a/target/hexagon/imported/encode.def b/target/hexagon/imported/encode.def
> index 33c3396..d1b3510 100644
> --- a/target/hexagon/imported/encode.def
> +++ b/target/hexagon/imported/encode.def
> @@ -71,6 +71,7 @@
>   
>   #include "encode_pp.def"
>   #include "encode_subinsn.def"
> +#include "allextenc.def"
>   
>   #ifdef __SELF_DEF_FIELD32
>   #undef __SELF_DEF_FIELD32

I had a problem applying this one:

Applying: Hexagon HVX import instruction encodings
error: target/hexagon/imported/encode.def: does not exist in index
Patch failed at 0054 Hexagon HVX import instruction encodings
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Resolved by doing:

(review/hexagon|AM 54/65)$ touch target/hexagon/imported/encode.def
(review/hexagon|AM 54/65)$ git add target/hexagon/imported/encode.def
(review/hexagon|AM 54/65)$ git am --continue
Applying: Hexagon HVX import instruction encodings
Applying: Hexagon HVX import semantics
...


