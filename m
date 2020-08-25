Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9DEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79302074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgwNHHnW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79302074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAf4u-0003Ri-2b
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bfoster@redhat.com>)
 id 1kAeuw-0003xd-91
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:47:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58084
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <bfoster@redhat.com>)
 id 1kAeuu-000148-AT
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598384854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kpNcf7z1kt5bCNe5xLbtO4jyioxa3rzabBYBmt8aO2c=;
 b=VgwNHHnW6+bWvcgNZyI4sx7d6QRLo+zVWTSkg8tyTy0OtKs9bjTffr7fpO4ygp5Pu0vNQ8
 MIjNP5e2vPiLVYJU5jZwjQ4TUPYtfHIwPAq2yQG1BChPJiwP8vM67CHzOqj3/A/BZy2i5x
 SpCq6uIgWjgDkLH2w7JeivITT5g7IlQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-PrCzxna_NCSqLNv5WZdDWw-1; Tue, 25 Aug 2020 15:47:30 -0400
X-MC-Unique: PrCzxna_NCSqLNv5WZdDWw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C4EAF6C0C;
 Tue, 25 Aug 2020 19:47:27 +0000 (UTC)
Received: from bfoster (ovpn-112-11.rdu2.redhat.com [10.10.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 77B1B6198E;
 Tue, 25 Aug 2020 19:47:26 +0000 (UTC)
Date: Tue, 25 Aug 2020 15:47:24 -0400
From: Brian Foster <bfoster@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: [PATCH 0/1] qcow2: Skip copy-on-write when allocating a zero
 cluster
Message-ID: <20200825194724.GA338144@bfoster>
References: <20200819175300.GA141399@bfoster>
 <w51v9hdultt.fsf@maestria.local.igalia.com>
 <20200820215811.GC7941@dread.disaster.area>
 <20200821110506.GB212879@bfoster>
 <w51364gjkcj.fsf@maestria.local.igalia.com>
 <w51zh6oi4en.fsf@maestria.local.igalia.com>
 <20200821170232.GA220086@bfoster>
 <w51d03evrol.fsf@maestria.local.igalia.com>
 <20200825165415.GB321765@bfoster>
 <w51d03etzj8.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51d03etzj8.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Received-SPF: pass client-ip=205.139.110.61; envelope-from=bfoster@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Dave Chinner <david@fromorbit.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, linux-xfs@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 07:18:19PM +0200, Alberto Garcia wrote:
> On Tue 25 Aug 2020 06:54:15 PM CEST, Brian Foster wrote:
> > If I compare this 5m fio test between XFS and ext4 on a couple of my
> > systems (with either no prealloc or full file prealloc), I end up seeing
> > ext4 run slightly faster on my vm and XFS slightly faster on bare metal.
> > Either way, I don't see that huge disparity where ext4 is 5-6 times
> > faster than XFS. Can you describe the test, filesystem and storage in
> > detail where you observe such a discrepancy?
> 
> Here's the test:
> 
> fio --filename=/path/to/file.raw --direct=1 --randrepeat=1 \
>     --eta=always --ioengine=libaio --iodepth=32 --numjobs=1 \
>     --name=test --size=25G --io_limit=25G --ramp_time=0 \
>     --rw=randwrite --bs=4k --runtime=300 --time_based=1
> 

My fio fallocates the entire file by default with this command. Is that
the intent of this particular test? I added --fallocate=none to my test
runs to incorporate the allocation cost in the I/Os.

> The size of the XFS filesystem is 126 GB and it's almost empty, here's
> the xfs_info output:
> 
> meta-data=/dev/vg/test           isize=512    agcount=4, agsize=8248576
> blks
>          =                       sectsz=512   attr=2, projid32bit=1
>          =                       crc=1        finobt=1, sparse=1,
>          rmapbt=0
>          =                       reflink=0
> data     =                       bsize=4096   blocks=32994304, imaxpct=25
>          =                       sunit=0      swidth=0 blks
> naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
> log      =internal log           bsize=4096   blocks=16110, version=2
>          =                       sectsz=512   sunit=0 blks, lazy-count=1
> realtime =none                   extsz=4096   blocks=0, rtextents=0
> 
> The size of the ext4 filesystem is 99GB, of which 49GB are free (that
> is, without the file used in this test). The filesystem uses 4KB
> blocks, a 128M journal and these features:
> 
> Filesystem revision #:    1 (dynamic)
> Filesystem features:      has_journal ext_attr resize_inode dir_index
>                           filetype needs_recovery extent flex_bg
>                           sparse_super large_file huge_file uninit_bg
>                           dir_nlink extra_isize
> Filesystem flags:         signed_directory_hash
> Default mount options:    user_xattr acl
> 
> In both cases I'm using LVM on top of LUKS and the hard drive is a
> Samsung SSD 850 PRO 1TB.
> 
> The Linux version is 4.19.132-1 from Debian.
> 

Thanks. I don't have LUKS in the mix on my box, but I was running on a
more recent kernel (Fedora 5.7.15-100). I threw v4.19 on the box and saw
a bit more of a delta between XFS (~14k iops) and ext4 (~24k). The same
test shows ~17k iops for XFS and ~19k iops for ext4 on v5.7. If I
increase the size of the LVM volume from 126G to >1TB, ext4 runs at
roughly the same rate and XFS closes the gap to around ~19k iops as
well. I'm not sure what might have changed since v4.19, but care to see
if this is still an issue on a more recent kernel?

Brian

> Berto
> 


