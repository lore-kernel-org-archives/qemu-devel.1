Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3514FC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:37:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3319214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bjR930Dz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3319214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSiuT-0005QF-9y
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 09:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1iSiot-0000K4-5U
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1iSior-0002Wy-BL
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:31:30 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1iSior-0002Vv-0P
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:31:29 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7EOHVg018990;
 Thu, 7 Nov 2019 14:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=qCar8QtabLY3mJB+6WWccal2NuHeIjf83LslRy17mhE=;
 b=bjR930DzddGWfns57b2fQRy5yTuZodE4j2jbzAuJsfGqeg4Ymoz7m5r4h2Ncz3rmuNoE
 17ljZJjhHU4EJzCdf1IG8hmKAQA1TK3J3L1nwSQjqoJU1cbag4vdGilm5R1XQ4YWsthQ
 2qRYP50X0TbN2YXTNC2pRmLuIpAUjfLIyeQAWgdVP9NvVr4CipuOyQ8rQyF2vmfKfGhK
 M4XYIQBHmPHUv3/zmJnQpuN25tjYed+gUuXZSsVz6trUuzS0fxA25ywpevGZPXO1E8yf
 Z0HXJbGGOV1IJMh3zTjHcvxqP3Fi3+OlSyLnJtX9PLRPEmgoGDZ/S4TDlrQABFO6RcSM OA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2w41w0xh4r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2019 14:31:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7EOCkB185756;
 Thu, 7 Nov 2019 14:31:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2w41whahx6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2019 14:31:23 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA7EVM25029595;
 Thu, 7 Nov 2019 14:31:22 GMT
Received: from starbug-mbp.localdomain (/10.175.193.46)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 07 Nov 2019 06:31:22 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 743694B2C26B;
 Thu,  7 Nov 2019 14:31:20 +0000 (GMT)
Date: Thu, 7 Nov 2019 14:31:20 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v4 14/20] fuzz: Add target/fuzz makefile rules
Message-ID: <20191107143120.hhrpmx7tblou4pkk@starbug-mbp>
Mail-Followup-To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-15-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191030144926.11873-15-alxndr@bu.edu>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070143
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 30, 2019 at 02:50:00PM +0000, Oleinik, Alexander wrote:
>From: Alexander Oleinik <alxndr@bu.edu>
>
>Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
>---
> Makefile                    | 15 ++++++++++++++-
> Makefile.objs               |  4 +++-
> Makefile.target             | 18 +++++++++++++++++-
> tests/fuzz/Makefile.include |  4 ++++
> 4 files changed, 38 insertions(+), 3 deletions(-)
> create mode 100644 tests/fuzz/Makefile.include
>
>diff --git a/Makefile b/Makefile
>index d2b2ecd3c4..571f5562c9 100644
>--- a/Makefile
>+++ b/Makefile
>@@ -464,7 +464,7 @@ config-host.h-timestamp: config-host.mak
> qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
> 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
>
>-TARGET_DIRS_RULES := $(foreach t, all clean install, $(addsuffix /$(t), $(TARGET_DIRS)))
>+TARGET_DIRS_RULES := $(foreach t, all fuzz clean install, $(addsuffix /$(t), $(TARGET_DIRS)))
>
> SOFTMMU_ALL_RULES=$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
> $(SOFTMMU_ALL_RULES): $(authz-obj-y)
>@@ -476,6 +476,15 @@ $(SOFTMMU_ALL_RULES): config-all-devices.mak
> $(SOFTMMU_ALL_RULES): $(edk2-decompressed)
> $(SOFTMMU_ALL_RULES): $(softmmu-main-y)
>
>+SOFTMMU_FUZZ_RULES=$(filter %-softmmu/fuzz, $(TARGET_DIRS_RULES))
>+$(SOFTMMU_FUZZ_RULES): $(authz-obj-y)
>+$(SOFTMMU_FUZZ_RULES): $(block-obj-y)
>+$(SOFTMMU_FUZZ_RULES): $(chardev-obj-y)
>+$(SOFTMMU_FUZZ_RULES): $(crypto-obj-y)
>+$(SOFTMMU_FUZZ_RULES): $(io-obj-y)
>+$(SOFTMMU_FUZZ_RULES): config-all-devices.mak
>+$(SOFTMMU_FUZZ_RULES): $(edk2-decompressed)
>+
> .PHONY: $(TARGET_DIRS_RULES)
> # The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
> # $(dir $@) yields the sub-directory, and $(notdir $@) yields the sub-goal
>@@ -526,6 +535,9 @@ subdir-slirp: slirp/all
> $(filter %/all, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
> 	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
>
>+$(filter %/fuzz, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
>+	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
>+
> ROM_DIRS = $(addprefix pc-bios/, $(ROMS))
> ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
> # Only keep -O and -g cflags
>@@ -535,6 +547,7 @@ $(ROM_DIRS_RULES):
>
> .PHONY: recurse-all recurse-clean recurse-install
> recurse-all: $(addsuffix /all, $(TARGET_DIRS) $(ROM_DIRS))
>+recurse-fuzz: $(addsuffix /fuzz, $(TARGET_DIRS) $(ROM_DIRS))
> recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(ROM_DIRS))
> recurse-install: $(addsuffix /install, $(TARGET_DIRS))
> $(addsuffix /install, $(TARGET_DIRS)): all
>diff --git a/Makefile.objs b/Makefile.objs
>index 9ff9b0c6f9..5478a554f6 100644
>--- a/Makefile.objs
>+++ b/Makefile.objs
>@@ -86,10 +86,12 @@ common-obj-$(CONFIG_FDT) += device_tree.o
> # qapi
>
> common-obj-y += qapi/
>+softmmu-obj-y = main.o
>
>-softmmu-main-y = main.o
> endif
>
>+
>+
> #######################################################################
> # Target-independent parts used in system and user emulation
> common-obj-y += cpus-common.o
>diff --git a/Makefile.target b/Makefile.target
>index ca3d14efe1..cddc8e4306 100644
>--- a/Makefile.target
>+++ b/Makefile.target
>@@ -202,7 +202,7 @@ endif
> COMMON_LDADDS = ../libqemuutil.a
>
> # build either PROG or PROGW
>-$(QEMU_PROG_BUILD): $(all-obj-y) $(COMMON_LDADDS)
>+$(QEMU_PROG_BUILD): $(all-obj-y) $(COMMON_LDADDS) $(softmmu-obj-y)
> 	$(call LINK, $(filter-out %.mak, $^))
> ifdef CONFIG_DARWIN
> 	$(call quiet-command,Rez -append $(SRC_PATH)/pc-bios/qemu.rsrc -o $@,"REZ","$(TARGET_DIR)$@")
>@@ -227,6 +227,22 @@ ifdef CONFIG_TRACE_SYSTEMTAP
> 	rm -f *.stp
> endif
>
>+ifdef CONFIG_FUZZ
>+include $(SRC_PATH)/tests/fuzz/Makefile.include
>+include $(SRC_PATH)/tests/Makefile.include
>+
>+fuzz: fuzz-vars
>+fuzz-vars: QEMU_CFLAGS := $(FUZZ_CFLAGS) $(QEMU_CFLAGS)
>+fuzz-vars: QEMU_LDFLAGS := $(FUZZ_LDFLAGS) $(QEMU_LDFLAGS)
>+fuzz-vars: $(QEMU_PROG_FUZZ)
>+dummy := $(call unnest-vars,, fuzz-obj-y)
>+
>+
>+$(QEMU_PROG_FUZZ): config-devices.mak $(all-obj-y) $(COMMON_LDADDS) $(fuzz-obj-y)
>+	$(call LINK, $(filter-out %.mak, $^))
>+

It may be useful to still handle the fuzz target here, and report
that fuzzing is disabled in this configuration, as it is, if I type
'make x86_64-softmmu/fuzz' I get the less useful output of:

   make[1]: *** No rule to make target `fuzz'.  Stop.

>+endif
>+
> install: all
> ifneq ($(PROGS),)
> 	$(call install-prog,$(PROGS),$(DESTDIR)$(bindir))
>diff --git a/tests/fuzz/Makefile.include b/tests/fuzz/Makefile.include
>new file mode 100644
>index 0000000000..324e6c1433
>--- /dev/null
>+++ b/tests/fuzz/Makefile.include
>@@ -0,0 +1,4 @@
>+# QEMU_PROG_FUZZ=qemu-fuzz-$(TARGET_NAME)$(EXESUF)
>+fuzz-obj-y = $(libqos-obj-y)
>+fuzz-obj-y += tests/libqtest.o
>+

But otherwise, this seems to be cleaner in that it is not causing
rebuilds of objects between selecting target/all or target/fuzz,
assuming that is correct here.

So with that,

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.

