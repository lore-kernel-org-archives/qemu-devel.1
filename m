Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F13FC55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:55:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC0722077D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="aCElod/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0722077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48759 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRDyF-0004b8-18
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 07:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jRDxT-0003vt-B6
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jRDxS-0001AG-5V
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:54:26 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:38776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jRDxR-0007mn-Al; Wed, 22 Apr 2020 07:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=dLu9ZHC3ANpBJoZmDDIScyPF2eb/jOtt5D8LCYbKACc=; 
 b=aCElod/23o1eNy8Kqh2fsOnTdPzT9R3bRESE+0sHbGxqGONTmJkssr5OoE+gU8tvtxMmf0ed9xK6MqYgeaZbXEFfdd1ULLIgCuzWCdt3jDm18wVIRglU/ZS+nByjJCICSGKWX7kPm9IMKUHUImkkL0nEim8qbEq1FG9ZfIJHRORVhpkab9u5SSiPnsseiBobybM29ymP6HKo28O+oQQ0b+z4ZSZvP+UNFcGzxT9tnipk8t6rR00ZHNQb2FO5Gm+eFi26v5nZh+KCOrhLBRt+RfETdWVeBR7UqTLUwpbei0In8gwWwvd70qwCB+4a0QrXRr+psaDvweYGMCyAI8iReQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jRDx4-0004Sp-Qc; Wed, 22 Apr 2020 13:54:02 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jRDx4-0002w5-HA; Wed, 22 Apr 2020 13:54:02 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 18/30] qcow2: Add subcluster support to
 qcow2_get_host_offset()
In-Reply-To: <b3f2ddad-2053-0839-ae97-3d886790a131@virtuozzo.com>
References: <cover.1584468723.git.berto@igalia.com>
 <1cc780f735044ac9138808234589d2c278c9cfbf.1584468723.git.berto@igalia.com>
 <b3f2ddad-2053-0839-ae97-3d886790a131@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 22 Apr 2020 13:54:02 +0200
Message-ID: <w51tv1bsplx.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 07:54:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
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

On Wed 22 Apr 2020 10:07:30 AM CEST, Vladimir Sementsov-Ogievskiy wrote:
>> +static int count_contiguous_subclusters(BlockDriverState *bs, int nb_clusters,
>> +                                        unsigned sc_index, uint64_t *l2_slice,
>> +                                        int l2_index)
>>   {
>>       BDRVQcow2State *s = bs->opaque;
>
> preexist, but, worth asserting that nb_clusters are all in this
> l2_slice?

Ok.

>> +        for (j = (i == 0) ? sc_index : 0; j < s->subclusters_per_cluster; j++) {
>> +            if (qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, j) != type) {
>> +                goto out;
>
> why not just return count from here? And then you don't need goto at
> all. Hmm, may be out: code will be extended in further patches..

It's not extended in further patches. I generally prefer having a single
exit point but you're right that it probably doesn't make sense here.

>>           /* Compressed clusters can only be processed one by one */
>> -        c = 1;
>> +        sc = s->subclusters_per_cluster - sc_index;
>
> should not we assert here that sc_index == 0? Otherwise the caller
> definitely doing something wrong.

No, no, the guest offset doesn't need to be cluster aligned so sc_index
can perfectly be != 0.

>> +    case QCOW2_SUBCLUSTER_ZERO_ALLOC:
>> +    case QCOW2_SUBCLUSTER_NORMAL:
>> +    case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
>> +        sc = count_contiguous_subclusters(bs, nb_clusters, sc_index,
>> +                                          l2_slice, l2_index);
>>           *host_offset = l2_entry & L2E_OFFSET_MASK;
>>           if (offset_into_cluster(s, *host_offset)) {
>
> Hmm, you may move "sc = count_contiguous_subclusters" to be after the
> switch-block, as it is universal now. And keep only offset calculation
> and error checking in the switch-block.

That's actually a good idea, thanks !! (plus we actually get to use the
QCOW2_SUBCLUSTER_COMPRESSED check in count_contiguous_subclusters(),
which is currently dead code).

Berto

