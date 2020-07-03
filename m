Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35CDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F4D1206A1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="gVbuN2jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F4D1206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrGki-0000sd-VA
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 04:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jrGk2-00087b-Vr
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 04:08:14 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:49825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jrGk0-0008QZ-Pc
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 04:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=RHQaLG4Z7zMmed9z4wA9PWCPbubTDNt/04iJmZ9stD8=; b=gVbuN2jzjYFae8GPVOQeoSDCwQ
 Kl1n7pIVvq7+mBrr1COdYtjEVp+1517iVysgg5HwKV+mvLTY/aLpKbTNRdc2moo36lw5ou5xyGODI
 RWqyHMV9Wf1ph7Qwye6o8nF7AHyroG8oky4IaayvpcGDqi0UNUTVgqjHAa0aom/cMP831mrSr/p0h
 FG9UIdCGpP8ijTL+QFLQWmS5La1dVps/PwlpvXYyOdwMNrHl7MDmjbyvmH36Gzs/xda5djIYJ5voH
 qmIPF4tSF97XPl7rAIWWtF359dVFMlZhmOmY2STJ+Ndd9Pw5FRMagMvw74u8uHHV3rPoazEh0EGwr
 Fj+cX8QwSpJeW8Md9AZPzBAsPt/K/kvW2lwsHtupfXe9F4Jkk1e01kgcqhBOBGCkDH5Ld08Nq9Qgx
 Eb3n9Rfp/mirAuWvpThyXdgMBoVnhwlUd4y2eXlrFr13QihDn60VpvBCsanhelrCbssrJ25WBaGFQ
 F/pAJGy7cXCuTNkH4aNDXCFza7K3Ui+Wj4vqlr+YW+jfnbrW9Pqk66J+U0p0qeHtHddPjNZs26B28
 u4y7ZRMaqZVybVTdM4Ui8xEWF3Qnc+UJL/GwGDAXsw7RaVkFEDZZDENBcToJM0Y6VGDIJcA8tVx6Y
 EUS1XIl1cIQ+C3hz945dMgVrdTJccxKjl0jkBjJdU=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v6 4/5] 9pfs: T_readdir latency optimization
Date: Fri, 03 Jul 2020 10:08:09 +0200
Message-ID: <2036889.5PXCEd79iF@silver>
In-Reply-To: <5261112.usFQB0EGfy@silver>
References: <cover.1587309014.git.qemu_oss@crudebyte.com>
 <20200702173500.27f2b0a5@bahia.lan> <5261112.usFQB0EGfy@silver>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 04:08:10
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

On Donnerstag, 2. Juli 2020 19:23:35 CEST Christian Schoenebeck wrote:
> > > Back to the actual topic: so what do we do about the mutex then? CoMutex
> > > for 9p2000.u and Mutex for 9p2000.L? I know you find that ugly, but it
> > > would just be a transitional measure.
> > 
> > That would ruin my day...
> > 
> > More seriously, the recent fix for a deadlock condition that was present
> > for years proves that nobody seems to be using silly clients with QEMU.
> > So I think we should just dump the lock and add a one-time warning in
> > the top level handlers when we detect a duplicate readdir request on
> > the same fid. This should be a very simple patch (I can take care of
> > it right away).
> 
> Looks like we have a consensus! Then I wait for your patch removing the
> lock, and for your feedback whether or not you see anything else in this
> patch set?

Please wait before you work on this patch. I really do think your patch should 
be based on/after this optimization patch for one reason: if (and even though 
it's a big if) somebody comes along with a silly client as you named it, then 
your patch can simply be reverted, which would not be possible if it's next.

So I would really suggest I change this patch here to go the ugly way with 2 
mutex types for readdir 9p2000.L vs 9p2000.L, and your patch would get rid of 
that mess by removing the lock entirely, okay?

Best regards,
Christian Schoenebeck



