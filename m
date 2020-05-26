Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708C3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F4B20776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDTouif1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F4B20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUXu-00055w-EP
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 04:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdUWZ-0003Z3-6B
 for qemu-devel@nongnu.org; Tue, 26 May 2020 04:01:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39056
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdUWX-0003pq-P6
 for qemu-devel@nongnu.org; Tue, 26 May 2020 04:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590480080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TQTXRXEz/gMqp9X6Ttchn0696bXl6YwkmcUsYoxdUSI=;
 b=dDTouif1+EJRgSbBNFI/1m2Tw/343Z2JzSgg3QIUcK3V+SJkBLcZzhTfJwx//HwcP4NRIi
 e/YBJkAjIEs11zRQX71vdNaZCIWs9yDfWwLejXyX+xP+aUuAo6b6QQDSg7jMn+IRXeRCDL
 P3jQXjHdvWcIdC2ylBpXqbzqe8PicGE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-AmwuIpA3MZCZLWgfc5C4sA-1; Tue, 26 May 2020 04:01:18 -0400
X-MC-Unique: AmwuIpA3MZCZLWgfc5C4sA-1
Received: by mail-wr1-f72.google.com with SMTP id h12so9465456wrr.19
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 01:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=TQTXRXEz/gMqp9X6Ttchn0696bXl6YwkmcUsYoxdUSI=;
 b=h/YLKaclMQ+S/DgPBqHb1LNISIqId8LG494tNV0gbbtsjLuMjLdtKv9d23kWoyu7HJ
 vU8KRKqED8E1K6IuRGFY3ibTUjt276HYQ+caC37xdjAgVTzcgMLR+rlSNxpxPl/Nss25
 xcE/HxhgsoW7/Hnt7r+vWL5vVsOjmPKvPQxeur3ZmHKuH/Nvr0W94axiuWPcDh3yPs7L
 vCJywlTlpCl+k6lpaz/XRZW/xrhymgQJoToAlzXkdruKiuDbIi7yx1mDYcUOd9Sn6XYB
 nfYi/ITYh5WAYk6DIbIgwxJqSFOwVQG0/vArQEUWo8Lgws2GHFBmVijJvwd57zqPoa9I
 Koxg==
X-Gm-Message-State: AOAM5317hWqO9itu87oy13dBDadcahueBDLxqSnfH2a860KdgAmjF4Gm
 VRXhxLTOKKhOkNINf4wZiW04L1sQgDs31FnAyYAx7oJwfgKjRgM8TjphPc/LNxSd28LGA/2XEGB
 vpGS/Q7eaL6b247c=
X-Received: by 2002:a1c:9d09:: with SMTP id g9mr176198wme.31.1590480077824;
 Tue, 26 May 2020 01:01:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTezZfZGX0L5pc2CVLnftyI30Qx3kbz/cu0o1ak+8NQokiUrSLXbd1JZAbNHwNuYB2zJ/p5Q==
X-Received: by 2002:a1c:9d09:: with SMTP id g9mr176118wme.31.1590480076810;
 Tue, 26 May 2020 01:01:16 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id k17sm16209514wmj.15.2020.05.26.01.01.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 01:01:16 -0700 (PDT)
Subject: Re: [PATCH v3] exec: set map length to zero when returning NULL
To: P J P <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20200526075042.420162-1-ppandit@redhat.com>
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
Message-ID: <0b36df7d-06f3-1a78-4a00-12024db7ace0@redhat.com>
Date: Tue, 26 May 2020 10:01:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200526075042.420162-1-ppandit@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:51:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Ding Ren <rding@gatech.edu>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/26/20 9:50 AM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> When mapping physical memory into host's virtual address space,
> 'address_space_map' may return NULL if BounceBuffer is in_use.
> Set and return '*plen = 0' to avoid later NULL pointer dereference.
> 
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Fixes: https://bugs.launchpad.net/qemu/+bug/1878259
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  exec.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> Update v3: set *plen = 0;
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg06249.html
> 
> diff --git a/exec.c b/exec.c
> index 5162f0d12f..4eea84bf66 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3538,6 +3538,7 @@ void *address_space_map(AddressSpace *as,
>  
>      if (!memory_access_is_direct(mr, is_write)) {
>          if (atomic_xchg(&bounce.in_use, true)) {
> +            *plen = 0;
>              return NULL;
>          }
>          /* Avoid unbounded allocations */
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


