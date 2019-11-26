Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780E5C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38DC32071E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PgnHgIK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DC32071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZYBI-0003La-RA
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 05:34:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iZXsY-0005f2-Rf
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:15:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iZXdm-0006rW-6q
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:00:15 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:53564)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iZXdh-0006kY-3U; Tue, 26 Nov 2019 05:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=hQzd4Zr7DasblLM3AfeX3zMqBJYp3U7KeN5i6Zef89o=; 
 b=PgnHgIK4YY/aSk/8FVs0Pr0w3nnhDLbqXdbZmtE5Z6gVm55yrghKVKWfGTPs7rlO9hoDl/y4jJKCBy3Q2tDZGIXUubnGc/SOYMHsVvcblUnAGEwdn6MXCjZBs7NYHlz1SIfIZgTN9xOZioEQXR5FBZhjvimjwLNNJEddLkZKHIdd6W/EiMJfcDR8BcfyPPjpLWUYaFl0xBZJaLPeeW54jWKP8f6XBP35fei2jnpGD9k18OaEkLmG3tFkctRC6jdSKZI70mKNmCXzFWR5D5BGVtYqJ25RSkFehAIXX9hYpQWGEhdpPfoyoSpIHM0BpHJS3jNLYKoE1twGxHBcAoTGVw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iZXdV-00050z-AQ; Tue, 26 Nov 2019 10:59:57 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1iZXdV-0003pK-7Y; Tue, 26 Nov 2019 10:59:57 +0100
From: Alberto Garcia <berto@igalia.com>
To: pannengyuan@huawei.com, kwolf@redhat.com, mreitz@redhat.com
Subject: Re: [PATCH] throttle-groups: fix memory leak in
 throttle_group_set_limits
In-Reply-To: <1574756222-43976-1-git-send-email-pannengyuan@huawei.com>
References: <1574756222-43976-1-git-send-email-pannengyuan@huawei.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 26 Nov 2019 10:59:57 +0100
Message-ID: <w51o8wz555u.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: liyiting@huawei.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 PanNengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org,
 kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 26 Nov 2019 09:17:02 AM CET, pannengyuan@huawei.com wrote:
> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c
> @@ -912,6 +912,7 @@ static void throttle_group_set_limits(Object *obj, Visitor *v,
>  unlock:
>      qemu_mutex_unlock(&tg->lock);
>  ret:
> +    qapi_free_ThrottleLimits(argp);
>      error_propagate(errp, local_err);
>      return;

Thanks, but I also think that 'arg' is not used so it can be removed?

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 77014c741b..37695b0cd7 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -893,8 +893,7 @@ static void throttle_group_set_limits(Object *obj, Visitor *v,
 {
     ThrottleGroup *tg = THROTTLE_GROUP(obj);
     ThrottleConfig cfg;
-    ThrottleLimits arg = { 0 };
-    ThrottleLimits *argp = &arg;
+    ThrottleLimits *argp;
     Error *local_err = NULL;
 
     visit_type_ThrottleLimits(v, name, &argp, &local_err);
@@ -912,6 +911,7 @@ static void throttle_group_set_limits(Object *obj, Visitor *v,
 unlock:
     qemu_mutex_unlock(&tg->lock);
 ret:
+    qapi_free_ThrottleLimits(argp);
     error_propagate(errp, local_err);
     return;
 }

Berto

