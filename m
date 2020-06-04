Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8AFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:20:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A30A2067B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvPbh2Dz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A30A2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgl6m-0000h4-Hg
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 04:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgl6A-0008PL-B3
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:19:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56579
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgl68-0003SH-F8
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591258775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9D2vYb4INb/R/szgShFGar3EwwBkRx+/rRVH4eTILvk=;
 b=EvPbh2DzfT2iXuIeOevRMNkQ9jcbqolqAkp8Ux6LVeAsFbXlwGalPBWg23lVWAIFsOe51+
 hB/4s6Z6YCBvwrxgrtqTTyJnEhcO1FviTBYPhP7q74g3GpiXRP5RBynFJwQuCtUYjJxTd1
 WDWysJk6jGAqkH1jiQHMZLtKF5WWyLM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-PjH4ohrnO_CcAPxNVNn5Lw-1; Thu, 04 Jun 2020 04:19:33 -0400
X-MC-Unique: PjH4ohrnO_CcAPxNVNn5Lw-1
Received: by mail-wr1-f70.google.com with SMTP id t5so2092188wro.20
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 01:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=9D2vYb4INb/R/szgShFGar3EwwBkRx+/rRVH4eTILvk=;
 b=boN+sE/9WczTXekLDG3JxZxWtQs22wngC71FAReaFyIlA/tvnTJ5QP/7tAc8Dksqq4
 q47k72iwGX6WWYxQPL1SG+aP5Qhc10b1eo0VV7dfLRuQMK5j9eUK2JBH2fUG/7iPtA20
 v7Z01ZfEgm9AQTY8jFyszqpoi0u1a3av0Fe//Pn3nRX8jMNz1+uUV41WWfHdngxuH8kA
 wOvNzvKT4y2FBdKV6vlNO3aQ+T+z2pqKTXIC6TSUG2xLJDvgw5mFhaz7Obq5mLF+6cqm
 XJxuKEgkQtaXEo1NGO+bWeReitlOiYYVBdNJJQp4aPV5V1RukILlC7APP+1mRHXxoaD7
 2ziw==
X-Gm-Message-State: AOAM5322jv6p55ogdVJyCoMyxpp0VTd+DBliQlLtqVVjYxI4rEuUYk9b
 vq8JKV4G0iSXZrdg/OkX9XLQH7J5zgJbjVEORXXOa5vsi5qMPNo7zucrf1i3INp7/GW8YKClef1
 VQJXTYd6ciXaovXw=
X-Received: by 2002:a5d:4705:: with SMTP id y5mr3031526wrq.98.1591258772206;
 Thu, 04 Jun 2020 01:19:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1BiBHHeI/LYSZMDwKozCWSN+w/vPPp967XTtvTkbE9sL2XIXhEAjqrABHd/iC4Hmk4vTCqw==
X-Received: by 2002:a5d:4705:: with SMTP id y5mr3031496wrq.98.1591258771950;
 Thu, 04 Jun 2020 01:19:31 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id l1sm7947035wrb.31.2020.06.04.01.19.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 01:19:31 -0700 (PDT)
Subject: python/qemu: Refactor QemuBinaryInfo
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 John Snow <jsnow@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
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
Message-ID: <8be12c09-98c5-2169-c946-b8689a31c7cf@redhat.com>
Date: Thu, 4 Jun 2020 10:19:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:12:15
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/29/20 10:23 PM, Philippe Mathieu-Daudé wrote:
[...]
>   accel/accel: Make TYPE_ACCEL abstract
>   python/qemu: Add binutils::binary_get_version()
>   tests/acceptance: Use 'version-min' tag to verify QEMU binary version
>   tests/acceptance: Restrict X86CPUModelAliases test to QEMU >= 4.1
>   python/qemu: Add binutils::binary_get_arch()
>   tests/acceptance: Use the 'arch' tag to verify QEMU binary target
>   python/qemu: Add binutils::binary_get_machines()
>   tests/acceptance: Use 'machine' tag to check if available in QEMU
>     binary
>   python/qemu: Add binutils::binary_get_qom_implementations()
>   python/qemu: Add binutils::binary_get_accels()
>   python/qemu/accel: Use binutils::binary_get_accels()
>   python/qemu: Add binutils::binary_get_devices()

I just noticed various of these methods are already implemented in
QemuBinaryInfo (see scripts/device-crash-test), so I guess it'd be
better to start refactoring from there (to the recent QEMU package).

> 
>  accel/accel.c                                 |   1 +
>  hw/core/machine.c                             |   3 +-
>  MAINTAINERS                                   |   6 +
>  python/qemu/accel.py                          |  26 +----
>  python/qemu/binutils.py                       | 107 ++++++++++++++++++
[...]


