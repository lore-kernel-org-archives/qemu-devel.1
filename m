Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407D9C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14EAB205F4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EAB205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHqrT-0006IQ-T2
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 10:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iHqkD-00019L-KY
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:45:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iHqkC-0002TF-4I
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:45:45 -0400
Received: from 2.mo4.mail-out.ovh.net ([46.105.72.36]:58206)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iHqkB-0002Rp-Rt
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:45:44 -0400
Received: from player690.ha.ovh.net (unknown [10.108.57.50])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 84D152081CA
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 16:45:41 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player690.ha.ovh.net (Postfix) with ESMTPSA id 3C75EA9ADE3F;
 Tue,  8 Oct 2019 14:45:34 +0000 (UTC)
Date: Tue, 8 Oct 2019 16:45:31 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/3] 9p: Fix file ID collisions
Message-ID: <20191008164531.25b359de@bahia.lan>
In-Reply-To: <30797240.IXYi3n4lAo@silver>
References: <cover.1567680121.git.qemu_oss@crudebyte.com>
 <2456208.kOTvEbKLdM@silver> <20191008154729.5b16ef26@bahia.lan>
 <30797240.IXYi3n4lAo@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11607183616548903232
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrheelgdekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.72.36
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

On Tue, 08 Oct 2019 16:25:48 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Dienstag, 8. Oktober 2019 15:47:29 CEST Greg Kurz wrote:
> > On Tue, 08 Oct 2019 14:05:28 +0200
> > 
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > On Dienstag, 8. Oktober 2019 11:14:59 CEST Greg Kurz wrote:
> > > > > No, it is not a feature. It is still a fix. :) I cannot use 9p without
> > > > > this
> > > > > fix at all, so it is not some optional "feature" for me.
> > > > 
> > > > I understand your need but this is still arguable. The 9p device has
> > > > a limitation with cross-device setups. The actual bug is to silently
> > > > cause inode number collisions in the guest. This is partly fixed by the
> > > > "9p: Treat multiple devices on one export as an error" patch. Thinking
> > > > again, it would even make sense to move "remap" from "9p: Added virtfs
> > > > option 'multidevs=remap|forbid|warn'" to its own patch. We could then
> > > > consider that the bug is fully fixed with "multidevs=forbid|warn".
> > > > 
> > > > Then comes the "remap" feature which is expected to lift the limitation
> > > > with cross-device setups, with a "not yet determined" performance cost
> > > > and light reviewing of the code.
> > > 
> > > Are these patch transfer requests addressed at me to be done?
> > 
> > It would certainly be appreciated :) and if it happens to be done
> > before 2019-10-29, it can even be shipped with QEMU 4.2.
> 
> Just to avoid any misapprehension, since today's comments of yours made me 
> sceptical: that would be
> 
> a) PR for QEMU 4.2 for *all* QID patches up to and including remapping with 
> variable suffix (e.g. as -multidevs=x-remap)?
> 
> or is your current plan rather 
> 
> b) to ship the discussed 9p patches for QEMU 4.2 only up to a certain patch 
> like multidevs=warn|forbid and all subsequent patches "might" then be merged 
> to master somewhere in distant future?
> 

Rather b) but I guess other patches could be merged as soon as the 4.3
development phase begins (mid December), and I'll continue to push patches
to my 9p-next branch during the freeze period anyway.

> Best regards,
> Christian Schoenebeck
> 
> 


