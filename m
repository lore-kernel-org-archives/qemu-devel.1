Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8F6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 169B72065F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0Dku7J8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169B72065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIQw-0008Mm-98
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtHyJ-0002KC-DM
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:51:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44379
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtHyG-00059T-Qv
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594245076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EFAURhhEZjwOIthRplw96ApWbu7HPwfzmrhPNCfhLdE=;
 b=W0Dku7J88jergdduzIcW/P5eF1vKMJ0n2U52G4ROo5Z5TNMCwO7rSgDdiNr6dVr6olp75J
 J4C8XuvLAW/JeKwczhG4fmAyB2sQGyH/9/Suytj8CU3uaKUuZRm1FVMmXPwbukXaDJkNL4
 gQzTIaQhoqCqlZKhqpuP9umMB30LrU8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-VwI-fXaHPUKkLTq4nXPyjQ-1; Wed, 08 Jul 2020 12:50:33 -0400
X-MC-Unique: VwI-fXaHPUKkLTq4nXPyjQ-1
Received: by mail-wr1-f69.google.com with SMTP id o25so52490655wro.16
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 09:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EFAURhhEZjwOIthRplw96ApWbu7HPwfzmrhPNCfhLdE=;
 b=fDNlINzCCsqYR4s5akPkFli2/lq63fgj8e/m1WQE9InqIZLCxPp5qtrYa5J2HL18C3
 bh9mEICa0COJUyhae37eFoxF5OP7iJ44Q2/RHyiHS4baqcvE5Le0qd+K9uK9JmpiR7OG
 9rW2ny7W0Gthnxjz6nPwsLW6UZ2sNGlCedia50KZ0r8i/sbYv+PfKnBWyQpPBAJwOiJa
 wpEs7JOvifW+zTwmx436jLIGm7zAGFf2wCbLvPgoE0wxYUg70I5qlSKMtWZ9KICTYdut
 YZUcZJGG0BlNsfw3sG6v/jIUZt71s5HD9QltDR4yNXJQJp7reMuav9xP31M11L76qEwZ
 Z6zQ==
X-Gm-Message-State: AOAM533b2AjJ3I1mf+AVS7DaEFn73C1dqre0lWqj69cW7leH5Nes3cUK
 kGgvdggf5QIditi9zQnodqvunfwW42S1EjCe6den2JfP04XYwbnHfTXojekjSTcudCjpKYqtOz5
 5O9GXA+npj9/xGwo=
X-Received: by 2002:adf:ef46:: with SMTP id c6mr59450010wrp.34.1594227031574; 
 Wed, 08 Jul 2020 09:50:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8FO8YN+A4TMFeUTdPVcQABFgUzQsaOABrMZVj3IkafJK1UxJlbU6MyADXKkcZTIrAC9t2Gw==
X-Received: by 2002:adf:ef46:: with SMTP id c6mr59449990wrp.34.1594227031322; 
 Wed, 08 Jul 2020 09:50:31 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id n16sm912288wra.19.2020.07.08.09.50.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 09:50:30 -0700 (PDT)
Subject: Re: build error of unused function as MACRO
 G_DEFINE_AUTOPTR_CLEANUP_FUNC expand
To: Li Qiang <liq3ea@163.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eblake@redhat.com" <eblake@redhat.com>,
 "liq3ea@gmail.com" <liq3ea@gmail.com>, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Bandan Das <bsd@redhat.com>
References: <5F05E942.FB9110.20278@mail-m971.mail.163.com>
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
Message-ID: <b02161d0-a027-5018-af05-8ccbc5c90cc9@redhat.com>
Date: Wed, 8 Jul 2020 18:50:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5F05E942.FB9110.20278@mail-m971.mail.163.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing the fuzzing maintainers.

On 7/8/20 5:41 PM, Li Qiang wrote:
> Hello all,
> 
>  
> 
> I build qemu with fuzzing enabled using clang and following error come.
> 
>  
> 
> nbd/server.c:1937:1: error: unused function
> 'glib_listautoptr_cleanup_NBDExtentArray' [-Werror,-Wunused-function]
> 
> G_DEFINE_AUTOPTR_CLEANUP_FUNC(NBDExtentArray, nbd_extent_array_free);
> 
> ^
> 
> /usr/include/glib-2.0/glib/gmacros.h:462:22: note: expanded from macro
> 'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
> 
>   static inline void _GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName) (GList **_l)
> { g_list_free_full (*_l, (GDestroyNotify) func); } \
> 
>                      ^
> 
> /usr/include/glib-2.0/glib/gmacros.h:443:48: note: expanded from macro
> '_GLIB_AUTOPTR_LIST_FUNC_NAME'
> 
> #define _GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName)
> glib_listautoptr_cleanup_##TypeName
> 
>                                                ^
> 
> <scratch space>:170:1: note:   CC      crypto/hash-glib.o
> 
> expanded from here
> 
> glib_listautoptr_cleanup_NBDExtentArray
> 
> ^
> 
> nbd/server.c:1937:1: error: unused function
> 'glib_slistautoptr_cleanup_NBDExtentArray' [-Werror,-Wunused-function]
> 
> /usr/include/glib-2.0/glib/gmacros.h:463:22: note: expanded from macro
> 'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
> 
>   static inline void _GLIB_AUTOPTR_SLIST_FUNC_NAME(TypeName) (GSList
> **_l) { g_slist_free_full (*_l, (GDestroyNotify) func); } \
> 
>                      ^
> 
> /usr/include/glib-2.0/glib/gmacros.h:445:49: note: expanded from macro
> '_GLIB_AUTOPTR_SLIST_FUNC_NAME'
> 
> #define _GLIB_AUTOPTR_SLIST_FUNC_NAME(TypeName)
> glib_slistautoptr_cleanup_##TypeName
> 
>                                                 ^
> 
> <scratch space>:171:1: note: expanded from here
> 
> glib_slistautoptr_cleanup_NBDExtentArray
> 
>  
> 
>  
> 
> I see Eric’s patch 9bda600b083(“build: Silence clang warning on older
> glib autoptr usage”)
> 
> So I know there should be a ‘-Wno-unused-function’ in CFLAGS. It is
> after ./configure:
> 
>  
> 
> CFLAGS            -g  -Wno-unused-function
> 
> QEMU_CFLAGS       -I/usr/include/pixman-1  -Werror  -pthread
> -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
> -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
> -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef
> -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common
> -fwrapv -std=gnu99  -Wno-string-plus-int -Wno-typedef-redefinition
> -Wno-initializer-overrides -Wexpansion-to-defined -Wendif-labels
> -Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-body
> -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self
> -Wignored-qualifiers -Wold-style-definition -Wtype-limits
> -fstack-protector-strong -I$(SRC_PATH)/capstone/include
> 
>  
> 
> However while I ‘make V=1’ I see the build nbd/serer.c using following
> command:
> 
> clang-8 -iquote /home/test/qemu/nbd -iquote nbd -iquote
> /home/test/qemu/tcg/i386 -isystem /home/test/qemu/linux-headers -isystem
> /home/test/qemu/linux-headers -iquote . -iquote /home/test/qemu -iquote
> /home/test/qemu/accel/tcg -iquote /home/test/qemu/include -iquote
> /home/test/qemu/disas/libvixl -I/usr/include/pixman-1  -Werror  -pthread
> -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
> -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
> -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef
> -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common
> -fwrapv -std=gnu99  -Wno-string-plus-int -Wno-typedef-redefinition
> -Wno-initializer-overrides -Wexpansion-to-defined -Wendif-labels
> -Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-body
> -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self
> -Wignored-qualifiers -Wold-style-definition -Wtype-limits
> -fstack-protector-strong -I/home/test/qemu/capstone/include
> -I/home/test/qemu/tests -I/home/test/qemu/tests/qtest -MMD -MP -MT
> nbd/server.o -MF nbd/server.d -fsanitize=address,fuzzer-no-link  -c -o
> nbd/server.o nbd/server.c
> 
>  
> 
> There’s no CFLAGS ‘-Wno-unused-function’.
> 
>  
> 
> So I want to know:
> 
> 1.    Wha’t the relation of CFLAGS and QEMU_CFLAGS, it seems the CFLAGS
> doesn’t work in this.
> 
> 2.    Any hits to solve this? My env error or needs a patch?
> 
>  
> 
> I use following command in Ubuntu 18.04.1.
> 
> CC=clang-8 CXX=clang++-8  ./configure  --target-list="i386-softmmu" 
> --enable-debug --enable-debug  --enable-kvm --enable-fuzzing
> 
>  
> 
>  
> 
> Thanks,
> 
> Li Qiang
> 


