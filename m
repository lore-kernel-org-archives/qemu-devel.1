Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A17C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2C172082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="o+MV55p8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C172082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyyn2-0006Hm-5y
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 09:02:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyyk0-0003OE-JG
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:59:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyyjy-0002Wy-Vx
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:59:48 -0500
Received: from mail-db8eur05on2136.outbound.protection.outlook.com
 ([40.107.20.136]:23488 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iyyju-0001zz-Cv; Tue, 04 Feb 2020 08:59:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjyalYBE5Nc5U8Vza+0z+zbl3FzM3UI6W3yiM8CndYuXAzV7Rjc196ftgRX8XB4h9L920hhl3bECt29B3u75czzQVfsD7Qu2ToCAA6/61wH1E/xJgHlPVxbPTnIEB9a5rpTcZa5aZCjbtxm3iOCjwa4aPg8xAORvEdKvhwh5uRwavSFBZVUz1K2LkS6ObjcjHCV8qJpigMEDWx6Oq5oJRNiYspwlwtA2ji798BQ+PvEifF3EelryrXO0+zTlBVurIOI3DVjTR0kmHzs2H1rMkA4m4OObJ5W8HgFQI1TrARYrTiOcBp2cYpcUkS6Vxihaw9KBCTx6InIk7WUaK25HWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLA8EHW+g+X9nLiOwSjFo3LgkO58xwMKaMx9Lf5LLQk=;
 b=f+IQfQB174Q4hmRjEvdqPcIDx/hyFy9trfim8V/Wal+4B73J5LIkggFGT3YE9uFSgyhxDjbgmXnm5n0YX3+0fP8urkl7WhCCpgeJgkL3Xb5OVqT5qU95MKLpmtWEmXbnotFLYaRrmWPRSpNGegxOO06sMe30uWlviM9IMTnwTjC9YcuKfmMwsZzh+1BRJwH6xo1vSuLuPeJQqfGpD/LsavuB6REbs/j35Y7tFwRKMp36MkLma86mkgB5VqgsNiE33zYFLHicFdxBX+DlK9o8UEUM/tMogOaP3k1cQ2+OyoToeN0LLMLEB8aDsCkRmoOL3VTPUoZVZ6QcbC3fnVwxdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLA8EHW+g+X9nLiOwSjFo3LgkO58xwMKaMx9Lf5LLQk=;
 b=o+MV55p8cLIs2CGkiaBl8ldLpIgU9B+RDAG9jve/rm2Uy1JhoqcbvSzs25fiMRzyr0gPb+u/P2K8Oxpchz0fYc87w3RMv7+j4RrTYfXDaCLtNenb5k9K9lFJvrcd3ZIAa4CI8i3VLpJT40A7R5IRF5zOijdmPcqW32fYsQJf3aQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3943.eurprd08.prod.outlook.com (20.178.87.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Tue, 4 Feb 2020 13:59:40 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 13:59:40 +0000
Subject: Re: [PATCH v3 1/1] qemu-img: Add --target-is-zero to convert
To: David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org
References: <20200204095246.1974117-1-david.edmondson@oracle.com>
 <20200204095246.1974117-2-david.edmondson@oracle.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200204165938988
Message-ID: <f384733a-0527-c6b5-5b31-4364ae707cfd@virtuozzo.com>
Date: Tue, 4 Feb 2020 16:59:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200204095246.1974117-2-david.edmondson@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0324.eurprd05.prod.outlook.com
 (2603:10a6:7:92::19) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0324.eurprd05.prod.outlook.com (2603:10a6:7:92::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27 via Frontend Transport; Tue, 4 Feb 2020 13:59:40 +0000
X-Tagtoolbar-Keys: D20200204165938988
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec5f607b-7995-41dc-14a8-08d7a97a7abf
X-MS-TrafficTypeDiagnostic: AM6PR08MB3943:
X-Microsoft-Antispam-PRVS: <AM6PR08MB39439601C0CA041E96350FE4C1030@AM6PR08MB3943.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(39850400004)(376002)(396003)(346002)(189003)(199004)(52116002)(5660300002)(86362001)(956004)(2906002)(2616005)(16526019)(26005)(31686004)(4326008)(186003)(81156014)(66556008)(66476007)(8676002)(81166006)(66946007)(8936002)(31696002)(16576012)(316002)(36756003)(6486002)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3943;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ar11N1/BgjGZRKh+vUkdagmmYR+cDtr0mPWQpuA2iVNpFFyxDPvdIdP9wnhwEiQXvIPYSYmodRx7zdZ20zMiWuLHWVb5cRb3QwPxNJ/tqbGCDBhBKl+rtVDj/yDC4D1ev6/mHVQtkFjax8UknvrTVxbpmoe8SuXIUWXES3UF/UjGcD7a5ivF89ATAUPkEv4oKQaMJzni/ygghNdKvi+mcM95hNTHDv/NqiyKhSN4oj6SYyeZrUgywY9huOE4ypvXtIkrZkNGiXEPoXyU8jZSBg84hmSxEXa3L6DsKyUflJSTMLyFh3ukZKXRMBoLeTMFRpCxVKtWFukDEyJpPgYTzPb8iCmdPpQ2XN0YjEmcHwTdfC79Kl1CVfMItj2klcaTJcDxlMXqPZ3tz8phn1TYJ0zaCjhmyxmVUGIRAlccRIT6tTKhqBXkWfSbJtQNVLNN
X-MS-Exchange-AntiSpam-MessageData: piwrtMlDQFAPRcIlzCoDtCTcuhJ/77r8MNpGmx076fM5i2YLEqMpv4CzuJATvPNr9YATLfYAhzdXr9SuMllkiVUWtrSMXjXsTPeXtc1kuYzTQPAe617QQJUuy+vxMtZYNhV3+kpLb+7omgL/Au0UTA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5f607b-7995-41dc-14a8-08d7a97a7abf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 13:59:40.7661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPFMkz1zVDC3EgvkzvG1mAaI6JKRnyUTir9idTFkgQvOPvy6cFG9v04T0IO5WCLcbIr5NR0PvIXmgZLN/juSegnmGSFEttTyB2M/ztKUS+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3943
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.20.136
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

04.02.2020 12:52, David Edmondson wrote:
> In many cases the target of a convert operation is a newly provisioned
> target that the user knows is blank (filled with zeroes). In this
> situation there is no requirement for qemu-img to wastefully zero out
> the entire device.
> 
> Add a new option, --target-is-zero, allowing the user to indicate that
> an existing target device is already zero filled.
> 
> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
> ---
>   docs/interop/qemu-img.rst |  8 +++++++-
>   qemu-img-cmds.hx          |  4 ++--
>   qemu-img.c                | 25 ++++++++++++++++++++++---
>   3 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/docs/interop/qemu-img.rst b/docs/interop/qemu-img.rst
> index fa27e5c7b453..99bdbe4740ee 100644
> --- a/docs/interop/qemu-img.rst
> +++ b/docs/interop/qemu-img.rst
> @@ -214,6 +214,12 @@ Parameters to convert subcommand:
>     will still be printed.  Areas that cannot be read from the source will be
>     treated as containing only zeroes.
>   
> +.. option:: --target-is-zero
> +
> +  Assume that the destination is filled with zeros. This parameter is
> +  mutually exclusive with the use of a backing file. It is required to

Should we mention, that s/backing file/backing file for destination/, to make it clean
that source backing file is unrelated?

> +  also use the ``-n`` parameter to skip image creation.
> +
>   Parameters to dd subcommand:
>   
>   .. program:: qemu-img-dd
> @@ -366,7 +372,7 @@ Command description:
>     4
>       Error on reading data
>   
> -.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
> +.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
>   
>     Convert the disk image *FILENAME* or a snapshot *SNAPSHOT_PARAM*
>     to disk image *OUTPUT_FILENAME* using format *OUTPUT_FMT*. It can
> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index 3fd836ca9090..e6f98b75473f 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -39,9 +39,9 @@ SRST
>   ERST
>   
>   DEF("convert", img_convert,
> -    "convert [--object objectdef] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] [--salvage] filename [filename2 [...]] output_filename")
> +    "convert [--object objectdef] [--image-opts] [--target-image-opts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] [--salvage] filename [filename2 [...]] output_filename")
>   SRST
> -.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] [--salvage] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
> +.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] [--salvage] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
>   ERST
>   
>   DEF("create", img_create,

Side question: is there plan to get rid of this duplication, and generate everything from rst?

> diff --git a/qemu-img.c b/qemu-img.c
> index 2b4562b9d9f2..e0bfc33ef4f6 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -70,6 +70,7 @@ enum {
>       OPTION_PREALLOCATION = 265,
>       OPTION_SHRINK = 266,
>       OPTION_SALVAGE = 267,
> +    OPTION_TARGET_IS_ZERO = 268,
>   };
>   
>   typedef enum OutputFormat {
> @@ -1984,10 +1985,9 @@ static int convert_do_copy(ImgConvertState *s)
>       int64_t sector_num = 0;
>   
>       /* Check whether we have zero initialisation or can get it efficiently */
> -    if (s->target_is_new && s->min_sparse && !s->target_has_backing) {
> +    if (!s->has_zero_init && s->target_is_new && s->min_sparse &&
> +        !s->target_has_backing) {
>           s->has_zero_init = bdrv_has_zero_init(blk_bs(s->target));
> -    } else {
> -        s->has_zero_init = false;
>       }
>   
>       if (!s->has_zero_init && !s->target_has_backing &&
> @@ -2086,6 +2086,7 @@ static int img_convert(int argc, char **argv)
>               {"force-share", no_argument, 0, 'U'},
>               {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS},
>               {"salvage", no_argument, 0, OPTION_SALVAGE},
> +            {"target-is-zero", no_argument, 0, OPTION_TARGET_IS_ZERO},
>               {0, 0, 0, 0}
>           };
>           c = getopt_long(argc, argv, ":hf:O:B:Cco:l:S:pt:T:qnm:WU",
> @@ -2209,6 +2210,14 @@ static int img_convert(int argc, char **argv)
>           case OPTION_TARGET_IMAGE_OPTS:
>               tgt_image_opts = true;
>               break;
> +        case OPTION_TARGET_IS_ZERO:
> +            /*
> +             * The user asserting that the target is blank has the
> +             * same effect as the target driver supporting zero
> +             * initialisation.
> +             */
> +            s.has_zero_init = true;
> +            break;
>           }
>       }
>   
> @@ -2247,6 +2256,11 @@ static int img_convert(int argc, char **argv)
>           warn_report("This will become an error in future QEMU versions.");
>       }
>   
> +    if (s.has_zero_init && !skip_create) {
> +        error_report("--target-is-zero requires use of -n flag");
> +        goto fail_getopt;
> +    }
> +
>       s.src_num = argc - optind - 1;
>       out_filename = s.src_num >= 1 ? argv[argc - 1] : NULL;
>   
> @@ -2380,6 +2394,11 @@ static int img_convert(int argc, char **argv)
>       }
>       s.target_has_backing = (bool) out_baseimg;
>   
> +    if (s.has_zero_init && s.target_has_backing) {
> +        error_report("Cannot use --target-is-zero with a backing file");

And here, probably better: "with a backing file on destination"

> +        goto out;
> +    }
> +
>       if (s.src_num > 1 && out_baseimg) {
>           error_report("Having a backing file for the target makes no sense when "
>                        "concatenating multiple input images");
> 

With or without my suggestions:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir

