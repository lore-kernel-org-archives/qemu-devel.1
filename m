Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28093C31E44
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 08:20:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAAA21C38
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 08:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAAA21C38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45030 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcmsq-0007ki-0G
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 04:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40838)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <klaus@birkelund.eu>) id 1hcmro-0006zd-PQ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 04:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <klaus@birkelund.eu>) id 1hcmrn-0006OY-BY
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 04:19:52 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46532)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <klaus@birkelund.eu>)
 id 1hcmrk-0006LG-8s; Mon, 17 Jun 2019 04:19:48 -0400
Received: from apples.localdomain (soho-cph.cust-cnex.dsd101.net
 [194.62.216.132])
 by charlie.dont.surf (Postfix) with ESMTPSA id 95277BF602;
 Mon, 17 Jun 2019 08:12:10 +0000 (UTC)
Date: Mon, 17 Jun 2019 10:12:05 +0200
From: Klaus Birkelund <klaus@birkelund.eu>
To: qemu-devel@nongnu.org
Message-ID: <20190617081205.GA26990@apples.localdomain>
Mail-Followup-To: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: [Qemu-devel] [RFC] nvme: how to support multiple namespaces
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
Cc: Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

I'm thinking about how to support multiple namespaces in the NVMe
device. My first idea was to add a "namespaces" property array to the
device that references blockdevs, but as Laszlo writes below, this might
not be the best idea. It also makes it troublesome to add per-namespace
parameters (which is something I will be required to do for other
reasons). Some of you might remember my first attempt at this that
included adding a new block driver (derived from raw) that could be
given certain parameters that would then be stored in the image. But I
understand that this is a no-go, and I can see why.

I guess the optimal way would be such that the parameters was something
like:

   -blockdev raw,node-name=blk_ns1,file.driver=file,file.filename=blk_ns1.img
   -blockdev raw,node-name=blk_ns2,file.driver=file,file.filename=blk_ns2.img
   -device nvme-ns,drive=blk_ns1,ns-specific-options (nsfeat,mc,dlfeat)...
   -device nvme-ns,drive=blk_ns2,...
   -device nvme,...

My question is how to state the parent/child relationship between the
nvme and nvme-ns devices. I've been looking at how ide and virtio does
this, and maybe a "bus" is the right way to go?

Can anyone give any advice as to how to proceed? I have a functioning
patch that adds multiple namespaces, but it uses the "namespaces" array
method and I don't think that is the right approach.

I've copied my initial discussion with Laszlo below.


Cheers,
Klaus


On Wed, Jun 05, 2019 at 07:09:43PM +0200, Laszlo Ersek wrote:
> On 06/05/19 15:44, Klaus Birkelund wrote:
> > On Tue, Jun 04, 2019 at 06:52:38PM +0200, Laszlo Ersek wrote:
> >> Hi Klaus,
> >>
> >> On 06/04/19 14:59, Klaus Birkelund wrote:
> >>> Hi Laszlo,
> >>>
> >>> I'm implementing multiple namespace support for the NVMe device in QEMU
> >>> and I'm not sure how to handle the bootindex property.
> >>>
> >>> Your commit message from a907ec52cc1a provides great insight, but do you
> >>> have any recommendations to how the bootindex property should be
> >>> handled?
> >>>
> >>> Multiple namespaces work by having multiple -blockdevs and then using
> >>> the property array functionality to reference a list of blockdevs from
> >>> the nvme device:
> >>>
> >>>     -device nvme,serial=<serial>,len-namespaces=1,namespace[0]=<drive_id>
> >>>
> >>> A bootindex property would be global to the device. Should it just
> >>> always default to the first namespace? I'm really unsure about how the
> >>> firmware handles it.
> >>>
> >>> Hope you can shed some light on this.
> >>
> >> this is getting quite seriously into QOM and QEMU options, so I
> >> definitely suggest to take this to the list, because I'm not an expert
> >> in all that, at all :)
> >>
> >> Based on a re-reading of the commit (which I have *completely* forgotten
> >> about by now!), and based on your description, my opinion is that
> >> introducing the "namespace" property to the "nvme" device as an array is
> >> a bad fit. Because, as you say, a single device may only take a single
> >> bootindex property. If it suffices to designate at most one namespace
> >> for booting purposes, then I *guess* an extra property can be
> >> introduced, to state *which* namespace the bootindex property should
> >> apply to (and the rest of the namespaces will be ignored for that
> >> purpose). However, if it's necessary to add at least two namespaces to
> >> the boot order, then the namespaces will have to be split to distinct
> >> "-device" options.
> >>
> >> My impression is that the "namespace" property isn't upstream yet; i.e.
> >> it is your work in progress. As a "QOM noob" I would suggest introducing
> >> a new device model, called "nvme-namespace". This could have its own
> >> "bootindex" property. On the "nvme" device model's level, the currently
> >> existing "bootindex" property would become mutually exclusive with the
> >> "nvme" device having "nvme-namespace" child devices. The parent-child
> >> relationship could be expressed from either direction, i.e. either the
> >> "nvme" parent device could reference the children with the "namespace"
> >> array property (it wouldn't refer to <drive_id>s but to the IDs of
> >> "nvme-namespace" devices), or the "nvme-namespace" devices could
> >> reference the parent "nvme" device via a "bus" property or similar.
> >>
> >> The idea is that "bootindex" would have to exist at the nvme-namespace
> >> device model's level, and a parent ("bus") device would have to enforce
> >> various properties, such as no namespace ID duplication and so on.
> >>
> >> I suggest that, if/when you respond to this email, keep all context, and
> >> CC the qemu-devel list at once. (I could have done that myself right
> >> now, but didn't want to, without your permission.)
> >>
> > 
> > Hi Laszlo,
> > 
> > Thank you very much for the feedback!
> > 
> > I have a big patch series for the nvme device which the multiple
> > namespace patch builds on. I'll post the big series tomorrow I hope.
> > Then I'll post the multiple namespaces patch as an RFC and include our
> > discussion here.
> > 
> > I hadn't thought about introducing a separate device model for the
> > namespace. It's way beyond my QOM knowledge, so yeah, hopefully someone
> > on the list have some opinions on this.
> > 
> > 
> > Thanks again!
> 
> My pleasure! I'll attempt to follow the discussion (from a safe distance
> :) ) because I'm curious about the proper device model hierarchy here.
> 
> Regarding OVMF, as long as your QEMU work keeps the *structure* of the
> OpenFirmware device paths intact (and you just compose the NSID and
> EUI-64 values dynamically, in the trailing "unit address" part), OVMF
> should need no change.
> 
> Thanks!
> Laszlo

