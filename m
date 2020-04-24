Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36B3C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 17:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADFCA2071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 17:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEVi8WHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFCA2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS1s7-00057z-OI
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 13:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jS1rO-0004L7-Si
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 13:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jS1rN-0000hh-LF
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 13:11:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41009
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jS1rN-0000hI-4O
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 13:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587748287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NuR4MrjEkKzIuUlj57QCf7KOOJZMlDti9Z9EHNRmhcg=;
 b=KEVi8WHLSmbFM4gFMe6cTAyNsONE8hZZ8en0AIbADhmWpL+liB53lKCuDYSISQVRuh5dZz
 2E3SUBsnzX587HybTbI7SV4F+diQHL+Nl17tVHFxAZwUsvvoiNou1dIl3tjL6FMqpJCSbo
 JyJIl4uTFD5k3Um0Rb7TsnWoymvZPWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-CGmkf-3ZO4yFT2THvyeYrA-1; Fri, 24 Apr 2020 13:11:19 -0400
X-MC-Unique: CGmkf-3ZO4yFT2THvyeYrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C41A21937FDE;
 Fri, 24 Apr 2020 17:11:11 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 230E210002A8;
 Fri, 24 Apr 2020 17:11:09 +0000 (UTC)
Subject: Re: [PATCH v4 24/30] qcow2: Clear the L2 bitmap when allocating a
 compressed cluster
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <6d596d82ed62615a8565b661691a06bfaf32237e.1584468723.git.berto@igalia.com>
 <w51r1wcn7eu.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1606ecb5-98ea-fefb-bb98-2ecda1d65f5c@redhat.com>
Date: Fri, 24 Apr 2020 12:11:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <w51r1wcn7eu.fsf@maestria.local.igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 02:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/24/20 12:02 PM, Alberto Garcia wrote:
> On Tue 17 Mar 2020 07:16:21 PM CET, Alberto Garcia <berto@igalia.com> wrote:
>> Compressed clusters always have the bitmap part of the extended L2
>> entry set to 0.
> 
> I was just finishing some improvements to the new code that allows
> BDRV_REQ_ZERO_WRITE at the subcluster level, and I'm starting to
> entertain the idea of using the L2 bitmap for compressed clusters as
> well.
> 
> I will make some tests next week, but I would like to know your opinion
> in case I'm missing something.
> 
> A compressed cluster cannot be divided into subclusters on the image:
> you would not be able to allocate or overwrite them separately,
> therefore any write request necessarily has to write (or do COW of) the
> whole cluster.
> 
> However if you consider the uncompressed guest data I don't see any
> reason why you wouldn't be able to zeroize or even deallocate individual
> subclusters. These operations don't touch the cluster data on disk
> anyway, they only touch the L2 metadata in order to change what the
> guest sees.
> 
> 'write -c 0 64k' followed by 'write -z 16k 16k' would not need to do any
> copy on write. The compressed data would remain untouched on disk but
> some of the subclusters would have the 'all zeroes' bit set, exactly
> like what happens with normal clusters.

It's a special case that avoids COW for write zeroes, but not for 
anything else. The moment you write any data (whether to the 
zero-above-compressed or the regular compressed portion), the entire 
cluster has to be rewritten.  I'm not sure how frequently guests will 
actually have the scenario of doing a zero request on a sub-cluster, but 
at the same time, I can see where you're coming from in stating that if 
it makes management of extended L2 easier to allow zero subclusters on 
top of a compressed cluster, then there's no reason to forbid it.

> 
> I think that this would make the on-disk format a bit simpler in general
> (no need to treat compressed clusters differently in some cases) and it
> would add a new optimization to compressed images. I just need to make
> sure that it doesn't complicate the code (my feeling is that it would
> actually simplify it, but I have to see).
> 
> Opinions?
> 
> Berto
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


