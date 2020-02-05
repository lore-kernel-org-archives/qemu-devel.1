Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B822C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67FAC2082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MElQojnl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FAC2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLH3-00041a-Le
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1izLGS-0003af-1w
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1izLGQ-00049L-UR
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:02:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35960)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1izLGQ-00049D-Ky
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:02:46 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015Dm9sM114283;
 Wed, 5 Feb 2020 14:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=+O+sRDcL8CtXUES4eqJwIb9el6/jozDHxCj0qFOeNd4=;
 b=MElQojnl77wl0KnCSJvEi7S/JPOFZv5IZPkZlmG58VaJtY26tg0oY4AUdKt23aDN7TZ/
 Mth247oqwA5zvqtGSwJ+ddOisR5cIh6l+4K5x6AP3X3eIGIQcClHIWDTfKtu2H4HqMoH
 xwgUFTsYdyy3CaGSZDK5jCpMF32mSG0rMIbQQnpEbwsMqjc2hAPIyc2K5mdQvR6r/YJy
 CBEDICExu8+krXfvSLSLS2t+xUZyuzDXE+Ld2SRzxLpIrGyWdC5jSQKNZXb97fcXxGHq
 2MX2ntLUBHA1ypsPohQFHvq/7GBkKyV/g5Vz3R/O6NCtEAODHTmPuLX6GMKOFQFzVDR2 GA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2xykbpb5k8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 14:02:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015DiLYU017798;
 Wed, 5 Feb 2020 14:02:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2xykbrx61m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 14:02:43 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 015E2gBF016062;
 Wed, 5 Feb 2020 14:02:42 GMT
Received: from starbug-mbp.localdomain (/10.169.111.17)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 05 Feb 2020 06:02:42 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 104E657DC69A;
 Wed,  5 Feb 2020 14:02:40 +0000 (GMT)
Date: Wed, 5 Feb 2020 14:02:39 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v8 01/21] softmmu: split off vl.c:main() into main.c
Message-ID: <20200205140239.5gpanlyx4yyenhcx@starbug-mbp>
Mail-Followup-To: "Bulekov, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-2-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200129053357.27454-2-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050110
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 05:34:11AM +0000, Bulekov, Alexander wrote:
>A program might rely on functions implemented in vl.c, but implement its
>own main(). By placing main into a separate source file, there are no
>complaints about duplicate main()s when linking against vl.o. For
>example, the virtual-device fuzzer uses a main() provided by libfuzzer,
>and needs to perform some initialization before running the softmmu
>initialization. Now, main simply calls three vl.c functions which
>handle the guest initialization, main loop and cleanup.
>
>Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>---
> Makefile                |  1 +
> Makefile.objs           |  2 ++
> Makefile.target         |  2 +-
> include/sysemu/sysemu.h |  4 ++++
> main.c                  | 53 +++++++++++++++++++++++++++++++++++++++++
> vl.c                    | 36 +++++++---------------------
> 6 files changed, 70 insertions(+), 28 deletions(-)
> create mode 100644 main.c
>
>diff --git a/Makefile b/Makefile
>index 32bd554480..e6de7a47bb 100644
>--- a/Makefile
>+++ b/Makefile
>@@ -473,6 +473,7 @@ $(SOFTMMU_ALL_RULES): $(chardev-obj-y)
> $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
> $(SOFTMMU_ALL_RULES): $(io-obj-y)
> $(SOFTMMU_ALL_RULES): config-all-devices.mak
>+$(SOFTMMU_ALL_RULES): $(softmmu-main-y)
> ifdef DECOMPRESS_EDK2_BLOBS
> $(SOFTMMU_ALL_RULES): $(edk2-decompressed)
> endif
>diff --git a/Makefile.objs b/Makefile.objs
>index 7c1e50f9d6..5ab166fed5 100644
>--- a/Makefile.objs
>+++ b/Makefile.objs
>@@ -84,6 +84,8 @@ common-obj-$(CONFIG_FDT) += device_tree.o
> # qapi
>
> common-obj-y += qapi/
>+
>+softmmu-obj-y = main.o
> endif
>
> #######################################################################
>diff --git a/Makefile.target b/Makefile.target
>index 6e61f607b1..8dcf3dddd8 100644
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
>diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>index 80c57fdc4e..270df5fa34 100644
>--- a/include/sysemu/sysemu.h
>+++ b/include/sysemu/sysemu.h
>@@ -118,6 +118,10 @@ QemuOpts *qemu_get_machine_opts(void);
>
> bool defaults_enabled(void);
>
>+void qemu_init(int argc, char **argv, char **envp);
>+void qemu_main_loop(void);
>+void qemu_cleanup(void);
>+
> extern QemuOptsList qemu_legacy_drive_opts;
> extern QemuOptsList qemu_common_drive_opts;
> extern QemuOptsList qemu_drive_opts;
>diff --git a/main.c b/main.c
>new file mode 100644
>index 0000000000..f10ceda541
>--- /dev/null
>+++ b/main.c
>@@ -0,0 +1,53 @@
>+/*
>+ * QEMU System Emulator
>+ *
>+ * Copyright (c) 2003-2008 Fabrice Bellard

I don't know the rules but, maybe that should also be extended to
2019/2020 since this is a new file.

Otherwise,

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.

