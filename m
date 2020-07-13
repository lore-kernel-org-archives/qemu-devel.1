Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BB8C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3023206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bC6PMIIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3023206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juuuA-00057N-8o
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juutO-0003x8-Uo
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:36:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43504
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juutM-0007bZ-D8
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594633015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6s2QD1QPxVNLI6xES735AXhUKZ6Jr/Rd7Ih3qLJ75x8=;
 b=bC6PMIIVGg9K1uFn4hNRz/85/BkyLbgQgWDmOv6w6AiWoGky1KC3svmMdY6Evv75pTLPzo
 ghYhb/9CaABpw3ylYkhTlhFDqZUWT3/z8AYjOgqq4Bi2jGuE1w7djcpd5sVeOcbe91no7e
 pJU8mDd7ZzvGbly6qf03tq3ca9K+z2c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-Tg-YSckCOs-eb1hq8stupA-1; Mon, 13 Jul 2020 05:36:54 -0400
X-MC-Unique: Tg-YSckCOs-eb1hq8stupA-1
Received: by mail-wm1-f69.google.com with SMTP id f68so15833171wmf.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 02:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=6s2QD1QPxVNLI6xES735AXhUKZ6Jr/Rd7Ih3qLJ75x8=;
 b=a4jlajpJUgj1QxoGfo5LExmr+O6OAejFjOs3bdo1tV3YVCn3c7eKMr/AVzQZO5n+2T
 4+NZrH1E6eOxBBQRHUHxuPtYrLdm+tuueSxdk5CeqIgvz84uZb3TN5Isn13RxMoIxPIz
 aGjS+dS9wnzqa4cnI2EKJYr0s/tSSDwiJcnJ/gKnmRt2Us32sTfN1w8H3vy1zXmUTM/z
 Ku0lw4kwhKOxtUtSiu47idgj/NMYqWnizyjqnNpMYvCz+jmnZCTA+2GylWx3ypPYmq4t
 cADKOPUBZoDcacBfD6EiOPpFYnIqpBjTDmJFMVOA2/9jzUFtFYcDicxmbIfHfhmX8znQ
 us2A==
X-Gm-Message-State: AOAM531VRA6H+A6ONcNEeA8HujWHeuIJuCs8r0yemdXMs+Pq65Z7PgAw
 dEMSjVhUqynfWmcrAvuNAzkcREvV10eLXMrn/l4ffeIXXtk0PmJb88xT5ScesUvfPceRSkl7bO7
 wUma0q6ogBBwCfdQ=
X-Received: by 2002:a5d:6846:: with SMTP id o6mr79515909wrw.370.1594633013068; 
 Mon, 13 Jul 2020 02:36:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOlsVjNmbC7eJuSeIMlfgUAUD6WQvqPvFXP21ksCrL8gqU6venFjcC49UZZCczvIpfWBp4fw==
X-Received: by 2002:a5d:6846:: with SMTP id o6mr79515887wrw.370.1594633012837; 
 Mon, 13 Jul 2020 02:36:52 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id s203sm23272433wms.32.2020.07.13.02.36.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 02:36:52 -0700 (PDT)
Subject: Re: [PATCH v5 16/16] python/qemu: Add mypy type annotations
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200710052220.3306-1-jsnow@redhat.com>
 <20200710052220.3306-17-jsnow@redhat.com>
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
Message-ID: <d41dd642-149f-17ab-61ca-b07139fee1cd@redhat.com>
Date: Mon, 13 Jul 2020 11:36:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200710052220.3306-17-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 7:22 AM, John Snow wrote:
> These should all be purely annotations with no changes in behavior at
> all. You need to be in the python folder, but you should be able to
> confirm that these annotations are correct (or at least self-consistent)
> by running `mypy --strict qemu`.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/accel.py   |  8 ++--
>  python/qemu/machine.py | 94 ++++++++++++++++++++++++------------------
>  python/qemu/qmp.py     | 44 +++++++++++---------
>  python/qemu/qtest.py   | 26 +++++++-----
>  4 files changed, 98 insertions(+), 74 deletions(-)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


