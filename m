Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503A8C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 13:16:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0101E206D5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 13:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ts4R7Eix";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ts4R7Eix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0101E206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWJuJ-0002fF-Ph
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 09:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Szabolcs.Nagy@arm.com>)
 id 1jWJqf-0001gb-BD
 for qemu-devel@nongnu.org; Wed, 06 May 2020 09:12:29 -0400
Received: from mail-eopbgr10056.outbound.protection.outlook.com
 ([40.107.1.56]:52813 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Szabolcs.Nagy@arm.com>)
 id 1jWJqd-00058i-BZ
 for qemu-devel@nongnu.org; Wed, 06 May 2020 09:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5oD8QDbD3KqoUZzL+9tHUjlMSduxtwIUAHBLuDom5E=;
 b=Ts4R7EixaeoBb2w05nH6modYzsPoZd8S8NKMLQ+03m4s4vbLcgkxODoH17EdcNQG60yDvVxIXDUm7NUcTI5oyKpbRxpn5JjPDxT+dsmdAPNcQnBbk3Nc36xOFn5XFiKs2IcsHEjY1no4HdheMgKN/3w144oqzHINTBzpwyK8pqM=
Received: from AM6P193CA0086.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::27)
 by AM6PR08MB3400.eurprd08.prod.outlook.com (2603:10a6:20b:42::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Wed, 6 May
 2020 12:57:20 +0000
Received: from AM5EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:88:cafe::5f) by AM6P193CA0086.outlook.office365.com
 (2603:10a6:209:88::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Wed, 6 May 2020 12:57:20 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; nongnu.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;nongnu.org; dmarc=bestguesspass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT057.mail.protection.outlook.com (10.152.17.44) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.27 via Frontend Transport; Wed, 6 May 2020 12:57:19 +0000
Received: ("Tessian outbound 567b75aed2b9:v54");
 Wed, 06 May 2020 12:57:19 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 793463745a22a3fb
X-CR-MTA-TID: 64aa7808
Received: from 579b215439e6.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 D5D69944-5D34-4810-A830-21654C73E1DF.1; 
 Wed, 06 May 2020 12:57:14 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 579b215439e6.1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Wed, 06 May 2020 12:57:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVDmedYJr0LQ5nRzLTBGtFYYxxsS4AlZOGNaZG1FVE95rG8drmHRfpY/S5wI6JLwao0XckIQGMdlThgWvvFEw4aYYGvmZJy/+QY5vxx/bzKLCX5novCJTU408y8Gj0AGkwhPoORdrmgKacrl3NydthrhGXVdHdV3xtkrkyrDCtp1/EQpv1tQ2LjNK+9WYk9j/y8U3Eu7NCYcCzjK7utUNSlC5RCgsLb1Q9BvZcqkoyWNbibmERQmNbjXWKElkiKMXHm69c0c/Nl8fIDx/PDjJ5pQ+Q3j+mmJ3fmDTLUQlUAOP4M6zi0Ew4krAyLo5OWYUplXxwC2oPnTOf9jnkdD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5oD8QDbD3KqoUZzL+9tHUjlMSduxtwIUAHBLuDom5E=;
 b=Nt5VjE0Ivsiatd2JKFAj/03Yke3GZNdOdHtiLNCLD6QgcvEBBEvFm7tSKmY52kgtQFYeJp4FyuQR0hAgbspR084BkBtvjWwuOut4ZLqlXLkdHsUGpPsj/RnGliwRJzWYN8MPHFIUCBfCJXa9ASmZ2R4nvV+BRmX6kWCl90xfhs6L2Vu2g4STaQ/O13kcQ1hvME2ts9J3slcNWFC3c3h03Ae+t7CzfNxuiKV65wIq6i+Hw+qCAktjwAaZzo6W1CDGCEYaTFHZNm8DzGBoYT0HAzI0FjkWPZXunajBwQs6txsIKD0idCIcf3L1AR2hrk82uaho3VR9SiExfoB+oYjPbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5oD8QDbD3KqoUZzL+9tHUjlMSduxtwIUAHBLuDom5E=;
 b=Ts4R7EixaeoBb2w05nH6modYzsPoZd8S8NKMLQ+03m4s4vbLcgkxODoH17EdcNQG60yDvVxIXDUm7NUcTI5oyKpbRxpn5JjPDxT+dsmdAPNcQnBbk3Nc36xOFn5XFiKs2IcsHEjY1no4HdheMgKN/3w144oqzHINTBzpwyK8pqM=
Authentication-Results-Original: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (52.135.167.23) by
 AM6PR08MB3765.eurprd08.prod.outlook.com (20.178.91.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19; Wed, 6 May 2020 12:57:13 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862%7]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 12:57:12 +0000
Date: Wed, 6 May 2020 13:57:09 +0100
From: Szabolcs Nagy <szabolcs.nagy@arm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: tst-arm-mte bug: PSTATE.TCO is cleared on exceptions
Message-ID: <20200506125709.GK23080@arm.com>
References: <20200420102902.GE15401@arm.com>
 <a36c670a-5cef-f8c6-ce1d-4fbb28f9488d@linaro.org>
 <ec85fd40-229b-c965-1f58-d4cbe825419c@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec85fd40-229b-c965-1f58-d4cbe825419c@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LO2P265CA0067.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::31) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by
 LO2P265CA0067.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:60::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.30 via Frontend Transport; Wed, 6 May 2020 12:57:11 +0000
X-Originating-IP: [217.140.106.55]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 101371b9-2625-4b3c-5aee-08d7f1bd0318
X-MS-TrafficTypeDiagnostic: AM6PR08MB3765:|AM6PR08MB3400:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3400A892904B3B4B7FB42105EDA40@AM6PR08MB3400.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: I4dageaS/kqYzhmy8QbOCTVcXAgSv3NJ9QBgdWKBCZmE8YwsShSVakx/sDGbXzRRtxdrM/6OrUQGcEdfENC6OM0k5Wa7j9JFtXcV0FCPSBQD9ZaZNaFCBW08o3aD6FvgPRKPAXr/gMmJVDr6Wd9ESwGTX6GK5u5cRjo2XyuH37bDaWPazBX1z700WQIY7VlVMCaWmwdpakQHT7R9JObl9so9s/tivTxBB10fQgsv0/j1vCkDTR2dAxVubRYEKaQy/NXgF22X9rKlOlF3FRmplek8FECXs7K4Vz05KTPnkP0yNRaJJCzSitUYvby43t+Tifv9WagAlfau2eF7HeYWk3LBZbp9r83udi15v/bN4c3PHh9p1XwJC2VjnJaYQvih2+zbr/45+YRUqLbdZQXNCb02Ca8s8fmlOt5CRii/sHurSYqOJReg4AQV4Hz0ajU7Ie32a6Z/hHM+kzd5nkXd/MIPHK6fs9KldRWTerljqlWI50ntbWyDSagxyhAXwkaUXeLMMLEKR4J38WxZXD5IrA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM6PR08MB3047.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFTY:;
 SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(33430700001)(8886007)(8936002)(2906002)(8676002)(44832011)(66556008)(66946007)(66476007)(956004)(33656002)(2616005)(4326008)(478600001)(55016002)(86362001)(186003)(7696005)(16526019)(26005)(36756003)(5660300002)(316002)(6916009)(33440700001)(1076003)(53546011)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1+qc9YghfPm9YRImpxb5QWQzyUNDGu2L2eWPs4Optw8zbXybfvVGk66+dzmB5/KAEjy2SHm+xmcLdpa6b7pBXYGMXVvixRSYbH2c6x9wsvEfJ6RjhLf03dy9YIo0P5x7tc0cKswq04xPo8Ulash3DjMEDrzLq1FwASZDOPfiOAOW47rVQUG7CIOTP8l/qoehI0jKIqphXDoc5pZ4gUZlSlOA4WLWVY4xNTVnCE/DkyQc1sI5PpuNU+uCxawgd/p4WWiuA1p9AaWj1SkqGSrFtWTzQcocI6Cra5U/y3dDB8LqRese8JNa2y8C9/oslnnGliu3xBBcZW6QTXbvMYkHFWVUDPKOM2SuXojEu3uudeTK4xQl15t+wMnWcQhXBXiC+yp9URkn7VqLEvQO35r6crs1qKFedHfpiPB7qcePa4DbynVDSF9NRKwfOH50hy1YIUSS8uIY+2jxQu09pKlkClbSfYbCbWgtVyOSb+Ikuqr3EABn1reZ4RjZEEDG56Tp1oTeX13fOFD0EDbvNrLneapJKwCjbNBU/P/8owxyiO3NWFPywPBe0zUKveJ2/qDUHuh2LihqGNglpIkGjs8qVvtWDup+VfVxIeMXCb0YBwhJEa80GdykFBHvYOV/eNeSQxZ2tfCLiYo1T4zo5LFXWKeBdaEEIW9WbDej4NuOFfTsvRaYkMOghdlIjjVZr3W4DOsq+Xgak0GB5wqONmlCts5WszEhIokjBfcl6dovgLPMIraGa8T3xTIafc8Y9ub7LQ6RYuy/hfNsqONk6tEEt5NV/OdF2eGBwBBhqxL97X0=
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3765
Original-Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT057.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE; SFTY:;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966005)(33430700001)(82310400002)(44832011)(36756003)(186003)(6862004)(4326008)(81166007)(356005)(53546011)(82740400003)(478600001)(47076004)(16526019)(2906002)(70206006)(70586007)(1076003)(8886007)(33656002)(7696005)(86362001)(5660300002)(8676002)(956004)(2616005)(336012)(55016002)(316002)(36906005)(8936002)(33440700001)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Office365-Filtering-Correlation-Id-Prvs: 45ac642f-058b-42d7-a483-08d7f1bcfe5a
X-Forefront-PRVS: 03950F25EC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DNnrNjWuA2g0pebzzDa4rzQaz1kEMtPWxqXghW6N3LxvZMMwK7FHVnz2gZ95oje4pzCI18uKiwQDuWoPtv4mQ7fIzvX0hu5ALdfOOE99aAqM5qMYEaXpTaGSyCcOSHaesSGymr+EACsIGiMD0yUYQaMPjesuf6lLvVKhQCFPGITb2tPv4AV/NTGFRwvNV5c+lsY9M9UCZyJTHykBbrqFhmEng/C27szhXsW5bjEsaH5XLNh6KwtMdIbZA3VXpBsOPYVDqUEt1WDdVUvcWE900bRbA6KZxqgjsGW7XzPLRZ2EtR+GiyIlLndzASE91dVSWaCqUDwHmrRmSg+eEAo5V2aIz+DA6yla0jDEPrQ9H/nQHkGwvh+q7k69yIcVuhyPJxvv1/5HgSBIw4kjJeeGV6N1xi6WATzK+1AMCgCTaD8/yqEivnzz9M13vkDHU0IcpEW3f3sNjevaTCs5EnaQncQEOBGS0dSpXglS2wUlFct7clKPFO5oiakS/UZLzIXsCAjNGNH6kbs5XY93YkoZZGJFdvPV57laXNP9OtSrURnmPagfMpMq++eMJCWjUOr92CQei+9ffDMDQuZG/7v/Aw==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 12:57:19.8635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 101371b9-2625-4b3c-5aee-08d7f1bd0318
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3400
Received-SPF: pass client-ip=40.107.1.56; envelope-from=Szabolcs.Nagy@arm.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 09:12:23
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

The 04/24/2020 12:47, Richard Henderson wrote:
> On 4/21/20 9:39 PM, Richard Henderson wrote:
> > Yep.  I failed to update aarch64_pstate_valid_mask for TCO.
> > Will fix.  Thanks,
> 
> Fixed on the branch.
> 
> I still need to work out how best to plumb the arm,armv8.5-memtag property so
> the devel/mte-v3 kernel branch isn't usable as-is for the moment.  For myself,
> I've just commented that test out for now.

The fix worked well thanks (in linux devel/mte-v3 i
reverted the patch that introduced arm,armv8.5-memtag)

However later on during testing malloc with PROT_MTE
i got a qemu assert failure:

Bail out! ERROR:/S/target/arm/mte_helper.c:97:allocation_tag_mem: assertion failed: (tag_size <= in_page)

i can reproduce it, but i don't know how to debug it
further, i don't know what the application is doing
when this happens, nor what the kernel is doing.

i rebuilt qemu with --enable-debug but now it's very
slow (still booting into linux 3h later).

let me know if there are ways to narrow this down.

