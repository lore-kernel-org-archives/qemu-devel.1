Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097D2C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A9F620731
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O/Zgtq7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A9F620731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZuS4-0001aM-Au
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:26:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1kZuPm-00006b-5x
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:23:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62618
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1kZuPj-0005QX-3W
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:23:49 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A3B1hIG182853
 for <qemu-devel@nongnu.org>; Tue, 3 Nov 2020 06:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=UZtYZRIjFqw6sjS3B7VzszpK3COVV8aleHW8JUgUb3o=;
 b=O/Zgtq7h5MKmMPPjvivOKRiYKbiM4XlHygKp+dmlpJANBPr1twWQ8Fc4LUh7fsdZEKQ1
 yCsolExA4gFF1DJpmrruSum6XdzpA8B0pzYnJYDyKh4bdseExfhclWdQzzbFRDvwiI4h
 g2dXOHJ18P/7Bm+FvuUIT0AmVAsMabxrYanTHb/3SlhDk+O6nH2mvcPK7asczJr1q3vi
 KFBvzWhAEXH06mjiRbVex89DdjcJkKA/BOFyFtoXhF49LVSz5fuVxLI+gzpKWrCPCso5
 SSFfwKHu4gVibEYeVMNPY+uXATgVihrZSS8n1O6lafmnNuz6avZtZWlU8LSK7SKkTdkE 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34k3g2dhx3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:23:43 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A3B1u7x183824
 for <qemu-devel@nongnu.org>; Tue, 3 Nov 2020 06:23:43 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34k3g2dhw5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2020 06:23:43 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A3BHLJE032237;
 Tue, 3 Nov 2020 11:23:41 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma05fra.de.ibm.com with ESMTP id 34h01qsmnd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2020 11:23:41 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0A3BNcsK2949782
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Nov 2020 11:23:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82AF74C040;
 Tue,  3 Nov 2020 11:23:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 449724C044;
 Tue,  3 Nov 2020 11:23:38 +0000 (GMT)
Received: from marcibm.ibmuc.com (unknown [9.145.145.228])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  3 Nov 2020 11:23:38 +0000 (GMT)
From: Marc Hartmayer <mhartmay@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] meson: vhost-user-gpu/virtiofsd: use absolute path
Date: Tue,  3 Nov 2020 12:23:33 +0100
Message-Id: <20201103112333.24734-1-mhartmay@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-03_07:2020-11-03,
 2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0 suspectscore=1
 lowpriorityscore=0 mlxscore=0 mlxlogscore=995 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030071
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 06:23:44
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The option `libexecdir` is relative to `prefix` (see
https://mesonbuild.com/Builtin-options.html), so we have to be aware
of this when creating 50-qemu-gpu.json and
50-qemu-virtiofsd.json. Otherwise, tools like libvirt will not be able
to find the executable.

Fixes: 16bf7a3326d8 ("configure: move directory options from config-host.mak to meson")
Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
---
 contrib/vhost-user-gpu/meson.build | 2 +-
 tools/virtiofsd/meson.build        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/vhost-user-gpu/meson.build b/contrib/vhost-user-gpu/meson.build
index 37ecca13cafb..c487ca72c1ff 100644
--- a/contrib/vhost-user-gpu/meson.build
+++ b/contrib/vhost-user-gpu/meson.build
@@ -9,6 +9,6 @@ if 'CONFIG_TOOLS' in config_host and 'CONFIG_VIRGL' in config_host \
 
   configure_file(input: '50-qemu-gpu.json.in',
                  output: '50-qemu-gpu.json',
-                 configuration: { 'libexecdir' : get_option('libexecdir') },
+                 configuration: { 'libexecdir' : get_option('prefix') / get_option('libexecdir') },
                  install_dir: qemu_datadir / 'vhost-user')
 endif
diff --git a/tools/virtiofsd/meson.build b/tools/virtiofsd/meson.build
index e1a4dc98d9ec..17edecf55c0a 100644
--- a/tools/virtiofsd/meson.build
+++ b/tools/virtiofsd/meson.build
@@ -15,5 +15,5 @@ executable('virtiofsd', files(
 
 configure_file(input: '50-qemu-virtiofsd.json.in',
                output: '50-qemu-virtiofsd.json',
-               configuration: { 'libexecdir' : get_option('libexecdir') },
+               configuration: { 'libexecdir' : get_option('prefix') / get_option('libexecdir') },
                install_dir: qemu_datadir / 'vhost-user')
-- 
2.25.4


