Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D76C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:28:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68DC20674
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="EKglWLYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68DC20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrQPx-0001Zc-TQ
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 14:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jrQPI-0000vf-NI
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 14:27:30 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:56421)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jrQPF-00036f-04
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 14:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=YgAd8RQyxDfW316Opml0shrGAhsfhj/EMueKQhboGUM=; b=EKglWLYu53KiyjRd1Oq+N4Cx6Z
 3xIKKtJVNHhcYHtM8cKYVMVKR8p6FVadwPp2lOR6Aa96rJpfqWLgpwnzzx/TU3+kvDzAPlUiSg8U8
 p4uE136OxFoTBRXWQ7rk0hp8cpPj0qO7h9WfTBlOIWFh7ghg0p8v3yFswJq6b9sFEpyjOCaB1dCmJ
 ViKK0re4utnx2z04BiDnIqqZRkUq6xqw41A2mDPSNjbI1nGCInpL28CX/QK58M9Eg1I/XFENXgBqD
 iV+hDMt3sKPbGJ4sOKo4P6/KWJKdByO9dUgPz4KjoLefyUs3ZAkqDKFDUmFQwqTy3+krV/3vip5M/
 MvXyOkCOoiiEtN1IzpnAKa7fHaZpMVlXCf6NSeRpJR6ARd6Hbm9T8Kgo7FUaZnyRuo+4CZ4GmGCVn
 rtVKrWpoQsUlxXQK46mt8+jDzShY882Wywkt0FrZBBGtTp/SpTQckonZ49AlpZeDGWQns0NCC6gPJ
 eXKby7NRxs1/HisHpwOBaN9yz6/LbrPucafoqgJuovBr+0gfVXUrIZY4Bx4hO0d6zlo8w1ZZVtvyH
 4mM/yMxeIXUvfRkiHBk8s6UGN7tZQWCijEndTtO4wfW9/tUDipnms+3PzJl1o+KWoWDF7KnL02IAf
 b4w/GqXCOzogeXTJIqP7SX4JYnDLEfo3V0wyEFruE=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v6 4/5] 9pfs: T_readdir latency optimization
Date: Fri, 03 Jul 2020 20:27:20 +0200
Message-ID: <2242974.z7sRGHuNfS@silver>
In-Reply-To: <20200703180821.0416ebe8@bahia.lan>
References: <cover.1587309014.git.qemu_oss@crudebyte.com>
 <2036889.5PXCEd79iF@silver> <20200703180821.0416ebe8@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 14:12:42
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

On Freitag, 3. Juli 2020 18:08:21 CEST Greg Kurz wrote:
> On Fri, 03 Jul 2020 10:08:09 +0200
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > On Donnerstag, 2. Juli 2020 19:23:35 CEST Christian Schoenebeck wrote:
> > > > > Back to the actual topic: so what do we do about the mutex then?
> > > > > CoMutex
> > > > > for 9p2000.u and Mutex for 9p2000.L? I know you find that ugly, but
> > > > > it
> > > > > would just be a transitional measure.
> > > > 
> > > > That would ruin my day...
> > > > 
> > > > More seriously, the recent fix for a deadlock condition that was
> > > > present
> > > > for years proves that nobody seems to be using silly clients with
> > > > QEMU.
> > > > So I think we should just dump the lock and add a one-time warning in
> > > > the top level handlers when we detect a duplicate readdir request on
> > > > the same fid. This should be a very simple patch (I can take care of
> > > > it right away).
> > > 
> > > Looks like we have a consensus! Then I wait for your patch removing the
> > > lock, and for your feedback whether or not you see anything else in this
> > > patch set?
> > 
> > Please wait before you work on this patch. I really do think your patch
> > should be based on/after this optimization patch for one reason: if (and
> > even though it's a big if) somebody comes along with a silly client as
> > you named it, then your patch can simply be reverted, which would not be
> > possible if it's next.
> > 
> > So I would really suggest I change this patch here to go the ugly way with
> > 2 mutex types for readdir 9p2000.L vs 9p2000.L, and your patch would get
> > rid of that mess by removing the lock entirely, okay?
> 
> If someones ever comes along with a silly client, she will get warnings
> explaining that she might get silly results. If it turns out that we
> really need to support that for valid reasons, it will be okay to focus
> on the appropriate fix when the time comes, not now. So I don't say any
> real benefit to postponing the removal of the lock after your series, but
> I do at least see one benefit, it will reduce the level of noise.

Reasons:

1. Less work for me, as I would have more conflicts to resolve manually if
   your patch would come next.

2. The dual mutex change is just like 3 lines of code more -> trivial (and my 
   problem)

3. If somebody complains, I just have to revert your patch.

4. For you, it does neither mean more time nor more efforts, as you haven't 
   started to write the patch yet.

5. The actual outcome from your side is the same: you get what you want, the
   lock will be gone entirely after all anyway.

and most notably:

6. I don't see any advantage if your patch would come next.

Best regards,
Christian Schoenebeck



