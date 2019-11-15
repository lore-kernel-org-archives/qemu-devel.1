Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A097AC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 13:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E5A520728
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 13:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TJjW20F0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5A520728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVbll-00018Y-KS
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 08:36:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iVbkt-0000Th-OZ
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:35:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iVbks-0001Qc-MA
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:35:19 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:39100)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iVbks-0001M0-2M; Fri, 15 Nov 2019 08:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=mAL+8qnlbnBLnL8WO6okoigrlqrRCe/hml51AA7367Y=; 
 b=TJjW20F0qm43mtPuQLlsjst9gdG85wqzmi+ovNENXKRRVGeGqRUFgSkG27aLew4KxPHzy5f/OWljuAlVQIMRifQ154cabcBymLlN+vJRq6FUFQqCDKoLQrbvKGFKKUEPL/Gi7nOo7ZGifdzlldD+UZTfjWr1diwr6Z3pWb/HFzjx9LMMWn+k8hujjD9VfYVZDxTHJI+qr7u7smXP7cEV8hr8L1wRzFdS5Avg+uxMUB3WHbYPr8LzptWseH4rSK1brax5ZUbjdYHu12OybIJTjB4z6Pclm3viQG7zAkYgcQrMtmGLpY2ZSS2Aq4wpMDvlh4VAIRMo0vHIeWLKS5mEgg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iVbkl-0005kG-CU; Fri, 15 Nov 2019 14:35:11 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1iVbkl-000657-A9; Fri, 15 Nov 2019 14:35:11 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2 24/26] qcow2: Add the 'extended_l2' option and the
 QCOW2_INCOMPAT_EXTL2 bit
In-Reply-To: <482bff8c-e1fe-6a91-8cd4-a5f571dc4095@redhat.com>
References: <cover.1572125022.git.berto@igalia.com>
 <e8694aa3a45aefa943c9ccbccc8ec5f1460553d0.1572125022.git.berto@igalia.com>
 <482bff8c-e1fe-6a91-8cd4-a5f571dc4095@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 15 Nov 2019 14:35:11 +0100
Message-ID: <w5136epz2i8.fsf@maestria.local.igalia.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 05 Nov 2019 01:47:58 PM CET, Max Reitz wrote:
>> @@ -1347,6 +1347,12 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>>      s->subcluster_size = s->cluster_size / s->subclusters_per_cluster;
>>      s->subcluster_bits = ctz32(s->subcluster_size);
>>  
>> +    if (s->subcluster_size < (1 << MIN_CLUSTER_BITS)) {
>> +        error_setg(errp, "Unsupported subcluster size: %d", s->subcluster_size);
>> +        ret = -EINVAL;
>> +        goto fail;
>> +    }
>> +
>>      /* Check support for various header values */
>>      if (header.refcount_order > 6) {
>>          error_setg(errp, "Reference count entry width too large; may not "
>
> It feels like this hunk should be part of the patch that added the
> s->subcluster_size assignment.

I don't have a strong opinion, but that patch simply defines the basic
attributes that are used elsewhere in the code, and this is the patch
where the values are checked (for creation and opening).

Berto

