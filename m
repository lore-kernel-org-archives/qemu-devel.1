Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48DEC76196
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 12:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD3720873
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 12:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD3720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoS8O-0007WI-V8
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 08:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51447)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hoS8D-00077S-3S
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 08:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hoS8B-0004SX-9J
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 08:37:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42148)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hoS8B-0004Q8-3t
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 08:36:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9BE0530C1352;
 Fri, 19 Jul 2019 12:36:55 +0000 (UTC)
Received: from work-vm (ovpn-117-245.ams2.redhat.com [10.36.117.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B331117F88;
 Fri, 19 Jul 2019 12:36:54 +0000 (UTC)
Date: Fri, 19 Jul 2019 13:36:52 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, pbonzini@redhat.com
Message-ID: <20190719123652.GA3000@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 19 Jul 2019 12:36:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] -rtc base=, migration and time jumps
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
Cc: jan.kiszka@siemens.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,
  I've just spent an unreasonable amount of time debugging
an rtc issue and come to the conclusion it's probably more
of a documentation problem than actual code - but I wondered if
anyone disagrees.

(ref: https://bugzilla.redhat.com/show_bug.cgi?id=1714143 )

The question revolves around -rtc base=    and what the base=
passed to a destination qemu after migration should be.
(partcicularly with 'host' clock)

At startup, QEMU (vl.c) calculates offsets from the host clock
to the base - that value isn't migrated.

Most rtc calculations done afterwards don't reference it - they're
all based on the time since we last read the clock and a rolling time
since then.

There's code to detect host clock jumps, and trigger a notifier
- the only use of that is the mc146818rtc used on the x86.
It then reuses the base offset to reset the rtc to the current host
clock time.

a) If you start a destination qemu with the same base= value
as the source then the internal offset value will be different
by how much later you started the destination.

b) If you can trigger the host clock jump update, then on x86
that difference from (a) will become visible in reading the rtc
(hwclock) and thus the rtc will appear to have fallen behind.

c) libvirt (when using an 'adjustment' as oVirt does) recalculates
the base on the destination; so the base passed to the destination
qemu is different from the source; so even when (b) happens
you get a consistent value.  This may be an accident!

d) The host clock jump detection (b) is broken - it correctly detects
backwards jumps; but it's detection of a forward jump is based
on two readings of the host clock being more than 60s apart - but
often ona q emu running a Linux guest the host clock isn't read at all;
so reading hwclock, waiting a minute and reading it again will trigger
the jump code.

So what to do?

1) Tell people to do what libvirt does and specify base= differently
on the dest.

2) Migrate the offset value such that the base= on the destination
is ignored

3) Fix the host clock jump detection

(3) is probably independent - the easiest fix would seem to be just
to set a timer to read the host clock at say 20 second intervals
which is wasteful but would avoid the false trigger.

Is (2) worth it or do we just go with (1) - I'm tempted to just
specify the behaviour.

Mind you, we could kill the host clock jump detection code - only
the mc148618 registers on the notifier for it - so presumably
aarch/ppc/s390 etc dont see it.

Thoughts?

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

