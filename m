Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200CFC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF85521741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="loztLyzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF85521741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izJ3f-000078-41
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:41:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1izJ2k-0007bZ-Lh
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:40:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1izJ2j-00008p-BB
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:40:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48344)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1izJ2j-00007y-2C
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:40:29 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015BcEnF010654;
 Wed, 5 Feb 2020 11:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=4mvzeDCufFFPyVJpZGx3S1Snye+pDXrw0lX11dS2UOs=;
 b=loztLyzFvbckdWcSswv4qlbDUO17UIyND8yAvOH1xzpB+ZitM4Suv59UCLdcip0iKiS2
 xry5mnZA2eclLBvr8Nr8Ni2p8Ays/Wk8yeLXfG2tx00n9HuVqb1Xp6Kod+WIW5uBeteI
 xhVoqrY73NMUN3LPXlgKzpt/2+l5g2QLN/XvIy8rddQyw+vPstwZD7nAFMc3BICYSH2l
 nm1TKEVjfFvtFmAPuXvjrTimTQiYuhZcuvFsUe6oxEZC6E6ZbzkAhRT1+koAHCK6ow7P
 4/yqeKCNrUgjjskeJ/y1FZdlZfxE+uDv501YcSsmUtBBlSewQozgOwKxiHCHE03CAui9 9A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2xykbpaete-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 11:40:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015BcYjE041120;
 Wed, 5 Feb 2020 11:40:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2xykbrn46s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 11:40:25 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 015BeOR9002795;
 Wed, 5 Feb 2020 11:40:24 GMT
Received: from starbug-mbp.localdomain (/10.169.111.17)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 05 Feb 2020 03:40:24 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 3B66D57D7536;
 Wed,  5 Feb 2020 11:40:22 +0000 (GMT)
Date: Wed, 5 Feb 2020 11:40:22 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v8 08/21] libqos: rename i2c_send and i2c_recv
Message-ID: <20200205114022.ejvh4i4cj7sfbahj@starbug-mbp>
Mail-Followup-To: "Bulekov, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-9-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200129053357.27454-9-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050095
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 05:34:18AM +0000, Bulekov, Alexander wrote:
>The names i2c_send and i2c_recv collide with functions defined in
>hw/i2c/core.c. This causes an error when linking against libqos and
>softmmu simultaneously (for example when using qtest inproc). Rename the
>libqos functions to avoid this.
>
>Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>Acked-by: Thomas Huth <thuth@redhat.com>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
> tests/qtest/libqos/i2c.c   | 10 +++++-----
> tests/qtest/libqos/i2c.h   |  4 ++--
> tests/qtest/pca9552-test.c | 10 +++++-----
> 3 files changed, 12 insertions(+), 12 deletions(-)
>
>diff --git a/tests/qtest/libqos/i2c.c b/tests/qtest/libqos/i2c.c
>index 156114e745..38f800dbab 100644
>--- a/tests/qtest/libqos/i2c.c
>+++ b/tests/qtest/libqos/i2c.c
>@@ -10,12 +10,12 @@
> #include "libqos/i2c.h"
> #include "libqtest.h"
>
>-void i2c_send(QI2CDevice *i2cdev, const uint8_t *buf, uint16_t len)
>+void qi2c_send(QI2CDevice *i2cdev, const uint8_t *buf, uint16_t len)
> {
>     i2cdev->bus->send(i2cdev->bus, i2cdev->addr, buf, len);
> }
>
>-void i2c_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t len)
>+void qi2c_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t len)
> {
>     i2cdev->bus->recv(i2cdev->bus, i2cdev->addr, buf, len);
> }
>@@ -23,8 +23,8 @@ void i2c_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t len)
> void i2c_read_block(QI2CDevice *i2cdev, uint8_t reg,
>                     uint8_t *buf, uint16_t len)
> {
>-    i2c_send(i2cdev, &reg, 1);
>-    i2c_recv(i2cdev, buf, len);
>+    qi2c_send(i2cdev, &reg, 1);
>+    qi2c_recv(i2cdev, buf, len);
> }
>
> void i2c_write_block(QI2CDevice *i2cdev, uint8_t reg,
>@@ -33,7 +33,7 @@ void i2c_write_block(QI2CDevice *i2cdev, uint8_t reg,
>     uint8_t *cmd = g_malloc(len + 1);
>     cmd[0] = reg;
>     memcpy(&cmd[1], buf, len);
>-    i2c_send(i2cdev, cmd, len + 1);
>+    qi2c_send(i2cdev, cmd, len + 1);
>     g_free(cmd);
> }
>
>diff --git a/tests/qtest/libqos/i2c.h b/tests/qtest/libqos/i2c.h
>index 945b65b34c..c65f087834 100644
>--- a/tests/qtest/libqos/i2c.h
>+++ b/tests/qtest/libqos/i2c.h
>@@ -47,8 +47,8 @@ struct QI2CDevice {
> void *i2c_device_create(void *i2c_bus, QGuestAllocator *alloc, void *addr);
> void add_qi2c_address(QOSGraphEdgeOptions *opts, QI2CAddress *addr);
>
>-void i2c_send(QI2CDevice *dev, const uint8_t *buf, uint16_t len);
>-void i2c_recv(QI2CDevice *dev, uint8_t *buf, uint16_t len);
>+void qi2c_send(QI2CDevice *dev, const uint8_t *buf, uint16_t len);
>+void qi2c_recv(QI2CDevice *dev, uint8_t *buf, uint16_t len);
>
> void i2c_read_block(QI2CDevice *dev, uint8_t reg,
>                     uint8_t *buf, uint16_t len);
>diff --git a/tests/qtest/pca9552-test.c b/tests/qtest/pca9552-test.c
>index 4b800d3c3e..d80ed93cd3 100644
>--- a/tests/qtest/pca9552-test.c
>+++ b/tests/qtest/pca9552-test.c
>@@ -32,22 +32,22 @@ static void receive_autoinc(void *obj, void *data, QGuestAllocator *alloc)
>
>     pca9552_init(i2cdev);
>
>-    i2c_send(i2cdev, &reg, 1);
>+    qi2c_send(i2cdev, &reg, 1);
>
>     /* PCA9552_LS0 */
>-    i2c_recv(i2cdev, &resp, 1);
>+    qi2c_recv(i2cdev, &resp, 1);
>     g_assert_cmphex(resp, ==, 0x54);
>
>     /* PCA9552_LS1 */
>-    i2c_recv(i2cdev, &resp, 1);
>+    qi2c_recv(i2cdev, &resp, 1);
>     g_assert_cmphex(resp, ==, 0x55);
>
>     /* PCA9552_LS2 */
>-    i2c_recv(i2cdev, &resp, 1);
>+    qi2c_recv(i2cdev, &resp, 1);
>     g_assert_cmphex(resp, ==, 0x55);
>
>     /* PCA9552_LS3 */
>-    i2c_recv(i2cdev, &resp, 1);
>+    qi2c_recv(i2cdev, &resp, 1);
>     g_assert_cmphex(resp, ==, 0x54);
> }
>
>-- 
>2.23.0
>
>

