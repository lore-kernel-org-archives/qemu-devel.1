Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB325C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D70D208C4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3f2Bd/ZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D70D208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50912 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwHU-0003VL-SP
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58264)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwAB-00050v-17
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwAA-0000zp-1F
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:15:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56594)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwA9-0000yN-OZ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:15:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI8vH2066196;
 Mon, 17 Jun 2019 18:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=IsiySJFqk5iTUWpDwM0EVFDRV5zBmyZpcH2UaSxLkzE=;
 b=3f2Bd/ZLcSFYk4Ae/rGaq5d/2/Y5RHmoA2+Lr+fPx4DWOZYBv3p/ZtIiT40B8+3WXXo0
 WNnclRhJ0wS6uGNBbr1pEF3O/9vEDXS0yJgpLoRh/LhZvtdfTO/r0wluT0GtIhlwyEOc
 MvToumfyYrO+TLQ6yA0KOpXnWe0GQa4gzOci72DJ+8AsaeO/8wpul1wa099nzQovmjD8
 I/M+f2NnQSFwLB7YJs1WyfuRpM+UVZkJo+b7koB+kRgGTg91ZocXQ/s4ExaaJIAQRf1x
 IPMOQ1Di3rT1jSRvsXZLSG8flDi0XqHai9qYBjBRkEKKJbTCno8OGWXpz440x4Op+QZa hw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2t4rmp00hc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:15:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIF9NL118044;
 Mon, 17 Jun 2019 18:15:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2t5cpdkegd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:15:22 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5HIFLeU027618;
 Mon, 17 Jun 2019 18:15:21 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:15:21 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:15:18 -0700
Message-Id: <20190617181518.29324-1-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170162
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [RFC PATCH v2 05/35] multi-process: Add config option
 for multi-process QEMU
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
Cc: elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, thuth@redhat.com,
 jag.raman@oracle.com, konrad.wilk@oracle.com, berrange@redhat.com,
 ross.lagerwall@citrix.com, liran.alon@oracle.com, kraxel@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, kanth.ghatraju@oracle.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jagannathan Raman <jag.raman@oracle.com>

Add a configuration option to separate multi-process code

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 configure | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/configure b/configure
index e1ad87b697..3834d69af5 100755
--- a/configure
+++ b/configure
@@ -491,6 +491,7 @@ docker="no"
 debug_mutex="no"
 libpmem=""
 default_devices="yes"
+mpqemu="no"
 
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
 cross_cc_aarch64="aarch64-linux-gnu-gcc"
@@ -1518,6 +1519,10 @@ for opt do
   ;;
   --disable-libpmem) libpmem=no
   ;;
+  --enable-mpqemu) mpqemu=yes
+  ;;
+  --disable-mpqemu) mpqemu=no
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1818,6 +1823,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   capstone        capstone disassembler support
   debug-mutex     mutex debugging support
   libpmem         libpmem support
+  mpqemu          multi-process QEMU support
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -6438,6 +6444,7 @@ echo "docker            $docker"
 echo "libpmem support   $libpmem"
 echo "libudev           $libudev"
 echo "default devices   $default_devices"
+echo "multiprocess QEMU $mpqemu"
 
 if test "$supported_cpu" = "no"; then
     echo
@@ -7226,6 +7233,10 @@ if test "$libpmem" = "yes" ; then
   echo "CONFIG_LIBPMEM=y" >> $config_host_mak
 fi
 
+if test "$mpqemu" = "yes" ; then
+  echo "CONFIG_MPQEMU=y" >> $config_host_mak
+fi
+
 if test "$bochs" = "yes" ; then
   echo "CONFIG_BOCHS=y" >> $config_host_mak
 fi
-- 
2.17.1


