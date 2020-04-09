Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6990C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 16:09:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EAF620771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 16:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BT0G9sa0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAF620771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMZjj-0000yj-L6
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 12:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jMZj7-0000Kn-Bl
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 12:08:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jMZj5-0001O4-Ta
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 12:08:24 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:35104)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jMZj5-0001MC-2s; Thu, 09 Apr 2020 12:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=NKPIp2dRkTf8NZYS41q9T5Or8ejKcaU3Fzs1utSqTys=; 
 b=BT0G9sa0e34fjD/3FrKjXHdCnYetWwpucMmi38yqPe4QoD4Pl8B9R5FpKAxnb7el76Mih/CLMPSH81HU3TeN1btoVbKLk+SXl4DQdM2tZWbxfrhGbUN9gG+by3oScqYB8fMeeSc9912syy3mQacm22eUVgL1+WzIeg1tUI3BEm7cN7HKKu3sGeRX+N0niqWJoIa0nn6kWw9B0NESVddNc0aa0Kag7hdHG3Z3+nCfs2Uv7pg5EihmK7XJx6xWAa7BrFuLA1wjErndQvy7pYnnqBAb7PohgNEpvnWC2WcZMa6XucJ/e5gDbOHKUmdrfXGIZcn39Ac/Dnm7tzE0tGOu2Q==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jMZj0-0000eG-2j; Thu, 09 Apr 2020 18:08:18 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jMZiz-0005GM-Pl; Thu, 09 Apr 2020 18:08:17 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 05/30] qcow2: Process QCOW2_CLUSTER_ZERO_ALLOC clusters
 in handle_copied()
In-Reply-To: <66273cab-85f3-209e-1e8f-1b09ad8ff97b@virtuozzo.com>
References: <cover.1584468723.git.berto@igalia.com>
 <42c52037c0c975e2d1cd23b470e7b61cbd0b3fa3.1584468723.git.berto@igalia.com>
 <66273cab-85f3-209e-1e8f-1b09ad8ff97b@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 09 Apr 2020 18:08:17 +0200
Message-ID: <w511row3amm.fsf@maestria.local.igalia.com>
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

On Thu 09 Apr 2020 12:59:30 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>   static void calculate_l2_meta(BlockDriverState *bs,
>>                                 uint64_t host_cluster_offset,
>>                                 uint64_t guest_offset, unsigned bytes,
>> -                              QCowL2Meta **m, bool keep_old)
>> +                              uint64_t *l2_slice, QCowL2Meta **m, bool keep_old)
>>   {
>>       BDRVQcow2State *s = bs->opaque;
>> -    unsigned cow_start_from = 0;
>> +    int l2_index = offset_to_l2_slice_index(s, guest_offset);
>> +    uint64_t l2_entry;
>> +    unsigned cow_start_from, cow_end_to;
>>       unsigned cow_start_to = offset_into_cluster(s, guest_offset);
>>       unsigned cow_end_from = cow_start_to + bytes;
>> -    unsigned cow_end_to = ROUND_UP(cow_end_from, s->cluster_size);
>>       unsigned nb_clusters = size_to_clusters(s, cow_end_from);
>>       QCowL2Meta *old_m = *m;
>> +    QCow2ClusterType type;
>> +
>> +    assert(nb_clusters <= s->l2_slice_size - l2_index);
>> +
>> +    /* Return if there's no COW (all clusters are normal and we keep them) */
>> +    if (keep_old) {
>> +        int i;
>> +        for (i = 0; i < nb_clusters; i++) {
>> +            l2_entry = be64_to_cpu(l2_slice[l2_index + i]);
>> +            if (qcow2_get_cluster_type(bs, l2_entry) != QCOW2_CLUSTER_NORMAL) {
>
> Could we also allow full ZERO_ALLOC clusters here?

No, because the L2 entry needs to be modified (in order to remove the
'all zeroes' bit) and we need to create a QCowL2Meta entry for that (see
qcow2_handle_l2meta()).

>> +    /* Get the L2 entry of the first cluster */
>> +    l2_entry = be64_to_cpu(l2_slice[l2_index]);
>> +    type = qcow2_get_cluster_type(bs, l2_entry);
>> +
>> +    if (type == QCOW2_CLUSTER_NORMAL && keep_old) {
>> +        cow_start_from = cow_start_to;
>> +    } else {
>> +        cow_start_from = 0;
>> +    }
>> +
>> +    /* Get the L2 entry of the last cluster */
>> +    l2_entry = be64_to_cpu(l2_slice[l2_index + nb_clusters - 1]);
>> +    type = qcow2_get_cluster_type(bs, l2_entry);
>> +
>> +    if (type == QCOW2_CLUSTER_NORMAL && keep_old) {
>> +        cow_end_to = cow_end_from;
>> +    } else {
>> +        cow_end_to = ROUND_UP(cow_end_from, s->cluster_size);
>> +    }
>
> These two ifs may be moved into if (keep_old), and drop "&& keep_old"
> from conditions. This also will allow to drop extra calculations, move
> new variables to if (keep_old) {} block and allow to pass
> l2_slice=NULL together with keep_old=false.

In subsequent patches we're going to have more cases than just
QCOW2_CLUSTER_NORMAL so I don't think it makes sense to move the
keep_old check around.

>> @@ -1239,7 +1304,8 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
>>   
>>       l2_index = offset_to_l2_slice_index(s, guest_offset);
>>       nb_clusters = MIN(nb_clusters, s->l2_slice_size - l2_index);
>> -    assert(nb_clusters <= INT_MAX);
>> +    /* Limit total byte count to BDRV_REQUEST_MAX_BYTES */
>> +    nb_clusters = MIN(nb_clusters, BDRV_REQUEST_MAX_BYTES >> s->cluster_bits);
>>   
>>       /* Find L2 entry for the first involved cluster */
>>       ret = get_cluster_table(bs, guest_offset, &l2_slice, &l2_index);
>> @@ -1249,18 +1315,17 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
>>   
>>       cluster_offset = be64_to_cpu(l2_slice[l2_index]);
>
> It would be good to s/cluster_offset/l2_entry/
>
> And, "cluster_offset & L2E_OFFSET_MASK" is used so many times, so, I'd
> not substitute, but keep both variables: l2_entry and cluster_offset.

Sounds good, I can change that.

>> +    /* Allocate at a given offset in the image file */
>> +    alloc_cluster_offset = *host_offset == INV_OFFSET ? INV_OFFSET :
>> +        start_of_cluster(s, *host_offset);
>> +    ret = do_alloc_cluster_offset(bs, guest_offset, &alloc_cluster_offset,
>> +                                  &nb_clusters);
>> +    if (ret < 0) {
>> +        goto out;
>>       }
>>   
>> -    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
>
> actually we don't need l2_slice for keep_old=false in
> calculate_l2_meta, so if calculate_l2_meta modified a bit, change of
> function tail is not needed..
>
> Still, may be l2_slice will be used in calculate_l2_meta() in further
> patches? Will see..

We'll need it in a later patch.

>> -fail:
>> -    if (*m && (*m)->nb_clusters > 0) {
>> +out:
>> +    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
>> +    if (ret < 0 && *m && (*m)->nb_clusters > 0) {
>>           QLIST_REMOVE(*m, next_in_flight);
>>       }
>
> Hmm, unrelated to the patch, but why do we remove meta, which we
> didn't create?

Not sure actually, I would need to check further...

Berto

