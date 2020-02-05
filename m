Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB67C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:57:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5674821741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NdL/+hpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5674821741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izM7V-0007Dz-Fy
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:57:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1izM6Y-0005h3-SX
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1izM6X-00054K-Dj
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:56:38 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52830)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1izM6X-0004mr-5b
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:56:37 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015ErH9m164776;
 Wed, 5 Feb 2020 14:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=d+mE53yA6sxd7boFHFcdpnS9Vj2kugnjvOvA7GA5L7w=;
 b=NdL/+hpqNH8dNjbdSHQr3ydjfpEFuwkmLC2GTuD53lFOlKfw1OJKVLPS8In0wcqRe8DS
 BMRdmX7CWL/LWrPXC+N6wVUbHK8DccvqwU+uj5QuT0FIkuH7cgnWLbY+TwAm1vaPpnRM
 APWwlDT+/LlRQm96OsnDnDHbuoUNSWT3D78ruq4VOfAkytD2fJYANJSN2K2OYH+CV3g4
 F5Cok+IM+k2Nx/Afw34Zt2wd2tomXz3buDQYU9B7MEA9rCnFfAHCbe1Jx6PlQ84q2Om7
 v73P0HsTQfTsjByir+1tFkPShzQUFNzdygnb1nyUsk5QenXjKyXPEPqsuJ92kgH+ryu/ 7g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2xykbp3h8u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 14:56:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015ErUGA173208;
 Wed, 5 Feb 2020 14:56:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2xymuswyp8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 14:56:21 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 015EuKxu031852;
 Wed, 5 Feb 2020 14:56:20 GMT
Received: from ol7.uk.oracle.com (/10.175.206.136)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 05 Feb 2020 06:56:19 -0800
From: Liam Merwick <liam.merwick@oracle.com>
To: alex.bennee@linaro.org, fam@euphon.net, philmd@redhat.com
Subject: [PATCH v2 3/6] travis.yml: install rpm2cpio for acceptance tests
Date: Wed,  5 Feb 2020 14:56:02 +0000
Message-Id: <1580914565-19675-4-git-send-email-liam.merwick@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1580914565-19675-1-git-send-email-liam.merwick@oracle.com>
References: <1580914565-19675-1-git-send-email-liam.merwick@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=862
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=926 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050118
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
Cc: slp@redhat.com, qemu-devel@nongnu.org, wainersm@redhat.com,
 pbonzini@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The extract_from_rpm() method added for the PVH acceptance tests needs
rpm2cpio to extract a vmlinux binary from an RPM.

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index 3b35b7cf04d3..59773365823e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -323,6 +323,7 @@ matrix:
             - python3-pil
             - python3-pip
             - python3.5-venv
+            - rpm2cpio
             - tesseract-ocr
             - tesseract-ocr-eng
 
-- 
1.8.3.1


