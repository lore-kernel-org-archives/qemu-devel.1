Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B02C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 23:45:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7435B20702
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 23:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HCQpyZ27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7435B20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbBQC-0000FS-DH
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 18:45:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=572b21b8d=dmitry.fomichev@wdc.com>)
 id 1kbBOW-00065z-7w; Fri, 06 Nov 2020 18:43:48 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:57360)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=572b21b8d=dmitry.fomichev@wdc.com>)
 id 1kbBOT-0003Tq-Sl; Fri, 06 Nov 2020 18:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604706226; x=1636242226;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fYRGLGEOoxEBnGfF2tyEuYZSUoEdxDjp8wNk3+vvDGE=;
 b=HCQpyZ27xbVRX4rzWs+g6Oe0loLfjrPILTkps/JusEkw4h8UXVuWIzsX
 wOyED/iejWUHuKyFxB3AEoCz0HTNhdhx69KcRWo6fWnYpTFN1TKoNEQGB
 eMUewM/8fKeCxr5Ib2lR0T7KQG/sHYEeIL1C1EPvcaXFPNZeGgAZEsdD9
 W51e17cYDGORAN6gbBXcj6gtJqUUG/wGthQGb6PgYXIsm8IzPIgAfsRYb
 iOqycUZ1+Mt3qGAdfzkwbA3MYgzO3s9qYFmmuwlePkpiSk4fBIxCpNlv7
 NksUJ1wEQ9J8i3ldrLRoWNh3KXSgWONr3JbCUinM+/F5sXi7TTaxPqz5G g==;
IronPort-SDR: 2NW0z+4hkOzEFlzaCSQPo2kmAm6/pL/LqWnhbyu5Gx99iT+LKG+drUZPA4dW9OrNn5Ep4yc6GK
 LrdJQ0c3F16DD1wPmdVz/cTDSj9xuY9J38el7o3I0EnAORw6S88owo3OF1IRo1SaLFy/TPFIoZ
 Lh2n1vPZ6jCO6hisaXZe9XyzyAyf/O/7u1hcCLFHAm2Vf5RW7ubRai1t81PwAkj+MzLowWUHak
 ZzDvJTCir+RzwzxkNubVD0JoUC+eOypNjy3YtwU5hH7Oewbb8sLlLylPziOilvngeublKN60hr
 SIE=
X-IronPort-AV: E=Sophos;i="5.77,457,1596470400"; d="scan'208";a="153267080"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 07:43:45 +0800
IronPort-SDR: F/6FZxJQr88nyu/0O6RWpt4/wSn1FPxf8yyxdfkqEqSa9ns96RjkF6ZYK8FJzr9J4y5TlujZnY
 4+YFyfOTTfij5MAbr64Z44dnwwsZ7cybvNMgcmzFmBaAlJzNKcFy4+HrGr+Mc7xsV+OivKNcRr
 6WJOhlnkINvA4X4cx5m97VwvDCeG2mAV4hRSo1XVWLVPajzJGUo4X7fMArOwnrAhYOfA9m52dr
 IIgZ/VWw7G/DsO+MVRBmKhPsNeaE4iGPhLRCZBBUL8coK6OGdPaRkQG00zI12PXjukXi+90jVU
 q7symgHTHBLB/czHwYt+7RPW
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2020 15:28:36 -0800
IronPort-SDR: 1tqXDhHyaKLSVGTR1PEtg1K6N3iblJH1/I+w4I93OFJLIsq6wLzQSSwOlMZDmINfHpeL4aUUXc
 Tc3YFDzGBK6+IQpC0iE1eqNv0F3BpX9ijAu4qjxP9oeaKVe1KT4P4y69tWrB2wzgtCoYbB1KIL
 gwcnyLrYp506zpA2afOnYQTOp7AzA3NcSrDDCaJMi5TkFULUxjD6RIeqQqbdQDrCtmj89y9tV0
 133z2/sXgp1lmF5uFKLBvQWk+R/qGx3N0TnfM/RtqbRTBbBIY7q82F+/94jD9qpJmKiiovZmQ7
 XQM=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 Nov 2020 15:43:42 -0800
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH v10 12/12] hw/block/nvme: Document zoned parameters in usage
 text
Date: Sat,  7 Nov 2020 08:43:05 +0900
Message-Id: <20201106234305.21339-13-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201106234305.21339-1-dmitry.fomichev@wdc.com>
References: <20201106234305.21339-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=572b21b8d=dmitry.fomichev@wdc.com; helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 18:43:12
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Added brief descriptions of the new device properties that are
now available to users to configure features of Zoned Namespace
Command Set in the emulator.

This patch is for documentation only, no functionality change.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Niklas Cassel <Niklas.Cassel@wdc.com>
---
 hw/block/nvme.c | 47 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index e82e3be821..6043f95116 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -9,7 +9,7 @@
  */
 
 /**
- * Reference Specs: http://www.nvmexpress.org, 1.2, 1.1, 1.0e
+ * Reference Specs: http://www.nvmexpress.org, 1.4, 1.3, 1.2, 1.1, 1.0e
  *
  *  https://nvmexpress.org/developers/nvme-specification/
  */
@@ -22,8 +22,9 @@
  *              [pmrdev=<mem_backend_file_id>,] \
  *              max_ioqpairs=<N[optional]>, \
  *              aerl=<N[optional]>, aer_max_queued=<N[optional]>, \
- *              mdts=<N[optional]>
- *      -device nvme-ns,drive=<drive_id>,bus=bus_name,nsid=<nsid>
+ *              mdts=<N[optional]>,zoned.append_size_limit=<N[optional]> \
+ *      -device nvme-ns,drive=<drive_id>,bus=<bus_name>,nsid=<nsid>,\
+ *              zoned=<true|false[optional]>
  *
  * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
  * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
@@ -41,14 +42,50 @@
  * ~~~~~~~~~~~~~~~~~~~~~~
  * - `aerl`
  *   The Asynchronous Event Request Limit (AERL). Indicates the maximum number
- *   of concurrently outstanding Asynchronous Event Request commands suppoert
+ *   of concurrently outstanding Asynchronous Event Request commands support
  *   by the controller. This is a 0's based value.
  *
  * - `aer_max_queued`
  *   This is the maximum number of events that the device will enqueue for
- *   completion when there are no oustanding AERs. When the maximum number of
+ *   completion when there are no outstanding AERs. When the maximum number of
  *   enqueued events are reached, subsequent events will be dropped.
  *
+ * - `zoned.append_size_limit`
+ *   The maximum I/O size in bytes that is allowed in Zone Append command.
+ *   The default is 128KiB. Since internally this this value is maintained as
+ *   ZASL = log2(<maximum append size> / <page size>), some values assigned
+ *   to this property may be rounded down and result in a lower maximum ZA
+ *   data size being in effect. By setting this property to 0, users can make
+ *   ZASL to be equal to MDTS. This property only affects zoned namespaces.
+ *
+ * Setting `zoned` to true selects Zoned Command Set at the namespace.
+ * In this case, the following namespace properties are available to configure
+ * zoned operation:
+ *     zoned.zsze=<zone size in bytes, default: 128MiB>
+ *         The number may be followed by K, M, G as in kilo-, mega- or giga-.
+ *
+ *     zoned.zcap=<zone capacity in bytes, default: zone size>
+ *         The value 0 (default) forces zone capacity to be the same as zone
+ *         size. The value of this property may not exceed zone size.
+ *
+ *     zoned.descr_ext_size=<zone descriptor extension size, default 0>
+ *         This value needs to be specified in 64B units. If it is zero,
+ *         namespace(s) will not support zone descriptor extensions.
+ *
+ *     zoned.max_active=<Maximum Active Resources (zones), default: 0>
+ *         The default value means there is no limit to the number of
+ *         concurrently active zones.
+ *
+ *     zoned.max_open=<Maximum Open Resources (zones), default: 0>
+ *         The default value means there is no limit to the number of
+ *         concurrently open zones.
+ *
+ *     zoned.offline_zones=<the number of offline zones to inject, default: 0>
+ *
+ *     zoned.rdonly_zones=<the number of read-only zones to inject, default: 0>
+ *
+ *     zoned.cross_zone_read=<enable RAZB, default: false>
+ *         Setting this property to true enables Read Across Zone Boundaries.
  */
 
 #include "qemu/osdep.h"
-- 
2.21.0


