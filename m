Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HEXHASH_WORD,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E7CC48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 14:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6366C208E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 14:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DqHAVcPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6366C208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgUzE-0004pn-KQ
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 10:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41901)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berto@igalia.com>) id 1hgUwS-0002ah-2k
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 10:00:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1hgUwM-0002Ub-CZ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 09:59:58 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:53111)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1hgUwK-0002Jo-2z; Thu, 27 Jun 2019 09:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date;
 bh=Ht2rbyqHntwmC490zMa1X34nRC8wvLyyZVYczHFfDNc=; 
 b=DqHAVcPMXAD/KdwUOX0/kGPvxlfOjP0LLP5jx04AaJtPLCQRLOiHxnL21qFHDtZsIttoQBCJLTQLahlacGUg/2RZAU0fzAxmpZtMDvFbhOtZOsAGH+I/02F1IwqGArgESbqcOh6HcdglAlM1fDizoHl/6g8HK7fy133nkbJ0zjXQCzauycHxbA3OVUXqt0irtHo90o5ygQyOvdKJesLw2xv0RPtqtzLg7+lHejK7pXaci3Php8KEBQZwsjQMoJeakp/UdeWhSHCMn6wKxbG6+V4O7tqTnRc1wocflBi0Tm6e4xlzi5uionYgob4qk8iB/VhOJ3RUI55sVmncGGAeNw==;
Received: from 82-181-154-206.bb.dnainternet.fi ([82.181.154.206]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1hgUvv-0005qy-Da; Thu, 27 Jun 2019 15:59:27 +0200
Received: from berto by perseus.local with local (Exim 4.89)
 (envelope-from <berto@igalia.com>)
 id 1hgUvi-0000KD-8C; Thu, 27 Jun 2019 16:59:14 +0300
Date: Thu, 27 Jun 2019 16:59:14 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Message-ID: <20190627135914.xlzohrdwr6mz2aq3@perseus.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: [Qemu-devel] [RFC] Re-evaluating subcluster allocation for qcow2
 images
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
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

a couple of years ago I came to the mailing list with a proposal to
extend the qcow2 format to add subcluster allocation.

You can read the original message (and the discussion thread that came
afterwards) here:

   https://lists.gnu.org/archive/html/qemu-block/2017-04/msg00178.html

The description of the problem from the original proposal is still
valid so I won't repeat it here.

What I have been doing during the past few weeks was to retake the
code that I wrote in 2017, make it work with the latest QEMU and fix
many of its bugs. I have again a working prototype which is by no
means complete but it allows us to have up-to-date information about
what we can expect from this feature.

My goal with this message is to retake the discussion and re-evaluate
whether this is a feature that we'd like for QEMU in light of the test
results and all the changes that we have had in the past couple of
years.

=== Test results ===

I ran these tests with the same hardware configuration as in 2017: an
SSD drive and random 4KB write requests to an empty 40GB qcow2 image.

Here are the results when the qcow2 file is backed by a fully
populated image. There are 8 subclusters per cluster and the
subcluster size is in brackets:

|-----------------+----------------+-----------------|
|  Cluster size   | subclusters=on | subclusters=off |
|-----------------+----------------+-----------------|
|   2 MB (256 KB) |   571 IOPS     |  124 IOPS       |
|   1 MB (128 KB) |   863 IOPS     |  212 IOPS       |
| 512 KB  (64 KB) |  1678 IOPS     |  365 IOPS       |
| 256 KB  (32 KB) |  2618 IOPS     |  568 IOPS       |
| 128 KB  (16 KB) |  4907 IOPS     |  873 IOPS       |
|  64 KB   (8 KB) | 10613 IOPS     | 1680 IOPS       |
|  32 KB   (4 KB) | 13038 IOPS     | 2476 IOPS       |
|   4 KB (512 B)  |   101 IOPS     |  101 IOPS       |
|-----------------+----------------+-----------------|

Some comments about the results, after comparing them with those from
2017:

- As expected, 32KB clusters / 4 KB subclusters give the best results
  because that matches the size of the write request and therefore
  there's no copy-on-write involved.

- Allocation is generally faster now in all cases (between 20-90%,
  depending on the case). We have made several optimizations to the
  code since last time, and I suppose that the COW changes made in
  commits b3cf1c7cf8 and ee22a9d869 are probably the main factor
  behind these improvements.

- Apart from the 64KB/8KB case (which is much faster), the patters are
  generally the same: subcluster allocation offers similar performance
  benefits compared to last time, so there are no surprises in this
  area.

Then I ran the tests again using the same environment but without a
backing image. The goal is to measure the impact of subcluster
allocation on completely empty images.

Here we have an important change: since commit c8bb23cbdb empty
clusters are preallocated and filled with zeroes using an efficient
operation (typically fallocate() with FALLOC_FL_ZERO_RANGE) instead of
writing the zeroes with the usual pwrite() call.

The effects of this are dramatic, so I decided to run two sets of
tests: one with this optimization and one without it.

Here are the results:

|-----------------+----------------+-----------------+----------------+-----------------|
|                 | Initialization with fallocate()  |  Initialization with pwritev()   |
|-----------------+----------------+-----------------+----------------+-----------------|
|  Cluster size   | subclusters=on | subclusters=off | subclusters=on | subclusters=off |
|-----------------+----------------+-----------------+----------------+-----------------|
|   2 MB (256 KB) | 14468 IOPS     | 14776 IOPS      |  1181 IOPS     |  260 IOPS       |
|   1 MB (128 KB) | 13752 IOPS     | 14956 IOPS      |  1916 IOPS     |  358 IOPS       |
| 512 KB  (64 KB) | 12961 IOPS     | 14776 IOPS      |  4038 IOPS     |  684 IOPS       |
| 256 KB  (32 KB) | 12790 IOPS     | 14534 IOPS      |  6172 IOPS     | 1213 IOPS       |
| 128 KB  (16 KB) | 12550 IOPS     | 13967 IOPS      |  8700 IOPS     | 1976 IOPS       |
|  64 KB   (8 KB) | 12491 IOPS     | 13432 IOPS      | 11735 IOPS     | 4267 IOPS       |
|  32 KB   (4 KB) | 13203 IOPS     | 11752 IOPS      | 12366 IOPS     | 6306 IOPS       |
|   4 KB (512 B)  |   103 IOPS     |   101 IOPS      |   101 IOPS     |  101 IOPS       |
|-----------------+----------------+-----------------+----------------+-----------------|

Comments:

- With the old-style allocation method using pwritev() we get similar
  benefits as we did last time. The comments from the test with a
  backing image apply to this one as well.

- However the new allocation method is so efficient that having
  subclusters does not offer any performance benefit. It even slows
  down things a bit in most cases, so we'd probably need to fine tune
  the algorithm in order to get similar results.

- In light of this numbers I also think that even when there's a
  backing image we could preallocate the full cluster but only do COW
  on the affected subclusters. This would the rest of the cluster
  preallocated on disk but unallocated on the bitmap. This would
  probably reduce on-disk fragmentation, which was one of the concerns
  raised during the original discussion.

I also ran some tests on a rotating HDD drive. Here having subclusters
doesn't make a big difference regardless of whether there is a backing
image or not, so we can ignore this scenario.

=== Changes to the on-disk format ===

In my original proposal I described 3 different alternatives for
storing the subcluster bitmaps. I'm naming them here, but refer to
that message for more details.

(1) Storing the bitmap inside the 64-bit entry
(2) Making L2 entries 128-bit wide.
(3) Storing the bitmap somewhere else

I used (1) for this implementation for simplicity, but I think (2) is
probably the best one.

===========================

And I think that's all. As you can see I didn't want to go much into
the open technical questions (I think the on-disk format would be the
main one), the first goal should be to decide whether this is still an
interesting feature or not.

So, any questions or comments will be much appreciated.

Berto

