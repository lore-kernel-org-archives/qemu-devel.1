Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CB8C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C83621D7B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PWGpTamj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C83621D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIx4b-00081y-40
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kIwt3-0005XM-S6; Thu, 17 Sep 2020 12:35:57 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:38479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kIwt1-0001in-LR; Thu, 17 Sep 2020 12:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=KDfVmD+m1iowetri9H3hR17m3iE/aqU1NeaEMw54oQQ=; 
 b=PWGpTamjRjwvfvgCvtm9p2TMbqEEbOxLk1QNAH9+v84LX/yacWcMjXcL15EjE3zoUN0ivKHWV4T3bi8dqe+DutZmrzepXgZcC8D6v9SpdUv3SVul9I1PDPzCY+rIxI5J5z2P024GDUwdfn7x4r932Ry74rAPeIjOQAZNUJSnmfN+JxLminJwu9Idmo/oLkbVn5iD4eim+7+wgqVsjqhyW8xF+d/UVqw+T22vsSUcSPb00STV9RgVZHkaKWCmycEjpYJAnD34/o8329SE+kODAjx5XmCG0HbG0ozMvD+ufwemD+xkyV3WmOvqClN3KpO4FFxEBudmfMEWHRtPeGWncw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kIwsz-0006TO-MP; Thu, 17 Sep 2020 18:35:53 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kIwsz-0001LK-Cq; Thu, 17 Sep 2020 18:35:53 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 10/14] block/qcow2-bitmap: improve
 qcow2_load_dirty_bitmaps() interface
In-Reply-To: <20200909185930.26524-11-vsementsov@virtuozzo.com>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-11-vsementsov@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 17 Sep 2020 18:35:53 +0200
Message-ID: <w51v9gc5pjq.fsf@maestria.local.igalia.com>
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

On Wed 09 Sep 2020 08:59:26 PM CEST, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> -/* qcow2_load_dirty_bitmaps()
> - * Return value is a hint for caller: true means that the Qcow2 header was
> - * updated. (false doesn't mean that the header should be updated by the
> - * caller, it just means that updating was not needed or the image cannot be
> - * written to).
> - * On failure the function returns false.
> - */
> -bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
> +/* Return true on success, false on failure. */
> +bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, bool *header_updated,
> +                              Error **errp)

I think that the documentation should clarify under what conditions
'header_updated' is modified.

>      if (s->nb_bitmaps == 0) {
>          /* No bitmaps - nothing to do */
> -        return false;
> +        return true;
>      }

Here is it not for example (should it be set to false?).

> -    if (bm_list == NULL) {
> +    if (!bm_list) {
>          return false;
>      }

This looks like a cosmetic change unrelated to the rest of the patch.

Berto

