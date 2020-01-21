Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED169C33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 05:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA11222522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 05:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="BmT+CPgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA11222522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itlgX-0006qy-Dh
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 00:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1itleu-0005Wj-SE
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 00:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1itleq-0002Pt-M7
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 00:01:00 -0500
Received: from nwk-aaemail-lapp03.apple.com ([17.151.62.68]:46690)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1itlep-0002OF-O0
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 00:00:56 -0500
Received: from pps.filterd (nwk-aaemail-lapp03.apple.com [127.0.0.1])
 by nwk-aaemail-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 00L4uUtp048852; Mon, 20 Jan 2020 21:00:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from : to :
 cc : subject : date : message-id : mime-version :
 content-transfer-encoding; s=20180706;
 bh=UvAe46VJ4DQbvFc6Wn+kdtfsiPDY6Wfu0C2do1ByPQA=;
 b=BmT+CPgWCPE5zDYr6WfvmN77j2NJhQTe1WOutPHh90Ua6VuIAULl/oBESH0rbPaRF0x6
 r2Cc8xJXe48QNc0IM/H0buY+ltCcflxdwTX2AxlaLwXcJnnY5W/H/vBEa36G9SRuh1oa
 ZJn54rIYnAe2r+7Zc5QnuuCwOOOZDlAx86m3KG920RJH77Z020wdMhzhajdmMBUC6MUd
 v58xa8TWwI4g2/ggwTOYEKjBKWEXSAYIh6WOIbjRW3fuKHwa8IizEOs4Qkkym8xl6nDT
 Nf/sjJnl5tDq6MXOGcxbbclZe7+HBqD20lHvpkGXxwNxcqdImqtfnc6kXcOVLuVTBKkB Qw== 
Received: from ma1-mtap-s03.corp.apple.com (ma1-mtap-s03.corp.apple.com
 [17.40.76.7])
 by nwk-aaemail-lapp03.apple.com with ESMTP id 2xmk4ngc8w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 20 Jan 2020 21:00:53 -0800
Received: from nwk-mmpp-sz11.apple.com
 (nwk-mmpp-sz11.apple.com [17.128.115.155]) by ma1-mtap-s03.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0Q4F00CTRXXGNA00@ma1-mtap-s03.corp.apple.com>; Mon,
 20 Jan 2020 21:00:53 -0800 (PST)
Received: from process_milters-daemon.nwk-mmpp-sz11.apple.com by
 nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q4F00C00XDY2N00@nwk-mmpp-sz11.apple.com>; Mon,
 20 Jan 2020 21:00:52 -0800 (PST)
X-Va-A: 
X-Va-T-CD: c56cc4374afe9162bf6a337f3d661529
X-Va-E-CD: b1400964e9a82443adde9a5f77bf6bab
X-Va-R-CD: f07809679447c5719e38e1231417c529
X-Va-CD: 0
X-Va-ID: dddb67ba-cdab-4596-8c42-fc4c122c619d
X-V-A: 
X-V-T-CD: c56cc4374afe9162bf6a337f3d661529
X-V-E-CD: b1400964e9a82443adde9a5f77bf6bab
X-V-R-CD: f07809679447c5719e38e1231417c529
X-V-CD: 0
X-V-ID: 1be32d2a-a3ce-420e-8ce0-a8df68aadff9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2020-01-20_10:,, signatures=0
Received: from pontoon.com (unknown [17.234.97.123]) by nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q4F005Q7XXG3520@nwk-mmpp-sz11.apple.com>; Mon,
 20 Jan 2020 21:00:52 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com
Subject: [PATCH v2 0/2] vnc: fix VNC artifacts
Date: Mon, 20 Jan 2020 21:00:50 -0800
Message-id: <cover.1579582674.git.dirty@apple.com>
X-Mailer: git-send-email 2.24.0
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2020-01-20_10:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 17.151.62.68
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
Reply-to: Cameron Esfahani <dirty@apple.com>
From: Cameron Esfahani via <qemu-devel@nongnu.org>

Remove VNC optimization to reencode framebuffer update as raw if it's
smaller than the default encoding.  QEMU's implementation was naive and
didn't account for the ZLIB z_stream mutating with each compression.  Just
saving and restoring the output buffer offset wasn't sufficient to "rewind"
the previous encoding.  Considering that ZRLE is never larger than raw and
even though ZLIB can occasionally be fractionally larger than raw, the
overhead of implementing this optimization correctly isn't worth it.

While debugging this, I noticed ZRLE always compresses better than ZLIB.
Prioritize ZRLE over ZLIB, even if the client hints that ZLIB is preferred.

Cameron Esfahani (2):
  vnc: fix VNC artifacts
  vnc: prioritize ZRLE compression over ZLIB

 ui/vnc-enc-zrle.c |  4 ++--
 ui/vnc.c          | 31 +++++++++++--------------------
 2 files changed, 13 insertions(+), 22 deletions(-)

-- 
2.24.0


