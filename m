Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84403C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5548B20578
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5548B20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCPdx-0001G7-GH
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 10:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iCPcH-0000Iv-HX
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iCPcF-0000fB-UO
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:47:05 -0400
Received: from 18.mo4.mail-out.ovh.net ([188.165.54.143]:36538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iCPcF-0000eh-Mm
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:47:03 -0400
Received: from player168.ha.ovh.net (unknown [10.109.143.223])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 422B42081B3
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 16:47:01 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player168.ha.ovh.net (Postfix) with ESMTPSA id 0EFE5A0769B1;
 Mon, 23 Sep 2019 14:46:55 +0000 (UTC)
Date: Mon, 23 Sep 2019 16:46:53 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/3] 9p: Fix file ID collisions
Message-ID: <20190923164653.5b79797a@bahia.lan>
In-Reply-To: <2537302.ZFCiNNprIf@silver>
References: <cover.1567680121.git.qemu_oss@crudebyte.com>
 <2376196.qMJLftDnS9@silver> <20190923145611.7ca240e8@bahia.lan>
 <2537302.ZFCiNNprIf@silver>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15772731796117363008
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdekgdejlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.54.143
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

On Mon, 23 Sep 2019 16:06:13 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Montag, 23. September 2019 14:56:11 CEST Greg Kurz wrote:
> > On Mon, 23 Sep 2019 11:50:46 +0200
> > 
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > On Freitag, 13. September 2019 19:01:57 CEST Greg Kurz wrote:
> > > > So I did some changes in 1/3 and pushed everything to 9p-next.
> > > 
> > > I've reviewed your changes. Some notes:
> > > 
> > > Patch 1:
> > > https://github.com/gkurz/qemu/commit/9295011c5a961603959b966c8aa6ad9840fe6
> > > db2> 
> > > * Typo 1:
> > > 	error_append_hint(&local_err, "Valide options are: multidevs="
> > > 	
> > > 	Valide -> Valid
> > > 
> > > * Typo 2 in log comment:
> > > 	[groug: - Moved "multidevs" parsing the local backend.
> > > 	->
> > > 	[groug: - Moved "multidevs" parsing to the local backend.
> > 
> > Fixed.
> 
> Thanks! Saw it, looks fine now.
> 
> > > > I'll do some
> > > > more manual testing and issue a PR when I'm confident enough.
> > > 
> > > That would be highly appreciated! So far I am the only one ever having
> > > tested this patch set at all!
> > 
> > Just to clarify, I won't thoroughly test it. My main concern is that it
> > doesn't break things. 
> 
> So in other words you are only going to test the default behaviour
> --multidevs=warn?
> 

This I've already done, along with multidevs=forbid.

Now I plan to run the PJD test suite from Tuxera with a simple
cross-device setup and --multidevs=remap. And that's it.

> If yes, and since that would mean I was the only person ever having tested the 
> actual fix, shouldn't --multidevs=remap|forbid better be marked as 
> experimental (docs and runtime warning) for now? Maybe that would also 
> anticipate receiving feedback from people actually using it later on.
> 

Makes sense. I don't think it is worth having a runtime warning,
but I'll turn remap to x-remap and amend the docs.

> > I usually rely on this:
> > 
> > https://www.tuxera.com/community/posix-test-suite/
> 
> Well, that website is far from being too verbose of what that test suite 
> actually encompasses.
> 

Yeah... this does a variety of tests I've never had time to
audit, but it exercices many paths of the 9pfs code.

> > > > It would be nice to have some sort of automated test for that in 'make
> > > > check'. My first thought is to simulate a cross-device setup with the
> > > > synth
> > > > backend, because it might be difficult to do this on a real filesystem
> > > > without requiring elevated privileges.
> > > 
> > > Hmm, since I neither haven't used the synth backend before, nor added qemu
> > > test cases so far, I am yet missing the complete picture here. My initial
> > > suggested approach would have been using loopback devices for simulating
> > > two file systems, but yes that's probably not viable due to required
> > > permissions. How would the synth backend help here? I mean you would need
> > > to simulate specific inode numbers and device numbers in some way for the
> > > test cases.
> > The synth backend allows to simulate anything you want, provided you
> > code it of course :)
> > 
> > It is currently used to run some 9p protocol conformance tests. Have a
> > look at the backend code to get the idea.
> > 
> > hw/9pfs/9p-synth.h
> > hw/9pfs/9p-synth.c
> > 
> > and the test program:
> > 
> > tests/virtio-9p-test.c
> > 
> > It currently doesn't care for st_dev/st_ino at all, but I guess
> > it shouldn't be that hard to add the necessary bits.
> 
> I see. Well, I will look at it, but that will definitely not be one of my 
> current high priority tasks that would happen in the next few weeks (simply 
> due to my work load).
> 

Same here :)

