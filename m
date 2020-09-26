Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC3DC4727C
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 02:00:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37C872087D
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 02:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nvAq4dF4";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="P85O9/2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C872087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLzVX-0001HW-S2
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 22:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1kLzUc-0000pp-2F
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 21:59:19 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:62153)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1kLzUZ-0008SK-Az
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 21:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1601085555; x=1632621555;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=LZPNQwih/o2nzIbQzKCInL1FKNM7+0jBGJ3U1WYkBZc=;
 b=nvAq4dF4i/gjGHiQm7NaxJulX+KjQ9oAx6HrgHLpGfLhoUpLHG1rMnMT
 deY0Iz1LYUr7VGbFQ0G2UqphFYSzAVpbEg8r/yfzAhC6LlnrccPF9I+2i
 ypNGUZ+dxE0OiVddf0cZjG8qP42ShnZxzYOPxbf0Duw10CWTM6NrMXpoF o=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Sep 2020 18:59:10 -0700
X-QCInternal: smtphost
Received: from nasanexm03g.na.qualcomm.com ([10.85.0.49])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 25 Sep 2020 18:59:11 -0700
Received: from nasanexm03b.na.qualcomm.com (10.85.0.98) by
 nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Sep 2020 18:59:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Fri, 25 Sep 2020 18:59:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4pT98gnyqGL9snosHdtnP+l92ALdfA17RRiiwB8ZZI4IXgN10iN59olX3hbVDrJ9wT8ykwCGhXadT8Ng0VilZLlP1uQ6cdKaPOJmUL/nD3+TG0++xr6U5JJLJzrngvUkL+cX2tb1fHsO4WoMVxK8eGCEfVpBxJtu0QIn+aFhbS+rK3sY3HWQIMGGgwSl/sun6c6m5wvkWdnP0iG3EujIsbd6glvaKGH0it50h4istDjC3WtxY6z30dpa6OR39EXl1uk9WBMv0KvQ01PB4QRBVAlylfdiCOfNmIAFrZGMghvmrwuuG2DatPslo4KfO8RYWV+K4oIvDCu0zes65MhVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dl7YEl213qRTIh8V1Dv3zDsbfhcgbZ13kzJQr9E+wWU=;
 b=U29AmJNC8XYDwl0lJ6p50gm3NoiLl1guZOWh5b00wtHJ6rfUPATWHM5RqEzxz0gWZM34khUHjLAU2UH65YIMrirQIPaTyIRFa7qjRFpfXPBy74F0b50NBs1BHcyLy46teiAQf0/UOSIkgiYY3pKiQYIDzmmc0d3W6oX7TwrghO0FXgkWLSR1aMZ4d8LXx7qLU4llpxvfnIi2BQgy8cxNMCOgt6Qha1eQF417OYWUP7im91Otc8eryChPOsMmHATdiAv+fat3IgjgBvvbVdGAOda5onzupmYrSpOZhkczqJqnFoggCi2uzDCPjiBnNAjPZ4SsCBzevFHqLHYwtCggsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dl7YEl213qRTIh8V1Dv3zDsbfhcgbZ13kzJQr9E+wWU=;
 b=P85O9/2qzem2shY5NF7AxlzbRis6S4vOFagXIvCoOIQe1TvvGRcRLBFdLe/DkPwXFKVWuQFSh/r7Y9wFcAvLMaFflIqQkqebE3RFahw8uiMZIPTKncXMrUg9itU2+i3+yIT9aeR5UIlFanuD40R9RCi1p0xAeR/3Uod5of9TlWw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3545.namprd02.prod.outlook.com
 (2603:10b6:301:79::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Sat, 26 Sep
 2020 01:59:02 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::dda2:8e04:fb37:ea4c]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::dda2:8e04:fb37:ea4c%7]) with mapi id 15.20.3391.027; Sat, 26 Sep 2020
 01:59:02 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: Re: Re: [PATCH] Fix stack smashing when handling PR_GET_PDEATHSIG
Date: Fri, 25 Sep 2020 18:56:49 -0700
Message-ID: <20200926015649.564-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200507130302.3684-1-steplong@quicinc.com>
References: <20200507130302.3684-1-steplong@quicinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0086.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::27) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.qualcomm.com (76.167.74.154) by
 BYAPR05CA0086.namprd05.prod.outlook.com (2603:10b6:a03:e0::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.17 via Frontend Transport; Sat, 26 Sep 2020 01:59:02 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [76.167.74.154]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6e826bd-e555-41d0-ef94-08d861bfbdb9
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3545:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB354553BFAB0D286C84126328C7370@MWHPR0201MB3545.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ovGAaQ11YSdtGxTCTae6QLcJjVe3grgnsbSdCqFEfBVtl/5S+THFqRnGbrelInDkAmJff5B9BttiaO18EmbeP8FCQYtpLuqqYEffPkwvlE6BAL14F4sgIJOiuUkYMvnme0n67gvXRan6vIjvLyJR8cOw9zy0i/uwHdmdDvVrvJRYz30B8lNwkbRXoPGo46pTTFtosV0a+/b/9bhrYeZJhGm6dGKIzJy9rbNlSJFOUWwF+bdcwGnCvc26kHs/8XeC5VDObCOBvYrEklTWs0BIZLk6rlewrZ67wsnMXreG41ZZz00blRitB3TnZGuwT/Em+6ZProEuFICShOL/7m2TJrgDSeT6SUTNJIDVV+n64T+lyiureimdCz3AXittQh8t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(366004)(396003)(376002)(346002)(39860400002)(316002)(8676002)(86362001)(66476007)(83380400001)(52116002)(6506007)(6512007)(66556008)(66946007)(16526019)(2616005)(6666004)(26005)(956004)(5660300002)(478600001)(186003)(36756003)(4326008)(1076003)(8936002)(4744005)(6486002)(2906002)(6916009);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ukdVuCA1MwC8VD4WsntuTGiVs+M9od9zfmWBrzmsGe4QIFVGBXCpkppWUVCZFypyCY2wSZFME8o5NKvvNrH3qjL4xZjf1VFPdnXFoIZ83sj2HbdQFS5rPSS2t4uJBat83oryT1aAjZscK4bBmMsX+hQG/IAFvVxbhqanUuW4GhKxJ0x36m+UfsgugSKGzE54EclG7EjqeIT0VJU/jqPAUxigrdgEp7Wzibdc8VQTyGu62mmaXFqMODLtQUKQy4W5ZhyE+iJf+YgYCiDIDLj4ii72iwFLxOumQJsWxkmjX4zY/5laXJ0E2sX9ARLhoF/5UCMSMwoP34RyZn1pf0TWP+TgdcvYUHLugcQu4RPxjctopRoetVrHE9gay8vw8eSkv5a028OUrJoSmNgRf+uKR+HihDDVNzIpWq69KSdOoGVDSRinophl23aNcRAd87p6u/uIKz0HnyoBGScifgDPz34TrJBGQFJEsTxMSWK/qmSGymE2X4k7ycB6xSIOiCYL2INdhTca63MOTmvlU+FF1k+5OCyKBUSDEGTlcRdUkuqvDH4MY9gv7RzZWP/q+ZboFVU2Uqi/RwenD50E+yJGAz9AAfrLkue58SPS6wopulnAXqN4/ICwpYIEqauySx0gar9dNjNgrT07bvReM7yiAQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e826bd-e555-41d0-ef94-08d861bfbdb9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0201MB3547.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2020 01:59:02.7539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhTTgrEso/LiBX4orAdwSkArbqdzes8RxMcswxRPFb32MWoGm+ivKAY4s9B9PwKBa3ci3qoemKbj84H9Y5rkRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3545
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 21:59:11
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>>  linux-user/syscall.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 05f0391..91f9114 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -10256,7 +10256,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>>              int deathsig;
>>              ret = get_errno(prctl(arg1, &deathsig, arg3, arg4, arg5));
>>              if (!is_error(ret) && arg2
>> -                && put_user_ual(deathsig, arg2)) {
>> +                && put_user_s32(deathsig, arg2)) {
>>                  return -TARGET_EFAULT;
>>              }
>>              return ret;

Hi Laurent, is it possible to get this patch into master?

