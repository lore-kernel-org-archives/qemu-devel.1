Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B30C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6983F2086D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6983F2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7NaH-0003bI-KO
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 13:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1i7NYd-0002Gy-5O
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1i7NYb-0006mW-Q9
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:34:30 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:51664
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1i7NYb-0006ky-Js
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:34:29 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>)
 id 1i7NYX-0002j5-Jj; Mon, 09 Sep 2019 19:34:25 +0200
Message-ID: <d095bafedcd4bcc5d76279785e5bd523aef62b58.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 09 Sep 2019 19:34:24 +0200
In-Reply-To: <20190909160039.GC20875@stefanha-x1.localdomain>
References: <20190902121233.13382-1-johannes@sipsolutions.net>
 <20190902121233.13382-2-johannes@sipsolutions.net>
 <fe517ef6c6a8e2df9675388be9454b5863c7fc55.camel@sipsolutions.net>
 <20190909160039.GC20875@stefanha-x1.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: Re: [Qemu-devel] [RFC] docs: vhost-user: add in-band kick/call
 messages
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
Cc: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-09-09 at 18:00 +0200, Stefan Hajnoczi wrote:

> Is this really necessary?  

Yes* :)

> Can the simulation interpose between the
> call/kick eventfds in order to control when events happen?
> 
>   CPU --cpu_kickfd--> Simulation --vhost_kickfd--> vhost-user device
> 
> and:
> 
>   vhost-user device --vhost_callfd--> Simulation -->cpu_callfd-> CPU
> 
> The simluation controls when the CPU's kick is seen by the device and
> also when the call is seen by the CPU.

The point isn't to let the simulation know about anything that happens.
The CPU and the device are *part* of the simulation.

> I don't understand why new vhost-user protocol messages are required.

I guess I haven't really explained it well then :-)

So let's say, WLOG, I have a simulated network and a bunch of Linux
machines that are running on simulation time. Today I can do that only
with user-mode Linux, but we'll see.

Now in order to run everything on simulation time, *everything* that
happens in the simulation needs to request a simulation calendar entry,
and gets told when that entry is scheduled.

So think, for example, you have

CPU ---[kick]---> device

Now, this is essentially triggering an interrupt in the device. However,
the simulation code has to ensure that the simulated device's interrupt
handling only happens at a scheduler entry. Fundamentally, the
simulation serializes all processing, contrary to what you want in a
real system.

Now, this means that the CPU (that's part of the simulation) has to
*wait* for the device to add an entry to the simulation calendar in
response to the kick... That means that it really has to look like

CPU               device                   calendar
     ---[kick]-->
                         ---[add entry]-->
                         <---[return]-----
     <-[return]--

so that the CPU won't get to idle or some other processing where it asks
the simulation calendar for its own next entry...

Yes, like I said before, I realize that all of this is completely
opposed to what you want in a real system, but then in a real system you
also have real timeouts, and don't just skip time forward when the
simulation calendar says so ...


* Now, of course I lied, this is software after all. The *concept* is
necessary, but it's not strictly necessary to do this in-band in the
vhost-user protocol.
We could do an out-of-band simulation socket for the kick signal and
just pretend we're using polling mode as far as the vhost-user protocol
is concerned, but it'd probably be harder to implement, and we couldn't
do it in a way that we could actually contribute anything upstream.
There are quite a few papers proposing such simulation systems, I only
found the VMSimInt one publishing their code, but even that is some
hacks on top of qemu 1.6.0...

johannes


