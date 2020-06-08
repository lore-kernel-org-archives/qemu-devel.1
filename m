Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1057C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E0B206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="pSb9y1qH";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="pSb9y1qH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E0B206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiJlt-00073B-FD
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 11:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Szabolcs.Nagy@arm.com>)
 id 1jiJh6-0005YX-9Z
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:28:12 -0400
Received: from mail-eopbgr130087.outbound.protection.outlook.com
 ([40.107.13.87]:61838 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Szabolcs.Nagy@arm.com>)
 id 1jiJh2-0000lN-Ts
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGIj7b9HPSCGzK5hbGdLsuBgSqDcbUA6U2jJ7HpyNkY=;
 b=pSb9y1qH2f+e66CZ3mc6/KKQttxxPluKR2H+UMRHo9nAwqupyzjKuv3161O6e/a0koxFP1abl6vgOU530QXAz5+F+HGR7pYxwo7dqe6+Td3CxDB0Pz+xGWZF5jtQvguTI+g7BQad7nsqNA/xCx8dghgWUmAw1XLAfzL93ncdVjw=
Received: from MRXP264CA0041.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:14::29)
 by AM6PR08MB4935.eurprd08.prod.outlook.com (2603:10a6:20b:d5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Mon, 8 Jun
 2020 15:13:01 +0000
Received: from VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:14:cafe::98) by MRXP264CA0041.outlook.office365.com
 (2603:10a6:500:14::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 15:13:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; nongnu.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;nongnu.org; dmarc=bestguesspass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT037.mail.protection.outlook.com (10.152.19.70) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 15:13:01 +0000
Received: ("Tessian outbound 39cdd740f5cb:v59");
 Mon, 08 Jun 2020 15:13:01 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 160437ec4049aa2a
X-CR-MTA-TID: 64aa7808
Received: from 592c9997bc0b.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 AD4BA1F4-321B-469D-BD17-16AAE75A9FC0.1; 
 Mon, 08 Jun 2020 15:12:55 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 592c9997bc0b.1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Mon, 08 Jun 2020 15:12:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zkor/vPYLC88A/2XENjq6w/wEWMiVWgZ/RHkWSM/VzQiGFieRptJbr5rtcH8f1mF41q5aysIa2/JbH9XVU8ERQ4fuyL8+It3SHh+xKWtDfJ7sNzIJ61tz08YXiBM/oMQKIwQaiqUtoO+r3MWJGMGExC3rakURGtXAYe5ToC0lMO8RuUGKD79c0RzFNgyzcE/fOvt5RxD52GNkLBJWFEVLVLkrqvCxK8JV4gBkzWI+qSZ5j9n7yxeWj4qqCU1nxllZ4EBVHnYLfFSOnBAY0DyYLDZG5Eq2TBMCJSUMlwahXgZd9q0p5+DGBj3JANRfuvBpuv30fQ9Xazu2FbdOJqKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGIj7b9HPSCGzK5hbGdLsuBgSqDcbUA6U2jJ7HpyNkY=;
 b=BBt6y/Zy88Q5jWrwh470jaevE68kwUczvegbpKzARSzzq35IGzUkyfLBxkOQaktAdgpxNh2rhKEs6m+HfybS1D39YtITXISa+PciCdGsUxH0QbQq+WMSX7fqUBiSX/7bBOG+W3D/+uMs8OcU1vnfN/EtMeKgKizj7zZilCbmNwQZOQ5uebpqwCCxUnKXsbZfI/PkYNkCNTcfpFR8QjJ/EibBzQLHaJ2SVof4fN6Y1PW4da1pdQz4C1GyKfnua7UtZkKmbCdeG2Strhu/62jmefIrMVZPHOzEmmTx/8GApLfeLc8fv7vSfyEP9MD3bljBPunkUgiCyuaemLAVDAEMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGIj7b9HPSCGzK5hbGdLsuBgSqDcbUA6U2jJ7HpyNkY=;
 b=pSb9y1qH2f+e66CZ3mc6/KKQttxxPluKR2H+UMRHo9nAwqupyzjKuv3161O6e/a0koxFP1abl6vgOU530QXAz5+F+HGR7pYxwo7dqe6+Td3CxDB0Pz+xGWZF5jtQvguTI+g7BQad7nsqNA/xCx8dghgWUmAw1XLAfzL93ncdVjw=
Authentication-Results-Original: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM6PR08MB3013.eurprd08.prod.outlook.com (2603:10a6:209:4e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.23; Mon, 8 Jun
 2020 15:12:54 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 15:12:54 +0000
Date: Mon, 8 Jun 2020 16:12:52 +0100
From: Szabolcs Nagy <szabolcs.nagy@arm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: another tst-arm-mte bug: qemu-system segfaults
Message-ID: <20200608151252.GA21083@arm.com>
References: <20200529120427.GB18623@arm.com>
 <9aa721e6-e72f-20bc-73b4-19fc3f493241@linaro.org>
 <20200603135053.GD21536@arm.com>
 <7ca0e091-7797-12cd-0c6f-41e453580e0a@linaro.org>
 <20200603171706.GH21536@arm.com>
 <eb0a8d9e-e8fc-6738-1851-74320585b7ab@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb0a8d9e-e8fc-6738-1851-74320585b7ab@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LO2P123CA0050.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::14) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.53) by
 LO2P123CA0050.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 15:12:54 +0000
X-Originating-IP: [217.140.106.53]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e5707d26-f983-492f-ec45-08d80bbe6f4e
X-MS-TrafficTypeDiagnostic: AM6PR08MB3013:|AM6PR08MB4935:
X-Microsoft-Antispam-PRVS: <AM6PR08MB493513F0929F0CA57015400EED850@AM6PR08MB4935.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;OLM:5236;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: fQU8yoxqMlXlYxXytrYSSflwa+5Rid+sU0JQiNcciPgZ0toSCtDLlFxw4S0odfA3Vq56Mza4mXJvRp4r5kgwbL/W/qxzP2+WFs5f6TUH7Jcop76suEdVp2dcER9pAphOMmPDYKkRQMJvkNV5Fg/EN2nCUb65JOTl87FgIa7Hbh4PfwPTXdEXGKmki6csFIds2zWwFvfMChNuOVswTB4Gjn/oZswpsOqvIucyiDuuLBwJxT29zyqkgg2iAa4RuEwFQlBPBuPnaraK2leYA0eI9Vs0Ez3QfJnQGXjZTMWqOz4GsFi5adsK+vzHFZViR/JWkzlG6UAt2qx4rJDh2Tv3nQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM6PR08MB3047.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFTY:;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(52116002)(7696005)(2906002)(86362001)(26005)(316002)(55016002)(16526019)(186003)(6916009)(33656002)(36756003)(956004)(66556008)(66476007)(5660300002)(66946007)(8936002)(478600001)(1076003)(8676002)(4326008)(2616005)(44832011)(8886007)(4744005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 7IugQenmgi6DXNK3YgJD86Y1OMU273hNvbvP7qDD75m802XhYGgToJ0dffvUkP2a/kcEqwLZ4aLy5QD47bmhBv5zQCbWNwG4px+5MNAZLAi5LEPZalqna9ONE+f64Ezbgxh5Fyiwx/fXb8fU/39iLhUyXtCwF6zfuf7aoElGyjUD3KP5zU5Rbz3Ln8uLaSSWNiuRFRSTaY8D+Ls7u0aaoq3rsQW0Tdoi9ms0097mVQ0s1ihQmHZUICb0zYdU6CBLWehIMKvlB5/Xp/ZHDIDEhrNlyIIwhEYUxGG++z07bd/41ilTgQT9x7F5v1gHCUWsqiXPo9PdrwbdPmQcuPxheZwyMsuikY4ylBsjRqc/jQ8uzcTI3QjpPZ/QmHAfdb5U8M/J8kcdQiRfdCRiMv+F2/tAx0h4rubbD35uNF6FsP2sp9E8Zvzc/4Xfb4FG8hIH8uDTflEvoktXYe6m+poPL1xe11Oh+cDXzQzcYgueHbV3tyNlBKjbBOxN1pehMlmN
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3013
Original-Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE; SFTY:;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(46966005)(8676002)(55016002)(478600001)(36906005)(4744005)(86362001)(8936002)(2906002)(36756003)(336012)(16526019)(7696005)(82310400002)(70206006)(316002)(4326008)(6862004)(70586007)(8886007)(44832011)(33656002)(1076003)(186003)(47076004)(5660300002)(81166007)(356005)(956004)(2616005)(82740400003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Office365-Filtering-Correlation-Id-Prvs: 42df0d04-ef88-4b0a-e363-08d80bbe6b1b
X-Forefront-PRVS: 042857DBB5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y2UOOcjWk9faW/erKFg9Xq3YGvT9O8YRbiOdpPFbIHdiaGaJf9F+Z8IIzudc4DN8qN7HcWPhecKcFIekIsycEUvxBNQgWOQQBRG45iryUUbvN2V2nGCSZhzmxrVxMd8+1WC4jPghtIpKLnRLshudOH6tCDe6aEwaOD38qlptFK9eRbrtdP4yc9s1svjrL/KHBGEljHkgZYGFsgDR/8o7i39AxtjDpJ73xS10eLT7kYAgXa8G16MD+5b18lRF+xHjiC0utpEQ7nUYOxLkjSlbOvf+ZEgG3hOeVMoso65alayyDks+l3ByPM6g1x7JMRI9E2Mn8H77NhKbZme+/8ssJMQsLSiLVew6FXh3HiGtWsNBP4tSA+BlIH8GMdN7SysE+XXvGFw2JjqyXBBOwqw8Mg==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 15:13:01.1040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5707d26-f983-492f-ec45-08d80bbe6f4e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4935
Received-SPF: pass client-ip=40.107.13.87; envelope-from=Szabolcs.Nagy@arm.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 11:28:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
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
Cc: nd@arm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 06/05/2020 13:26, Richard Henderson wrote:
> That assert is just wrong -- it's attempting to sanity check a virtual address
> against a property associated with the physical address, and even doing that
> incorrectly.
> 
> I've pushed a fixup to the branch to remove it, and I'll look into adding a
> correct assertion later.

thanks, my tests pass with the change.

