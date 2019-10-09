Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71111C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:03:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA2020B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA2020B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIHFL-0003Ck-R6
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 15:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1iIDT7-00057r-3L
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1iIDT5-0002m8-Sq
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:01:36 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:57840
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1iIDT5-0002gb-MG
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:01:35 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.92.2) (envelope-from <johannes@sipsolutions.net>)
 id 1iIDT1-00088V-2S; Wed, 09 Oct 2019 17:01:31 +0200
Message-ID: <da211edf1f16a6e59572ac3ab398d5cbc8170037.camel@sipsolutions.net>
Subject: Re: [Qemu-devel] [RFC] contrib: add vhost-user-sim
From: Johannes Berg <johannes@sipsolutions.net>
To: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 09 Oct 2019 17:01:26 +0200
In-Reply-To: <20191009140021.GQ5747@stefanha-x1.localdomain>
 (sfid-20191009_160024_966574_34E45675)
References: <20190917122644.15736-1-johannes@sipsolutions.net>
 <20190923092548.GA26219@stefanha-x1.localdomain>
 <24d18f1c38356b19461e77275b94a1ebf89838f1.camel@sipsolutions.net>
 <20191009140021.GQ5747@stefanha-x1.localdomain>
 (sfid-20191009_160024_966574_34E45675)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
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
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-10-09 at 15:00 +0100, Stefan Hajnoczi wrote:

> > The first issue is that sometimes glib actually seems to reports an FD
> > as readable when it's not, so I even put them into non-blocking mode :(
> 
> Strange.  Spurious wakeups are possible in general.  I think when using
> fd monitoring (select(), poll(), etc) the fds should be in non-blocking
> mode.

Are they? I reimplemented all this on top of my (internal) testing
framework and use blocking FDs there, and had no issues whatsoever.

> But if you're seeing this often it makes me wonder if something else is
> unintentionally reading available bytes...

I have no idea, it'd be strange though, what would even get to the FD?

> > The second is that I can't seem to understand how to do recursive
> > mainloops.
> > 
> > To really do this *well*, it should remain a single-threaded
> > application, but would need a hook like
> > 
> > run_mainloop_until_fd_readable(vdev->call_fd)
> > 
> > inside the libvhost-user.c code, and that's a bit ugly ... if I even
> > could figure out how to implement that in glib.
> 
> Recursive mainloops are tricky since usually event loop code isn't
> written to be re-entrant.  It opens up a whole new dimension that
> existing code usually wasn't designed for.  In this case you are writing
> the code from scratch so maybe you can get it to work, but it makes me
> wonder why the recursive mainloop is necessary.

It's needed to handle different clients / connections.

For example, consider this flow

VM           net device & simtime
  <-------------- VHOST_USER_SLAVE_CALL_VRING
  --------------> request for time handling
  <-------------- response for time handling
  --------------> REPLY_ACK for VHOST_USER_SLAVE_CALL_VRING

I sort of solved it with different threads for the different entities
(netdev & simtime) but that also just causes deadlocks with the locking
that needs to happen.

Like I said, I had reimplemented this in the meantime with a (hand-
written) recursive mainloop as a single thread, and it works way better.
One of these days I need to sit down and port that to be independent of
my testing framework, so I can show the code ...

johannes


