Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D948BC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A329221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AtnKBis5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A329221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVVws-0007I0-7V
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 04:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihai.carabas@oracle.com>)
 id 1kVVuZ-00049y-3a; Thu, 22 Oct 2020 04:25:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihai.carabas@oracle.com>)
 id 1kVVuW-00066a-5n; Thu, 22 Oct 2020 04:25:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M8OEIA008774;
 Thu, 22 Oct 2020 08:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=eQHLQiP0pOQUmU48nt08dYJM5zU3ME8PIvW/dXLfPa8=;
 b=AtnKBis5JpfwAIB8iCRuc2CcG45alolMJwgBQ6udgEyl8HL1BHXZS4oxrwPq+2W++K/+
 vI5dw54z8/mTQPph04wX37O3JFVickpJREpE4TH2gMTqXFrBF4B+oEZ5VQO+WTbO0azV
 IWxYoRieJ7MiEEBHLvv77e4azjBigurbw9YqPn0UCMi7X3aJcC8kJ5AHGXTxuh21y2Eo
 p9sVVThrP7p243DDY0Z8j0Td3AZWx9YZIIRtmqHrRwfps9O8SuuZalKNVH9SW9xFWJXD
 typlY+Khb/O89h/dhTJ4uGuz4dF+Tw7cCPIlsca1kCmavc43MbemNy0anA/VgUVWvvM3 2w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 34ak16mvsf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 22 Oct 2020 08:25:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M8Fjif083192;
 Thu, 22 Oct 2020 08:25:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 348ah0k2gq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Oct 2020 08:25:17 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09M8PG9A013938;
 Thu, 22 Oct 2020 08:25:16 GMT
Received: from mihai.localdomain (/10.153.73.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 22 Oct 2020 01:25:16 -0700
From: Mihai Carabas <mihai.carabas@oracle.com>
To: peter.maydell@linaro.org, shannon.zhaosl@gmail.com, mst@redhat.com,
 imammedo@redhat.com
Subject: [PATCH 0/8] Add support for pvpanic mmio device
Date: Thu, 22 Oct 2020 10:42:48 +0300
Message-Id: <1603352576-21671-1-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220055
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220056
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=mihai.carabas@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 04:09:38
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: Mihai Carabas <mihai.carabas@oracle.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patchset was assembled from chuncks from some old patches from 2018 [1]
which were left unmerged and some additions from me. Surprisingly their Linux
kernel counterpart were merged (so the pvpanic driver from the kernel supports
mmio).

I have seen the discussions about moving the pvpanic to PCI [1]. Those patches
were sent but nothing happened. Also they are not trivial and require major
modifications at the driver level also. Given the fact that we already have
mmio driver support for pvpanic in the Linux kernel, I have sent these patches
to ask again the maintainers if this can be merged.

How to test this:
/usr/bin/qemu-system-aarch64 \
        -machine virt,gic-version=3,pvpanic=on

There is a new property for machine virt called pvpanic which is by default
turned off.

[1] http://patchwork.ozlabs.org/project/qemu-devel/cover/1543865209-50994-1-git-send-email-peng.hao2@zte.com.cn/

Mihai Carabas (1):
  pvpanic: break dependency on ISA_BUS

Peng Hao (5):
  hw/misc/pvpanic: Add the MMIO interface
  hw/arm/virt: Use the pvpanic device
  hw/arm/virt: add pvpanic device in virt acpi table
  hw/arm/virt: add configure interface for pvpanic-mmio
  pvpanic : update pvpanic document

Philippe Mathieu-Daudé (2):
  hw/misc/pvpanic: Build the pvpanic device for any machine
  hw/misc/pvpanic: Cosmetic renaming

 docs/specs/pvpanic.txt    | 12 ++++++-
 hw/arm/Kconfig            |  1 +
 hw/arm/virt-acpi-build.c  | 17 ++++++++++
 hw/arm/virt.c             | 47 +++++++++++++++++++++++++++
 hw/misc/Kconfig           |  2 +-
 hw/misc/meson.build       |  2 +-
 hw/misc/pvpanic.c         | 83 ++++++++++++++++++++++++++++++++++++++---------
 include/hw/arm/virt.h     |  2 ++
 include/hw/misc/pvpanic.h |  5 +--
 9 files changed, 150 insertions(+), 21 deletions(-)

-- 
1.8.3.1


