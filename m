Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26237C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 19:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD7222145D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 19:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TelT0fnq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7222145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFNFm-000640-VW
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 15:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFNEq-0005Cx-7t
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 15:55:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25867
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFNEo-0007Hx-MP
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 15:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599508537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L5LgZALd8EMValX7oDlAy/sNP/oJ4oIEiCdp0d8WRTo=;
 b=TelT0fnqbjW/hLRpn6Cr0J44CPJAAfqjw+zsdqrqSh1A/DyhleM4emiF+qnlblar2YWQlR
 /6qxlv/D173G9bgZ+1dAoSek+3/sqSHgFePc2/XMDipQqrCgQHFItXD5qS2yF4rCl94Jr4
 RWzg+IPpZM9pMDN+m1iIKZwr4lAVmcU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-yU7Pz6GJPyCafuBxSa_quw-1; Mon, 07 Sep 2020 15:55:36 -0400
X-MC-Unique: yU7Pz6GJPyCafuBxSa_quw-1
Received: by mail-wm1-f72.google.com with SMTP id 189so848428wme.5
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 12:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=L5LgZALd8EMValX7oDlAy/sNP/oJ4oIEiCdp0d8WRTo=;
 b=XClJfVd0g57lSvJ2/7BvReRUE7/STNiJTuvEzeRAaPQMTEm5X37q6va2XAOsleeq27
 1uEqNoZFmJTvWighpiYtetjzjBWUIcHal1fWw691vzP49NcAPA1ShjjJdkBLb+GjINCF
 kvqaRiwNIKD+IhHbr8dkoYFyDaMgKxzEUD74CWdis9Xd5JLnPeTWzyGrHdL0fZoNoFmK
 OXRNLQFNT+cApyKDeFAJ7sNN9mDJWSCFCUV6hW2QTk/KlasrUdkQ+qcS9xxOHs3r/Xwe
 md4OGTYmz4XOOlZHKTVoy3wD5cTvwft53SwOZ8Q8IOj351L9NDTYhHalR2TykhRHGAbd
 /VmQ==
X-Gm-Message-State: AOAM5318pQ56LX7sP94Pnqd7KnA/Hn7GZCtoGfiLIl7cpWqWcDJEHnhA
 ttd6+rtXC24FeBsA9TC9sEkxuLv+mH8pOIFOYvBCQXFErAj5kNh5anbFygVbizQHqLvA7iYT4Ir
 x3UpP2Zm2pTMEx1Y=
X-Received: by 2002:a5d:668b:: with SMTP id l11mr19158715wru.89.1599508535200; 
 Mon, 07 Sep 2020 12:55:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGb8FMKIdhpK0+XdYZ0DM9mA5CZdy6LoYKc0qgQlS/t2jYp+3mgclO9KAkjdw0NF70S+igsA==
X-Received: by 2002:a5d:668b:: with SMTP id l11mr19158701wru.89.1599508535047; 
 Mon, 07 Sep 2020 12:55:35 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id m13sm29655996wrr.74.2020.09.07.12.55.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 12:55:33 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] vmstate: Enable test-vmstate on all platform:
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200907195025.2308-1-luoyonggang@gmail.com>
 <20200907195025.2308-5-luoyonggang@gmail.com>
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
Message-ID: <b9255d35-ef89-22af-e3f3-528184bd1381@redhat.com>
Date: Mon, 7 Sep 2020 21:55:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907195025.2308-5-luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 02:54:37
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/7/20 9:50 PM, Yonggang Luo wrote:
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>

Trailing ':' in subject, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/meson.build | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tests/meson.build b/tests/meson.build
> index 7f27a15cee..39fa822be3 100644
> --- a/tests/meson.build
> +++ b/tests/meson.build
> @@ -185,11 +185,9 @@ if have_system
>      'test-timed-average': [],
>      'test-util-sockets': ['socket-helpers.c'],
>      'test-base64': [],
> +    'test-vmstate': [migration, io],
>      'test-bufferiszero': [],
>    }
> -  if 'CONFIG_POSIX' in config_host
> -    tests += {'test-vmstate': [migration, io]}
> -  endif
>    if 'CONFIG_INOTIFY1' in config_host
>      tests += {'test-util-filemonitor': []}
>    endif
> 


