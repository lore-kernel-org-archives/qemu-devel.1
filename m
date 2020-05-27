Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BB9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 11:30:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0980A206DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 11:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQUh82sd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0980A206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jduGG-0003Jd-9N
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 07:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jduFX-0002Wt-67
 for qemu-devel@nongnu.org; Wed, 27 May 2020 07:29:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21757
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jduFV-0001DM-Mk
 for qemu-devel@nongnu.org; Wed, 27 May 2020 07:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590578967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DVW20RJ7WUVVN7ibW9FVgUm0GXhEiqkS0bE0L/Mdba8=;
 b=aQUh82sdFTaaAB1fYZ6afvC7oec7sVRePukbr6CWbuTeksuZfHXKfNkTxoP7Xp3nFGDQw6
 +lq6a/JoWdFecPcOwFXCQV8PZpk22n2WP/tFOy4yT8g50KsLgspbNATXX8Au6xLMoufOSy
 SZfTOY6Tu+vQA66pK84UMU/LqMvKmiY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-KA4gKa6mOzePHQoflLb67g-1; Wed, 27 May 2020 07:29:24 -0400
X-MC-Unique: KA4gKa6mOzePHQoflLb67g-1
Received: by mail-ed1-f72.google.com with SMTP id a14so10040001edx.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 04:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=DVW20RJ7WUVVN7ibW9FVgUm0GXhEiqkS0bE0L/Mdba8=;
 b=E0tzZ6fBR3ZZPN+tbB6h2QsfQwxZWch329Z4+N0KhBBJo7nIQrICawhHiKOV0/T+B8
 CwBOP61qfoEs+73MaC7HlLQrPyz4ARn0ZD4D5pXv/neScvWCfzEahCflIcrT2/TQyCNa
 RzhBwjk+HUhuK3gO2mPyQ8DZnkVVFQqWl/uYvVRg+NZSRP6pjLVwqUG31Jc37Nn6zAB3
 IPrQrnE/7yHjMkeLitfAu1DoKIEXHJlPwVZrmEgkxI4DDFHuJOd/Ryt6CbMHQknqMfe/
 n+0CeJHVzrgllIqwPO79U5fpR+LVGh6rXnnjHt8WXqnlUZn6DcCkQo+zV8zLhb2u59fR
 2B9g==
X-Gm-Message-State: AOAM530esI9QXKwhQgTRwIx0Dk5cuMAMHQ9oLSKXLiUAAOODlbhuo4zQ
 Nf7l+CVU4QGQKLCba3A5ESpnR7sDor5nOdcoXHNc2jySct4G/rGW79zPQN92F1lveM6fw7b8vr2
 hgpAdA23wcr4MtAk=
X-Received: by 2002:a17:906:9493:: with SMTP id
 t19mr5342168ejx.407.1590578962786; 
 Wed, 27 May 2020 04:29:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyO1P+wwJ16RAgJZa/HrHq0Ln2rxIiILsdO3TtuTLb/eo94v7+T2doYAsztmCnGg7TmBQZumA==
X-Received: by 2002:a17:906:9493:: with SMTP id
 t19mr5342144ejx.407.1590578962481; 
 Wed, 27 May 2020 04:29:22 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id l18sm957639eds.46.2020.05.27.04.29.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 04:29:21 -0700 (PDT)
Subject: Re: [PATCH v6 0/5] fw_cfg: Add FW_CFG_DATA_GENERATOR; crypto: Add
 tls-cipher-suites
To: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20200519182024.14638-1-philmd@redhat.com>
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
Message-ID: <5ed708d2-1af4-c8e8-58a0-3208550f05b8@redhat.com>
Date: Wed, 27 May 2020 13:29:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200519182024.14638-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:45:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Daniel,

On 5/19/20 8:20 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> This series has two parts:
> 
> - First we add the ability to QOM objects to produce data
>   consumable by the fw_cfg device,
> 
> - Then we add the tls-cipher-suites object, and let it
>   implement the FW_CFG_DATA_GENERATOR interface.

Can I have a quick feedback that you are not going to NAck this series
later before addressing all comments from Laszlo's reviews?

Thanks!

Phil.

> 
> This is required by EDK2 'HTTPS Boot' feature [*] to tell
> the guest which TLS ciphers it can use.
> 
> [*]: https://github.com/tianocore/edk2/blob/master/OvmfPkg/README
> 
> Since v5:
> - Complete rewrite after chatting with Daniel Berrangé
> Since v4:
> - Addressed Laszlo comments (see patch#1 description)
> Since v3:
> - Addressed Markus' comments (do not care about heap)
> Since v2:
> - Split of
> Since v1:
> - Addressed Michael and Laszlo comments.
> 
> Please review,
> 
> Phil.
> 
> v5: https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04525.html
> v4: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04300.html
> v3: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02965.html
> v2: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02522.html
> v1: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01598.html
> Supersedes: <20190620122132.10075-1-philmd@redhat.com>
> 
> Philippe Mathieu-Daudé (5):
>   hw/nvram/fw_cfg: Add the FW_CFG_DATA_GENERATOR interface
>   softmmu/vl: Let -fw_cfg option take a 'blob_id' argument
>   softmmu/vl: Allow -fw_cfg 'blob_id' option to set any file pathname
>   crypto: Add tls-cipher-suites object
>   crypto/tls-cipher-suites: Product fw_cfg consumable blob
> 
>  include/crypto/tls-cipher-suites.h |  39 ++++++++
>  include/hw/nvram/fw_cfg.h          |  49 ++++++++++
>  crypto/tls-cipher-suites.c         | 152 +++++++++++++++++++++++++++++
>  hw/nvram/fw_cfg.c                  |  30 ++++++
>  softmmu/vl.c                       |  19 +++-
>  crypto/Makefile.objs               |   1 +
>  6 files changed, 285 insertions(+), 5 deletions(-)
>  create mode 100644 include/crypto/tls-cipher-suites.h
>  create mode 100644 crypto/tls-cipher-suites.c
> 


