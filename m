Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90873C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:22:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D3B920730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="1M4PAiV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3B920730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59485 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyz6J-0008N8-KG
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 09:22:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dme@dme.org>) id 1iyz5X-0007di-7C
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dme@dme.org>) id 1iyz5V-0004Tp-Ph
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:22:03 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46913)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dme@dme.org>) id 1iyz5V-0004T8-Ii
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:22:01 -0500
Received: by mail-wr1-x442.google.com with SMTP id z7so23202663wrl.13
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 06:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=k8F47PBkp6uJ64nh4as4niwbprvGOzymnKEuFow1Kvw=;
 b=1M4PAiV7ablXmodjj0VSZEv6myBQXn0TuKqJYrOkDoNwXRgsWRoYNOpfDLlq86874e
 KEsWykCjM/Lxo5B/QfVKnyidNX67eP72uKiByIr1Jfg+du2qIXhQdOq/PhdOupU57Q8P
 0/YWYK1aAU+WRzq9vDoXXg81rF68osslU3P1SAayeg7P7Z7s6CzJmKpMOPhR8LM5mUqU
 EJzjJu+P9vHtefM5NsARfVqPd7ZK8VYRfQrak2o6p2nE8O2UMXKu5hZAl2SEQx+5+t3b
 xmB1vmXuhB8k09rIXxy9y5j3MdyI8eaBkOTgZZcVcrWWvHwAZlfy6/o9M287bfDwz3mF
 2huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=k8F47PBkp6uJ64nh4as4niwbprvGOzymnKEuFow1Kvw=;
 b=HS75p9UYL/XtX1GSoukpBKfk+E3vUTtYGSGKQS1KJwY0mZiJlph49SyLTNNfQWdIAT
 LZWxS0kQelsYkHlH2GspoVP8tJPpt4kUY1eo/EqLcRfOdabYU+Af86NfvUBXIxsUA8B9
 sOHiNWm0iWXYBywYJgG/0qyt3p9qhiXrG16WBs/34oMYVcxt+HPhIepzmVQv7EqHL3P0
 7k7/4zd4haKkRwdLkAQO+jDWnXIjiHiZqXCtBmnIZmLCSeG6+QwnKCTI86HjGfhlDuy6
 kDIbAzWK7qclJ9NiQKu+kXVK/Ca9T3kshk0cXznEfklPLrNhcfWBRm+kayrlIzwEr/Sy
 vimg==
X-Gm-Message-State: APjAAAWUsw+UydSRSNlDxbyhfE0o18/pXz1iQmvnIjySnYREtBSIvMaT
 nxUHK1s63Wb3O2sm5W2lAtyf+A==
X-Google-Smtp-Source: APXvYqxAGxnFvJueW59zX7jlp3kkzb3pEkHDb1ajJltJSBEbrC0f3QEUTED3+77+cIiNK9A5RpG4Mw==
X-Received: by 2002:adf:e38f:: with SMTP id e15mr24076178wrm.271.1580826120482; 
 Tue, 04 Feb 2020 06:22:00 -0800 (PST)
Received: from disaster-area.hh.sledj.net (disaster-area.hh.sledj.net.
 [81.149.164.25])
 by smtp.gmail.com with ESMTPSA id 2sm30135135wrq.31.2020.02.04.06.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 06:21:59 -0800 (PST)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id f262d27c;
 Tue, 4 Feb 2020 14:21:59 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/1] qemu-img: Add --target-is-zero to convert
In-Reply-To: <f384733a-0527-c6b5-5b31-4364ae707cfd@virtuozzo.com>
References: <20200204095246.1974117-1-david.edmondson@oracle.com>
 <20200204095246.1974117-2-david.edmondson@oracle.com>
 <f384733a-0527-c6b5-5b31-4364ae707cfd@virtuozzo.com>
X-HGTTG: gag-halfrunt
From: David Edmondson <dme@dme.org>
Date: Tue, 04 Feb 2020 14:21:59 +0000
Message-ID: <cund0ausa9k.fsf@gag-halfrunt.hh.sledj.net>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

On Tuesday, 2020-02-04 at 16:59:39 +03, Vladimir Sementsov-Ogievskiy wrote:

> 04.02.2020 12:52, David Edmondson wrote:
>> In many cases the target of a convert operation is a newly provisioned
>> target that the user knows is blank (filled with zeroes). In this
>> situation there is no requirement for qemu-img to wastefully zero out
>> the entire device.
>> 
>> Add a new option, --target-is-zero, allowing the user to indicate that
>> an existing target device is already zero filled.
>> 
>> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
>> ---
>>   docs/interop/qemu-img.rst |  8 +++++++-
>>   qemu-img-cmds.hx          |  4 ++--
>>   qemu-img.c                | 25 ++++++++++++++++++++++---
>>   3 files changed, 31 insertions(+), 6 deletions(-)
>> 
>> diff --git a/docs/interop/qemu-img.rst b/docs/interop/qemu-img.rst
>> index fa27e5c7b453..99bdbe4740ee 100644
>> --- a/docs/interop/qemu-img.rst
>> +++ b/docs/interop/qemu-img.rst
>> @@ -214,6 +214,12 @@ Parameters to convert subcommand:
>>     will still be printed.  Areas that cannot be read from the source will be
>>     treated as containing only zeroes.
>>   
>> +.. option:: --target-is-zero
>> +
>> +  Assume that the destination is filled with zeros. This parameter is
>> +  mutually exclusive with the use of a backing file. It is required to
>
> Should we mention, that s/backing file/backing file for destination/, to make it clean
> that source backing file is unrelated?

Yes, that makes sense, similarly in the error message.

>> +  also use the ``-n`` parameter to skip image creation.
>> +
>>   Parameters to dd subcommand:
>>   
>>   .. program:: qemu-img-dd
>> @@ -366,7 +372,7 @@ Command description:
>>     4
>>       Error on reading data
>>   
>> -.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
>> +.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
>>   
>>     Convert the disk image *FILENAME* or a snapshot *SNAPSHOT_PARAM*
>>     to disk image *OUTPUT_FILENAME* using format *OUTPUT_FMT*. It can
>> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
>> index 3fd836ca9090..e6f98b75473f 100644
>> --- a/qemu-img-cmds.hx
>> +++ b/qemu-img-cmds.hx
>> @@ -39,9 +39,9 @@ SRST
>>   ERST
>>   
>>   DEF("convert", img_convert,
>> -    "convert [--object objectdef] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] [--salvage] filename [filename2 [...]] output_filename")
>> +    "convert [--object objectdef] [--image-opts] [--target-image-opts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] [--salvage] filename [filename2 [...]] output_filename")
>>   SRST
>> -.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] [--salvage] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
>> +.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] [--salvage] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
>>   ERST
>>   
>>   DEF("create", img_create,
>
> Side question: is there plan to get rid of this duplication, and generate everything from rst?
>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 2b4562b9d9f2..e0bfc33ef4f6 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -70,6 +70,7 @@ enum {
>>       OPTION_PREALLOCATION = 265,
>>       OPTION_SHRINK = 266,
>>       OPTION_SALVAGE = 267,
>> +    OPTION_TARGET_IS_ZERO = 268,
>>   };
>>   
>>   typedef enum OutputFormat {
>> @@ -1984,10 +1985,9 @@ static int convert_do_copy(ImgConvertState *s)
>>       int64_t sector_num = 0;
>>   
>>       /* Check whether we have zero initialisation or can get it efficiently */
>> -    if (s->target_is_new && s->min_sparse && !s->target_has_backing) {
>> +    if (!s->has_zero_init && s->target_is_new && s->min_sparse &&
>> +        !s->target_has_backing) {
>>           s->has_zero_init = bdrv_has_zero_init(blk_bs(s->target));
>> -    } else {
>> -        s->has_zero_init = false;
>>       }
>>   
>>       if (!s->has_zero_init && !s->target_has_backing &&
>> @@ -2086,6 +2086,7 @@ static int img_convert(int argc, char **argv)
>>               {"force-share", no_argument, 0, 'U'},
>>               {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS},
>>               {"salvage", no_argument, 0, OPTION_SALVAGE},
>> +            {"target-is-zero", no_argument, 0, OPTION_TARGET_IS_ZERO},
>>               {0, 0, 0, 0}
>>           };
>>           c = getopt_long(argc, argv, ":hf:O:B:Cco:l:S:pt:T:qnm:WU",
>> @@ -2209,6 +2210,14 @@ static int img_convert(int argc, char **argv)
>>           case OPTION_TARGET_IMAGE_OPTS:
>>               tgt_image_opts = true;
>>               break;
>> +        case OPTION_TARGET_IS_ZERO:
>> +            /*
>> +             * The user asserting that the target is blank has the
>> +             * same effect as the target driver supporting zero
>> +             * initialisation.
>> +             */
>> +            s.has_zero_init = true;
>> +            break;
>>           }
>>       }
>>   
>> @@ -2247,6 +2256,11 @@ static int img_convert(int argc, char **argv)
>>           warn_report("This will become an error in future QEMU versions.");
>>       }
>>   
>> +    if (s.has_zero_init && !skip_create) {
>> +        error_report("--target-is-zero requires use of -n flag");
>> +        goto fail_getopt;
>> +    }
>> +
>>       s.src_num = argc - optind - 1;
>>       out_filename = s.src_num >= 1 ? argv[argc - 1] : NULL;
>>   
>> @@ -2380,6 +2394,11 @@ static int img_convert(int argc, char **argv)
>>       }
>>       s.target_has_backing = (bool) out_baseimg;
>>   
>> +    if (s.has_zero_init && s.target_has_backing) {
>> +        error_report("Cannot use --target-is-zero with a backing file");
>
> And here, probably better: "with a backing file on destination"
>
>> +        goto out;
>> +    }
>> +
>>       if (s.src_num > 1 && out_baseimg) {
>>           error_report("Having a backing file for the target makes no sense when "
>>                        "concatenating multiple input images");
>> 
>
> With or without my suggestions:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
>
> -- 
> Best regards,
> Vladimir

dme.
-- 
You bring light in.

