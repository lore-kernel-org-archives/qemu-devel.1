Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D077C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 10:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 146F520643
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 10:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="UcjirQHc";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="UcjirQHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146F520643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWdNJ-0006VW-TF
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 06:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Szabolcs.Nagy@arm.com>)
 id 1jWdJH-0004rF-MC
 for qemu-devel@nongnu.org; Thu, 07 May 2020 05:59:19 -0400
Received: from mail-eopbgr70042.outbound.protection.outlook.com
 ([40.107.7.42]:33054 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Szabolcs.Nagy@arm.com>)
 id 1jWdJE-0006lJ-Tr
 for qemu-devel@nongnu.org; Thu, 07 May 2020 05:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TJeSNlaI5tIQdjp6KQHVi6UR65en5IBIbDqNA2mE9Q=;
 b=UcjirQHc2jj5tDMUa+i5FfhUSULMr5dXI8rLhibptvRfwC6Q3hMlg/yJ3S9wHUw8PTo5wC/pc1XMp4n45Gz31SI0eoblzBsFEiMn5ss0MiQlxQYB7AvizlCIxm8pS6CEBqQCAc8TQF+r1+pUXlkk/xOWZDiU8P4uboFawvmKB10=
Received: from AM6P195CA0005.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::18)
 by AM6PR08MB4168.eurprd08.prod.outlook.com (2603:10a6:20b:aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 7 May
 2020 09:59:12 +0000
Received: from AM5EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:81:cafe::7b) by AM6P195CA0005.outlook.office365.com
 (2603:10a6:209:81::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Thu, 7 May 2020 09:59:12 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; nongnu.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;nongnu.org; dmarc=bestguesspass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT025.mail.protection.outlook.com (10.152.16.157) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.27 via Frontend Transport; Thu, 7 May 2020 09:59:11 +0000
Received: ("Tessian outbound b3a67fbfbb1f:v54");
 Thu, 07 May 2020 09:59:11 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 941e544bff700706
X-CR-MTA-TID: 64aa7808
Received: from 08c1ed4fbdbd.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 F02F889A-33C5-4DF5-A287-E17D4CB25AE2.1; 
 Thu, 07 May 2020 09:59:06 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 08c1ed4fbdbd.1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Thu, 07 May 2020 09:59:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goHnWHXmUlHUx1DPG/Is71/kPOYseVu3PlrTV5aSE3EgkStgH/ZgRhKpiV/wsAuwmu/x2nk5+UjTzo81fRUXBpK+FUg1A3U1DZW7pSdFDtWDOwnA3H83K0hRr5Aqd8DMoZpfwwXSTHjnrmaedKSwMKqI4YZhJdiRAqVDk1P3a2++sBPJ1WqSJRmyK0wMc9lrg5CQGZ740LdgMWdQiInsaMsysP0TbHS/imTzn1f5bE022dl9onLZNM7WeqlHcRFXqM0xuRK71dAHls3Byj8uU5GXcuYkwN9PymvxdsNyTTDGy1GrooMR0IN0OhrAXfOug2Il8km+NjZfz72HoXvr7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TJeSNlaI5tIQdjp6KQHVi6UR65en5IBIbDqNA2mE9Q=;
 b=EIVICdUe8v3GNTAPmA2AVRlRyNY829h6I10fEog2ZDb/MiRbevnq7VqowV6bZRe4zkWsZ+KQxvF/685j+sR6+PUNS7MDox8FZ462KEb4Q+Btwa5dhHs0WfEKynOWVZax81kG57D5XaWGTujiiMsJu4iYVtpdyzAHfDpi9yH9FtaNzU5p9qvr38aFR0m479NsCCSCO4roegTRvvEEcNQy87QDyQBqhSBzUGlN2RFpglHyXWjHnliLkVl5xh05RfBDuBOLG7rjCoI6DGLI1a/g5e1knDfWbE73jYyjaEUyGbTWR3ZgHD8umAJw2OLyyNu/8keHcta2B6IoSZ8+3sJedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TJeSNlaI5tIQdjp6KQHVi6UR65en5IBIbDqNA2mE9Q=;
 b=UcjirQHc2jj5tDMUa+i5FfhUSULMr5dXI8rLhibptvRfwC6Q3hMlg/yJ3S9wHUw8PTo5wC/pc1XMp4n45Gz31SI0eoblzBsFEiMn5ss0MiQlxQYB7AvizlCIxm8pS6CEBqQCAc8TQF+r1+pUXlkk/xOWZDiU8P4uboFawvmKB10=
Authentication-Results-Original: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM6PR08MB4054.eurprd08.prod.outlook.com (2603:10a6:20b:a0::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Thu, 7 May
 2020 09:59:05 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862%7]) with mapi id 15.20.2979.030; Thu, 7 May 2020
 09:59:05 +0000
Date: Thu, 7 May 2020 10:59:03 +0100
From: Szabolcs Nagy <szabolcs.nagy@arm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: tst-arm-mte bug: PSTATE.TCO is cleared on exceptions
Message-ID: <20200507095902.GA30635@arm.com>
References: <20200420102902.GE15401@arm.com>
 <a36c670a-5cef-f8c6-ce1d-4fbb28f9488d@linaro.org>
 <ec85fd40-229b-c965-1f58-d4cbe825419c@linaro.org>
 <20200506125709.GK23080@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200506125709.GK23080@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LO2P265CA0369.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::21) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by
 LO2P265CA0369.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a3::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 09:59:04 +0000
X-Originating-IP: [217.140.106.55]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a2c9ab9-cdf8-4f3a-0096-08d7f26d4aeb
X-MS-TrafficTypeDiagnostic: AM6PR08MB4054:|AM6PR08MB4168:
X-Microsoft-Antispam-PRVS: <AM6PR08MB416869FE17D15EF49BA45A2AEDA50@AM6PR08MB4168.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;OLM:8273;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: zSfZV7O6tiMvulQ7joNncHSBAsmdZ5cM/Slj3MNpc9+BHCis05RMsyQRa6EUWuFltd/+MIWh96UY55N99CWyyG26Zkt4o+Yw8k5GzQHjWYb1EeN85TmRGcYSoDOfTsRw26MF8n1tLQVed9N05u0Sq6pW/pu3KrUE+Y4AsXjQTZPpGpCL+bkhmvvNkNaZT8d3idfSHnPhH7+8v12fA2JJJSRQgmvsmi1CfRAiuGe1ujCWV4ckpsrMMNE8LhT2xhAwwyyhw05cIXEcPd78qQOGb/uX2aikE+iPg2WooJawF3IyKnBr+BToDy+dC2ChxE/GwL3+8wmiTs3NIaefq6rsgPVA+VbcQ+orl86Q4HA4J7f4hHTRSL/sJmECvb8jIAS93pPfsbgsBlRHfK407cdZDFNtbwFDPZcyKck8Oe4pjvML4Y8BufDhbsqBtEpbp1BLoTb2fjObAeMRHrViP1/qFtx33sdbg6Qk8EriUZKWGnZZqBAYMRiKs5R4m6GMXGx54qtjxnNrn0RKUdx0tu426A==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM6PR08MB3047.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFTY:;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(33430700001)(66556008)(8936002)(478600001)(66476007)(4326008)(8676002)(36756003)(2906002)(33440700001)(55016002)(5660300002)(33656002)(66946007)(8886007)(1076003)(6916009)(44832011)(16526019)(83320400001)(83280400001)(316002)(83310400001)(52116002)(186003)(956004)(2616005)(26005)(83300400001)(83290400001)(86362001)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: in7wQxEW4rm6MQDOpAuNC1QJQYry1mmjSIzPCEwmHOHgGTVm5sgcwuEREqU2ol4qwccPsFx/H3zlCnNtvPjwjiWkfXUh9pzzg61SO0pOJpxCnf/6TY4sXq+RXssy4knnQ9NMWNgZj3ljyftWzOJ1JJRtacJbdDWsfcSqazvS0CHclrozKYef3n6PzyPbYyer6vF1xnrcMOoyNAd5Dt2sKZVSUyAhKeff7xdCW+PqrFkPOypoWh9SCqTmCV5PoSLTqYt1cVWNjier4JaIaXsu4+qzObCqg0zbk22NyURuny46MX77ebEJGw0IvpDwmyKQUoQdjEdpt3XWp3R9eHVew/UrNjO23/hzDeUeL3Dx89XciE6PivAgxR/8EuGZ1Utgc7dCq9WklquieNMjDBWt/mQtst6AKDWnoQZNuJaSA7kTGht9DGaIuXJlm5sVurJKXs6FxgUBugAIB3jnhpd9qwY+pAJ8xgYLw3n7676f+7x0uX+DTLdmYK0YVyvRdwIYTcbnr80fPj4ynhDJrLFr4qhRzHHMU4gKOU0Tj/0W8c1YVAu53mqFYfBq0pvMpRhu6qVquUto6sm5p+FbADl+FN9xnfHoVnIqW3DcBgVuF7WhFgzRGwjstYlZ580j6FvsKvtML9q5CXKxyjbRWuFTHd0ewQXAlQZyFrCbXUqvBOE8QylDJ5/5WwWNHv6oXqWtGCmqkhdu+NQajGmzKitfMHQjRgUkyrvaFwmzP21SiSEKtlvdDpThgyTQQsWp7F6BAquw5XRnE2jaRh9gGxJ2nNC/RpAVyI1CblgmAv8sSQw=
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4054
Original-Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE; SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966005)(33430700001)(36756003)(478600001)(8676002)(1076003)(5660300002)(4326008)(47076004)(33440700001)(7696005)(356005)(82310400002)(70206006)(86362001)(70586007)(81166007)(186003)(2906002)(26005)(8936002)(16526019)(55016002)(82740400003)(36906005)(8886007)(336012)(6862004)(33656002)(44832011)(316002)(956004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Office365-Filtering-Correlation-Id-Prvs: 43edff45-44d5-4cb4-836c-08d7f26d46aa
X-Forefront-PRVS: 03965EFC76
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5F2TeJyiaydmHuxI+A4cB422ParW4/d1fbBq28phOn7uVVlTAPaqEWLOnYImhtNdPXn8kqiALRlhvrnNAumLhwqXhj7DA8UhCvV0IjnorTs78aUaLjBRAofOrpdTD0+u6hrD6Ioe9AfcPXjRpjeVtdoeMjUUKUYt/HTdG8hLCjFCPc4oX8dGcd0vht5gfLkmzorSbSbFYDPAFKWdjAJ0R2FMJRdH3k/o0CI5dDeLKYfRsiL+MMKuIG2uq4HW5sB0PrSOZtOls5mAhq967W7Fizln/vrbjNw9grM828MaQCLG8+/k1UQj2dnOmjSgkhY8u3MbE2F9XvSADBI+uJ92+8sMaGm7C8JOGu94d7NK0xPdPQwk97zGXHz9WABxu7SczJgRt54CIb+TlcMC2nuyV6bQmRmTJrGBxTAIuhgvu65PBxmyaChmp5dmoLNAhADvOL/Ko+HZXUxAitAnnGJyCDaokMZpg4zAmCn3VpGf/r5/u5MKGDR1onmiwe+jQEI5ivnVTKbSHCDPDDr/lLI6q1YpygBcoHNcrAT8dGV1LFjM6UnZokRPfggnojgCcsZgzFDRKbY9o7b0UHOiKDhgow==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 09:59:11.7856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2c9ab9-cdf8-4f3a-0096-08d7f26d4aeb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4168
Received-SPF: pass client-ip=40.107.7.42; envelope-from=Szabolcs.Nagy@arm.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 05:59:13
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

The 05/06/2020 13:57, Szabolcs Nagy wrote:
> However later on during testing malloc with PROT_MTE
> i got a qemu assert failure:
> 
> Bail out! ERROR:/S/target/arm/mte_helper.c:97:allocation_tag_mem: assertion failed: (tag_size <= in_page)
> 
> i can reproduce it, but i don't know how to debug it
> further, i don't know what the application is doing
> when this happens, nor what the kernel is doing.

actually i know what the application is doing,
it's in an mmap when qemu aborts:

...
23:15:17.379227 munmap(0x100ffff9675a000, 8192) = 0
23:15:17.428456 mmap(NULL, 8192, PROT_READ|PROT_WRITE|0x20, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xffff9675a000
23:15:17.502543 mmap(NULL, 36864, PROT_READ|PROT_WRITE|0x20, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xffff96707000
23:15:17.572469 munmap(0x100ffff96707000, 36864) = 0
23:15:17.645050 munmap(0x100ffff9675a000, 8192) = 0
23:15:17.721526 mmap(NULL, 8192, PROT_READ|PROT_WRITE|0x20, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xffff9675a000
23:15:17.779768 mmap(NULL, 36864, PROT_READ|PROT_WRITE|0x20, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xffff96707000
23:15:17.840278 newfstatat(3, "usr/lib", {st_mode=S_IFDIR|0755, st_size=4096, ...}, AT_SYMLINK_NOFOLLOW) = 0
23:15:18.164292 unlinkat(3, "usr/lib/.apk.1e1bebb420b720c23f29fc2cacd5581b598339805fd12c00", 0) = 0
23:15:18.357742 symlinkat("libXau.so.6.0.0", 3, "usr/lib/.apk.1e1bebb420b720c23f29fc2cacd5581b598339805fd12c00") = 0
23:15:18.469921 fchownat(3, "usr/lib/.apk.1e1bebb420b720c23f29fc2cacd5581b598339805fd12c00", 0, 0, AT_SYMLINK_NOFOLLOW) = 0
23:15:18.638698 unlinkat(3, "usr/lib/.apk.93d31976aebb056b6e2d9577dc8a2f112e28756d03f736a4", 0) = 0
23:15:18.760374 openat(3, "usr/lib/.apk.93d31976aebb056b6e2d9577dc8a2f112e28756d03f736a4", O_RDWR|O_CREAT|O_EXCL|O_TRUNC|O_LARGEFILE|O_CLOEXEC, 0755) = 8
23:15:18.916049 write(8, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0\267\0\1\0\0\0\300\r\0\0\0\0\0\0@\0\0\0\0\0\0\0\3700\0\0\0\0\0\0\0\0\0\0@\08\0\6\0@\0\26\0\25\0\1\0\0\0\5\0"..., 13944) = 13944
23:15:18.961239 close(8)                = 0
23:15:20.137627 fchownat(3, "usr/lib/.apk.93d31976aebb056b6e2d9577dc8a2f112e28756d03f736a4", 0, 0, 0) = 0
23:15:20.289924 utimensat(3, "usr/lib/.apk.93d31976aebb056b6e2d9577dc8a2f112e28756d03f736a4", [{tv_sec=1579395233, tv_nsec=0} /* 2020-01-19T00:53:53+0000 */, {tv_sec=1579395233, tv_nsec=0} /* 2020-01-19T00:53:53+0000 */], 0) = 0
23:15:20.467212 munmap(0x100ffff96707000, 36864) = 0
23:15:20.503631 munmap(0x100ffff9675a000, 8192) = 0
23:15:20.550130 mmap(NULL, 8192, PROT_READ|PROT_WRITE|0x20, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0Connection to localhost closed by remote host.

(this allocator does a lot of small mmap and munmap)

but i cant tell what happens on the kernel side.

is there some recommended way to turn some form
of tracing on in qemu before i execute the
problematic application?

or is it better if i try to extract a reproducer?
(that does not use the network)

> 
> i rebuilt qemu with --enable-debug but now it's very
> slow (still booting into linux 3h later).

this is too slow, things time out.

