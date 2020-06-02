Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1179C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 14:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ADA32068D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 14:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjegDICY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADA32068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg8Cz-0003h2-NW
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 10:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jg8C2-00037t-FT
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 10:47:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59049
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jg8C1-0007a6-6y
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 10:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591109223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QeO0NXFyVX922zwxN8YmvHITMTh6VNjP3N1esX25vhM=;
 b=OjegDICYIxxKEL/JZoADGjJXl7tbPEDHOeIlqwsNoIR0PM4jriaSHlcneW0QdYsmfKvgAK
 w3q4v3GKfHp5ClcBsg9ubapGRO83U62ezgwULHehN4WekKgp6+RlOaC3mlR8jazQb6KwRi
 3Mi+xw/Bhlt9OL18RJ7Nl0dNwk+YGYE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-7ZVM5cZzMzOdlzb7r841Mw-1; Tue, 02 Jun 2020 10:47:02 -0400
X-MC-Unique: 7ZVM5cZzMzOdlzb7r841Mw-1
Received: by mail-wr1-f71.google.com with SMTP id m14so1480849wrj.12
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 07:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=QeO0NXFyVX922zwxN8YmvHITMTh6VNjP3N1esX25vhM=;
 b=Azh3cYHYDE0rXbRIi5NkTrXBSEw0dshPrTchy01NSnPN51ZReziRluk8D7XhQDYjBd
 h+wh91N3CVU2s+nmzZrf7+Up5Dkq1xKZvkOqoOhW/tEhN1iI9v24AwcMqA29zNmBPWrO
 W+fYDuZAf2yr8C4NaxoqVhsnWYAwyG7qTKcU1qE/1+IRs5XBw5K3Vn6qjtIObePmGPXi
 kUlQstolsUxP79qHIBNOv8ftYN9mVOwUsIpSVxtdHn9WPLd7B+34upPj6YySN+y//Z0r
 R/kZz5towP74SgOWWRVLBUTG466q2yC+jr9Pl+t+2aT7rWIGSb1n2yZbzjkw/aSf34Fk
 vjMg==
X-Gm-Message-State: AOAM530Raarl16wwvceRoS1SnbtGiSiy6WhlxDoUsRHJPp0jfCZhLJag
 NfjkDg85kWSMu3CjP9vJqIN4RHdXvjE6lpS0W/5ZM4FSVLsLhtPzRdqZ1n5VNwRoWLQk3+SPlGf
 11V/kvq7eataMWzo=
X-Received: by 2002:a5d:6085:: with SMTP id w5mr26462765wrt.322.1591109221215; 
 Tue, 02 Jun 2020 07:47:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwF5auD96YZCMf7+9dWrS2WQ7U+eMGdgaMVnPgYIHVIkYunHBQmncA75BNloB/xQW/SWIi/Cg==
X-Received: by 2002:a5d:6085:: with SMTP id w5mr26462733wrt.322.1591109220924; 
 Tue, 02 Jun 2020 07:47:00 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id u12sm4163809wrq.90.2020.06.02.07.46.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 07:47:00 -0700 (PDT)
Subject: Re: [PATCH v4 00/13] user-mode: Prune build dependencies (part 1)
To: qemu-devel@nongnu.org
References: <20200522172510.25784-1-philmd@redhat.com>
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
Message-ID: <71ea2e86-11e7-277c-9757-d4fc282e0787@redhat.com>
Date: Tue, 2 Jun 2020 16:46:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200522172510.25784-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 03:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: qemu-riscv@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-s390x@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series is now fully reviewed.

Laurent, as Paolo's misc-tree is already full, can it go via your
linux-user tree (as it improve linux-user at the end)?

Thanks,

Phil.

On 5/22/20 7:24 PM, Philippe Mathieu-Daudé wrote:
> This is the first part of a series reducing user-mode
> dependencies. By stripping out unused code, the build
> and testing time is reduced (as is space used by objects).
> 
> Part 1 (generic):
> - reduce user-mode object list
> - remove some migration code from user-mode
> - remove cpu_get_crash_info()
> 
[...]
> 
> Philippe Mathieu-Daudé (13):
>   Makefile: Only build virtiofsd if system-mode is enabled
>   configure: Avoid building TCG when not needed
>   tests/Makefile: Only display TCG-related tests when TCG is available
>   tests/Makefile: Restrict some softmmu-only tests
>   util/Makefile: Reduce the user-mode object list
>   stubs/Makefile: Reduce the user-mode object list
>   target/riscv/cpu: Restrict CPU migration to system-mode
>   exec: Assert CPU migration is not used on user-only build
>   arch_init: Remove unused 'qapi-commands-misc.h' include
>   target/i386: Restrict CpuClass::get_crash_info() to system-mode
>   target/s390x: Restrict CpuClass::get_crash_info() to system-mode
>   hw/core: Restrict CpuClass::get_crash_info() to system-mode
>   stubs: Restrict ui/win32-kbd-hook to system-mode


