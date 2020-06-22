Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BE9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:39:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF0C20738
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2Yl+elR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF0C20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnRM2-0006Ot-OC
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 14:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnRKH-0002W4-Rj
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 14:37:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52987
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnRKF-000060-Nl
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 14:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592851066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nt1GnSVQf/NCJiEbEKyHC6d7MSGvnzAEIdQQLJkM6QM=;
 b=C2Yl+elR3i/gansJtgEGZdfqSlRVrB4GTJCuE4xPHRU5tKsvABYw6xFwGmHinmN2hyvFZB
 +39A19nhAngzxB5842ZVT9G6ExCWKyW2z69A7FZnFrducVvHvqHDzvOMydAW74nHN9LkPp
 JPXfV4+8IQbIlxsU8IBJweYYFCGFkA8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-qTOR-_nCPXKY9JHCC_mdPg-1; Mon, 22 Jun 2020 14:37:44 -0400
X-MC-Unique: qTOR-_nCPXKY9JHCC_mdPg-1
Received: by mail-wm1-f72.google.com with SMTP id c66so270232wma.8
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 11:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=nt1GnSVQf/NCJiEbEKyHC6d7MSGvnzAEIdQQLJkM6QM=;
 b=mk4wsWeLLVe63kIlTOJ5DdQ3I1ukJY+y4GSZGiuH3ALncM/DIVi6323FKcvCbt+yp/
 vlBgHLzA/mw0jcArxwsWJLgJF9/PP4Usftjb9cBcpuav6dMRf+RF1hpG45h+KwWXMHp8
 5GxyWR2zJok8q9mhIqdmJpGmP80mqgqvb9Y2o09sC6djL7ci9wVClHCwC7XhmrH95ps4
 8r09BIPQ2WlQrNvJFKk+aKTX5dOAzhLXqA2oZmJR88mG99J3lBMACLUSMMdpaLGkwsza
 lClBaI33kTqvHF/wvLipf/2UorQcH+k3U7cUVxe+K9+mydxdUTDmCvRVszfTtt37K1Xg
 KR6w==
X-Gm-Message-State: AOAM532LCNHoSL7Fe/xMeqPEnAQPaL4T+2v5Jixs4kotjUGd9zuy2Znq
 5qy+IIKydJL2pUICRFzzDexFa0XlmJIrkxaqDV1mSFMdpCbKsgHc/FKmqeo5sO1hkn9Fy1/nk+F
 otpjaFUi/Rgl1fdE=
X-Received: by 2002:a5d:464e:: with SMTP id j14mr20533558wrs.393.1592851062827; 
 Mon, 22 Jun 2020 11:37:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxi37iaNLmyrmI3FvKHu+GZrc2j1eoAvzQa+52IYyYp8/AOvC6xHuvarubi6Jg8AUQx9dbW2A==
X-Received: by 2002:a5d:464e:: with SMTP id j14mr20533531wrs.393.1592851062586; 
 Mon, 22 Jun 2020 11:37:42 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f14sm1115965wro.90.2020.06.22.11.37.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 11:37:42 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] util: Introduce qemu_get_host_name()
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
References: <cover.1592849834.git.mprivozn@redhat.com>
 <02ebd01e1ff7b4aba70e58a674f457ec8e4cf20b.1592849834.git.mprivozn@redhat.com>
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
Message-ID: <151caec3-fbdf-10ff-34c7-39737c7f4d07@redhat.com>
Date: Mon, 22 Jun 2020 20:37:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <02ebd01e1ff7b4aba70e58a674f457ec8e4cf20b.1592849834.git.mprivozn@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
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

On 6/22/20 8:19 PM, Michal Privoznik wrote:
> This function offers operating system agnostic way to fetch host
> name. It is implemented for both POSIX-like and Windows systems.
> 
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>

Thanks for the updates!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/qemu/osdep.h | 10 ++++++++++
>  util/oslib-posix.c   | 35 +++++++++++++++++++++++++++++++++++
>  util/oslib-win32.c   | 13 +++++++++++++
>  3 files changed, 58 insertions(+)
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
> + */
> +char *qemu_get_host_name(Error **errp);
> +
>  #endif
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 916f1be224..3997ee0442 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -761,3 +761,38 @@ void sigaction_invoke(struct sigaction *action,
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
> +    g_autofree char *hostname = NULL;
> +
> +#ifdef _SC_HOST_NAME_MAX
> +    len = sysconf(_SC_HOST_NAME_MAX);
> +#endif /* _SC_HOST_NAME_MAX */
> +
> +    if (len < 0) {
> +        len = HOST_NAME_MAX;
> +    }
> +
> +    /* Unfortunately, gethostname() below does not guarantee a
> +     * NULL terminated string. Therefore, allocate one byte more
> +     * to be sure. */
> +    hostname = g_new0(char, len + 1);
> +
> +    if (gethostname(hostname, len) < 0) {
> +        error_setg_errno(errp, errno,
> +                         "cannot get hostname");
> +        return NULL;
> +    }
> +
> +    return g_steal_pointer(&hostname);
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


