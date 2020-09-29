Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E8CC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:17:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2716208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SN3t6zP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2716208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNKC1-0005KK-OL
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 14:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNK9g-0003xJ-O1; Tue, 29 Sep 2020 14:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:32802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNK9d-000323-NH; Tue, 29 Sep 2020 14:15:12 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C9503208B8;
 Tue, 29 Sep 2020 18:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601403306;
 bh=1kFpfx7ScgF8pui+L0UJTB53gx5FbvvAUM3s1/XKnmg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SN3t6zP9Q8wOCuRr95TxZGydfFJaz4LgmgsOTGhYLMAduKJuu7dA3thULls+zs/DT
 b8QQCCJ49bKhBMdDoLM3YhOmssKisw8CeVnk9SNl+3laSnE4cPhBWrIlzzK3b6F/To
 Yl393oQD8XwVbeQ2oSvIdYGjNyFwXqkHiXxnLOXo=
Date: Tue, 29 Sep 2020 11:15:03 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and
 Zoned Namespace Command Set
Message-ID: <20200929181503.GD477114@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200924210751.GD1738917@apples.localdomain>
 <MN2PR04MB59515B1EA1238861DFF3236AE1350@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200928063648.GA1967@apples.localdomain>
 <20200928212541.GC227320@dhcp-10-100-145-180.wdl.wdc.com>
 <CY4PR04MB3751997C2ED1D5EFB69E32ACE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200929104633.GA179147@apples.localdomain>
 <20200929172944.GB477114@dhcp-10-100-145-180.wdl.wdc.com>
 <20200929180004.GC286786@apples.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929180004.GC286786@apples.localdomain>
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
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 08:00:04PM +0200, Klaus Jensen wrote:
> On Sep 29 10:29, Keith Busch wrote:
> > On Tue, Sep 29, 2020 at 12:46:33PM +0200, Klaus Jensen wrote:
> > > It is unmistakably clear that you are invalidating my arguments about
> > > portability and endianness issues by suggesting that we just remove
> > > persistent state and deal with it later, but persistence is the killer
> > > feature that sets the QEMU emulated device apart from other emulation
> > > options. It is not about using emulation in production (because yeah,
> > > why would you?), but persistence is what makes it possible to develop
> > > and test "zoned FTLs" or something that requires recovery at power up.
> > > This is what allows testing of how your host software deals with opened
> > > zones being transitioned to FULL on power up and the persistent tracking
> > > of LBA allocation (in my series) can be used to properly test error
> > > recovery if you lost state in the app.
> > 
> > Hold up -- why does an OPEN zone transition to FULL on power up? The
> > spec suggests it should be CLOSED. The spec does appear to support going
> > to FULL on a NVM Subsystem Reset, though. Actually, now that I'm looking
> > at this part of the spec, these implicit transitions seem a bit less
> > clear than I expected. I'm not sure it's clear enough to evaluate qemu's
> > compliance right now.
> > 
> > But I don't see what testing these transitions has to do with having a
> > persistent state. You can reboot your VM without tearing down the
> > running QEMU instance. You can also unbind the driver or shutdown the
> > controller within the running operating system. That should make those
> > implicit state transitions reachable in order to exercise your FTL's
> > recovery.
> > 
> 
> Oh dear - don't "spec" with me ;)
> 
> NVMe v1.4 Section 7.3.1:
> 
>     An NVM Subsystem Reset is initiated when:
>       * Main power is applied to the NVM subsystem;
>       * A value of 4E564D64h ("NVMe") is written to the NSSR.NSSRC
>         field;
>       * Requested using a method defined in the NVMe Management
>         Interface specification; or
>       * A vendor specific event occurs.
 
Okay. I wish the nvme twg would strip the changelog from the published
TPs. We have unhelpful statements like this in the ZNS spec:

  "Default active zones to transition to Closed state on power/controller reset."

> In the context of QEMU, "Main power" is tearing down QEMU and starting
> it from scratch. Just like on a "real" host, unbinding the driver,
> rebooting or shutting down the controller does not cause a subsystem
> reset (and does not cause the zones to change state). 

That can't be right. The ZNS spec says:

  The initial state of a zone state machine is set as a result of:
    a) an NVM Subsystem Reset; or
    b) all controllers in the NVM subsystem reporting Shutdown
       processing complete ((i.e., 10b in the Shutdown Status (SHST)
       register)

So a CC.SHN had better cause an implicit transition of open zones to
their "initial" state since 'open' is not a valid initial state.

