Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A811C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9E72076E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Z10AmR2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9E72076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joQ9x-000111-Hy
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 07:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1joQ7P-0007zf-L7; Thu, 25 Jun 2020 07:32:35 -0400
Received: from mail-am6eur05on2096.outbound.protection.outlook.com
 ([40.107.22.96]:57825 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1joQ7L-0006x2-99; Thu, 25 Jun 2020 07:32:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqjYLVvNdAT0YJRMm7h5yDJnQPUps20SNAd+OVj1Y7DNtuTR3TbM+svTNoirFRtxRUDNzkqgp1Cc9Bu2bCrp8ZUwFzXCv6sr/UixRr9uCRXG699aViXykteZwqL7NHKnK4ys+FDZLDCVmtFVBzZhXaT6mwTK3MAnBUp30l+rpEvHEnwX3Ea6QpIS6dnZ6HpISqgYALs4YjtzTxhC9ltSxeabd8s4v7pmP38/1RU21cO2263L5Kpwm4Q2PQNnZwVvdg2+YQr9TiMu77W7Wq4kh054KdkMIauDIBWSglOcfXB30hVS2MzJR6//qT0dUgebOh0fch+zVbD8jMpUNw+/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkuHlMphA33fR4Sn2LxATBN5G3BiQHfkiKlO+uFazEo=;
 b=hSNK1qpvhKio0o8BjBPQccSlo1cmIiWKDFIwoLmYot+uUo3WhmywNApAgkzVXBwi2GJ0TgVDTzUubIDpjqrhq/ahHvbECBXfkOqSPVoU1rO5YiNq2qxvqE/M1hBI77ZNVPPOfJRbNULPnQe6EqmPHttBXVcJVsACCpeHUaU7cw9juxB5uha0sFTosQJfv4WwQpy9Fs3GE7Y2N61qm5AzZ7Cn5/ag3RkWTyCGGha8Nr3Bn/ZUDselkd+XpdZrA3zQA73hfKEHOyYSE8qkYq8NG8mz/ngMhhOr9kmjD7kRX6r+9T+zS6Jr1GmkaAQTbE1QaAxsmc8iZr6b3NjXwB7qdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkuHlMphA33fR4Sn2LxATBN5G3BiQHfkiKlO+uFazEo=;
 b=Z10AmR2gz729YYUekWBm++G/t7oV8a2mlVO1v4K0L7IR77XThOGMqnnKsxUCiD/OIFgp/jHtLg3gFHITbiURO3y9f/lZleep9r2KVddVH2GVmrZh5eUusGZ1D8s9I/fu9Fr6cmN7WVrMbBsA2f602E06OAl7kyGFIy3NmdDTeqc=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4898.eurprd08.prod.outlook.com (2603:10a6:20b:cd::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Thu, 25 Jun
 2020 11:32:26 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3109.027; Thu, 25 Jun 2020
 11:32:26 +0000
Subject: Re: [PATCH] scripts/simplebench: compare write request performance
To: qemu-block@nongnu.org
References: <1592977550-692121-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <6977a08a-70e8-12a5-d3da-96518f17dc3e@virtuozzo.com>
Date: Thu, 25 Jun 2020 14:32:20 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <1592977550-692121-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: multipart/alternative;
 boundary="------------A8AD66C5E88CCC3459C0B3D0"
Content-Language: en-GB
X-ClientProxiedBy: FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::20) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21 via Frontend Transport; Thu, 25 Jun 2020 11:32:21 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 679bfad6-10db-4715-097a-08d818fb6dab
X-MS-TrafficTypeDiagnostic: AM6PR08MB4898:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4898732344A12A8B71B2F9E0F4920@AM6PR08MB4898.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:121;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y4a0oOFIdELS7e8iOMpjxcGCjtakLcTgEtIT9wyHmgdlCcmQLa1WJlz/H3ta5oVvw1Nrcbq7B8dMnKMN0f7J47GAGm6ESEALq4piErYyjUUSre5upe0JoTo2iKfVUpu/9M8pBsoS/z48oEsrmejc0SayCEaafAvcJWSrmBq5Rv4UQ0W9DsLl+V5dnmSmYk/HWSrnQbQYlY9TkjKSnyMpW2Rng0ZcVuV1WUMvPWhk6czTAnHR7rcCjmOtXoGjb02U4FGiSoknFZy7SCdFxlahg+jbDstI495O8Y5dXkFsWvecdv68RIIs5NYIglgiy6TB2SsFCt2pXoW9HTVCeHphVOPKtJowJl8CZTElt4jHS0f0VnHR18F83K3UlS7Uwagb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39840400004)(346002)(136003)(396003)(31696002)(53546011)(107886003)(26005)(31686004)(316002)(478600001)(83380400001)(186003)(4326008)(16526019)(36756003)(6486002)(52116002)(33964004)(2906002)(6512007)(86362001)(6506007)(6916009)(66476007)(66556008)(8936002)(5660300002)(8676002)(44832011)(2616005)(956004)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: waVDH/+K7cO1zGSxJMT7K76K/1ITnspSbHuyT3LOLUKasfgqtoafyY6AfXQY2pNbOkbhmQ/lZRVsOWQS9HY/TA/1RFPFclenDnzEGO/O9LxJN7Si/LK15AkEY+bRupEIrB16J3BpDWOzatt9g497P57+7kYg4lyeYMzfvRXFOahIiFPBxBKPIjzkHO4DEDjo5r+pPmkz97+iqC11hWI8YUNMMfwrKiov0UxdXNZecCuRpbM3nKdtpoEXZnDlYqbm59YCuU7XeEzWnXObAns0UKjmGbXT42uXgwzQ6bZqkFMrBUGYT9/cEzw5l8L+u8d/2KTGMEnvwBkm8/rUF9Y00cpU4+JvvPasfUBl9tSuPMCT9e5Jm/dhbAv9vIqcY77zyNB/7A9GaDRf+Oc3Xh9Ccx8LT5rbbYmuQ2TPPTZo0yBL7Kw0SfiXJxDW3sQ+9hNKooO1jwu1GHNklYMG5TojHKiVmKRI5L50Xd4o9CA6AzoZVs024B90K++Dd0oI/bIy
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679bfad6-10db-4715-097a-08d818fb6dab
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 11:32:26.4538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saLH2QQv1QuUoF/i+DhODLMPkkXl4bCIS7Cnrf8CQmPVBtmKgS/Hsrq3n1hYtnuLWWwROnkA9a4lvwnPR0dQ1UaTpJB2QcYu8KOI9gdwJV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4898
Received-SPF: pass client-ip=40.107.22.96;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 07:32:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--------------A8AD66C5E88CCC3459C0B3D0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.06.2020 08:45, Andrey Shinkevich wrote:
> The script 'bench_write_req.py' allows comparing performances of write
> request for two qemu-img binary files.
>
> Suggested-by: Denis V. Lunev <den@openvz.org>
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   scripts/simplebench/bench_write_req.py | 150 +++++++++++++++++++++++++++++++++
>   1 file changed, 150 insertions(+)
>   create mode 100755 scripts/simplebench/bench_write_req.py
>
> diff --git a/scripts/simplebench/bench_write_req.py b/scripts/simplebench/bench_write_req.py
> new file mode 100755
> index 0000000..e127dcc
> --- /dev/null
> +++ b/scripts/simplebench/bench_write_req.py
> @@ -0,0 +1,150 @@
> +#!/usr/bin/env python3
...
> +    # Test-cases are "rows" in benchmark resulting table, 'id' is a caption
> +    # for the row, other fields are handled by bench_func.
> +    test_cases = [
> +        {
> +            'id': '<cluster middle>',
> +            'block_size': 4096,
> +            'block_offset': 524288,
> +            'requests': 100
s/100/10/
> +        },
> +        {
> +            'id': '<cluster overlap>',
> +            'block_size': 524288,
> +            'block_offset': 4096,
> +            'requests': 10
s/10/2/
> +        },
> +    ]

I reduced the number of requests per the test case to make the script 
runtime more reasonable for HDD device and got the following results:

qemu-img1 is the current version of QEMU

qemu-img2 is the current version but without the feature "[PATCH v14 
1/1] qcow2: skip writing zero buffers to empty COW areas" (git commit 
ID: c8bb23cbdbe32f5)

SSD:

$ time ./scripts/simplebench/bench_write_req.py ./qemu-img1 ./qemu-img2 
image.qcow2
Testing 1/4: <qemu-img binary 1> :: <cluster middle>
   #run 1
     {'seconds': 0.377}
   #run 2
     {'seconds': 0.382}
   #run 3
     {'seconds': 0.376}
Testing 2/4: <qemu-img binary 1> :: <cluster overlap>
   #run 1
     {'seconds': 6.836}
   #run 2
     {'seconds': 8.513}
   #run 3
     {'seconds': 6.843}
Testing 3/4: <qemu-img binary 2> :: <cluster middle>
   #run 1
     {'seconds': 11.46}
   #run 2
     {'seconds': 8.734}
   #run 3
     {'seconds': 8.579}
Testing 4/4: <qemu-img binary 2> :: <cluster overlap>
   #run 1
     {'seconds': 11.848}
   #run 2
     {'seconds': 17.8}
   #run 3
     {'seconds': 19.822}
Done
-----------------  -------------------  -------------------
                    <qemu-img binary 1>  <qemu-img binary 2>
<cluster middle>   0.38 +- 0.00         9.59 +- 1.87
<cluster overlap>  7.40 +- 1.12         16.49 +- 4.64
-----------------  -------------------  -------------------

real    1m43.769s
user    0m1.881s
sys 0m4.677s


HDD:

$ sudo time ./scripts/simplebench/bench_write_req.py ./qemu-img1 
./qemu-img2 /vz/tmp/image.qcow2
Testing 1/4: <qemu-img binary 1> :: <cluster middle>
   #run 1
     {'seconds': 54.738}
   #run 2
     {'seconds': 57.049}
   #run 3
     {'seconds': 58.199}
Testing 2/4: <qemu-img binary 1> :: <cluster overlap>
   #run 1
     {'seconds': 12.846}
   #run 2
     {'seconds': 11.015}
   #run 3
     {'seconds': 11.11}
Testing 3/4: <qemu-img binary 2> :: <cluster middle>
   #run 1
     {'seconds': 53.969}
   #run 2
     {'seconds': 58.22}
   #run 3
     {'seconds': 61.413}
Testing 4/4: <qemu-img binary 2> :: <cluster overlap>
   #run 1
     {'seconds': 15.702}
   #run 2
     {'seconds': 12.627}
   #run 3
     {'seconds': 11.879}
Done
-----------------  -------------------  -------------------
                    <qemu-img binary 1>  <qemu-img binary 2>
<cluster middle>   56.66 +- 1.92        57.87 +- 3.90
<cluster overlap>  11.66 +- 1.19        13.40 +- 2.30
-----------------  -------------------  -------------------
3.31user 7.93system 7:03.13elapsed 2%CPU (0avgtext+0avgdata 
78280maxresident)k
50240inputs+22659372outputs (0major+965543minor)pagefaults 0swaps


Andrey


--------------A8AD66C5E88CCC3459C0B3D0
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 24.06.2020 08:45, Andrey Shinkevich
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:1592977550-692121-1-git-send-email-andrey.shinkevich@virtuozzo.com">
      <pre class="moz-quote-pre" wrap="">The script 'bench_write_req.py' allows comparing performances of write
request for two qemu-img binary files.

Suggested-by: Denis V. Lunev <a class="moz-txt-link-rfc2396E" href="mailto:den@openvz.org">&lt;den@openvz.org&gt;</a>
Suggested-by: Vladimir Sementsov-Ogievskiy <a class="moz-txt-link-rfc2396E" href="mailto:vsementsov@virtuozzo.com">&lt;vsementsov@virtuozzo.com&gt;</a>
Signed-off-by: Andrey Shinkevich <a class="moz-txt-link-rfc2396E" href="mailto:andrey.shinkevich@virtuozzo.com">&lt;andrey.shinkevich@virtuozzo.com&gt;</a>
---
 scripts/simplebench/bench_write_req.py | 150 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;
 1 file changed, 150 insertions(&#43;)
 create mode 100755 scripts/simplebench/bench_write_req.py

diff --git a/scripts/simplebench/bench_write_req.py b/scripts/simplebench/bench_write_req.py
new file mode 100755
index 0000000..e127dcc
--- /dev/null
&#43;&#43;&#43; b/scripts/simplebench/bench_write_req.py
@@ -0,0 &#43;1,150 @@
&#43;#!/usr/bin/env python3
</pre>
    </blockquote>
    ...<br>
    <blockquote type="cite" cite="mid:1592977550-692121-1-git-send-email-andrey.shinkevich@virtuozzo.com">
      <pre class="moz-quote-pre" wrap="">&#43;    # Test-cases are &quot;rows&quot; in benchmark resulting table, 'id' is a caption
&#43;    # for the row, other fields are handled by bench_func.
&#43;    test_cases = [
&#43;        {
&#43;            'id': '&lt;cluster middle&gt;',
&#43;            'block_size': 4096,
&#43;            'block_offset': 524288,
&#43;            'requests': 100</pre>
    </blockquote>
    s/100/10/<br>
    <blockquote type="cite" cite="mid:1592977550-692121-1-git-send-email-andrey.shinkevich@virtuozzo.com">
      <pre class="moz-quote-pre" wrap="">
&#43;        },
&#43;        {
&#43;            'id': '&lt;cluster overlap&gt;',
&#43;            'block_size': 524288,
&#43;            'block_offset': 4096,
&#43;            'requests': 10</pre>
    </blockquote>
    s/10/2/<br>
    <blockquote type="cite" cite="mid:1592977550-692121-1-git-send-email-andrey.shinkevich@virtuozzo.com">
      <pre class="moz-quote-pre" wrap="">
&#43;        },
&#43;    ]
</pre>
    </blockquote>
    <p>I reduced the number of requests per the test case to make the
      script runtime more reasonable for HDD device and got the
      following results:</p>
    <p>qemu-img1 is the current version of QEMU</p>
    <p>qemu-img2 is the current version but without the feature &quot;<span style="color: rgb(29, 28, 29); font-family: Slack-Lato,
        appleLogo, sans-serif; font-size: 15px; font-style: normal;
        font-variant-ligatures: common-ligatures; font-variant-caps:
        normal; font-weight: 400; letter-spacing: normal; orphans: 2;
        text-align: left; text-indent: 0px; text-transform: none;
        white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(248, 248,
        248); text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">[PATCH v14
        1/1] qcow2: skip writing zero buffers to empty COW areas&quot; (git
        commit ID: c8bb23cbdbe32f5)<br>
      </span></p>
    <p>SSD:</p>
    <p>$ time ./scripts/simplebench/bench_write_req.py ./qemu-img1
      ./qemu-img2 image.qcow2<br>
      Testing 1/4: &lt;qemu-img binary 1&gt; :: &lt;cluster middle&gt;<br>
      &nbsp; #run 1<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 0.377}<br>
      &nbsp; #run 2<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 0.382}<br>
      &nbsp; #run 3<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 0.376}<br>
      Testing 2/4: &lt;qemu-img binary 1&gt; :: &lt;cluster overlap&gt;<br>
      &nbsp; #run 1<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 6.836}<br>
      &nbsp; #run 2<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 8.513}<br>
      &nbsp; #run 3<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 6.843}<br>
      Testing 3/4: &lt;qemu-img binary 2&gt; :: &lt;cluster middle&gt;<br>
      &nbsp; #run 1<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 11.46}<br>
      &nbsp; #run 2<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 8.734}<br>
      &nbsp; #run 3<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 8.579}<br>
      Testing 4/4: &lt;qemu-img binary 2&gt; :: &lt;cluster overlap&gt;<br>
      &nbsp; #run 1<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 11.848}<br>
      &nbsp; #run 2<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 17.8}<br>
      &nbsp; #run 3<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 19.822}<br>
      Done<br>
      -----------------&nbsp; -------------------&nbsp; -------------------<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;qemu-img binary 1&gt;&nbsp; &lt;qemu-img binary
      2&gt;<br>
      &lt;cluster middle&gt;&nbsp;&nbsp; 0.38 &#43;- 0.00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9.59 &#43;- 1.87<br>
      &lt;cluster overlap&gt;&nbsp; 7.40 &#43;- 1.12&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16.49 &#43;- 4.64<br>
      -----------------&nbsp; -------------------&nbsp; -------------------<br>
      <br>
      real&nbsp;&nbsp;&nbsp; 1m43.769s<br>
      user&nbsp;&nbsp;&nbsp; 0m1.881s<br>
      sys 0m4.677s</p>
    <p><br>
    </p>
    <p>HDD:</p>
    <p>$ sudo time ./scripts/simplebench/bench_write_req.py ./qemu-img1
      ./qemu-img2 /vz/tmp/image.qcow2<br>
      Testing 1/4: &lt;qemu-img binary 1&gt; :: &lt;cluster middle&gt;<br>
      &nbsp; #run 1<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 54.738}<br>
      &nbsp; #run 2<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 57.049}<br>
      &nbsp; #run 3<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 58.199}<br>
      Testing 2/4: &lt;qemu-img binary 1&gt; :: &lt;cluster overlap&gt;<br>
      &nbsp; #run 1<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 12.846}<br>
      &nbsp; #run 2<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 11.015}<br>
      &nbsp; #run 3<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 11.11}<br>
      Testing 3/4: &lt;qemu-img binary 2&gt; :: &lt;cluster middle&gt;<br>
      &nbsp; #run 1<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 53.969}<br>
      &nbsp; #run 2<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 58.22}<br>
      &nbsp; #run 3<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 61.413}<br>
      Testing 4/4: &lt;qemu-img binary 2&gt; :: &lt;cluster overlap&gt;<br>
      &nbsp; #run 1<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 15.702}<br>
      &nbsp; #run 2<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 12.627}<br>
      &nbsp; #run 3<br>
      &nbsp;&nbsp;&nbsp; {'seconds': 11.879}<br>
      Done<br>
      -----------------&nbsp; -------------------&nbsp; -------------------<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;qemu-img binary 1&gt;&nbsp; &lt;qemu-img binary
      2&gt;<br>
      &lt;cluster middle&gt;&nbsp;&nbsp; 56.66 &#43;- 1.92&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 57.87 &#43;- 3.90<br>
      &lt;cluster overlap&gt;&nbsp; 11.66 &#43;- 1.19&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13.40 &#43;- 2.30<br>
      -----------------&nbsp; -------------------&nbsp; -------------------<br>
      3.31user 7.93system 7:03.13elapsed 2%CPU (0avgtext&#43;0avgdata
      78280maxresident)k<br>
      50240inputs&#43;22659372outputs (0major&#43;965543minor)pagefaults 0swaps</p>
    <p><br>
    </p>
    <p>Andrey<br>
    </p>
  </body>
</html>

--------------A8AD66C5E88CCC3459C0B3D0--

