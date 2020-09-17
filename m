Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A38C2BBD1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956D9206C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="h1sWkZuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956D9206C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIwyn-0002SV-KH
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kIwqE-0001wl-Tc; Thu, 17 Sep 2020 12:33:02 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:35338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kIwqD-00019M-1m; Thu, 17 Sep 2020 12:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=5i0goaiC1isRgsxJwWXNDDZLK0Oc/YnTnxrxLGHDrjQ=; 
 b=h1sWkZuJNP/SZ6f000BDfCxwywtjQmddyqJvRRSFvvKfLJze2IUbHduI8+bYj+iL7qBW8opegCbB1xZ5wBKzBXPCdvRZ0q7XXb0i4s3fws2hknafRmR3XPahnKEZ4bpv4GzFnitLtfDaHON9oUDZJgKT9NrX7FvexRMUwopxuOhBkxYKiGtLLFmgzoTiaE3Jbnw/cxHTuVhC4zVTy1mSH49fa4m+XhO5s/GfKw20vUDXbCkQZL93yesmhUdOtsdk9a2HHHK1RYfO1QAN6Q3PVd+32BQAegSW/clwgxw4JT/d7cbeQj9BMPWH1ONhESzLGyhiJgnpn7c2Y41GCSJjvg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kIwq9-000656-7M; Thu, 17 Sep 2020 18:32:57 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kIwq8-00017z-UN; Thu, 17 Sep 2020 18:32:56 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 09/14] block/qcow2: qcow2_get_specific_info(): drop error
 propagation
In-Reply-To: <20200909185930.26524-10-vsementsov@virtuozzo.com>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-10-vsementsov@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 17 Sep 2020 18:32:56 +0200
Message-ID: <w51y2l85pon.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 09:56:37
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

On Wed 09 Sep 2020 08:59:25 PM CEST, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> + * On success return true with bm_list set (probably to NULL, if no bitmaps),

" probably " ? :-)

> + * on failure return false with errp set.
>   */
> -Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
> -                                                Error **errp)
> +bool qcow2_get_bitmap_info_list(BlockDriverState *bs,
> +                                Qcow2BitmapInfoList **info_list, Error **errp)
>  {
>      BDRVQcow2State *s = bs->opaque;
>      Qcow2BitmapList *bm_list;
>      Qcow2Bitmap *bm;
> -    Qcow2BitmapInfoList *list = NULL;
> -    Qcow2BitmapInfoList **plist = &list;

So here 'list' points at NULL and 'plist' at &list.

> -        *plist = obj;
> -        plist = &obj->next;

In the original code 'plist' is updated when you add a new element, so
it always points at the end of the list. But 'list' is unchanged and it
still points at the first element.

So the caller receives a pointer to the first element.

> +        *info_list = obj;
> +        info_list = &obj->next;

But in the new code there is only one variable (passed by the caller),
which always points at the end of the list.

Berto

