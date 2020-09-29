Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAE1C47420
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 17:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A224208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 17:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiR4U8wj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A224208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNJhp-0006Ch-P7
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 13:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNJfx-0004uX-O4; Tue, 29 Sep 2020 13:44:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNJft-0006zb-UB; Tue, 29 Sep 2020 13:44:28 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 189CA2076B;
 Tue, 29 Sep 2020 17:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601401463;
 bh=gfr+TwX12CuOcV0RoXnEfYo6dfkKb4tX5vb8oGV2+Wg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FiR4U8wjtidfQ8PLd+m7r0hZFbmvlHSqgEb5V9exm2Csz4C5yON0Wz39FdF3Gtzrc
 u3RCLHv/CmGjpYGI7N4iMhbWJtMzK94vM0egcPMq1nya03noKd25MEKwwrmvonjNA1
 BmCHrpHY5OdoWJbuRsbwVz6/mR30J5x9FP6D9Xr4=
Date: Tue, 29 Sep 2020 10:44:19 -0700
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and
 Zoned Namespace Command Set
Message-ID: <20200929174419.GC477114@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200924210751.GD1738917@apples.localdomain>
 <MN2PR04MB59515B1EA1238861DFF3236AE1350@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200928063648.GA1967@apples.localdomain>
 <20200928212541.GC227320@dhcp-10-100-145-180.wdl.wdc.com>
 <CY4PR04MB3751997C2ED1D5EFB69E32ACE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200929104633.GA179147@apples.localdomain>
 <CY4PR04MB37513C512B186B8AB521C690E7320@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR04MB37513C512B186B8AB521C690E7320@CY4PR04MB3751.namprd04.prod.outlook.com>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 13:29:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -77
X-Spam_score: -7.8
X-Spam_bar: -------
X-Spam_report: (-7.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Klaus Jensen <its@irrelevant.dk>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 11:13:51AM +0000, Damien Le Moal wrote:
> OK. Then let's move the persistence implementation as the last patch in the
> series. This way, if it is still controversial, it will not block the rest.
> 
> Here is what I propose:
> Dmitry: remove persistence stuff from your patches, address comments and resend.
> Klaus: Rebase your persistence patch(es) with reworked format on top of Dmitry
> series and send.
> 
> That creates a pipeline for reviews and persistence is not a blocker. And I
> agree that other ZNS feature can come after we get all of that done first.
> 
> Thoughts ? Keith ? Would that work for you ?

That works for me. I will have comments for Dmitry's v5, though, so
please wait one more day before considering a respin.

