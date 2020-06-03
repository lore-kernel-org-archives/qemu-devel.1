Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43268C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 17:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E35205CB
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 17:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUJwu64Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E35205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgXA2-0003Cw-AN
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 13:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgX9S-0002ev-4m
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 13:26:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34197
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgX9R-0001Y0-11
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 13:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591205164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ox19amF9zeU+dokGCpHVwQBiTN3+WSy5x1F3UWD7b+Y=;
 b=MUJwu64YwGSKXlbgb+S6DrJGB83pRAUMBOPPC7vEijMMJ32T53wKenFidRJs08UVsSRDaw
 Gh6MpH8Nv48pEPbm7dc4PxLUPm1B1fkw38ipy0yMD+d02prZBhI2qEOqbe/8QguEzppmq7
 V1gPPepmC7/1rWe1UrNScD/yWQwHC+0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-yBkq6MmmNritHvIbv48coA-1; Wed, 03 Jun 2020 13:26:02 -0400
X-MC-Unique: yBkq6MmmNritHvIbv48coA-1
Received: by mail-wr1-f69.google.com with SMTP id z10so1357260wrs.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 10:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Ox19amF9zeU+dokGCpHVwQBiTN3+WSy5x1F3UWD7b+Y=;
 b=dBUbJUv4x4SZope15eGMLDlCAKYJ/oiZUUe+RqJ1QPL8M59k+Kgx2Tr4pB1qw9rCjG
 E7EID+NeiwFPTTSTFb3wbwv8AmLy5rNzhMdl2oEOfYJDPH0SkSi0dRsQAwlxYPuB5cIM
 2Qq6+vRtlb8nBC/7wLTjNW8Ism8XZWWaEzvzYKgZt/ORlqo98vDHus2hP4XjCcuGadiD
 fGV2193VBD0MAd9Q65T1gS671AuT3EQJvlk1dhXyIfacQoit0ewX5eBqKLGTpTWXWE/K
 0f5eOtc0XKKaBMp26ymkIj5vHwv0APRevB/ayUzy4tVoyILnq1pX8+HPtxYH99bk1F+W
 tHmA==
X-Gm-Message-State: AOAM532E3jaTdsSUbzcKzakT178TZiFPIHabVWNfIUyY3U2rPdoYl/a1
 B0vourx8FaqW6pxXPDkc+BJ/jiapVSX9hS0PoCe9/M0OOKiblhqU0dXF8/pso0rK1aNsJuzxSqA
 V8znkhD6g/WpQPfo=
X-Received: by 2002:a05:600c:c3:: with SMTP id u3mr228749wmm.108.1591205161444; 
 Wed, 03 Jun 2020 10:26:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8ihIRhva2wibd76MPdpTmJRbyOZzsKn+fImVAxIW8QtYgHNdXfWoRIk4paARP086eMkntCw==
X-Received: by 2002:a05:600c:c3:: with SMTP id u3mr228726wmm.108.1591205161188; 
 Wed, 03 Jun 2020 10:26:01 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id a6sm3919596wrn.38.2020.06.03.10.26.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 10:26:00 -0700 (PDT)
Subject: Re: [PATCH] tests: fix a memory in test_socket_unix_abstract_good
To: Li Qiang <liq3ea@163.com>, berrange@redhat.com,
 marcandre.lureau@redhat.com, zxq_yx_007@163.com
References: <20200603161409.54682-1-liq3ea@163.com>
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
Message-ID: <65333e6e-1a7b-b51d-e73b-7019514cc7f6@redhat.com>
Date: Wed, 3 Jun 2020 19:25:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200603161409.54682-1-liq3ea@163.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:12:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/20 6:14 PM, Li Qiang wrote:
> After build qemu with '-fsanitize=address' extra-cflags,
> 'make check' show following leak:
> 
> =================================================================
> ==44580==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 2500 byte(s) in 1 object(s) allocated from:
>     #0 0x7f1b5a8b8d28 in __interceptor_calloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xded28)
>     #1 0x7f1b5a514b10 in g_malloc0 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x51b10)
>     #2 0xd79ea4e4c0ad31c3  (<unknown module>)
> 
> SUMMARY: AddressSanitizer: 2500 byte(s) leaked in 1 allocation(s).
> 
> Call 'g_rand_free' in the end of function to avoid this.

GLib doc doesn't seem complete (they don't mention explicitly the
generator returned from g_rand_new has to be released with g_rand_free).

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Fixes: 4d3a329af59("tests/util-sockets: add abstract unix socket cases")
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  tests/test-util-sockets.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
> index 2ca1e99f17..ca6671f9bf 100644
> --- a/tests/test-util-sockets.c
> +++ b/tests/test-util-sockets.c
> @@ -312,6 +312,7 @@ static void test_socket_unix_abstract_good(void)
>      g_thread_join(serv);
>  
>      g_free(abstract_sock_name);
> +    g_rand_free(r);
>  }
>  #endif
>  
> 


