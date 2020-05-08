Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C297C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F9D3208DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZjBg/mQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9D3208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX1SW-0005Zx-Fs
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 07:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jX1R0-00044v-GS; Fri, 08 May 2020 07:44:54 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:43604)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jX1Qy-00083t-MC; Fri, 08 May 2020 07:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=f2k3CoJ7c9Fa+epKJZzqwwWFio7++7SFTro/IdOcniQ=; 
 b=ZjBg/mQn7BJ3TBLqp6c+Hzo5vvKiREggwFNC2cwSy6d68vOuHV6zBOt/zhnyZKPOTM2cIVk7nlAESTH7lQtm/3x5FTXDTgF1XZLOaIaUU7ei1kvTOK6h/9hvNlOBDXdDllqcyHjaDT0fTbrLFDM4x6zNSliX300M6TNTdPKIKZIxTEOpulGyAoRriat+b2aJfE6h0CqDa3Iiu3V+RE68Efo4YzyclVg5r28ksH47nEblfbfeldcF5R4KFlRxeSaldhjcngV8apd9u9WUfUGrXZLvKCCkMPT/AQO4si1tZEPZm63/WezrhSOg1qyUNE/Bj+QKj8zDFx4nVlxglI3Gsg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jX1Qu-0001aN-My; Fri, 08 May 2020 13:44:48 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jX1Qu-0005K4-DN; Fri, 08 May 2020 13:44:48 +0200
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 20/31] qcow2: Add subcluster support to
 qcow2_get_host_offset()
In-Reply-To: <80306243-b500-6977-3fcd-82853c905105@redhat.com>
References: <cover.1588699789.git.berto@igalia.com>
 <d4b41accb4c52f31dc7faa3b58084062ac4407f4.1588699789.git.berto@igalia.com>
 <80306243-b500-6977-3fcd-82853c905105@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 08 May 2020 13:44:48 +0200
Message-ID: <w518si2bqhb.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 07:44:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 06 May 2020 07:55:29 PM CEST, Eric Blake wrote:
> On 5/5/20 12:38 PM, Alberto Garcia wrote:
>> The logic of this function remains pretty much the same, except that
>> it uses count_contiguous_subclusters(), which combines the logic of
>> count_contiguous_clusters() / count_contiguous_clusters_unallocated()
>> and checks individual subclusters.
>
> Maybe mention that qcow2_cluster_to_subcluster_type() is now inlined 
> into its lone remaining caller.

Ok.

>> +static int count_contiguous_subclusters(BlockDriverState *bs, int nb_clusters,
>> +                                        unsigned sc_index, uint64_t *l2_slice,
>> +                                        int l2_index)
>>   {
>
>> +
>> +    assert(type != QCOW2_SUBCLUSTER_INVALID); /* The caller should check this */
>> +    assert(l2_index + nb_clusters <= s->l2_size);
>> +
>> +    if (type == QCOW2_SUBCLUSTER_COMPRESSED) {
>> +        /* Compressed clusters are always processed one by one */
>> +        return s->subclusters_per_cluster - sc_index;
>
> Should this assert(sc_index == 0)?

No. The documentation of the function says "Compressed clusters are
always processed one by one but for the purpose of this count they are
treated as if they were divided into subclusters of size
s->subcluster_size".

Let's say we have a compressed cluster at offset 0 (size 64k) and we
perform a read request with offset=32k, size=8k.

qcow2_co_preadv_part() calls qcow2_get_host_offset() and asks "How many
bytes up to 8k can we read in one go at offset 32k?".

The offset is 32k so the first subcluster is #16. And this function
(count_contiguous_subclusters()) is asked "how many contiguous
subclusters do we have starting at subcluster #16?" and the answer is
32 - 16 = 16 subclusters.

qcow2_get_host_offset() only needs 8k/2k = 4 subclusters, so it tells
the original caller (qcow2_co_preadv_part()) "you can read all 8k in one
go and the subcluster type is _COMPRESSED".

>>       for (i = 0; i < nb_clusters; i++) {
>> -        uint64_t entry = get_l2_entry(s, l2_slice, l2_index + i);
>> -        QCow2ClusterType type = qcow2_get_cluster_type(bs, entry);
>> -
>> -        if (type != wanted_type) {
>> -            break;
>> +        l2_entry = get_l2_entry(s, l2_slice, l2_index + i);
>> +        l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index + i);
>> +        if (check_offset && expected_offset != (l2_entry & L2E_OFFSET_MASK)) {
>> +            return count;
>> +        }
>> +        for (j = (i == 0) ? sc_index : 0; j < s->subclusters_per_cluster; j++) {
>> +            if (qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, j) != type) {
>> +                return count;
>> +            }
>
> This really is checking that sub-clusters have the exact same type.

Correct.

>> @@ -604,24 +604,17 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
>>               ret = -EIO;
>>               goto fail;
>>           }
>> -        /* Compressed clusters can only be processed one by one */
>> -        c = 1;
>>           *host_offset = l2_entry & L2E_COMPRESSED_OFFSET_SIZE_MASK;
>>           break;
>> -    case QCOW2_CLUSTER_ZERO_PLAIN:
>> -    case QCOW2_CLUSTER_UNALLOCATED:
>> -        /* how many empty clusters ? */
>> -        c = count_contiguous_clusters_unallocated(bs, nb_clusters,
>> -                                                  l2_slice, l2_index, type);
>
> The old code was counting how many contiguous clusters has similar 
> types, coalescing ranges of two different cluster types into one 
> nb_clusters result.

Not really. The old code had three different cases in the switch()
block:

- Compressed clusters: return always 1.

- Unallocated / zero_plain: count the number of clusters of the exact
  same type (one of the parameters was 'wanted_type').

- Normal / zero_alloc: count the number of clusters of type normal or
  zero_alloc that are contiguous on the image file **but stop** if the
  QCOW_OFLAG_ZERO flag changes. In other words, count contiguous
  clusters of the same type.

The new code simply merges all three cases in the same function. It
could be done even without having subclusters.

Plus, the old function was also returning the cluster type, so it had to
be the same one for the whole region.

>>           if (offset_into_cluster(s, host_cluster_offset)) {
>>               qcow2_signal_corruption(bs, true, -1, -1,
>>                                       "Cluster allocation offset %#"
>> @@ -647,9 +640,11 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
>>           abort();
>>       }
>>   
>> +    sc = count_contiguous_subclusters(bs, nb_clusters, sc_index,
>> +                                      l2_slice, l2_index);
>
> But the new code is stopping at the first different subcluster type, 
> rather than trying to coalesce as many compatible types into one larger 
> nb_clusters.  When coupled with patch 19, that factors into my concern 
> over whether patch 19 needed to check for INVALID clusters in the 
> middle, or whether its fail: label was unreachable.  But it also means 
> that you are potentially fragmenting the write in more places (every 
> time a subcluster status changes) rather than coalescing similar status, 
> the way the old code used to operate.

Note that the functions in this patch that you're reviewing are
concerned with read requests, not write requests.

Berto

