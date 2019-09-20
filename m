Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7941CC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E8D82070C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8D82070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBEPq-0000f0-CB
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 04:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iBEP6-0000BQ-6B
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iBEP4-0001mC-GM
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:36:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42074)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iBEP4-0001lp-9q
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:36:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3879A69061
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 08:36:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-81.ams2.redhat.com
 [10.36.117.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B1775D9E5;
 Fri, 20 Sep 2019 08:36:32 +0000 (UTC)
Date: Fri, 20 Sep 2019 10:36:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Tony Asleson <tasleson@redhat.com>
Subject: Re: [RFC 0/4] POC: Generating realistic block errors
Message-ID: <20190920083630.GA5458@localhost.localdomain>
References: <20190919194847.18518-1-tasleson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919194847.18518-1-tasleson@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 20 Sep 2019 08:36:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.09.2019 um 21:48 hat Tony Asleson geschrieben:
> For a long time I thought that VMs could be a great way to improve OS
> code quality by modifying the simulated hardware to return errors to
> exercise error paths in the OSs, specifically in block devices for right now.
> A number of different approaches are available within the Linux kernel, eg.
> scsi-debug, dm-flakey, and others.  However, I always though it would be best to
> simulate it from the hardware.  To fully exercise the entire stack.  As a
> bonus it's OS agnostic for those projects that cross OSs and it's available
> before the OS even boots.
> 
> This POC needs a lot more work, but it's what I have so far.  Learning QEMU
> internals, plus some of the different bus types has been interesting to say
> the least.  I'm most familiar with SCSI, but the others are foreign to me.
> AHCI/SATA/ATA is very interesting with it's history and the associated code to
> handle it's evolution.
> 
> Eventually I think it would be useful to add functionality for errors on
> write paths, timeouts, and different error behaviors.  Like media error(s) that
> are corrected by a re-write (simulate failed write on power loss), bit rot
> injection etc.  I know a number of these can be solved different ways,
> but embracing them from the VM environment seems ideal to me.

Yes, this makes sense to me. The question to answer seems to be where
this functionality would fit in - first of all, frontend (inside the
device emulation) or backend. And it's not an easy quesiton, but see
below.

> Expanding to gather statistics on IO patterns, histograms etc. could
> be very useful too.  Having the ability to start/stop information
> collection and then have access to what happened and in what order
> could allow for better error injection of key FS structures and
> software RAID solutions too.

We do already gather some basic statistics, and it would probably make
sense to add more things there. This is pretty clearly a job for the
backend, I think. If the information is easy to collect, we can add it
in the normal I/O path, otherwise an optional filter block driver could
do this.

> I've recently been informed that blkdebug exists.  From a cursory
> investigation it does appear have overlap, but I haven't given it a
> try yet.  From looking at the code to insert my changes it appears
> that some of the errors I'm generating are different than what for
> example an EIO on a read_aio does, but I'm not sure.  Perhaps some of
> the other features that I've outlined above already exist too in some
> other capacity of QEMU?

The overlap seems big enough that we can't ignore it. blkdebug was
primarily meant to debug image format block drivers like qcow2, but
because this means that it can inject I/O errors if specific sectors are
accessed, it makes sense to just use the same functionality for guest
devices, too.

I/O error inserted by blkdebug can be one-off or permanent, but since it
also supports using a small state machine, I think you should already be
able to configure your errors that are corrected by a rewrite, too, even
if there is no explicit support for this yet (I guess we could add it if
it turned out to be much easier to use).

The one thing I see in your series that we can't currently provide this
way is the exact sector number where the error happened. If you read
from sector 32 to 64 and there is an error configured for sector 50, you
just see that the whole request is failing.


I also wonder why you had to write low-level error handling code instead
of calling the existing error functions. If the existing functions don't
give the right result in error cases, shouldn't they be fixed anyway?

And then, as John already hinted, adding code for debugging scenarios to
hot paths that are important for high-performance VMs that don't use any
debugging is less than optimal.


So bringing everything together, what would you think of this plan:

1. Extend blkdebug with whatever ways you need to trigger I/O errors
   (only if the existing modes aren't sufficient at least for the start;
   we can still always extend it later)

2. Add a new BlockDriver callback that can return detailed information
   about an error (such as the exact sector number), and wire it up
   through BlockBackend (some blk_* function). Implement it in blkdebug.

3. In the guest devices, only call the function to get detailed error
   information in the existing error path. You can then update some
   device state according to the details if the block driver returned
   anything (probably only blkdebug will return something).

This way, we have no changes at all in the hot I/O path if you didn't
configure your VM with a blkdebug filter. And we avoid duplication of
code both in the error handler in devices and in the error injection
mechanisms.

Kevin

