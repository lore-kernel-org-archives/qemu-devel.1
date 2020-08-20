Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEF0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 20:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58678207BB
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 20:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eib2wX3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58678207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8qo5-0006Bv-Jn
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 16:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1k8qmi-0005eG-MQ; Thu, 20 Aug 2020 16:03:40 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:51265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1k8qme-0005Bu-Qh; Thu, 20 Aug 2020 16:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=FBmh43oHM1E23Eh1cS4UpORoJitJGaSH3+r5hSYb2S0=; 
 b=eib2wX3FlFGPUZdl6D5um7Grh1wfetgdRbxYaful7/y4tr79MELroOqVB4olFgPCa6kd/rZaFJzpyKjnSUdPNYoMf9RmB9QBmsUuXR9uDZdOVUPi26D7iPPLynH1At/znh25pZQNZcC+/y6yaD56WGHyYIDoLFFEEb1XJkb7BS1cvNsPrR1ThOiSJYrxeZe3mc/kcR5wd+W7BxSugXB3wnW0ZNAyeoz5qQpXungccA3eIx1qGR8BwCfh770rHirmaNynLTxVk0EE+cf/rfMUPYaOFMpz1DFzAA8ABcGChCv9ZJ/8kvmkOOyltgQJAPpGq08LMFINZslv2WIVzl+Amg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1k8qmE-0007Np-Uh; Thu, 20 Aug 2020 22:03:11 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1k8qmE-0000MG-L0; Thu, 20 Aug 2020 22:03:10 +0200
From: Alberto Garcia <berto@igalia.com>
To: Brian Foster <bfoster@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 0/1] qcow2: Skip copy-on-write when allocating a zero
 cluster
In-Reply-To: <20200819175300.GA141399@bfoster>
References: <cover.1597416317.git.berto@igalia.com>
 <20200817101019.GD11402@linux.fritz.box>
 <w518sedz3td.fsf@maestria.local.igalia.com>
 <20200817155307.GS11402@linux.fritz.box>
 <w51pn7memr7.fsf@maestria.local.igalia.com>
 <20200819150711.GE10272@linux.fritz.box> <20200819175300.GA141399@bfoster>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 20 Aug 2020 22:03:10 +0200
Message-ID: <w51v9hdultt.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 16:03:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: linux-xfs@vger.kernel.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: linux-xfs

On Wed 19 Aug 2020 07:53:00 PM CEST, Brian Foster wrote:
> In any event, if you're seeing unclear or unexpected performance
> deltas between certain XFS configurations or other fs', I think the
> best thing to do is post a more complete description of the workload,
> filesystem/storage setup, and test results to the linux-xfs mailing
> list (feel free to cc me as well). As it is, aside from the questions
> above, it's not really clear to me what the storage stack looks like
> for this test, if/how qcow2 is involved, what the various
> 'preallocation=' modes actually mean, etc.

(see [1] for a bit of context)

I repeated the tests with a larger (125GB) filesystem. Things are a bit
faster but not radically different, here are the new numbers:

|----------------------+-------+-------|
| preallocation mode   |   xfs |  ext4 |
|----------------------+-------+-------|
| off                  |  8139 | 11688 |
| off (w/o ZERO_RANGE) |  2965 |  2780 |
| metadata             |  7768 |  9132 |
| falloc               |  7742 | 13108 |
| full                 | 41389 | 16351 |
|----------------------+-------+-------|

The numbers are I/O operations per second as reported by fio, running
inside a VM.

The VM is running Debian 9.7 with Linux 4.9.130 and the fio version is
2.16-1. I'm using QEMU 5.1.0.

fio is sending random 4KB write requests to a 25GB virtual drive, this
is the full command line:

fio --filename=/dev/vdb --direct=1 --randrepeat=1 --eta=always
    --ioengine=libaio --iodepth=32 --numjobs=1 --name=test --size=25G
    --io_limit=25G --ramp_time=5 --rw=randwrite --bs=4k --runtime=60
  
The virtual drive (/dev/vdb) is a freshly created qcow2 file stored on
the host (on an xfs or ext4 filesystem as the table above shows), and
it is attached to QEMU using a virtio-blk-pci device:

   -drive if=virtio,file=image.qcow2,cache=none,l2-cache-size=200M

cache=none means that the image is opened with O_DIRECT and
l2-cache-size is large enough so QEMU is able to cache all the
relevant qcow2 metadata in memory.

The host is running Linux 4.19.132 and has an SSD drive.

About the preallocation modes: a qcow2 file is divided into clusters
of the same size (64KB in this case). That is the minimum unit of
allocation, so when writing 4KB to an unallocated cluster QEMU needs
to fill the other 60KB with zeroes. So here's what happens with the
different modes:

1) off: for every write request QEMU initializes the cluster (64KB)
        with fallocate(ZERO_RANGE) and then writes the 4KB of data.

2) off w/o ZERO_RANGE: QEMU writes the 4KB of data and fills the rest
        of the cluster with zeroes.

3) metadata: all clusters were allocated when the image was created
        but they are sparse, QEMU only writes the 4KB of data.

4) falloc: all clusters were allocated with fallocate() when the image
        was created, QEMU only writes 4KB of data.

5) full: all clusters were allocated by writing zeroes to all of them
        when the image was created, QEMU only writes 4KB of data.

As I said in a previous message I'm not familiar with xfs, but the
parts that I don't understand are

   - Why is (4) slower than (1)?
   - Why is (5) so much faster than everything else?

I hope I didn't forget anything, tell me if you have questions.

Berto

[1] https://lists.gnu.org/archive/html/qemu-block/2020-08/msg00481.html

