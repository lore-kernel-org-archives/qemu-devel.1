Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7852DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C10C2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C10C2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weiser.dinsnail.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNxQD-00008T-Dk
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <michael@weiser.dinsnail.net>) id 1iNx8U-00025E-H1
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:48:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <michael@weiser.dinsnail.net>) id 1iNx8T-0005JW-9E
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:48:02 -0400
Received: from heinz.dinsnail.net
 ([2a01:238:43b4:3200:9392:5dcc:2f0e:a960]:44548)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <michael@weiser.dinsnail.net>)
 id 1iNx8Q-0005Hy-Al; Fri, 25 Oct 2019 06:47:58 -0400
Received: from heinz.dinsnail.net ([IPv6:0:0:0:0:0:0:0:1])
 by heinz.dinsnail.net (8.15.2/8.15.2) with ESMTP id x9PAiwtg032198;
 Fri, 25 Oct 2019 12:44:58 +0200
Received: from eldalonde.UUCP (uucp@localhost)
 by heinz.dinsnail.net (8.15.2/8.15.2/Submit) with bsmtp id x9PAiwOU032197;
 Fri, 25 Oct 2019 12:44:58 +0200
Received: from eldalonde.weiser.dinsnail.net (localhost [IPv6:0:0:0:0:0:0:0:1])
 by eldalonde.weiser.dinsnail.net (8.15.2/8.15.2) with ESMTP id x9PAZAHL002573; 
 Fri, 25 Oct 2019 12:35:10 +0200
Received: (from michael@localhost)
 by eldalonde.weiser.dinsnail.net (8.15.2/8.15.2/Submit) id x9PAZAXh002572;
 Fri, 25 Oct 2019 12:35:10 +0200
Date: Fri, 25 Oct 2019 12:35:10 +0200
From: Michael Weiser <michael@weiser.dinsnail.net>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 2/3] qcow2: Assert that qcow2_cache_get() callers hold
 s->lock
Message-ID: <20191025103510.GA2272@weiser.dinsnail.net>
References: <20191023152620.13166-1-kwolf@redhat.com>
 <20191023152620.13166-3-kwolf@redhat.com>
 <20191023153749.GB6177@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023153749.GB6177@localhost.localdomain>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-dinsnail-net-MailScanner-Information: Please contact the ISP for more
 information
X-dinsnail-net-MailScanner-ID: x9PAiwtg032198
X-dinsnail-net-MailScanner: Found to be clean
X-dinsnail-net-MailScanner-From: michael@weiser.dinsnail.net
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:238:43b4:3200:9392:5dcc:2f0e:a960
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
Cc: psyhomb@gmail.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 dgilbert@redhat.com, mreitz@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Kevin,

On Wed, Oct 23, 2019 at 05:37:49PM +0200, Kevin Wolf wrote:

> > qcow2_cache_do_get() requires that s->lock is locked because it can
> > yield between picking a cache entry and actually taking ownership of it
> > by setting offset and increasing the reference count.
> > 
> > Add an assertion to make sure the caller really holds the lock. The
> > function can be called outside of coroutine context, where bdrv_pread
> > and flushes become synchronous operations. The lock cannot and need not
> > be taken in this case.
> I'm still running tests to see if any other code paths trigger the
> assertion, but image creation calls this without the lock held (which is
> harmless because nobody else knows about the image so there won't be
> concurrent requests). The following patch is needed additionally to make
> image creation work with the new assertion.

I can confirm that with all four patches corruption does no longer
occur as of commit 69f47505ee66afaa513305de0c1895a224e52c45. Removing
only 3/3 (qcow2: Fix corruption bug in
qcow2_detect_metadata_preallocation()) the assertion triggers after a
few seconds, leaving behind a few leaked clusters but no errors in the
image.

(qemu) qemu-system-x86_64:qemu/include/qemu/coroutine.h:175:
qemu_co_mutex_assert_locked: Assertion `mutex->locked && mutex->holder
== qemu_coroutine_self()' failed.
Aborted (core dumped)

$ qemu-img check qtest.qcow2 
Leaked cluster 169257 refcount=3 reference=2
Leaked cluster 172001 refcount=1 reference=0
Leaked cluster 172002 refcount=1 reference=0
Leaked cluster 172003 refcount=1 reference=0
Leaked cluster 172004 refcount=1 reference=0
Leaked cluster 172005 refcount=1 reference=0
Leaked cluster 172006 refcount=1 reference=0
Leaked cluster 172007 refcount=1 reference=0
Leaked cluster 172008 refcount=1 reference=0
Leaked cluster 172009 refcount=1 reference=0
Leaked cluster 172010 refcount=1 reference=0
Leaked cluster 172011 refcount=1 reference=0
Leaked cluster 172012 refcount=1 reference=0

13 leaked clusters were found on the image.
This means waste of disk space, but no harm to data.
255525/327680 = 77.98% allocated, 3.22% fragmented, 0.00% compressed
clusters
Image end offset: 17106403328

I was going to test with master as well but got overtaken by v2. Will
move on to test v2 now. :)

Series:
Tested-by: Michael Weiser <michael.weiser@gmx.de>

No biggie but if there's a chance could you switch my address to the
above?
-- 
Thanks,
Michael

