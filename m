Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63518C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 242F1206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHV4MRO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242F1206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juuLE-0007gD-7n
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juuKA-0006b3-IP
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:00:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28144
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juuK7-0002vJ-RZ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594630830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bHaICCKOU/TxtVVNqMc29Q4jcoJsXcHbohOtzvJ4wEQ=;
 b=LHV4MRO71tWgtaGPoU9QE+quwU8SFOw95GP//1y4u2XWbR6PrlqUy2FWrfAo823B9n9phW
 shrJW2CIJiqZMBJsAHKbuRezWe78esjWtyonMV64e15naJspQK8vH/WZfcBEfbH80ulc2z
 xGBzHMJ4ix3EmtJyHA8beqVmvZULVoM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-1C6K8MOpN8Or4wOYz9YiAQ-1; Mon, 13 Jul 2020 05:00:26 -0400
X-MC-Unique: 1C6K8MOpN8Or4wOYz9YiAQ-1
Received: by mail-wm1-f72.google.com with SMTP id g138so17921358wme.7
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 02:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=bHaICCKOU/TxtVVNqMc29Q4jcoJsXcHbohOtzvJ4wEQ=;
 b=JelBK1/Fb8rw3Xa/weN45M3rfCkt/96lhjz1oNm3VOw0MUsAwy3+TbmfLqwpo3bLsi
 F1ty9knwOIRe4fLZdlrVAkIkkY7trZ3o4iz/FIsbXiGLa4hdSbKC+KClm9RglVPf6XkE
 f4iQa1uRuvnyJwwfg+dGWX/R2CKQ15/A65Ab7jqG4Iadh1P3DlJ9jmQMonODsvIGKXrL
 FgmFKjASWip/8P7pYYDwxyRJfM0u0EzR5fHEUnPGOpfZB/ukzru5hwluEHAVVG9GIUPZ
 ARRvmZ103SM8sOpu8JBvzZd/30zs/b6hksGcdWbjvuq8sBWxvpIsownAz/ANAwO2wOMN
 ZVLg==
X-Gm-Message-State: AOAM531zaSrNShTQzRwxm5qZyaUk/+mI5ad3sf9c/WRFUrlEsFcST8td
 Hnn9E9T7/oSFMtTGewKJaFMdE+rylS+RXm2AWpQEjww5x/Gw2T+NVk/nPYLgXmuLkG0mumJwsqc
 PAwNT3c9MN5PuHz4=
X-Received: by 2002:adf:de8d:: with SMTP id w13mr77261631wrl.129.1594630825748; 
 Mon, 13 Jul 2020 02:00:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx27tG3sic85OHjYb6VlvNUycjATl7Hcn8UbvFR8v/LwvMUvY3S4F9Wr+u1U8i3pw7k5gnjgw==
X-Received: by 2002:adf:de8d:: with SMTP id w13mr77261617wrl.129.1594630825552; 
 Mon, 13 Jul 2020 02:00:25 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k126sm23315304wme.17.2020.07.13.02.00.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 02:00:25 -0700 (PDT)
Subject: Re: [PATCH 1/1] configure: fix incorrect have_keyring check
To: Alexey Kirillov <lekiravi@yandex-team.ru>
References: <20200713085528.5608-1-lekiravi@yandex-team.ru>
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
Message-ID: <ad2b3d6a-701a-e867-5d79-5c19ba2a3985@redhat.com>
Date: Mon, 13 Jul 2020 11:00:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200713085528.5608-1-lekiravi@yandex-team.ru>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, David Edmondson <david.edmondson@oracle.com>,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alexey,

On 7/13/20 10:55 AM, Alexey Kirillov wrote:
> In some shells, we can't use == sign (as example, in dash).
> 
> Signed-off-by: Alexey Kirillov <lekiravi@yandex-team.ru>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 31e2ddbf28..f65914f98f 100755
> --- a/configure
> +++ b/configure
> @@ -6486,7 +6486,7 @@ EOF
>  fi
>  if test "$secret_keyring" != "no"
>  then
> -    if test "$have_keyring" == "yes"
> +    if test "$have_keyring" = "yes"
>      then
>  	secret_keyring=yes
>      else
> 

Thanks, but David already sent the same fix:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg713765.html

It should be merged in today or tomorrow via Alex Bennée tree.


