Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F14C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9670920732
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRceRlx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9670920732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnQXh-0007FH-O1
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 13:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnQWP-0006Vm-DA
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 13:46:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40705
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnQWN-0000re-B7
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 13:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592847973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zXILthbnke/SQQxnodonfPYtSroyivxwwfSyA4Fr++s=;
 b=FRceRlx6VdM0P6wRt5Rye81d9VisejpttVq1cIICgF60kpf+mxEBXJMtJ2sMQkhc5n6Uj2
 kaK47OEmxhbW1uZQrJ74mvOCii/W2yxNYt91Bz2eqqCEUsjrd51OR1TUd1UcNb8y0ub3lx
 wj08XdzsotlqNzdSGRvFilxsiKIxXzU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-37qKJ67oMD-jkvQxaMIlbw-1; Mon, 22 Jun 2020 13:46:11 -0400
X-MC-Unique: 37qKJ67oMD-jkvQxaMIlbw-1
Received: by mail-wm1-f72.google.com with SMTP id c66so227399wma.8
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 10:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=zXILthbnke/SQQxnodonfPYtSroyivxwwfSyA4Fr++s=;
 b=M7bWX+uVWciuDGUXQQad3jnlWZ5If7gykeE5V5588JJlA0W3ZGopZ1YckpAHSvYNef
 dMlyEVOESloBrXRpODAOk7g46kyqazfzrDJ0RWRR1PBwg8GSvEhP56KBjfXBavfnpAVN
 sMe6nOSvfbDH1zMxCZTtGEuDDoBScDcy6JnDMuug1xjSDWREszLZCPkOazUJRO+rWsk7
 6lbkwN1rfsaUGDm+P1wKt/+qCGKARXwnJWvWLXx6Imxbr7JW/6ziRoP92MuqU92/EqIm
 WLWjr//d3mxGNwZt4x05t9sTrWANvc7s+5ONJd7+HkU5yFjaX8oYpS0sL3xnJoXQQV3v
 ZPSg==
X-Gm-Message-State: AOAM5304dXdwK6qz0n3XB1E4OKyhXGJaJXl0YJgUKu4aBlQ6fvYwhkd+
 I/eEmm2gWjT3rteiSa0CO1gUCBBCVHrt96GXVCvf83wXBNZraf7GTrRYaLZdcbSDfKpdi95kAaM
 4gg2sx0Gb4rjKh/c=
X-Received: by 2002:a5d:664a:: with SMTP id f10mr20361243wrw.300.1592847970204; 
 Mon, 22 Jun 2020 10:46:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwd/0rZJ9+nAbmMw37bxTDhx27K/Sw798fxKFFTpaY/vwdxVr1yJzdcd0q1oj2CMUiudI79fA==
X-Received: by 2002:a5d:664a:: with SMTP id f10mr20361215wrw.300.1592847969909; 
 Mon, 22 Jun 2020 10:46:09 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u74sm328909wmu.31.2020.06.22.10.46.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 10:46:09 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] util: Introduce qemu_get_host_name()
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
References: <cover.1592846572.git.mprivozn@redhat.com>
 <567f969602c1742e23c7760944e909346b2d012b.1592846572.git.mprivozn@redhat.com>
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
Message-ID: <16ab58fb-226d-5d25-19d6-c8d14b169aab@redhat.com>
Date: Mon, 22 Jun 2020 19:46:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <567f969602c1742e23c7760944e909346b2d012b.1592846572.git.mprivozn@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, sw@weilnetz.de, marcandre.lureau@gmail.com,
 vfeenstr@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 7:26 PM, Michal Privoznik wrote:
> This function offers operating system agnostic way to fetch host
> name. It is implemented for both POSIX-like and Windows systems.
> 
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  include/qemu/osdep.h | 10 ++++++++++
>  util/oslib-posix.c   | 32 ++++++++++++++++++++++++++++++++
>  util/oslib-win32.c   | 13 +++++++++++++
>  3 files changed, 55 insertions(+)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index ff7c17b857..a795d46b28 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -607,4 +607,14 @@ static inline void qemu_reset_optind(void)
>  #endif
>  }
>  
> +/**
> + * qemu_get_host_name:
> + * @errp: Error object
> + *
> + * Operating system agnostic way of querying host name.
> + *
> + * Returns allocated hostname (caller should free), NULL on failure.

free -> g_free?

> + */
> +char *qemu_get_host_name(Error **errp);
> +
>  #endif
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 916f1be224..865a3d71a7 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -761,3 +761,35 @@ void sigaction_invoke(struct sigaction *action,
>      }
>      action->sa_sigaction(info->ssi_signo, &si, NULL);
>  }
> +
> +#ifndef HOST_NAME_MAX
> +# ifdef _POSIX_HOST_NAME_MAX
> +#  define HOST_NAME_MAX _POSIX_HOST_NAME_MAX
> +# else
> +#  define HOST_NAME_MAX 255
> +# endif
> +#endif
> +
> +char *qemu_get_host_name(Error **errp)
> +{
> +    long len = -1;
> +    char *hostname;
> +
> +#ifdef _SC_HOST_NAME_MAX
> +    len = sysconf(_SC_HOST_NAME_MAX);
> +#endif /* _SC_HOST_NAME_MAX */
> +
> +    if (len < 0) {
> +        len = HOST_NAME_MAX;
> +    }
> +
> +    hostname = g_malloc0(len + 1);
> +
> +    if (gethostname(hostname, len) < 0) {
> +        error_setg_errno(errp, errno,
> +                         "cannot get hostname");

Missing:

           g_free(hostname);

> +        return NULL;
> +    }
> +
> +    return hostname;
> +}
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index e9b14ab178..3b49d27297 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -808,3 +808,16 @@ bool qemu_write_pidfile(const char *filename, Error **errp)
>      }
>      return true;
>  }
> +
> +char *qemu_get_host_name(Error **errp)
> +{
> +    wchar_t tmp[MAX_COMPUTERNAME_LENGTH + 1];
> +    DWORD size = G_N_ELEMENTS(tmp);
> +
> +    if (GetComputerNameW(tmp, &size) == 0) {
> +        error_setg_win32(errp, GetLastError(), "failed close handle");
> +        return NULL;
> +    }
> +
> +    return g_utf16_to_utf8(tmp, size, NULL, NULL, NULL);
> +}
> 


