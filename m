Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1102C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72DB620879
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72DB620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35019 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTmXl-0002Hh-Ld
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 08:09:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTmWy-00020e-UO
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTmWx-00009p-HH
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:09:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hTmWx-00008q-Al
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:09:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76E97C0A4F6F;
	Thu, 23 May 2019 12:08:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 027BA67C9B;
	Thu, 23 May 2019 12:08:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 314EB1138648; Thu, 23 May 2019 14:08:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190514171545.24961-1-peter.maydell@linaro.org>
	<878sv7yn6t.fsf@dusky.pond.sub.org>
	<CAFEAcA9O4YUFa1X+TqJLGD2M3mPXwhv3WwL2thOk-aeezEaoaQ@mail.gmail.com>
	<f972c27e-de17-2d96-04d9-bec421c78384@greensocs.com>
	<87imu3swp2.fsf@dusky.pond.sub.org>
	<CAFEAcA_LFdwYX0Lp8Z=ecgJKC18F7i51nUjOT7YY+CQBaH_tTg@mail.gmail.com>
	<87ef4pisja.fsf@dusky.pond.sub.org>
	<CAFEAcA-8CZT2-sNBDEJdKv7PB-b1usNgbqo0O9QofYApvR-=pQ@mail.gmail.com>
Date: Thu, 23 May 2019 14:08:54 +0200
In-Reply-To: <CAFEAcA-8CZT2-sNBDEJdKv7PB-b1usNgbqo0O9QofYApvR-=pQ@mail.gmail.com>
	(Peter Maydell's message of "Thu, 23 May 2019 09:54:17 +0100")
Message-ID: <874l5lnzjd.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Thu, 23 May 2019 12:09:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] hw/core/bus.c: Only the main system bus can
 have no parent
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Damien Hedde <damien.hedde@greensocs.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 23 May 2019 at 07:39, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > It's a well-defined order, but it doesn't actually help in a
>> > lot of cases, because often the thing you care about ordering
>> > on is not a device or is not in the same tree as the thing
>> > it depends on.
>>
>> Dependencies need some kind of connection.
>>
>> In the physical world, connections are a scarce resource.  This leads to
>> somewhat regular dependencies.  Reset order follows wiring.  The wiring
>> isn't always a tree, but it's tree-like enough to make trees a useful
>> concept there.
>
> I would say rather than in the physical world reset tends
> to happen in parallel -- somebody pulls a reset line high
> and everything connected to it simultaneously goes into a
> state where it resets its internal state, and stays there.

Yes.  Can be viewed as a tree of depth 1.  Parallel doesn't contradict
tree.

> Things like "don't read PC before memory is initialized" tend
> to be handled by "memory is initialized while the CPU is being
> held in reset, and then the CPU only reads it when it *leaves*
> the reset state". (So the suggested multi-phasing does try
> to make our emulation match the real hardware).

No argument.

> There is also some 'tree-like' behaviour in that where a
> collection of devices can all be reset at once this is usually
> based on the "composition tree", eg if you reset an SoC then
> it's resetting all the devices in the SoC. Unfortunately QEMU's
> qbus tree does not at all match this "composition tree". Our
> QOM object tree gets closer, but I have no idea how you might
> get from the qbus-reset world we have today to a world where
> reset propagated down the QOM object tree.

Supports the idea that inadequate device modelling contributes to the
problem.

One of the stated reasons for the invention of QOM was better device
modelling.  Sadly, we've done that only in a few corners.  There's too
much left of qdev's oversimplified design.  Or maybe too little left of
qdev's initial simplicity.  We're not exactly in a happy place there,
I'm afraid.

>> >> hw/input/pckbd.c is instructive.  The qemu_register_reset() in
>> >> i8042_mm_init() is inded for a non-qdevified device.  The one in
>> >> i8042_realizefn() has no such excuse.
>> >>
>> >> Does not contradict what you wrote, of course.  Still, shouldn't we at
>> >> least get rid of the latter kind?
>> >
>> > Yes, absolutely. Also we should qdevify the non-qdev devices.
>> > This part is something where we have a clear path forwards
>> > for making cleanups (no tricky design decisions/debate required),
>> > it just requires somebody to write the actual code.
>>
>> After all these years, the transition to qdev is still incomplete, and
>> the incompleteness still bogs us down.
>>
>> We don't even know what still needs to be converted.  If we had a list
>> of such device models, and which machines depend on them, we could apply
>> a bit more force to the problem.
>
> In this case we *do* have a clear list of things to fix:
> we just need to search for places that are directly calling
> qemu_register_reset() (and weed out the handful of "no, really
> not a device" false positives). I think that this is actually
> the case for most situations where failure-to-qdevify is a
> blocker -- it's a blocker because there's a particular API we
> want to get rid of or clean up or whatever, and then we just
> need to look for uses of the API. If there happen to be non-qdev
> devices which (perhaps buggily) don't use the API, we don't
> need to care about them because they don't block us from the cleanup.

Fair enough.

>> >> I'm afraid *any* improvement will have an impact on reset ordering.
>> >> Most reorderings will be just fine.  How terrible could the
>> >> less-than-fine ones be?
>> >
>> > If you get "CPU reset" and "built in bootloader sets the PC to the
>> > initial address specified by the -kernel file" the wrong way around
>> > then we break booting :-)
>>
>> Wonderfully unsubtle failure!  Even the stupidest of smoke tests should
>> catch it.
>>
>> Would you be willing to hazard a guess on the risk of creating bugs
>> subtle enough to survive basic smoke tests?
>
> Probably quite high, given that we don't have very good test
> coverage even for 'basic smoke tests', and we certainly don't
> have a smoke test that covers every device model. Which doesn't
> mean we should be afraid of touching reset ordering entirely:
> it just means that for this particular patch I wanted to
> play safe, because "remove a TODO comment" doesn't seem like a
> solid enough payoff for running the risk.

Makes sense.

Registering qbus_reset_all_fn() in main() is kind of ugly, but it works.
There's a comment pointing out it's ugly.  Right now it's a TODO
comment, which maybe expresses more hope for cleanup than there really
is.  I'd leave it alone anyway.

