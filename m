Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9492C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 17:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1786208DB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 17:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eu7V4pM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1786208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWO2e-0002Ip-O3
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 13:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWO1b-0001lB-T2
 for qemu-devel@nongnu.org; Wed, 06 May 2020 13:40:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30690
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWO1Z-0002Ga-U3
 for qemu-devel@nongnu.org; Wed, 06 May 2020 13:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588786800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OPO9BHCWV4PmbgNkRmnt/HDG3vlmSx1XlFRIfmSKIN4=;
 b=eu7V4pM+zIcQqpGPLAWZNa31H8WwGruLWITd7XAVOcJozH7yfsYzmFAQNB9jQJfx/Dpftg
 b8koPzsNr4VZAIiKNgmc3bXXbgxOK39oyt6+JlHeW5Dr8vup3s9qQR82BPPnXfz/yEbCEq
 VG81xEudJYxWlcbQY2UXTCDOx5YmKpY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-Zm97H1xOMWiVR4LnANZ47A-1; Wed, 06 May 2020 13:39:53 -0400
X-MC-Unique: Zm97H1xOMWiVR4LnANZ47A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45FC98014D5;
 Wed,  6 May 2020 17:39:51 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E63F11025EB7;
 Wed,  6 May 2020 17:39:48 +0000 (UTC)
Subject: Re: [PATCH v5 19/31] qcow2: Add subcluster support to
 calculate_l2_meta()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1588699789.git.berto@igalia.com>
 <907ab6846b93b441a27eb6853ff3058f1c821bf9.1588699789.git.berto@igalia.com>
 <12569151-2f16-f136-6928-2a915b25120b@redhat.com>
 <w517dxp9ea6.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9478ac11-8cae-4576-345e-3acf9e287119@redhat.com>
Date: Wed, 6 May 2020 12:39:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <w517dxp9ea6.fsf@maestria.local.igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 04:02:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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

On 5/6/20 12:14 PM, Alberto Garcia wrote:

>> Note that you are only skipping until the first normal subcluster, even
>> if other zero/unallocated clusters occur between the first normal
>> cluster and the start of the action.
> 
> That's correct.
> 
>> Or visually, suppose we have:
>>
>> --0-NN-0_NNNNNNNN_NNNNNNNN_NNNNNNNN
>>
>> as our 32 subclusters, with sc_index of 8.  You will end up skipping
>> subclusters 0-3, but NOT 6 and 7.
> 
> That's correct. This function works with the assumption that the initial
> COW region is located immediately before the data region, which is in
> turn contiguous to the tail COW region.
> 
...
>> Still, even though we spend time copying the allocated contents of
>> those two subclusters, we also copy the subcluster status, and the
>> guest still ends up reading the same data as before.
> 
> No, the subcluster status is updated and those subclusters are marked
> now as allocated. That's actually why we can use the _RANGE masks that
> you proposed here:
> 
>     https://lists.gnu.org/archive/html/qemu-block/2020-04/msg01155.html
> 
> In other words, we have this bitmap:
> 
>     --0-NN-0_NNNNNNNN_NNNNNNNN_NNNNNNNN
> 
> If we write to subcluster 8 (which was already allocated), the resulting
> bitmap is this one:
> 
>     --0-NNNN_NNNNNNNN_NNNNNNNN_NNNNNNNN
> 
> The last block in iotest 271 deals exactly with this kind of scenarios.

Ah, that's what I was missing. So we indeed do more I/O than strictly 
necessary (by reading from the backing file or writing explicit zeroes 
rather than leaving unallocated or zero subclusters), but we are careful 
that the COW range of the operation puts the correct data into the head 
and tail (either from the backing file or explicitly zero) so that even 
though the status changes to N, the guest still sees the same contents.

I also agree that it is not worth trying to optimize to those later 
subclusters - it adds a lot of complexity for something that does not 
occur as frequently.  It is more important to optimize to the initial 
sequence of unalloc/zero clusters, but once we hit data, taking the 
penalty of COWing a few extra subclusters isn't going to be much worse.

> 
>>>        /* Get the L2 entry of the last cluster */
>>> -    l2_entry = get_l2_entry(s, l2_slice, l2_index + nb_clusters - 1);
>>> -    type = qcow2_get_cluster_type(bs, l2_entry);
>>> +    l2_index += nb_clusters - 1;
>>> +    l2_entry = get_l2_entry(s, l2_slice, l2_index);
>>> +    l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
>>> +    sc_index = offset_to_sc_index(s, guest_offset + bytes - 1);
>>> +    type = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc_index);
>>
>> [1] but here, we are skipping any intermediate clusters, and worrying
>> only about the state of the final cluster.  Is that always going to do
>> the correct thing, or will there be cases where we need to update the
>> L2 entries of intermediate clusters?
> 
>         Cluster 1             Cluster 2             Cluster 3
> |---------------------|---------------------|---------------------|
>     <---cow_start--><-------write request--------><--cow_end--->
> 
> 
> All L2 entries from the beginning of cow_start until the end of cow_end
> are always updated. That's again what the loop that I optimized using
> the _RANGE masks (and that I liked above) was doing.

I guess the other thing that helps is that even if there are 
intermediate invalid subclusters, ideally the caller of this function is 
setting nb_clusters according to its own scan of how many contiguous 
clusters are even available for us to attempt to write into.  So patch 
20/31 catches the case where we don't have contiguous clusters if any of 
the subclusters are invalid.  And in _this_ patch, it shouldn't really 
matter if we don't detect that we are overwriting what used to be an 
invalid subcluster with something that is now valid data.

> 
> The code in calculate_l2_meta() is only concerned with determining the
> actual start and end points. Everything between them will be written to
> and marked as allocated. It's only the subclusters outside that range
> that keep the previous values (unallocated, or zero).

I think you've convinced me that we are safe on what this function does. 
  In fact, if we rely on 20/31 checking for invalid subclusters when 
computing nb_clusters, we could probably assert that the start and end 
cluster in this function are not invalid, instead of adding the fail: 
label.  But even if you don't do that, I can live with:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


