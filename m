Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD42C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 12:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12722206B8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 12:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12722206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4lDs-0007rq-6B
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 08:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1i4lCS-0006yF-EC
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 08:12:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1i4lCR-000260-4A
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 08:12:48 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:60442
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1i4lCQ-00023g-U1
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 08:12:47 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.92.1) (envelope-from <johannes@sipsolutions.net>)
 id 1i4lCL-0003Ne-V9; Mon, 02 Sep 2019 14:12:42 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: qemu-devel@nongnu.org
Date: Mon,  2 Sep 2019 14:12:31 +0200
Message-Id: <20190902121233.13382-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: [Qemu-devel] [RFC] vhost-user simulation extension
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

First of all, I'm not sure if QEMU actually maintains the master copy of
this document and it isn't like virtio? It *looks* like it does, given
that the updates are "do something" rather than "sync to some version",
but please let me know if I need to send this elsewhere.

Secondly, I'm not sure how amenable you are to changes that are likely
to not be of "production" use. There are many people using Linux for
simulation, but you don't necessarily have to make it easy for them :-)

Third, if this is accepted I'm not sure we'd currently implement it in
QEMU itself. We're currently working on user-mode-Linux because I haven't
found a really good way to control time in QEMU simulation (though other
people have, e.g. VMSimInt[1] has implemented this, AFAICT though only
in full simulation, not with KVM.) So again, this may or may not be a
show-stopper, let me know. The UML patch[2] to implement vhost-user has
been posted to the list but we expect to be making revisions to it before
it can be integrated.

With all that said, let me explain a bit more what this is about. In a
simulation system like VMSimInt or what we're working on, you have what
the VMSimInt paper[3] calls the "simulation calendar", where each of the
simulated components adds an entry and then gets told when (and for how
much simulated time) to run. This is necessary to ensure the simulation
will run the different components in the proper timeline, and if none of
the components has anything to do, time can just skip forward, similar to
the time-travel mode I implemented in UML[4].

Now, of course it's not very useful if you have multiple VMs that can be
on the same simulation time, if they cannot exchange data. VMSimInt has
its own network hooks in the code changes[5], but I'm also interested in
simulating devices (using the same simulation calendar), not just networks.

The obvious way of integrating devices seemed to be virtio/vhost-user, and
that's why we already implemented vhost-user in UML. Now, a bit later, I
realized that due to the asynchronous nature of kick/call on vrings, the
simulation calendar update cannot be guaranteed properly without some extra
synchronisation.

I haven't implemented it yet, but I'm convinced that the proposed addition
to the vhost-user spec would let us implement this properly, as we could
have the vring update message (VHOST_USER_VQ_KICK) put an entry on the
simulation calendar for actually processing the message before sending an
ACK reply back, and the same for VHOST_USER_VQ_CALL in the other direction.
The actual processing of the message on the vring would then happen when
the simulation calendar told that component to run, i.e. when the event
on the calendar actually gets scheduled.

There are obviously other ways of implementing this, for instance I could
use vhost-user polling mode, and then not really implement polling but
have an out-of-band message (e.g. through the communcation channel that's
also used for the simulation time/calendar [6]) to indiciate kick/call.
However, this is uglier in the code, extending the protocol in this way
would just require me to configure the drivers/devices to negotiate these
extensions and hook the interrupt handling on both sides to the simulation
calendar, the latter of which is necessary anyway.

Hopefully I've managed to explain what I'm trying to do here, questions or
suggestions are always welcome :-)

johannes

[1] http://www.ikr.uni-stuttgart.de/INDSimLib/
[2] https://patchwork.ozlabs.org/patch/1140033/
[3] http://www.ikr.uni-stuttgart.de/Content/Publications/Archive/We_SIMUTools_2014_40209.pdf
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=065038706f77a56754e8f0c2556dab7e22dfe577
[5] I've extracted them from their sources as a diff against QEMU v1.6.0:
    https://p.sipsolutions.net/af9a68ded948c07e.txt
[6] which I'm currently planning to implement using a separate virtio device
    with an appropriate driver that hooks into low-level UML things


