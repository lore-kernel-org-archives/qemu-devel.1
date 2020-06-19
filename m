Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F40C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 20:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5502A20890
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 20:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5502A20890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmNgM-0008Bo-Lv
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 16:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jmNfZ-0007mk-17
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 16:31:25 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:48453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jmNfW-00052Q-8v
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 16:31:24 -0400
IronPort-SDR: bq5jCJhg+RQifxL8VX8adnN+v8mrpzQ5iUelVuQxcBylxlvp/Mh0QwDGdqexSMtsNvHsETyMPu
 z2dBQYA6x2XhASiKuSENJlUpbXnhouEm+zFwsWWQr1dd38oPjAFpyhPFi/5u4gPaGHedMY+O5n
 bk/O6p7ry5eEKH1isKXcYQgcoRulqhgjH1h8fohznVhySEE8P4oOqzawj2KTv9jXOQp48+O2K0
 Q9xJHVc96plN+8W2jfcEM8K7Qn067h8okrA+ei/Esg4ORphRL7d5wZYXJfEOWqvij7Tygt0lGP
 tvw=
X-IronPort-AV: E=Sophos;i="5.75,256,1589270400"; d="scan'208";a="50019564"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa3.mentor.iphmx.com with ESMTP; 19 Jun 2020 12:31:19 -0800
IronPort-SDR: NydjMDKOEuMj3tvkzPVK0xvQ0Z+6IRknJpVImnEWntTY6q/EHYg9XkzHnugOQQizL2zICDr3nW
 vK9uSX146S2d2O/A3UODqaM114+xFfV/oePyihFb/r1KRqC5HwS0qCvlAaw6Twof6zdXOm9R69
 +wcSAmqdbfMopGX0PuhAPJu90l4u4L30h922Fs2HDMr9e1zDnPElTL6PVHcR8X8RbTg/IUEv87
 D3fJaC/n1QorwdMwRu7W/M2ZuEgEN7jDFam8kq+DKaLFq8eGcpZmfT1W4r9uo7nAbuulYj/f4J
 dvQ=
Date: Fri, 19 Jun 2020 20:31:14 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>
Subject: Re: [PATCH] target/i386: reimplement fpatan using floatx80 operations
In-Reply-To: <159259853716.4885.17553921070428472065@d1fd068a5071>
Message-ID: <alpine.DEB.2.21.2006192030000.30302@digraph.polyomino.org.uk>
References: <159259853716.4885.17553921070428472065@d1fd068a5071>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Received-SPF: pass client-ip=68.232.137.180;
 envelope-from=joseph_myers@mentor.com; helo=esa3.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 16:04:17
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jun 2020, no-reply@patchew.org wrote:

> This series failed the docker-mingw@fedora build test. Please find the 
> testing commands and their output below. If you have Docker installed, 
> you can probably reproduce it locally.

This is because the patch depends on my previous patch to reimplement 
f2xm1, which adds an include of fpu/softfloat-macros.h to 
target/i386/fpu_helper.c.

-- 
Joseph S. Myers
joseph@codesourcery.com

