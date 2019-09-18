Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E67C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:31:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ADF4218AE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="DdhzLdWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ADF4218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAjPb-0004E0-OG
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAjEY-0000Io-As
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAjEX-0002WS-2A
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:38 -0400
Received: from mail-eopbgr680129.outbound.protection.outlook.com
 ([40.107.68.129]:42238 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAjEW-0002Vm-Sc
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=do1fiXYn9zn7VH8g0T5kLXVmZ2nhZfXRNgiJjY+Trtgu/qHp5cgB25nQQHC+jVfRtelHahTrsL9PBGeKyWI1JTe49hYTjG8NRLlGtAnV/cEFuRb6Jv0JLKTf+s/nkO4ZyV82gIe/09enAEfyt1YJDLFx6W25H75Nan/Avn9bk+FjqrWYXgWR5+CNKMV+tyz3BNgSvMbzAlK9a7UrG5kzg2A38Qpq7IhssM8x3ryppJAe389iI1oM6cyScxG2WHF/FICnYXUgX5h5BR0VPkemkhW9+28GITuuIi4ffceSS/QblJt4jmosDuAdPzBP49W75ljTvtPIgmVGc+xUyHu8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2izqZJkASHESNPbDHoHBQTjXBKSGF86bMlZIo/9vuKo=;
 b=gqpLAaemrmcuVPscUB0GqnX6JL+lKsgZ6vYZtAPav9o2FtDMYaZXJFx5INky9o/RgV2UaYjOEdkadV2bF4yn/FK9kR4Dpp9NHWmk+Ay8KyS71+tPFXXhBPph0aHNWaeiIhYdXxQLNHZvV4Yh0Uxwi2YSdN/Ee4cYJ+W+A01X8aomnXPJU13+5b6oGG/W/chme4+YbD3lOHXzRJCzyQ8l0NpkAGSjrE+uQ80ynoFqTTMBZ4XmjigQO1RHZ5ch/4327JLvo1qdb/M9V+2uvVc7nRlzDJ3aJ/JV4VBqWYMd6gZqZ8EOMue37OQea+Q+UVVSbEK1E0bAoYQevXnIjNiIWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2izqZJkASHESNPbDHoHBQTjXBKSGF86bMlZIo/9vuKo=;
 b=DdhzLdWTYYnAuxIMRjAzR8m0oFE8X66uBkskEDodwFp3eP+8u2CFA31CdrebV3+EoTbA28J5Nzw7mjy2ZolxhAbsevOEfFGDAElZH7Q1W79YoZwSRoeD1F/mOBRrB822lzZp5eK0B0NriSyFKRQ2iOECsgAmf3UpvuFZIHOkm9w=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2695.namprd03.prod.outlook.com (10.173.43.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Wed, 18 Sep 2019 23:19:35 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 23:19:34 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 07/22] fuzz: Add target/fuzz makefile rules
Thread-Index: AQHVbneI23stXmJTGUWQ3vuiIwgZRA==
Date: Wed, 18 Sep 2019 23:19:34 +0000
Message-ID: <20190918231846.22538-8-alxndr@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
In-Reply-To: <20190918231846.22538-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e130272c-1c22-49ec-a276-08d73c8eaab5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB2695; 
x-ms-traffictypediagnostic: CY4PR03MB2695:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB2695ACB9E71B430251284E38BA8E0@CY4PR03MB2695.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(199004)(189003)(2501003)(36756003)(86362001)(316002)(2351001)(6916009)(3846002)(6486002)(6506007)(6436002)(76176011)(386003)(52116002)(88552002)(75432002)(2906002)(99286004)(5660300002)(5640700003)(6116002)(6512007)(4326008)(25786009)(7736002)(186003)(50226002)(305945005)(102836004)(66476007)(446003)(26005)(2616005)(476003)(66446008)(478600001)(71190400001)(14454004)(64756008)(71200400001)(66066001)(14444005)(786003)(8676002)(54906003)(1076003)(486006)(11346002)(66556008)(66946007)(8936002)(81166006)(81156014)(256004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2695;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Crnj6rxPqUIODn02d6jFUmV5lN2PpVnYGnR20NyhCcxVN4RfGjNJ346Ex6jV3Ui8Yg0BCsfStNrh20F1JMRTPQUpsdVOZ4hWuvYboV+aDIUXBg/C6D3Akka/2hISkaiaQIB5FoSudcoNZUokRHZiWwglgn7cqHgDubyu9//tmEO6R02PwbiOGRRY6a8ihOANqb3oSJ5e8oCtHvlzsTk6iCp3P6dMYPYUS4k05ybwIPtGUMWp83xV5568bqF9ltErg8r+e9ME666NbH8rbkTAYoGmZxj6NHCTsOdduzzA1YrZqyXYUoGnRCy/6v6Nj+Qt/ZswrE5nYvvRYN87GPkMVjH8IThMMpjjt26opIu+kd1RY+4WU3F53tdJhlNpuH5+oaWpzASqcuFtKc0mxt7QfHTOluiG37gZ+ummbHZ+cEQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e130272c-1c22-49ec-a276-08d73c8eaab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 23:19:34.4976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gcyRLXctN6SFZU/sNV1rWI9YRnXffjBgb7qf00JZFnN+pDOHA33njmps/a5C/zGb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2695
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.129
Subject: [Qemu-devel] [PATCH v3 07/22] fuzz: Add target/fuzz makefile rules
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
Note that with this you cannot configure with --enable-fuzzing to build
/all targets. Even if you could, you would need to clean all of the *.o
between builds, since fuzzing adds instrumentation CFLAGS.


 Makefile                    | 15 ++++++++++++++-
 Makefile.target             | 16 ++++++++++++++++
 tests/fuzz/Makefile.include |  4 ++++
 3 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 tests/fuzz/Makefile.include

diff --git a/Makefile b/Makefile
index f628783571..3a43492340 100644
--- a/Makefile
+++ b/Makefile
@@ -453,7 +453,7 @@ config-host.h-timestamp: config-host.mak
 qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@=
")
=20
-TARGET_DIRS_RULES :=3D $(foreach t, all clean install, $(addsuffix /$(t), =
$(TARGET_DIRS)))
+TARGET_DIRS_RULES :=3D $(foreach t, all fuzz clean install, $(addsuffix /$=
(t), $(TARGET_DIRS)))
=20
 SOFTMMU_ALL_RULES=3D$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
 $(SOFTMMU_ALL_RULES): $(authz-obj-y)
@@ -465,6 +465,15 @@ $(SOFTMMU_ALL_RULES): config-all-devices.mak
 $(SOFTMMU_ALL_RULES): $(edk2-decompressed)
 $(SOFTMMU_ALL_RULES): $(softmmu-main-y)
=20
+SOFTMMU_FUZZ_RULES=3D$(filter %-softmmu/fuzz, $(TARGET_DIRS_RULES))
+$(SOFTMMU_FUZZ_RULES): $(authz-obj-y)
+$(SOFTMMU_FUZZ_RULES): $(block-obj-y)
+$(SOFTMMU_FUZZ_RULES): $(chardev-obj-y)
+$(SOFTMMU_FUZZ_RULES): $(crypto-obj-y)
+$(SOFTMMU_FUZZ_RULES): $(io-obj-y)
+$(SOFTMMU_FUZZ_RULES): config-all-devices.mak
+$(SOFTMMU_FUZZ_RULES): $(edk2-decompressed)
+
 .PHONY: $(TARGET_DIRS_RULES)
 # The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
 # $(dir $@) yields the sub-directory, and $(notdir $@) yields the sub-goal
@@ -511,6 +520,9 @@ subdir-slirp: slirp/all
 $(filter %/all, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
 	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
=20
+$(filter %/fuzz, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
+	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
+
 ROM_DIRS =3D $(addprefix pc-bios/, $(ROMS))
 ROM_DIRS_RULES=3D$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
 # Only keep -O and -g cflags
@@ -520,6 +532,7 @@ $(ROM_DIRS_RULES):
=20
 .PHONY: recurse-all recurse-clean recurse-install
 recurse-all: $(addsuffix /all, $(TARGET_DIRS) $(ROM_DIRS))
+recurse-fuzz: $(addsuffix /fuzz, $(TARGET_DIRS) $(ROM_DIRS))
 recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(ROM_DIRS))
 recurse-install: $(addsuffix /install, $(TARGET_DIRS))
 $(addsuffix /install, $(TARGET_DIRS)): all
diff --git a/Makefile.target b/Makefile.target
index 5e916230c4..6065989964 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -227,6 +227,22 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 	rm -f *.stp
 endif
=20
+ifdef CONFIG_FUZZ
+include $(SRC_PATH)/tests/fuzz/Makefile.include
+include $(SRC_PATH)/tests/Makefile.include
+
+fuzz: fuzz-vars
+fuzz-vars: QEMU_CFLAGS :=3D $(FUZZ_CFLAGS) $(QEMU_CFLAGS)
+fuzz-vars: QEMU_LDFLAGS :=3D $(FUZZ_LDFLAGS) $(QEMU_LDFLAGS)
+fuzz-vars: $(QEMU_PROG_FUZZ)
+dummy :=3D $(call unnest-vars,, fuzz-obj-y)
+
+
+$(QEMU_PROG_FUZZ): config-devices.mak $(all-obj-y) $(COMMON_LDADDS) $(fuzz=
-obj-y)
+	$(call LINK, $(filter-out %.mak, $^))
+
+endif
+
 install: all
 ifneq ($(PROGS),)
 	$(call install-prog,$(PROGS),$(DESTDIR)$(bindir))
diff --git a/tests/fuzz/Makefile.include b/tests/fuzz/Makefile.include
new file mode 100644
index 0000000000..324e6c1433
--- /dev/null
+++ b/tests/fuzz/Makefile.include
@@ -0,0 +1,4 @@
+# QEMU_PROG_FUZZ=3Dqemu-fuzz-$(TARGET_NAME)$(EXESUF)
+fuzz-obj-y =3D $(libqos-obj-y)
+fuzz-obj-y +=3D tests/libqtest.o
+
--=20
2.23.0


