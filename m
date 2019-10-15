Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C7AC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C7320640
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C7320640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKPLA-0005Ww-GJ
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 12:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iKPKG-0004gX-QN
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iKPKF-0006HK-Dw
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:05:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49922)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iKPKB-0006Bp-2i; Tue, 15 Oct 2019 12:05:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A3A058E1CE1;
 Tue, 15 Oct 2019 16:05:25 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DD5D60C57;
 Tue, 15 Oct 2019 16:05:23 +0000 (UTC)
Subject: Re: [RFC PATCH 00/23] Add subcluster allocation to qcow2
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1571152571.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1d8b92eb-d530-9acb-82a6-87a04ea5c31d@redhat.com>
Date: Tue, 15 Oct 2019 11:05:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <cover.1571152571.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Tue, 15 Oct 2019 16:05:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/19 10:23 AM, Alberto Garcia wrote:
> Hi,
> 
> this series adds a new feature to the qcow2 on-disk format called
> "Extended L2 Entries", which allows us to do subcluster allocation.
> 
> This cover letter explains the reasons behind this proposal, the
> changes to the on-disk format, test results and pending work. If you
> are curious you can also have a look at previous discussions about
> this feature:
> 

> === Changes to the on-disk format ===
> 
> An L2 entry is 64 bits wide, with this format (for uncompressed
> clusters):
> 
> 63    56 55    48 47    40 39    32 31    24 23    16 15     8 7      0
> 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> **<----> <--------------------------------------------------><------->*
>    Rsrved              host cluster offset of data             Reserved
>    (6 bits)                (47 bits)                           (8 bits)
> 
>      bit 63: refcount == 1   (QCOW_OFLAG_COPIED)
>      bit 62: compressed = 1  (QCOW_OFLAG_COMPRESSED)
>      bit  0: all zeros       (QCOW_OFLAG_ZERO)
> 
> If Extended L2 Entries are enabled, bit 0 becomes reserved and must be
> unset, and this 64-bit bitmap follows the entry:
> 
> 63    56 55    48 47    40 39    32 31    24 23    16 15     8 7      0
> 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> <---------------------------------> <--------------------------------->
>       subcluster reads as zeros            subcluster is allocated
>               (32 bits)                           (32 bits)

I like the grouping - you can then do a 4-byte read and comparison to 0 
to see if the entire cluster reads as zeroes or is unallocated.

With 32k clusters, this results in 1k subclusters.  In cluster 1 (offset 
32k), which bits map where?  (The obvious choices are that sub-cluster 
32k maps to bit 0, 33k maps to bit 1, ...; or that sub-cluster 32k maps 
to bit 31, 33k maps to bit 30, ...)

/me reads ahead

okay, in patch 5, you said you map the most significant bit to the first 
cluster. That feels backwards to me; I wonder if the math is any easier 
if you map sub-clusters starting from the least-significant, because 
then you get:

bit = (address >> cluster_size) & 32

rather than

bit = 31 - ((address >> cluster_size) & 32)


> Some comments about the results:
> 
> - The smallest allowed cluster size for an image with subclusters is
>    16 KB (in this case the subclusters size is 512 bytes), hence the
>    missing values in the 4 KB and 8 KB rows.

Again reading ahead, I see that patch 5 requires a 16k minimum cluster 
for using extended L2.  Could we still permit clusters smaller than 
that, but merely document that subclusters are always a minimum of 512 
bytes and therefore for an 8k cluster we only use 16 bits (leaving the 
other 16 bits zero)?  But I'm also fine with the simplicity of just 
stating that subclusters require at least 16k clusters.


> === To do ===
> 
> A couple of things are missing from this series:
> 
> - The ability to efficiently zero individual subclusters using
>    qcow2_co_pwrite_zeroes(). At the moment only full clusters can be
>    zeroed with this method.
> 
> - Alternatively we could get rid of the individual "all zeroes" bits
>    altogether and have 64 subclusters per cluster. We would still have
>    the QCOW_OFLAG_ZERO bit in the standard cluster descriptor.

I think you've got more flexibility with the two bits per sub-cluster 
than you would with just 1 bit and 64 subclusters, so I don't think this 
direction is going to get us far.

> 
> - The number of subclusters per cluster is always 32. It would be
>    trivial to allow configuring this, but I don't see any use case.

Agreed.

> 
> - Tests: I have a few written that I'll add in future revisions of
>    this series.
> 
> - handle_alloc_space() works at the subclusters level. That is, if you
>    have an unallocated 2MB cluster with 64KB subclusters, no backing
>    image and you write 4KB of data, QEMU won't write zeroes to the
>    affected subcluster(s) and will use handle_alloc_space() instead.
>    The other subclusters won't be touched and will remain unallocated.
>    This behavior is consistent with how subclusters work and saves disk
>    space, but offers slightly lower performance (see test results
>    above). Theoretically we could offer a setting to configure this,
>    but I'm not convinced that this is very useful.
> 
> ===========================
> 
> As usual, feedback is welcome,

Looks promising!

How do subclusters interact with external data files?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

