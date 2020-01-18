Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34905C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 08:27:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F359B2468B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 08:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="s7V7sMsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F359B2468B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=etsukata.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isjRl-0007FF-48
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 03:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <devel@etsukata.com>) id 1isjQz-0006kZ-K0
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 03:26:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <devel@etsukata.com>) id 1isjQy-00028B-Fp
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 03:26:21 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <devel@etsukata.com>) id 1isjQy-00026g-52
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 03:26:20 -0500
Received: by mail-pg1-x544.google.com with SMTP id x8so12829904pgk.8
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 00:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=etsukata-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7WcQTAu3j6GzRWA1pYKmEBuoWcYwo9lQbdxloO0pLOw=;
 b=s7V7sMsLe5Ur0/odVNb7Xbgcs85OBCmhJvQGMPzZG29GhmdbZ9wne6sJBIvN0FI9JW
 2uiDYZ+CMdrWkN1R9lLEFS8KVGPDXO2NzNow00uC5llI7sa8uPPNav+iEZeq3AYoHaT1
 8xgNjbxsOsn6kxwJ3NQQVjo1/zGdFxIB98Bqv3CZozOS/BVCAJafst8vPvXzpHHXZwHG
 2crE/UlHb/OSK8oVZOkod0TaRknvUaS9mIHqFBDenEvoiaLdXJzj6xj7p9GiQjIXKUeR
 +JEDVWx68D7ogIPnHr19nzld3Mt0bzJpVjDVi9Ms4cZjh0Th0IIgjElefe5a0q+E851G
 +ADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=7WcQTAu3j6GzRWA1pYKmEBuoWcYwo9lQbdxloO0pLOw=;
 b=Rnjw2rIkSBuZnWGdNF3++gubTvHpPnqI0Vyj927fz4nYidbmvk28bZDhKp7ljQphXy
 y89Uigv5d8rPDubjUmsBTy1U3PWSI9DZQL9Z8Vcvdra1FlDSPHWibDwCiNhIOYbdpHQv
 n0Vyvs71MKZIZRv1AClXndOgYrqPwwiSK+PZFGmwS1mvTHlxcF8+N848qA42xep3kmcy
 bDKgoXcQ4PGpM86LyH9Xi65J27gT6fx9521G8MgvYHdeUJcP9G8lpJ0FH5Jwu75XxEAw
 zSqm5zNn7FqZB8PbXq3Rre2Au+L6IzN/nzdv+kv0y9UZ8qVP/d7KOGJlcdAgdWP8biHw
 Iwgw==
X-Gm-Message-State: APjAAAWZNj6P0D9pETBzi1v77FQlwsgCviXbfAK26V0V8CiUSEJGalB2
 KDbCRvJ/0dXdr2/gIAEiyibAeA==
X-Google-Smtp-Source: APXvYqx6G+/ppmzgAqJkQlMoevtKLZW3WbkPlIJTPj84YHrOGyLvCnKZJAnpSSrbfovzv5MDxc+DdQ==
X-Received: by 2002:aa7:9105:: with SMTP id 5mr7217463pfh.258.1579335978168;
 Sat, 18 Jan 2020 00:26:18 -0800 (PST)
Received: from Etsukata.local (p5210008-ipngn11502marunouchi.tokyo.ocn.ne.jp.
 [153.163.172.8])
 by smtp.gmail.com with ESMTPSA id s26sm31935362pfe.166.2020.01.18.00.26.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 18 Jan 2020 00:26:17 -0800 (PST)
Subject: Re: [PATCH] block/backup: fix memory leak in bdrv_backup_top_append()
To: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, vsementsov@virtuozzo.com
References: <20191223090632.30653-1-devel@etsukata.com>
From: Eiichi Tsukata <devel@etsukata.com>
Openpgp: preference=signencrypt
Autocrypt: addr=devel@etsukata.com; keydata=
 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
Message-ID: <0a09b9cf-4c5e-a90e-07eb-2331b8140d3b@etsukata.com>
Date: Sat, 18 Jan 2020 17:26:13 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191223090632.30653-1-devel@etsukata.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping

On 2019/12/23 18:06, Eiichi Tsukata wrote:
> bdrv_open_driver() allocates bs->opaque according to drv->instance_size.
> There is no need to allocate it and overwrite opaque in
> bdrv_backup_top_append().
> 
> Reproducer:
> 
>   $ QTEST_QEMU_BINARY=./x86_64-softmmu/qemu-system-x86_64 valgrind -q --leak-check=full tests/test-replication -p /replication/secondary/start
>   ==29792== 24 bytes in 1 blocks are definitely lost in loss record 52 of 226
>   ==29792==    at 0x483AB1A: calloc (vg_replace_malloc.c:762)
>   ==29792==    by 0x4B07CE0: g_malloc0 (in /usr/lib64/libglib-2.0.so.0.6000.7)
>   ==29792==    by 0x12BAB9: bdrv_open_driver (block.c:1289)
>   ==29792==    by 0x12BEA9: bdrv_new_open_driver (block.c:1359)
>   ==29792==    by 0x1D15CB: bdrv_backup_top_append (backup-top.c:190)
>   ==29792==    by 0x1CC11A: backup_job_create (backup.c:439)
>   ==29792==    by 0x1CD542: replication_start (replication.c:544)
>   ==29792==    by 0x1401B9: replication_start_all (replication.c:52)
>   ==29792==    by 0x128B50: test_secondary_start (test-replication.c:427)
>   ...
> 
> Fixes: 7df7868b9640 ("block: introduce backup-top filter driver")
> Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
> ---
>  block/backup-top.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/backup-top.c b/block/backup-top.c
> index 7cdb1f8eba..617217374d 100644
> --- a/block/backup-top.c
> +++ b/block/backup-top.c
> @@ -196,7 +196,7 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
>      }
>  
>      top->total_sectors = source->total_sectors;
> -    top->opaque = state = g_new0(BDRVBackupTopState, 1);
> +    state = top->opaque;
>  
>      bdrv_ref(target);
>      state->target = bdrv_attach_child(top, target, "target", &child_file, errp);
> 

