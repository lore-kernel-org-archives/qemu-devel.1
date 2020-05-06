Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAD7C38A2A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 23:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 982452075A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 23:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V3/XnR91";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="Teew6UoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982452075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWToO-0000Bz-OA
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 19:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jWTly-0006lO-RT
 for qemu-devel@nongnu.org; Wed, 06 May 2020 19:48:19 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:2215)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jWTlw-0006pP-Eo
 for qemu-devel@nongnu.org; Wed, 06 May 2020 19:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1588808896; x=1620344896;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=aKMSDx7zBZ2OSwytABORyUusEb539iVinrWqy9IGK/Y=;
 b=V3/XnR919+Wz1ffj3wmTrVFgRh3ZYDjVQAv42w7Mj4YqZaAeiB0xdZaA
 dHbzgh0SnR+qTCmbrZ/If/rTZz7yI8MkkXee8L8D+FS+GcsvQBE7ZSlZJ
 mJGJd+NmLnQk8hlNpGJGtK6Gy2sJeGpH0cizPAWtoV6q+cRG1AESAkcuE E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 06 May 2020 16:48:10 -0700
Received: from nasanexm01c.na.qualcomm.com ([10.85.0.83])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 06 May 2020 16:48:10 -0700
Received: from apsanexr02e.ap.qualcomm.com (10.85.0.28) by
 NASANEXM01C.na.qualcomm.com (10.85.0.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 May 2020 16:48:09 -0700
Received: from NASANEXM01E.na.qualcomm.com (10.85.0.31) by
 apsanexr02e.ap.qualcomm.com (10.85.0.28) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 May 2020 16:48:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01E.na.qualcomm.com (10.85.0.31) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 6 May 2020 16:48:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5E3XV0iF1bRYV+9hS84WLFLve5Jt26Uz6cfkyJlZYeMY07QQ/CUibYHLGm2QWLinLVRcJIIDrddEQAWEsEGDPqbBfPhk1TJ+fyl2wT9E0m4ddEJwxxe7Mk/XtNiqHTirKcTchuZx0XL3cZTv0yWQbe5J3L2DjY7Rk7LSnt3QGMseavNuFaWfV4X7Z8f4SMWFxjN/jai8zx2fMQYxf6fvzNZ3dMRTE4PxrcdDRaJXIZQFqEA1Jsfp0e9C6JIW0jNpyt+APisekJwzFrJqmDqv8UcQE/c4VL8pV3h6bECfeewpvsff4Os5PazTnEXkBZO06H+2HowuQJbrHQsAR2EwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfziM7tJJgSPx4z0atQ5AIdkpw6g3UM6IiE6l1UFGPQ=;
 b=SKMYbyR3CsW45RF3TSJkBPhX+ZmySj7iJK6d050xlSBLwXj1NOD2BpYJXtewehSqdUhxdmufFSOHJR3EwSaJ201aDFp2++aOsW7IcsLlnBRPp+Dzd90yY5V+oRrG/AR85ei3oixozNX8qXI1EWVrH8KwttIaBVjMPIdg5hfI+nXlw7jPQ8Ot50jTNBv9NC2guELWFFOWTjIf/xl5IIXhmpsUey0ELLEG6IAwxmlL3cYVWdVOc5wW34B400ud6H2+2smvXo+eFKHkY2SF4vF/b8s7ddpeQ2XFhc0N56Ze3kuH0qziH8FkwZL+KkNMU6yqfPGZjzlSmEuhb6wd3or/JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfziM7tJJgSPx4z0atQ5AIdkpw6g3UM6IiE6l1UFGPQ=;
 b=Teew6UoLJFd0H9sJNb9/W+8KPlF8ZjrtXGCwuEdoHoz1FYovsvGW/4IPaDI4Ocf8AkihM9y4pN/jpk6SHhu/c2NMp5wAxTa4Vb3igAHSH67DwW9IZmmjLaorQ4d1/KesIh8kSK6F44qEyVtYfZRZt5cdntY5P/uI9QQiuBcZ2kM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3626.namprd02.prod.outlook.com
 (2603:10b6:301:77::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Wed, 6 May
 2020 23:48:06 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2979.028; Wed, 6 May 2020
 23:48:06 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] Fix stack corruption when handling PR_GETDEATHSIG
Date: Wed,  6 May 2020 16:47:51 -0700
Message-ID: <20200506234751.7920-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:208:23d::10) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.qualcomm.com (24.102.122.190) by
 MN2PR06CA0005.namprd06.prod.outlook.com (2603:10b6:208:23d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend
 Transport; Wed, 6 May 2020 23:48:04 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9647a07c-fb42-45e9-3ff1-08d7f217ec24
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3626:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3626B1B9EE47490FAEAD0145C7A40@MWHPR0201MB3626.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FnucNo19aczOzjlKrw2AvZsyQHVnN+xMPxKA/+WFtsHLKVv3ITl2/fSW+JNYWs4YclvuBkDElFiOlra7h8RYiICpGjhjbcawqF5Ieji74J1tyscPLMklRkSWckU8PAaeobfWUEM8OXGApOdbo4CcAskn2hyS7WxeXGb/WFNPwLnQmJ3nVHJadBaXO2kO13h1Xr1I/Zaz6GEkkrxlxuKinDSz6SHoClq0gABUmn+JlAruLQIbQ9YA7ZHXtsUSWD21grn9ADuKYl0jY5WfNqj5kbn/5m9/NBfM+4gaUXhMMenNGGStRoos4f4GzjXNbYkMSDdaQBQvSKSmzGGGV+ZpsPzG5YQ9YeAIb7hrWBageUlnyJmC8mN9i5/p039UphEQ9RPkbS8ntI6gKpLmCq/HGi/nBAJJo7/qwvlrLouy5Mfn5pb+hGfsUS+R6Id3jWpyKwFehGEnLLr3gW4/6Cty0ecLkMBCYgwMyYLMlHHeS2pU6f1wsXAA4AvQ8CuoCLFzxOXh6Sa5qkuyYrIVUhAG3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(366004)(136003)(39860400002)(346002)(396003)(33430700001)(8936002)(66946007)(66556008)(66476007)(186003)(6512007)(956004)(16526019)(316002)(26005)(86362001)(8676002)(52116002)(2906002)(5660300002)(6506007)(4326008)(478600001)(1076003)(2616005)(6916009)(107886003)(33440700001)(6666004)(6486002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Bj21FYr8/m7YQGPSxsRim/qm6ZVqtBrYyR4w2iDm4XBGmv2zAGI4eiKCt9G4CDOq5QOUd2MIVxAYtMKaCofVHpW227pPCGcKua67LC5QyJSFdXW9sHuPpXhmoqfywfP8gsz404BWX3WO4SCJXYl/9uI14ziqemOdMgrRQzSUZ37Ni8V9y1ebIBbUwsoQRR7jgLfrPK6Iya2KVBkDJDxtOdq//8IVS3poWEd/4CpxPZHtdGAiS/DTwbxMn4qjn7K6DcbYj9117Zn6epeJoNbvrLopuU2MIt7DLgjYaavw2zV64ccRUmrNNZpvIGWeRw4E/5uWjzqbNOQjAsd10qzbiBUY8lVgiHsl2OBP80op0I5Pjf4PaH4HfAcxap0AhpLnHwbp44V0bVuboFWf+b1SGNHLwf1GfxvLsVd576+C0+XLkXeoAWFY3pIjhpZtS+5KSUfUR7aYEpegQUMadpzAeWxix6NC8Ufmy6DQRPnV9z39Z5j+plfqrvclElBy5/J+2YuClnJAoPNft8qGcXef2qXSaImoeOSxnmtYfh8n8or86+8mjw6V3IxBRYwblcKqZFbgvYwrPJRoQo6aABF6EHbnjSHTBBOznnCzohS1ne7Hxd7PFTVm8wH3HLFQJaUfzj1vR7ZBs9XxpJS98reZBH6VSiuCwsMUdWwtRoodD24G5Y+cOUOrmFJh3obkSR0RnVgEDNvSLAXOWsRJ3Sa5bLhjvJFCpCU6Q3PGwwPoqPdC/Db/Sdz34FZ/1jNGvMesnPVaJOk3/ExkZBqOQzs9VMGsHdkQxZvn2j7RdF7/N1c=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9647a07c-fb42-45e9-3ff1-08d7f217ec24
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 23:48:05.9606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: un+VReAmp8JEWfk50LPaHPnrUSioTBXzD0P/nDZzmjjMtqMq4NqBFi1SH1VQyJCvZfjOo/hwHQIx2KvlSkKh2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3626
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 19:48:10
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
Cc: pzheng@quicinc.com, riku.voipio@iki.fi, efriedma@quicinc.com,
 laurent@vivier.eu, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ana Pazos <apazos@quicinc.com>

Signed-off-by: Ana Pazos <apazos@quicinc.com>
---
Submitting this patch on behalf of Ana Pazos. The bug was triggered by
the following c file on aarch64-linux-user.

> #include <signal.h>
> #include <sys/prctl.h>
>
> int main() {
>   int PDeachSig = 0;
>   if (prctl(PR_GET_PDEATHSIG, &PDeachSig) == 0 && PDeachSig == SIGKILL)
>     prctl(PR_SET_PDEATHSIG, 0);
>   return (PDeachSig == SIGKILL);
> }

 linux-user/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..4eac567f97 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10253,10 +10253,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         switch (arg1) {
         case PR_GET_PDEATHSIG:
         {
-            int deathsig;
+            uint32_t deathsig;
             ret = get_errno(prctl(arg1, &deathsig, arg3, arg4, arg5));
             if (!is_error(ret) && arg2
-                && put_user_ual(deathsig, arg2)) {
+                && put_user_u32(deathsig, arg2)) {
                 return -TARGET_EFAULT;
             }
             return ret;
-- 
2.17.1


