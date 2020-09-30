Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEA8C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 20:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A77E52071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 20:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHviVrMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77E52071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNjCS-0006U8-Mw
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 16:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kNj0B-0003Wh-Fr
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:47:03 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kNizz-0006UF-Cq
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:47:03 -0400
Received: by mail-wr1-x444.google.com with SMTP id w5so3248987wrp.8
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 13:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DpnWaHg4hzEO5NtJtUfCCrOkV5UyFXzK6KVmdaf7Hck=;
 b=BHviVrMNJ3O52cjKYDmG9HWTj4DaRtxbwk7wKTla+jEqJ+HvrthuSZfockGKyBqt+d
 L/znlK55/E9x9MMnvIFPoqdAmcm0A2y9HMz8Oxod1euSWL0C63BvFFxj7wamnoSY9+vF
 ebXXlXIEJWZoK0YDkShjioxsinXRXW8samGLCW07VIVL84hnwz0jYTAN/NdjLAlCw2yU
 OGDrEpb3ONhhB1tGnymfj61NTuU0mwnzZSFfKrrYedzWvZXDSbeXEFLPK3PCSawTFqnd
 uLnwQ4Yf6NWnfQUB6E3YbUNkHEnchKuAroNcPT305YrRAywnb0QB5/2aVvpD+YpJKFV+
 X7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DpnWaHg4hzEO5NtJtUfCCrOkV5UyFXzK6KVmdaf7Hck=;
 b=G7J9JFBsCU89XYGmpQEImM/4oPgmPDf1m1jEWRuWBiB9cNz91auA1fY181HWwdj21O
 ImuCNBPBr2R8t5StgtD4/q6uLFgVYEyPnGzkM6GPSD57YqYgObe0aKXuOSsfFzpNN0Z2
 Kr9UrsilXspYiS56afGhOGIYSWsDQvR4vBw3UmZqiZxoYZzd5uTqaQaI6BMiIdZDBVO0
 oPfeT66d1fV4C3KCuQo6RSkzKMEzCqx/dCtLvdUGzKNFvZsamQc00/MSrqEBJYMGyQXC
 mgupEfwMVzChCFhW6yvrjHVp5VU9K7wTxMCWF9E2dq7a6b13sWqTiCkteeytMcP86f2a
 leLw==
X-Gm-Message-State: AOAM533BBIcC8SVCoCOeI/e1i4tif/IPlGt/dZ7V4Gl3RnTanb//4IWe
 0W5zQK6VuqBy0Wtzm9xZuJXEC0AmyjrWtw==
X-Google-Smtp-Source: ABdhPJyapevol/p0GBILie1jWav9pMKCX4cAd8evBQVVzW4IQVubBGE/jeHgV1/6+1Ieyh36tIiExg==
X-Received: by 2002:adf:a49d:: with SMTP id g29mr5355058wrb.219.1601498808961; 
 Wed, 30 Sep 2020 13:46:48 -0700 (PDT)
Received: from cmiranda-laptop.localdomain ([188.251.240.167])
 by smtp.gmail.com with ESMTPSA id v204sm5310764wmg.20.2020.09.30.13.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 13:46:48 -0700 (PDT)
From: cupertinomiranda@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 11/14] arc: Add gdbstub and XML for debugging support
Date: Wed, 30 Sep 2020 21:46:01 +0100
Message-Id: <20200930204604.20663-12-cupertinomiranda@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200930204604.20663-1-cupertinomiranda@gmail.com>
References: <20200930204604.20663-1-cupertinomiranda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=cupertinomiranda@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Claudiu Zissulescu <claziss@gmail.com>,
 Cupertino Miranda <cupertinomiranda@gmail.com>,
 Shahab Vahedi <shahab.vahedi@gmail.com>, Shahab Vahedi <shahab@synopsys.com>,
 Cupertino Miranda <cmiranda@synopsys.com>, linux-snps-arc@lists.infradead.org,
 Claudiu Zissulescu <claziss@synopsys.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shahab Vahedi <shahab@synopsys.com>

Register layout for the target and the mechanisms to read and set them.

Signed-off-by: Shahab Vahedi <shahab@synopsys.com>
---
 gdb-xml/arc-aux-minimal.xml |  32 +++
 gdb-xml/arc-aux-other.xml   | 235 ++++++++++++++++++++
 gdb-xml/arc-core-v2.xml     |  45 ++++
 target/arc/gdbstub.c        | 421 ++++++++++++++++++++++++++++++++++++
 4 files changed, 733 insertions(+)
 create mode 100644 gdb-xml/arc-aux-minimal.xml
 create mode 100644 gdb-xml/arc-aux-other.xml
 create mode 100644 gdb-xml/arc-core-v2.xml
 create mode 100644 target/arc/gdbstub.c

diff --git a/gdb-xml/arc-aux-minimal.xml b/gdb-xml/arc-aux-minimal.xml
new file mode 100644
index 0000000000..7809c97a8d
--- /dev/null
+++ b/gdb-xml/arc-aux-minimal.xml
@@ -0,0 +1,32 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2018 Free Software Foundation, Inc.
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.arc.aux-minimal">
+  <flags id="status32_type" size="4">
+      <field name="H"   start="0"  end="0"/>
+      <field name="E"   start="1"  end="4"/>
+      <field name="AE"  start="5"  end="5"/>
+      <field name="DE"  start="6"  end="6"/>
+      <field name="U"   start="7"  end="7"/>
+      <field name="V"   start="8"  end="8"/>
+      <field name="C"   start="9"  end="9"/>
+      <field name="N"   start="10" end="10"/>
+      <field name="Z"   start="11" end="11"/>
+      <field name="L"   start="12" end="12"/>
+      <field name="DZ"  start="13" end="13"/>
+      <field name="SC"  start="14" end="14"/>
+      <field name="ES"  start="15" end="15"/>
+      <field name="RB"  start="16" end="18"/>
+      <field name="AD"  start="19" end="19"/>
+      <field name="US"  start="20" end="20"/>
+      <field name="IE"  start="31" end="31"/>
+  </flags>
+  <reg name="pc"       bitsize="32" regnum="36" type="code_ptr"      group="general"/>
+  <reg name="lp_start" bitsize="32" regnum="37" type="code_ptr"      group="general"/>
+  <reg name="lp_end"   bitsize="32" regnum="38" type="code_ptr"      group="general"/>
+  <reg name="status32" bitsize="32" regnum="39" type="status32_type" group="general"/>
+</feature>
diff --git a/gdb-xml/arc-aux-other.xml b/gdb-xml/arc-aux-other.xml
new file mode 100644
index 0000000000..86b114af98
--- /dev/null
+++ b/gdb-xml/arc-aux-other.xml
@@ -0,0 +1,235 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2018 Free Software Foundation, Inc.
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.arc.aux-other">
+  <flags id="timer_build_type" size="4">
+    <field name="version" start="0"  end="7"/>
+    <field name="t0"      start="8"  end="8"/>
+    <field name="t1"      start="9"  end="9"/>
+    <field name="rtc"     start="10" end="10"/>
+    <field name="p0"      start="16" end="19"/>
+    <field name="p1"      start="20" end="23"/>
+  </flags>
+  <flags id="irq_build_type" size="4">
+    <field name="version" start="0"  end="7"/>
+    <field name="IRQs"    start="8"  end="15"/>
+    <field name="exts"    start="16" end="23"/>
+    <field name="p"       start="24" end="27"/>
+    <field name="f"       start="28" end="28"/>
+  </flags>
+  <flags id="mpy_build_type" size="4">
+    <field name="version32x32" start="0"  end="7"/>
+    <field name="type"         start="8"  end="9"/>
+    <field name="cyc"          start="10" end="11"/>
+    <field name="DSP"          start="12" end="15"/>
+    <field name="version16x16" start="16" end="23"/>
+  </flags>
+  <flags id="vecbase_build_type" size="4">
+    <field name="version" start="2"  end="9"/>
+    <field name="addr"    start="10" end="31"/>
+  </flags>
+  <flags id="isa_config_type" size="4">
+    <field name="version"   start="0"  end="7"/>
+    <field name="pc_size"   start="8"  end="11"/>
+    <field name="lpc_size"  start="12" end="15"/>
+    <field name="addr_size" start="16" end="19"/>
+    <field name="b"         start="20" end="20"/>
+    <field name="a"         start="21" end="21"/>
+    <field name="n"         start="22" end="22"/>
+    <field name="l"         start="23" end="23"/>
+    <field name="c"         start="24" end="27"/>
+    <field name="d"         start="28" end="31"/>
+  </flags>
+  <flags id="timer_ctrl_type" size="4">
+    <field name="ie" start="0" end="0"/>
+    <field name="nh" start="1" end="1"/>
+    <field name="w"  start="2" end="2"/>
+    <field name="ip" start="3" end="3"/>
+    <field name="pd" start="4" end="4"/>
+  </flags>
+  <flags id="tlbpd0_type" size="4">
+    <field name="a"   start="0"  end="7"  type="uint8"/>
+    <field name="g"   start="8"  end="8"  type="bool"/>
+    <field name="v"   start="9"  end="9"  type="bool"/>
+    <field name="sz " start="10" end="10" type="bool"/>
+    <field name="vpn" start="12" end="30" type="uint32"/>
+    <field name="s"   start="31" end="31" type="bool"/>
+  </flags>
+  <flags id="tlbpd1_type" size="4">
+    <field name="fc"  start="0"  end="0"/>
+    <field name="eu"  start="1"  end="1"/>
+    <field name="wu"  start="2"  end="2"/>
+    <field name="ru"  start="3"  end="3"/>
+    <field name="ek"  start="4"  end="4"/>
+    <field name="wk"  start="5"  end="5"/>
+    <field name="rk"  start="6"  end="6"/>
+    <field name="ppn" start="12" end="31"/>
+  </flags>
+  <flags id="tlbindex_type" size="4">
+    <field name="index" start="0"  end="12"/>
+    <field name="rc"    start="28" end="30"/>
+    <field name="e"     start="31" end="31"/>
+  </flags>
+  <flags id="tlbcmd_type" size="4">
+    <field name="cmd" start="0" end="5"/>
+  </flags>
+  <flags id="pid_type" size="4">
+    <field name="p" start="0"  end="7" />
+    <field name="s" start="29" end="29"/>
+    <field name="t" start="31" end="31"/>
+  </flags>
+  <flags id="erstatus_type" size="4">
+    <field name="e"  start="1"  end="4" />
+    <field name="ae" start="5"  end="5" />
+    <field name="de" start="6"  end="6" />
+    <field name="u"  start="7"  end="7" />
+    <field name="v"  start="8"  end="8" />
+    <field name="c"  start="9"  end="9" />
+    <field name="n"  start="10" end="10"/>
+    <field name="z"  start="11" end="11"/>
+    <field name="l"  start="12" end="12"/>
+    <field name="dz" start="13" end="13"/>
+    <field name="sc" start="14" end="14"/>
+    <field name="es" start="15" end="15"/>
+    <field name="rb" start="16" end="18"/>
+    <field name="ad" start="19" end="19"/>
+    <field name="us" start="20" end="20"/>
+    <field name="ie" start="31" end="31"/>
+  </flags>
+  <flags id="ecr_type" size="4">
+    <field name="parameter"    start="0"  end="7" />
+    <field name="causecode"    start="8"  end="15"/>
+    <field name="vectornumber" start="16" end="23"/>
+    <field name="u"            start="30" end="30"/>
+    <field name="p"            start="31" end="31"/>
+  </flags>
+  <flags id="irq_ctrl_type" size="4">
+    <field name="nr" start="0"  end="4"/>
+    <field name="b"  start="9"  end="9"/>
+    <field name="l"  start="10" end="10"/>
+    <field name="u"  start="11" end="11"/>
+    <field name="lp" start="13" end="13"/>
+  </flags>
+  <flags id="irq_act_type" size="4">
+    <field name="active" start="0" end="15"/>
+    <field name="u" start="31" end="31"/>
+  </flags>
+  <flags id="irq_status_type" size="4">
+    <field name="p"  start="0"  end="3"/>
+    <field name="e"  start="4"  end="4"/>
+    <field name="t"  start="5"  end="5"/>
+    <field name="ip" start="31" end="31"/>
+  </flags>
+  <flags id="mpu_build_type" size="4">
+    <field name="version" start="0" end="7"/>
+    <field name="regions" start="8" end="15"/>
+  </flags>
+  <flags id="mpuen_type" size="4">
+    <field name="ue" start="3"  end="3"/>
+    <field name="uw" start="4"  end="4"/>
+    <field name="ur" start="5"  end="5"/>
+    <field name="ke" start="6"  end="6"/>
+    <field name="kw" start="7"  end="7"/>
+    <field name="kr" start="8"  end="8"/>
+    <field name="en" start="30" end="30"/>
+  </flags>
+  <flags id="mpuecr_type" size="4">
+    <field name="mr"      start="0"  end="7"/>
+    <field name="vt"      start="8"  end="9"/>
+    <field name="ec_code" start="16" end="31"/>
+  </flags>
+  <flags id="mpurdb_type" size="4">
+    <field name="v"         start="0" end="0"/>
+    <field name="base_addr" start="5" end="31"/>
+  </flags>
+  <flags id="mpurdp_type" size="4">
+    <field name="size_lower" start="0"  end="1"/>
+    <field name="ue"         start="3"  end="3"/>
+    <field name="uw"         start="4"  end="4"/>
+    <field name="ur"         start="5"  end="5"/>
+    <field name="ke"         start="6"  end="6"/>
+    <field name="kw"         start="7"  end="7"/>
+    <field name="kr"         start="8"  end="8"/>
+    <field name="size_upper" start="9"  end="11"/>
+  </flags>
+  <!-- build registers -->
+  <reg name="timer_build"   bitsize="32" regnum="40" type="timer_build_type"   group=""/>
+  <reg name="irq_build"     bitsize="32" regnum="41" type="irq_build_type"     group=""/>
+  <reg name="mpy_build"     bitsize="32" regnum="42" type="mpy_build_type"     group=""/>
+  <reg name="vecbase_build" bitsize="32" regnum="43" type="vecbase_build_type" group=""/>
+  <reg name="isa_config"    bitsize="32" regnum="44" type="isa_config_type"    group=""/>
+  <!-- timer registers -->
+  <reg name="timer_count0" bitsize="32" regnum="45"                        group="general"/>
+  <reg name="timer_ctrl0"  bitsize="32" regnum="46" type="timer_ctrl_type" group="general"/>
+  <reg name="timer_limit0" bitsize="32" regnum="47"                        group="general"/>
+  <reg name="timer_count1" bitsize="32" regnum="48"                        group="general"/>
+  <reg name="timer_ctrl1"  bitsize="32" regnum="49" type="timer_ctrl_type" group="general"/>
+  <reg name="timer_limit1" bitsize="32" regnum="50"                        group="general"/>
+  <!-- mmu registers -->
+  <reg name="pid"      bitsize="32" regnum="51" type="pid_type"      group="general"/>
+  <reg name="tlbpd0"   bitsize="32" regnum="52" type="tlbpd0_type"   group="general"/>
+  <reg name="tlbpd1"   bitsize="32" regnum="53" type="tlbpd1_type"   group="general"/>
+  <reg name="tlbindex" bitsize="32" regnum="54" type="tlbindex_type" group="general"/>
+  <reg name="tlbcmd"   bitsize="32" regnum="55" type="tlbcmd_type"   group="general"/>
+  <!-- mpu registers -->
+  <reg name="mpu_build" bitsize="32" regnum="56"  type="mpu_build_type" group=""/>
+  <reg name="mpuen"     bitsize="32" regnum="57"  type="mpuen_type"     group=""/>
+  <reg name="mpuecr"    bitsize="32" regnum="58"  type="mpuecr_type"    group=""/>
+  <reg name="mpurdb0"   bitsize="32" regnum="59"  type="mpurdb_type"    group=""/>
+  <reg name="mpurdb1"   bitsize="32" regnum="60"  type="mpurdb_type"    group=""/>
+  <reg name="mpurdb2"   bitsize="32" regnum="61"  type="mpurdb_type"    group=""/>
+  <reg name="mpurdb3"   bitsize="32" regnum="62"  type="mpurdb_type"    group=""/>
+  <reg name="mpurdb4"   bitsize="32" regnum="63"  type="mpurdb_type"    group=""/>
+  <reg name="mpurdb5"   bitsize="32" regnum="64"  type="mpurdb_type"    group=""/>
+  <reg name="mpurdb6"   bitsize="32" regnum="65"  type="mpurdb_type"    group=""/>
+  <reg name="mpurdb7"   bitsize="32" regnum="66"  type="mpurdb_type"    group=""/>
+  <reg name="mpurdb8"   bitsize="32" regnum="67"  type="mpurdb_type"    group=""/>
+  <reg name="mpurdb9"   bitsize="32" regnum="68"  type="mpurdb_type"    group=""/>
+  <reg name="mpurdb10"  bitsize="32" regnum="69"  type="mpurdb_type"    group=""/>
+  <reg name="mpurdb11"  bitsize="32" regnum="70"  type="mpurdb_type"    group=""/>
+  <reg name="mpurdb12"  bitsize="32" regnum="71"  type="mpurdb_type"    group=""/>
+  <reg name="mpurdb13"  bitsize="32" regnum="72"  type="mpurdb_type"    group=""/>
+  <reg name="mpurdb14"  bitsize="32" regnum="73"  type="mpurdb_type"    group=""/>
+  <reg name="mpurdb15"  bitsize="32" regnum="74"  type="mpurdb_type"    group=""/>
+  <reg name="mpurdp0"   bitsize="32" regnum="75"  type="mpurdp_type"    group=""/>
+  <reg name="mpurdp1"   bitsize="32" regnum="76"  type="mpurdp_type"    group=""/>
+  <reg name="mpurdp2"   bitsize="32" regnum="77"  type="mpurdp_type"    group=""/>
+  <reg name="mpurdp3"   bitsize="32" regnum="78"  type="mpurdp_type"    group=""/>
+  <reg name="mpurdp4"   bitsize="32" regnum="79"  type="mpurdp_type"    group=""/>
+  <reg name="mpurdp5"   bitsize="32" regnum="80"  type="mpurdp_type"    group=""/>
+  <reg name="mpurdp6"   bitsize="32" regnum="81"  type="mpurdp_type"    group=""/>
+  <reg name="mpurdp7"   bitsize="32" regnum="82"  type="mpurdp_type"    group=""/>
+  <reg name="mpurdp8"   bitsize="32" regnum="83"  type="mpurdp_type"    group=""/>
+  <reg name="mpurdp9"   bitsize="32" regnum="84"  type="mpurdp_type"    group=""/>
+  <reg name="mpurdp10"  bitsize="32" regnum="85"  type="mpurdp_type"    group=""/>
+  <reg name="mpurdp11"  bitsize="32" regnum="86"  type="mpurdp_type"    group=""/>
+  <reg name="mpurdp12"  bitsize="32" regnum="87"  type="mpurdp_type"    group=""/>
+  <reg name="mpurdp13"  bitsize="32" regnum="88"  type="mpurdp_type"    group=""/>
+  <reg name="mpurdp14"  bitsize="32" regnum="89"  type="mpurdp_type"    group=""/>
+  <reg name="mpurdp15"  bitsize="32" regnum="90"  type="mpurdp_type"    group=""/>
+  <!-- exception registers -->
+  <reg name="erstatus" bitsize="32" regnum="91" type="erstatus_type" group="general"/>
+  <reg name="erbta"    bitsize="32" regnum="92" type="code_ptr"      group="general"/>
+  <reg name="ecr"      bitsize="32" regnum="93" type="ecr_type"      group="general"/>
+  <reg name="eret"     bitsize="32" regnum="94" type="code_ptr"      group="general"/>
+  <reg name="efa"      bitsize="32" regnum="95" type="uint32"        group="general"/>
+  <!-- irq registers -->
+  <reg name="icause"               bitsize="32" regnum="96"  type="uint8"           group="general"/>
+  <reg name="aux_irq_ctrl"         bitsize="32" regnum="97"  type="irq_ctrl_type"   group="general"/>
+  <reg name="aux_irq_act"          bitsize="32" regnum="98"  type="irq_act_type"    group="general"/>
+  <reg name="irq_priority_pending" bitsize="32" regnum="99"  type="uint16"          group="general"/>
+  <reg name="aux_irq_hint"         bitsize="32" regnum="100" type="uint8"           group="general"/>
+  <reg name="irq_select"           bitsize="32" regnum="101" type="uint8"           group="general"/>
+  <reg name="irq_enable"           bitsize="32" regnum="102" type="bool"            group="general"/>
+  <reg name="irq_trigger"          bitsize="32" regnum="103" type="bool"            group="general"/>
+  <reg name="irq_status"           bitsize="32" regnum="104" type="irq_status_type" group="general"/>
+  <reg name="irq_pulse_cancel"     bitsize="32" regnum="105" type="bool"            group="general"/>
+  <reg name="irq_pending"          bitsize="32" regnum="106" type="bool"            group="general"/>
+  <reg name="irq_priority"         bitsize="32" regnum="107" type="uint8"           group="general"/>
+  <!-- miscellaneous -->
+  <reg name="bta" bitsize="32" regnum="108" type="code_ptr" group="general"/>
+</feature>
diff --git a/gdb-xml/arc-core-v2.xml b/gdb-xml/arc-core-v2.xml
new file mode 100644
index 0000000000..550dae3411
--- /dev/null
+++ b/gdb-xml/arc-core-v2.xml
@@ -0,0 +1,45 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2018 Free Software Foundation, Inc.
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.arc.core.v2">
+  <reg name="r0"       bitsize="32" regnum="0"                  group="general"/>
+  <reg name="r1"       bitsize="32" regnum="1"                  group="general"/>
+  <reg name="r2"       bitsize="32" regnum="2"                  group="general"/>
+  <reg name="r3"       bitsize="32" regnum="3"                  group="general"/>
+  <reg name="r4"       bitsize="32" regnum="4"                  group="general"/>
+  <reg name="r5"       bitsize="32" regnum="5"                  group="general"/>
+  <reg name="r6"       bitsize="32" regnum="6"                  group="general"/>
+  <reg name="r7"       bitsize="32" regnum="7"                  group="general"/>
+  <reg name="r8"       bitsize="32" regnum="8"                  group="general"/>
+  <reg name="r9"       bitsize="32" regnum="9"                  group="general"/>
+  <reg name="r10"      bitsize="32" regnum="10"                 group="general"/>
+  <reg name="r11"      bitsize="32" regnum="11"                 group="general"/>
+  <reg name="r12"      bitsize="32" regnum="12"                 group="general"/>
+  <reg name="r13"      bitsize="32" regnum="13"                 group="general"/>
+  <reg name="r14"      bitsize="32" regnum="14"                 group="general"/>
+  <reg name="r15"      bitsize="32" regnum="15"                 group="general"/>
+  <reg name="r16"      bitsize="32" regnum="16"                 group="general"/>
+  <reg name="r17"      bitsize="32" regnum="17"                 group="general"/>
+  <reg name="r18"      bitsize="32" regnum="18"                 group="general"/>
+  <reg name="r19"      bitsize="32" regnum="19"                 group="general"/>
+  <reg name="r20"      bitsize="32" regnum="20"                 group="general"/>
+  <reg name="r21"      bitsize="32" regnum="21"                 group="general"/>
+  <reg name="r22"      bitsize="32" regnum="22"                 group="general"/>
+  <reg name="r23"      bitsize="32" regnum="23"                 group="general"/>
+  <reg name="r24"      bitsize="32" regnum="24"                 group="general"/>
+  <reg name="r25"      bitsize="32" regnum="25"                 group="general"/>
+  <reg name="gp"       bitsize="32" regnum="26" type="data_ptr" group="general"/>
+  <reg name="fp"       bitsize="32" regnum="27" type="data_ptr" group="general"/>
+  <reg name="sp"       bitsize="32" regnum="28" type="data_ptr" group="general"/>
+  <reg name="ilink"    bitsize="32" regnum="29" type="code_ptr" group="general"/>
+  <reg name="r30"      bitsize="32" regnum="30"                 group="general"/>
+  <reg name="blink"    bitsize="32" regnum="31" type="code_ptr" group="general"/>
+  <reg name="accl"     bitsize="32" regnum="32"                 group="general"/>
+  <reg name="acch"     bitsize="32" regnum="33"                 group="general"/>
+  <reg name="lp_count" bitsize="32" regnum="34" type="uint32"   group="general"/>
+  <reg name="pcl"      bitsize="32" regnum="35" type="code_ptr" group="general"/>
+</feature>
diff --git a/target/arc/gdbstub.c b/target/arc/gdbstub.c
new file mode 100644
index 0000000000..574e8fdf4b
--- /dev/null
+++ b/target/arc/gdbstub.c
@@ -0,0 +1,421 @@
+
+/*
+ * QEMU ARC CPU
+ *
+ * Copyright (c) 2016 Michael Rolnik
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * http://www.gnu.org/licenses/lgpl-2.1.html
+ */
+
+#include "qemu/osdep.h"
+#include "exec/gdbstub.h"
+#include "arc-common.h"
+#include "target/arc/regs.h"
+#include "internals.h"
+#include "irq.h"
+
+/* gets the register address for a particular processor */
+#define REG_ADDR(reg, processor_type) \
+    arc_aux_reg_address_for((reg), (processor_type))
+
+int arc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+{
+    ARCCPU *cpu = ARC_CPU(cs);
+    CPUARCState *env = &cpu->env;
+    uint32_t regval = 0;
+
+    switch (n) {
+    case 0 ... 31:
+       regval = env->r[n];
+       break;
+    case GDB_REG_58:
+       regval = env->r[58];
+       break;
+    case GDB_REG_59:
+       regval = env->r[59];
+       break;
+    case GDB_REG_60:
+       regval = env->r[60];
+       break;
+    case GDB_REG_63:
+       regval = env->r[63];
+       break;
+    default:
+       assert(!"Unsupported register is being read.");
+    }
+
+    return gdb_get_reg32(mem_buf, regval);
+}
+
+int arc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    ARCCPU *cpu = ARC_CPU(cs);
+    CPUARCState *env = &cpu->env;
+    uint32_t regval = ldl_p(mem_buf);
+
+    switch (n) {
+    case 0 ... 31:
+        env->r[n] = regval;
+        break;
+    case GDB_REG_58:
+        env->r[58] = regval;
+        break;
+    case GDB_REG_59:
+        env->r[59] = regval;
+        break;
+    case GDB_REG_60:
+        env->r[60] = regval;
+        break;
+    case GDB_REG_63:
+        env->r[63] = regval;
+        break;
+    default:
+        assert(!"Unsupported register is being written.");
+    }
+
+    return 4;
+}
+
+
+static int
+arc_aux_minimal_gdb_get_reg(CPUARCState *env, GByteArray *mem_buf, int regnum)
+{
+    /* TODO: processor type must be set according to configuration */
+    static const int processor = ARC_OPCODE_ARCv2HS;
+    uint32_t regval = 0;
+
+    switch (regnum) {
+    case GDB_AUX_MIN_REG_PC:
+        regval = env->pc & 0xfffffffe;
+        break;
+    case GDB_AUX_MIN_REG_LPS:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_lp_start, processor));
+        break;
+    case GDB_AUX_MIN_REG_LPE:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_lp_end, processor));
+        break;
+    case GDB_AUX_MIN_REG_STATUS:
+        regval = pack_status32(&env->stat);
+        break;
+    default:
+        assert(!"Unsupported minimal auxiliary register is being read.");
+    }
+    return gdb_get_reg32(mem_buf, regval);
+}
+
+
+static int
+arc_aux_minimal_gdb_set_reg(CPUARCState *env, uint8_t *mem_buf, int regnum)
+{
+    /* TODO: processor type must be set according to configuration */
+    static const int processor = ARC_OPCODE_ARCv2HS;
+    uint32_t regval = ldl_p(mem_buf);
+    switch (regnum) {
+    case GDB_AUX_MIN_REG_PC:
+        env->pc = regval & 0xfffffffe;
+        break;
+    case GDB_AUX_MIN_REG_LPS:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_lp_start, processor));
+        break;
+    case GDB_AUX_MIN_REG_LPE:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_lp_end, processor));
+        break;
+    case GDB_AUX_MIN_REG_STATUS:
+        unpack_status32(&env->stat, regval);
+        break;
+    default:
+        assert(!"Unsupported minimal auxiliary register is being written.");
+    }
+    return 4;
+}
+
+
+static int
+arc_aux_other_gdb_get_reg(CPUARCState *env, GByteArray *mem_buf, int regnum)
+{
+    /* TODO: processor type must be set according to configuration */
+    static const int processor = ARC_OPCODE_ARCv2HS;
+    uint32_t regval = 0;
+    switch (regnum) {
+    case GDB_AUX_OTHER_REG_TIMER_BUILD:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_timer_build, processor));
+        break;
+    case GDB_AUX_OTHER_REG_IRQ_BUILD:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_irq_build, processor));
+        break;
+    case GDB_AUX_OTHER_REG_MPY_BUILD:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_mpy_build, processor));
+        break;
+    case GDB_AUX_OTHER_REG_VECBASE_BUILD:
+        regval = env->vecbase_build;
+        break;
+    case GDB_AUX_OTHER_REG_ISA_CONFIG:
+        regval = env->isa_config;
+        break;
+    case GDB_AUX_OTHER_REG_TIMER_CNT0:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_count0, processor));
+        break;
+    case GDB_AUX_OTHER_REG_TIMER_CTRL0:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_control0, processor));
+        break;
+    case GDB_AUX_OTHER_REG_TIMER_LIM0:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_limit0, processor));
+        break;
+    case GDB_AUX_OTHER_REG_TIMER_CNT1:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_count1, processor));
+        break;
+    case GDB_AUX_OTHER_REG_TIMER_CTRL1:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_control1, processor));
+        break;
+    case GDB_AUX_OTHER_REG_TIMER_LIM1:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_limit1, processor));
+        break;
+    case GDB_AUX_OTHER_REG_PID:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_pid, processor));
+        break;
+    case GDB_AUX_OTHER_REG_TLBPD0:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_tlbpd0, processor));
+        break;
+    case GDB_AUX_OTHER_REG_TLBPD1:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_tlbpd1, processor));
+        break;
+    case GDB_AUX_OTHER_REG_TLB_INDEX:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_tlbindex, processor));
+        break;
+    case GDB_AUX_OTHER_REG_TLB_CMD:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_tlbcommand, processor));
+        break;
+    /* MPU */
+    case GDB_AUX_OTHER_REG_MPU_BUILD:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_mpu_build, processor));
+        break;
+    case GDB_AUX_OTHER_REG_MPU_EN:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_mpuen, processor));
+        break;
+    case GDB_AUX_OTHER_REG_MPU_ECR:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_mpuic, processor));
+        break;
+    case GDB_AUX_OTHER_REG_MPU_BASE0 ... GDB_AUX_OTHER_REG_MPU_BASE15: {
+        const uint8_t index = regnum - GDB_AUX_OTHER_REG_MPU_BASE0;
+        regval = helper_lr(env, REG_ADDR(AUX_ID_mpurdb0 + index, processor));
+        break;
+    }
+    case GDB_AUX_OTHER_REG_MPU_PERM0 ... GDB_AUX_OTHER_REG_MPU_PERM15: {
+        const uint8_t index = regnum - GDB_AUX_OTHER_REG_MPU_PERM0;
+        regval = helper_lr(env, REG_ADDR(AUX_ID_mpurdp0 + index, processor));
+        break;
+    }
+    /* exceptions */
+    case GDB_AUX_OTHER_REG_ERSTATUS:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_erstatus, processor));
+        break;
+    case GDB_AUX_OTHER_REG_ERBTA:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_erbta, processor));
+        break;
+    case GDB_AUX_OTHER_REG_ECR:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_ecr, processor));
+        break;
+    case GDB_AUX_OTHER_REG_ERET:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_eret, processor));
+        break;
+    case GDB_AUX_OTHER_REG_EFA:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_efa, processor));
+        break;
+    /* interrupt */
+    case GDB_AUX_OTHER_REG_ICAUSE:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_icause, processor));
+        break;
+    case GDB_AUX_OTHER_REG_IRQ_CTRL:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_aux_irq_ctrl, processor));
+        break;
+    case GDB_AUX_OTHER_REG_IRQ_ACT:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_aux_irq_act, processor));
+        break;
+    case GDB_AUX_OTHER_REG_IRQ_PRIO_PEND:
+        regval = env->irq_priority_pending;
+        break;
+    case GDB_AUX_OTHER_REG_IRQ_HINT:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_aux_irq_hint, processor));
+        break;
+    case GDB_AUX_OTHER_REG_IRQ_SELECT:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_irq_select, processor));
+        break;
+    case GDB_AUX_OTHER_REG_IRQ_ENABLE:
+        regval = env->irq_bank[env->irq_select & 0xff].enable;
+        break;
+    case GDB_AUX_OTHER_REG_IRQ_TRIGGER:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_irq_trigger, processor));
+        break;
+    case GDB_AUX_OTHER_REG_IRQ_STATUS:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_irq_status, processor));
+        break;
+    case GDB_AUX_OTHER_REG_IRQ_PULSE:
+        regval = 0; /* write only for clearing the pulse triggered interrupt */
+        break;
+    case GDB_AUX_OTHER_REG_IRQ_PENDING:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_irq_pending, processor));
+        break;
+    case GDB_AUX_OTHER_REG_IRQ_PRIO:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_irq_priority, processor));
+        break;
+    case GDB_AUX_OTHER_REG_BTA:
+        regval = helper_lr(env, REG_ADDR(AUX_ID_bta, processor));
+        break;
+    default:
+        assert(!"Unsupported other auxiliary register is being read.");
+    }
+    return gdb_get_reg32(mem_buf, regval);
+}
+
+
+static int
+arc_aux_other_gdb_set_reg(CPUARCState *env, uint8_t *mem_buf, int regnum)
+{
+    /* TODO: processor type must be set according to configuration */
+    static const int processor = ARC_OPCODE_ARCv2HS;
+    uint32_t regval = ldl_p(mem_buf);
+    switch (regnum) {
+    case GDB_AUX_OTHER_REG_TIMER_BUILD:
+    case GDB_AUX_OTHER_REG_IRQ_BUILD:
+    case GDB_AUX_OTHER_REG_MPY_BUILD:
+    case GDB_AUX_OTHER_REG_VECBASE_BUILD:
+    case GDB_AUX_OTHER_REG_ISA_CONFIG:
+    case GDB_AUX_OTHER_REG_MPU_BUILD:
+    case GDB_AUX_OTHER_REG_MPU_ECR:
+    case GDB_AUX_OTHER_REG_ICAUSE:
+    case GDB_AUX_OTHER_REG_IRQ_PRIO_PEND:
+    case GDB_AUX_OTHER_REG_IRQ_STATUS:
+    case GDB_AUX_OTHER_REG_IRQ_PENDING:
+        /* builds/configs/exceptions/irqs cannot be changed */
+        break;
+    case GDB_AUX_OTHER_REG_TIMER_CNT0:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_count0, processor));
+        break;
+    case GDB_AUX_OTHER_REG_TIMER_CTRL0:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_control0, processor));
+        break;
+    case GDB_AUX_OTHER_REG_TIMER_LIM0:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_limit0, processor));
+        break;
+    case GDB_AUX_OTHER_REG_TIMER_CNT1:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_count1, processor));
+        break;
+    case GDB_AUX_OTHER_REG_TIMER_CTRL1:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_control1, processor));
+        break;
+    case GDB_AUX_OTHER_REG_TIMER_LIM1:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_limit1, processor));
+        break;
+    case GDB_AUX_OTHER_REG_PID:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_pid, processor));
+        break;
+    case GDB_AUX_OTHER_REG_TLBPD0:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_tlbpd0, processor));
+        break;
+    case GDB_AUX_OTHER_REG_TLBPD1:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_tlbpd1, processor));
+        break;
+    case GDB_AUX_OTHER_REG_TLB_INDEX:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_tlbindex, processor));
+        break;
+    case GDB_AUX_OTHER_REG_TLB_CMD:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_tlbcommand, processor));
+        break;
+    /* MPU */
+    case GDB_AUX_OTHER_REG_MPU_EN:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_mpuen, processor));
+        break;
+    case GDB_AUX_OTHER_REG_MPU_BASE0 ... GDB_AUX_OTHER_REG_MPU_BASE15: {
+        const uint8_t index = regnum - GDB_AUX_OTHER_REG_MPU_BASE0;
+        helper_sr(env, regval, REG_ADDR(AUX_ID_mpurdb0 + index, processor));
+        break;
+    }
+    case GDB_AUX_OTHER_REG_MPU_PERM0 ... GDB_AUX_OTHER_REG_MPU_PERM15: {
+        const uint8_t index = regnum - GDB_AUX_OTHER_REG_MPU_PERM0;
+        helper_sr(env, regval, REG_ADDR(AUX_ID_mpurdp0 + index, processor));
+        break;
+    }
+    /* exceptions */
+    case GDB_AUX_OTHER_REG_ERSTATUS:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_erstatus, processor));
+        break;
+    case GDB_AUX_OTHER_REG_ERBTA:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_erbta, processor));
+        break;
+    case GDB_AUX_OTHER_REG_ECR:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_ecr, processor));
+        break;
+    case GDB_AUX_OTHER_REG_ERET:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_eret, processor));
+        break;
+    case GDB_AUX_OTHER_REG_EFA:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_efa, processor));
+        break;
+    /* interrupt */
+    case GDB_AUX_OTHER_REG_IRQ_CTRL:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_aux_irq_ctrl, processor));
+        break;
+    case GDB_AUX_OTHER_REG_IRQ_ACT:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_aux_irq_act, processor));
+        break;
+    case GDB_AUX_OTHER_REG_IRQ_HINT:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_aux_irq_hint, processor));
+        break;
+    case GDB_AUX_OTHER_REG_IRQ_SELECT:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_irq_select, processor));
+        break;
+    case GDB_AUX_OTHER_REG_IRQ_ENABLE:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_irq_enable, processor));
+        break;
+    case GDB_AUX_OTHER_REG_IRQ_TRIGGER:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_irq_trigger, processor));
+        break;
+    case GDB_AUX_OTHER_REG_IRQ_PULSE:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_irq_pulse_cancel, processor));
+        break;
+    case GDB_AUX_OTHER_REG_IRQ_PRIO:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_irq_priority, processor));
+        break;
+    case GDB_AUX_OTHER_REG_BTA:
+        helper_sr(env, regval, REG_ADDR(AUX_ID_bta, processor));
+        break;
+    default:
+        assert(!"Unsupported other auxiliary register is being written.");
+    }
+    return 4;
+}
+
+
+void arc_cpu_register_gdb_regs_for_features(ARCCPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+
+    gdb_register_coprocessor(cs,
+                             arc_aux_minimal_gdb_get_reg, /* getter */
+                             arc_aux_minimal_gdb_set_reg, /* setter */
+                             GDB_AUX_MIN_REG_LAST,    /* number of registers */
+                             "arc-aux-minimal.xml",       /* feature file */
+                             0);                      /* position in g packet */
+
+    gdb_register_coprocessor(cs,
+                             arc_aux_other_gdb_get_reg,
+                             arc_aux_other_gdb_set_reg,
+                             GDB_AUX_OTHER_REG_LAST,
+                             "arc-aux-other.xml",
+                             0);
+}
+
+/*-*-indent-tabs-mode:nil;tab-width:4;indent-line-function:'insert-tab'-*-*/
+/* vim: set ts=4 sw=4 et: */
-- 
2.20.1


