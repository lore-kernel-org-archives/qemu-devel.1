Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B12C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B635320874
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EZkQ8JnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B635320874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJHyV-0006Y2-Po
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kJHw4-0004d0-RH; Fri, 18 Sep 2020 11:04:29 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:37617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kJHw1-0008K0-5j; Fri, 18 Sep 2020 11:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=IsimdFgV26HkbW33CL0zF1P8llAr22nvOmxjJvDFWDg=; 
 b=EZkQ8JnPTGCKUBGONQZX9L8jhpqzhqggJHEx4QyRkPdgNfe2ZpAVUYZLZBBfqkuk69Bz4wbiJNtASqxHXKHrgUwQSV2N6r8li+3Q/cS0S1qveHz7YZJRCMifeRxruLRN/p9EB1B1E7WAzuPHrkdwLD+eqLDTlZfGTGSAy67zyT8qmx8yGqwARzhFunsHfsOJoXlDbiCkyvVL192TmWjcU9vU0LxJlHNXoV5hQqIfxfDdYIsNRwQQ4qAZAgvJYT4FG/zaR48WV8+36fs4pxL7QWhbpTaWSwJsjJ0YEWYtrWwxeNduaf07fG067BOW9jQVIZmDpqT09i9+YSJJC0VnnQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kJHvw-0007wk-PY; Fri, 18 Sep 2020 17:04:20 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kJHvw-0003po-FI; Fri, 18 Sep 2020 17:04:20 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 08/13] block/qcow2: qcow2_get_specific_info(): drop
 error propagation
In-Reply-To: <20200917195519.19589-9-vsementsov@virtuozzo.com>
References: <20200917195519.19589-1-vsementsov@virtuozzo.com>
 <20200917195519.19589-9-vsementsov@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 18 Sep 2020 17:04:20 +0200
Message-ID: <w51sgbf2kjv.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 10:54:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, pavel.dovgaluk@ispras.ru,
 qemu-devel@nongnu.org, armbru@redhat.com, groug@kaod.org, stefanha@redhat.com,
 pbonzini@redhat.com, mreitz@redhat.com, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 17 Sep 2020 09:55:14 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
> Don't use error propagation in qcow2_get_specific_info(). For this
> refactor qcow2_get_bitmap_info_list, its current interface is rather
> weird.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>

> - * In case of no bitmaps, the function returns NULL and
> - * the @errp parameter is not set.
> - * When bitmap information can not be obtained, the function returns
> - * NULL and the @errp parameter is set.
> + * On success return true with bm_list set (probably to NULL, if no bitmaps),
> + * on failure return false with errp set.

I still find the 'probably' thing odd :-) I think the API documentation
should describe what the function does and under which conditions, not
the probability of the outcomes.

>      QSIMPLEQ_FOREACH(bm, bm_list, entry) {
>          Qcow2BitmapInfo *info = g_new0(Qcow2BitmapInfo, 1);
>          Qcow2BitmapInfoList *obj = g_new0(Qcow2BitmapInfoList, 1);
> @@ -1124,13 +1123,13 @@ Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
>          info->name = g_strdup(bm->name);
>          info->flags = get_bitmap_info_flags(bm->flags & ~BME_RESERVED_FLAGS);
>          obj->value = info;
> -        *plist = obj;
> -        plist = &obj->next;
> +        *info_list = obj;
> +        info_list = &obj->next;
>      }

You were right with this, I got confused by the fact that you are
modifying the pointer provided by the user.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

