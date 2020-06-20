Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D6EC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 00:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A6F22583
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 00:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A6F22583
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmREo-0005Df-Si
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 20:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jmREF-0004o4-G1
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 20:19:27 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:34113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jmRED-0007aQ-2M
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 20:19:26 -0400
IronPort-SDR: ec3F4/o5EkFTPyM2TgQ9gRqeYRy71NF7dQqTxzLFYVRLZbCTv2d0yNn937vpn91vtHJIs9zXAL
 Q8StcAbwyDX3//37OVh7eQOylt8DoI25daT6XoyJcEGc2snBwcPb0Vlb9uk19/ZhN3J2bp5VlV
 8lqYLLfNyGd/G+1WWDxbWwNN4B9clBmvlnci1V9z1epOBQg+Emr5SEFciwghCncLq8fd01lbgX
 yD8IxyrG2YK59IT/GT3SdSaaqyMZWoPIJ0GU9us8XKnr/Hjq4T5t9ZXbJhhkQgnXZHtlGB9Zqn
 R5s=
X-IronPort-AV: E=Sophos;i="5.75,256,1589270400"; d="scan'208";a="50135318"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa4.mentor.iphmx.com with ESMTP; 19 Jun 2020 16:19:22 -0800
IronPort-SDR: uA2ZxNzA+BsU58iKyc43NJNCAcYNLFVyhJSXjVgb51dpkKxEzPzuqvuZqXx7zrsOy40oxsg+My
 iZhfe9QNtZyldh6g++xpJwXlOV50TaIiBfStG/GurxTZItK8cEws4KsTiwZ7Jzr4qt75xkm3Or
 wSLEFBVKwAwJOs82knJOnazWXpWXlFVAevyWqBge0tgqD1mspLEHnuxs9TaJrPzXSBLB4/7OFd
 1f85yiDFEkW/i3SV5WHROo5yuLG/51Z0BeXdp3lNP8fbZpoxMpsOWYQYYUKh+wUdwQExPJ+5t+
 1CY=
Date: Sat, 20 Jun 2020 00:19:16 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <rth@twiddle.net>,
 <ehabkost@redhat.com>
Subject: Re: [PATCH] target/i386: reimplement fpatan using floatx80 operations
In-Reply-To: <alpine.DEB.2.21.2006192003370.30302@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2006200016130.30302@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2006192003370.30302@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Received-SPF: pass client-ip=68.232.137.252;
 envelope-from=joseph_myers@mentor.com; helo=esa4.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 20:19:22
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Testing with the glibc testsuite shows this patch needs a little more work 
to get correct underflow/inexact exceptions in the case where ST0 is 
positive and ST1/ST0 is small.  I'll send a revised patch next week (I 
don't expect any changes in the rest of the code).

-- 
Joseph S. Myers
joseph@codesourcery.com

