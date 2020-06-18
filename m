Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4F1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A0D20884
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="suPTZ0Eg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A0D20884
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jluwd-00050e-BO
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 09:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jluu2-0002rr-A4; Thu, 18 Jun 2020 09:48:26 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:47691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jlutz-0002Zz-Tm; Thu, 18 Jun 2020 09:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=vmWxMloFkb6xrDsKeRM+49TELXO3PtnDi6v83hBbVAs=; b=suPTZ0EgGnCegn6tA/bNngKrFh
 dMEx4J7TChSZG4aE3z/oMyNcEO6qiTwL4C4w3C4j0NiEtaZLik0cJlElS/uXJJ1dzEn2qUDG9KA4b
 WR8qCCLBeRndgq7tZkKcdO2oRTgHZQ5geU4Ng37stIDAyhiJHj5GsLCuaJVJLnzglK7tbh7YgwLh/
 IjVP9aZJo03cKEhYQf+RzXtaX9XgPA0Bk3dWohJkoeCOZLn5F8bvb3ZK1feshqwMCYst3PRhxnGJW
 BKcLrowOhxHtHhb1BE9hBJF8oDFDeTfImkk8QoidwnO0HNTeK5gA1QtI1dgsfWSku7Dn5Uzsvl7AS
 7mEa3ufn80Gd83u8pdRF4PVfigK9DIYWCCsRr+8JKteubvGskP9aZvsjwHQIXOWx2uQWfsweB/Lvy
 gWZg7WtENaUoyKP5nhZJ2q6H5YaRdjJ2YiM3n6DlAtYhY97wlQNOhzEDuZDtEvwhD620cV3q6sG7q
 mA6Vb10VEDR2CxNVR0k4u+dnnCq496F1/htvf7H06hcscinbQ2InHEVcY3OuxpJznrlD2fNEzF6mY
 Vl/PFreqHDauXbBecue2uG9q2XGPgGUP47CxWb8i72+p4LSUZt+Z+hShs2hKGoe+tuzA7sTF+fUyb
 sdKkBufx7hKUkRuXVBwP2CrINrS9E2lrJ92VOVPGE=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 72/78] 9p: Lock directory streams with a CoMutex
Date: Thu, 18 Jun 2020 15:47:50 +0200
Message-ID: <2870690.GaQWCNxEGh@silver>
In-Reply-To: <159234758691.15440.17375965710878676458@sif>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
 <20200616184136.27463d2e@bahia.lan>
 <159234758691.15440.17375965710878676458@sif>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 09:48:14
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mittwoch, 17. Juni 2020 00:46:26 CEST Michael Roth wrote:
> > > Indeed, for that particular stable branch I would see the following 9p
> > > fixes as additional candidates (chronologically top down):
> > > 
> > > 841b8d099c [trivial] 9pfs: local: Fix possible memory leak in
> > > local_link()
> > > 846cf408a4 [maybe] 9p: local: always return -1 on error in
> > > local_unlinkat_common 9580d60e66 [maybe] virtio-9p-device: fix memleak
> > > in virtio_9p_device_unrealize 659f195328 [trivial] 9p/proxy: Fix
> > > export_flags
> > > a5804fcf7b [maybe] 9pfs: local: ignore O_NOATIME if we don't have
> > > permissions 03556ea920 [trivial] 9pfs: include linux/limits.h for
> > > XATTR_SIZE_MAX a4c4d46272 [recommended] xen/9pfs: yield when there
> > > isn't enough room on the ring
> > > 
> > > What do you think Greg?
> > 
> > AFAIK, only regressions and fixes to severe bugs (QEMU crashes, hangs,
> > CVEs) go to stable QEMU releases. It doesn't seem to be the case for any
> > of the commits listed above but I had only a quick look.
> 
> That's the main focus, but if memory leaks and other minor fixes get tagged
> for stable I'll generally pull those in as well if the backport is fairly
> straightforward. As that was the case with the patches above I went
> ahead and pull those in.
> 
> > > What's the recommended way for me to keep track of imminent stable
> > > picks/
> > > freezes in future?
> > 
> > Hmm good question. I'm usually notified when Michael posts the patch
> > round-up and a 9p patch is already in the list, like for the present
> > patch. Other than that I watch qemu-stable from time to time or the
> > planning pages in the wiki.
> > 
> > Michael, anything better to suggest to Christian ?
> 
> I think that about covers it. You can also subscribe to the planning
> pages, e.g. https://wiki.qemu.org/Planning/5.0 (by clicking the
> star/"add to watchlist" icon), then you'll get notifications when
> additional release/freeze dates are added. Generally it will be updated
> shortly before the patch round-up gets posted to qemu-stable.

Good idea! Will do that.

Thanks Michael!

Best regards,
Christian Schoenebeck



