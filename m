Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7B6C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22D21214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D21214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAC2j-0008Lo-7a
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 07:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iABvQ-0003JT-95
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iABvO-0002vl-Su
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:45:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55662)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iABvO-0002vR-N4
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:45:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C898118C4266;
 Tue, 17 Sep 2019 11:45:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74C2C5D9D5;
 Tue, 17 Sep 2019 11:45:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 60D3717535; Tue, 17 Sep 2019 13:45:36 +0200 (CEST)
Date: Tue, 17 Sep 2019 13:45:36 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Li Qiang <liq3ea@163.com>
Message-ID: <20190917114536.sh7xbekebne4pqox@sirius.home.kraxel.org>
References: <20190831153922.121308-1-liq3ea@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831153922.121308-1-liq3ea@163.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Tue, 17 Sep 2019 11:45:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] vnc: fix memory leak when vnc disconnect
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
Cc: fangying1@huawei.com, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 31, 2019 at 08:39:22AM -0700, Li Qiang wrote:
> Currently when qemu receives a vnc connect, it creates a 'VncState' to
> represent this connection. In 'vnc_worker_thread_loop' it creates a
> local 'VncState'. The connection 'VcnState' and local 'VncState' exchange
> data in 'vnc_async_encoding_start' and 'vnc_async_encoding_end'.
> In 'zrle_compress_data' it calls 'deflateInit2' to allocate the libz library
> opaque data. The 'VncState' used in 'zrle_compress_data' is the local
> 'VncState'. In 'vnc_zrle_clear' it calls 'deflateEnd' to free the libz
> library opaque data. The 'VncState' used in 'vnc_zrle_clear' is the connection
> 'VncState'. In currently implementation there will be a memory leak when the
> vnc disconnect. Following is the asan output backtrack:

Added to ui patch queue.

thanks,
  Gerd


