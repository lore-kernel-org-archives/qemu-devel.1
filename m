Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB63DC4360C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 07:15:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 760F42082C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 07:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YHxPklCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760F42082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKdWu-0005I2-I1
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 03:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iKdW3-0004jZ-Vw
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 03:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iKdW2-0003O3-Ms
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 03:14:39 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:60630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iKdW0-0003NF-EO; Wed, 16 Oct 2019 03:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=Vc6YcjgswJfszX4YH/NguoOYWfENgZ6uAq6L+RNwYlI=; 
 b=YHxPklCYxVyGsfIP168213wRZyuXNBpw+zo3+1ufZYLNB8KF9ahnv94WU+OWpaKDJxD7m/tBa/CWSgY+ItQkHo9GA4EyYKLqTeL9zPg+VNHku2UCs7J8X0rfzHi/RncIgRpYwL7ROxm3voYkBfCloJfW0HiXFXHXGylMMX4VbGpXM1W4D+aPMmDmOK6ndLvc+/R5cD81RPIjTyCqJF49YEKNQpKl/OaaXPg+ro85PCTldsoksYBUeiteA/Vxjig1Dv7NnKu0DJurG2J3DQ200v0rbPlqgMrxl1kXwbM8JCXBq1dQb1jx+BtsnpHJkAybKIFngVuGFFUv2tlOSnObQw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iKdVx-0007mw-7W; Wed, 16 Oct 2019 09:14:33 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1iKdVx-0001pt-4R; Wed, 16 Oct 2019 09:14:33 +0200
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 00/23] Add subcluster allocation to qcow2
In-Reply-To: <1d8b92eb-d530-9acb-82a6-87a04ea5c31d@redhat.com>
References: <cover.1571152571.git.berto@igalia.com>
 <1d8b92eb-d530-9acb-82a6-87a04ea5c31d@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 16 Oct 2019 09:14:33 +0200
Message-ID: <w51lftlnova.fsf@maestria.local.igalia.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 15 Oct 2019 06:05:23 PM CEST, Eric Blake wrote:

>> 63    56 55    48 47    40 39    32 31    24 23    16 15     8 7      0
>> 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> <---------------------------------> <--------------------------------->
>>       subcluster reads as zeros            subcluster is allocated
>>               (32 bits)                           (32 bits)
>
> okay, in patch 5, you said you map the most significant bit to the
> first cluster. That feels backwards to me; I wonder if the math is any
> easier if you map sub-clusters starting from the least-significant,
> because then you get:
>
> bit = (address >> cluster_size) & 32
>
> rather than
>
> bit = 31 - ((address >> cluster_size) & 32)

The reason why I chose that ordering is because I think it's more
natural for debugging if you read from left to right:

63    56 55    48 47    40 39    32 31    24 23    16 15     8 7      0
00000000 00000000 00000000 00011111 11100000 00000000 00000000 00000000
<---------------------------------> <--------------------------------->
      subcluster reads as zeros            subcluster is allocated

Here the last five subclusters read as zeros, and the first three
subclusters are allocated.

I don't think the math is any different. What you need in the code is

  1) A way to get the subcluster index. That doesn't change, it's

        sc_index = (address >> cluster_bits) & 31

     in both cases.

  2) A way to get the "subcluster reads as zeros" and "subcluster is
     allocated" masks. That's not very different either, it's a constant
     shifted by the subcluster index in both cases:

     LSB first:

        all_zeros_mask = (1 << 32) << sc_index
        allocated_mask = 1 << sc_index

     MSB first:

        all_zeros_mask = (1 << 63) >> sc_index
        allocated_mask = (1 << 31) >> sc_index

>> Some comments about the results:
>> 
>> - The smallest allowed cluster size for an image with subclusters is
>>    16 KB (in this case the subclusters size is 512 bytes), hence the
>>    missing values in the 4 KB and 8 KB rows.
>
> Again reading ahead, I see that patch 5 requires a 16k minimum cluster 
> for using extended L2.  Could we still permit clusters smaller than 
> that, but merely document that subclusters are always a minimum of 512 
> bytes and therefore for an 8k cluster we only use 16 bits (leaving the 
> other 16 bits zero)?  But I'm also fine with the simplicity of just 
> stating that subclusters require at least 16k clusters.

I can't think of any reason why you would want smaller clusters, the
numbers show that the performance starts to drop with sizes under 16KB.

> How do subclusters interact with external data files?

As far as I'm aware they work just fine (I'll add tests for that
anyway).

Berto

