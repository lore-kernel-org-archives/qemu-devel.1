Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C674CC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 17:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9941320706
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 17:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SVrqDkjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9941320706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAcbI-0002R3-RD
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 13:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kAcaf-0001si-2S; Tue, 25 Aug 2020 13:18:33 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:54798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kAcab-0006jZ-6E; Tue, 25 Aug 2020 13:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=NRuZ0LyzRm4DjommZhDcvSlF725dOGlT2jpGRP/6sTE=; 
 b=SVrqDkjA5NLym8V/ERjmtPwQdbukrc/bGdB4ViJwrptUP0t2vvDZZ3oaM4NjQMsm3fbNoaEkqyBEdFpMtLlFZe1v9cXuBw4HGJcGZXqLoUh42k0g84pTeAKREk4VgYrWuofXtckK8MDT/t1vMkskcWJQIGiH3DL0Gp2nyRhJLVK4OYAscLWKHAoJ66PHkuKjTAGVo3ptoaplOu9jPDzIybnVPE8oPB1jMb3Vdx+xX1dxOrPPFZnTojsPBp7yfsEpA+uf1MAgo091DN5/wNKAH++smJ97U+kVfM2msiLE2MXgAMMoXT+4ZS4kN5+7pWwCCN/18jtQH70WOE8c/fwpaQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kAcaS-00048N-28; Tue, 25 Aug 2020 19:18:20 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kAcaR-000403-Ot; Tue, 25 Aug 2020 19:18:19 +0200
From: Alberto Garcia <berto@igalia.com>
To: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 0/1] qcow2: Skip copy-on-write when allocating a zero
 cluster
In-Reply-To: <20200825165415.GB321765@bfoster>
References: <w51pn7memr7.fsf@maestria.local.igalia.com>
 <20200819150711.GE10272@linux.fritz.box> <20200819175300.GA141399@bfoster>
 <w51v9hdultt.fsf@maestria.local.igalia.com>
 <20200820215811.GC7941@dread.disaster.area> <20200821110506.GB212879@bfoster>
 <w51364gjkcj.fsf@maestria.local.igalia.com>
 <w51zh6oi4en.fsf@maestria.local.igalia.com> <20200821170232.GA220086@bfoster>
 <w51d03evrol.fsf@maestria.local.igalia.com> <20200825165415.GB321765@bfoster>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 25 Aug 2020 19:18:19 +0200
Message-ID: <w51d03etzj8.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 13:18:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue 25 Aug 2020 06:54:15 PM CEST, Brian Foster wrote:
> If I compare this 5m fio test between XFS and ext4 on a couple of my
> systems (with either no prealloc or full file prealloc), I end up seeing
> ext4 run slightly faster on my vm and XFS slightly faster on bare metal.
> Either way, I don't see that huge disparity where ext4 is 5-6 times
> faster than XFS. Can you describe the test, filesystem and storage in
> detail where you observe such a discrepancy?

Here's the test:

fio --filename=/path/to/file.raw --direct=1 --randrepeat=1 \
    --eta=always --ioengine=libaio --iodepth=32 --numjobs=1 \
    --name=test --size=25G --io_limit=25G --ramp_time=0 \
    --rw=randwrite --bs=4k --runtime=300 --time_based=1

The size of the XFS filesystem is 126 GB and it's almost empty, here's
the xfs_info output:

meta-data=/dev/vg/test           isize=512    agcount=4, agsize=8248576
blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1,
         rmapbt=0
         =                       reflink=0
data     =                       bsize=4096   blocks=32994304, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=16110, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0

The size of the ext4 filesystem is 99GB, of which 49GB are free (that
is, without the file used in this test). The filesystem uses 4KB
blocks, a 128M journal and these features:

Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index
                          filetype needs_recovery extent flex_bg
                          sparse_super large_file huge_file uninit_bg
                          dir_nlink extra_isize
Filesystem flags:         signed_directory_hash
Default mount options:    user_xattr acl

In both cases I'm using LVM on top of LUKS and the hard drive is a
Samsung SSD 850 PRO 1TB.

The Linux version is 4.19.132-1 from Debian.

Berto

