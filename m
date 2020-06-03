Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC94C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D323920679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dLotD5vC";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dLotD5vC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D323920679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgU5f-0004hn-RK
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Szabolcs.Nagy@arm.com>)
 id 1jgU20-0002LD-P9
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:06:12 -0400
Received: from mail-eopbgr40085.outbound.protection.outlook.com
 ([40.107.4.85]:46502 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Szabolcs.Nagy@arm.com>)
 id 1jgU1x-0006xJ-50
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZ1Zec1BkUOG86b48vt3ZqYP5a03fN40vCfy360O+Lc=;
 b=dLotD5vC9lfLlnu9+2JnyI8c0slsM3ILP8u9pOPEdeZHZMOs9RxVYwcgdL7XzO0ZVXn0c/MnVOV7BzM9bRYkKTiqR12mvJUsSPLe8WyrDRvLEdPFxjlmxjcplH1Oo0x0RTbIsrkKBFNIi05+7QzSREeqbbeg2i+cpDEn9+6MBko=
Received: from DB8PR06CA0046.eurprd06.prod.outlook.com (2603:10a6:10:120::20)
 by DB6PR0802MB2373.eurprd08.prod.outlook.com (2603:10a6:4:88::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 13:51:04 +0000
Received: from DB5EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:120:cafe::16) by DB8PR06CA0046.outlook.office365.com
 (2603:10a6:10:120::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Wed, 3 Jun 2020 13:51:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; nongnu.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;nongnu.org; dmarc=bestguesspass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT046.mail.protection.outlook.com (10.152.21.230) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Wed, 3 Jun 2020 13:51:04 +0000
Received: ("Tessian outbound 444e8e881ac1:v57");
 Wed, 03 Jun 2020 13:51:04 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7ef9f1e573b4f2c1
X-CR-MTA-TID: 64aa7808
Received: from b035e463ec41.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 2AA7B2B4-0A2D-4943-B408-2F414F3D6EC0.1; 
 Wed, 03 Jun 2020 13:50:58 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b035e463ec41.1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Wed, 03 Jun 2020 13:50:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arNNX5owJD4sIRLVUuYTGtNqEv4yqaBcyeUSEECOTJsfLsDQG3M6utenOmby6S+k/n8T/5VtVXxlfMMizlXqmiD0JhAO4KwoBnPIiYojv/u47/+vbuPMSxLS08PZ2HKyX3QQq3vf5Z+MromP2C+Sl0Ireq32yCv3XIwf/XQcTTZuiN4F6MwzJLYwCOyAyRYiuVF+vANyt3XYp3Cd0h1NBB2Ea+R54zZuBSdhXKmfBxpq2b/tM6W7gCnymmgagOsO86Xs0HMlPypuV6jpUmJF0QYa+z7ZDKs5CLcLCxqjSXz2S2Zxj2UOyqYPgtrv2bnvNwuQN6siABCO8SVvlkWnYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZ1Zec1BkUOG86b48vt3ZqYP5a03fN40vCfy360O+Lc=;
 b=XG2D9R52IMDdxb+EKJHcYcbcOy7Tp43LQsYh66+n4AxLFX4BtJ6dVnWkourTrWJVDSV6rEOMgI+7eFfx4+1kvudf44MDlINGVQYrZkj+8EiWJGqAm4p1RaElPqvHPk5vjW45iJyegjagPbaSFWYgNTh4HJx6dtYdh6GP/lgWcfKfy654wBbKO0wXNBNmkjXN4woOMi1okBqS6GDkH2BRpKZ7ntM6qntm9FtIawJaXSuR/P5VuQzWi1YJEelxV8wXiUKbSk28m9vKtM/BCZZ/IsTEAxrL+7g877LwlQioBzaIoFU44fwtlAn05jeh9gOB4Oqx/42qCUaTD9RfDCEYUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZ1Zec1BkUOG86b48vt3ZqYP5a03fN40vCfy360O+Lc=;
 b=dLotD5vC9lfLlnu9+2JnyI8c0slsM3ILP8u9pOPEdeZHZMOs9RxVYwcgdL7XzO0ZVXn0c/MnVOV7BzM9bRYkKTiqR12mvJUsSPLe8WyrDRvLEdPFxjlmxjcplH1Oo0x0RTbIsrkKBFNIi05+7QzSREeqbbeg2i+cpDEn9+6MBko=
Authentication-Results-Original: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM6PR08MB3864.eurprd08.prod.outlook.com (2603:10a6:20b:8e::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 13:50:56 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862%7]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 13:50:56 +0000
Date: Wed, 3 Jun 2020 14:50:54 +0100
From: Szabolcs Nagy <szabolcs.nagy@arm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: another tst-arm-mte bug: qemu-system segfaults
Message-ID: <20200603135053.GD21536@arm.com>
References: <20200529120427.GB18623@arm.com>
 <9aa721e6-e72f-20bc-73b4-19fc3f493241@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9aa721e6-e72f-20bc-73b4-19fc3f493241@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LO2P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::19) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.54) by
 LO2P265CA0007.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:62::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Wed, 3 Jun 2020 13:50:56 +0000
X-Originating-IP: [217.140.106.54]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cfaf5127-bd0f-4462-f588-08d807c52864
X-MS-TrafficTypeDiagnostic: AM6PR08MB3864:|DB6PR0802MB2373:
X-Microsoft-Antispam-PRVS: <DB6PR0802MB23731FF5FB1B6D6BC1FF6CB1ED880@DB6PR0802MB2373.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;OLM:3826;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: tYufogAQ2y4zflGO8b2+EuEU9QOjiBnVsN+5saHScAu6jvj0Dh3PWvxSDH+8K9BS7GGbqoQFImlywN2H+h1Fyq+U/tF2HO8LAqp6uFKZQ1urijQ4V8AASWx8M7jNJDDxiVAXf1n58MHEED9KwjYKTOpF/PG6zVV/K55fkbmu5/3x5g5SwUJ0q1aUKOX07PFux3UMmuASO+F6D++S5yCGi5Ba0VAdh9Eu3JPLIf6vdEka7uP92v7Fz/Q3k4kV91JlbyrI8O5OWrCJGsbyfJ6VMLCU4vSysAbuHdWtYkVTPxRTsoh8JT2CJd9Haj136HSCE270nJD4yKsGGcq0L/6u0Ug74Fk50NB94An56K+zPg+mP/PetoB7Eqysf7YXx/WEscdakn6559s7kiLbowtDhw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM6PR08MB3047.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(26005)(2616005)(6916009)(956004)(4744005)(53546011)(86362001)(316002)(52116002)(8676002)(8936002)(8886007)(7696005)(1076003)(478600001)(5660300002)(4326008)(66946007)(33656002)(44832011)(16526019)(2906002)(66556008)(966005)(186003)(55016002)(83380400001)(36756003)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Z8ykULLt/HDFgnLj/ka9sQGAHQ/59ZFcamy/EFZVcWnW3WG8HQIe5nrEjAFNbINlnE1BQzeJh6UGrugiRUCOXkI4pxnCzW5acHFADMb0omIY+7mURBWOkLXmoglN215Rtdo4JyUsK8MWLKdRzQpeSfBZGX/MR3wo6LGAkCAuyZuJBFdopd3p+Cu5MYMRF7gD59jStjOhKjqahRI9p9d7e6o4+EgKp5YgCkA04i206Aa0yYayApsAgDIZkHYdWSSsQBUs7vT4Xton5e2ijFR3LSE6amSxLxNyV//ew/OJMZK8oVcR5OQ1tsEcVEQ1k8gtKnsv9X0613VK+Szsuln/DTxKatGSHl1yV1AvWSUILgLJMlFR0S9LZIWh4LbHKtcyD1WKHOTftkIVoZ7Kb/yA1GkX/xdIFSbPIyT1QCuJ0kAFWMwxDMLLP2KNFrrzEOY1ejMcBOxy5VDUU4AMGf3IWBYbMRyG4UAA4cwedcpySsi8vXD+MpsXYyZH373Nom4G
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3864
Original-Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE; SFTY:;
 SFS:(4636009)(136003)(39840400004)(396003)(376002)(346002)(46966005)(4326008)(8936002)(8886007)(966005)(8676002)(36756003)(70206006)(6862004)(2906002)(86362001)(956004)(2616005)(55016002)(70586007)(44832011)(83380400001)(316002)(16526019)(336012)(186003)(33656002)(26005)(356005)(53546011)(7696005)(4744005)(478600001)(1076003)(5660300002)(82310400002)(47076004)(81166007);
 DIR:OUT; SFP:1101; 
X-MS-Office365-Filtering-Correlation-Id-Prvs: ab8d6a37-a399-4102-fd5f-08d807c523ad
X-Forefront-PRVS: 04238CD941
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c0c1BS4jI1gmQ9t0Go0BiAshlBZc9Akwc6NapO2aLpCXc9xqUYNy5bmNzBMItYb2Eh2AxzxxbL95Jvsuo5Ijeq8BsIk8pRhWfAs9w/vk/nsOJlhq3sip8vOW2mi36/9pjQk0pmOqvZ/ez8htCPEharu9/4RtXmwVXmgYldCWmRtVO9enN19OAElKG9z9H9TeFtagDF6x81BhoAEWCTzm096dptjUf9AXpTQH+q6R2p+vNY8T1pVtWMvdGej7dcuWhh+3aOdd1YFrzJrMcKCPCovSKTTZqPSMcchVVWgsDi+fB8XNPrZ5XI7bV9dPIsdaGmIMOpHMrMt2VsSZFr5htIU3Cl/DmYHgpFGZt+FgJGbx+fwPOKAWyQugMEb2cu3R9PDLgWvl+hmRWO09P29ZpgdNR7ZVo3FQP/eD7UlfKw4gsJ/Oyci+AyZeDjmJp+JrAYS7+fgVp82VZzrLWGaM2uhePHrUk6/g9W8vi4f5K3A=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 13:51:04.0517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfaf5127-bd0f-4462-f588-08d807c52864
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2373
Received-SPF: pass client-ip=40.107.4.85; envelope-from=Szabolcs.Nagy@arm.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 10:06:06
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

The 06/02/2020 14:58, Richard Henderson wrote:
> On 5/29/20 5:04 AM, Szabolcs Nagy wrote:
> > again i'm using the branch at
> > 
> > https://github.com/rth7680/qemu/tree/tgt-arm-mte
> > 
> > to test armv8.5-a mte, now qemu-system-aarch64 segfaults
> > and it's easy to reproduce: minimal source and static
> > linked binary is attached (should be executed on linux
> > with mte support, i used mte-v4 kernel with reverted
> > memory property check).
> 
> Now fixed on that branch.

thanks my tests now get further but later i run into
the previous assert failure:

target/arm/mte_helper.c:97:allocation_tag_mem: assertion failed: (tag_size <= in_page)

i might be able to reduce it to a small reproducer
this time. i assume that will help.

