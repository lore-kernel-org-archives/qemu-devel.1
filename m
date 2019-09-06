Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524BEC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 15:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2908320838
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 15:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2908320838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6GH2-0003fM-6m
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 11:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1i6GDa-0000qk-4R
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1i6GDX-0004nR-OZ
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:32:09 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:50232
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1i6GDX-0004l9-9X
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:32:07 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.92.1) (envelope-from <johannes@sipsolutions.net>)
 id 1i6GDT-0005ke-OZ; Fri, 06 Sep 2019 17:32:03 +0200
Message-ID: <fe0f3f7bfa730088454790dc2d863285c4461134.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Date: Fri, 06 Sep 2019 17:32:02 +0200
In-Reply-To: <20190906110340-mutt-send-email-mst@kernel.org>
References: <20190902121233.13382-1-johannes@sipsolutions.net>
 <20190906121350.29202-1-johannes@sipsolutions.net>
 <20190906102217-mutt-send-email-mst@kernel.org>
 <be405c3ba658cdac7f68c91213c3b714ac24c1e3.camel@sipsolutions.net>
 <20190906110340-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: Re: [Qemu-devel] [RFC] libvhost-user: implement
 VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS
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

Hi,

> Oh. Apparently qemu mailman chose this time to kick me out
> of list subscription (too many bounces or something?)
> so I didn't see it.

D'oh. Well, it's really my mistake, I should've CC'ed you.

> What worries me is the load this places on the socket.
> ATM if socket buffer is full qemu locks up, so we
> need to be careful not to send too many messages.

Right, sure. I really don't think you ever want to use this extension in
a "normal VM" use case. :-)

I think the only use for this extension would be for simulation
purposes, and even then only combined with the REPLY_ACK and SLAVE_REQ
extensions, i.e. you explicitly *want* your virtual machine to lock up /
wait for a response to the KICK command (and respectively, the device to
wait for a response to the CALL command).

Note that this is basically its sole purpose: ensuring exactly this
synchronisation! Yes, it's bad for speed, but it's needed in simulation
when time isn't "real".

Let me try to explain again, most likely my previous explanation was too
long winded. WLOG, I'll focus on the "kick" use case, the "call" is the
same, just the other way around. I'm sure you know that the call is
asynchronous, i.e. the VM will increment the eventfd counter, and
"eventually" it becomes readable to the device. Now the device does
something (as fast as it can, presumably) and returns the buffer to the
VM.

Now, imagine you're running in simulation time, i.e. "time travel" mode.
Briefly, this hacks the idle loop of the (UML) VM to just skip forward
when there's nothing to do, i.e. if you have a timer firing in 100ms and
get to idle, time is immediately incremented by 100ms and the timer
fires. For a single VM/device this is already implemented in UML, and
while it's already very useful that's only half the story to me.

Once you have multiple devices and/or VMs, you basically have to keep a
"simulation calendar" where each participant (VM/device) can put an
entry, and then whenever they become idle they don't immediately move
time forward, but instead ask the calendar what's next, and the calendar
determines who runs.

Now, for these simulation cases, consider vhost-user again. It's
absolutely necessary that the calendar is updated all the time, and the
asynchronous nature of the call breaks that - the device cannot update
the calendar to put an event there to process the call message.

With this extension, the device would work in the following way. Assume
that the device is idle, and waiting for the simulation calendar to tell
it to run. Now,

 1) it has an incoming call (message) from VM (which waits for reply)
 2) the device will now put a new event on the simulation scheduler for
    a time slot to process the message
 3) return reply to VM
 4) device goes back to sleep - this stuff was asynchronously handled
    outside of the simulation basically.

In a sense, the code that just ran isn't considered part of the
simulated device, it's just the transport protocol and part of the
simulation environment.

At this point, the device is still waiting for its calendar event to be
triggered, but now it has a new one to process the message. Now, once
the VM goes to sleep, the scheduler will check the calendar and
presumably tell the device to run, which runs and processes the message.
This repeats for as long as the simulation runs, going both ways (or
multiple ways if there are more than 2 participants).


Now, what if you didn't have this synchronisation, ie. we don't have
this extension or we don't have REPLY_ACK or whatnot?

In that case, after the step 1 above, the VM will immediately continue
running. Let's say it'll wait for a response from the device for a few
hundred milliseconds (of now simulated time). However, depending on the
scheduling, the device has quite likely not yet put the new event on the
simulation calendar (that happens in step 2 above). This means that the
VM's calendar event to wake it up after a few hundred milliseconds will
immediately trigger, and the simulation ends with the driver getting a
timeout from the device.


So - yes, while I understand your concern, I basically think this is not
something anyone will want to use outside of such simulations. OTOH,
there are various use cases (I'm doing device simulation, others are
doing network simulation) that use such a behaviour, and it might be
nice to support it in a more standard way, rather than everyone having
their own local hacks for everything, like e.g. the VMSimInt paper(**).


But again, like I said, no hard feelings if you think such simulation
has no place in upstream vhost-user.


(**) I put a copy of their qemu changes on top of 1.6.0 here:
     https://p.sipsolutions.net/af9a68ded948c07e.txt

johannes


