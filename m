Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58310C282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 19:22:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 249CB20656
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 19:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZvg6DHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249CB20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iouQv-0005vE-9x
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 14:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1iouQB-000528-I1
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:21:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1iouQA-0003Rq-AV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:21:43 -0500
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:45809)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1iouQA-0003RK-6W
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:21:42 -0500
Received: by mail-qk1-x741.google.com with SMTP id x1so384175qkl.12
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 11:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LpscZTXyWM5lTXfwxjl7Kqj/be0nEhGa6bSXbLR9a2Q=;
 b=rZvg6DHBmaUBHVYlIG38oSwAhWuE0EB20FQzq64kq2K+BINEEK+3ZMiHdRDAVbU1yy
 dlCc8t4lBXyQYjZE4ii1AdnVimTL/04nk7NXdPdF15ykwHHgfnlE9XordGBt0JvzqBMw
 mamIKuKH/HB/SvzQb2rhI7ajOK1ICOdZlhaEuKeEdSh/wJwg5yeJXFXhVAV7nJ60BV19
 TBMrTtGsBUDH7jB663vItpXQ+rNZMRZ/05FM80sDy1D2ASzdSY6Z/nfrhvsJwfdizOmh
 4L++SykzSIbhIMuggZAiAq6ln3yj9P/erDDQvopT6HsKkDXEZzUeEV7so8iN7dd+1quP
 YzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LpscZTXyWM5lTXfwxjl7Kqj/be0nEhGa6bSXbLR9a2Q=;
 b=Fi+648sFihDI90DdIqVgEDhA8+tnjfl/HxeL6vBoBWvNE2E9k0BUGl8z0Uz6D7zIvG
 RC/IpFBoaAuw2NHn++zcNXXE2VzfB/Jh7Ub0uii/HT+QZT5C+ZeEFMvICEHwZ4caIhh4
 1ZnZCheRosxV+kpvN1udC+fg7ND//UfYP0nZemW3d2AC6VwFn/mJSgmFUDh5OGN3whhZ
 CHRJTJiDUqgzDKaapNt+lOkzYPBb4ocTUtn+yumR3ge1uAaxBZ78H8nR22defLbDrPls
 2EdNALiim9yukm0Cw9tR8JfjAzJJnk6h0pb+rJ1F5A6dIgaDpZU6QIZDV1zjnbVpAt99
 IGWQ==
X-Gm-Message-State: APjAAAXrQrBu/YIy4j2dAOag2TzAAofDc0a36sQGNFFogEfbzRIxuq5z
 bt0A6W/WiC7dZ4+onZjQeuRT81VM
X-Google-Smtp-Source: APXvYqxBe9GkQ8oq7MrsvM7jLGv4MDokOz+Tr7ubahkFHS/QKEjlev6kxa8xQmK3ODfQeaP2tfr7+A==
X-Received: by 2002:a37:66c2:: with SMTP id a185mr836170qkc.211.1578424901306; 
 Tue, 07 Jan 2020 11:21:41 -0800 (PST)
Received: from ?IPv6:2804:431:c7c6:655b:9e1c:e865:3705:e1df?
 ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id c18sm335593qtn.71.2020.01.07.11.21.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 11:21:40 -0800 (PST)
Subject: Re: [PATCH 1/1] 9p-local.c: always return -1 on error in
 local_unlinkat_common
To: Greg Kurz <groug@kaod.org>
References: <20200107144718.391550-1-danielhb413@gmail.com>
 <20200107174726.5640a059@bahia.lan>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <254ea08e-ef26-a61d-6144-404f035c21e8@gmail.com>
Date: Tue, 7 Jan 2020 16:21:38 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200107174726.5640a059@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/7/20 1:47 PM, Greg Kurz wrote:
> I've changed "9p-local.c:" to "9p: local:" which is the usual prefix used for
> fsdev backend specific changes.

Good to know. Thanks for fixing it up.

> 
> On Tue,  7 Jan 2020 11:47:18 -0300
> Daniel Henrique Barboza <danielhb413@gmail.com> wrote:
> 
>> local_unlinkat_common() is supposed to always return -1 on error.
>> This is being done by jumps to the 'err_out' label, which is
>> a 'return ret' call, and 'ret' is initialized with -1.
>>
>> Unfortunately there is a condition in which the function will
>> return 0 on error: in a case where flags == AT_REMOVEDIR, 'ret'
>> will be 0 when reaching
>>
>> map_dirfd = openat_dir(...)
>>
>> And, if map_dirfd == -1 and errno != ENOENT, the existing 'err_out'
>> jump will execute 'return ret', when ret is still set to zero
>> at that point.
>>
>> This patch fixes it by changing all 'err_out' labels by
>> 'return -1' calls, ensuring that the function will always
>> return -1 on error conditions. 'ret' can be left unintialized
>> since it's now being used just to store the result of 'unlinkat'
>> calls.
>>
>> CC: Greg Kurz <groug@kaod.org>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
> 
> Applied to 9p-next.
> 
> Thanks Daniel and feliz ano novo :)


Bonne année!




> 
>>   hw/9pfs/9p-local.c | 14 ++++++--------
>>   1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
>> index ca641390fb..de61aca216 100644
>> --- a/hw/9pfs/9p-local.c
>> +++ b/hw/9pfs/9p-local.c
>> @@ -1076,7 +1076,7 @@ out:
>>   static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
>>                                    int flags)
>>   {
>> -    int ret = -1;
>> +    int ret;
>>   
>>       if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
>>           int map_dirfd;
>> @@ -1094,12 +1094,12 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
>>   
>>               fd = openat_dir(dirfd, name);
>>               if (fd == -1) {
>> -                goto err_out;
>> +                return -1;
>>               }
>>               ret = unlinkat(fd, VIRTFS_META_DIR, AT_REMOVEDIR);
>>               close_preserve_errno(fd);
>>               if (ret < 0 && errno != ENOENT) {
>> -                goto err_out;
>> +                return -1;
>>               }
>>           }
>>           map_dirfd = openat_dir(dirfd, VIRTFS_META_DIR);
>> @@ -1107,16 +1107,14 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
>>               ret = unlinkat(map_dirfd, name, 0);
>>               close_preserve_errno(map_dirfd);
>>               if (ret < 0 && errno != ENOENT) {
>> -                goto err_out;
>> +                return -1;
>>               }
>>           } else if (errno != ENOENT) {
>> -            goto err_out;
>> +            return -1;
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

