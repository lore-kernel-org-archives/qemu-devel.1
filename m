Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A01C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:18:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA47E20673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA47E20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHldc-00076h-Sp
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 05:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iHlaL-0004od-0U
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iHlaJ-0006Di-6g
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:15:12 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:48668)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iHlaJ-0006Ak-01
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:15:11 -0400
Received: from player692.ha.ovh.net (unknown [10.108.54.97])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 29B4C6BD13
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 11:15:07 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player692.ha.ovh.net (Postfix) with ESMTPSA id 24905A923CBF;
 Tue,  8 Oct 2019 09:15:01 +0000 (UTC)
Date: Tue, 8 Oct 2019 11:14:59 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/3] 9p: Fix file ID collisions
Message-ID: <20191008111459.048e659f@bahia.lan>
In-Reply-To: <1590425.yRI6RxI3rl@silver>
References: <cover.1567680121.git.qemu_oss@crudebyte.com>
 <7439377.rdf1oF7g69@silver> <20190923185012.06131248@bahia.lan>
 <1590425.yRI6RxI3rl@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 6024408926595815744
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrheelgdduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.73.241
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Antonios Motakis <antonios.motakis@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Sep 2019 11:31:06 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Montag, 23. September 2019 18:50:12 CEST Greg Kurz wrote:
> > > > > If yes, and since that would mean I was the only person ever having
> > > > > tested
> > > > > the actual fix, shouldn't --multidevs=remap|forbid better be marked as
> > > > > experimental (docs and runtime warning) for now? Maybe that would also
> > > > > anticipate receiving feedback from people actually using it later on.
> > > > 
> > > > Makes sense. I don't think it is worth having a runtime warning,
> > > > but I'll turn remap to x-remap and amend the docs.
> > > 
> > > Mwa, I would like to veto against your "x-remap" plan though. Keep in mind
> > > I also have to send out a patch for libvirt for this fix. Even I would
> > > not have read "x" to stand for "experimental". So I would definitely
> > > favor a runtime warning instead of renaming that parameter.
> > 
> > Hmmm... I don't see the point in adding a warning for a feature that
> > is only active if the user explicitly asks for it. 
> 
> Because many people might be using this option without ever reading the docs, 
> e.g. because of being suggested by copy & paste tutorials or any stack*.com 
> forum.
> 
> > And, anyway, this
> > still is an experimental feature, right ? 
> 
> No, it is not a feature. It is still a fix. :) I cannot use 9p without this 
> fix at all, so it is not some optional "feature" for me.
> 

I understand your need but this is still arguable. The 9p device has
a limitation with cross-device setups. The actual bug is to silently
cause inode number collisions in the guest. This is partly fixed by the
"9p: Treat multiple devices on one export as an error" patch. Thinking
again, it would even make sense to move "remap" from "9p: Added virtfs
option 'multidevs=remap|forbid|warn'" to its own patch. We could then
consider that the bug is fully fixed with "multidevs=forbid|warn".

Then comes the "remap" feature which is expected to lift the limitation
with cross-device setups, with a "not yet determined" performance cost
and light reviewing of the code.

> x-remap would just make things unnecessarily more complicated without adding 
> anything useful.
> 

Not really. This gives a crucial information to the user about the
level of confidence we have in this feature.

> A warning/info log could be used to motivate people providing feedback and 
> make them clearly aware about their current version still being an 
> experimental fix in their specific qemu version. That warning/info is just a 
> one line change that can easily be dropped at some point in future after this 
> qid fix proofed to be reliable (i.e. from users' feedback and test cases).
> 

The overwhelming majority of feedbacks I had on 9p the last few years
are CVEs. Antonios and you are the only users who ever seemed to care
for cross-device setups. So I don't expect much feedback on that area
and I don't buy the "motivate people" argument, especially since "remap"
won't be the default.

> > Not sure it is time to have
> > libvirt to support it yet.
> 
> Most people are using libvirt xml configs instead of calling qemu directly 
> with command line options. So of course I will suggest a libvirt patch as soon 
> as this patch set is pulled on qemu side.
> 

Yes and before a feature has a chance to be officially supported
in libvirt, people usually rely on the <qemu:commandline> domain
XML tag to pass extra arguments to QEMU.

https://blog.vmsplice.net/2011/04/how-to-pass-qemu-command-line-options.html

With the current fsdev implementation, we can only pass properties
to the -fsdev command line option. So this would require to not
use the <filesystem type='mount'> XML tag and manually _open-code_
the needed QEMU arguments:

<qemu:commandline>
  <qemu:arg value='-fsdev'/>
  <qemu:arg value='local,id=fsdev0,path=/var/tmp/virtfs,security_model=passthrough,multidevs=remap'/>
  <qemu:arg value='-device'/>
  <qemu:arg value='virtio-9p,id=virtio-9p0,mount_tag=host,fsdev=fsdev0'/>
</qemu:commandline>

And if fsdev is converted to be a proper QEMU device, it would as
easy as:

<qemu:commandline>
  <qemu:arg value='-set'/>
  <qemu:arg value='device.fsdev0.multidevs=remap'/>
</qemu:commandline>

This is unrelated but it would also allow to drop a lot
of code in fsdev that mimics what qdev would give us
for free. :)

> 
> 

Also, I strongly recommend you try out "virtio-fs" which is
going to be soon the production grade way of sharing files
between host and guest.

https://www.mail-archive.com/libvir-list@redhat.com/msg182457.html

Cheers,

--
Greg

