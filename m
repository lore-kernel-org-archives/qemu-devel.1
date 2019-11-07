Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFBDFC6195
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:05:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8093B214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rzm/dbVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8093B214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSiPM-00089b-JE
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 09:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1iSiNn-0006kL-TI
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:03:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1iSiNi-0005rz-AG
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:03:31 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1iSiNf-0005qt-KE
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:03:24 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7Dx5KA190378;
 Thu, 7 Nov 2019 14:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=nRMmqYPPSqu9yPqEGbMe3y+cXNmqhtkaIrHW8rByKuk=;
 b=rzm/dbVW63Hq+6prJB55PMd6Zt9E6z9jx3K+F/RuKX8zfudZ6PEP0+ATykVUPY7BPL61
 zSe44eDjttQOzOv3EqKHOMgniAQP3HZP4OuTOIUrzOVl5LAIp60lsIVjQAS9Y69aW8/6
 Q5GZsagDe3GMgx+hi/Ly9if+QX1Q0Hxh9glNCYJCUrT0ro2TAP/U8bZW4nvdWUxp3VSD
 FoUaVLi+iBty8AzRHrQgHQJhGdWC3JHc0vwcPe39f2CRCKHRiqEer9O4e9gt44e2/CA+
 RJMxDdDuv/CfHPU4Q1KvKXnK/Zkm1oVZQSdAp88asPYdVqA4iNtttfH5Qg94vqjxyjLf 8w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2w41w0xa8f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2019 14:03:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7DwRFp115756;
 Thu, 7 Nov 2019 14:03:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2w41wh8k6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2019 14:03:18 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA7E3Hpa025203;
 Thu, 7 Nov 2019 14:03:17 GMT
Received: from starbug-mbp.localdomain (/10.175.193.46)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 07 Nov 2019 06:03:17 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 9C7014B2BC74;
 Thu,  7 Nov 2019 14:03:14 +0000 (GMT)
Date: Thu, 7 Nov 2019 14:03:14 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v4 09/20] libqos: split qos-test and libqos makefile vars
Message-ID: <20191107140314.gljw6drskhoot7ye@starbug-mbp>
Mail-Followup-To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-10-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191030144926.11873-10-alxndr@bu.edu>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070141
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

On Wed, Oct 30, 2019 at 02:49:55PM +0000, Oleinik, Alexander wrote:
>From: Alexander Oleinik <alxndr@bu.edu>
>
>Most qos-related objects were specified in the qos-test-obj-y variable.
>qos-test-obj-y also included qos-test.o which defines a main().
>This made it difficult to repurpose qos-test-obj-y to link anything
>beside tests/qos-test against libqos. This change separates objects that
>are libqos-specific and ones that are qos-test specific into different
>variables.
>
>Signed-off-by: Alexander Oleinik <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
> tests/Makefile.include | 71 +++++++++++++++++++++---------------------
> 1 file changed, 36 insertions(+), 35 deletions(-)
>
>diff --git a/tests/Makefile.include b/tests/Makefile.include
>index 67853d10c3..1517c4817e 100644
>--- a/tests/Makefile.include
>+++ b/tests/Makefile.include
>@@ -699,52 +699,53 @@ tests/test-crypto-block$(EXESUF): tests/test-crypto-block.o $(test-crypto-obj-y)
>
> libqgraph-obj-y = tests/libqos/qgraph.o
>
>-libqos-obj-y = $(libqgraph-obj-y) tests/libqos/pci.o tests/libqos/fw_cfg.o
>-libqos-obj-y += tests/libqos/malloc.o
>-libqos-obj-y += tests/libqos/libqos.o
>-libqos-spapr-obj-y = $(libqos-obj-y) tests/libqos/malloc-spapr.o
>+libqos-core-obj-y = $(libqgraph-obj-y) tests/libqos/pci.o tests/libqos/fw_cfg.o
>+libqos-core-obj-y += tests/libqos/malloc.o
>+libqos-core-obj-y += tests/libqos/libqos.o
>+libqos-spapr-obj-y = $(libqos-core-obj-y) tests/libqos/malloc-spapr.o
> libqos-spapr-obj-y += tests/libqos/libqos-spapr.o
> libqos-spapr-obj-y += tests/libqos/rtas.o
> libqos-spapr-obj-y += tests/libqos/pci-spapr.o
>-libqos-pc-obj-y = $(libqos-obj-y) tests/libqos/pci-pc.o
>+libqos-pc-obj-y = $(libqos-core-obj-y) tests/libqos/pci-pc.o
> libqos-pc-obj-y += tests/libqos/malloc-pc.o tests/libqos/libqos-pc.o
> libqos-pc-obj-y += tests/libqos/ahci.o
> libqos-usb-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/usb.o
>
> # Devices
>-qos-test-obj-y = tests/qos-test.o $(libqgraph-obj-y)
>-qos-test-obj-y += $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
>-qos-test-obj-y += tests/libqos/e1000e.o
>-qos-test-obj-y += tests/libqos/i2c.o
>-qos-test-obj-y += tests/libqos/i2c-imx.o
>-qos-test-obj-y += tests/libqos/i2c-omap.o
>-qos-test-obj-y += tests/libqos/sdhci.o
>-qos-test-obj-y += tests/libqos/tpci200.o
>-qos-test-obj-y += tests/libqos/virtio.o
>-qos-test-obj-$(CONFIG_VIRTFS) += tests/libqos/virtio-9p.o
>-qos-test-obj-y += tests/libqos/virtio-balloon.o
>-qos-test-obj-y += tests/libqos/virtio-blk.o
>-qos-test-obj-y += tests/libqos/virtio-mmio.o
>-qos-test-obj-y += tests/libqos/virtio-net.o
>-qos-test-obj-y += tests/libqos/virtio-pci.o
>-qos-test-obj-y += tests/libqos/virtio-pci-modern.o
>-qos-test-obj-y += tests/libqos/virtio-rng.o
>-qos-test-obj-y += tests/libqos/virtio-scsi.o
>-qos-test-obj-y += tests/libqos/virtio-serial.o
>+libqos-obj-y = $(libqgraph-obj-y)
>+libqos-obj-y += $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
>+libqos-obj-y += tests/libqos/e1000e.o
>+libqos-obj-y += tests/libqos/i2c.o
>+libqos-obj-y += tests/libqos/i2c-imx.o
>+libqos-obj-y += tests/libqos/i2c-omap.o
>+libqos-obj-y += tests/libqos/sdhci.o
>+libqos-obj-y += tests/libqos/tpci200.o
>+libqos-obj-y += tests/libqos/virtio.o
>+libqos-obj-$(CONFIG_VIRTFS) += tests/libqos/virtio-9p.o
>+libqos-obj-y += tests/libqos/virtio-balloon.o
>+libqos-obj-y += tests/libqos/virtio-blk.o
>+libqos-obj-y += tests/libqos/virtio-mmio.o
>+libqos-obj-y += tests/libqos/virtio-net.o
>+libqos-obj-y += tests/libqos/virtio-pci.o
>+libqos-obj-y += tests/libqos/virtio-pci-modern.o
>+libqos-obj-y += tests/libqos/virtio-rng.o
>+libqos-obj-y += tests/libqos/virtio-scsi.o
>+libqos-obj-y += tests/libqos/virtio-serial.o
>
> # Machines
>-qos-test-obj-y += tests/libqos/aarch64-xlnx-zcu102-machine.o
>-qos-test-obj-y += tests/libqos/arm-imx25-pdk-machine.o
>-qos-test-obj-y += tests/libqos/arm-n800-machine.o
>-qos-test-obj-y += tests/libqos/arm-raspi2-machine.o
>-qos-test-obj-y += tests/libqos/arm-sabrelite-machine.o
>-qos-test-obj-y += tests/libqos/arm-smdkc210-machine.o
>-qos-test-obj-y += tests/libqos/arm-virt-machine.o
>-qos-test-obj-y += tests/libqos/arm-xilinx-zynq-a9-machine.o
>-qos-test-obj-y += tests/libqos/ppc64_pseries-machine.o
>-qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
>+libqos-obj-y += tests/libqos/aarch64-xlnx-zcu102-machine.o
>+libqos-obj-y += tests/libqos/arm-imx25-pdk-machine.o
>+libqos-obj-y += tests/libqos/arm-n800-machine.o
>+libqos-obj-y += tests/libqos/arm-raspi2-machine.o
>+libqos-obj-y += tests/libqos/arm-sabrelite-machine.o
>+libqos-obj-y += tests/libqos/arm-smdkc210-machine.o
>+libqos-obj-y += tests/libqos/arm-virt-machine.o
>+libqos-obj-y += tests/libqos/arm-xilinx-zynq-a9-machine.o
>+libqos-obj-y += tests/libqos/ppc64_pseries-machine.o
>+libqos-obj-y += tests/libqos/x86_64_pc-machine.o
>
> # Tests
>+qos-test-obj-y = tests/qos-test.o
> qos-test-obj-y += tests/ac97-test.o
> qos-test-obj-y += tests/ds1338-test.o
> qos-test-obj-y += tests/e1000-test.o
>@@ -776,7 +777,7 @@ check-unit-y += tests/test-qgraph$(EXESUF)
> tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
>
> check-qtest-generic-y += tests/qos-test$(EXESUF)
>-tests/qos-test$(EXESUF): $(qos-test-obj-y)
>+tests/qos-test$(EXESUF): $(qos-test-obj-y) $(libqos-obj-y)
>
> tests/qmp-test$(EXESUF): tests/qmp-test.o
> tests/qmp-cmd-test$(EXESUF): tests/qmp-cmd-test.o
>-- 
>2.23.0
>
>

