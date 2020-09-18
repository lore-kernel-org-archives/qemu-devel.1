Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EBEC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:32:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A85222BB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqZJ5mbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A85222BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJNz8-0002OM-9A
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 17:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kJNeR-0002eF-O7; Fri, 18 Sep 2020 17:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kJNeN-0000WJ-Vz; Fri, 18 Sep 2020 17:10:39 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D68BD221EC;
 Fri, 18 Sep 2020 21:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600463430;
 bh=87u0cGI5OW/VCUfWSJCWtOoGSBNJxc8FJLLqDiSZvMc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aqZJ5mbfUnRZgGSwG5VgQ4xN2DBNDDmb6Y3cKsk6LqeiPHsldh+Wfu4T2Cs9Sq8wF
 K67A9hUQH//uDq/DZG9n7kjKGMg1eTE2cjJEkXRJuYzBU1TQk1Azgg3/JyKz4KBpTa
 Vx3OmK9dy2sqSa60S4H8PPSx0UAwB6ZP9vrVi1BU=
Date: Fri, 18 Sep 2020 14:10:27 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v3 01/15] hw/block/nvme: Define 64 bit cqe.result
Message-ID: <20200918211027.GD4030837@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
 <20200913221436.22844-2-dmitry.fomichev@wdc.com>
 <20200915073720.GB499689@apples.localdomain>
 <MN2PR04MB5951ED0FD5633E8144459A28E1200@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200915195546.GA14485@apples.localdomain>
 <MN2PR04MB5951E0BA1D9E217C37B82ED3E1200@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200915204849.GC14485@apples.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915204849.GC14485@apples.localdomain>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 17:10:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Niklas Cassel <Niklas.Cassel@wdc.com>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 15, 2020 at 10:48:49PM +0200, Klaus Jensen wrote:
> On Sep 15 20:44, Dmitry Fomichev wrote:
> > 
> > It is not necessary to change it in NST patch since result64 field is not used
> > in that patch. But if you insist, I can move it to NST patch :)
> 
> You are right of course, but since it is a change to the "spec" related
> data structures that go into include/block/nvme.h, I think it belongs in
> "hw/block/nvme: Introduce the Namespace Types definitions".

Just my $.02, unless you're making exernal APIs, I really find it easier
to review internal changes inline with the patches that use it.

Another example, there are patches in this series that introduce trace
points, but the patch that use them come later. I find that harder to
review since I need to look at two different patches to understand its
value.

I realize this particular patch is implementing a spec feature, but I'd
prefer to see how it's used over of making a round trip to the spec.

