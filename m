Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61091C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:51:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05882206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FQ8+KLes";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FQ8+KLes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05882206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQWpJ-0003b0-Ry
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 09:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58306 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Szabolcs.Nagy@arm.com>) id 1jQTuf-0006pY-74
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:44:29 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <Szabolcs.Nagy@arm.com>) id 1jQTud-0007ey-Ee
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:44:28 -0400
Received: from mail-vi1eur05on2056.outbound.protection.outlook.com
 ([40.107.21.56]:20033 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Szabolcs.Nagy@arm.com>)
 id 1jQTuc-0007bu-HZ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvcXzd494JKhyRsd2rPpybtfKtx34IDVK2punL9p/vs=;
 b=FQ8+KLesY04Hun2MeFe8zLFLuI9adj/xgMxbqhUp+iH6VVeVak/jU+6LqT0Rr9vVkVzM1rLwiKfPG8GE+QdJMU+NPsT/hHv14ttEW7xhbfW2MTwNWTNWKxqpMdV3H6mlmqymuE0/7F+DQisRKWL6dljAEb0tyteDAX3ZADyQwks=
Received: from DB7PR05CA0070.eurprd05.prod.outlook.com (2603:10a6:10:2e::47)
 by AM6PR08MB3237.eurprd08.prod.outlook.com (2603:10a6:209:4c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 10:29:18 +0000
Received: from DB5EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2e:cafe::28) by DB7PR05CA0070.outlook.office365.com
 (2603:10a6:10:2e::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Mon, 20 Apr 2020 10:29:18 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; nongnu.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;nongnu.org; dmarc=bestguesspass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT033.mail.protection.outlook.com (10.152.20.76) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.18 via Frontend Transport; Mon, 20 Apr 2020 10:29:17 +0000
Received: ("Tessian outbound 76e9a4cf1540:v53");
 Mon, 20 Apr 2020 10:29:17 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4f9fc8c862c322e6
X-CR-MTA-TID: 64aa7808
Received: from 4b4ac23e4fb9.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 939926B4-5EE1-4890-B9DE-60B0028F3E26.1; 
 Mon, 20 Apr 2020 10:29:12 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4b4ac23e4fb9.1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Mon, 20 Apr 2020 10:29:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSQUlr3Nv9kcmbLaBTngcSxhjFlRiS4pahEfevBHscT4lvh6KR+qxgfVF5mxLufwU1LfRQ7s8iP7XdBxUyFi6ZvzH8nGtZd3OpIYHEkxY8QLKumQl3kGOWBzyLoGm3/hHUeIXXQ9piDV8MqOLeMnK8cIJcM/6qocIEYyn7Qcqcyw4ZW8sTkdYU6oQXvmvwYealK2kv6siGbjG4vqFWh3jIvqH8TL/iFqN3pcHyCLhdidh1/ZDvp0IUfDlYBHaW+OuSiXag5NzhPuSrBTmByCO7ad+pYUtDqtLzCGn+3IJR+AwKcsZpUkQEIVcqQjcJsK1t4sCEs1pJOGFJ+Omf+I2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvcXzd494JKhyRsd2rPpybtfKtx34IDVK2punL9p/vs=;
 b=FYooqhutrBv1dQKnKCgW19ETeLUofuYsqAz/qYpgj+ic7ousAbIte+ZrgpFhV2jMi2EffA/RLZT4S1rOCxCDw29cmNbb2ygfWWAK/iXtt/shXyXApqm5maFPqaazol6rR6+H2ceWjsIYJLHK2TM/uLMXzUmmIdVPshuURZUwYwH24mKGh/QzkDS7PTgnqJjeodO8xXwPb6kkk6aXP+Y3rvDosp+i4KGlrg+7rAGpz32ARehaQ8BL4GRxg7wXFlIXFe2AdMdzR/UcDBN/lVURfmvhtENBeOm4MkeSmfTQNCkCe/AqH/f5pUOdv7qUZlWHHye6SPPcs01QPxkxiRsHcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvcXzd494JKhyRsd2rPpybtfKtx34IDVK2punL9p/vs=;
 b=FQ8+KLesY04Hun2MeFe8zLFLuI9adj/xgMxbqhUp+iH6VVeVak/jU+6LqT0Rr9vVkVzM1rLwiKfPG8GE+QdJMU+NPsT/hHv14ttEW7xhbfW2MTwNWTNWKxqpMdV3H6mlmqymuE0/7F+DQisRKWL6dljAEb0tyteDAX3ZADyQwks=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM6PR08MB3912.eurprd08.prod.outlook.com (2603:10a6:20b:86::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.28; Mon, 20 Apr
 2020 10:29:10 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862%7]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 10:29:10 +0000
Date: Mon, 20 Apr 2020 11:29:02 +0100
From: Szabolcs Nagy <szabolcs.nagy@arm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: tst-arm-mte bug: PSTATE.TCO is cleared on exceptions
Message-ID: <20200420102902.GE15401@arm.com>
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: SN4PR0401CA0032.namprd04.prod.outlook.com
 (2603:10b6:803:2a::18) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by
 SN4PR0401CA0032.namprd04.prod.outlook.com (2603:10b6:803:2a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Mon, 20 Apr 2020 10:29:09 +0000
X-Originating-IP: [217.140.106.55]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8bbfba04-fc87-4198-6ad9-08d7e515ae67
X-MS-TrafficTypeDiagnostic: AM6PR08MB3912:|AM6PR08MB3237:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3237C98F51FE0264A9A32272EDD40@AM6PR08MB3237.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;OLM:6108;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM6PR08MB3047.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFTY:;
 SFS:(10009020)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(235185007)(5660300002)(33656002)(6666004)(16526019)(478600001)(44832011)(4326008)(966005)(1076003)(36756003)(8886007)(2906002)(186003)(44144004)(8676002)(7696005)(66556008)(66476007)(66616009)(66946007)(316002)(86362001)(8936002)(81156014)(33964004)(26005)(52116002)(6916009)(2616005)(956004)(55016002)(2700100001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: TcM6pq18e36deVUUxzfm86bztKcY5CuJVmeM5npLffHYfd/xp5tVFUcVvR3t0kmr9RNJiIzKFlPtbK2XqSsJm7kwkkWK6if4XODt3DLVy+PPgSsy3F/nnZdF+qcAOR3Rfh/aCr+4PubEx2EPlTcwzZ1eVQ/sO2HytuC/FcJTmO4WeLUfVpNrMIC+H+L2BIvqMqIxpwKboHhGTbWq2UcHENCBV+mSK7j0yav+9V9Tsf4kNdkLDkqnK3zaM9uPv9lpqalr3atGsnf1dw0at6bszdQ5hEkTEKjsdnzVRLowE/XTlKYYyiLUm8gTTz2Ykt9yCscQiyLVmQ+i8Cko3u3aJK8W/kRJzLpL/z2HAu/gtmLhqt+3gjxyuJWl2KDcb+W/bCFL/vcHdoqCbcI3ugU/ZIUtZxA5LAk2Rr6hUg1otStHPhAFRlHUbSGjhOQCZldjWxHLVO3QLLgArcCaAhPx3+muN21N7th/Fu84mn+NVU7rCpMP3AfAGP/+ffW4R6YsESc1XYnMZDpRNDfz77OiBMoHU5KW6iBulnrnt36zpq6RW9eLjQzcaMSK63oF5rmi
X-MS-Exchange-AntiSpam-MessageData: WxlcoHugV6VyOm6jXTehjE7NdQgA/ihNWv0qIU7iblE9/sC5BED2iSggLyVxN62BzvIN3w1Yekde8rPcvy8j4+BNBIQ0YocEWb4z8MgQjc/qqtlIlT9WZnaNHqIq6ls8uXoEbcBscSlVkYjTYO8Adg==
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3912
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE; SFTY:;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966005)(47076004)(6666004)(8886007)(1076003)(5660300002)(235185007)(55016002)(8936002)(8676002)(33656002)(81156014)(2906002)(4326008)(6862004)(36756003)(86362001)(336012)(956004)(186003)(2616005)(478600001)(16526019)(82740400003)(66616009)(70206006)(70586007)(81166007)(44144004)(356005)(44832011)(316002)(7696005)(33964004)(966005)(26005)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0e12f43d-145f-41ab-9913-08d7e515a9d1
X-Forefront-PRVS: 03793408BA
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0PHL0y2o6j5VViAagRPLl756b57wQypqsfnDlHOuP117JQMmAEc2IYefODnnsSBFfgVPE+he6e4VMvdvh2hOyiHLuA9Mh7EtbU0QS1OCXVXo8hdIKkLI46CgrvpFwjzZz1Kt1BoXJRxUoacApDeFxtTruX8RpYolq+Ea4KsE8gOMJ8T70vlLde815NywGKTf3ELltuQAHSMcsWoyh9ojAVMlBi0/Hsl7JROBdSiX1JYKEG/z0Dg64oHmeIhoN1h7rX5OyqRccUQJMHwmQC+rOWHt4LlIX5gD1/9y9p9teFajouYrT5+Yz8N/Lqp3ASlE+Us+W0W5YhRBlicEDx3fBcsMTlxPqrMCTN07dvLEoTqMnxDpSEcxPhehgmyS45Wve+u8fND4qeHQn6fNFwOp6FaJKTtKt0JMOoptkJdyHyquYMwOYRS8faY0trI7q6Z0Fr4ary3gHo0bJ5P5k40BDC8iKxZuTL6RW/ZXAx7LqgVQYHNkXuyG2DvSJvcti+Gm7QR1xPXMpVcimcEzcMgKXHMtcyhvpmUNsEFxfatxZjTA8iI7ifhUfcnvygtXMkhiQ2VnYq7rGiaMFnLtD0/VYWgmyxv7V4chLvcKE19h/Styq+AOzfjkdP23F5McXZNc
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 10:29:17.9221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbfba04-fc87-4198-6ad9-08d7e515ae67
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3237
Received-SPF: pass client-ip=40.107.21.56; envelope-from=Szabolcs.Nagy@arm.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 06:44:22
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.56
X-Mailman-Approved-At: Mon, 20 Apr 2020 09:36:03 -0400
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

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

i'm using the branch at

https://github.com/rth7680/qemu/tree/tgt-arm-mte

to test armv8.5-a mte and hope this is ok to report bugs here.

i'm doing tests in qemu-system-aarch64 with linux userspace
code and it seems TCO bit gets cleared after syscalls or other
kernel entry, but PSTATE is expected to be restored, so i
suspect it is a qemu bug.

i think the architecture saves/restores PSTATE using SPSR_ELx
on exceptions.

i used the linux branch
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=devel/mte-v2

attached a reproducer that segfaults in qemu but should work.

thanks.

--r5Pyd7+fXNt84Ff3
Content-Type: text/x-csrc; charset=utf-8
Content-Disposition: attachment; filename="bug.c"

// CFLAGS = -march=armv8.5-a+memtag
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/prctl.h>

#define TAG_SHIFT 56

#ifndef PROT_MTE
#define PROT_MTE 0x20
#endif
#ifndef PR_SET_TAGGED_ADDR_CTRL
#define PR_SET_TAGGED_ADDR_CTRL 55
#define PR_GET_TAGGED_ADDR_CTRL 56
#define PR_TAGGED_ADDR_ENABLE 1UL
#endif
#ifndef PR_MTE_TCF_SYNC
#define PR_MTE_TCF_SYNC 2UL
#define PR_MTE_TAG_SHIFT 3
#endif

int main()
{
	if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE|PR_MTE_TCF_SYNC|(0xffff << PR_MTE_TAG_SHIFT), 0, 0, 0))
		abort();

	unsigned long *a = mmap(0, 1<<12, PROT_READ|PROT_WRITE|PROT_MTE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
	if (a == MAP_FAILED)
		abort();

	// tag ptr a
	a = (void*)((unsigned long)a|(1UL<<TAG_SHIFT));

	// tag memory a[0], a[1]
	asm volatile ("stg %1, %0" : "=Q"(*a) : "r"(a));

	// turn tag checks off
	asm volatile ("msr tco, 1");

	a[0]=1; // ok
	a[1]=2; // ok
	a[2]=3; // tag mismatch but tco==1 so ok

	write(1, "foo\n", 4);

	// PSTATE.TCO (bit 25) should be still set after the syscall
	unsigned long x;
	asm volatile ("mrs %0, tco" : "=r"(x));
	printf("tco = 0x%lx\n", x);

	a[3]=4; // tag mismatch, segfaults if tco==0
	return 0;
}

--r5Pyd7+fXNt84Ff3--

