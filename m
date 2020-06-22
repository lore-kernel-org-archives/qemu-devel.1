Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2151C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:17:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE97D20675
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2WcQ9CG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE97D20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnJWW-0003nN-1Q
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 06:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnJTl-0001BR-Kl
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:15:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60892
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnJTj-0000nJ-IA
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592820902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4YVoT+3J1q1vx0VdtUzgkPmVz3LPW5cTTx/GWKxpQcQ=;
 b=S2WcQ9CGD8V/eTEYNtf4vUg/b+A8NabDlxZBT3o1rGOqi+0febiAmg/nEul99PX5QaHIhp
 VIOGxVMYE9JzTvmZaogj1fmwbqxyMp6nl+G3hFv7uGSH2nGAW2m6m3Ql07KKRPcSvTLwhi
 FbdhjLAme+evcdMSnQ1JfwNb4ejCZWs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-y_imuVGiOqe2P5Tk5b2qRQ-1; Mon, 22 Jun 2020 06:15:00 -0400
X-MC-Unique: y_imuVGiOqe2P5Tk5b2qRQ-1
Received: by mail-wm1-f71.google.com with SMTP id p24so6645980wma.4
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 03:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4YVoT+3J1q1vx0VdtUzgkPmVz3LPW5cTTx/GWKxpQcQ=;
 b=L02RVv6NxE1hKWZFCc0cd4RgcYrhrEb0gmi5hM0xJ8GOY3HvjJ/BJYCj4j2weD2Z95
 ziGqm0ONzBK42js74kTSSgaJJhH71q7y9pxBGJzcwchjb+9nqLA7lV+l1eFyd4gLjnyw
 YsSIC18tMIqYzAa0aYzLw6PdNhxAxdF55dNGAcZgjoDnxuIsse71YRJbAiL9dPPO6R2j
 gaQmZXIIu6pnvTERACXa3BDQTKNWb34nDPnSYXm0ZqnHnNYmLSCQdZAZgqpQKa7GsjZ8
 z4KUFSpRNrQvJP1BdDH6heQ5VaH/FhsI0qNh/fyc8vWfdMHbCuNjs2AslneRCTog9Tz6
 2o2g==
X-Gm-Message-State: AOAM5333ExZf/Ql6nojxOLwjC1rjSQWqKxeBCIQv2q2kiM+dEFgs+k8W
 GRKuQM5EusHBhlt3+hhpG6gnkp/O4fxFQv537QQ+qHZ14DoRAghnL18QzX0+l2d57CdAtnnsQL9
 xv7IcbfcMUisAw+k=
X-Received: by 2002:adf:f7c6:: with SMTP id a6mr11159080wrq.355.1592820899471; 
 Mon, 22 Jun 2020 03:14:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVeiYicOpT3Vg+X0VNMUsoKm63hDNmh4olGs+AhyDzTmWcdcR/clNtAyepqE7lhGhVGEAy/g==
X-Received: by 2002:adf:f7c6:: with SMTP id a6mr11159058wrq.355.1592820899195; 
 Mon, 22 Jun 2020 03:14:59 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id n1sm17087458wrp.10.2020.06.22.03.14.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 03:14:58 -0700 (PDT)
Subject: Re: [PATCH] qga: Use gethostname() instead of g_get_host_name()
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
References: <8e73f685e10c684eb5e2c88c2185504d26f024fc.1592296355.git.mprivozn@redhat.com>
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
Message-ID: <7e31a988-7d6f-7bc5-3563-e77efff87ca3@redhat.com>
Date: Mon, 22 Jun 2020 12:14:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8e73f685e10c684eb5e2c88c2185504d26f024fc.1592296355.git.mprivozn@redhat.com>
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
Cc: vfeenstr@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michal,

On 6/16/20 10:34 AM, Michal Privoznik wrote:
> Problem with g_get_host_name() is that on the first call it saves
> the hostname into a global variable and from then on, every
> subsequent call returns the saved hostname. Even if the hostname
> changes. This doesn't play nicely with guest agent, because if
> the hostname is acquired before the guest is set up (e.g. on the
> first boot, or before DHCP) we will report old, invalid hostname.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1845127
> 
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  qga/commands.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/qga/commands.c b/qga/commands.c
> index efc8b90281..ce3c2041a6 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -512,14 +512,62 @@ int ga_parse_whence(GuestFileWhence *whence, Error **errp)
>      return -1;
>  }
>  
> +#ifndef HOST_NAME_MAX
> +# ifdef _POSIX_HOST_NAME_MAX
> +#  define HOST_NAME_MAX _POSIX_HOST_NAME_MAX
> +# else
> +#  define HOST_NAME_MAX 255
> +# endif
> +#endif
> +
>  GuestHostName *qmp_guest_get_host_name(Error **errp)
>  {
>      GuestHostName *result = NULL;
> -    gchar const *hostname = g_get_host_name();
> -    if (hostname != NULL) {
> -        result = g_new0(GuestHostName, 1);
> -        result->host_name = g_strdup(hostname);
> +    g_autofree char *hostname = NULL;
> +
> +    /*
> +     * We want to avoid using g_get_host_name() because that
> +     * caches the result and we wouldn't reflect changes in the
> +     * host name.
> +     */

I see there is only one g_get_host_name() call in the
codebase, but can we have a generic qemu_get_host_name()
helper implemented in util/oslib-*c instead?

> +
> +#ifndef G_OS_WIN32
> +    long len = -1;
> +
> +#ifdef _SC_HOST_NAME_MAX
> +    len = sysconf(_SC_HOST_NAME_MAX);
> +#endif /* _SC_HOST_NAME_MAX */
> +
> +    if (len < 0) {
> +        len = HOST_NAME_MAX;
>      }
> +
> +    hostname = g_malloc0(len + 1);
> +
> +    if (gethostname(hostname, len) < 0) {
> +        return NULL;
> +    }
> +
> +#else /* G_OS_WIN32 */
> +
> +    wchar_t tmp[MAX_COMPUTERNAME_LENGTH + 1];
> +    DWORD size = G_N_ELEMENTS(tmp);
> +
> +    if (GetComputerNameW(tmp, &size) != 0) {
> +        /*
> +         * Indeed, on Windows retval of zero means failure
> +         * and nonzero means success.
> +         */
> +        hostname = g_utf16_to_utf8(tmp, size, NULL, NULL, NULL);
> +    }
> +#endif /* G_OS_WIN32 */
> +
> +    if (!hostname) {
> +        hostname = g_strdup("localhost");
> +    }
> +
> +    result = g_new0(GuestHostName, 1);
> +    result->host_name = g_steal_pointer(&hostname);
>      return result;
>  }
>  
> 


