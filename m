Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEE5C47420
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B212085B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AN7Gd13o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B212085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNexC-0005GQ-9s
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 12:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNew3-0004fR-KG
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:26:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNew2-0004w0-0E
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:26:31 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601483189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=N8SVCDYg6PFdhgxm65ggSo6NUhbB7gDgeDLb2R3HdUE=;
 b=AN7Gd13oQlLt2JJylD9GIsPUBRFjnV2uqLQo1qcrGtXJ1EeQYWGG3Fhoy6ZwSlVkQfekJK
 vSEdknRJNo6g2VJyVcg29KE/IY7VhDFBFG37PGPM04/NN1pTb5v8NTSk+XvG/UZtQ7ujzT
 W7tCCbSaa9NS42RsIj6Z7c9TK1rIfe4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-GxFutCB5NB-pP9ZZnQRgMQ-1; Wed, 30 Sep 2020 12:25:08 -0400
X-MC-Unique: GxFutCB5NB-pP9ZZnQRgMQ-1
Received: by mail-wm1-f70.google.com with SMTP id t8so32050wmj.6
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 09:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=N8SVCDYg6PFdhgxm65ggSo6NUhbB7gDgeDLb2R3HdUE=;
 b=nqExrf6fWL8MPkavRzfG6cdM1bGfKle12z1kTCFbTUvDgoUsmB4HpLlOyDmqOgwj1M
 t87Cfd52jjbfZ4bFRP/qNiCE4dd7Hca72XdgII276D5qGeF+1UVATJJZoXHsJjtztWmM
 3v/IIe/zLbpQFPzC4ZuBQFtgh04feSAHhBJYenHi+Bpax/TJq6Cz37Id3j+z2KRTyWN5
 Tee8i+7ROhxTwhEI5YaG/vr9OES5FL4IUd3CMiXvjpEMtc4kaQreOjY27hJaZH3/CoNo
 JVG3rD5jcM0JItmBJnw/aCpWY01QgXwYjGX4Ac4GKC/MMeepAADd8bADg7iRxIcp6/3j
 jrdA==
X-Gm-Message-State: AOAM530Igt19H5o7ipPp9yjxuwQCSKgPj6bhSPdwzU38ZDXqM/SvmeJK
 dp7EEmDsrLWPUHxE3J/LVdzjg7kupOTtAvXRGKuAOZRSC1x7xmXZ4AueJ9aScWEIpwFrjKHh0ok
 59UOS75B5R2KtMzM=
X-Received: by 2002:adf:e907:: with SMTP id f7mr3977294wrm.169.1601483107085; 
 Wed, 30 Sep 2020 09:25:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcmb8To/ae7JApwknVKfYewjuOrTH/pfslFo9E/Ukw4WpHlCmBp9RIHjhM4iqqQZ/NH1yb7g==
X-Received: by 2002:adf:e907:: with SMTP id f7mr3977264wrm.169.1601483106764; 
 Wed, 30 Sep 2020 09:25:06 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id h76sm4167413wme.10.2020.09.30.09.25.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 09:25:06 -0700 (PDT)
Subject: Re: [PATCH 3/4] qemu-io-cmds: avoid gcc 10 warning
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
References: <20200930155859.303148-1-borntraeger@de.ibm.com>
 <20200930155859.303148-4-borntraeger@de.ibm.com>
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
Message-ID: <747cd7fd-53ea-8e72-9725-61f67d32f789@redhat.com>
Date: Wed, 30 Sep 2020 18:25:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930155859.303148-4-borntraeger@de.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 5:58 PM, Christian Borntraeger wrote:
> With gcc 10 on Fedora32 I do get:
> 
> Compiling C object libblock.fa.p/qemu-io-cmds.c.o
> In file included from /usr/include/stdio.h:867,
>                  from /home/cborntra/REPOS/qemu/include/qemu/osdep.h:85,
>                  from ../qemu-io-cmds.c:11:
> In function ‘printf’,
>     inlined from ‘help_oneline’ at ../qemu-io-cmds.c:2389:9,
>     inlined from ‘help_all’ at ../qemu-io-cmds.c:2414:9,
>     inlined from ‘help_f’ at ../qemu-io-cmds.c:2424:9:
> /usr/include/bits/stdio2.h:107:10: error: ‘%s’ directive argument is null [-Werror=format-overflow=]
>   107 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Let us check for null.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  qemu-io-cmds.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index baeae86d8c85..c2080aa398a9 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -2386,7 +2386,9 @@ static void help_oneline(const char *cmd, const cmdinfo_t *ct)
>      if (cmd) {
>          printf("%s ", cmd);
>      } else {
> -        printf("%s ", ct->name);
> +        if (ct->name) {
> +            printf("%s ", ct->name);
> +        }
>          if (ct->altname) {
>              printf("(or %s) ", ct->altname);
>          }
> 

This one has been fixed last month:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg732728.html

Then queued recently:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg745394.html


