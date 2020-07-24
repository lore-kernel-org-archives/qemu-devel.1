Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADFBC433E8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC16820674
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+/2PoFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC16820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyyqE-00039c-2q
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 10:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyypT-0002ZB-Qy
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:37:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55824
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyypR-0005QT-DF
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595601460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CxxYXq0Ya5G8OlkLF9LEQENDau11QrFUsrQIbA2S5FA=;
 b=Z+/2PoFXjUnU87Dzor/XqyRND2EfVRHdfJOeg1Mlaxcm62qXh20qdEhrCatPMI2FA/X2A8
 yzTDZPT0CBKDH3OnrMX6871HmyI8OpX+RBfId83vMAUVVQPPY2X9LtSQgN7LYz3mWqnpkI
 zLimvZLhDbLLNefZopFWUdFnhpfc4ng=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-26cMZVEvP-eiMTNWSdAsoQ-1; Fri, 24 Jul 2020 10:37:38 -0400
X-MC-Unique: 26cMZVEvP-eiMTNWSdAsoQ-1
Received: by mail-wr1-f70.google.com with SMTP id a18so2223204wrm.14
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 07:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=CxxYXq0Ya5G8OlkLF9LEQENDau11QrFUsrQIbA2S5FA=;
 b=kPdVOal6YS+8gvFK9HcV/h2qra0ay/ZOliLrBErZRkXk3rcj3cw5GhMrW/9hi3HwVP
 l7jXStV/LdjLm/Gk5dMUK/+MBkvR6W5/SeJHeXNrptGuUmq2y6kPeq55+louf8xiItQH
 JLs51hiM4O3eubGXPTS8N2d+PjUNdx1iIjXqHz4LDaYeUDn78pmvuNJjRNbAfMu8PyRf
 VPezhKKaKc9kfRfYRW6WCrY+seQiFWbGCX2TILw4FiQ6Uy9g3M/n2PmKG5QgvL/r6aQv
 +akIT3L8r9Mb8tfzH+s9p4bngrsA0O+vJDiI75GRo93D6GyDTp/WAhJbr6tGuWL3RqOK
 aQ2A==
X-Gm-Message-State: AOAM531V9GTNIcflK+6UX6NX8ssTEI5/WWKtm76jRALqezdLr7JjZcc8
 dcH4EocDfhOQg12UpMbsYE22WB14NFQiB62O+q/roD5T+kvA1VSB5rmZFiGExoMAs/SitvcadbE
 CQm1auFZq058ZHnU=
X-Received: by 2002:adf:fb06:: with SMTP id c6mr8678646wrr.261.1595601457300; 
 Fri, 24 Jul 2020 07:37:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxebtFaN/kD4Fcy6l2ocVNMyDOiycLGO+GrvCCOB2A6icDGrV79+YSdB39EEywuy/CRP8+FZQ==
X-Received: by 2002:adf:fb06:: with SMTP id c6mr8678625wrr.261.1595601457045; 
 Fri, 24 Jul 2020 07:37:37 -0700 (PDT)
Received: from [192.168.1.33] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id c25sm7141869wml.46.2020.07.24.07.37.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 07:37:36 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] block: switch to use qemu_open/qemu_create for
 improved errors
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200724132510.3250311-1-berrange@redhat.com>
 <20200724132510.3250311-5-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <ee219d91-d359-8034-bd87-1f980baa5bdd@redhat.com>
Date: Fri, 24 Jul 2020 16:37:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200724132510.3250311-5-berrange@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:55:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/24/20 3:25 PM, Daniel P. Berrangé wrote:
> Currently at startup if using cache=none on a filesystem lacking
> O_DIRECT such as tmpfs, at startup QEMU prints
> 
> qemu-system-x86_64: -drive file=/tmp/foo.img,cache=none: file system may not support O_DIRECT
> qemu-system-x86_64: -drive file=/tmp/foo.img,cache=none: Could not open '/tmp/foo.img': Invalid argument
> 
> while at QMP level the hint is missing, so QEMU reports just
> 
>   "error": {
>       "class": "GenericError",
>       "desc": "Could not open '/tmp/foo.img': Invalid argument"
>   }
> 
> which is close to useless for the end user trying to figure out what
> they did wrong.
> 
> With this change at startup QEMU prints
> 
> qemu-system-x86_64: -drive file=/tmp/foo.img,cache=none: Unable to open '/tmp/foo.img' flags 0x4000: filesystem does not support O_DIRECT
> 
> while at the QMP level QEMU reports a massively more informative
> 
>   "error": {
>      "class": "GenericError",
>      "desc": "Unable to open '/tmp/foo.img' flags 0x4002: filesystem does not support O_DIRECT"
>   }
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  block/file-posix.c            | 18 +++++++-----------
>  block/file-win32.c            |  6 ++----
>  tests/qemu-iotests/051.out    |  4 ++--
>  tests/qemu-iotests/051.pc.out |  4 ++--
>  tests/qemu-iotests/061.out    |  2 +-
>  tests/qemu-iotests/069.out    |  2 +-
>  tests/qemu-iotests/082.out    |  4 ++--
>  tests/qemu-iotests/111.out    |  2 +-
>  tests/qemu-iotests/226.out    |  6 +++---
>  tests/qemu-iotests/232.out    | 12 ++++++------
>  tests/qemu-iotests/244.out    |  6 +++---
>  11 files changed, 30 insertions(+), 36 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index bac2566f10..c63926d592 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -630,11 +630,10 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
>      raw_parse_flags(bdrv_flags, &s->open_flags, false);
>  
>      s->fd = -1;
> -    fd = qemu_open_old(filename, s->open_flags, 0644);
> +    fd = qemu_open(filename, s->open_flags, errp);
>      ret = fd < 0 ? -errno : 0;
>  
>      if (ret < 0) {
> -        error_setg_file_open(errp, -ret, filename);
>          if (ret == -EROFS) {
>              ret = -EACCES;
>          }
> @@ -1032,15 +1031,13 @@ static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
>          }
>      }
>  
> -    /* If we cannot use fcntl, or fcntl failed, fall back to qemu_open_old() */
> +    /* If we cannot use fcntl, or fcntl failed, fall back to qemu_open() */
>      if (fd == -1) {
>          const char *normalized_filename = bs->filename;
>          ret = raw_normalize_devicepath(&normalized_filename, errp);
>          if (ret >= 0) {
> -            assert(!(*open_flags & O_CREAT));
> -            fd = qemu_open_old(normalized_filename, *open_flags);
> +            fd = qemu_open(normalized_filename, *open_flags, errp);
>              if (fd == -1) {
> -                error_setg_errno(errp, errno, "Could not reopen file");
>                  return -1;
>              }
>          }
> @@ -2411,10 +2408,9 @@ raw_co_create(BlockdevCreateOptions *options, Error **errp)
>      }
>  
>      /* Create file */
> -    fd = qemu_open_old(file_opts->filename, O_RDWR | O_CREAT | O_BINARY, 0644);
> +    fd = qemu_create(file_opts->filename, O_RDWR | O_BINARY, 0644, errp);
>      if (fd < 0) {
>          result = -errno;
> -        error_setg_errno(errp, -result, "Could not create file");
>          goto out;
>      }
[...]

Nice :)

I haven't checked the iotest errors; assuming a CI will take care of it:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


