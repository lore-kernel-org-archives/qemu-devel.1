Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDF8C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26C732076B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gbTgtP4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C732076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNHDS-0003vE-R9
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 11:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kNH9b-0001Dw-QS; Tue, 29 Sep 2020 11:02:56 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:51296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kNH9Y-0005BP-WE; Tue, 29 Sep 2020 11:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=tQn2+j6CvjanyRo+MaWRASd8g8G9azr4yhSXHzpCucc=; 
 b=gbTgtP4KVIy/GKue7h4yH5jANTGIL6UYLfvWOumbQxWuulSadZ9DJLPVBXxQ6++Ajoi8Ncy3YwqaxA5agbwxgNoMYcETjnBfyI6elbXfzGDGgza7QYrU5tQknL9F62HyGhLXEH4MRg8IrJhyBMe7eJ0XEIyJtQplAB4oXsnLDOoamJkSX5Ht2qRKzWQkFL4A+YxlJpp7My2oU3OnB4T43sh96LsvRTuwitCpPsRxGcmhyAVFjGnTv1seMpNQ7zzJwi3yoA5Kipmll7poQlEz96b+aNue9I9Eo+pQFWuSOe+8okiOp7gbfptd2fDzOoUT10Qn6wQjgcYE3UIsnvRBlw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kNH9V-0006oa-Bh; Tue, 29 Sep 2020 17:02:49 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kNH9V-0006PL-1I; Tue, 29 Sep 2020 17:02:49 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu block <qemu-block@nongnu.org>
Subject: Re: qcow2 merge_cow() question
In-Reply-To: <20684b8e-4f13-794a-f3d2-974ba380277b@virtuozzo.com>
References: <b44aafbf-bd00-3bc0-68c4-5cc01a6b8b01@virtuozzo.com>
 <w51wo1si2jv.fsf@maestria.local.igalia.com>
 <20684b8e-4f13-794a-f3d2-974ba380277b@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 29 Sep 2020 17:02:49 +0200
Message-ID: <w51lfgspqw6.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 11:02:50
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 21 Aug 2020 03:42:29 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>> What are these ifs for?
>>>
>>>             /* The data (middle) region must be immediately after the
>>>              * start region */
>>>             if (l2meta_cow_start(m) + m->cow_start.nb_bytes != offset) {
>>>                 continue;
>>>             }
>>>                                                                                                             
>>>             /* The end region must be immediately after the data (middle)
>>>              * region */
>>>             if (m->offset + m->cow_end.offset != offset + bytes) {
>>>                 continue;
>>>             }
>>>
>>> How is it possible that data doesn't immediately follow start cow
>>> region or end cow region doesn't immediately follow data region?
>> 
>> They are sanity checks. They maybe cannot happen in practice and in
>> that case I suppose they should be replaced with assertions but this
>> should be checked carefully. If I remember correctly I was wary of
>> overlooking a case where this could happen.
>> 
>> In particular, that function receives only one data region but a list
>> of QCowL2Meta objects. I think you can get more than one QCowL2Meta
>> if the same request involves a mix of copied and newly allocated
>> clusters, but that shouldn't be a problem either.
>
> OK, thanks. So, intuitively it shouldn't happen, but there should be
> some careful investigation to change them to assertions.

I was having a look at this and here's a simple example of how this can
happen:

qemu-img create -f qcow2 -o cluster_size=1k img.qcow2 1M
qemu-io -c 'write 0 3k' img.qcow2
qemu-io -c 'discard 0 1k' img.qcow2
qemu-io -c 'discard 2k 1k' img.qcow2
qemu-io -c 'write 512 2k' img.qcow2

The last write request can be performed with one single write operation
but it needs to allocate clusters #0 and #2.

This means that merge_cow() is called with offset=512, bytes=2k and two
QCowL2Meta structures:

  - The first one with cow_start={0, 512} and cow_end={1k, 0} 
  - The second one with cow_start={2k, 0} and cow_end={2560, 512}

In theory it should be possible to combine both into one that has
cow_start={0, 512} and cow_end={2560, 512}, but I don't think this
situation happens very often so I wouldn't go that way.

In any case, the checks have to remain and they cannot be turned into
assertions.

Berto

