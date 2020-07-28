Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB79C433EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B246420829
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B246420829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0MD9-0005DO-Vy
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 05:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k0MC7-00048F-78
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:46:47 -0400
Received: from 7.mo69.mail-out.ovh.net ([46.105.50.32]:52048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k0MC4-0003vo-P5
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:46:46 -0400
Received: from player794.ha.ovh.net (unknown [10.108.54.203])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id D1D9F99FEC
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 11:46:41 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player794.ha.ovh.net (Postfix) with ESMTPSA id 0ED9811B6564F;
 Tue, 28 Jul 2020 09:46:40 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R003ffe7c47e-e567-4c73-a760-8ca6956bb487,
 96196EA346850768E7E70500A314E772A5EF2CEB) smtp.auth=groug@kaod.org
Date: Tue, 28 Jul 2020 11:46:39 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v7 3/6] 9pfs: add new function v9fs_co_readdir_many()
Message-ID: <20200728114639.478a91e8@bahia.lan>
In-Reply-To: <8722268.CRvGb0V2lm@silver>
References: <cover.1595166227.git.qemu_oss@crudebyte.com>
 <1626524.GXyn7ySoG3@silver> <20200728104600.4552a126@bahia.lan>
 <8722268.CRvGb0V2lm@silver>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 17582334422159300928
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedriedvgddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.50.32; envelope-from=groug@kaod.org;
 helo=7.mo69.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 05:46:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 11:34:12 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Dienstag, 28. Juli 2020 10:46:00 CEST Greg Kurz wrote:
> > > So I'll prepare a v8 with this patch here split into two.
> > > 
> > > But this is it. I don't see another chunk in this patch set that could be
> > > split further down in an useful way.
> > > 
> > > Best regards,
> > > Christian Schoenebeck
> > 
> > You're in charge now so feel free to do that if the development+testing
> > cost is acceptable to you. 
> 
> Yep, that's the plan. This patch set is already thoroughly tested by me, so I 
> would like to avoid major changes for this series now that would require me to 
> restart major testing cycles.
> 
> In this particular case, this patch-split ends up in 100% identical code. So 
> it is really just git history tweaking after all.
> 
> > You already know my take on having smaller
> > patches :)
> 
> A pure desire for something is one thing, the actually available real-life 
> options are another thing. If you see more options than I can identify, you 
> are always invited to make your call.
> 
> Plus this patch series already contain trivial patches for a long time (e.g. 
> patch 1, 2, 6), and yet I haven't seen any ack from your side for any of them.
> Be invited for that as well.
> 

I'm now starting to reach a steady-state in my new job. I should hopefully
be able to find some cycles for the trivial patches at least.

Thanks for your patience.

> Best regards,
> Christian Schoenebeck
> 
> 


