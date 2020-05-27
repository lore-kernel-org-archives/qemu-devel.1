Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB0EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4234A2078C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T8UclndY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="M9Gd2gpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4234A2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdox1-0006M6-D2
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 01:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jdoqI-0003A1-Ar; Wed, 27 May 2020 01:43:06 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jdoqG-0003Rx-PR; Wed, 27 May 2020 01:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590558184; x=1622094184;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=TYOhDUvGXhVIkQHt2ZGBAU2yZzGi9FOklLlhVGSZQHA=;
 b=T8UclndYfdAY5HD+VBbBSzQCB8O/axLBgSp57Ls9Nj4SF240ETufgCvL
 fBnrOwL9eg3NZdF18kHjkhL3+rBA9HRjm7FHH0y8/npKhdwUYExk9dSp8
 1CHFBuRh8cvILA74kyqQDjnSf7yRcviGULSakADvB0ocf11cmHPynjQec
 eGdDc0V/ClZyNJ3zX/tIsyGR2dJC/DSIW2D0N7EHQaMOcYGLAfRPIvJAB
 JYYdIsl/dr3RGBL7dnRqW3V2zN+TeCSOQ+8Hv/jb0O294S1ROnUfP0N+X
 k8384VXbG+sgVN054/s8CAECorRBTFGYXyv+DmNqA7+Ai5wI0LUqCKPaL g==;
IronPort-SDR: VKsFZ11wKOxHkyOlvXXN5a0d8/w8sJtLG8+nF9vIp0kkQqfz3u5+uaoAUyuhnSTVxft7uztcne
 7Bw3JlLwGGmq1Rdbk/VmSAUkoNpqz0rdy3qvhoAVCPiwt37Co7b4XmRqLH49HWjrs/GqUNU6MF
 SgX2KIWtjpliqqHK5dD3WRlPP2FiTVPifiPBLKf+XdwSp57gMTmFUS7VcTJ4E3CrPogQYweXaL
 0Zto+FRMg/d7CaJeua5PgfFRyS3HbhBci9C6dMRM4uppfh0RF6wymosOMIq9/TOkEvisoJGubg
 Fz8=
X-IronPort-AV: E=Sophos;i="5.73,440,1583164800"; d="scan'208";a="247638074"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
 by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 13:43:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3iAG0ypi7ZQldgycVMUaVovnxK1j+W/2ah6hbr6/K4WJ6cOXv9ZCaMZlvYfvUa2OawHj7jH2COyi98d/Q7TEb7harbsEaPpTgcCBXv48Zye03GB0I2lF9NijdJ3EJQB55yW7T4hWFROzlMgQlAWEb7zVKhOQoCGZ9wlsAKCMMxD21dKMNbG59SL/Kf2redK90sIbANAp1JJNIhmC8N8n7v4otMsysBoDUOLy5X/w7YxtxZP1qhfKy+px4guEmQkBl9eZLV4+Af9EyaAq2ny2/Km1u95Pg/zOHT/HC0q1qm50PQpLYeV35z9N4MmqXls+QEgdCNf6n3Dc1g+wmqHvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5wFUTJ97chLrxAx7+sb4faEuMenrhWFh4zXvcXH9J8=;
 b=RczpWTVR5Q7KeLiTKB+IzC+YQcpz7WPMKG4ysJEmW43oneturmSO/LkuZ66FbdsqNdSUdld2uFO0yfPRRtjESG0G14iSBV9m9kzdd9CTXDqnOrsPnZ/HHExjXKd18wNjhZGynwbt4qQmonmK9hTAhOQRoovk0opW/wVq63caDCtiLRpiFLHRPRQSFbgalbVONtJ8XdtqOyKgdr1lRF3PFK+orpgLNCa27RW7eAWElDAbH+ZMVla6+g+eH1vIKNl2KB/R9Y4ArLyPlT1NkXipSxTugKqXlgoXdPyW7jleF6MPGynf3S5I9AOKUdOH7exMm5RMasxU/K72Y4EhM0yDrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5wFUTJ97chLrxAx7+sb4faEuMenrhWFh4zXvcXH9J8=;
 b=M9Gd2gpxUEgaf3sK8QFbDEUy7igNsGhcAwz2Sh0JfjloLbQTPsbGxpdKnHFblll8E2pu465Rk6C7iUi/NvH6EdGGPbM/a+I97XTQFeT1J7ULVLyDCNMa3N67FRNsilKsxvpEkQ9w+DAvczoiAEgwpCwVWRvZ+ipm8krf6/fkkuc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6923.namprd04.prod.outlook.com (2603:10b6:5:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 27 May
 2020 05:43:01 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 05:43:01 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v2 1/5] hw: Add sockets_specified field in CpuTopology
Date: Wed, 27 May 2020 11:12:22 +0530
Message-Id: <20200527054226.232103-2-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200527054226.232103-1-anup.patel@wdc.com>
References: <20200527054226.232103-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::20) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.30.5) by
 MAXPR0101CA0058.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend
 Transport; Wed, 27 May 2020 05:42:57 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.30.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 310b8f55-c395-44f3-7a7d-08d80200d19c
X-MS-TrafficTypeDiagnostic: DM6PR04MB6923:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB692390D59A4847014D5C332D8DB10@DM6PR04MB6923.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ySXkXKtQO2fQ4wG4Y5KaL5MADMQmPYpl2yXBqD6IyZaiITBXi+CsBFJH0CF0iDFv9kwTpVTPz4IMvhnY23NoMOYNf7WSeaZ/lCEihUCRY0rBcS1TmAFvcP5osFNRAO96jQbNpiRVz+H00zc5TDrtDwvEDcESRFGFr4mU2UJ0bmK1xGX0LoUDJlKKfFRu7Z9OiWs/xyenosaI23gEsS2L60N7BvbixyLqoHY1ypuQYbBDdMxQ9ZWFgkMLihYiUFxfYqCdVlMlKCeyW4TvZDREbsJHjayE50pbF9lLkae684ObmbXqwop5pAqnKIPmmHq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(1006002)(110136005)(6666004)(316002)(1076003)(8676002)(2616005)(5660300002)(956004)(8886007)(8936002)(36756003)(44832011)(4326008)(54906003)(186003)(16526019)(478600001)(26005)(66556008)(2906002)(55236004)(66476007)(7696005)(55016002)(86362001)(52116002)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: C2RrkNkMfFNoKrje/PxtWSxvPnf2nOTFBZ+NqhZ8C+ob9z3L1lV1BVFXPZu90cpVf4VMUDxMJc9dnWDZnbBFJr8dnWUqQn7mER24/9diR93QS/y0GuRoHAi/TPcGZXZ4K4s67EcDMgFY2Ie4M5e+2YEOqsI2LC4QnOURrYrRZCF6gJA6A06flIqXBTkekSOjQ0+EvDX1d70JSSahEFULxD/n63JfMt8JEElvEO0PamsLPgd0ictXPghfJEsrsNWaRauldLLBt1SD6eLmcjxcepEHopHQOgRr5PSJymzCoMXx3RtlF+G6kBa8XDHLhf3muGZiGlStlS6uc8aqmNI3/8IyeFz2wjqgBZC/jpS/QP/96Ssu8tR/6KYkZL7dYvEIdUYeiEaMqDU5H10YbC5tZwuXAue9z5cdkYxembq6o0BIPSBnYKN/8IiavBgjnpwb9jlhX9a1W0iQe83ZncE/te7K+V+c+AQpul0pEBKnSjE=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310b8f55-c395-44f3-7a7d-08d80200d19c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 05:43:01.4662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UiNMVxXAd6W2V7N3CihJLMvUUIxTSKGq1G0OpwFBlWB27nAHHqaNNFfYY96sKUxoXsJXQ+NYOwGnULp1zKKoVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6923
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=409226bd6=Anup.Patel@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 01:42:59
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When "sockets" sub-option of "-smp" option is not specified, the
smp_parse() function will assume one CPU per-socket and set the
number of sockets equal to number of CPUs.

This is counter-intuitive and we should allow machine emulation to
decide default number of sockets when "sockets" sub-option is not
specified. To achieve this, we add boolean flag sockets_specified
in struct CpuTopology which tells machine emulation whether the
"sockets" sub-option was specified in command-line.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 hw/core/machine.c   | 2 ++
 include/hw/boards.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index bb3a7b18b1..fd5ef5a4bb 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -706,6 +706,8 @@ static void smp_parse(MachineState *ms, QemuOpts *opts)
         unsigned cores   = qemu_opt_get_number(opts, "cores", 0);
         unsigned threads = qemu_opt_get_number(opts, "threads", 0);
 
+         ms->smp.sockets_specified = (sockets == 0) ? false : true;
+
         /* compute missing values, prefer sockets over cores over threads */
         if (cpus == 0 || sockets == 0) {
             cores = cores > 0 ? cores : 1;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 18815d9be2..59b28ada65 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -244,6 +244,7 @@ typedef struct DeviceMemoryState {
  * @cores: the number of cores in one package
  * @threads: the number of threads in one core
  * @sockets: the number of sockets on the machine
+ * @sockets_specified: the number of sockets were specified for the machine
  * @max_cpus: the maximum number of logical processors on the machine
  */
 typedef struct CpuTopology {
@@ -251,6 +252,7 @@ typedef struct CpuTopology {
     unsigned int cores;
     unsigned int threads;
     unsigned int sockets;
+    bool sockets_specified;
     unsigned int max_cpus;
 } CpuTopology;
 
-- 
2.25.1


