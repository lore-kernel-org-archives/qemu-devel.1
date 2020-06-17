Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81938C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 22:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504AC2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 22:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IQf7mE+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504AC2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlgBU-00052J-KI
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 18:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfhc-0003Zc-5Q; Wed, 17 Jun 2020 17:34:36 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfhZ-0005By-49; Wed, 17 Jun 2020 17:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592429672; x=1623965672;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3nKOfRp8Li/D7irbjAbnlRYOCmKWJfaM5MN8r7hOdXc=;
 b=IQf7mE+m5JVGzrW0DAzZNEwefFakiBYTO06ktzoEoHSIr47Jl6Tmm3wm
 Q1/kCPOyRcX3eJPXceAa3vdirTOMEbzI/RqHWRTTxt4xozLxuic4kNL/M
 WcJTGlTrBB80vUJj5LWxBRtf+t41GNC6hG0QL850SVD1wl5VAm9pXCKEp
 BY8olt/5Kef56V3Fe+KPZ/JNeYVpQfKU4txAAGuF61A/dyteh0wyhJ2iT
 yltROJQ6G25Eh7vvhIQ3XSgnMWZv2eVBIhYhA6p+OuNcugG/Nae0HVqcU
 Ry9mZoVOn+24+4vcVOalfUm7CMLPyekJCaWwEYtEfSSQ7SiZsoSJ+XAar g==;
IronPort-SDR: dg/5iq+K7aeUFog8R0SDrWnwM7NLsds3cl2Q2zLHQ/8BH4u9Soz0wCJKOPYr/pCPDTEvpXp3KM
 kKFKgFDtGGI0HQ5wpvwOjCDz1Pz8Z0KQlGOFtI5jWrH7TvuHTyV+KWI223ndh7CScU68qVcVe9
 sCvCg1rGgXXSqVJZSu3ByjIJ5YpvKqnyFznOPCBYSsbMX02IIpItSpM0HntmeU1B+z/cKr0op/
 9EHDycGqc541rydiMfzVRnMTnr/mjGDInb+jIRMMFAxE8U81xh+FptdA7WfvPowpwxwSqPbBux
 R0g=
X-IronPort-AV: E=Sophos;i="5.73,523,1583164800"; d="scan'208";a="249439782"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 05:34:28 +0800
IronPort-SDR: luL764Fw84XdAuMS+GDwLVn0q4J/d4z1ztin2R7jEW2eHvxk4zxcRNp9JtnZYdwIp5KlfJCT9X
 8Lfxqln//5tdIenAsCLEtCHl9pJlT4hM4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 14:23:09 -0700
IronPort-SDR: 1gBPrfwbnUwn8vNtQoh8rS9+hSTw0llpzUVKBiHlk20uw1m4L4Du/B3GUCTR97WVuWXMzf1WWC
 jrJ0QGTm4BPw==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2020 14:34:26 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>
Subject: [PATCH v2 00/18] hw/block/nvme: Support Namespace Types and Zoned
 Namespace Command Set
Date: Thu, 18 Jun 2020 06:33:57 +0900
Message-Id: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=430b82a1d=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 17:34:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2: rebased on top of block-next/block branch

Zoned Namespace (ZNS) Command Set is a newly introduced command set
published by the NVM Express, Inc. organization as TP 4053. The main
design goals of ZNS are to provide hardware designers the means to
reduce NVMe controller complexity and to allow achieving a better I/O
latency and throughput. SSDs that implement this interface are
commonly known as ZNS SSDs.

This command set is implementing a zoned storage model, similarly to
ZAC/ZBC. As such, there is already support in Linux, allowing one to
perform the majority of tasks needed for managing ZNS SSDs.

The Zoned Namespace Command Set relies on another TP, known as
Namespace Types (NVMe TP 4056), which introduces support for having
multiple command sets per namespace.

Both ZNS and Namespace Types specifications can be downloaded by
visiting the following link -

https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs.zip

This patch series adds Namespace Types support and zoned namespace
emulation capability to the existing NVMe PCI driver.

The patchset is organized as follows -

The first several patches are preparatory and are added to allow for
an easier review of the subsequent commits. The group of patches that
follows adds NS Types support with only NVM Command Set being
available. Finally, the last group of commits makes definitions and
adds new code to support Zoned Namespace Command Set.

Based-on: <20200609205944.3549240-1-eblake@redhat.com>

Ajay Joshi (1):
  hw/block/nvme: Define 64 bit cqe.result

Dmitry Fomichev (15):
  hw/block/nvme: Move NvmeRequest has_sg field to a bit flag
  hw/block/nvme: Clean up unused AER definitions
  hw/block/nvme: Add Commands Supported and Effects log
  hw/block/nvme: Define trace events related to NS Types
  hw/block/nvme: Make Zoned NS Command Set definitions
  hw/block/nvme: Define Zoned NS Command Set trace events
  hw/block/nvme: Support Zoned Namespace Command Set
  hw/block/nvme: Introduce max active and open zone limits
  hw/block/nvme: Simulate Zone Active excursions
  hw/block/nvme: Set Finish/Reset Zone Recommended attributes
  hw/block/nvme: Generate zone AENs
  hw/block/nvme: Support Zone Descriptor Extensions
  hw/block/nvme: Add injection of Offline/Read-Only zones
  hw/block/nvme: Use zone metadata file for persistence
  hw/block/nvme: Document zoned parameters in usage text

Niklas Cassel (2):
  hw/block/nvme: Introduce the Namespace Types definitions
  hw/block/nvme: Add support for Namespace Types

 block/nvme.c          |    2 +-
 block/trace-events    |    2 +-
 hw/block/nvme.c       | 2316 ++++++++++++++++++++++++++++++++++++++++-
 hw/block/nvme.h       |  228 +++-
 hw/block/trace-events |   56 +
 include/block/nvme.h  |  282 ++++-
 6 files changed, 2820 insertions(+), 66 deletions(-)

-- 
2.21.0


