Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1593C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF6A0206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F7bhjvHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6A0206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1AsN-0003fA-Ut
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdY-0007eL-Ig
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdV-0002CS-VP
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXP6S007487;
 Thu, 30 Jul 2020 15:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=YY5D39VKx7KmG8DuA4MVFb9AvBcnww2s9GY477Dv1AY=;
 b=F7bhjvHlazBQxGL8ecgUix4nSu7n3KX2vBNSjqrTaNCfBR3e1OkS+XYQK3UWFGe6odLA
 9bVzh+9wd9EcRgiQjuHSijJFFYPriyV+HN/AiKi6muNl6v9cpTKGTNJl6NO0LqShbLn7
 4owo3W8vaMqqnPBuBPTiKRd2tCbIzNvsYz+GdgFoxdHatGqS/+g0FnzztdN6QSr/6hua
 gPOrE5+v8YszM3CJnjMaHo41EG9FKZAdKX5PZhu+9AX1Uf45OvhrQv1qA1Mq0pRzaj6p
 5lionbrrfOALx6xEpauTA34ORkGF3Wi0dWsug/2Jqrf9TmUPNkHZtn54U33K+Vvj1zl3 IA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 32hu1jmfg8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 15:38:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFWZkc176078;
 Thu, 30 Jul 2020 15:38:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 32hu61a21u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 15:38:18 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UFcGG1007551;
 Thu, 30 Jul 2020 15:38:16 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 08:38:16 -0700
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 29/32] pci: export pci_update_mappings
Date: Thu, 30 Jul 2020 08:14:33 -0700
Message-Id: <1596122076-341293-30-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=1 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=steven.sistare@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 11:37:58
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow pci_update_mappings to be called from other modules.
No change in functionality.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/pci/pci.c         | 3 +--
 include/hw/pci/pci.h | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index de0fae1..7343e00 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -216,7 +216,6 @@ static const TypeInfo pcie_bus_info = {
 };
 
 static PCIBus *pci_find_bus_nr(PCIBus *bus, int bus_num);
-static void pci_update_mappings(PCIDevice *d);
 static void pci_irq_handler(void *opaque, int irq_num, int level);
 static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom, Error **);
 static void pci_del_option_rom(PCIDevice *pdev);
@@ -1316,7 +1315,7 @@ static pcibus_t pci_bar_address(PCIDevice *d,
     return new_addr;
 }
 
-static void pci_update_mappings(PCIDevice *d)
+void pci_update_mappings(PCIDevice *d)
 {
     PCIIORegion *r;
     int i;
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index c1bf7d5..bd07c86 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -865,5 +865,6 @@ extern const VMStateDescription vmstate_pci_device;
 }
 
 MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
+void pci_update_mappings(PCIDevice *d);
 
 #endif
-- 
1.8.3.1


