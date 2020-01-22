Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECF4C2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 01:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 253A92253D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 01:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253A92253D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu4kT-0007fQ-CB
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 20:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1iu4jt-0007F5-5h
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 20:23:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1iu4jr-0002LY-JL
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 20:23:24 -0500
Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169]:11503)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1iu4jr-0002HJ-3n
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 20:23:23 -0500
Received: from kw-mxoi2.gw.nic.fujitsu.com (unknown [192.168.231.133]) by
 mgwkm02.jp.fujitsu.com with smtp
 id 64d9_8430_c8d091d7_37a7_4556_bffd_ac144edacdfa;
 Wed, 22 Jan 2020 10:23:11 +0900
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local
 (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
 by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id CF1C9AC0093
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 10:23:10 +0900 (JST)
Received: from G01JPEXCHKW13.g01.fujitsu.local
 (G01JPEXCHKW13.g01.fujitsu.local [10.0.194.52])
 by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id B6BF9BD6509;
 Wed, 22 Jan 2020 10:23:09 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 G01JPEXCHKW13.g01.fujitsu.local (10.0.194.52) with Microsoft SMTP Server id
 14.3.439.0; Wed, 22 Jan 2020 10:23:09 +0900
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To: <dgilbert@redhat.com>
Subject: Re: [PATCH v2 073/109] virtiofsd: extract root inode init into
 setup_root()
Date: Wed, 22 Jan 2020 10:31:40 +0900
Message-ID: <20200122013140.31553-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200121122433.50803-74-dgilbert@redhat.com>
References: <20200121122433.50803-74-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.219.69.169
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
Cc: m.mizuma@jp.fujitsu.com, berrange@redhat.com, slp@redhat.com,
 misono.tomohiro@jp.fujitsu.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 philmd@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Miklos Szeredi <mszeredi@redhat.com>
> 
> Inititialize the root inode in a single place.
btw, Initialize
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> dgilbert:
> with fix suggested by Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

