Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F049C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28ACE2199C
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28ACE2199C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpV0M-0007VA-7s
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 05:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50891)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hpV0C-00076u-DJ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hpV0A-0006qq-9d
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:53:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45110)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hpV09-0006m6-FJ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:53:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A63FA2F8BC3;
 Mon, 22 Jul 2019 09:52:57 +0000 (UTC)
Received: from work-vm (ovpn-117-221.ams2.redhat.com [10.36.117.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A52DA5C221;
 Mon, 22 Jul 2019 09:52:56 +0000 (UTC)
Date: Mon, 22 Jul 2019 10:52:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190722095253.GB3035@work-vm>
References: <20190719123652.GA3000@work-vm>
 <5ee83209-cd46-dded-4d04-0dce1a01fccb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5ee83209-cd46-dded-4d04-0dce1a01fccb@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 22 Jul 2019 09:52:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] -rtc base=, migration and time jumps
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
Cc: jan.kiszka@siemens.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> So here's my understanding:  "-rtc base=3D" says what is the RTC value
> when the guest starts.  This value is only used by qemu_get_timedate,
> and most RTCs only use it on startup or reset.  However, there are
> exceptions (the PC RTC's host clock notifier, the ds1338's set time
> functionality, and all reads of m41t80/m48t59/twl92230) and this causes
> the bug.

Yes, I think so.

> On 19/07/19 14:36, Dr. David Alan Gilbert wrote:
> > d) The host clock jump detection (b) is broken - it correctly detects
> > backwards jumps; but it's detection of a forward jump is based
> > on two readings of the host clock being more than 60s apart - but
> > often ona q emu running a Linux guest the host clock isn't read at all;
> > so reading hwclock, waiting a minute and reading it again will trigger
> > the jump code.
>=20
> Oops.  Back when the detection was added, there were two QEMU_CLOCK_HOST
> timers firing every second so the clock jump detection happened promptly.
>=20
> These timers were then removed as a power-saving optimization, and that
> broke the jump detection.

Ah OK; I'm a bit cautious that perhaps we're still getting some benefit
=66rom them; maybe in snapshots?

> > 1) Tell people to do what libvirt does and specify base=3D differently
> > on the dest.
>=20
> This is racy; the user does not have a good way to know the exact base
> on the destination.

Right.

> > 2) Migrate the offset value such that the base=3D on the destination
> > is ignored
>=20
> At least on some RTCs the offset is already being migrated indirectly.
> For example on x86 the (base_rtc, last_update) pair might be usable to
> reconstruct the offset?

Yes it probably is.

> > 3) Fix the host clock jump detection
> >=20
> > (3) is probably independent - the easiest fix would seem to be just
> > to set a timer to read the host clock at say 20 second intervals
> > which is wasteful but would avoid the false trigger.
> >=20
> > Is (2) worth it or do we just go with (1) - I'm tempted to just
> > specify the behaviour.
> >=20
> > Mind you, we could kill the host clock jump detection code - only
> > the mc148618 registers on the notifier for it - so presumably
> > aarch/ppc/s390 etc dont see it.
>=20
> I would just remove the host clock jump detection code.  IIUC that
> should fix your bug so you don't even need to do the above-mentioned
> reconstruction of the offset (let's call it 2b) in the PC RTC.

OK, I'll do that.

> That still leaves the problem that the base goes out of sync on
> migration on m41t80/m48t59/twl92230.  For that, I think that the
> simplest thing to do would be to fix those to store and migrate the
> offset themselves just like all other RTC implementations.

I'll put those on my TODO - I don't think they're actually used
by any versioned machine so keeping migration compat shouldn't
be an issue.

Dave

> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

