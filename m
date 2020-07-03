Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F51C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1801221531
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVlfRVBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1801221531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNiC-0006zL-Az
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrNcl-0000eA-Hf
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:29:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40728
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrNcj-0006p0-Sj
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593790149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LOB0SWEuMVyGY4su8Kj1BvaONtT+bGp5fFHzTY7W+ks=;
 b=OVlfRVBlUrPiKJ6bYG7cwq/1XTY4gNU88Vjq2DMaqriLkzm51aKk7tD+fG0VW8G2j1Lxpa
 25SMBPUvDayzSI11FZRBGkY625qKgU0nKW/rCkZGa4D/Oof5YJB75qLYPDPzx66TFbhNT4
 LmDklCxVA/mfd4zZXpJyzQgZPAx+1gM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-ldl8eqaDPqaIJTsyCKuggg-1; Fri, 03 Jul 2020 11:29:07 -0400
X-MC-Unique: ldl8eqaDPqaIJTsyCKuggg-1
Received: by mail-wm1-f71.google.com with SMTP id o13so35408505wmh.9
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 08:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=LOB0SWEuMVyGY4su8Kj1BvaONtT+bGp5fFHzTY7W+ks=;
 b=giLC8wXxRWj1BpHjAfpT5SEV+fYlHNgfQdg8My1tzf8UPh57DdrXHhuLWpL7CoSOHN
 ON+KRNJE6iXvKxWcMZ80i6+6oDiNfH4egja2cXJFgZEK9ws/o4zlX/uPwwgWx4c4chkM
 aUL9ZauO0lWAnc6IGP+NJRRdk3K8fjjRmp78eh92cc8rig5n6kfTxKWWYSZSjTItxlAE
 Uy6nn1HNbe3+4lK67ZAOT7Tw97MKNKHoYdeVRiVRnHBVEaHoQLdDV1YeCxpEYN6ed61I
 D2Qx6tMgwUTyzLYRwt5TONGL2dPZFcs2eRlGdY2meb0Ov4k8ENq9/4Q9HD8v7KJHdPbY
 FMkA==
X-Gm-Message-State: AOAM533/UvTP8r0jnLOX7LzYZyKE7Idfgv6NlLdumE84U0bPoHGZVySW
 DJj3CDwn/lpZPZ35vuk7pnzza4ScgYqz8FnZoXIsJGXaR6O2aQpQHpQd+V8tYuslDqQUrcO8LQy
 QQmg5CfASgwS8IyY=
X-Received: by 2002:adf:e2c9:: with SMTP id d9mr37004153wrj.227.1593790146757; 
 Fri, 03 Jul 2020 08:29:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwqqFCXkNU5EL4shCPl+cvnlxqswnUQzjo8ouZMyuNQtVv6wUp6tFeIYV9CzQjR3byAXIm+Q==
X-Received: by 2002:adf:e2c9:: with SMTP id d9mr37004140wrj.227.1593790146558; 
 Fri, 03 Jul 2020 08:29:06 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 14sm13383766wmk.19.2020.07.03.08.29.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 08:29:06 -0700 (PDT)
Subject: Re: [PATCH v3 7/9] util/compatfd.c: Only include <sys/syscall.h> if
 CONFIG_SIGNALFD
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200703145614.16684-1-peter.maydell@linaro.org>
 <20200703145614.16684-8-peter.maydell@linaro.org>
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
Message-ID: <4da522b2-1843-cd51-6c91-8b9e7402050b@redhat.com>
Date: Fri, 3 Jul 2020 17:29:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200703145614.16684-8-peter.maydell@linaro.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
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
Cc: David Carlier <devnexen@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 4:56 PM, Peter Maydell wrote:
> From: David CARLIER <devnexen@gmail.com>
> 
> util/compatfd.c includes <sys/syscall.h> so that the CONFIG_SIGNALFD
> code can use SYS_signalfd. Guard the #include with CONFIG_SIGNALFD
> to avoid portability issues on hosts like Haiku which do not
> provide that header file.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> [PMM: Expanded commit message]
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  util/compatfd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/util/compatfd.c b/util/compatfd.c
> index c296f55d148..ee47dd80897 100644
> --- a/util/compatfd.c
> +++ b/util/compatfd.c
> @@ -16,7 +16,9 @@
>  #include "qemu/osdep.h"
>  #include "qemu/thread.h"
>  
> +#if defined(CONFIG_SIGNALFD)

Most of the code base guards <sys/syscall.h> with '#ifdef CONFIG_LINUX',
bsd-user/strace.c is the BSD exception.

CONFIG_SIGNALFD guards SYS_signalfd.

>  #include <sys/syscall.h>
> +#endif
>  
>  struct sigfd_compat_info
>  {
> 


