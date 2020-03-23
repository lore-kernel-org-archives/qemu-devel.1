Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E52C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:46:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EA62076A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdsETX4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EA62076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGLXi-0002z6-5F
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 07:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGLWf-00026R-T0
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGLWe-0004IX-25
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:45:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:25141)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGLWd-0004Hk-UR
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584963946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nMX+mK7SvNwlIf8iLPWPdYlLXCuL15S0k6BsUlXa2kk=;
 b=GdsETX4UfGrZkVLRkRqYTGVde1+YdIbTLJf02FRXjfMW3rZmdAljxxFSDSFxoH/OybFizn
 hTXEW2pmArI+xMsMVJD51e3TAW41OblbvZyWcPahBAGbk0+s/3p32pxObd6MhAhy9V1T1w
 NlFDStTBe/jMiOV2xS04YrE6ARgyZsc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-S7gltq7hPoaHViUQFn_IaQ-1; Mon, 23 Mar 2020 07:45:44 -0400
X-MC-Unique: S7gltq7hPoaHViUQFn_IaQ-1
Received: by mail-ed1-f70.google.com with SMTP id b12so8400045edy.7
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 04:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1QNrV+jZniFlMPTgjmDn2ea5ZytvhuwiE59+RIDklks=;
 b=OIAgud90Ury2VmRm5l6YZP+rQyhWPkj9ZXBfj2wW1jI24mUrfuFZjSpKxvi7ZKo6U0
 zoc0iFhRCQYsQXfcL2vTSMC45XKmGP48BDg4L04Zd49GfmSQFFuIZ09eZRkbkxAGb5Wj
 TffEbCFG+V4iM0F0y+XYmHYdBPRvuJKEz/WL0mAsrHQxKKIbe94NYvj0fFZ6pjr/DzCK
 zv7X2q5ofyAwvJ5HbojwQu1qUZdRezqchor6DJkhk7ukyTKizZB33QMvPtKQcTgIkX8F
 TfhjZn37qvQmlEh4a/1lz7WNRYHg17qpBioJOnzZWEmFqAFGScFvvyFda/z6xL21As+u
 /yyA==
X-Gm-Message-State: ANhLgQ1d4LeplcPHRmu5nPpNsqoL3bJQKpg5I/hajrbyHk0Kz40YmV18
 /cecavJrBoiXuXMQsKBUGmgbr3cL9n7jIcgGr5ItPwqNBwLrKMcWx8LZHbXDBIlcf177vuk9Dli
 sdETQZjUh7jgCHpw=
X-Received: by 2002:a17:906:1ba1:: with SMTP id
 r1mr19754914ejg.297.1584963943281; 
 Mon, 23 Mar 2020 04:45:43 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtThfBizwvpHlMeWCILHmsLnneqefpzeAxa69Db1q1Pm+0ILZ5b/Np3Qnwygpj+SSuzBgfwwg==
X-Received: by 2002:a17:906:1ba1:: with SMTP id
 r1mr19754896ejg.297.1584963942983; 
 Mon, 23 Mar 2020 04:45:42 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id dc25sm700999ejb.59.2020.03.23.04.45.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 04:45:42 -0700 (PDT)
Subject: Re: [PATCH] linux-user, configure: improve syscall_nr.h dependencies
 checking
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200323114116.163609-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e1255aec-44c4-623f-6816-f1a7578ab61d@redhat.com>
Date: Mon, 23 Mar 2020 12:45:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323114116.163609-1-laurent@vivier.eu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 12:41 PM, Laurent Vivier wrote:
> This is mostly a fix for in-tree build.
>=20
> It removes errors on .d directories:
>=20
>    grep: ./.gitlab-ci.d: Is a directory
>    grep: ./scripts/qemu-guest-agent/fsfreeze-hook.d: Is a directory
>=20
> and improves performance by only checking <ARCH>-linux-user directories.
>=20
> Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
> Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   configure | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/configure b/configure
> index 4f12cd01777e..da09c3589572 100755
> --- a/configure
> +++ b/configure
> @@ -1910,9 +1910,9 @@ for arch in alpha hppa m68k xtensa sh4 microblaze a=
rm ppc s390x sparc sparc64 \
>       # remove the file if it has been generated in the source directory
>       rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
>       # remove the dependency files
> -    find . -name "*.d" \
> -           -exec grep -q "${source_path}/linux-user/${arch}/syscall_nr.h=
" {} \; \
> -           -exec rm {} \;
> +    test -d ${arch}-linux-user && find ${arch}-linux-user -type f -name =
"*.d" \
> +         -exec grep -q "${source_path}/linux-user/${arch}/syscall_nr.h" =
{} \; \
> +         -exec rm {} \;
>   done
>  =20
>   if test -z "$python"
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


