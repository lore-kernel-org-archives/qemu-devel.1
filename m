Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392A1CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 23:03:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2ACB20679
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 23:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMrXmb5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2ACB20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNPeg-0002Dw-5P
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 19:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1iNPdH-0000wj-CS
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 19:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1iNPdG-0008Sa-7l
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 19:01:35 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d]:33935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1iNPdF-0008S8-TP
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 19:01:34 -0400
Received: by mail-lf1-x12d.google.com with SMTP id f5so9752236lfp.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 16:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=I8j4dAhlgluaZhQ+lH7QcWf+rfQOK1gdUYJEkBkfVwQ=;
 b=cMrXmb5q29/uRBibIUeErXB93uwiq7cDGLP0Ql+40npuD/Ko96/0lOwZ64tJn6GI+J
 7YE+l1AKzcJU6T2Ixvep9mQpUrwx9T/jT7u7sNrNO2Emfhm73RGTbMP7ttortsbrrFsw
 etWnnp4k73fClfqdzhv1hORJq/h1rhkrPBCRoT1eZ7nD8QVW431Uy8++54jWKyfCD4R4
 B4tEyowCPkCcy+iyc7I8hjqHXSXMy7lsudqhOo3Dr4MZK1orSIy26e0mYvw9AXxyV2iY
 2HWBPmZVjRaDuzWX8Si51ezGhB3MIMkwFnoFYs5sbCmKzBUU/OmizEawKm0+CUxrUKQB
 ReDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=I8j4dAhlgluaZhQ+lH7QcWf+rfQOK1gdUYJEkBkfVwQ=;
 b=Ay6onZtL9jLmHC8ccyzEP4vZfU1v9HwSpadrGudifaURQZ4Uksd09xQNSwn9vLqYau
 8+TG5RfOKQf+jLn7SoV4VFy28f8/5umHiHpYD/U40oJmuBgftZ5jBXhoIcd3yHPDqZ+B
 bID/hODkcytgsxWwVk+rnEnwLAfvRP6dsjy8UdoBSmyo5SZ8+mX7EiV27aXas4LHoh7U
 NaAH2D0GZeOa72YLogp24aEQswKFi+2O8HUTBKDDXuak6p92VH9wbEY7zmhMrJ6qWUEw
 ErbvI6+FuSLvKatBFAJ3lzEkeD+QZlB70WY6IRl9sv/E/4QhI9utHajtX6BBkmAdSpdU
 PISQ==
X-Gm-Message-State: APjAAAXlXg0ioA4+ZJhG9/VL0I3axcRI7RCIzGFYRVjsOqSXXJTBHyI9
 M0M/wWtkZvBT637RRnvXZhYP37gM
X-Google-Smtp-Source: APXvYqwUB9qrGtGQnjrb2kXZqudv/8VQ+aesPexMI8BGmCBSgvelO6RONVXQ7zMZpIIffUxI/UJjbg==
X-Received: by 2002:ac2:47ed:: with SMTP id b13mr19901725lfp.43.1571871691614; 
 Wed, 23 Oct 2019 16:01:31 -0700 (PDT)
Received: from octofox.cadence.com
 (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
 by smtp.gmail.com with ESMTPSA id b2sm15634556lfq.27.2019.10.23.16.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 16:01:26 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] target/xtensa queue
Date: Wed, 23 Oct 2019 16:01:10 -0700
Message-Id: <20191023230110.7170-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::12d
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

please pull the following two target/xtensa patches for v4.2.

The following changes since commit a30cb4b1f22c58aa3b933ee9e1d7611399b57b5b:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.2-pull-request' into staging (2019-09-12 16:17:26 +0100)

are available in the Git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20191023-xtensa

for you to fetch changes up to d9e8553bc8821d72cb72ca95f76b2d8ff6eb628a:

  hw/xtensa: add virt machine (2019-10-18 20:38:10 -0700)

----------------------------------------------------------------
target/xtensa improvements for v4.2:

- regenerate and reimport test_mmuhifi_c3 core;
- add virt machine.

----------------------------------------------------------------
Max Filippov (2):
      target/xtensa: regenerate and re-import test_mmuhifi_c3 core
      hw/xtensa: add virt machine

 MAINTAINERS                                        |    5 +
 default-configs/xtensa-softmmu.mak                 |    1 +
 hw/xtensa/Kconfig                                  |    6 +
 hw/xtensa/Makefile.objs                            |    1 +
 hw/xtensa/sim.c                                    |   41 +-
 hw/xtensa/virt.c                                   |  135 +
 hw/xtensa/xtensa_sim.h                             |   34 +
 target/xtensa/core-test_mmuhifi_c3.c               |    3 +-
 target/xtensa/core-test_mmuhifi_c3/core-isa.h      |  116 +-
 .../xtensa/core-test_mmuhifi_c3/gdb-config.inc.c   |  114 +-
 .../core-test_mmuhifi_c3/xtensa-modules.inc.c      | 6384 ++++++++++----------
 11 files changed, 3593 insertions(+), 3247 deletions(-)
 create mode 100644 hw/xtensa/virt.c
 create mode 100644 hw/xtensa/xtensa_sim.h

-- 
Thanks.
-- Max

