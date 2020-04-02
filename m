Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922BBC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 05:32:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485D120784
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 05:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nDDcFxQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485D120784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJsSz-0003C8-BD
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 01:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJsS5-0002mm-E0
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 01:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJsS3-0004Ie-KD
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 01:31:40 -0400
Received: from mail-db8eur05on2138.outbound.protection.outlook.com
 ([40.107.20.138]:22241 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJsS3-0004Hp-0k
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 01:31:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6hPWBQzy7w/FgNPUbERJSEvNhUdvbiccVWCIg9zZsWEGdeBO8eoKWSF2A0KmKM6DFf4wMbaqoAUtIk3TWUgSCQZtQFiG/oClTErIrryGkiy5rQeCnRzX1h26IkXx0JxHUbjlSUmWzlcMQqTBO4sF3wA9Xzb1Lpg2eS84P+zsiOdflBSNqmHFPbF/rOAT0HM9PElvFghz/ci/Qk3DeGfNJZv2WXcg4L8sSl6hd+CBDjJTwRcaahpYQj1W5RVysZE4UbxjGEQZr+d1kT7SQEjc2JQrHSb98Fcm/5FggbHTgFFkmewYKLfowu4FnBZTjGFCd67wVfi7lZ4BXGHgCvQmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPERsdTnWGCvFEAedgVPqGnzi5M+Noqu+3TGZx1Juas=;
 b=DsHc/IuZiZP4Gq1aAG3kXd1yrOQP7SmQdgWRSMdLhOKhru8XqXCttffZ3/0cty793x8968CZYrMBbk1Mt1v9tOSYO8+9f7N6voDTKtIMVbZMTJP511ON3BNlLdAHFqnIkrzEH+KDAf2sKS8mR2neZc5CpqDWa2YcEajvd1ZE5DxE24DzBXvFkcNWJb0k8OklWzE0P2uZoRw+UIHwlJxJc4JL/1Z0Uu4X37MP8uYfr94W3zcvD3SiCT7KWLcZP+fwnCWxtFsaCL2A+OONoS9OQLRXyGxZy6ZWLBcrpbl/wSK+d19mXGHPlupemXbztwHJ2LfqpbUyXa/4ueS2R0p9/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPERsdTnWGCvFEAedgVPqGnzi5M+Noqu+3TGZx1Juas=;
 b=nDDcFxQygE9I2H26yUVwQB8j6kZg84x5/pPYUMbN8wevdQWLNAkU6IjG/9mbfFldXsBaZ9ePo7lPtCP4fJpUoSCTtAukmZhCGW8r/AzJIYE+8Sg5j5QFjsdaTX9fp31mB9jBk97qIH+iujT86jLoHnEHt06SsM1Mj8BWDFxz9Bw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5495.eurprd08.prod.outlook.com (10.141.172.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Thu, 2 Apr 2020 05:31:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.016; Thu, 2 Apr 2020
 05:31:36 +0000
Subject: Re: Questionable aspects of QEMU Error's design
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <CAFEAcA_b1gZ-B4NaEdQS2zffdvobW=FUx4ysEgXVAz+=cZ+R3Q@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200402083134343
Message-ID: <a3ca8c60-dd83-ea7b-c268-0c94e441bb52@virtuozzo.com>
Date: Thu, 2 Apr 2020 08:31:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <CAFEAcA_b1gZ-B4NaEdQS2zffdvobW=FUx4ysEgXVAz+=cZ+R3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.23) by
 FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16 via Frontend Transport; Thu, 2 Apr 2020 05:31:35 +0000
X-Tagtoolbar-Keys: D20200402083134343
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1fc8563-d3ef-4a04-d5cc-08d7d6c71c65
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5495B4267F1F2D5F04D977BEC1C60@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39850400004)(346002)(376002)(366004)(396003)(136003)(81156014)(186003)(31686004)(5660300002)(31696002)(81166006)(8676002)(16576012)(110136005)(26005)(16526019)(478600001)(2906002)(86362001)(66556008)(66476007)(36756003)(316002)(956004)(2616005)(6486002)(52116002)(4326008)(8936002)(54906003)(66946007);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iKXk/ZGDWOZOgIqEtmit6ugh44fL94RQM3j70rTAOhFdWXXWvMC/iwFkruAKo7OmcELPy5tsWGDP3dNnUk8gYBKaPVFF6DFShbdM3DhS5iScyB+KCC4Zx44+PNvM/lsKwPqlWxvDgTLB8MRZ6Q1H2FHEs8DwB/0naG1IpcS6LgtlcR2XCdoOjUifZa8cXKpbabiwkRmWTHOmLSVuvGHHlCShGT4VqqrGoAEsa6ZSW/3iq1TiiPHP3uasty6lU2flc6dUIR4h3qgk/QaU9LBifRtqANyupIaX9cIwUo0qvrWNj0LBznPD+x/RS3O1/cJTHBsOuk7oi04tSTqKEnqEjB64/yeLxTyi5DkzDCut0nquvl/q+lQxo/VvC/VgFYxsQeW/hs2uq5ATeY42PKBmYzMCVp6odzJ/7y//LeWjdanWT4KHyTD9ku06aurTorD7
X-MS-Exchange-AntiSpam-MessageData: CGoWcTNfNHRhOS3KW4bIjeacD3vC1SHGGUfACmfggW2pzFLm/JMOtDGT2Jnt6MV5C8H221iWfawy6eAi+VAryQADZBRzV+EqsoqAjrjG6MGdjzGINbWzqVAiOUbtRydnIwk4PBtv+hFpqRq54NJfeQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fc8563-d3ef-4a04-d5cc-08d7d6c71c65
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 05:31:36.1666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61XoKgNpaEQQ2yuPrs3JPXOJDXAr2G8N0ubpUzpBObKhHyJCYhGE8jRsL8n5569iExi+hgI3yow/Q3J9nlm8q7yCtsg8zsk8usfnZ3v4LG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.138
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

01.04.2020 23:15, Peter Maydell wrote:
> On Wed, 1 Apr 2020 at 10:03, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> QEMU's Error was patterned after GLib's GError.  Differences include:
> 
>  From my POV the major problem with Error as we have it today
> is that it makes the simple process of writing code like
> device realize functions horrifically boilerplate heavy;
> for instance this is from hw/arm/armsse.c:
> 
>          object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
>                                   "memory", &err);
>          if (err) {
>              error_propagate(errp, err);
>              return;
>          }
>          object_property_set_link(cpuobj, OBJECT(s), "idau", &err);
>          if (err) {
>              error_propagate(errp, err);
>              return;
>          }
>          object_property_set_bool(cpuobj, true, "realized", &err);
>          if (err) {
>              error_propagate(errp, err);
>              return;
>          }
> 
> 16 lines of code just to set 2 properties on an object
> and realize it. It's a lot of boilerplate and as
> a result we frequently get it wrong or take shortcuts
> (eg forgetting the error-handling entirely, calling
> error_propagate just once for a whole sequence of
> calls, taking the lazy approach and using err_abort
> or err_fatal when we ought really to be propagating
> an error, etc). I haven't looked at 'auto propagation'
> yet, hopefully it will help?

Yes, after it the code above will look like this:

... some_func(..., errp)
{
     ERRP_AUTO_PROPAGATE(); # magic macro at function start, and no "Error *err" definition

...
           object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
                                    "memory", errp);
           if (*errp) {
               return;
           }
           object_property_set_link(cpuobj, OBJECT(s), "idau", errp);
           if (*errp) {
               return;
           }
           object_property_set_bool(cpuobj, true, "realized", errp);
           if (*errp) {
               return;
           }
...
}

  - propagation is automatic, errp is used directly and may be safely dereferenced.



-- 
Best regards,
Vladimir

