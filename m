Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554FBC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:21:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C694820872
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOxjDnWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C694820872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2H5-00089H-It
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kO23u-0002Ah-Dl; Thu, 01 Oct 2020 13:08:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kO23r-0001dC-5t; Thu, 01 Oct 2020 13:08:10 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1B3B620897;
 Thu,  1 Oct 2020 17:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601572085;
 bh=DqV8NkhOy+mAyQY3i8jWiz8eC7B5XK/sg1yHF9qll/E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tOxjDnWQqfja1eFNoK2uV4HD0O+yd/zLhA0iKasrEfsLTmNsXi+3kuOSl6/Q9NV9V
 L4/vuV0Qr67Cy72fL3/0FH/42LbCZHIf36TuNQ6NF//sx9X883mUrLqg7dqwKmrrfH
 +JrAdYlTS6Gi9mEdCnjbRd2RjdhwktjdXtTHbiFI=
Date: Thu, 1 Oct 2020 10:08:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH v5 05/14] hw/block/nvme: Add support for Namespace Types
Message-ID: <20201001170801.GB564651@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-6-dmitry.fomichev@wdc.com>
 <20201001112245.GA316454@localhost.localdomain>
 <20201001152922.GC3343@C02WT3WMHTD6>
 <20201001155034.GA337287@localhost.localdomain>
 <20201001155931.GA564651@dhcp-10-100-145-180.wdl.wdc.com>
 <20201001162355.GA339198@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001162355.GA339198@localhost.localdomain>
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

On Thu, Oct 01, 2020 at 04:23:56PM +0000, Niklas Cassel wrote:
> But I see your point, all of this code:
> 
>         if (NVME_CC_CSS(data) != NVME_CC_CSS(n->bar.cc)) {
>             if (NVME_CC_EN(n->bar.cc)) {
>                 NVME_GUEST_ERR(pci_nvme_err_change_css_when_enabled,
>                                "changing selected command set when enabled");
>             } else {
>                 switch (NVME_CC_CSS(data)) {
>                 case CSS_NVM_ONLY:
>                     trace_pci_nvme_css_nvm_cset_selected_by_host(data &
>                                                                  0xffffffff);
>                 break;
>                 case CSS_CSI:
>                     NVME_SET_CC_CSS(n->bar.cc, CSS_CSI);
>                     trace_pci_nvme_css_all_csets_sel_by_host(data &
>                                                              0xffffffff);
>                     break;
>                 case CSS_ADMIN_ONLY:
>                     break;
>                 default:
>                     NVME_GUEST_ERR(pci_nvme_ub_unknown_css_value,
>                                    "unknown value in CC.CSS field");
>                 }
>             }
>         }
> 
> should simply be dropped.
> 
> No need to call NVME_SET_CC_CSS() explicitly.
> 
> CC.CSS bit will be set futher down in this function anyway:
> 
>         if (NVME_CC_EN(data) && !NVME_CC_EN(n->bar.cc)) {
>             n->bar.cc = data;

Yep, that's how I saw it too. I folded it all into a rebase here for
this particular patch:

  http://git.infradead.org/qemu-nvme.git/commitdiff/45157cab2e700155b05f0bd28533f73d7e399ab8?hp=2015774a010011a9e8d2ab5291fd8d747f60471e

It depends on the prep patches I sent yesterday, which seem pretty
straight forward. I'll just wait another day before committing that
stuff and other fixes to the nvme-next branch. But if you want to get a
head start on the ZNS enabling parts, what I have in mind is in the
branch from the above link.

