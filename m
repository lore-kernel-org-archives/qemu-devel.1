Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C42C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE4D206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RuFgd89o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE4D206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUrt-00039W-La
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joUrG-0002j2-Vu
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:36:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30611
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joUrE-0005d0-D4
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593102971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=N81NH57bfjBc3k7aggQBZh1SqdPlvFN3bNQGYrUBVAs=;
 b=RuFgd89o4t5HWqpC845AK6Tk0ZIrdaEbrIg1Ox/T0s1vpOFySA0NP3PSu06xTzA3LBG7cI
 N6YULyguHkScasEL2VPdJxBBPJA+ovGynz3jqr2LNdMX/WGr0lKrrWGlCXIwwKSAVJEtVq
 lZK5/LNKSlXAlveEsp91MXV2aknV8T8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-YpvGjdZ8NU67x_q_vNzmew-1; Thu, 25 Jun 2020 12:36:08 -0400
X-MC-Unique: YpvGjdZ8NU67x_q_vNzmew-1
Received: by mail-wr1-f70.google.com with SMTP id n4so5214475wrj.15
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 09:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=N81NH57bfjBc3k7aggQBZh1SqdPlvFN3bNQGYrUBVAs=;
 b=XUyO2DrXEg+DKITw8WsARnhROkkfYDYIpy0KsnlZMeS6aL4y0BdF77cyl2XtEkxKRO
 UxCzb0Iw2TbuhgJvsGslRbdpykDalfRJ6ZvIRSWzHcV2G5QshEEgdBABihaqXxUbS50J
 u9nFBWSZHu+X+f9/LhcKPBXHOuyXoW0I/j/iJAekBrqJRRm3rQoKFfNse8LWWQfWVjqc
 M3+DhkOBf+V4TOcVjqf88Aox2vemWpY/mXGTlAl4ZCqD4U8MsUYEY4ifPrT25jACKAIA
 6m4xgwGFCPU49EPeOybXu84Y1W3aTDTEZKwkbZfs364KxCef+euxzPVsgrsLunW5ltgC
 WcGQ==
X-Gm-Message-State: AOAM531O+7CHRAPwEjfWtxRxy9w219xidqAOdE7pAoyV0ec1mjHrlptD
 S5d9RKPO2W1zCato29tzDmbtYvKWA1G7qZjtcr21sws6ID3VaaiCjc47ZFhVKqVm2nWbNbZWdVI
 gUXvtJCEcRRdjg8I=
X-Received: by 2002:a05:600c:2209:: with SMTP id
 z9mr2100649wml.178.1593102966961; 
 Thu, 25 Jun 2020 09:36:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVifkdILSR70YKQEAhRdwnyFt1L1fahXykvBIT0QsKAmNJZtVqIFUE+B+6Mj8yesCD4jroWQ==
X-Received: by 2002:a05:600c:2209:: with SMTP id
 z9mr2100627wml.178.1593102966705; 
 Thu, 25 Jun 2020 09:36:06 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id b184sm6870929wmc.20.2020.06.25.09.36.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 09:36:06 -0700 (PDT)
Subject: Re: [PATCH v5] osdep: Make MIN/MAX evaluate arguments only once
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200625162602.700741-1-eblake@redhat.com>
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
Message-ID: <ebba61cb-635f-b9f8-94bc-a616db160230@redhat.com>
Date: Thu, 25 Jun 2020 18:36:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200625162602.700741-1-eblake@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 6:26 PM, Eric Blake wrote:
> I'm not aware of any immediate bugs in qemu where a second runtime
> evaluation of the arguments to MIN() or MAX() causes a problem, but
> proactively preventing such abuse is easier than falling prey to an
> unintended case down the road.  At any rate, here's the conversation
> that sparked the current patch:
> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg05718.html
> 
> Update the MIN/MAX macros to only evaluate their argument once at
> runtime; this uses typeof(1 ? (a) : (b)) to ensure that we are
> promoting the temporaries to the same type as the final comparison (we
> have to trigger type promotion, as typeof(bitfield) won't compile; and
> we can't use typeof((a) + (b)) or even typeof((a) + 0), as some of our
> uses of MAX are on void* pointers where such addition is undefined).
> 
> However, we are unable to work around gcc refusing to compile ({}) in
> a constant context (such as the array length of a static variable),
> even when only used in the dead branch of a __builtin_choose_expr(),
> so we have to provide a second macro pair MIN_CONST and MAX_CONST for
> use when both arguments are known to be compile-time constants and
> where the result must also be usable as a constant; this second form
> evaluates arguments multiple times but that doesn't matter for
> constants.  By using a void expression as the expansion if a
> non-constant is presented to this second form, we can enlist the
> compiler to ensure the double evaluation is not attempted on
> non-constants.
> 
> Alas, as both macros now rely on compiler intrinsics, they are no
> longer usable in preprocessor #if conditions; those will just have to
> be open-coded or the logic rewritten into #define or runtime 'if'
> conditions (but where the compiler dead-code-elimination will probably
> still apply).
> 
> I tested that both gcc 10.1.1 and clang 10.0.0 produce errors for all
> forms of macro mis-use.  As the errors can sometimes be cryptic, I'm
> demonstrating the gcc output:
> 
> Use of MIN when MIN_CONST is needed:
> 
> In file included from /home/eblake/qemu/qemu-img.c:25:
> /home/eblake/qemu/include/qemu/osdep.h:249:5: error: braced-group within expression allowed only inside a function
>   249 |     ({                                                  \
>       |     ^
> /home/eblake/qemu/qemu-img.c:92:12: note: in expansion of macro ‘MIN’
>    92 | char array[MIN(1, 2)] = "";
>       |            ^~~
> 
> Use of MIN_CONST when MIN is needed:
> 
> /home/eblake/qemu/qemu-img.c: In function ‘is_allocated_sectors’:
> /home/eblake/qemu/qemu-img.c:1225:15: error: void value not ignored as it ought to be
>  1225 |             i = MIN_CONST(i, n);
>       |               ^
> 
> Use of MIN in the preprocessor:
> 
> In file included from /home/eblake/qemu/accel/tcg/translate-all.c:20:
> /home/eblake/qemu/accel/tcg/translate-all.c: In function ‘page_check_range’:
> /home/eblake/qemu/include/qemu/osdep.h:249:6: error: token "{" is not valid in preprocessor expressions
>   249 |     ({                                                  \
>       |      ^
> 
> Fix the resulting callsites that used #if or computed a compile-time
> constant min or max to use the new macros.  cpu-defs.h is interesting,
> as CPU_TLB_DYN_MAX_BITS is sometimes used as a constant and sometimes
> dynamic.
> 
> It may be worth improving glib's MIN/MAX definitions to be saner, but
> that is a task for another day.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
>

Nice! (btw why extra line after s-o-b?)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> 
> v2 was: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00727.html
> v3: avoid __auto_type [Richard], document other approaches that fail
> [Dave], rebase to master
> v4: use ((void)0) instead of __builtin_unreachable [Dave], update comments
> v5: fix typo, comment formatting, one more __builtin_unreachable
> ---
>  hw/usb/hcd-xhci.h         |  2 +-
>  include/block/block.h     |  4 +--
>  include/exec/cpu-all.h    |  8 +++---
>  include/exec/cpu-defs.h   |  7 ++++-
>  include/qemu/osdep.h      | 57 ++++++++++++++++++++++++++++++++-------
>  accel/tcg/translate-all.c |  6 ++---
>  migration/qemu-file.c     |  2 +-
>  7 files changed, 63 insertions(+), 23 deletions(-)


