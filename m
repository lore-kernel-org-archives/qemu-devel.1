Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5257DC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 08:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19ADA206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 08:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jwNGnQFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19ADA206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLNUE-00048u-2x
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 04:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLNSl-0003Xr-Va
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 04:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLNSg-0000Aq-M7
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 04:50:35 -0400
Received: from mail-eopbgr50090.outbound.protection.outlook.com
 ([40.107.5.90]:6615 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jLNSV-0008Gx-JG; Mon, 06 Apr 2020 04:50:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlkceLuNDvW807vPR+FfjgRaIJOjcmTgiVe2VL/63oxGYfMS7pEi61Qe0s8alNY6V0qC+H+qstEfURN5S4qpiMTu6uf5RxCymalKcqQUfiUyvBdv8gcVTt1k4uRkjwK012P2/q3jARHNgyWPwmPfZJ9LiPdg/8D/vIvzt+s5wZ+nya6XL4Q6s9tndvVwT5E1WDRnK4U3Ip+uGHPFVr2sF3z151jkBo10AqFLJpzJLla3mE+V8GJTQOK4HiAvsFH9HDTvfIeACK7XfpEM8ViaabJTGmOP1pIMURBQFnBeoct7nZ9bBdVGxKQRCAxp0tyjR91uJQLCBBnmyUjXxVPgQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yd36caQJZWhnRPO3s9n9J+CV7yw5anD2NDZ6oezq9AI=;
 b=LcyJ+2S1oZeLs4vTRwVOSOS7stxjzGz973VEa8GxmL3/nr1ncZwRQ1ezUai40mNdUAoAtDZsn22vHXr0L0M4XG7a55XOHNVpuoKDDL37A0jqo0xB+Us1sxqhAoyIPU2da9ZzVrNHHU9H2tKjAg6n/nwHRcZcd8/GLRJP6O/6RvJ0njaMT1J70MRUoAhv+MyMx2Sxc1wKTn1IFhlViDnECwUsB6C7eIh2GVq6GdWYJNVrlxJbLlLpwhjSSFy5MwstCP+yFv9yyEpbNO0hyhkuXQlrze43IxTQl14dzDxRJiKJCZc1/jNNWI2wIbF93MxX/v0oGrtsPkQ9cEcWC1AK0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yd36caQJZWhnRPO3s9n9J+CV7yw5anD2NDZ6oezq9AI=;
 b=jwNGnQFcH9f2BOtUqpVTvjUS9wmQKbu4XIuJmeD3nkpnRBeax3qinur41S3FF0N9m//JHvRKLN6iFTO1eC0AX+326x2Mu9lglzFoEIiWWdVd5mt8Gd2LbK4ovnJuModDbcFk2whKOTfU5MhTQZNR8uHD4FcAra2qsfZGNZTuF4U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5382.eurprd08.prod.outlook.com (10.141.173.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.20; Mon, 6 Apr 2020 08:50:16 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Mon, 6 Apr 2020
 08:50:16 +0000
Subject: Re: [PATCH for-5.0? v2] qcow2: Explicit mention of padding bytes
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200403181907.878751-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200406115012760
Message-ID: <8fe869d5-baf5-6d04-78d4-bee89cd7ef47@virtuozzo.com>
Date: Mon, 6 Apr 2020 11:50:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200403181907.878751-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.61) by
 FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16 via Frontend Transport; Mon, 6 Apr 2020 08:50:15 +0000
X-Tagtoolbar-Keys: D20200406115012760
X-Originating-IP: [185.215.60.61]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85990488-e3dc-4e8d-0296-08d7da0786df
X-MS-TrafficTypeDiagnostic: AM7PR08MB5382:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5382C1C57E382BFC17D6713CC1C20@AM7PR08MB5382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 0365C0E14B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39840400004)(136003)(366004)(396003)(346002)(376002)(81156014)(8676002)(66476007)(8936002)(31696002)(81166006)(6486002)(36756003)(86362001)(66556008)(6666004)(478600001)(66946007)(31686004)(5660300002)(4326008)(54906003)(52116002)(16576012)(316002)(956004)(16526019)(2616005)(26005)(2906002)(186003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tROtn8QOuJKgSwk84K6HjF0F3fk07jbLd6BzGXKlLdlF3Uha1hbLN6n/UlJhIBFY9L32wk0ozlQe0o1GPSS1IukwKkK3/AZuNymVo7DQJHnnj8/6sPWX31hruGDy7n1CYAoYNng6cMlAICf9M/+oejprc6l4yfuRgXH0OOeZmTM7zYXMshOFL7du0x4lE6TikdVoouVjP6ciP5EciVy65+pUxNM6QkJ16ge6Pj/kJUv3J0pbRCo0S+ax36PjZX4dDn8IkIAKw99AqbANBa4nUMrkS524csfwiuGtPD0Dl2/E2g32U4KaP18ARiNwHJjQMMli1MFsvJ6+XFcMsaP6ysqZhY+lRNGiKv1RSrV4aI3H9jyJYqyCsDJBFhdyjSld4Q7PwrqXyDV9Q1Mvqb2jPfY3YzBWFRA7pzjCpmP110Pt+v/J3CljJG0f6hBRbDeVr4zmwhJljUk0fDRcuiUgN9KkaVZNxCYHd0feRQu0hujAwcNihgfRfKDQvDKNYTpVBQxcMdeQTXWt0Vv8cnDHEw==
X-MS-Exchange-AntiSpam-MessageData: we/pX86OGTBJjSwti8g2HWsph5+p/ESwmxR/1svuNKJ15g+mQkvm+bdF7+0x4FPD/U3y3/LFJ+z+lJ3YdL1OxkqXx+OPz3jUkb77VqIdmJHfm9wA7XUVuIjW0TuICGYK4U1Trv2QQiMyLlyQcrgzIg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85990488-e3dc-4e8d-0296-08d7da0786df
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 08:50:16.2177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByRYsuGSuTqIz8uI1Shfz4LONpLe/4qxqpCiTXxu4e6Q+ELqBRwbrKTXsW4GXB/fDeij9Y6OZUmGr/CbvAbA1Dbn4h/ZYHQFe2TGj4VGZG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5382
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.90
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

03.04.2020 21:19, Eric Blake wrote:
> Although we already covered the need for padding bytes with our
> changes in commit 3ae3fcfa, commit 66fcbca5 just added one byte and
> relied on the rest of the text for implicitly covering 7 padding
> bytes.  For consistency with other parts of the header (such as the
> header extension format listing padding from n - m, or the snapshot
> table entry mentioning variable padding), we might as well call out
> the remaining 7 bytes as padding until such time (as any) as they gain
> another meaning.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> v2: Call out explicit byte range rather than '105 - m' [Max]
> 
> Safe for 5.0 as it is just a doc fix, but only if we actually want it.
> 
>   docs/interop/qcow2.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index 640e0eca4000..80728bc2008d 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -210,3 +210,4 @@ version 2.
>                       Available compression type values:
>                           0: zlib <https://www.zlib.net/>
> 
> +        105 - 111:  Padding, leave as zero.
> 

Looking on this in separate, I'd make a software which will zero this padding unconditionally. However, if it's an existing image which we just open, we should keep the content we read.. On the other hand, of course, if read the whole spec, everything is clear.


-- 
Best regards,
Vladimir

