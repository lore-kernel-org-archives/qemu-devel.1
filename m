Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07739C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93AC208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="le5GjNNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93AC208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopj3-0002vV-Du
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:20:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1iopf6-0005gk-Oo
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1iopf5-0006bK-EC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:16:48 -0500
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:39688)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1iopf2-0006Zz-Qh; Tue, 07 Jan 2020 09:16:44 -0500
Received: by mail-qv1-xf43.google.com with SMTP id y8so20561221qvk.6;
 Tue, 07 Jan 2020 06:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SdvGPS/XJdqytZYrb4vgNQWyWBKFRSDsX/DuNlf6ccg=;
 b=le5GjNNh+HJOVtg2c4V4WujCfARz/3m5/C5zJoqq+WAIhx/FEZQjvQTNfODf101BRX
 FcZ5Bxz/Cyc6jvyTm0ank9UPmcCqMbv9kC6hIlkoxsHAuuYSq6qroDl99JFI9+t63/sr
 IxSRnTSyYY1ObuudVplZY25IEd1n/nR/QS5LKz1UikKDChZjvCNO2rklKQIsH6r9d11m
 1m0R37FLKsDCM2R0oEHlbVwZKaAqhihWu3wuAn1KhQR8uzU9nA5FYcYN5Dv4DuGyYOss
 Oz1m2JQt604+qs2wyFrVe2DYYJvnuChLkk1e0SdLSwpj3sYPypqjAAwmhq+6mMqazSOX
 2YAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SdvGPS/XJdqytZYrb4vgNQWyWBKFRSDsX/DuNlf6ccg=;
 b=iv9pL0FZBzrRPqtBXRg/aMUxMlxZYnh6fR7qB1+mKZE+cSE0HpZjccrewrEY4RuRm6
 isqFrGuQO7bmBDXkaMbncckvO3Ea2vX56uWPAfkylTMkWJOUv4YU2UAH145wa560NtWK
 M5RbchBW/b+Cz3lJDjYdhtr71JbpzP09N4ptxTtfVFaifzGhzJNl47TCNfPTCpsor6oo
 A5+Ufcl1Y+52/keoYugVerPF3zts5qHmT9XNtciwRiHg43IMNmGjaRU/y4aYbICfnFJT
 VdBX7om3gwSPC0Cd/4euSXYVoPH9Q3fIhtGi2IbqFZDi1MxVS0fQlDuW8HlVEMUR9Bn9
 jfpw==
X-Gm-Message-State: APjAAAUXeXuH6F3y0ZEzDw5LsflPhykPzoTCAPRW3wjnW8d89bvfkxGB
 6x6skJiOcaUNpMuXB79j3emb04ol
X-Google-Smtp-Source: APXvYqw8IRrxNdGJlltd61qTMPqPoNTD0uIzh0CPxQyY7qYQtT4XRd4IQFagTk1TOtQsJEhsTCo3rw==
X-Received: by 2002:a0c:c24f:: with SMTP id w15mr84501810qvh.66.1578406603768; 
 Tue, 07 Jan 2020 06:16:43 -0800 (PST)
Received: from ?IPv6:2804:431:c7c6:655b:9e1c:e865:3705:e1df?
 ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id n190sm22663294qke.90.2020.01.07.06.16.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 06:16:43 -0800 (PST)
Subject: Re: [PATCH v1 44/59] 9p-local.c: remove unneeded label in
 local_unlinkat_common()
To: Greg Kurz <groug@kaod.org>
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106182425.20312-45-danielhb413@gmail.com>
 <20200107145340.60698c46@bahia.lan>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <ad424eb9-334e-3e5e-626b-6b2a6316b870@gmail.com>
Date: Tue, 7 Jan 2020 11:16:39 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200107145340.60698c46@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f43
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/7/20 10:53 AM, Greg Kurz wrote:
> On Mon,  6 Jan 2020 15:24:10 -0300
> Daniel Henrique Barboza <danielhb413@gmail.com> wrote:
> 
>> 'err_out' can be replaced by 'return ret' in the error conditions
>> the jump was being made.
>>
>> CC: Greg Kurz <groug@kaod.org>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
>>   hw/9pfs/9p-local.c | 12 +++++-------
>>   1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
>> index ca641390fb..f9bdd2ad7c 100644
>> --- a/hw/9pfs/9p-local.c
>> +++ b/hw/9pfs/9p-local.c
>> @@ -1094,12 +1094,12 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
>>   
>>               fd = openat_dir(dirfd, name);
>>               if (fd == -1) {
>> -                goto err_out;
>> +                return ret;
>>               }
>>               ret = unlinkat(fd, VIRTFS_META_DIR, AT_REMOVEDIR);
>>               close_preserve_errno(fd);
>>               if (ret < 0 && errno != ENOENT) {
>> -                goto err_out;
>> +                return ret;
>>               }
>>           }
>>           map_dirfd = openat_dir(dirfd, VIRTFS_META_DIR);
>> @@ -1107,16 +1107,14 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
>>               ret = unlinkat(map_dirfd, name, 0);
>>               close_preserve_errno(map_dirfd);
>>               if (ret < 0 && errno != ENOENT) {
>> -                goto err_out;
>> +                return ret;
>>               }
>>           } else if (errno != ENOENT) {
>> -            goto err_out;
>> +            return ret;
> 
> Ouch... I now realize we can get there with ret == 0 when unlinking a
> directory in mapped-file mode. The function will wrongly return success
> despite the failure.... Since this function is supposed to return -1
> on error, I suggest to do that instead of return ret, and to drop the
> initialization of ret to -1, which wouldn't be needed anymore.
> 
> Since this would fix a bug it makes sense to post it separately from
> this series. Rewrite the title/changelog accordingly and I'll merge
> it via the 9p tree.


Got it. I'll repost it separately with an updated title and commit msg.


Thanks,


Daniel

> 
>>           }
>>       }
>>   
>> -    ret = unlinkat(dirfd, name, flags);
>> -err_out:
>> -    return ret;
>> +    return unlinkat(dirfd, name, flags);
>>   }
>>   
>>   static int local_remove(FsContext *ctx, const char *path)
> 

