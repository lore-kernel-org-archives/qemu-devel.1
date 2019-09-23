Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E34C4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E369820882
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E369820882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCRd3-0003os-Oq
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iCRXd-0005mm-Fy
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iCRXc-0000gl-4C
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:50:25 -0400
Received: from 7.mo69.mail-out.ovh.net ([46.105.50.32]:35514)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iCRXb-0000ef-Tm
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:50:24 -0400
Received: from player788.ha.ovh.net (unknown [10.108.54.13])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id DAF7D6A5A0
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 18:50:19 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player788.ha.ovh.net (Postfix) with ESMTPSA id 302E6A1A5679;
 Mon, 23 Sep 2019 16:50:13 +0000 (UTC)
Date: Mon, 23 Sep 2019 18:50:12 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/3] 9p: Fix file ID collisions
Message-ID: <20190923185012.06131248@bahia.lan>
In-Reply-To: <7439377.rdf1oF7g69@silver>
References: <cover.1567680121.git.qemu_oss@crudebyte.com>
 <2537302.ZFCiNNprIf@silver> <20190923164653.5b79797a@bahia.lan>
 <7439377.rdf1oF7g69@silver>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 17855365151793977664
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdekgddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.50.32
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

On Mon, 23 Sep 2019 17:03:23 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Montag, 23. September 2019 16:46:53 CEST Greg Kurz wrote:
> > > > > > I'll do some
> > > > > > more manual testing and issue a PR when I'm confident enough.
> > > > > 
> > > > > That would be highly appreciated! So far I am the only one ever having
> > > > > tested this patch set at all!
> > > > 
> > > > Just to clarify, I won't thoroughly test it. My main concern is that it
> > > > doesn't break things.
> > > 
> > > So in other words you are only going to test the default behaviour
> > > --multidevs=warn?
> > 
> > This I've already done, along with multidevs=forbid.
> > 
> > Now I plan to run the PJD test suite from Tuxera with a simple
> > cross-device setup and --multidevs=remap. And that's it.
> 
> Well, Ok then, however at least some simple, manual, final "ls -i" of the 
> inode numbers on guest would not hurt though. ;-)
> 
> > > If yes, and since that would mean I was the only person ever having tested
> > > the actual fix, shouldn't --multidevs=remap|forbid better be marked as
> > > experimental (docs and runtime warning) for now? Maybe that would also
> > > anticipate receiving feedback from people actually using it later on.
> > Makes sense. I don't think it is worth having a runtime warning,
> > but I'll turn remap to x-remap and amend the docs.
> 
> Mwa, I would like to veto against your "x-remap" plan though. Keep in mind I 
> also have to send out a patch for libvirt for this fix. Even I would not have 
> read "x" to stand for "experimental". So I would definitely favor a runtime 
> warning instead of renaming that parameter.
> 

Hmmm... I don't see the point in adding a warning for a feature that
is only active if the user explicitly asks for it. And, anyway, this
still is an experimental feature, right ? Not sure it is time to have
libvirt to support it yet.

Maybe Daniel can comment on libvirt adoption of new features ?

> I can send a patch on top for docs and warning if you want.
> 
> 


