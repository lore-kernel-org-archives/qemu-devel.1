Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2F0C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B87D521744
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ObY6aC8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87D521744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPAmM-0003Vd-MC
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 16:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jPAhz-0006gi-Ko
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jPAhy-00015R-AL
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:01:59 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:46220)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jPAhw-0000t8-38; Thu, 16 Apr 2020 16:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=Rug0Debv6omc6uLIfbFGIMevhTktWTI6Z9XLSY+1rMc=; 
 b=ObY6aC8nag0zZYx2ANiw5Av6NVN8MF4ntAlCs1i34+PSA8qBkUcrKlRA2OJpVRqyiJv1EAdY+PGXr9GTK+FnhWsAhsa0C0bMsDjkJltB1FCpqyN/r7IjKyKHZNEAD0cdg4sAi/GIEmVYHjkAIbwwqoeF9T3pXwNWNeetn9InvLW8J5mOfjSW8Eae6Hd5FGUBELye1LGNKN5yryCIqk0eEnrJUteijMwNMRoqlyf7YbxvcrfTgykpjo3uB4VqC7iXMkWgqkLtm9ymj5FNWL4Eh67hsXm3qu7j8GMmrwqqK+o1C3IUW44PoDfARmCkArkrsNCksF7IjXq/j9sDF/a1SA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jPAha-00018U-W2; Thu, 16 Apr 2020 22:01:35 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jPAha-0006Yv-Mg; Thu, 16 Apr 2020 22:01:34 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 17/30] qcow2: Add subcluster support to
 calculate_l2_meta()
In-Reply-To: <376b9add-b074-0020-61ae-d19d76876fb8@virtuozzo.com>
References: <cover.1584468723.git.berto@igalia.com>
 <6f179204ed9ab6274a9d30b6aa9a63865a16035a.1584468723.git.berto@igalia.com>
 <376b9add-b074-0020-61ae-d19d76876fb8@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 16 Apr 2020 22:01:34 +0200
Message-ID: <w51blnrxkrl.fsf@maestria.local.igalia.com>
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

On Wed 15 Apr 2020 10:39:26 AM CEST, Vladimir Sementsov-Ogievskiy wrote:
>> + * Returns 1 on success, -errno on failure (in order to match the
>> + * return value of handle_copied() and handle_alloc()).
>
> Hmm, honestly, I don't like this idea. handle_copied and handle_alloc
> has special return code semantics. Here no reason for special
> semantics, just classic error/success.

Right, the only reason is to avoid adding something like this after all
callers:

        if (ret == 0) {
            ret = 1;
        }

But you have a point, maybe I change it after all.

>> +        case QCOW2_SUBCLUSTER_NORMAL:
>> +        case QCOW2_SUBCLUSTER_COMPRESSED:
>> +        case QCOW2_SUBCLUSTER_ZERO_ALLOC:
>> +        case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
>> +            cow_end_to = ROUND_UP(cow_end_from, s->cluster_size);
>
> Hmm. Interesting, actually, we don't need to COW
> QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC subclusters in cow-area.. But this
> need more modifications to cow-handling.

True, if there are more unallocated subclusters in the cow area we could
make the copy operation smaller. I'm not sure if it's worth adding extra
code for this, but maybe I can leave a comment.

>> +            break;
>> +        case QCOW2_SUBCLUSTER_ZERO_PLAIN:
>> +        case QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN:
>> +            cow_end_to = ROUND_UP(cow_end_from, s->subcluster_size);
>
>
> This is because in new cluster we can made previous subclusters
> unallocated, and don't copy from backing.
> Hmm, actually, we should not just make them unallocated, but copy part
> of bitmap from original l2-entry.. I need to keep it in mind for next
> patches.

The bitmap is always copied from the original L2 entry, you can see it
in the patch "qcow2: Update L2 bitmap in qcow2_alloc_cluster_link_l2()"

Berto

