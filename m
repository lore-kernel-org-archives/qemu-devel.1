Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AAEC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:47:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 010B92072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evTTetxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010B92072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izRZj-0004zN-7Q
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 15:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1izRZ6-0004TW-Tu
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:46:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1izRZ5-0000Wm-Ia
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:46:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34264
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1izRZ5-0000WQ-8g
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580935586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=OBLzCGD6UfQS4TRCCZODzoBj6cbRoKiDOdTmazOkp6I=;
 b=evTTetxwSg/PC0khcQfMHU/Eg+KYem16RaT4Sw0+UUUCJhlHbzig7BfVSMe7MQsGgCwE4L
 4BQ+/YRjYd0i4ZKkeh76SLK1/yN4iPUqGeWgSDRbf+VZLHw6coXNL8apmCyo5hq3IL/Ucd
 yNMGJc2if8pHdGJE+XZDNpQHyCULMDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-KUXQje5DOxm8GAALCOlgyg-1; Wed, 05 Feb 2020 15:46:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E521410CE782;
 Wed,  5 Feb 2020 20:46:20 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-145.ams2.redhat.com [10.36.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41E3219C69;
 Wed,  5 Feb 2020 20:46:19 +0000 (UTC)
Subject: Re: [PATCH 1/2] qtest: Fix rtas dependencies
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200205204115.555212-1-lvivier@redhat.com>
 <20200205204115.555212-2-lvivier@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2745c304-0918-e51a-7988-c039522b3e14@redhat.com>
Date: Wed, 5 Feb 2020 21:46:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200205204115.555212-2-lvivier@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: KUXQje5DOxm8GAALCOlgyg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/02/2020 21.41, Laurent Vivier wrote:
> qtest "rtas" command is only available with pseries not all ppc64 targets,
> so if I try to compile only powernv machine, the build fails with:
> 
>   /usr/bin/ld: qtest.o: in function `qtest_process_command':
>   .../qtest.c:645: undefined reference to `qtest_rtas_call'
> 
> We fix this by enabling rtas command only with pseries machine.
> 
> Fixes: eeddd59f5962 ("tests: add RTAS command in the protocol")

Well, at that point in time CONFIG_PSERIES was not available yet ... so
not sure if the "Fixes:" really makes sense here...

But apart from that:
Reviewed-by: Thomas Huth <thuth@redhat.com>

> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  qtest.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/qtest.c b/qtest.c
> index 12432f99cf44..587dcbb4b515 100644
> --- a/qtest.c
> +++ b/qtest.c
> @@ -27,7 +27,8 @@
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
>  #include "qemu/cutils.h"
> -#ifdef TARGET_PPC64
> +#include "config-devices.h"
> +#ifdef CONFIG_PSERIES
>  #include "hw/ppc/spapr_rtas.h"
>  #endif
>  
> @@ -628,7 +629,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>  #else
>          qtest_sendf(chr, "OK little\n");
>  #endif
> -#ifdef TARGET_PPC64
> +#ifdef CONFIG_PSERIES
>      } else if (strcmp(words[0], "rtas") == 0) {
>          uint64_t res, args, ret;
>          unsigned long nargs, nret;
> 


