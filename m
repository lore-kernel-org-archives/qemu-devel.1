Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DAEC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:25:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FAC52166E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VaHDPJIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FAC52166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jCq-0005sZ-PU
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 06:25:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j8jBp-0005C7-4W
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:24:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j8jBn-00065X-IL
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:24:49 -0500
Received: from mail-am6eur05on2134.outbound.protection.outlook.com
 ([40.107.22.134]:3577 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j8jBi-000657-ON; Mon, 02 Mar 2020 06:24:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3k1KDxLsrTGDliJtFXlFTBXySxmPTrmAIpa8muZY21TW2Gg4T5RfniWorlEUzFG9JtzIHV4XUnWSPj/sH794tknWinjoTaVcVCAC0tgPPkoZZFFUu9OKQtPUX8zebVt/Byp1JuRwvNWwTd/W6jPEVk6oSPw4a5RCYTSYu4eB4jrdRoX54c00SpxIXqyWHZpSs8ijpGGOscCaWg4NymycPt/ggaJmmD0WBU8S/DCwymBuVWlAVe21do5Cn4lrJhvd5DwT63CVTg2ytvXEBAPgNvD2FeLu5nlUkgnnQtSBOP4CwdvqZ89/hyDizUK99kW1DDTCdPojP/LHdC7FUP1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i9PoVaGysnW8PsoZvaZdbJVnxYF7pjmO1+WwaKDaPk=;
 b=kEcz/qbP8FARWAueZOzoiGXdN8E8RCoeG0SBFNG8S++B/ONQikCFVGKr848uAywy66VqEKj8K80lPPkJnQ8dsV4XKELUaZl+0m7ds8AML1w1WtuOJI1v16JdP23pW7kGfy4rfLUk89IsM7UxRXrgxrTp+whlNYEvoTDeaEnUddUJALLVUh4G3JQrbQwLu6bm5aSIO8Pw6cCRN4DZKwregZsPzPTXuQS93B7TNh1FYO/EqA5/V2ONv+5qOG7QjT5qU9OWeF0T/Y2+ADQdtuZ48u/yP9Y81EVhOHegcmyFekAI4M8L8AOrlPiISA3KkForT0THH/qd3JGSfoTVX4ApRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i9PoVaGysnW8PsoZvaZdbJVnxYF7pjmO1+WwaKDaPk=;
 b=VaHDPJITUuFyp7Vx6+FqWuEWZMw01BhvqyVRceO6BxlVEyqnKhE2aILp9Qr/7aT/kChMo0Romy6Q2vK4kTJZGElpOBNcgJFuPt/lxAb6sRHvKyRFmxsmcMX8aPIRU5b99uSFQWhW2UR04FGyxGI6wwQuUnLlE9QxrEZ7P4FDxMg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4150.eurprd08.prod.outlook.com (20.179.2.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Mon, 2 Mar 2020 11:24:40 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 11:24:40 +0000
Subject: Re: [PATCH v2 1/4] qcow2: introduce compression type feature
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200302082111.21205-1-dplotnikov@virtuozzo.com>
 <20200302082111.21205-2-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200302142438579
Message-ID: <6190af16-d08e-fb0b-f090-a3d64986a960@virtuozzo.com>
Date: Mon, 2 Mar 2020 14:24:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200302082111.21205-2-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0502CA0005.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::15) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0502CA0005.eurprd05.prod.outlook.com (2603:10a6:3:e3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 11:24:39 +0000
X-Tagtoolbar-Keys: D20200302142438579
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c3ec573-c0fc-444c-92ff-08d7be9c4c7f
X-MS-TrafficTypeDiagnostic: AM6PR08MB4150:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4150D71B661D0CE2E54DDD6CC1E70@AM6PR08MB4150.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(39850400004)(376002)(346002)(396003)(199004)(189003)(316002)(8676002)(26005)(478600001)(2616005)(956004)(81156014)(16526019)(186003)(6486002)(19627235002)(81166006)(8936002)(66946007)(2906002)(4326008)(31686004)(16576012)(36756003)(31696002)(66556008)(52116002)(5660300002)(86362001)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4150;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mcYtOaaYbC4qH+jh1lsbnBQNRJL6AkXQb+HVXwFn2tNGim8O+COJbK5U3RJR184YFwO7eEiza290YMW6qQIq+pLsqzGmic6zdXQ7v4sDIjff5Hv9eVygyZBD27erN8VvY7NNInYr8HTpj9eXF6rDgHb3flxDMtkPU3sNTmBe7z3/TdqF6XrRJzwft2Y6kOKrAOMmSrN9FarxBoXN2t37fKel1GjoMVXCxaOS6ZRW6PGLNM4PT4uft0y+8tEbSxlsbi5Zcw1GK/mU07XfH+mRwBtSgx1iP/JeLGBEY1Q0xcooCCZQgKLafCJAM8edlF7MYO+GEXA/US4nXPPodsV4BPPqF/JEwr3hHUIpB9OHeSxuEs6qHAksAwz9Is93ztpv7yVWIvqPIy3O1q3oWVCkdz3CtcFa5T8gGTk7lwME83y0gUX+74l917Am5dep/QL7
X-MS-Exchange-AntiSpam-MessageData: G2BFooSaC+REztz/IXZQUOEwmUbRC0xiaDWwxiRJZvd+j4HltZUgoL86C3yD8OVjx42CbPxMEq763j7BF5iQ+9vpfjgNEA16ySvTtrpB08i/DB8SaTadJiy4kQ4RRo4vM8P2uCjqTHWWvpg5jDwSDQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3ec573-c0fc-444c-92ff-08d7be9c4c7f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 11:24:40.5758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOfjG4V8tRUuU2RpppDX2y1ut2zHYtGPM/Vj3+ViS3mi5pyf7P2Fh+49Eo+vOT8uqc1wTPrW5sNeL9iEgTeRu5NpIhUw3jOGqGXH1lk/yuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4150
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.134
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
Cc: kwolf@redhat.com, den@openvz.com, qemu-block@nongnu.org, armbru@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.03.2020 11:21, Denis Plotnikov wrote:
> The patch adds some preparation parts for incompatible compression type
> feature to qcow2 allowing the use different compression methods for
> image clusters (de)compressing.
> 
> It is implied that the compression type is set on the image creation and
> can be changed only later by image conversion, thus compression type
> defines the only compression algorithm used for the image, and thus,
> for all image clusters.
> 
> The goal of the feature is to add support of other compression methods
> to qcow2. For example, ZSTD which is more effective on compression than ZLIB.
> 
> The default compression is ZLIB. Images created with ZLIB compression type
> are backward compatible with older qemu versions.
> 
> Adding of the compression type breaks a number of tests because now the
> compression type is reported on image creation and there are some changes
> in the qcow2 header in size and offsets.
> 
> The tests are fixed in the following ways:
>      * filter out compression_type for all the tests
>      * fix header size, feature table size and backing file offset
>        affected tests: 031, 036, 061, 080
>        header_size +=8: 1 byte compression type
>                         7 bytes padding
>        feature_table += 48: incompatible feture compression type
>        backing_file_offset += 56 (8 + 48 -> header_change + fature_table_change)
>      * add "compression type" for test output matching when it isn't filtered
>        affected tests: 049, 060, 061, 065, 144, 182, 242, 255
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>

I'm almost OK with this patch. Some notes below and:

Seems, new option should be handled in qcow2_amend_options among other unsupported ones (otherwise qcow2_amend_options aborts).

> ---
>   qapi/block-core.json             |  22 ++++++-
>   block/qcow2.h                    |  18 ++++-
>   include/block/block_int.h        |   1 +
>   block/qcow2.c                    | 109 +++++++++++++++++++++++++++++++
>   tests/qemu-iotests/031.out       |  14 ++--
>   tests/qemu-iotests/036.out       |   4 +-
>   tests/qemu-iotests/049.out       | 102 ++++++++++++++---------------
>   tests/qemu-iotests/060.out       |   1 +
>   tests/qemu-iotests/061.out       |  34 ++++++----
>   tests/qemu-iotests/065           |  20 +++---
>   tests/qemu-iotests/080           |   2 +-
>   tests/qemu-iotests/144.out       |   4 +-
>   tests/qemu-iotests/182.out       |   2 +-
>   tests/qemu-iotests/242.out       |   5 ++
>   tests/qemu-iotests/255.out       |   8 +--
>   tests/qemu-iotests/common.filter |   3 +-
>   16 files changed, 255 insertions(+), 94 deletions(-)
> 

[..]

> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -146,6 +146,12 @@ typedef struct QCowHeader {
>   
>       uint32_t refcount_order;
>       uint32_t header_length;
> +
> +    /* Additional fields */
> +    uint8_t  compression_type;
> +
> +    /* header must be a multiple of 8 */
> +    uint8_t  padding[7];
>   } QEMU_PACKED QCowHeader;
>   
>   typedef struct QEMU_PACKED QCowSnapshotHeader {
> @@ -216,13 +222,16 @@ enum {
>       QCOW2_INCOMPAT_DIRTY_BITNR      = 0,
>       QCOW2_INCOMPAT_CORRUPT_BITNR    = 1,
>       QCOW2_INCOMPAT_DATA_FILE_BITNR  = 2,
> +    QCOW2_INCOMPAT_COMPRESSION_BITNR= 3,

checkpatch complains. I think, you can just use one space before '=' and don't
care about alignment.

>       QCOW2_INCOMPAT_DIRTY            = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
>       QCOW2_INCOMPAT_CORRUPT          = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
>       QCOW2_INCOMPAT_DATA_FILE        = 1 << QCOW2_INCOMPAT_DATA_FILE_BITNR,
> +    QCOW2_INCOMPAT_COMPRESSION      = 1 << QCOW2_INCOMPAT_COMPRESSION_BITNR,
>   
>       QCOW2_INCOMPAT_MASK             = QCOW2_INCOMPAT_DIRTY
>                                       | QCOW2_INCOMPAT_CORRUPT
> -                                    | QCOW2_INCOMPAT_DATA_FILE,
> +                                    | QCOW2_INCOMPAT_DATA_FILE
> +                                    | QCOW2_INCOMPAT_COMPRESSION,
>   };
>   
>   /* Compatible feature bits */
> @@ -369,6 +378,13 @@ typedef struct BDRVQcow2State {
>   
>       bool metadata_preallocation_checked;
>       bool metadata_preallocation;
> +    /*
> +     * Compression type used for the image. Default: 0 - ZLIB
> +     * The image compression type is set on image creation.
> +     * The only way to change the compression type is to convert the image
> +     * with the desired compression type set
> +     */
> +    Qcow2CompressionType compression_type;
>   } BDRVQcow2State;
>   
>   typedef struct Qcow2COWRegion {
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 6f9fd5e20e..2c6bb9dc99 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -57,6 +57,7 @@
>   #define BLOCK_OPT_REFCOUNT_BITS     "refcount_bits"
>   #define BLOCK_OPT_DATA_FILE         "data_file"
>   #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
> +#define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
>   
>   #define BLOCK_PROBE_BUF_SIZE        512
>   
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 3c754f616b..fc5232a5d6 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1242,6 +1242,50 @@ static int qcow2_update_options(BlockDriverState *bs, QDict *options,
>       return ret;
>   }
>   
> +static int validate_compression_type(BDRVQcow2State *s, Error **errp)
> +{
> +    /*
> +     * Sanity check
> +     * according to qcow2 spec, the compression type is 1-byte field
> +     * but in BDRVQcow2State the compression_type is enum sizeof(int)
> +     * so, the max compression_type value is 255.
> +     */
> +    if (s->compression_type > 0xff) {

This code is unreachable, I'd prefer assertion.

> +        error_setg(errp, "qcow2: compression type value is too big");
> +        return -EINVAL;
> +    }
> +
> +    switch (s->compression_type) {
> +    case QCOW2_COMPRESSION_TYPE_ZLIB:
> +        break;
> +
> +    default:
> +        error_setg(errp, "qcow2: unknown compression type: %u",
> +                   s->compression_type);
> +        return -ENOTSUP;
> +    }
> +
> +    /*
> +     * if the compression type differs from QCOW2_COMPRESSION_TYPE_ZLIB
> +     * the incompatible feature flag must be set
> +     */
> +    if (s->compression_type == QCOW2_COMPRESSION_TYPE_ZLIB) {
> +        if (s->incompatible_features & QCOW2_INCOMPAT_COMPRESSION) {
> +            error_setg(errp, "qcow2: Compression type incompatible feature "
> +                             "bit must not be set");
> +            return -EINVAL;
> +        }
> +    } else {
> +        if (!(s->incompatible_features & QCOW2_INCOMPAT_COMPRESSION)) {
> +            error_setg(errp, "qcow2: Compression type incompatible feature "
> +                             "bit must be set");
> +            return -EINVAL;
> +        }
> +    }
> +
> +    return 0;
> +}
> +


[..]

> @@ -3379,6 +3453,27 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
>           }
>       }
>   
> +    if (qcow2_opts->has_compression_type &&
> +        qcow2_opts->compression_type != QCOW2_COMPRESSION_TYPE_ZLIB) {
> +
> +        ret = -EINVAL;
> +
> +        if (version < 3) {
> +            error_setg(errp, "Compression type is only supported with "

Hmm. "Non-zlib compression type is only.." would be a bit more honest :)

> +                       "compatibility level 1.1 and above (use version=v3 or "
> +                       "greater)");
> +            goto out;
> +        }
> +
> +        switch (qcow2_opts->compression_type) {
> +        default:
> +            error_setg(errp, "Unknown compression type");
> +            goto out;
> +        }
> +
> +        compression_type = qcow2_opts->compression_type;
> +    }
> +


[..]

> --- a/tests/qemu-iotests/065
> +++ b/tests/qemu-iotests/065
> @@ -88,23 +88,25 @@ class TestQMP(TestImageInfoSpecific):
>   class TestQCow2(TestQemuImgInfo):
>       '''Testing a qcow2 version 2 image'''
>       img_options = 'compat=0.10'
> -    json_compare = { 'compat': '0.10', 'refcount-bits': 16 }
> -    human_compare = [ 'compat: 0.10', 'refcount bits: 16' ]
> +    json_compare = { 'compat': '0.10', 'refcount-bits': 16, 'compression-type': 'zlib' }
> +    human_compare = [ 'compat: 0.10', 'compression type: zlib', 'refcount bits: 16' ]

over-80 line (and several below).

>   
>   class TestQCow3NotLazy(TestQemuImgInfo):
>       '''Testing a qcow2 version 3 image with lazy refcounts disabled'''
>       img_options = 'compat=1.1,lazy_refcounts=off'
>       json_compare = { 'compat': '1.1', 'lazy-refcounts': False,
> -                     'refcount-bits': 16, 'corrupt': False }
> -    human_compare = [ 'compat: 1.1', 'lazy refcounts: false',
> +                     'refcount-bits': 16, 'corrupt': False,
> +                     'compression-type': 'zlib' }
> +    human_compare = [ 'compat: 1.1', 'compression type: zlib', 'lazy refcounts: false',
>                         'refcount bits: 16', 'corrupt: false' ]
>   
>   class TestQCow3Lazy(TestQemuImgInfo):
>       '''Testing a qcow2 version 3 image with lazy refcounts enabled'''
>       img_options = 'compat=1.1,lazy_refcounts=on'
>       json_compare = { 'compat': '1.1', 'lazy-refcounts': True,
> -                     'refcount-bits': 16, 'corrupt': False }
> -    human_compare = [ 'compat: 1.1', 'lazy refcounts: true',
> +                     'refcount-bits': 16, 'corrupt': False,
> +                     'compression-type': 'zlib' }
> +    human_compare = [ 'compat: 1.1', 'compression type: zlib', 'lazy refcounts: true',
>                         'refcount bits: 16', 'corrupt: false' ]
>   

[..]


-- 
Best regards,
Vladimir

