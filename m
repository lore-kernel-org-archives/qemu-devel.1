Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3413C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:09:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B9221D6C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccY47oBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B9221D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGNGN-0000LE-VJ
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 10:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGNFh-0008De-27
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 10:08:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47222
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGNFf-0005A3-0d
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 10:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599746918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t9rwAF9aA7tjqUjoLtzS1fgHPnMnB5K89LDcUIfAi6U=;
 b=ccY47oByGfoXT8DMOOXvwVmLRzUbsQC8hRxrlDMcWi9u/lMb8IjsfBwmpmAZtXu1s3w5lA
 7glm31zNsfmhGDLhyx4EHZ+QHUYvUmHnDoFhFKdF93gcahLXqOZBMdEVyst0N/IwwxB/Xn
 fl6IWFJ5PXQ7fz4YlX/OpAiVUcYnoJ8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-yFY8UbJxPbyMz7cmNcXMwg-1; Thu, 10 Sep 2020 10:08:34 -0400
X-MC-Unique: yFY8UbJxPbyMz7cmNcXMwg-1
Received: by mail-wr1-f72.google.com with SMTP id 33so2313674wre.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 07:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=t9rwAF9aA7tjqUjoLtzS1fgHPnMnB5K89LDcUIfAi6U=;
 b=s57Q/r8ea6kf68drh+WIjXE0ixOijuDGCUSFDsy7vdnhnx9eub4ZvPEYmENrBzgwvX
 zFZ67Bsi4mT29kxlDc1S/BnKDhaVCebYCBxo+WJOdRPONX8lHTrnWDWuaZtDMzOU8lOg
 6cSf0H7rcC7ctCHi+UmzECzJFJgckd2g3XuyrJmwR4kQ33woh8ZMkJMEpmFaDLpVdY4l
 UTfNM1egoa81mlhqsNsq+cFW/ksdFW2b9f2t8iTCff1kblz2A7OatnCVa4jlQBwv4kR3
 6BWO7ejCX/OHR/mVxTlGFsqPT7AEY9jHxGoJ9hABl20gtVlJxNnXwhuvj9GCNzSOzFy0
 ADVQ==
X-Gm-Message-State: AOAM532532WfQzalGLDfWdn/LBnuSjD3xAiJnhisMgSW8qXGDbVKU9OB
 AkF/69y0aHDPH6z05+CtUzimm1uZ5SxhXIWjKGeqkhTUZ8U1ihXGEyXdLWLbBtGZyoLmlwn6HPz
 1vhexoHsIOf60t0k=
X-Received: by 2002:adf:f986:: with SMTP id f6mr8936160wrr.270.1599746913569; 
 Thu, 10 Sep 2020 07:08:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyb/XH1Rbc33nv9hvMzIYNE3wGeTHU/ESahDwHvPTi6vUNsVBh9PEvDZIbvVjZBBv1vmkxBGA==
X-Received: by 2002:adf:f986:: with SMTP id f6mr8936130wrr.270.1599746913282; 
 Thu, 10 Sep 2020 07:08:33 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id c14sm8900181wrv.12.2020.09.10.07.08.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 07:08:32 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] hw/timer/hpet: Trivial format string fix
To: qemu-devel@nongnu.org, Dov Murik <dovmurik@linux.vnet.ibm.com>
References: <20200910135852.516809-1-philmd@redhat.com>
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
Message-ID: <35c826f7-bfbf-9e74-ad86-ef2d3262828f@redhat.com>
Date: Thu, 10 Sep 2020 16:08:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200910135852.516809-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:35:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/20 3:58 PM, Philippe Mathieu-Daudé wrote:
> Fix a format string and remove dead code.
> 
> Since v1:
> - Addressed Dov comments (fix format string + style):
>   https://www.mail-archive.com/qemu-devel@nongnu.org/msg739239.html

Dov, since you sent the same patches/code and sign them with
your S-o-b, I added them here too, is that OK with you?

> 
> Philippe Mathieu-Daudé (2):
>   hw/timer/hpet: Remove dead code
>   hw/timer/hpet: Fix DPRINTF format string
> 
>  hw/timer/hpet.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
> 


