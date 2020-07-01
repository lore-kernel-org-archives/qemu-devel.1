Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A27FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34D620702
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34D620702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqcAx-0007XZ-89
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 08:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1jqcAO-000754-Ds
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:48:44 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:34915)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1jqcAM-0003B1-A5
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:48:43 -0400
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: 5QgK/SXwCc6EKSkGOeangV8vEp7V9umk9wmgnWxSV2V48hAALJdbZq65mwpbSZPY2uC9jKC49m
 lyz7UKsH3JCHeBHFxDV7PkBip771dNQ6ZzvjU7bOGmAqQ/q0h1z+/5hhHPhmZOaBEYJuBAeGyd
 rlQ+NlxOfecG5/NtG+R9hThTFy5NKHMNTu6AzaTAEVnHhAq/+FrU68jdJ2dC1od/9Sq5BJ8Nqe
 fVyHL4nFlUUnysL1eubYHANNr7+hgKaaM391RTQ+4hUfP77936jOIFZAHqi5vwE6dODe3FzAcz
 r/w=
X-SBRS: 2.7
X-MesageID: 21384237
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,300,1589256000"; d="scan'208";a="21384237"
Date: Wed, 1 Jul 2020 13:48:36 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] acpi: Fix access to PM1 control and status registers
Message-ID: <20200701124836.GD2030@perard.uk.xensource.com>
References: <20200701110549.148522-1-anthony.perard@citrix.com>
 <20200701075914-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200701075914-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=216.71.145.155;
 envelope-from=anthony.perard@citrix.com; helo=esa3.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 07:06:03
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 01, 2020 at 08:01:55AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 01, 2020 at 12:05:49PM +0100, Anthony PERARD wrote:
> > The ACPI spec state that "Accesses to PM1 control registers are
> > accessed through byte and word accesses." (In section 4.7.3.2.1 PM1
> > Control Registers of my old spec copy rev 4.0a).
> > 
> > With commit 5d971f9e6725 ("memory: Revert "memory: accept mismatching
> > sizes in memory_region_access_valid""), it wasn't possible anymore to
> > access the pm1_cnt register by reading a single byte, and that is use
> > by at least a Xen firmware called "hvmloader".
> > 
> > Also, take care of the PM1 Status Registers which also have "Accesses
> > to the PM1 status registers are done through byte or word accesses"
> > (In section 4.7.3.1.1 PM1 Status Registers).
> > 
> > Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> 
> 
> Can't we set impl.min_access_size to convert byte accesses
> to word accesses?

I actually tried, but when reading `addr` or `addr+1` I had the same
value. So I guess `addr` wasn't taken into account.

I've checked again, with `.impl.min_access_size = 2`, the width that the
function acpi_pm_cnt_read() get is 2, but addr isn't changed so the
function is still supposed to shift the result (or the value to write)
based on addr, I guess.

-- 
Anthony PERARD

