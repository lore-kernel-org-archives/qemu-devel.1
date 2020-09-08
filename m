Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9975DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CFE421D43
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUChqni2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFE421D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYrj-00016F-Bt
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 04:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFYlS-0006QM-PE
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:14:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59231
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFYlQ-0000WO-Oo
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599552843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wpgqHe7X0D0s6EE/jL295E8Ejo2SPhCQY5awtGHNuxQ=;
 b=VUChqni2x+ELD+qkUNKiiRK4hldwJGpKa5lsO1+XoPfN8jTFcOBWjxtIUY6D0zx+FruQyO
 1Jp1K+BObnug399z4Ae+lVZgalE9kUJ1g+8K2MdVt1M+UsFNFRvq79Z+elv8ihJyAFCc+m
 RdC0r9W4VfX7+ar8BGJTJE6/XWUWAW4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-wv1WTZD3Mxy35W9jl-V8NQ-1; Tue, 08 Sep 2020 04:13:59 -0400
X-MC-Unique: wv1WTZD3Mxy35W9jl-V8NQ-1
Received: by mail-wm1-f71.google.com with SMTP id l26so3194193wmg.7
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 01:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wpgqHe7X0D0s6EE/jL295E8Ejo2SPhCQY5awtGHNuxQ=;
 b=VH5Rekx7ZiWgTHMmVl65+pd8aNDhTR8G5k1GC3YsTuthjYdtAeWwa+O+JQov3GfCFf
 uZtZBJj5xNwsqMPz6TWD6b35ZCJWjYH7LvW1+aRqFSEAz+YeY1KEzOZhDoMGqKXdPoLp
 N2fAA27Tct8GbDc0S37gRcTpaUreHiZX7dH3trS0BOTioyrR/UTh7M4PxaQukH6/B2g/
 +ws21u/bCS7tpXw28bDygUNId/suA028z+wislWxas+6vKxq0pJxK2P0DV4Yw/eVYlaR
 THYaOJ07IPSxnKeRol77x+9aAQjJTYFnCgTPYukYLg97gET7aDjqthMsD+AzXye6wlwX
 1nYw==
X-Gm-Message-State: AOAM531vzltksGpsV4VwPfT1FD164XcjIhdGa6fj2gJ9eRynC3qzqqrf
 jWbD0qynDDWPJ6RApQkqi4gzwWAhTgaNm238vQQ5ahKtOypp4AVLlI6+K5qAiCleiVPvncrleVP
 dzbd/DlHj0o3z+Gc=
X-Received: by 2002:a7b:c92b:: with SMTP id h11mr3103893wml.6.1599552838482;
 Tue, 08 Sep 2020 01:13:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7uv5MW3KOjnRetYyCMa/WR3LXAgG3leEfeoeL9Qf9qIDwuFJ+DJ6T8oWuy+Z4el0kKaLOJQ==
X-Received: by 2002:a7b:c92b:: with SMTP id h11mr3103882wml.6.1599552838315;
 Tue, 08 Sep 2020 01:13:58 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id q12sm32468706wrs.48.2020.09.08.01.13.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 01:13:57 -0700 (PDT)
Subject: Re: [PATCH 01/10] Makefile: remove obsolete edk2 exception from
 "clean" rule
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
References: <20200908072939.30178-1-lersek@redhat.com>
 <20200908072939.30178-2-lersek@redhat.com>
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
Message-ID: <441bfbde-2751-a5a6-3c88-c810fbd303c5@redhat.com>
Date: Tue, 8 Sep 2020 10:13:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908072939.30178-2-lersek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.825, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/8/20 9:29 AM, Laszlo Ersek wrote:
> The file "BaseTools/Source/Python/UPT/Dll/sqlite3.dll" was removed in edk2
> commit 26e2b295ec7a ("BaseTools:Remove unused
> BaseTools\Source\Python\UPT\Dll", 2019-05-08), part of edk2-stable201905,
> so skipping it in the outermost in-tree "clean" rule is unnecessary.
> 
> Remove the obsolete pathname reference.
> 
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> Ref: https://bugs.launchpad.net/qemu/+bug/1852196
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  Makefile | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index ed354c43b0ba..485f56d336fe 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -201,7 +201,6 @@ clean: recurse-clean ninja-clean clean-ctlist
>  	find . \( -name '*.so' -o -name '*.dll' -o -name '*.[oda]' \) -type f \
>  		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-aarch64.a \
>  		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
> -		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
>  		-exec rm {} +
>  	rm -f TAGS cscope.* *.pod *~ */*~
>  	rm -f fsdev/*.pod scsi/*.pod
> 


