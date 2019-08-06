Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BB2C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 17:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B463B20717
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 17:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJ9DjBgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B463B20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv2u8-0005Bc-Q3
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 13:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52079)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <danielhb413@gmail.com>) id 1hv2qo-0008Q3-FX
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 13:02:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1hv2qn-00077O-7v
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 13:02:18 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:38226)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1hv2qn-00076g-3D
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 13:02:17 -0400
Received: by mail-qt1-x842.google.com with SMTP id n11so85239068qtl.5
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 10:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=0TL3JL4VWytHn1tlsKbBLGaaRd1gh51yUZoQ45PT598=;
 b=JJ9DjBgzlLywh5zuSErKXFfpiH1292B+oriRpzXay0QG3P8+OhszVrLZFyKkSsJi9F
 snvR6b73DJjla4WbhClYF0caqxddWVhzfP/mtZjA/Kq9qBBz0WURmt2i0uW1YXcGYBmu
 vdAznAYR25Z6S24eCKp9wEEKdOzvAMnwrWcy9x4ww6/S3NVOuE0sRKYjmlPkICQ1tmrK
 elEW/oVBlEmgeti0MiuQZ+cM1z2wISwcFbf148wgNdeFBFHQbc0p0YhCF92pnET/K4j1
 nq2CF7btUy8vPH9mC4pf9gp0oBB8ncXD505sdJaOyNIjFETLI90MQgPh7ynvbxbQbWE0
 TuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=0TL3JL4VWytHn1tlsKbBLGaaRd1gh51yUZoQ45PT598=;
 b=ZPG/daHNhJXqSbceNlRGWOGYfaI10XoBi6Wwl3R/eBPLZLlWtf96lVz6F2GKAfa7qr
 toLpl/UHPDeUVFn+yFLoVNF2eG/zaItVvhXBz/USGtGn0tWP8jzWxW1tc5NcpDR4loDE
 tV+SHCQStC3euGX29I+YNoKvLwPitLjY/nz57ND69BfPSug0jZJfOADTu+Kgv4399caW
 rUPAy5eec1RzRP43+Ie8SojBdlYzkNUYZmzoJ8BolKDm6alX8XOFdY3Uh23/4HcYyTxp
 DSLTZBG7gUuFwAEj9dXKBxiFt/OLZSZ78N6vjt2JQnbX2BsWzCUHrQkDdaNCMC4bFgow
 pyEA==
X-Gm-Message-State: APjAAAWe+LlW6JtAo2nHz+jCD4nJRmdHD4WJTa4XGVhmfVp0ixVRXYrS
 zljPmBQgrT98HacPmKP2iSk=
X-Google-Smtp-Source: APXvYqzpr7+soC88RxPYkNyZYtMthvTIpSEK08fizHS2QFw+nyJ6oh2LedrJ0Q1T9/RiI7/tvHdC9w==
X-Received: by 2002:a0c:98e9:: with SMTP id g38mr3959038qvd.187.1565110935641; 
 Tue, 06 Aug 2019 10:02:15 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c7:5ef4:7266:b7a7:9def:f8fc?
 ([2804:431:c7c7:5ef4:7266:b7a7:9def:f8fc])
 by smtp.gmail.com with ESMTPSA id y194sm39653199qkb.111.2019.08.06.10.02.14
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Aug 2019 10:02:15 -0700 (PDT)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190628194512.21311-1-danielhb413@gmail.com>
 <20190628194512.21311-2-danielhb413@gmail.com>
 <20190802160731.GF6379@localhost.localdomain>
 <92e47934-88e0-5734-fa35-56ecd700e1d7@gmail.com>
 <20190806152112.GC5849@localhost.localdomain>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <4e9d7a8a-2ce1-d696-f57b-8e0effd09014@gmail.com>
Date: Tue, 6 Aug 2019 14:02:11 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806152112.GC5849@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: Re: [Qemu-devel] [PATCH v4 1/4] block: introducing
 'bdrv_co_delete_file' interface
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
Cc: jsnow@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/6/19 12:21 PM, Kevin Wolf wrote:
> Am 06.08.2019 um 15:27 hat Daniel Henrique Barboza geschrieben:
>>>> diff --git a/block.c b/block.c
>>>> index c139540f2b..6e2b0f528d 100644
>>>> --- a/block.c
>>>> +++ b/block.c
>>>> @@ -621,6 +621,17 @@ int get_tmp_filename(char *filename, int size)
>>>>    #endif
>>>>    }
>>>> +/**
>>>> + * Helper that checks if a given string represents a regular
>>>> + * local file.
>>>> + */
>>>> +bool bdrv_path_is_regular_file(const char *path)
>>>> +{
>>>> +    struct stat st;
>>>> +
>>>> +    return (stat(path, &st) == 0) && S_ISREG(st.st_mode);
>>>> +}
>>>> +
>>>>    /*
>>>>     * Detect host devices. By convention, /dev/cdrom[N] is always
>>>>     * recognized as a host CDROM.
>>> This hunk isn't generic, it belong in file-posix.c
>> Patch 3 uses this function as part of the core logic of this fix (do not
>> delete the file if the file already existed) inside block/cryptoc. This
>> is the reason it is exposed here. I assumed that we do not want a
>> public function inside file-posix.c (since there is none - everything
>> is done using the BD interfaces).
> Hm... This doesn't feel right. crypto can't assume that it's working on
> a local file. It's working on some lower level BlockDriverState,
> whatever that may be. Remember that you could pass all kind of URLs e.g.
> for network protocols like NBD or gluster. You don't want to check
> whether a local filename exists then.
>
> In fact, I'm not sure if having a special case for an already existing
> file is even worth it: By the time we fail, we'll already have truncated
> the file, so the old data is lost anyway. Deleting that empty or
> half-initialised file doesn't seem much worse than leaving a broken file
> behind.

Makes sense. I'll use your argument to justify not handling this 'file
already exists' scenario and simply delete the file in the fail scenario
inside block_crypto_co_create_opts_luks. Then we can move this
path_is_regular_file function inside file-posix.c as you suggested.


>
> Kevin


