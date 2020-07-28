Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B631FC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F50B20714
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Wn3WKLeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F50B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0M0j-0008JK-ND
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 05:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k0M03-0007Qd-Cs
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:34:19 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:35905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k0M00-0002AA-BN
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=ZK2baikIxFUth6O+ZE0Jhwc0q+XRqMZKUrH1RwXVGfc=; b=Wn3WKLeA0LW7BAIdKjXCJIgf5A
 u8OSQaX83a6ELbV59t+40YzEc5p6YMIEDUcxQ9P8MgXBkiTigoHowyblBerL3vIcbipHijtVyOwvx
 NuA0po2dmxj0ritJEthV/ZE0zB3GKEBOm+xvTJrlG16I1NK3n7/E4IJOuOnLVhcdW77ioKU67iY32
 rkqe1jaeYoZ41x15OOO3Jjay0HmiTMJ7+0Q8QlLpo6NHTh1xCorEv0fmFO3TRUuo9KLCzxy8IbsDJ
 q3kptTNw2O+mk7zDk8wQR6YDtarsRk0VA8DUD6GbXRJgRURPbxYaXmNAe0cwoFLvfAO8EXIC0y7Ez
 3/LtkqNg==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v7 3/6] 9pfs: add new function v9fs_co_readdir_many()
Date: Tue, 28 Jul 2020 11:34:12 +0200
Message-ID: <8722268.CRvGb0V2lm@silver>
In-Reply-To: <20200728104600.4552a126@bahia.lan>
References: <cover.1595166227.git.qemu_oss@crudebyte.com>
 <1626524.GXyn7ySoG3@silver> <20200728104600.4552a126@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 04:33:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Dienstag, 28. Juli 2020 10:46:00 CEST Greg Kurz wrote:
> > So I'll prepare a v8 with this patch here split into two.
> > 
> > But this is it. I don't see another chunk in this patch set that could be
> > split further down in an useful way.
> > 
> > Best regards,
> > Christian Schoenebeck
> 
> You're in charge now so feel free to do that if the development+testing
> cost is acceptable to you. 

Yep, that's the plan. This patch set is already thoroughly tested by me, so I 
would like to avoid major changes for this series now that would require me to 
restart major testing cycles.

In this particular case, this patch-split ends up in 100% identical code. So 
it is really just git history tweaking after all.

> You already know my take on having smaller
> patches :)

A pure desire for something is one thing, the actually available real-life 
options are another thing. If you see more options than I can identify, you 
are always invited to make your call.

Plus this patch series already contain trivial patches for a long time (e.g. 
patch 1, 2, 6), and yet I haven't seen any ack from your side for any of them.
Be invited for that as well.

Best regards,
Christian Schoenebeck



