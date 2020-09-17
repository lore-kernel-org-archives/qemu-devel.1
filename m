Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18372C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D0B21D43
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/rUKds8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D0B21D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIoet-000076-LZ
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 03:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIodX-0006xZ-Bo
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:47:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIodV-0004jH-90
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600328840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ot9QkrYEDbGS3t+N9d85/lzjBh1N8X9TllGTFiyj/RQ=;
 b=V/rUKds8Rjr1hMvGFFWMH6b6R3SAamwfAVqlqH4TQONJkuM09loCl7HvYAaCej7kwKl8iy
 yfKhMISQd7rh9Mk7TefHRNYjRqJSMFohBdV4ern3LhEfZaLaBy1oQC1uMq0QA2bze4xFU5
 SDpR7wizL9+kGAXiEyozJGzyXMqBfxE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-oDfmtzWkNBmh2h0VGM4Z8g-1; Thu, 17 Sep 2020 03:47:16 -0400
X-MC-Unique: oDfmtzWkNBmh2h0VGM4Z8g-1
Received: by mail-wm1-f69.google.com with SMTP id x6so442675wmi.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 00:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Ot9QkrYEDbGS3t+N9d85/lzjBh1N8X9TllGTFiyj/RQ=;
 b=IHUnoIjlCiFulUfL8gqKR566VMDBjW7I+qRngY/p2lGn1KhrnViRdplcRuPnQ726uf
 xoD+itm1DSh5KnWR9X0H4qd+VyP+QFoVqPkumPkoWwZMDxX+xVGwgBHWhn1nc9Fc1Qlz
 3CO84FY7EaVeKQE1ISGxayV5rmcCOH+4YZILfR4rXu9/zIqzLjuhjuq6jXhkQLiBid4/
 Cdz+tl/jut/Ogx+ro/+4uYnDGdQWtM9cA0PNrcrwcYAxcfRFwSybdwE0TOuvhaRAAEzD
 9wmqLjseGgHCCrY/J4SzC6vbL9vZnpCA6ua4Ra21dgohqOPNhZ38vN/DhNZ0ZiGyS/nI
 Nu/Q==
X-Gm-Message-State: AOAM530k3mGql7N2ICUyl6XMYfZ+SYzdL9iHGyQbArC2VbbZnD37zExm
 0nFJS92M4r+JGYe5O8HfUrfnYBjGwg+Qb4TccOVUNxOSEOPrf2kYg/UkkOC+9aHzqPEaBJ3KN75
 JASFB/WwVilGk8hc=
X-Received: by 2002:a5d:68d1:: with SMTP id p17mr29531119wrw.378.1600328835408; 
 Thu, 17 Sep 2020 00:47:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKwJx9stU1EiVE9OEJMzQOyi4Qy7d/9RHeSn5Ck2s//GJCqdC+FI7/mRpUOonLRTZ4vwMl0A==
X-Received: by 2002:a5d:68d1:: with SMTP id p17mr29531112wrw.378.1600328835220; 
 Thu, 17 Sep 2020 00:47:15 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id z9sm10121544wmg.46.2020.09.17.00.47.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 00:47:14 -0700 (PDT)
Subject: Re: [PATCH v2] migration: Silence compiler warning in
 global_state_store_running()
To: Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
References: <20200917074344.168785-1-thuth@redhat.com>
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
Message-ID: <da9ed157-dd81-c486-e4ac-d98ca3ac0ee3@redhat.com>
Date: Thu, 17 Sep 2020 09:47:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200917074344.168785-1-thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 9:43 AM, Thomas Huth wrote:
> GCC 9.3.0 on Ubuntu complains:
> 
> In file included from /usr/include/string.h:495,
>                  from /home/travis/build/huth/qemu/include/qemu/osdep.h:87,
>                  from ../migration/global_state.c:13:
> In function ‘strncpy’,
>     inlined from ‘global_state_store_running’ at ../migration/global_state.c:47:5:
> /usr/include/x86_64-linux-gnu/bits/string_fortified.h:106:10: error:
>  ‘__builtin_strncpy’ specified bound 100 equals destination size [-Werror=stringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> ... but we apparently really want to do a strncpy here - the size is already
> checked with the assert() statement right in front of it. To silence the
> warning, simply replace it with our strpadcpy() function.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Use strpadcpy instead of QEMU_NONSTRING (and yes, this time it seems
>      to really silence the compiler warning :-))
> 
>  migration/global_state.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/global_state.c b/migration/global_state.c
> index 25311479a4..a33947ca32 100644
> --- a/migration/global_state.c
> +++ b/migration/global_state.c
> @@ -44,8 +44,8 @@ void global_state_store_running(void)
>  {
>      const char *state = RunState_str(RUN_STATE_RUNNING);
>      assert(strlen(state) < sizeof(global_state.runstate));
> -    strncpy((char *)global_state.runstate,
> -           state, sizeof(global_state.runstate));
> +    strpadcpy((char *)global_state.runstate, sizeof(global_state.runstate),
> +              state, '\0');

https://www.mail-archive.com/qemu-block@nongnu.org/msg44925.html
;)

>  }
>  
>  bool global_state_received(void)
> 


