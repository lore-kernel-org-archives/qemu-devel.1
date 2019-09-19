Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E5CC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:05:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C42E121907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFpGMpFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42E121907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAuFS-0006Gf-Vl
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 07:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAuDK-0005EZ-1Q
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAuDJ-0007cX-5i
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:03:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30210
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAuDI-0007c9-P9
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1568890983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=99g3hLnAk0d5Ikj5XS9R91cbufIy1oLhGJR0Fszckoo=;
 b=RFpGMpFY6HObj/JripzvpVjrVcRTP4fVlFJ7XXR0dhMgrKODSpA7NJtxUBHoXoU71jFU/C
 /94+5WBNjLEvfJ4Pm4oFnlAO4W3cMQhRxZlPvQKkJuu3RTOVeFngPLeIZvmbgvxzWROxFl
 ZLlle1pzP8k0/Wr+MCX2w3mGb4a0xBc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-pNXaZqfbNEKQUkHHboStLg-1; Thu, 19 Sep 2019 07:02:59 -0400
Received: by mail-wm1-f70.google.com with SMTP id l3so1557132wmf.8
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 04:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o8V8PDjgyLEZg73yT/dfos+m3pqZM721NH0eN1Ms3Dw=;
 b=RCyFIlejdjLpErA2XvKXnpg2auu4NqrKBddGCZRLbE7rg7+X8ULH8a0AOSxZ169b+u
 jRi1MZO7MtJ7wC4v0Rr2g2O7k0T49IxcQ8OPvQ69D4dIVZXqYr65fD8dv02nqAtX0ofv
 cmdXQluxPGGQRuGsyrKODHMTvTEBn30WXJAWUm0gYn0AS2+91fl748veMcV5JRKVmVqQ
 nSjdCTHuoxneUXWvCzt3cIh+HgO1RC7zMmtVMSqPuNRyRup5KvGr9BMnrUVXL7NZXhsw
 N6l7JmSpeM/PxpkPOq23ckcXU/oN2axcZFkZnonp0jtZJxjUxVp7rTWwUAL/8vJi87Ek
 5+Vw==
X-Gm-Message-State: APjAAAVORztxye81KfbWJGMXTEVKKxPKl3XFanuXHZQwSH+DWjHBu0Mg
 hH/WXB2b9U/cru/jkQyRRH+pRJCIf8WPwyy6RrN9PHWJyTjCdq+AFbqdxDtHz/gaZy7Nqx1yHNf
 nfW7etujEI3zjNBQ=
X-Received: by 2002:a1c:9ec9:: with SMTP id h192mr2406333wme.105.1568890977877; 
 Thu, 19 Sep 2019 04:02:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxkn1/zTrvAY7vR8XbdJzuVlfjgUu08wM22iQ44HMMFh4bv+cmB1LefwS/2Hswv4fJ1MdKAFA==
X-Received: by 2002:a1c:9ec9:: with SMTP id h192mr2406321wme.105.1568890977737; 
 Thu, 19 Sep 2019 04:02:57 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id d22sm3940484wmb.44.2019.09.19.04.02.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 04:02:57 -0700 (PDT)
To: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20190919105932.19412-1-philmd@redhat.com>
 <20190919105932.19412-3-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d89a1e52-af32-dce8-4b95-288520472783@redhat.com>
Date: Thu, 19 Sep 2019 13:02:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190919105932.19412-3-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: pNXaZqfbNEKQUkHHboStLg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
Subject: Re: [Qemu-devel] [PATCH 2/2] .shippable.yml: Build WHPX enabled
 binaries
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
Cc: Fam Zheng <fam@euphon.net>, Stefan Weil <sw@weilnetz.de>,
 Lucian Petrut <lpetrut@cloudbasesolutions.com>,
 Ilias Maratos <i.maratos@gmail.com>, Justin Terry <juterry@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/19 12:59 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  .shippable.yml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/.shippable.yml b/.shippable.yml
> index bbc6f88510..01b33bd034 100644
> --- a/.shippable.yml
> +++ b/.shippable.yml
> @@ -25,6 +25,8 @@ env:
>        TARGET_LIST=3Dmips64el-softmmu,mips64el-linux-user
>      - IMAGE=3Ddebian-ppc64el-cross
>        TARGET_LIST=3Dppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
> +    - IMAGE=3Dfedora-win10sdk-cross
> +      TARGET_LIST=3Dx86_64-softmmu,i386-softmmu

Note for Alex, if this patch is accepted, I think we can remove
x86_64-softmmu from TARGET_LIST in the debian-win64-cross job, since
this one duplicates it (and even covers more).

>  build:
>    pre_ci:
>      # usually host ARCH is set by configure
>=20


