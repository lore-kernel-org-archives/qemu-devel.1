Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B7CC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4232D20674
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hKvNPH7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4232D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8kqN-00063U-Gy
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 09:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8kpZ-0005Wf-CG; Thu, 20 Aug 2020 09:42:13 -0400
Received: from mail-vi1eur05on2108.outbound.protection.outlook.com
 ([40.107.21.108]:42496 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8kpV-0003RC-GX; Thu, 20 Aug 2020 09:42:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdgX/Xl4HRi0TxTd6sIh7o9+DJ4lzZ9vsSRlkidIRi0XWw1i5gjg4aDpkiHVurWc9iValdwM9iOWU94QNbYV6DmPZsjq5chJZdHXOMxzHbHDAtZUdZP/06SocqLitwdBWSs//pLHgjfX2Xype6o37gnf9kQfqxYiqs3bfUEHtJpJQylLzVB/mUhpk0WH/1t6oq6YVmkUAwPuL+4ZmY7I5IV4U8qcW7X9N6zoenynJ4Cvig9QrJUD1r//On2tru2Y0KP1svUHVsudlK3iB8GJBljXCaWbPy6aJ2QJW99tU+eUsHolTWGiAn2nqOwp9h+pmWCpEkt4nyEJogiBfsXeWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1i3R3YZE3BvhnCgkdbZ/G2VBXGsFcJG9izMWtxgmHXo=;
 b=TI/EU0ZQ5LGl9wt/VUG+o2hdZ/b5FpIpya0dA7el/I/mdODxJ0qEG12zKvpLGvrDEAQCMFrNyRdQ/9O4KR+AAu59XjRlQKvdfGcrnrrU21j/68C9QLroJN0tSesv1rrXEmbwUPpTqGC3cKwf6LsfSL0p6JwmSX4678cKXxBW/JLi7trjJ1BmAqmbz3JnlfubAz/Gw2j2LtNBMR8Ht5YT0xqjjdpp+bL263mYuxCHau3ls99LPOIny+Cq1sJ0jhccJNT9bbzPVMI/lFm+x+hdioB8i9UCylc74qEZvsq+j/YnBgv6G20tuuFzIOK8Oorws8ARphWeRjREP60tcfiZ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1i3R3YZE3BvhnCgkdbZ/G2VBXGsFcJG9izMWtxgmHXo=;
 b=hKvNPH7LwhJberJNY/FTNsqdzHxFL5h1PDJ0HIPOfQ8kGAkxWVVC4u+eMG6gAjvliowRZv0k7HS/cVtouZ2gAFnbXTtJdxKYh36BFaUd2IFTQUfGPYyiy25j/xr2k0Se5SMG0sqI3CzcY5Rqi9228kmpx/dAMB4eW+Sy6xYpzQ4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1650.eurprd08.prod.outlook.com (2603:10a6:203:2f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 13:42:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 13:42:05 +0000
Subject: Re: [PATCH v4 3/4] iotests.py: Let wait_migration() return on failure
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200818133240.195840-1-mreitz@redhat.com>
 <20200818133240.195840-4-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ce71556a-2e84-3101-c4b8-9d4c35d56715@virtuozzo.com>
Date: Thu, 20 Aug 2020 16:42:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200818133240.195840-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0136.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::41) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM0PR01CA0136.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Thu, 20 Aug 2020 13:42:05 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bebc1f07-b06c-4649-437d-08d8450ed3d5
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1650:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1650AD06912A77D760E72E64C15A0@AM5PR0801MB1650.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ewer8M3H9noTGb1wzPHLyeLHCGXiPsdlaU9Dcu1S4wK7m2ZoAwU38EoVmc/90QcJt+BGMUATA7rUarvfFwQ8MLaiQqfuULZiXhGUovCoJY1vcuzXDUq7h7FwFzYUPJkP+xQqX6o1StiO5653iDXRex2x+27V+ItkiAp3qfDLPiUfRgSUxXMChwtAG8EHcgX4sOOGAsRI1nYOQor7cfoQYoko6l3Kg3gzhLE6uL6klLnOYBcpyszPY2DHMdHJM7e33v0b1UjwCEI0CQXWoTHGtnRG5H+9wnaxmfsq0ksrpTTp6JaQ7o6F53ZKus6NO8BKGVpeyn1bPl6rfew1ayvrL45JZElkdsFD27firx9w+xVxCePNaeuDlMJ/WeJNYzI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39840400004)(2906002)(52116002)(2616005)(31686004)(478600001)(66556008)(956004)(66946007)(66476007)(86362001)(316002)(36756003)(6486002)(186003)(83380400001)(8676002)(8936002)(31696002)(4326008)(16576012)(54906003)(5660300002)(26005)(16526019)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: QzqoV/mh4arIyhZET049S0KvflPPh6DDWxMf9CNDbBGLFyqfElPoxdAdnLx/oH1lcBjokvT9XBXDTEzq6H4MapCDprot6/qLia6PWBRXQDkxTXslaxdRgYwBXsOzVkJjfTCyqcLjPcmnMcS+HRfO4qMTbr/AiUE7cQofXrbgsf3pBqJ+MUhn4Ux51KPVo229uzZ16zeTjFJX8pGiIDvCgH3qr54Zvnmmc3X+vvl6OKx/VMTr5YUn027Gs7Xx9iNG2tHEZ9DBFUOSv7UErwRb6ThKd2IKGRXp57EuN4GC3w1DbEwI3Df/ovamslGCdqsiePEiWl8bNrMEsF4DqAbEUqxc+7w2ZwE/fNdz6tsAvyO+wmJ71sND5Ao7FhwumGRCBluNJGYEGci7W3xdWRxE/xIH6jzIdG+CpYZH+z78/IHzBePSVckc1GmHT7oPcjk2hb8Qjd3bXNtSPI4UWGz0J02XzcEyuQgYncOYL8lREpAVg6uT0pI2QNyroqLDfkR6rYfc7zKq6KgVOrfxJFggK0ROiC3MoaPejvJV2ZMc7lGtXMvhTlkCCgotu4EpVu7rGZ/jeii73v8zSnrUU18LWQNQNxy/sxtmSc3J6x4hKyc3B6pbNlyo7cKvGoD6u9GVE34yEVJBPLG9oY21C3iIjQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebc1f07-b06c-4649-437d-08d8450ed3d5
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 13:42:05.9569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeapFFo2w5uIJnPw0KzLgG04iGGOCn7VHOhtmcFu9zG6INz7neojULuZdAEZCDsLaQmKoit3pLb9/g4sYPN9pAL+MY+pvjvMLJUEljlq7EA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1650
Received-SPF: pass client-ip=40.107.21.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 09:42:06
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

18.08.2020 16:32, Max Reitz wrote:
> Let wait_migration() return on failure (with the return value indicating
> whether the migration was completed or has failed), so we can use it for
> migrations that are expected to fail, too.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index ee93cf22db..f39fd580a6 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -729,16 +729,22 @@ class VM(qtest.QEMUQtestMachine):
>               }
>           ]))
>   
> -    def wait_migration(self, expect_runstate):
> +    def wait_migration(self, expect_runstate: Optional[str]) -> bool:
>           while True:
>               event = self.event_wait('MIGRATION')
>               log(event, filters=[filter_qmp_event])
> -            if event['data']['status'] == 'completed':
> +            if event['data']['status'] in ('completed', 'failed'):
>                   break
> -        # The event may occur in finish-migrate, so wait for the expected
> -        # post-migration runstate
> -        while self.qmp('query-status')['return']['status'] != expect_runstate:
> -            pass
> +
> +        if event['data']['status'] == 'completed':
> +            # The event may occur in finish-migrate, so wait for the expected
> +            # post-migration runstate
> +            runstate = None
> +            while runstate != expect_runstate:
> +                runstate = self.qmp('query-status')['return']['status']

Would be good to use the helper from the previous patch. With it or not:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> +            return True
> +        else:
> +            return False
>   
>       def node_info(self, node_name):
>           nodes = self.qmp('query-named-block-nodes')
> 


-- 
Best regards,
Vladimir

