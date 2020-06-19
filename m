Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AD3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 20:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB572100A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 20:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB572100A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmNlx-0005St-HR
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 16:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jmNl7-0004AV-I8
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 16:37:09 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:28523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jmNl5-0006Gf-Pk
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 16:37:09 -0400
IronPort-SDR: DYj2XXy1vcl6MUqdx8LqqzJnXJqohmosBQFyyKSO/JkDZ3/TNreY63mOrZu7qMUJ75YjBonD8L
 qiRZMsDdW/xTSkZRzeky+WGoEkCFfjCOBvcMXTKcoZCGYT4UNohQdY2IRhRJJ+ifSM5pUZp8Qr
 ghavLlpE8dGuntf6f/XdN+IjOISDIwHobdUVGJf3rAnCAQhI7janx0pU+ktnce9HEz4brk/5Co
 Np6WBVwU9J8yp1qdJkOcSD3euwz8W10psxpy/B5nlWVA4tP2kNBI0aScAm0Wjqc1IgDRyj6UBR
 6fM=
X-IronPort-AV: E=Sophos;i="5.75,256,1589270400"; d="scan'208";a="50019668"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa3.mentor.iphmx.com with ESMTP; 19 Jun 2020 12:37:05 -0800
IronPort-SDR: rcwutrZCWGwOSd41h2n1FQStS87wiA2tqUlyvCoV7olo/ds/CFm98uYeVpSRF09nk9T1H6vmzV
 e07A1NnbEVCIW66LOvwrkmR2pMrVZ5/6pM+f7muTs2CZi98uZftG71XxKPoz6vmXY8jZ9Qmeqo
 WMFcFwPxUINoA+rTMDJc+KS9uDn1MsyalKain5pvocApPpW+QqawSU57/k8dSMFNTEkiUXvCJd
 PS1SE6DQFd+KT3hDRC9LmSQtaMtfVin0m9taAqJHci67ln7xdv7VwrFLK4yLPFQRt6En1fRSf5
 mLQ=
Date: Fri, 19 Jun 2020 20:36:59 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>
Subject: Re: [PATCH] target/i386: reimplement fpatan using floatx80 operations
In-Reply-To: <159259858920.4885.12804141142907411593@d1fd068a5071>
Message-ID: <alpine.DEB.2.21.2006192035060.30302@digraph.polyomino.org.uk>
References: <159259858920.4885.12804141142907411593@d1fd068a5071>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) To
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

> This series seems to have some coding style problems. See output below for
> more information:

This is the same issues as before of this patch checker not understanding 
hex float constants, and it not seeming particularly useful to wrap lines 
in a large table of randomly generated tests.

-- 
Joseph S. Myers
joseph@codesourcery.com

