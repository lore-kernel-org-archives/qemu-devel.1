Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A55C4CECE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 19:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6127D206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 19:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="K5odHVzP";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="aCFHEbb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6127D206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCq6z-0004FW-DU
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 15:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=03412eee96=coreyw7@fb.com>) id 1jCq5m-00035v-7J
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=03412eee96=coreyw7@fb.com>) id 1jCq5l-0007fC-5o
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:35:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27802)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=03412eee96=coreyw7@fb.com>)
 id 1jCq5i-0007V9-RE; Fri, 13 Mar 2020 15:35:31 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02DIpHdY006021; Fri, 13 Mar 2020 12:35:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=facebook; bh=Gqb4Kplo7iJD/dasTcAzF0Oly2xDUuR1CKIfVh084u4=;
 b=K5odHVzPyk9qxx4hjcbyNr2MzjMZ8fn3QNRUbFnsJBijT2n8Fibui/uytEtIIyZgS93z
 qYNAOaD1vPuBfBM1KA5mmdDqTGIDL2SlzaBchnwU6DQx4FyRr/cZG4M/nCs/kuYZyvRc
 4qk1L8CRSuIG8A/2GyksQDh/s9tzIHEQWw0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by mx0a-00082601.pphosted.com with ESMTP id 2yqt7t5y03-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 13 Mar 2020 12:35:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 13 Mar 2020 12:35:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5pyWJs9s23k5Ris/Ej4HVK3G8cbj7t5SeAn5wjeQzbklwp1oLU5tiPxrPqd33IAXbkY/TAslH8I/sbeuHdrcwOPdVokAScjDSZdnTmT77EjF4kAouRK7l/a7aY28ncHLhk7lxXw4yQjpyO85yjkGSdOgxGltTuKuskGaWQeg2GhFC0SUIyNzFSJTQwBwGLNc4gd6FSD8Dn1rfPLjq+Y93YhBpoS8qFQfycnxdTQctOZPlYcJBoW5dNSG086Qy7jiTimeJZxdgYv4gHqidwncMJ7e9YdjUNru1hR/9JqIrdl1BHTMa/FsywVbWGEwEh57O5juOL3OwHxQvVkQbczww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gqb4Kplo7iJD/dasTcAzF0Oly2xDUuR1CKIfVh084u4=;
 b=LaRQkPTJ7ZaBRo3+7JNQkzMf+m0Kln1HPuO33q2saYLMumBq27/uLJPt7cIHn378tlAwsPUdi1JkfH8iDrL6ju3F3EkVtuA2j0zx9yShw/5JHR203w8SO8RAU/UzcX3QRAkiHDAWWZ37CNyxR/UBjC2lk3dyhfZWLkcDPoI5541fNW02YLsWmJ4PZh1kCP4sXc1Lh7wsay+9RUBQMKwOPn4JHeliyhFHUmMQ3t+lSo3bp/dbroTrOweHL9UHMtEs2PrnkPxr/hk/Dx88nXpkJaCKW5WaPmh77ohOmQQY5unZ8m+TQx8dV6/LMAaGNDdnh4cTPTTYnyv0siPQH3KwJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gqb4Kplo7iJD/dasTcAzF0Oly2xDUuR1CKIfVh084u4=;
 b=aCFHEbb1Fj7uSKUozBYX9z7kDR/oiA4Yhnn0a6ODLVIMG81D2G9SgaWBlInAeAzuOApiM190223ZKOKruxQ3HfCXmNxSTdqJEX+B+pb6Goxu++4C/e/fWUxvPk5GRwjnGnbGZbheoVL2rwYMN34b8S5p+TTRfR67Cer/wNFCc+4=
Received: from MW3PR15MB4041.namprd15.prod.outlook.com (2603:10b6:303:47::20)
 by MW3PR15MB3803.namprd15.prod.outlook.com (2603:10b6:303:41::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Fri, 13 Mar
 2020 19:35:16 +0000
Received: from MW3PR15MB4041.namprd15.prod.outlook.com
 ([fe80::c110:c47c:2e3b:af31]) by MW3PR15MB4041.namprd15.prod.outlook.com
 ([fe80::c110:c47c:2e3b:af31%5]) with mapi id 15.20.2814.018; Fri, 13 Mar 2020
 19:35:16 +0000
From: Corey Wharton <coreyw7@fb.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: [PATCH v2 0/2] Support different CPU types for the sifive_e machine
Date: Fri, 13 Mar 2020 12:34:27 -0700
Message-Id: <20200313193429.8035-1-coreyw7@fb.com>
X-Mailer: git-send-email 2.21.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR21CA0060.namprd21.prod.outlook.com
 (2603:10b6:300:db::22) To MW3PR15MB4041.namprd15.prod.outlook.com
 (2603:10b6:303:47::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from coreyw7-fedora-MJ09BKJM.thefacebook.com
 (2620:10d:c090:500::7:96c0) by MWHPR21CA0060.namprd21.prod.outlook.com
 (2603:10b6:300:db::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.6 via Frontend
 Transport; Fri, 13 Mar 2020 19:35:15 +0000
X-Mailer: git-send-email 2.21.1
X-Originating-IP: [2620:10d:c090:500::7:96c0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7af22d59-4e31-47ca-6b52-08d7c785a82e
X-MS-TrafficTypeDiagnostic: MW3PR15MB3803:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR15MB38039CBD7E4266E0245C63E593FA0@MW3PR15MB3803.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39860400002)(346002)(366004)(376002)(136003)(396003)(199004)(186003)(16526019)(66476007)(5660300002)(66556008)(2616005)(66946007)(2906002)(36756003)(8936002)(81156014)(81166006)(8676002)(6506007)(4744005)(1076003)(6666004)(52116002)(4326008)(478600001)(86362001)(6512007)(54906003)(316002)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW3PR15MB3803;
 H:MW3PR15MB4041.namprd15.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cvgf+AF24C+UJMZ938O+dxJT9L53Psuz1Fz1nM1RKGTL0TZV4TWmlZLVk3ld+ppGIN/s+ak466z59OuyrWt7nWgMzUx9BCZrMf3e6cfoK97nUGiCxli7b0JXgjrRIJ3M0VEv2mtqt0rcv/M9lYlBAQhKfzfSLYzmJXlN2ndwGwzQ5yixlT1JH6JiJtuWpsjjFhyQ3iiszlXffpGwji6l24/so0x3fDrEpvxZVBJ6s8DkbWl1fcGaq/4QetWxjQ/xLrR/UtYdhFuxYcqc/ByvV5b+oOoYe1HU/C4LSLx+WjozbEVXf9G9VS9HQWJfe6+lDULQoWS7s1MPG3ANwPlIs5BhthFptsTjTb3QHFdHHax2HXMYr6Ky4ANAkBDkbxq8hUKT/Ksli11bUvXVBnHPZrno2J1Y7JJHYFFQTBqVBGp5yHh6NdDOqM1c5sQaHCxu
X-MS-Exchange-AntiSpam-MessageData: yb+3Chni6/3362jCT4yhQS4aXLO2Ksoq7rHoyjDa0ixXSiOHW284CfGEB/54LC3ZbdtqSjxzEyxG0Qj53TrgkqbHh1z1wdqiL0eQEv86VdSSOmleTGNnXzr7G3yS5eGpcqQntWVpmkbpytFdNcuiqg3LU04/pnlOiLGnjArPKHYQOzOVthKxRtJ/119MLyC7
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af22d59-4e31-47ca-6b52-08d7c785a82e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 19:35:16.4537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guclRID4ucQwaP3VBLG7lPmNbzLy+3QTzibBGt0Gp3NRx8jHq1amFZPaHdzplw+c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3803
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-13_08:2020-03-12,
 2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 clxscore=1011 mlxscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=444
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130090
X-FB-Internal: deliver
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 67.231.145.42
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>, Corey Wharton <coreyw7@fb.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The purpose of this patch set is to allow the sifive_e machine to run
with different CPU targets to enable different ISA entensions. To that
end it also introduces a new sifive-e34 CPU type which provides the
same ISA as sifive-e31, with the addition of the single precision
floating-point extension (f). The default CPU for the sifive_e machine
is unchanged.

v2: Added missing RVU flag

Corey Wharton (2):
  riscv: sifive_e: Support changing CPU type
  target/riscv: Add a sifive-e34 cpu type

 hw/riscv/sifive_e.c |  3 ++-
 target/riscv/cpu.c  | 10 ++++++++++
 target/riscv/cpu.h  |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.21.1


