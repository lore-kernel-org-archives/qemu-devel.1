Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90599C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 06:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555CA206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 06:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uLb+EDeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555CA206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWDFY-0001ru-HG
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 02:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWDEc-00019P-UF; Wed, 06 May 2020 02:08:47 -0400
Received: from mail-eopbgr10128.outbound.protection.outlook.com
 ([40.107.1.128]:43591 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWDEb-0007FN-Tl; Wed, 06 May 2020 02:08:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTEQXx+hUVdsHui8n5uf35SY45QZZUsBB62MAzR7ghZyBEdQ5Xkiz45gjk8YoZPh169DBFpJtwMDyaLsHvXB+7BZRz0dM26OuvoaRSvJEPNf8UR+HO5kHHx16xTMccbHrV/cHcclp8Blb5w3l+V2aJFjjgVbcGW9cS57orJ6cXwB9j9NxFzXPHnw7PlP4wohcwzvMtjDVeXceMdLhPjO9BTrjhnRFEm98rbuBOkk34O8YmkP5rbQenT925/9ZoUyW5xTxcZmO6BG4KIaGSZpuB2CIY1veb6hsLCKmHzLLVi2ZHqTHq1ftcx58C3AXy3FTZh+9DrHRD7GQeodEVu97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doxdqRzIPjpq4JSwJgdlmPSQLrcAH6dg/bwdzEK+UKU=;
 b=V15p5KAYXPHP48WCIHsq+r41UJa3OANlNI64zKUXKCz1IAf1nrJzFt1HwTtsM7FVCxRXIHHMbdCzOBmkVAMXyVdb85LIe/ze+CxUpPeTYvibpYKttL2RpgNEQGIMsS/Rs/00f7IgU/WOU3U8dxdHVbF0dxIEOl9ZbH/ysENJtqDTNW6hv3ptOT2GHq9GeJesZfhxf48JC/GkRUVKrCi4DlrI3Y7PFFjIho9iSSBOGpl5ehfKbCTKND7IDK5y7vbCx7maNbzQLDeD/W2YFgSLyicP7l4FgGzSSn2n5Q42uq7UedeoPpSkGlxyWtyczd43NPuNEQSBQno40I8q3/Z2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doxdqRzIPjpq4JSwJgdlmPSQLrcAH6dg/bwdzEK+UKU=;
 b=uLb+EDeLMSKjmX4OM872GJW7XRvpFftjuBsy6wn+92R7kc0Qsk33YWYLxQtqZTw082aq5IZF7bhP+NSIfvgaC353PUvAnqCLKJJH4w2x8VQxDickiVMaTDxeCWxaivcWMYmgSGFCZWBiqyyBAEFEBB0exG557fqKBrlHsdauNB8=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Wed, 6 May
 2020 06:08:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 06:08:42 +0000
Subject: Re: [PATCH v2 2/6] block/nbd-client: drop max_block restriction from
 discard
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200401150112.9557-1-vsementsov@virtuozzo.com>
 <20200401150112.9557-3-vsementsov@virtuozzo.com>
 <e3253b06-4bff-970d-9b9b-32da6bf652b8@redhat.com>
 <ffae80d5-0302-f719-8934-21bb4a7eacca@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200506090841468
Message-ID: <c6e51077-b669-af82-6883-06471c13c62c@virtuozzo.com>
Date: Wed, 6 May 2020 09:08:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <ffae80d5-0302-f719-8934-21bb4a7eacca@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0027.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::37) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM0P190CA0027.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Wed, 6 May 2020 06:08:42 +0000
X-Tagtoolbar-Keys: D20200506090841468
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f4e2245-b6c7-4f18-ede3-08d7f183edc1
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5495B38D3A26E2CCD3C09378C1A40@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:254;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZfxTK50csTV62exmSMskJ4MJZufk+Ycex2qkSAaYShiHBzVhhTj2tekxQuGjE2wnfMAWOVB3+0DHamSvXZsxKkfT0lSkO7uWdg5Kg3LOU442+3RFdrjfnOZ7mOwAnb7d1BkQJ48rSQ9VKaG1cXmgRGSyMZN5DHJ8PrrHW3P9kak9AeSuaCCWjg6lko/D5FTwjBFzxtJhUOZLJ6BImgxBLVRwIftQRzn5iMBMiDOTx73XOnYYK55rRkIbbOVHO8Dj3XAJtE2yHIJsZTnoKewZv7gIm84W/A0vKCNwvTXswBHddSSn1+YY+Yn/vuaMrUSSKxymRs3uaG/4vLcCB26T4ylReYmUaWe5FktPoXQNf6Lgs0ZDkQiU7YuUPHEZiO/uuZj3wCNCYQ4guQjIoTD8aL4o0SpDzEUJvN2S4gQACSTE2lpBiSYeQJaO1RF9fEsVgie721TsEdEjmM5JtBAiy5AFxFZAjLP90rjphc5FHRyDolds048FmOINj/DwDOgwG92jZaoSXwNuBiiFWhPYV+Dvb3jyvBwOV0snimVH6fWDwAIXCR39AsQnjQSiNfMA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39830400003)(396003)(346002)(376002)(33430700001)(36756003)(8676002)(86362001)(31696002)(6486002)(52116002)(26005)(186003)(53546011)(16576012)(31686004)(316002)(8936002)(33440700001)(2616005)(956004)(16526019)(5660300002)(4744005)(66476007)(66556008)(66946007)(478600001)(4326008)(107886003)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Zgy3TWYSrswAUm4Amz8eqd1r3vrR+gHw3ov31+Du5IEPTZGICDh/MOnBUt3fbbfkzxTxiP+ouWTPHcnbaGoYi6momha2KssfFRnh/RnUJmCcDd1K7pZYuaisAJYPROjlAssRzJ3kV4utWRF2OmXU/HZQ+ShPWP0ZgOPZIKZoGBAb67LZkIsYd3VF5S8x89ud8wn+qDxcewOxtDerhIaMhrZAADk1AD4fh/rAMIockUWAQkDIk1qdpq1oKHdA2dDuA5EEjo9fDHQmkwYvbxFEWAwjgRFoxjbELr2kA275gEwLyasDFbEit6rFfKBJbNy5fE50KNjOMEpFNW7aZ3EqqTfSSczEzEmERu04ZJpqwdRosDuE5l2eN4jcgZMSW1ut9QSkCFoejrQ+1RzcAXwcqbcrGBFLwBgi45BftfPi8nf3IQW+C1E/tQchNLHX8OI8gzHPpynGrncXxTm9ncfU32dutWggzIvbZbtVIojKfZriG1u4wxdcJZAreZqi7gA0Q+8OExnd52KBCDtkPD1d4iwy5mXe2mcZqqIUdT08RRSjSiF4immJlae+8e1EVZCTswsjROFT0fRe0ZSl2QWrCClICdPUP46+ZAU3zjOrLuIjeWRapUuERGWSpgQoXQqjxzj25RhLza7PiGzbGlbDvvZI66LjFornaR2WegPBeW3qPheuLxfGuiHqTJfpz+M9UzHexDc1/Ma2Yo0COawgwfc8/W1i87VMv0OBOGxSUkAhid8xup6PhIQt3C1gmZTXrsBs451PMa4U7kXJPe2zB2o+rT0qkKc9vmCo4EDy1l4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4e2245-b6c7-4f18-ede3-08d7f183edc1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 06:08:42.9119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9fKTpZmugO0pGfwb4YDrNyHcizxBNkA13A6K/Wjl++TDtwOfxpUfBgC5oWRc5V8yWFNaMysWoIO59KzsKK88ctADA4v4MNDer/1mIGCg4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.1.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:08:43
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, T_DKIM_INVALID=0.01,
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

04.05.2020 22:59, Eric Blake wrote:
> On 4/21/20 4:56 PM, Eric Blake wrote:
>> On 4/1/20 10:01 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> NBD spec is updated, so that max_block doesn't relate to
>>> NBD_CMD_TRIM. So, drop the restriction.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>   block/nbd.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>> I might tweak the commit message of 1/6 and here to call out the NBD spec commit id (nbd.git 9f30fedb), but that doesn't change the patch proper.
> 
> I'm queuing 1 and 2 through my NBD tree now; the rest involve more of the block layer and go in tandem with your other work on cleaning up 64-bit operations throughout, and I still need to give that a better review.
> 

Thank you!

-- 
Best regards,
Vladimir

