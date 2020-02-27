Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293E0C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 08:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7CFC24688
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 08:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="O84UbF5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CFC24688
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ExH-0000ua-1H
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 03:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7Ewa-0000Q2-UC
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:54:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7EwZ-0005bw-MH
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:54:56 -0500
Received: from mail-vi1eur04on070d.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::70d]:23525
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7EwU-0005TK-I7; Thu, 27 Feb 2020 03:54:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2j2Qd6RnEXKR6bhcdo7oE69e6DI/E1HIYuJd76bPyYHVKplqLT49CIQx/iQ169mmlapMkV9xfDDsIb08I/0NwyzPmIUh3mpf+7ubgGxENeytxclsR4Qx5Q7U8RxrHlPRJm/X84ob2T4L07njmjTPXutff/0ajiRsgqhSZPy7gBGg2L9ytPF4+7/SZJMHK+y9OS3TxSyKlPTF0+ke1ga2jA/UAGrsorBSAn002Jcjf5RR2dVWZ6TEMzoPvPL/iw5lXCyKLTaW2klFQPbrQouoGYm+Mfw/1IpNrZY+DF8cHXPvraJLNNLFRB7L6EXNrHBnG9+qdLT09LO2Ipsilljjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqxS4CYW0q6g7sXzYvNgX+c4Ip+wz9R1qeMOr0/faM8=;
 b=XEYUqIzca+u/T4OS2qewSwRL2CpSWC8bEGMH2hOZMXuUx2QLd106P9fAW4zwgbhcQsj5qxWuMQiDf9o8MqH962KuyFRT3lqxEuwp05+4vSl0sWJ9w6qFQEgGGk9zQm32MZZv25dwr4mU3/w66XL8Dt/L4E959JhuVczR+dzxKmgPYl3F3DgkVGfXURWrrponZepV9wi/D8A6Y2yLLpGI+ssPKj32ygEpd4WliOod5Hr/8TU0Yy3RW4NZbFyrFuZwhUuF6f4u+G8V0Q74w6ak9E8dbsLTWInRq+YJKUHCbL0B1rTJJ7LRskLvkWryeXg9nuANZVzIIOa7IJ1RtHYfzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqxS4CYW0q6g7sXzYvNgX+c4Ip+wz9R1qeMOr0/faM8=;
 b=O84UbF5RWSpLZXjR2cMY/6+Ebr1c1kKdGrRHeJ8Hhl0p0/bMDiZM13EbxomWUMA7jPOfIsPnxEoYAX3t5Ll9YeFhUwtBph37zH2sdPSE5F6ATgaeYWnWlnXuRpYV9MpQgmWmUyZeqhbLp7Y2kADcBkGKTqQq7xjG/mh1j8nWMMw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB5309.eurprd08.prod.outlook.com (52.133.245.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 08:54:48 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda%5]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 08:54:48 +0000
Subject: Re: [PATCH v1 2/8] qcow2: rework the cluster compression routine
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-3-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200227115444461
Message-ID: <3283410c-fc70-f73e-c924-47a34c6b980d@virtuozzo.com>
Date: Thu, 27 Feb 2020 11:54:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200227072953.25445-3-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P18901CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::32) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P18901CA0022.EURP189.PROD.OUTLOOK.COM (2603:10a6:3:8b::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 08:54:46 +0000
X-Tagtoolbar-Keys: D20200227115444461
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f790733f-6fd0-489a-16ff-08d7bb62b2a8
X-MS-TrafficTypeDiagnostic: VI1PR08MB5309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB53097CDC63F0E4A63FA0AB03C1EB0@VI1PR08MB5309.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(39840400004)(376002)(366004)(396003)(346002)(189003)(199004)(31686004)(86362001)(16526019)(26005)(316002)(186003)(6486002)(52116002)(31696002)(16576012)(478600001)(36756003)(8936002)(2616005)(81166006)(81156014)(8676002)(956004)(4326008)(66946007)(66556008)(66476007)(5660300002)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB5309;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ICEsyFq/SIg7fnWxZFG1tD6EAtXdwbvjot74kv7HO0eK/CY1O9/SOJjr5680g3yCIn4to/B+wUFjTketPh2TJSDFXziJJU0+LfAs0jj7O5WzaQgm93u1YoGNPF9i0SHqdEmKkD0d1hLZ0CCrCqhpnVN00kyVP/Rs6UmX8208N3SXHcu6Sx7UTR3sk/+a7C0Rck18DEDqgIvC1pF5DlVfa89H1jZtKWvb7fc/aZdq71mtV5wKr13dbTbVOIdPYo+r+yAWm6ScLnRuQpv3wcGKrgrO0j38YR3gHGexYDeHRhv3PtoXuUfWpC2UfRQUkg1i2Uaq3xau3Ex6UZ7gBzhXwrYy2DMqHvEivTDbFi5cdwyIrGq6ndEwo/uu5srpsbM4ZXQPpM/krKtmqVubh8cPfKp4F+GIx21uB6UeYnc9AHl4434kAtcGh+s0HbmdunCp
X-MS-Exchange-AntiSpam-MessageData: V+XHYeEB8kU61zLmUWBrILMkjAhsWWGcCIbDbLEOBFmwaGDptLVswOafS3qXM39sr4WNOeORMszFVDDKlNIpbhQCQTBau6T3P3vD7oACl5OkS9iD+ucfs0s5TjE4U5wizXT5NYEsf9okiprd7OT6gA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f790733f-6fd0-489a-16ff-08d7bb62b2a8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 08:54:47.6563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jD3vSJPkA4d/hbyJD2Bpa4rd7SbGbUxCwJKFy/i6bEwASY0Kzt40PyI+7Bqj0m/nE1EP69JaAkRHbXwDLADXsQ3eVN/4qRL0TO2hK4iSmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5309
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::70d
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, den@vrtuozzo.com,
 armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.02.2020 10:29, Denis Plotnikov wrote:
> The patch enables processing the image compression type defined
> for the image and chooses an appropriate method for image clusters
> (de)compression.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   block/qcow2-threads.c | 77 +++++++++++++++++++++++++++++++++++--------
>   1 file changed, 63 insertions(+), 14 deletions(-)
> 
> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
> index 77bb578cdf..1c128e9840 100644
> --- a/block/qcow2-threads.c
> +++ b/block/qcow2-threads.c
> @@ -74,7 +74,9 @@ typedef struct Qcow2CompressData {
>   } Qcow2CompressData;
>   
>   /*
> - * qcow2_compress()
> + * qcow2_zlib_compress()
> + *
> + * Compress @src_size bytes of data using zlib compression method
>    *
>    * @dest - destination buffer, @dest_size bytes
>    * @src - source buffer, @src_size bytes
> @@ -83,8 +85,8 @@ typedef struct Qcow2CompressData {
>    *          -ENOMEM destination buffer is not enough to store compressed data
>    *          -EIO    on any other error
>    */
> -static ssize_t qcow2_compress(void *dest, size_t dest_size,
> -                              const void *src, size_t src_size)
> +static ssize_t qcow2_zlib_compress(void *dest, size_t dest_size,
> +                                   const void *src, size_t src_size)
>   {
>       ssize_t ret;
>       z_stream strm;
> @@ -119,19 +121,19 @@ static ssize_t qcow2_compress(void *dest, size_t dest_size,
>   }
>   
>   /*
> - * qcow2_decompress()
> + * qcow2_zlib_decompress()
>    *
>    * Decompress some data (not more than @src_size bytes) to produce exactly
> - * @dest_size bytes.
> + * @dest_size bytes using zlib compression method
>    *
>    * @dest - destination buffer, @dest_size bytes
>    * @src - source buffer, @src_size bytes
>    *
>    * Returns: 0 on success
> - *          -1 on fail
> + *          -EIO on failure
>    */
> -static ssize_t qcow2_decompress(void *dest, size_t dest_size,
> -                                const void *src, size_t src_size)
> +static ssize_t qcow2_zlib_decompress(void *dest, size_t dest_size,
> +                                     const void *src, size_t src_size)
>   {
>       int ret = 0;
>       z_stream strm;
> @@ -144,7 +146,7 @@ static ssize_t qcow2_decompress(void *dest, size_t dest_size,
>   
>       ret = inflateInit2(&strm, -12);
>       if (ret != Z_OK) {
> -        return -1;
> +        return -EIO;
>       }
>   
>       ret = inflate(&strm, Z_FINISH);
> @@ -154,7 +156,7 @@ static ssize_t qcow2_decompress(void *dest, size_t dest_size,
>            * @src buffer may be processed partly (because in qcow2 we know size of
>            * compressed data with precision of one sector)
>            */
> -        ret = -1;
> +        ret = -EIO;
>       }
>   
>       inflateEnd(&strm);
> @@ -189,20 +191,67 @@ qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
>       return arg.ret;
>   }
>   
> +/*
> + * qcow2_co_compress()
> + *
> + * Compress @src_size bytes of data using the compression
> + * method defined by the image compression type
> + *
> + * @dest - destination buffer, @dest_size bytes
> + * @src - source buffer, @src_size bytes
> + *
> + * Returns: 0 on success
> + *          a negative error code on failure

Hmm, it's default semantics and it used without any comment for most of C
functions, so I don't think we need the comment. As well as dest/src
argument names are obvious enough. Still, I'm not against too.


> + */
>   ssize_t coroutine_fn
>   qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
>                     const void *src, size_t src_size)
>   {
> -    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size,
> -                                qcow2_compress);
> +    BDRVQcow2State *s = bs->opaque;
> +    Qcow2CompressFunc fn;
> +
> +    switch (s->compression_type) {
> +    case QCOW2_COMPRESSION_TYPE_ZLIB:
> +        fn = qcow2_zlib_compress;
> +        break;
> +
> +    default:
> +        return -ENOTSUP;

it can't be anything other. Maybe, better abort() ?

> +    }
> +
> +    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size, fn);
>   }
>   
> +/*
> + * qcow2_co_decompress()
> + *
> + * Decompress some data (not more than @src_size bytes) to produce exactly
> + * @dest_size bytes using the compression method defined by the image
> + * compression type
> + *
> + * @dest - destination buffer, @dest_size bytes
> + * @src - source buffer, @src_size bytes
> + *
> + * Returns: 0 on success
> + *          a negative error code on failure
> + */
>   ssize_t coroutine_fn
>   qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
>                       const void *src, size_t src_size)
>   {
> -    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size,
> -                                qcow2_decompress);
> +    BDRVQcow2State *s = bs->opaque;
> +    Qcow2CompressFunc fn;
> +
> +    switch (s->compression_type) {
> +    case QCOW2_COMPRESSION_TYPE_ZLIB:
> +        fn = qcow2_zlib_decompress;
> +        break;
> +
> +    default:
> +        return -ENOTSUP;
> +    }
> +
> +    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size, fn);
>   }
>   
>   
> 


-- 
Best regards,
Vladimir

