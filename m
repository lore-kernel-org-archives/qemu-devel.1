Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72782C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A630205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PDdk/b1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A630205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEBo9-0002MC-Dd
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEBnP-0001kd-T8
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEBnN-0000r2-Ph
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:58:10 -0400
Received: from mail-eopbgr10114.outbound.protection.outlook.com
 ([40.107.1.114]:6215 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jEBnN-0000an-4Z; Tue, 17 Mar 2020 08:58:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQxIuwSUhNzW/TpQoRp1gPZSsToxBW6phPFBX51dSWputCwA/UckFpkcgHWm1ASyQwBSV1uKDhE9EcGP+jp/fcycrlbmjAse+hzScNIJ6/Wq7eoMAsjai0QnZWw7a2s9CnzdNvBdU5f1id4ewPRoZMJvDkoO9XTIg9YXZmK+7/+7Cnv4V1GQWPX7K9DuuoZI7MHJCaQ8MvHsiH/D6s6FnhqJRo7n+1XofPaR7XWRXqFTENJP4kOLMvms0mgcHKpZx5hKO4jv8U7Q6TS0nsv7tF9FU7VYQb5hLWqjDBkc3LDOEkahZvHek6LoXXAOxDPFMTIil4+eROeooA8k2nDTYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0Kq85s2Ks2Epila95mdgyYaGzCUw+xjcbAH9L8wwco=;
 b=eM/W/9wY1C1btyUnzae2CmkkR+6G1OTqJZRsx0sKE7EhutT3yF86eVX5LEFWGsHzATlN7QXChLuVXV9GUBBQLNxQuaz3bLYU+O8aBf6CiPnHC9A/AY263J9QSGapomg/NKB0xiyzesTLbnrwUTHbV965IrCsBH8xObMpTl3TH9mo/yRWZYzZMsS62iLG7FeyuwHVa+4FoD/g6aG2oId0WYPwFr9uhDSqRNVE5NVdx9ifXBhUF7vNhlGjZ9FRbgjo2g5MBi+wZLYwNESt/pg7N2qSh7ZrAsDsViWFxe4UF+FVrL8S4P/86ATj2Mp/XTZV1AZsSI2AHn8Aa93yGcSDlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0Kq85s2Ks2Epila95mdgyYaGzCUw+xjcbAH9L8wwco=;
 b=PDdk/b1Nz3W9GHXkCyWn2yyYwqIk7CAlsmTmMVjB1sahq+aL829pTNZXXPxwbYeyvY6yMb8fUmqXlee6iE1zPhAAY3zpjEiEp59/lV5+UNW56c3utqmsWeu9Sv/80EuiAXRfzRVNRBpQPjbsiQAsSyeAenWk0dMDC3ksvMVpP9Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2571.eurprd08.prod.outlook.com (10.175.36.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Tue, 17 Mar 2020 12:58:04 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2814.021; Tue, 17 Mar
 2020 12:58:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 4/3] hw/sd/ssi-sd: fix error handling in ssi_sd_realize
Date: Tue, 17 Mar 2020 15:57:41 +0300
Message-ID: <20200317125741.15301-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200313170517.22480-1-armbru@redhat.com>
References: <20200313170517.22480-1-armbru@redhat.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::15) To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.248) by
 FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.15 via Frontend Transport; Tue, 17 Mar 2020 12:58:03 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.248]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 433f859c-f332-480d-53f2-08d7ca72d4b0
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2571:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB257189EA29D36AD6631021F7C1F60@HE1PR0802MB2571.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39850400004)(396003)(346002)(136003)(376002)(199004)(16526019)(186003)(2616005)(6486002)(36756003)(2906002)(6506007)(316002)(6916009)(6666004)(26005)(66556008)(66476007)(5660300002)(52116002)(4326008)(1076003)(86362001)(66946007)(478600001)(6512007)(81166006)(8676002)(81156014)(8936002)(956004)(69590400007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2571;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1aw67l5G3vEfsaXy64mihmcT6S2ofrwBzAvJh7J/9ilIVJgFdmKqZp3aoutFeZuHd4hFb3vd/TLZ02DHFVTmqgcwmsmlPvZyENzk//0sqlD1ChYg4a0pIZyT/L+bt0VOYyLwqwfg031ORMcM+SznBQGx4+OwdMX9OyruU/L9V3CpYwVJaNxkb3x55s8JuH+f1/SAog/o0y0dgw28WzbL1w5jr9et3IV7ahbMa4ZfUQ0ToJDVT4u81BmHdIQ7vFddqf1tIyFjUM31jz0vkc3n7bbv27tHTKecbqOfdrWavbERlsL6G74SA2bB1jzoP4YGqweKWjNHVaeVQf6tZdpVmdmNV/wYdBSxO86viCDggY/sNPndhWE9IYeFupPVWKpgK0l+1wN/uRGU50xZ20O9lUTj3aaAC+jmt4/6I+Acgxy329i8EvwBIML0mG4qkANQL4vXqSSTM92Lb0FHGe9yGNMP/N748Ixm7nWQWJSjsij2G95cfXMx9eOl8sjn+O+
X-MS-Exchange-AntiSpam-MessageData: vZyvMA7I6D6RW+OWl9OWMeoVN7j4uDkiKQuAszJL+rdC9T7FUtDpzjYic0Uiq8nXPK/DwN3/zGCWcyif1uLRq3uW3QnnowqLijdw3nNJ2QnA/FxhygX9BhX26aJ8rs/5/TxwPOm6kQUEZ4qiddCmSQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433f859c-f332-480d-53f2-08d7ca72d4b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 12:58:04.3760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxdO4RTmu9WB6Gef1781zu6xJL7vLepn2Q9aa8W67PFS3y8KDu/UVzFCfJk3qRzOmdKS97k0GdFXjphNnBhXeXBSWkcOOcRVdv9CAAumzqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2571
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.114
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
Cc: vsementsov@virtuozzo.com, qemu-block@nongnu.org, armbru@redhat.com,
 alxndr@bu.edu, paul.durrant@citrix.com, ashijeetacharya@gmail.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's wrong to use same err object as errp parameter for several
function calls without intermediate checking for error: we'll crash if
try to set err object twice. Fix that.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Forgive me for sending this into your series, but seems it is very
appropriate.

It's rephrasing  of my
 [PATCH v9 03/10] hw/sd/ssi-sd: fix error handling in ssi_sd_realize
for partI series but but without use of ERRP_AUTO_PROPAGATE.

 hw/sd/ssi-sd.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 91db069212..829797b597 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -255,13 +255,25 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
     carddev =3D qdev_create(BUS(&s->sdbus), TYPE_SD_CARD);
     if (dinfo) {
         qdev_prop_set_drive(carddev, "drive", blk_by_legacy_dinfo(dinfo), =
&err);
+        if (err) {
+            goto fail;
+        }
     }
+
     object_property_set_bool(OBJECT(carddev), true, "spi", &err);
+    if (err) {
+        goto fail;
+    }
+
     object_property_set_bool(OBJECT(carddev), true, "realized", &err);
     if (err) {
-        error_setg(errp, "failed to init SD card: %s", error_get_pretty(er=
r));
-        return;
+        goto fail;
     }
+
+    return;
+
+fail:
+    error_propagate_prepend(errp, err, "failed to init SD card: ");
 }
=20
 static void ssi_sd_reset(DeviceState *dev)
--=20
2.21.0


