Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A28C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:46:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B853E2071C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ckXYTC2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B853E2071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVYcJ-0001Bb-Tt
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@citrix.com>)
 id 1jVYbH-0000Fc-Ei
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:45:27 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:51400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@citrix.com>)
 id 1jVYbF-0007Gz-D0
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1588589125;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=tXO0ICCiT142bp9ixaiqrYulWlsUgTl6QaOusnFsu4U=;
 b=ckXYTC2lI9O+nMZDl8xRFaGITfN1NzLp1mClaeYLEpE5E5J9RKCvNElL
 VVWXq9hmRBsFgA/dqJFcFvrgdOwoTb29KGGgrA0QuLQCwHXfueYdnLFAr
 D0YgDacqisHZap/GvG65pGM0QAcMPzj26dOSKrFlbOcdguFn4sSRJqDYt E=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=roger.pau@citrix.com;
 spf=Pass smtp.mailfrom=roger.pau@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
 receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="roger.pau@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
 roger.pau@citrix.com designates 162.221.158.21 as permitted
 sender) identity=mailfrom; client-ip=162.221.158.21;
 receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="roger.pau@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: VA3TIEhLTXp19jB7KBHvDtiNb7ydxUl7/pqE0PN/ICWErY/2eqpU1iwd9W7mtFrxXdtFnLftqj
 0Kmkr+jP+e5W/4TSAaIZwVGklxWHvocqq8eQ64FOAj9FxBheeCKksSPw+q1C9OL+x58Db5JKA7
 YOOT/DjeR/kDcJQU9cRw3AspnuU36z5KDTLLlx3Q58mlTEVWFqcTwnywwvbwASFSLpDGIpCAPu
 V4GbVkYxG276mG1eZYPLKhcJ0Bh9wQ8sUWfXS9rXnO1l57OMkxUzoA/149rGJZhHprFTGQCd4u
 bOM=
X-SBRS: 2.7
X-MesageID: 17353198
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.73,351,1583211600"; d="scan'208";a="17353198"
Date: Mon, 4 May 2020 12:45:12 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] xen: fix build without pci passthrough
Message-ID: <20200504104512.GA1353@Air-de-Roger>
References: <20200504101443.3165-1-roger.pau@citrix.com>
 <ccf11b67-4aaa-5fb2-e23f-674380b47a13@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccf11b67-4aaa-5fb2-e23f-674380b47a13@redhat.com>
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Received-SPF: pass client-ip=216.71.155.144; envelope-from=roger.pau@citrix.com;
 helo=esa4.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 06:45:21
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, KHOP_DYNAMIC=0.001, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org,
 Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 04, 2020 at 12:35:39PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Roger,
> 
> On 5/4/20 12:14 PM, Roger Pau Monne wrote:
> > has_igd_gfx_passthru is only available when QEMU is built with
> > CONFIG_XEN_PCI_PASSTHROUGH, and hence shouldn't be used in common
> > code without checking if it's available.
> > 
> > Fixes: 46472d82322d0 ('xen: convert "-machine igd-passthru" to an accelerator property')
> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> 
> See Kconfig fix suggested here:
> https://www.mail-archive.com/xen-devel@lists.xenproject.org/msg61844.html

Having it available on Kconfig is indeed fine, but this still needs
some kind of configure checks AFAIK, as it's only available on Linux.

I'm certainly missing some context, but whether XEN_IGD_PASSTHROUGH
gets defined on Kconfig or not shouldn't really matter for this patch,
as we would still need to gate the code properly so it's not build
when PCI passthrough (or whatever name the option has) is not enabled?

Thanks, Roger.

