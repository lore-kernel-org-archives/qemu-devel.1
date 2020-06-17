Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEA5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:59:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1C4021841
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="b3seLZVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C4021841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlg66-0006KC-UA
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfil-0005AE-7b; Wed, 17 Jun 2020 17:35:48 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfii-0005JY-1P; Wed, 17 Jun 2020 17:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592429743; x=1623965743;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+rqBZY1U3F+yetC52f/eo+7Diy5jbNgRvxvBAhx0aao=;
 b=b3seLZVmq+03txtaufYYUd7MGE6JRgK1h3Avc+dDyx0uMRkVMU/Qj7/k
 ySXORvH9f3ifGLB1/uSIfb25vHdxwVL72CIsK+rO1EKBBKCgeLkkZRfbk
 HAJ89IeEsV6tFR+KOoF70v+3cYcGO0mZ367nBf82B7AB06bAJx4sIRfrJ
 S2uudSlSPi3yTufaPpM8n8Xhb2XyU2veaqgGGmrK1g3XfuLNvfjSE2X03
 xJp8y5H+RH6mDI2ElAD53DMb4mc9LTPfl9eNl9Btf266qiNtaGLGrH6PG
 VsYWpgdtUhAgvK1D33J2tV2BGjrwwpHYY02yg5QJsQF52On4OIjo+SIOY A==;
IronPort-SDR: J3sQ4+Lu7HeJrkZfnDfW3AqD08kMhdaJaMq7ULIpAYVI2v3znb601TtewZ0aese5B/79ljpjXX
 9eljBak+IIJ8xqSvhyQyHSLZN6PNqLAWMPESHbAZbjAXfL7lgp+opGlPJ9PalUda2gN+Dpe+Rf
 4cg7kT2FOLs2PNm4GScj6UCClbgDkZLfjKzz9M0XCDD5prUNE42LvJOvEixpIuZ2Dr8+PwDT8Y
 b3E+5ti5NsJmydfJLRK0/dcpGjAzmYa8h74QhbLSxeHAMb3mUXHIm4wp02OwPgaOpFYIgDJItb
 IFg=
X-IronPort-AV: E=Sophos;i="5.73,523,1583164800"; d="scan'208";a="249439849"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 05:35:00 +0800
IronPort-SDR: 6qizE2Lmrt6xMT1kymNWSBHd9sWfDyXxsOITRZnjRHkxK9u76VC49UqtOwmlJtVL1WuHNKSQ03
 7cc5ZogYH9aFXjfIVrz6B7/QLMZwubl04=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 14:23:41 -0700
IronPort-SDR: wT2sYu4NG9DC7YafUcU2mjQXmlaBLTky2wTVn+Ql4SAZMsAHhDYS/+UKjeITXFcoN4F7gIiW6P
 SlDiuOkk6DfQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2020 14:34:59 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>
Subject: [PATCH v2 18/18] hw/block/nvme: Document zoned parameters in usage
 text
Date: Thu, 18 Jun 2020 06:34:15 +0900
Message-Id: <20200617213415.22417-19-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
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

Added brief descriptions of the new driver properties now available
to users to configure features of Zoned Namespace Command Set in the
driver.

This patch is for documentation only, no functionality change.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 63e7a6352e..90b1ae24b5 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -9,7 +9,7 @@
  */
 
 /**
- * Reference Specs: http://www.nvmexpress.org, 1.2, 1.1, 1.0e
+ * Reference Specs: http://www.nvmexpress.org, 1.4, 1.3, 1.2, 1.1, 1.0e
  *
  *  http://www.nvmexpress.org/resources/
  */
@@ -20,7 +20,8 @@
  *      -device nvme,drive=<drive_id>,serial=<serial>,id=<id[optional]>, \
  *              cmb_size_mb=<cmb_size_mb[optional]>, \
  *              [pmrdev=<mem_backend_file_id>,] \
- *              max_ioqpairs=<N[optional]>
+ *              max_ioqpairs=<N[optional]> \
+ *              zoned=<true|false[optional]>
  *
  * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
  * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
@@ -32,6 +33,63 @@
  * For example:
  * -object memory-backend-file,id=<mem_id>,share=on,mem-path=<file_path>, \
  *  size=<size> .... -device nvme,...,pmrdev=<mem_id>
+ *
+ * Setting "zoned" to true makes the driver emulate zoned namespaces.
+ * In this case, of the following options are available to configure zoned
+ * operation:
+ *     zone_size=<zone size in MiB>
+ *
+ *     zone_capacity=<zone capacity in MiB, default: zone_size>
+ *
+ *     zone_file=<zone metadata file name, default: none>
+ *         Zone metadata file, if specified, allows zone information
+ *         to be persistent across shutdowns and restarts.
+ *
+ *     zone_descr_ext_size=<zone descriptor extension size, default 0>
+ *         This value needs to be specified in 64B units. If it is zero,
+ *         namespace(s) will not support zone descriptor extensions.
+ *
+ *     max_active=<Maximum Active Resources (zones), default: 0 - no limit>
+ *
+ *     max_open=<Maximum Open Resources (zones), default: 0 - no limit>
+ *
+ *     reset_rcmnd_delay=<Reset Zone Recommended Delay in milliseconds>
+ *         The amount of time that passes between the moment when a zone
+ *         enters Full state and when Reset Zone Recommended attribute
+ *         is set for that zone.
+ *
+ *     reset_rcmnd_limit=<Reset Zone Recommended Limit in milliseconds>
+ *         If this value is zero (default), RZR attribute is not set for
+ *          any zones.
+ *
+ *     finish_rcmnd_delay=<Finish Zone Recommended Delay in milliseconds>
+ *         The amount of time that passes between the moment when a zone
+ *         enters an Open or Closed state and when Finish Zone Recommended
+ *         attribute is set for that zone.
+ *
+ *     finish_rcmnd_limit=<Finish Zone Recommended Limit in milliseconds>
+ *         If this value is zero (default), FZR attribute is not set for
+ *         any zones.
+ *
+ *     zamds=<zone append maximum data size, in KiB, default: 128>
+ *         The maximum I/O size that can be supported by Zone Append
+ *         command. Since internally this this value is maintained as
+ *         ZAMDS = log2(<maximum append size> / <page size>), some
+ *         values assigned to this property may be rounded down and
+ *         result in a lower maximum ZA data size being in effect.
+ *
+ *     zone_async_events=<send zone Async Events: default: true>
+ *         Enable sending Zone Descriptor Changed AENs to the host.
+ *
+ *     offline_zones=<the number of offline zones to inject, default: 0>
+ *
+ *     rdonly_zones=<the number of read-only zones to inject, default: 0>
+ *
+ *     cross_zone_read=<enables Read Across Zone Boundaries, default: true>
+ *
+ *     fill_pattern=<data fill pattern, default: 0x00>
+ *         Byte pattern to to return for any portions of unwritten data
+ *         during read.
  */
 
 #include "qemu/osdep.h"
-- 
2.21.0


