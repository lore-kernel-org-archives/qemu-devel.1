Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60E9C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 06:16:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E812206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 06:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E812206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxlZR-00084i-RU
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 02:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1jxlYS-0006r8-QA
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 02:15:08 -0400
Received: from mail.ispras.ru ([83.149.199.84]:53654)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1jxlYP-0001cX-ES
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 02:15:08 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 609094089F10;
 Tue, 21 Jul 2020 06:15:00 +0000 (UTC)
Subject: [PATCH v2 0/2] Romless QEMU shutdown patches
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
To: qemu-devel@nongnu.org
Date: Tue, 21 Jul 2020 09:15:00 +0300
Message-ID: <159531210010.24117.10018704762356020189.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 02:15:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, pavel.dovgalyuk@ispras.ru, f4bug@amsat.org,
 aleksandar.qemu.devel@gmail.com, antonynpavlov@gmail.com, chenhc@lemote.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some machines require custom ROMs or kernels. They can't be started without
-bios, -kernel, or -pflash options. But this requirement can't be detected
automatically.

Running a romless machine may be needed for automatic introspection of default
machine hardware, when QEMU is started with a single -machine option.

This series provides patches that enable QEMU execution for MIPS and ARM machines,
even when there is no ROM.

v2 changes:
 - useless error reports were dropped (suggested by Peter Maydell)

---

Pavel Dovgalyuk (2):
      hw/mips: remove exit(1) in case of missing ROM
      hw/arm: remove exit(1) in case of missing ROM


 hw/arm/digic_boards.c |    8 ++++++--
 hw/arm/gumstix.c      |   12 ------------
 hw/arm/omap_sx1.c     |    5 -----
 hw/arm/palm.c         |    8 +-------
 hw/mips/fuloong2e.c   |    8 +++-----
 hw/mips/jazz.c        |    8 +++-----
 hw/mips/malta.c       |   11 ++++-------
 hw/mips/mipssim.c     |   10 +++-------
 8 files changed, 20 insertions(+), 50 deletions(-)

--
Pavel Dovgalyuk

