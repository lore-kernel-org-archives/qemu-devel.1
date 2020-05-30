Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB24C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 19:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A606F20722
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 19:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYb+hO5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A606F20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jf7FV-0005hz-TO
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 15:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jf7El-00055v-9k
 for qemu-devel@nongnu.org; Sat, 30 May 2020 15:33:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35044
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jf7Ej-0002te-Bm
 for qemu-devel@nongnu.org; Sat, 30 May 2020 15:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590867219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Vo9S9vxP4crDxCzMYi7QxBeEx7gqH4LpdeP1PdyjQso=;
 b=XYb+hO5ogzzdZU6ih5U5ighzWLLD6IUEl/IeEiFlGrW7sE5ARe56crFlvyNGvyzuoqcMBg
 QJ1INpShohbgan2eawztKKILXiRLlggpGIJ7YZDujoAKiG/Qc+RaG4ml9G6/wT50jSJcTm
 uCvct8ioM6oK2Ssj2fnL0UJvjTYAEnE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-PuEsrPoMMcaY3VLqq1l7ow-1; Sat, 30 May 2020 15:33:35 -0400
X-MC-Unique: PuEsrPoMMcaY3VLqq1l7ow-1
Received: by mail-wm1-f72.google.com with SMTP id 18so1890078wmu.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2020 12:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Vo9S9vxP4crDxCzMYi7QxBeEx7gqH4LpdeP1PdyjQso=;
 b=sKRoW4vwc7q1VP1CvnTOOD1zuL+Tl4CADyNoyzwAbcq14YnuplmnfacLQ7tJRXBjmV
 0okIrU8QdtnhSvcEm8ld19bB22IT/Ra3sqvJf1tX+3aG//auVQrJKn6IC6bEEExNf22B
 PwJLKS7+gtIgpDaOfHMBm0sZNVPiMOo2wu5PngxNR/uq4VAHoUZBURKpRoAl3UdD/tVr
 5uo24auR6j50tqIBb0tIojf/x7NhrTa2KGxq0oN37xUl18edD8sW8HhttSftlB/u0Vu5
 d9zW3sEEAhvcna+TaDdRS8/kSxzngoq1C3KHZTMMDiQvDXbreUkiwJFrR86H8k7jL9tg
 EjVA==
X-Gm-Message-State: AOAM533Vf6uSHaxPJdmlCs0IT/43L2LXrl+t358DPRSfk/GGFVpIaaRw
 epgxBvZwq4GuoIPAXEb4eW5J2s5etVVUmwJg3quOonz8MY+c4uyhmVr6nFnvPESXWNwth1Ljcp8
 F4utg85PDgYhBAgI=
X-Received: by 2002:adf:f988:: with SMTP id f8mr15545853wrr.81.1590867214265; 
 Sat, 30 May 2020 12:33:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFGE3GAxLUF25ml0e6UFZnUz59nbVGoF8O7Re6xDDExJhkzBqXlZcK7MDUdjkQ7nmRCiCHrA==
X-Received: by 2002:adf:f988:: with SMTP id f8mr15545838wrr.81.1590867214015; 
 Sat, 30 May 2020 12:33:34 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id h137sm5375099wme.0.2020.05.30.12.33.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 May 2020 12:33:33 -0700 (PDT)
Subject: Re: [PATCH 0/4] python: pylint and flake8 support
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200528222129.23826-1-jsnow@redhat.com>
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
Message-ID: <120164fd-a4f2-0c07-efd6-846f2de40892@redhat.com>
Date: Sat, 30 May 2020 21:33:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200528222129.23826-1-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/30 15:33:39
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
Cc: Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 12:21 AM, John Snow wrote:
> This is a quick series to delint the files under python/qemu, with one
> extra fix outside of that domain.
> 
> This was split out from my longer series attempting to package
> python/qemu. This part is a nice standalone chunk.
> 
> John Snow (4):
>   scripts/qmp: Fix shebang and imports
>   python/machine.py: remove bare except
>   python/qemu: delint and add pylintrc
>   python/qemu: delint; add flake8 config
> 
>  python/qemu/.flake8    |  2 ++
>  python/qemu/accel.py   |  9 ++++---
>  python/qemu/machine.py | 52 +++++++++++++++++++++++--------------
>  python/qemu/pylintrc   | 58 ++++++++++++++++++++++++++++++++++++++++++
>  python/qemu/qmp.py     |  4 +--
>  python/qemu/qtest.py   | 42 +++++++++++++++++++-----------
>  scripts/qmp/qmp        |  4 ++-
>  scripts/qmp/qom-fuse   |  4 ++-
>  scripts/qmp/qom-get    |  6 +++--
>  scripts/qmp/qom-list   |  6 +++--
>  scripts/qmp/qom-set    |  6 +++--
>  scripts/qmp/qom-tree   |  6 +++--
>  12 files changed, 150 insertions(+), 49 deletions(-)
>  create mode 100644 python/qemu/.flake8
>  create mode 100644 python/qemu/pylintrc
> 

Thanks, patches 1/3/4 applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next

I skipped patch #2 which doesn't apply on top on Vladimir's "hard-kill"
patch:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg680200.html


