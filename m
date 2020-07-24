Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488A5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:17:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 121BF20714
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmX4nSjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121BF20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyr1T-00064M-2Z
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 02:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyr0U-0005HG-Va
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:16:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29303
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyr0T-0005RS-7Q
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595571392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/45hO55ke5izVX3RXey5PYITo1YS3iRDx99sZ9y/4xI=;
 b=ZmX4nSjqcW3AA5ACqzFwYIdI4xib/CpDNafrGC9+THJOtrBEYrVCbMbxCNAu/J7ZjFZwSq
 ublCAHEy0noDpcR5QywX2RmK+96/uXeyEFsEmhDNBXSbsmt08VOaiM0Et1NYj6FNXe6YWE
 lCyuJ9viGLWe1urWcEHzFTZE99acoc4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-74OtwX-QMJmsiPedHPtUzw-1; Fri, 24 Jul 2020 02:16:28 -0400
X-MC-Unique: 74OtwX-QMJmsiPedHPtUzw-1
Received: by mail-wm1-f72.google.com with SMTP id f74so3569958wmf.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 23:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/45hO55ke5izVX3RXey5PYITo1YS3iRDx99sZ9y/4xI=;
 b=B1ASoGWLd46aAqElJ4FhtY9BsoSo1npz1ax90CJfKzGFZ8LtKaQPcf+FSMoeMFvhTv
 cwqq+1FBovt7uZM4gR3wnKWJ8w6m/EOnbVtqbuE+JufBotoZ+dtEBIW9kIAX2itqdZUH
 TAOlJXPKG2JdZFViJ20DdhTNKRA3ytQBw7MhS2gXCNYqWMIpS/hVt+A24FNIDcduDpFZ
 dxBoDIVnAZCQ09jejM+bMLie/zPrgEkrJz7Or4EU8PsEydAgYZvLgM5iZCQZ7hjTY/uO
 gfZP4r92LEtG1GSbpiXCAc5Ou3ot2ogdC+daAACh5SXZH/5zBHLT//9fbvUiU65CpoSk
 e/LQ==
X-Gm-Message-State: AOAM530e0bu9+KmXYIZFK/BmNUIWXZ+Gz2/5+HaSm4VfrA5tv1dTAjQq
 IAv578kyltvoKrTVpfvvSs0vAtpfg0fC//2R8NXx0aYJCZcfKErQvcILHIjHNTVedNOJN3gxpJJ
 oPKZ0Zpg2Jpo8CCg=
X-Received: by 2002:adf:ed88:: with SMTP id c8mr6598877wro.233.1595571386993; 
 Thu, 23 Jul 2020 23:16:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7CPXLY5FKUxCiBxiUoVchGnVOsWXrngSYSRv83b1ISBiLHM40fd3en9LYR6w4YdyfQYDltA==
X-Received: by 2002:adf:ed88:: with SMTP id c8mr6598862wro.233.1595571386811; 
 Thu, 23 Jul 2020 23:16:26 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id j75sm88671wrj.22.2020.07.23.23.16.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 23:16:26 -0700 (PDT)
Subject: Re: [PATCH 1/7] ide: rename cmd_write to ctrl_write
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200724052300.1163728-1-jsnow@redhat.com>
 <20200724052300.1163728-2-jsnow@redhat.com>
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
Message-ID: <705b33b7-ec0d-99a0-e6e2-213c4ebddcfb@redhat.com>
Date: Fri, 24 Jul 2020 08:16:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200724052300.1163728-2-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 01:23:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, Alexander Bulekov <alxndr@bu.edu>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/24/20 7:22 AM, John Snow wrote:
> It's the Control register, part of the Control block -- Command is
> misleading here. Rename all related functions and constants.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  include/hw/ide/internal.h |  9 +++++----
>  hw/ide/core.c             | 12 ++++++------
>  hw/ide/ioport.c           |  2 +-
>  hw/ide/macio.c            |  2 +-
>  hw/ide/mmio.c             |  8 ++++----
>  hw/ide/pci.c              | 12 ++++++------
>  hw/ide/trace-events       |  2 +-
>  7 files changed, 24 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


