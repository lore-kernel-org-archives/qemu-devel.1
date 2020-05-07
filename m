Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8B0C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36EBE208D6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pb0/+YV1";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="OdCiimNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EBE208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWgDi-0006RX-33
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 09:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jWgBR-00045R-8o
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:03:25 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:44151)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jWgBO-0005Z7-Pq
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1588856602; x=1620392602;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=Lu/P8kCaWCWQjA9OKybNIw8xpFNWbPnE67fq6b2dr4A=;
 b=Pb0/+YV1sl0ZY1/aYfQtjG+qZjXCjBjtXtFuLimamhe2wKnm3S0oFL4V
 PwOK2kpk35KGGgkXfvn4+TrPmaJEJd9yWgStE6DgfCy0+JcHWXHKxIsmL
 /CIFds9uBWAYQHD/jBjIBlBWWEXBP+Nmqrm+tymUYSREuOgoomxpIoLqp g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 07 May 2020 06:03:21 -0700
Received: from nasanexm01f.na.qualcomm.com ([10.85.0.32])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 07 May 2020 06:03:20 -0700
Received: from APSANEXR01B.ap.qualcomm.com (10.85.0.37) by
 NASANEXM01F.na.qualcomm.com (10.85.0.32) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 7 May 2020 06:03:20 -0700
Received: from nasanexm03h.na.qualcomm.com (10.85.0.50) by
 APSANEXR01B.ap.qualcomm.com (10.85.0.37) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 7 May 2020 06:03:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03h.na.qualcomm.com (10.85.0.50) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 7 May 2020 06:03:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpTb5KT5aiaK9BsbBt/ZWkkV8q0L3iq5tCLkhHhA1kAXDUsWCAE71v7LNohtEFkEc09D81hI316JE6pcuqcehjcPxlbMAIDXi9Fa+NXD+2KgCN9ypiasTHzCqhUwq68Pb49Q5SvRgD+vXmGLFb+CoSaJA8OHFEsGUyISP025V40/xpWngnFbEHfsYfzwcMKKJ6XvoOpqF9mdJ99Erjow7njeF6NzdFs9895F6FU+RfU40LzHQhFb07M9HGGEe/1E1C7yseG6Rg9cGWPWdWevOSnyqf6PmzmraUhUHRhligmWYYp/2+Wxk3LTkNZ5DlfKl32c0wSoSqK/oePVSgdOuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSn+69CcY7gRI7wjz07YJoXEdEgUgXebIscIxPBO/pE=;
 b=Lq+Xwwtz9je9B6uPTGJDED4/WUJPu/5Hg48m4eGS9Fm7+bRIzxO59ClD77xW771ltNcLDn1UzTXiR7NnP/NiWBvifXd3dF9LzV0CE00vo9T5fwG+WGfa568C1gxnaZ/7QIIElaV/5wcNj26aXSTK5lSigNl9COmDiLA7qbZLICjPLPXa+joDw4ZRMTOr7jT3wr1mEiRDTFKiCCXJRWsGxyNpqtn75W0kqeFbrkFkxiD30BgoroRDyfKBdL67Fw9My4UXkpFGcLQW4YOB7vwwRq+GbMMSvMptu2WiDvQ++2qfWipPqDW5AuwXG1ZSXf4tIDqB4UTSjgUCyaOx+aPX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSn+69CcY7gRI7wjz07YJoXEdEgUgXebIscIxPBO/pE=;
 b=OdCiimNrQPpGZ8eQPrQxqCRZkyeWq2l0nO9tpdJv3E4SOZWoyS2q82if39qmrKD5fRT+USfRAvCDIjN0u9q6jtyK/r8VSBuziCLKulnfHrR++3rXdhPLq8DfLurtK/zBKyopu7YR8W+3Fldqgfw08ocCKETMSX/WWFuMu4PAcX8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3625.namprd02.prod.outlook.com
 (2603:10b6:301:76::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 13:03:16 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 13:03:16 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2] Fix stack smashing when handling PR_GET_PDEATHSIG
Date: Thu,  7 May 2020 06:03:02 -0700
Message-ID: <20200507130302.3684-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0026.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::39) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.qualcomm.com (24.102.122.190) by
 MN2PR15CA0026.namprd15.prod.outlook.com (2603:10b6:208:1b4::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend
 Transport; Thu, 7 May 2020 13:03:15 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08cae30a-5149-4cda-ded0-08d7f28701b6
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3625:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB362510DD54F341ADB0906E18C7A50@MWHPR0201MB3625.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WLsjqnWsBwZG52HEqvD/pMAB9r8xWEENArcohwzdantwW0Q8UWqHxGrEOCH9B7lJU5eSxSbzqlgl6dxE8/IWpd6YU4q4BybCLgWNqDHeq0bRI/zcTLPTpTqK65NDebd9y3jMUA0cWWhoW8IcSPYo1ELCJNF0wkO6QHXBiQUP5tbjuyQa8mHNrq41WNFk1cke8uewQW5OdVdNYSPLpTBeblDnssZ3ecY7owa0FwywNBhSXpQu20rMdGrw4SdMR4zoX97RQNY2bYEfy8EFvs8gm5WwYhRcuTaDb7PIXLg8cfioUn3Ez8Wn42kyytfj2JzsU3zQz3o3OGsEB7QpZuj0PHs1cJqJY/V1eUebT95doEayodmPs3tXPjqSkeC+zx8yJFzI3aXzC4UjW/rD0wRijAPE2R/LgGHijJ43PCk8Q2P53AcK2WqurKYxWK66Cfx78sFqTODoCLo20L7zn1Ps7QZAj35EyR2JcLzNaQtRQ5cD9tIR84+vR/bU6RUrdQp5dDFUhsVNeCKEfiDQHuOpow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(39860400002)(396003)(376002)(366004)(346002)(33430700001)(66556008)(186003)(4326008)(16526019)(6486002)(26005)(36756003)(52116002)(956004)(2906002)(86362001)(83300400001)(6506007)(6512007)(83280400001)(83320400001)(83290400001)(83310400001)(6666004)(2616005)(107886003)(66946007)(478600001)(1076003)(5660300002)(66476007)(6916009)(316002)(8676002)(8936002)(33440700001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: FfP3VcGWLL1IRiKIRrnu2XhqPoutYixkdInIVjud15E26pl6wS2Zy3/M0U5QOAPc7aE1TiMmsD+d2guJKy7qf/QvuJ7Ls3rLidxTc6HRMX/E0XrXkaOdtK4uaPc3tBLc/pCVtyb23INFUHnrGeTGvWdetfPCnoRj15hSGC7nIGLrZENXjurC+Pqw20huokLNeT0mSLdlgaVcYoEAumzxdx2aToTqKH29aP3RhNt/iJoq6a9ib+v+e7/16sftaFX9J5bebRN+JwUHQ/BBwnAfFlbUNDj1iMRQTb/4Qni2VqCbyUdrXpZxc2FvTZntj6VHiIMB9oXRTRWR77D5kbfCr8Fu1twUaY5Mg0FH7IxNtW4P2D99KFHfH52wakffvpMQtIBBxS9cy/abnBl6JKGW147ZHh5oWifEtaANn148rDbPuPMUNGcXwNcEQCsm4RWJaP7rWYWYOyjpHCgb5VvqrRFAQbj8r40aPVhKnSHBjFs0m+bHqpW+yQrSpNZRR3S4Tzf8eNrC7h0KKzI9j7EYPt4ZrHYrMvj/FxbR2TpmH/xgV365SP7V3VY2rgUKqoDp6rK/J5aqt75H4AMHAp9a9v9LK3wz8hKGZX9xHwF3j+OqwN7szQJyQ+NPNFCjTyaZfckUYCE5IGCOiL/iVVHxNFWvdYdH1/LE5iW5djl+Ub5ANoLEMQ/5jv+62WDMOQ9vAQ7MRyfhKHT6GDVhxwR+yv5oN3zrC7Q+e2iEX2Bji4m+c51JaP8nFxeQfXHTmgTRj2OW94hAB11FpUdle95YK3apzy9hQrskFcepiFe30HA=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cae30a-5149-4cda-ded0-08d7f28701b6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 13:03:16.3131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdNO/fUoZMt2HA+g4Inmhc9Onwlg3ETv2YUnSsPtOcLmT/9edXheoduyJOfJxrba5r4yDQijKzPr5t3263cSKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3625
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.39; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 09:03:21
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The bug was triggered by the following code on aarch64-linux-user:

#include <signal.h>
#include <sys/prctl.h>

int main(void)
{
  int PDeathSig = 0;
  if (prctl(PR_GET_PDEATHSIG, &PDeathSig) == 0 && PDeathSig == SIGKILL)
    prctl(PR_GET_PDEATHSIG, 0);
  return (PDeathSig == SIGKILL);
}

Signed-off-by: Stephen Long <steplong@quicinc.com>
Signed-off-by: Ana Pazos <apazos@quicinc.com>
---

I fixed the incorrect subject line. PR_GETDEATHSIG should be PR_GET_PDEATHSIG.
Is there a test folder where I can include the code that triggered the bug?
Also, I thought "int" can be 2 bytes on some machines.

 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..91f91147ba 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10256,7 +10256,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             int deathsig;
             ret = get_errno(prctl(arg1, &deathsig, arg3, arg4, arg5));
             if (!is_error(ret) && arg2
-                && put_user_ual(deathsig, arg2)) {
+                && put_user_s32(deathsig, arg2)) {
                 return -TARGET_EFAULT;
             }
             return ret;
-- 
2.17.1


