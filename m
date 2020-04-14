Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF59C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 799452075E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="J7c2uv9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799452075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOKZe-0005Iu-NK
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 08:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jOKYl-0004oh-Bt
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jOKYk-0002V4-7k
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:20:59 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:44690)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jOKYj-0002TW-LV; Tue, 14 Apr 2020 08:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=7YZZX1Klg2DDgKOL1XRre7jsECwUz/wwPBkxLXt5PR0=; 
 b=J7c2uv9z/wuGm/Pj8q8JCIXD8nW+zQLjDw0BKxrnKFPVBa4rL+84p/DcaU7scaKx7EuS0AkLmQtQValL32fhc1d5Klg7y4kK51D2SCte7hIeVK3atqIZkz0uLc+Zgjh0/BLAUqGAFlj0THlMlCn7oMlOf+awmv35kIybcXmDtin1QlQnQXQEWOfbIxY2P7JUm3bfFJMi0ku39FYqWo6kAcT5cuqkiwHf+Spi+ptQr/NUj3PKaVh8HOB4dXB0INoChuqF8NNCyE2f0wtlH7offigBvK1ua0NPNlMDjIHfZkUoacbi9ZKNeoGv2Qlvg7WIeHpJdrEWyXvZgSChZtuTiA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jOKYf-0003Eh-Fe; Tue, 14 Apr 2020 14:20:53 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jOKYf-0002B9-6D; Tue, 14 Apr 2020 14:20:53 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 11/30] qcow2: Add l2_entry_size()
In-Reply-To: <58d1fa17-91ea-9f8d-c39a-4141783d1234@virtuozzo.com>
References: <cover.1584468723.git.berto@igalia.com>
 <fd0f93353a218ff4518f34ebdbca05c2fc0f1085.1584468723.git.berto@igalia.com>
 <58d1fa17-91ea-9f8d-c39a-4141783d1234@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 14 Apr 2020 14:20:53 +0200
Message-ID: <w51y2qy5kd6.fsf@maestria.local.igalia.com>
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 14 Apr 2020 11:44:57 AM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>       /* allocate a new l2 entry */
>>   
>> -    l2_offset = qcow2_alloc_clusters(bs, s->l2_size * sizeof(uint64_t));
>> +    l2_offset = qcow2_alloc_clusters(bs, s->l2_size * l2_entry_size(s));
>
> hmm. s->l2_size * l2_entry_size, isn't it just s->cluster_size always?
> Maybe, just refactor these things?

I think the patch is simpler to follow if I only do the strictly
necessary changes and don't mix them with other things.

>>           nb_new_l2_tables = DIV_ROUND_UP(nb_new_data_clusters,
>> -                                        s->cluster_size / sizeof(uint64_t));
>> +                                        s->cluster_size / l2_entry_size(s));
>
> Isn't it just s->l2_size ?

Yes, same as before.

>>           /* The cluster range may not be aligned to L2 boundaries, so add one L2
>>            * table for a potential head/tail */
>>           nb_new_l2_tables++;
>
> Conversions looks correct, but how to check that we have converted
> everything?

I went through all cases, I think I didn't miss any!

> I found this not converted chunk:
>
>      /* total size of L2 tables */
>      nl2e = aligned_total_size / cluster_size;
>      nl2e = ROUND_UP(nl2e, cluster_size / sizeof(uint64_t));
>      meta_size += nl2e * sizeof(uint64_t);

This is used by qcow2_measure() and is fixed on a later patch because,
unlike all other cases, it does not use a BlockDriverState to determine
the size of an L2 entry.

> Hmm. How to avoid it? Maybe, at least, refactor the code, to drop all
> sizeof(uint64_t), converting them to L2_ENTRY_SIZE, L1_ENTRY_SIZE,
> REFTABLE_ENTRY_SIZE etc?

That wouldn't be a bad thing I guess but, again, for a separate patch or
series.

> And all occurrences of pure '8' (not many of them exist)

I think most/all nowadays only refer to the number of bits per byte.

Maybe there's a couple that still need to be fixed, but we have been
removing a lot of numeric literals from the qcow2 code (see for example
b6c246942b, 3afea40243 or a35f87f50d).

Berto

