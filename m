Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64065C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3BB42100A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5ByVCve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BB42100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJG9l-0006mN-MT
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 09:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJG70-00042h-Lt
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJG6r-00084D-Ft
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600434443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hkiaIOItr08iBtdiyysWI4MLKZLQNgyeAEoNXGvPDPI=;
 b=X5ByVCvewJCNFEGQ30wBjslGA9gb8XTJfBaM7VIkpix+4WSWwVQ0220hyTJWWyHeejOBzB
 qFa9Nsz3h72LBdcvnseoMd2ntbIJVEU7siPGKnXQ8Qk+vv4AUZ/bBgMbYr0cLpEfIoDLRO
 4nz01qTH/jvdqwb+1PAXx92PqEj4FOg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-vpSDn74tPj-IU8VysUH4WA-1; Fri, 18 Sep 2020 09:07:12 -0400
X-MC-Unique: vpSDn74tPj-IU8VysUH4WA-1
Received: by mail-wr1-f72.google.com with SMTP id l9so2097549wrq.20
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 06:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=hkiaIOItr08iBtdiyysWI4MLKZLQNgyeAEoNXGvPDPI=;
 b=R6Nl2DtdnrFVXHfgyFPboUyNJjDAYs/zu/JTjRkUSTiS3Wq72WBsX1Lfn92GFmR0SK
 CzZurNCjzFcSJZ5HogAHcsXkxAXVk9C2wRJESrb+UDBl6uru3YcuNlHETlrTQRNgZSbi
 c+EJOZPGL3mjvHXcq5ZPn/XoCGm9+6os3tY39q9z1byFq3K0uIxyrk9sEvNuO1oapTaD
 KHZXSrHi/VRQZbb3xtFh6w1QT4VUWESf2EV7YtUqyZeJ9GSs/NTEPuBxyJMTCj3bsb9M
 nHnWTBxGLBJBJGYVxQWUK1/HRM4Zv8Y5cDAATWBe8y9R7YalQJwIVzTWO8r7rStc3JWI
 lz2g==
X-Gm-Message-State: AOAM532mKLqhI0Zd6bzyET/lCF99J79cplwrFQmQmlSoq125N3ReTbsQ
 GjnkoV6T8xyXfC6r6qMYsi568dSOkHw6qAx+RV5eM+TbZoVocinavkuhDoBj2Cca14i4BhcKX4u
 J/xIOoCEbt4MPchU=
X-Received: by 2002:a05:600c:2105:: with SMTP id
 u5mr1469519wml.150.1600434430913; 
 Fri, 18 Sep 2020 06:07:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwP8HR4NZSE3oh85/a3t0nSdihIRYNpiN7BpaXnmn5M952AlEmGnCQAXvwzgEksgOgz3MYNUw==
X-Received: by 2002:a05:600c:2105:: with SMTP id
 u5mr1469507wml.150.1600434430702; 
 Fri, 18 Sep 2020 06:07:10 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id 63sm5580044wrh.71.2020.09.18.06.07.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 06:07:09 -0700 (PDT)
Subject: Re: [PATCH 00/37] qapi: static typing conversion, pt1
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
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
Message-ID: <17a3ca61-1c9a-8c0b-af89-2d9cad8c544b@redhat.com>
Date: Fri, 18 Sep 2020 15:07:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915224027.2529813-1-jsnow@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.869, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Ben Widawsky <ben@bwidawsk.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Ben who offered to help with having the QEMU python
scripts packaged (and this series is a step toward that).

On 9/16/20 12:39 AM, John Snow wrote:
> Hi, this series starts adding static type hints to the QAPI module. As
> you can see, the series started getting quite a bit long, so this is
> only a partial conversion that focuses on a handful of the easier files.
> 
> The tougher files -- schema.py, expr.py, parser.py -- will each receive
> their own series as a follow-up to this one.
> 
> Notes:
> 
> - This requires Python 3.6+. Python 3.5 is EOL, so let's do that.
> 
> - Any patch named "add notational type hints" changes ONLY signatures,
>   which have no runtime impact whatsoever. These are big patches,
>   but fairly straightforward.
> 
> - Most other patches are as bite-sized as possible, generally fixing one
>   single warning.
> 
> - After patch 6, `flake8 qapi/` should pass 100% on this and every
>   future commit.
> 
> - After patch 7, `pylint --rcfile=qapi/pylintrc qapi/` should pass 100%
>   on this and every future commit.
> 
> - After patch 16, `mypy --config-file=qapi/mypy.ini qapi/` should pass
>   100% on this and every future commit.
> 
> Preliminary refactoring and prerequisites:
> 
> 001/37: 'python: Require 3.6+'
> 002/37: '[DO-NOT-MERGE] qapi: add debugging tools'
> 003/37: 'qapi-gen: Separate arg-parsing from generation'
> 004/37: 'qapi: move generator entrypoint into module'
> 005/37: 'qapi: Remove wildcard includes'
> 006/37: 'qapi: delint using flake8'
> 007/37: 'qapi: add pylintrc'
> 
> common.py (and params.py):
> 
> 008/37: 'qapi/common.py: Remove python compatibility workaround'
> 009/37: 'qapi/common.py: Add indent manager'
> 010/37: 'qapi/common.py: delint with pylint'
> 011/37: 'qapi/common.py: Replace one-letter 'c' variable'
> 012/37: 'qapi/common.py: check with pylint'
> 013/37: 'qapi/common.py: add notational type hints'
> 014/37: 'qapi/common.py: Move comments into docstrings'
> 015/37: 'qapi/common.py: split build_params into new file'
> 016/37: 'qapi: establish mypy type-checking baseline'
> 
> events.py:
> 
> 017/37: 'qapi/events.py: add notational type hints'
> 018/37: 'qapi/events.py: Move comments into docstrings'
> 
> commands.py:
> 
> 019/37: 'qapi/commands.py: Don't re-bind to variable of different type'
> 020/37: 'qapi/commands.py: add notational type hints'
> 021/37: 'qapi/commands.py: enable checking with mypy'
> 
> source.py:
> 
> 022/37: 'qapi/source.py: add notational type hints'
> 023/37: 'qapi/source.py: delint with pylint'
> 
> gen.py:
> 
> 024/37: 'qapi/gen.py: Fix edge-case of _is_user_module'
> 025/37: 'qapi/gen.py: add notational type hints'
> 026/37: 'qapi/gen.py: Enable checking with mypy'
> 027/37: 'qapi/gen.py: Remove unused parameter'
> 028/37: 'qapi/gen.py: update write() to be more idiomatic'
> 029/37: 'qapi/gen.py: delint with pylint'
> 
> introspect.py:
> 
> 030/37: 'qapi/introspect.py: Add a typed 'extra' structure'
> 031/37: 'qapi/introspect.py: add _gen_features helper'
> 032/37: 'qapi/introspect.py: create a typed 'Node' data structure'
> 033/37: 'qapi/introspect.py: add notational type hints'
> 
> types.py:
> 
> 034/37: 'qapi/types.py: add notational type hints'
> 035/37: 'qapi/types.py: remove one-letter variables'
> 
> visit.py:
> 
> 036/37: 'qapi/visit.py: remove unused parameters from gen_visit_object'
> 037/37: 'qapi/visit.py: add notational type hints'


