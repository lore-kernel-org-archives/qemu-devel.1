Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25EDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:46:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6810420760
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUi+qcnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6810420760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw1P5-0003Ix-Ms
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 06:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jw1O6-0002mE-Kl
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:45:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33552
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jw1O4-0005DP-Je
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594896311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OxYWZgwLWn7Rnmoh675ZCFOcGubhbtM3QKjvJxepby8=;
 b=TUi+qcnBaDiD11KS7rbb3y87vAhw8El9JwyVJIMAkje2t+XHEMJvcXbXloHRn5x4nwy+Jq
 fLjLUPdlCfHVUb6RGzIPwSJ8kQf8lvN+bZTmpAyYUgRwMoTeSylJt81sWJtoMBUR59JOak
 E0tN9TP3luOOQE7RCHz7jvuNKxHsCGU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-RcauqPHNPyKk8BPtoYPllA-1; Thu, 16 Jul 2020 06:45:07 -0400
X-MC-Unique: RcauqPHNPyKk8BPtoYPllA-1
Received: by mail-wr1-f69.google.com with SMTP id y16so5351839wrr.20
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 03:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=OxYWZgwLWn7Rnmoh675ZCFOcGubhbtM3QKjvJxepby8=;
 b=BBY2yw4A83CmaIwvnd/mOECFEFtPLydpczsSQy9TFEx681HQ0aFz3UnJfJCwFG5ye/
 6tR/kDYvXDXN2+dqTGO0DsCzj7YRG3QyHAcdn3impjjfBxBhDkk1m0xq4muFpr6gpnGv
 uHzN0/mwXGGczo7Z5zlwkLxGE9BnivixqdzAZPtM2N6kGzepBco3arypRKF9MOLOg+e9
 bu8/bD8XDhNZE141yhPsZIlr+GU64Pp6MToV2deCIhnKnqSelDPy3og7G1mcoMQsclH6
 r+oXP2q4RIulpvC0P53x5oX4X/tjiNmNTC3O89m+rjesp+Xdquk5sOHRm7xwPMkrG9xP
 OKMA==
X-Gm-Message-State: AOAM531o0P9EME3iG/UHov2Gq4/4XJ1dYZTDZerc8zWo+OxBcCAszCmd
 C1QnvI9/gL4ihtXG+y0XLUFGR7ssvjaXhPREI/uZxWHbw70jn+g2NbHch1CrBcrDC0WeL6dn9/A
 WomKZjy695cBk3Zs=
X-Received: by 2002:a5d:55cb:: with SMTP id i11mr4277124wrw.28.1594896306114; 
 Thu, 16 Jul 2020 03:45:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYbnuKjraPbNIkft/3GTUfSsNTNTx6l/aUgESxOucWFlYdAHLRLOjvsyeHY5kY8Vrt3fD+lA==
X-Received: by 2002:a5d:55cb:: with SMTP id i11mr4277090wrw.28.1594896305809; 
 Thu, 16 Jul 2020 03:45:05 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 w128sm8996937wmb.19.2020.07.16.03.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 03:45:04 -0700 (PDT)
Date: Thu, 16 Jul 2020 06:45:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: teawater <teawaterz@linux.alibaba.com>
Subject: Re: [virtio-dev] [RFC for Linux v4 0/2] virtio_balloon: Add
 VIRTIO_BALLOON_F_CONT_PAGES to report continuous pages
Message-ID: <20200716064340-mutt-send-email-mst@kernel.org>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
 <20200716021929-mutt-send-email-mst@kernel.org>
 <744230FA-78D8-4568-8188-683087065E84@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <744230FA-78D8-4568-8188-683087065E84@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 19:36:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, virtio-dev@lists.oasis-open.org,
 david@redhat.com, qemu-devel@nongnu.org, jasowang@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, akpm@linux-foundation.org, Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 16, 2020 at 03:01:18PM +0800, teawater wrote:
> 
> 
> > 2020年7月16日 14:38，Michael S. Tsirkin <mst@redhat.com> 写道：
> > 
> > On Thu, Jul 16, 2020 at 10:41:50AM +0800, Hui Zhu wrote:
> >> The first, second and third version are in [1], [2] and [3].
> >> Code of current version for Linux and qemu is available in [4] and [5].
> >> Update of this version:
> >> 1. Report continuous pages will increase the speed.  So added deflate
> >>   continuous pages.
> >> 2. According to the comments from David in [6], added 2 new vqs inflate_cont_vq
> >>   and deflate_cont_vq to report continuous pages with format 32 bits pfn and 32
> >>   bits size.
> >> Following is the introduction of the function.
> >> These patches add VIRTIO_BALLOON_F_CONT_PAGES to virtio_balloon. With this
> >> flag, balloon tries to use continuous pages to inflate and deflate.
> >> Opening this flag can bring two benefits:
> >> 1. Report continuous pages will increase memory report size of each time
> >>   call tell_host.  Then it will increase the speed of balloon inflate and
> >>   deflate.
> >> 2. Host THPs will be splitted when qemu release the page of balloon inflate.
> >>   Inflate balloon with continuous pages will let QEMU release the pages
> >>   of same THPs.  That will help decrease the splitted THPs number in
> >>   the host.
> >>   Following is an example in a VM with 1G memory 1CPU.  This test setups an
> >>   environment that has a lot of fragmentation pages.  Then inflate balloon will
> >>   split the THPs.
> 
> 
> >> // This is the THP number before VM execution in the host.
> >> // None use THP.
> >> cat /proc/meminfo | grep AnonHugePages:
> >> AnonHugePages:         0 kB
> These lines are from host.
> 
> >> // After VM start, use usemem
> >> // (https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git)
> >> // punch-holes function generates 400m fragmentation pages in the guest
> >> // kernel.
> >> usemem --punch-holes -s -1 800m &
> These lines are from guest.  They setups the environment that has a lot of fragmentation pages.
> 
> >> // This is the THP number after this command in the host.
> >> // Some THP is used by VM because usemem will access 800M memory
> >> // in the guest.
> >> cat /proc/meminfo | grep AnonHugePages:
> >> AnonHugePages:    911360 kB
> These lines are from host.
> 
> >> // Connect to the QEMU monitor, setup balloon, and set it size to 600M.
> >> (qemu) device_add virtio-balloon-pci,id=balloon1
> >> (qemu) info balloon
> >> balloon: actual=1024
> >> (qemu) balloon 600
> >> (qemu) info balloon
> >> balloon: actual=600
> These lines are from host.
> 
> >> // This is the THP number after inflate the balloon in the host.
> >> cat /proc/meminfo | grep AnonHugePages:
> >> AnonHugePages:     88064 kB
> These lines are from host.
> 
> >> // Set the size back to 1024M in the QEMU monitor.
> >> (qemu) balloon 1024
> >> (qemu) info balloon
> >> balloon: actual=1024
> These lines are from host.
> 
> >> // Use usemem to increase the memory usage of QEMU.
> >> killall usemem
> >> usemem 800m
> These lines are from guest.
> 
> >> // This is the THP number after this operation.
> >> cat /proc/meminfo | grep AnonHugePages:
> >> AnonHugePages:     65536 kB
> These lines are from host.
> 
> 
> 
> >> 
> >> Following example change to use continuous pages balloon.  The number of
> >> splitted THPs is decreased.
> >> // This is the THP number before VM execution in the host.
> >> // None use THP.
> >> cat /proc/meminfo | grep AnonHugePages:
> >> AnonHugePages:         0 kB
> These lines are from host.
> 
> >> // After VM start, use usemem punch-holes function generates 400M
> >> // fragmentation pages in the guest kernel.
> >> usemem --punch-holes -s -1 800m &
> These lines are from guest.  They setups the environment that has a lot of fragmentation pages.
> 
> >> // This is the THP number after this command in the host.
> >> // Some THP is used by VM because usemem will access 800M memory
> >> // in the guest.
> >> cat /proc/meminfo | grep AnonHugePages:
> >> AnonHugePages:    911360 kB
> These lines are from host.
> 
> >> // Connect to the QEMU monitor, setup balloon, and set it size to 600M.
> >> (qemu) device_add virtio-balloon-pci,id=balloon1,cont-pages=on
> >> (qemu) info balloon
> >> balloon: actual=1024
> >> (qemu) balloon 600
> >> (qemu) info balloon
> >> balloon: actual=600
> These lines are from host.
> 
> >> // This is the THP number after inflate the balloon in the host.
> >> cat /proc/meminfo | grep AnonHugePages:
> >> AnonHugePages:    616448 kB
> >> // Set the size back to 1024M in the QEMU monitor.
> >> (qemu) balloon 1024
> >> (qemu) info balloon
> >> balloon: actual=1024
> These lines are from host.
> 
> >> // Use usemem to increase the memory usage of QEMU.
> >> killall usemem
> >> usemem 800m
> These lines are from guest.
> 
> >> // This is the THP number after this operation.
> >> cat /proc/meminfo | grep AnonHugePages:
> >> AnonHugePages:    907264 kB
> These lines are from host.
> 
> > 
> > I'm a bit confused about which of the above run within guest,
> > and which run within host. Could you explain pls?
> > 
> > 
> 
> I added some introduction to show where these lines is get from.
> 
> Best,
> Hui


OK so we see host has more free THPs. But guest has presumably less now - so
the total page table depth is the same. Did we gain anything?

> 
> > 
> >> [1] https://lkml.org/lkml/2020/3/12/144
> >> [2] https://lore.kernel.org/linux-mm/1584893097-12317-1-git-send-email-teawater@gmail.com/
> >> [3] https://lkml.org/lkml/2020/5/12/324
> >> [4] https://github.com/teawater/linux/tree/balloon_conts
> >> [5] https://github.com/teawater/qemu/tree/balloon_conts
> >> [6] https://lkml.org/lkml/2020/5/13/1211
> >> 
> >> Hui Zhu (2):
> >>  virtio_balloon: Add VIRTIO_BALLOON_F_CONT_PAGES and inflate_cont_vq
> >>  virtio_balloon: Add deflate_cont_vq to deflate continuous pages
> >> 
> >> drivers/virtio/virtio_balloon.c     |  180 +++++++++++++++++++++++++++++++-----
> >> include/linux/balloon_compaction.h  |   12 ++
> >> include/uapi/linux/virtio_balloon.h |    1
> >> mm/balloon_compaction.c             |  117 +++++++++++++++++++++--
> >> 4 files changed, 280 insertions(+), 30 deletions(-)
> > 
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


