Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F28C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA707206C1
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ8kjSWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA707206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0gB-0008TV-OS
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kO0WR-0006z3-5q; Thu, 01 Oct 2020 11:29:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kO0WN-0001oY-7Y; Thu, 01 Oct 2020 11:29:30 -0400
Received: from C02WT3WMHTD6 (rap-us.hgst.com [199.255.44.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7CE4420719;
 Thu,  1 Oct 2020 15:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601566165;
 bh=555IYNNoaWfxGKgf/qxov85wrFNy355cbjX1Rfz6uAg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kQ8kjSWjHMzzIeOS9sT+cW+b5zY6oBvnuQ8kBKP3+iqkzod/bR9HCRWipF59HI5XR
 dBdCYIR15aRXSGaVHPn+GG5FJMv3KTshJsBEK3lGzWPFBVKczUn5TLfGOk580C6vHe
 OjTVZrM1Tx1VmpVHktJyx1RRthjnWsjiatbn4Krk=
Date: Thu, 1 Oct 2020 09:29:22 -0600
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH v5 05/14] hw/block/nvme: Add support for Namespace Types
Message-ID: <20201001152922.GC3343@C02WT3WMHTD6>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-6-dmitry.fomichev@wdc.com>
 <20201001112245.GA316454@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001112245.GA316454@localhost.localdomain>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 11:20:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 01, 2020 at 11:22:46AM +0000, Niklas Cassel wrote:
> On Mon, Sep 28, 2020 at 11:35:19AM +0900, Dmitry Fomichev wrote:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> > @@ -2222,6 +2328,30 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
> >          break;
> >      case 0x14:  /* CC */
> >          trace_pci_nvme_mmio_cfg(data & 0xffffffff);
> > +
> > +        if (NVME_CC_CSS(data) != NVME_CC_CSS(n->bar.cc)) {
> > +            if (NVME_CC_EN(n->bar.cc)) {
> 
> I just saw this print when doing controller reset on a live system.
> 
> Added a debug print:
> nvme_write_bar WRITING: 0x0 previous: 0x464061
> 
> so the second if-statement has to be:
> 
>     if (NVME_CC_EN(n->bar.cc) && NVME_CC_EN(data)) {
> 
> Sorry for introducing the bug in the first place.

No worries.

I don't think the check should be here at all, really. The only check for valid
CSS should be in nvme_start_ctrl(), which I posted yesterday.
 
> > +                NVME_GUEST_ERR(pci_nvme_err_change_css_when_enabled,
> > +                               "changing selected command set when enabled");
> > +            } else {
> > +                switch (NVME_CC_CSS(data)) {
> > +                case CSS_NVM_ONLY:
> > +                    trace_pci_nvme_css_nvm_cset_selected_by_host(data &
> > +                                                                 0xffffffff);
> > +                    break;
> > +                case CSS_CSI:
> > +                    NVME_SET_CC_CSS(n->bar.cc, CSS_CSI);
> > +                    trace_pci_nvme_css_all_csets_sel_by_host(data & 0xffffffff);
> > +                    break;
> > +                case CSS_ADMIN_ONLY:
> > +                    break;
> > +                default:
> > +                    NVME_GUEST_ERR(pci_nvme_ub_unknown_css_value,
> > +                                   "unknown value in CC.CSS field");
> > +                }
> > +            }
> > +        }

