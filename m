Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E261DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 13:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AECEA2074B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 13:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RV87th60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AECEA2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjjnL-0006rr-Ql
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 09:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjjlt-0005Ws-Ns
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 09:31:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23835
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjjln-0003Y7-T3
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 09:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591968654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=teRKqjh/dPu2cClbbEJpLtQ/iufZd7M3Suji0paTUww=;
 b=RV87th60MCSDrYZClepvJQzAFfjfINXl3+6gnZ2/E+n9XkiG5ApoieaywbJbXT0zZ9pVcm
 08nG0WRD9nw86IPjOiVzrerEPZQMLxCdrbmPNY2Z7Zbfxs64oJUfRnZYJkiu/5giIs1Nmm
 Tpq9LzgQUXA81y+xv+0gHC3R71KSmY0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-CXX5asJcPMeZPXcEWDHRtg-1; Fri, 12 Jun 2020 09:30:52 -0400
X-MC-Unique: CXX5asJcPMeZPXcEWDHRtg-1
Received: by mail-wm1-f71.google.com with SMTP id h6so1954262wmb.7
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 06:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=teRKqjh/dPu2cClbbEJpLtQ/iufZd7M3Suji0paTUww=;
 b=qFM1VinOmEXB5lGOkl1OWUph3cnrluvnozzQSCHk+Bp1+o5swUxOU7Qj/wlRbCRHXH
 8EL059EFYRq8CVv7ICum5ADwHz26x4lfaCcn9wlj2z89XnIS/XVDYWhu8GuczAn65Xz9
 e2xD3gpD3A5XMtbK4SN8gMaNgaOte7W0JZ+OH4XXLuFl/2/C2yqUQtB0vwAthIPfVtB/
 uhQLH1BL8lj+Z2z3LOtoXXtdgpG+e6xVgnlslD3P9c2Pdwnnf2KSXEw50H+eR6BLqo4N
 MfdATitof6W2UqXdx5d2Asep6FtsPUWsIsoujASnxw2vE4+awwDXMzG5+x1xL+H+JaWh
 i3xA==
X-Gm-Message-State: AOAM532iWfVKCWuBNN+NLG9zMxqa9peBrGwak3VMtrA1LedT2wv76yVD
 8vFwnauJrdmcHPxhyH7g0Mwacxtg13TyaiX0OiHupuwyxTlrkqbIwwuQ10JVzym+2LS4q7WK9LR
 SFUXdWUx7mKW/RoU=
X-Received: by 2002:a5d:4484:: with SMTP id j4mr14694626wrq.325.1591968651514; 
 Fri, 12 Jun 2020 06:30:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7VbPrXSUJVbHmzBfMwCmzc9ONcoEmfExtvPK7Y38J080KPoMRl3Neqg17kPLFa00SXPmCww==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr14694583wrq.325.1591968651134; 
 Fri, 12 Jun 2020 06:30:51 -0700 (PDT)
Received: from [192.168.1.40] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id d5sm10728700wrb.14.2020.06.12.06.30.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2020 06:30:50 -0700 (PDT)
Subject: Re: [PATCH] .gitignore: Ignore storage-daemon files
To: Roman Bolshakov <r.bolshakov@yadro.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200612105830.17082-1-r.bolshakov@yadro.com>
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
Message-ID: <b87e42b4-6436-672e-24b8-7b650002625e@redhat.com>
Date: Fri, 12 Jun 2020 15:30:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200612105830.17082-1-r.bolshakov@yadro.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:26
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
Cc: qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Markus (qapi)

On 6/12/20 12:58 PM, Roman Bolshakov wrote:
> The files are generated.
> 
> Fixes: 2af282ec51a ("qemu-storage-daemon: Add --monitor option")
> Cc: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  .gitignore | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index 0c5af83aa7..90acb4347d 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -34,18 +34,18 @@
>  /qapi/qapi-builtin-types.[ch]
>  /qapi/qapi-builtin-visit.[ch]
>  /qapi/qapi-commands-*.[ch]
> -/qapi/qapi-commands.[ch]
> -/qapi/qapi-emit-events.[ch]
> +**/qapi/qapi-commands.[ch]
> +**/qapi/qapi-emit-events.[ch]
>  /qapi/qapi-events-*.[ch]
> -/qapi/qapi-events.[ch]
> -/qapi/qapi-init-commands.[ch]
> -/qapi/qapi-introspect.[ch]
> +**/qapi/qapi-events.[ch]
> +**/qapi/qapi-init-commands.[ch]
> +**/qapi/qapi-introspect.[ch]
>  /qapi/qapi-types-*.[ch]
> -/qapi/qapi-types.[ch]
> +**/qapi/qapi-types.[ch]
>  /qapi/qapi-visit-*.[ch]
>  !/qapi/qapi-visit-core.c
> -/qapi/qapi-visit.[ch]
> -/qapi/qapi-doc.texi
> +**/qapi/qapi-visit.[ch]
> +**/qapi/qapi-doc.texi
>  /qemu-edid
>  /qemu-img
>  /qemu-nbd
> @@ -59,6 +59,7 @@
>  /qemu-keymap
>  /qemu-monitor.texi
>  /qemu-monitor-info.texi
> +/qemu-storage-daemon
>  /qemu-version.h
>  /qemu-version.h.tmp
>  /module_block.h
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


