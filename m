Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BA5C433EA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B71206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrNY4vZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B71206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyyn9-0000kA-98
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 10:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyylm-00078C-Uf
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:33:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57717
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyyll-0004hU-24
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595601232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MIQ0bIU6co+XtiZGTirpJi6eFCfpeQM/nYgl/kbu4zc=;
 b=UrNY4vZRyxPjjMO3rSs99U2Rw+j5bs8SkEM/gIkx/XkIKJuSsn/1awdQR6zbhlwptsvPKm
 apZizYrMXEGDlW8zcdHhKFY1AFKsMD71qqLrcUT2Hr3Ad2QJcV334pHW9QgVL20yyRFkkE
 2GHbHmaRsQkoR+WqnanBxEB6a3WGAIY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-VIaGVqeHNwuoxeAfblpM0g-1; Fri, 24 Jul 2020 10:33:50 -0400
X-MC-Unique: VIaGVqeHNwuoxeAfblpM0g-1
Received: by mail-wr1-f71.google.com with SMTP id 89so2205236wrr.15
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 07:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=MIQ0bIU6co+XtiZGTirpJi6eFCfpeQM/nYgl/kbu4zc=;
 b=pqDFS2gytcq90kGzm1O2293mOaxoK9E+MOoFKoUNbAYNf1b0oyPAwNRMsyh78HVBaD
 /WKhpqv8QocGmzU+9B81CvstP/S260f5wfl3eRZythp/tb0ZuA2/UU2uNr2Z0fnDr2uO
 kbG0gkoWvbvn5XuDTk3r1Aqt00PvcZzbTXW6U62yQTOZ+FPMKOdeQt7WeaOonNB+ficK
 qkJhSijkYjK1vJ8xe+jN0CTklzeEmtVbCZyqPjeoF5I38lUoZr8XeNawdk4wSHBr75Bv
 Ax1v5rc4LcIgnQs6huVrW596j5kfb+t7uh0QTSrqztvjmREDDzQJArf/R9N2YrfzfCu6
 58lQ==
X-Gm-Message-State: AOAM5324+T3hBzbQI/SLx6vke9h4R6yqH2QnQ037gWCUMS3RDmrVVi1v
 kL+UDZEZG4pruuCbdc8cUu8w5L7X6aXt43CHgKFkyYDTBf+UUP9iItLzEX6Ay2kAeFlLOwIOreZ
 fMRbns59nOq/H7jI=
X-Received: by 2002:adf:94a1:: with SMTP id 30mr8483823wrr.37.1595601229319;
 Fri, 24 Jul 2020 07:33:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDxXOS/Mg4TvPOR2KqRcN4gKyTQpOwBfTpPXW3Bq76kNnSfTYmWpphRUWx2ec83hUVKpqrdA==
X-Received: by 2002:adf:94a1:: with SMTP id 30mr8483800wrr.37.1595601229043;
 Fri, 24 Jul 2020 07:33:49 -0700 (PDT)
Received: from [192.168.1.33] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id u16sm7439854wmn.11.2020.07.24.07.33.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 07:33:48 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] util: introduce qemu_open and qemu_create with
 error reporting
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200724132510.3250311-1-berrange@redhat.com>
 <20200724132510.3250311-3-berrange@redhat.com>
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
Message-ID: <cf17b9eb-e510-b8ff-cf17-b7eb474048a7@redhat.com>
Date: Fri, 24 Jul 2020 16:33:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200724132510.3250311-3-berrange@redhat.com>
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
> This introduces two new helper metohds
> 
>   int qemu_open(const char *name, int flags, Error **errp);
>   int qemu_create(const char *name, int flags, mode_t mode, Error **errp);
> 
> Note that with this design we no longer require or even accept the
> O_CREAT flag. Avoiding overloading the two distinct operations
> means we can avoid variable arguments which would prevent 'errp' from
> being the last argument. It also gives us a guarantee that the 'mode' is
> given when creating files, avoiding a latent security bug.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  include/qemu/osdep.h |  6 ++++
>  util/osdep.c         | 78 ++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 71 insertions(+), 13 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 3a16e58932..ca24ebe211 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -494,7 +494,13 @@ int qemu_madvise(void *addr, size_t len, int advice);
>  int qemu_mprotect_rwx(void *addr, size_t size);
>  int qemu_mprotect_none(void *addr, size_t size);
>  
> +/*
> + * Don't introduce new usage of this function, prefer the following
> + * qemu_open/qemu_create that take a "Error **errp"
> + */
>  int qemu_open_old(const char *name, int flags, ...);
> +int qemu_open(const char *name, int flags, Error **errp);
> +int qemu_create(const char *name, int flags, mode_t mode, Error **errp);
>  int qemu_close(int fd);
>  int qemu_unlink(const char *name);
>  #ifndef _WIN32
> diff --git a/util/osdep.c b/util/osdep.c
> index 9df1b6adec..5c0f4684b1 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -22,6 +22,7 @@
>   * THE SOFTWARE.
>   */
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  
>  /* Needed early for CONFIG_BSD etc. */
>  
> @@ -282,10 +283,10 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
>  /*
>   * Opens a file with FD_CLOEXEC set
>   */
> -int qemu_open_old(const char *name, int flags, ...)
> +static int
> +qemu_open_internal(const char *name, int flags, mode_t mode, Error **errp)
>  {
>      int ret;
> -    int mode = 0;
>  
>  #ifndef _WIN32
>      const char *fdset_id_str;
> @@ -297,24 +298,31 @@ int qemu_open_old(const char *name, int flags, ...)
>  
>          fdset_id = qemu_parse_fdset(fdset_id_str);
>          if (fdset_id == -1) {
> +            error_setg(errp, "Could not parse fdset %s", name);
>              errno = EINVAL;
>              return -1;
>          }
>  
>          fd = monitor_fdset_get_fd(fdset_id, flags);
>          if (fd < 0) {
> +            error_setg_errno(errp, -fd, "Could not acquire FD for %s flags %x",
> +                             name, flags);
>              errno = -fd;
>              return -1;
>          }
>  
>          dupfd = qemu_dup_flags(fd, flags);
>          if (dupfd == -1) {
> +            error_setg_errno(errp, errno, "Could not dup FD for %s flags %x",
> +                             name, flags);
>              return -1;
>          }
>  
>          ret = monitor_fdset_dup_fd_add(fdset_id, dupfd);
>          if (ret == -1) {
>              close(dupfd);
> +            error_setg(errp, "Could not save FD for %s flags %x",
> +                       name, flags);
>              errno = EINVAL;
>              return -1;
>          }
> @@ -323,22 +331,66 @@ int qemu_open_old(const char *name, int flags, ...)
>      }
>  #endif
>  
> -    if (flags & O_CREAT) {
> -        va_list ap;
> -
> -        va_start(ap, flags);
> -        mode = va_arg(ap, int);
> -        va_end(ap);
> -    }
> -
>  #ifdef O_CLOEXEC
> -    ret = open(name, flags | O_CLOEXEC, mode);
> -#else
> +    flags |= O_CLOEXEC;
> +#endif /* O_CLOEXEC */
> +
>      ret = open(name, flags, mode);
> +
> +#ifndef O_CLOEXEC
>      if (ret >= 0) {
>          qemu_set_cloexec(ret);
>      }
> -#endif
> +#endif /* ! O_CLOEXEC */
> +
> +    if (ret == -1) {
> +        const char *action = "open";
> +        if (flags & O_CREAT) {
> +            action = "create";
> +        }
> +        error_setg_errno(errp, errno, "Could not %s '%s' flags 0x%x",
> +                         action, name, flags);
> +    }
> +

NL--

> +
> +    return ret;
> +}
> +
> +
> +int qemu_open(const char *name, int flags, Error **errp)
> +{
> +    if (flags & O_CREAT) {
> +        error_setg(errp,
> +                   "Invalid O_CREAT flag passed to qemu_open, use qemu_create");
> +        return -1;
> +    }
> +    return qemu_open_internal(name, flags, 0, errp);
> +}
> +
> +
> +int qemu_create(const char *name, int flags, mode_t mode, Error **errp)
> +{
> +    if (flags & O_CREAT) {
> +        error_setg(errp, "Redundant O_CREAT flag passed to qemu_create");
> +        return -1;
> +    }
> +    return qemu_open_internal(name, flags | O_CREAT, mode, errp);
> +}
> +
> +

I'd rather see this patch split as:

- extract qemu_open_internal(const char *name, int flags, mode_t mode)
from qemu_open_old()

- Add Error **errp to qemu_open_internal()

- add qemu_open() and qemu_create()

Preferably split:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +int qemu_open_old(const char *name, int flags, ...)
> +{
> +    va_list ap;
> +    mode_t mode = 0;
> +    int ret;
> +
> +    va_start(ap, flags);
> +    if (flags & O_CREAT) {
> +        mode = va_arg(ap, int);
> +    }
> +    va_end(ap);
> +
> +    ret = qemu_open_internal(name, flags, mode, NULL);
>  
>  #ifdef O_DIRECT
>      if (ret == -1 && errno == EINVAL && (flags & O_DIRECT)) {
>


