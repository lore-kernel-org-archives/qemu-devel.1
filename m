Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D76C43215
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88AB520836
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YwCDi5OS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88AB520836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZFxv-00023E-HQ
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 10:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iZFwv-0000ve-Vk
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:06:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iZFwv-0004rj-1K
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:06:49 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:59231)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iZFwm-0004fX-P4; Mon, 25 Nov 2019 10:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=/9gu02rifEO+MVaVl8KSkcNB03HCWmZd9FBt1FBlsD4=; 
 b=YwCDi5OS4Fy7KKuouazeXF5EoYi8xKpQOlO0jMV8RT5kItDSvKNhHswULnBWND/nuprCbCqZvtMGan86LZrOGJKk3afZ5btZvIq+pccbfrAlibS44Wqv7seLLQHllFyRw0cLWf7/pN14RxhnC+O0EvI0j+rgZ/GMzTHrWdx3K1fNuyTrhhKPFypPFRHDd2z/efMQOmBW90aDCUHCuu2NDF5UrMrXmg9YkV6JexT+wI3loUH8x7kyZkh6FhltcMvyheXins9XyEA+C1M8XW5AuDGJOgRa5vrUs5L1Z5nVP3RUJAe3zDKPAhOgP8z63YjQxKBV/5XUfdaQiJMuUvASbg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iZFwj-00075A-2Y; Mon, 25 Nov 2019 16:06:37 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1iZFwi-0004aQ-Ve; Mon, 25 Nov 2019 16:06:36 +0100
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v3 2/8] block: Add no_fallback parameter to
 bdrv_co_truncate()
In-Reply-To: <20191122160511.8377-3-kwolf@redhat.com>
References: <20191122160511.8377-1-kwolf@redhat.com>
 <20191122160511.8377-3-kwolf@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 25 Nov 2019 16:06:36 +0100
Message-ID: <w515zj8hu6b.fsf@maestria.local.igalia.com>
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 22 Nov 2019 05:05:05 PM CET, Kevin Wolf wrote:

> @@ -3405,6 +3412,7 @@ typedef struct TruncateCo {
>      int64_t offset;
>      bool exact;
>      PreallocMode prealloc;
> +    bool no_fallback;
>      Error **errp;
>      int ret;
>  } TruncateCo;

You add the 'no_fallback' field here...

>  int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
> -                  PreallocMode prealloc, Error **errp)
> +                  PreallocMode prealloc, bool no_fallback, Error **errp)
>  {
>      Coroutine *co;
>      TruncateCo tco = {

...but then you don't use it when the structure is initialized.

Berto

