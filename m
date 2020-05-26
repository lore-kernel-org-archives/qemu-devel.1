Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44730C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 129C8206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SW+g20V5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129C8206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdc5F-0007lu-6g
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdc0c-000223-2O
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:00:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41903
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdc0I-0004Lc-OC
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590508830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z4sgj3+NyEy/3+mBjY3Nt+b+4prcl2HAo8tM6GCa4FY=;
 b=SW+g20V592lH2irpk8A7lGCXCGDTC6YKh1xKc/Akic0HMVRk7TQhUcI+dd1g48WmQg2VcX
 nYYxL95Rk+mLwZWJPbjS3rRrb5RPhiQs2LMi22p/e2Eya8OwqoSe4ctPDZuDR7A5QopSex
 rebviEHXj0O2AnBtbzEzbXYh1BD0FEo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-r7cznSpoOg-fajyYc1uleA-1; Tue, 26 May 2020 12:00:16 -0400
X-MC-Unique: r7cznSpoOg-fajyYc1uleA-1
Received: by mail-ed1-f69.google.com with SMTP id w15so8533277edi.11
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 09:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Z4sgj3+NyEy/3+mBjY3Nt+b+4prcl2HAo8tM6GCa4FY=;
 b=LNleE9UB+iXJKquQoHyd7rfS1GflZwfIYKU9yqV7572ooPyPkK5ayX0aVrc6+8S/3Q
 FJYBeUpd1EdWlgfS4kqlqawiAycsBRL/0IYuxyNovSSNLOy/UAS8kF/xcbw2LXfgmI6/
 rL2xDdheQKhxQkolc1uxFJgjQqWOlvWc8uW+qmQl/AANArvkFqbjxllSefWsCXiRnmI1
 9lX8/2v36AMYvPw1zPaHcoLIsjzvs4xDBRZA6K6txUAo+p+XgphHP4ex3NHFhm9bd8ip
 WvlE42cCgwp3xvhc/a61rlw7SxDfIlpdH+Fc1pP5al7DpcCihmp9+9fl0tMBUis5Y95h
 CiZA==
X-Gm-Message-State: AOAM531wPxTe5OCapj+9bdp2gJIl7UoOz/AGM5XnOYLLYhauo/nVzXGg
 XNYSPC9FAR/AgIDp8uljDCvpCQTUfdZgcF91QOITSeJXKwJmXj5dCuwAWxiPdVO3cmjM29HbT/e
 kkj4iOmriP+gpDIA=
X-Received: by 2002:a17:906:7750:: with SMTP id
 o16mr1812572ejn.12.1590508814645; 
 Tue, 26 May 2020 09:00:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkxg9mifNluU2U//fPO/S4BmBUg+9kjSZc/EHxG7lC+jdLnwfQ63TeVhjm0JGd98GZhbhtyQ==
X-Received: by 2002:a17:906:7750:: with SMTP id
 o16mr1812536ejn.12.1590508814403; 
 Tue, 26 May 2020 09:00:14 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id ld9sm260307ejb.30.2020.05.26.09.00.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 09:00:13 -0700 (PDT)
Subject: Re: [PATCH RFC 06/32] python/qemu: formalize as package
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-7-jsnow@redhat.com>
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
Message-ID: <68ac7059-7890-c4a1-7280-4dc4aa52c888@redhat.com>
Date: Tue, 26 May 2020 18:00:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514055403.18902-7-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 7:53 AM, John Snow wrote:
> NB: I am choosing Python 3.6 here. Although our minimum requirement is
> 3.5, this code is used only by iotests (so far) under which we have been
> using a minimum version of 3.6.

Preferably with another Ack-by from someone familiar with Python iotests:
Acked-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> 3.6 is being preferred here for variable type hint capability, which
> enables us to use mypy for this package.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/README.rst |  6 ++++++
>  python/setup.py   | 50 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
>  create mode 100644 python/README.rst
>  create mode 100755 python/setup.py
> 
> diff --git a/python/README.rst b/python/README.rst
> new file mode 100644
> index 0000000000..25f6d93fd5
> --- /dev/null
> +++ b/python/README.rst
> @@ -0,0 +1,6 @@
> +QEMU Python Tooling
> +-------------------
> +
> +This package provides QEMU tooling used by the QEMU project to build,
> +configure, and test QEMU. It is not a fully-fledged SDK and it is subject
> +to change at any time.
> diff --git a/python/setup.py b/python/setup.py
> new file mode 100755
> index 0000000000..f897ceac97
> --- /dev/null
> +++ b/python/setup.py
> @@ -0,0 +1,50 @@
> +#!/usr/bin/env3 python
> +"""
> +QEMU tooling installer script
> +Copyright (c) 2020 John Snow for Red Hat, Inc.
> +"""
> +
> +import setuptools
> +
> +def main():
> +    """
> +    QEMU tooling installer
> +    """
> +
> +    kwargs = {
> +        'name': 'qemu',
> +        'use_scm_version': {
> +            'root': '..',
> +            'relative_to': __file__,
> +        },
> +        'maintainer': 'QEMU Developer Team',
> +        'maintainer_email': 'qemu-devel@nongnu.org',
> +        'url': 'https://www.qemu.org/',
> +        'download_url': 'https://www.qemu.org/download/',
> +        'packages': setuptools.find_namespace_packages(),
> +        'description': 'QEMU Python Build, Debug and SDK tooling.',
> +        'classifiers': [
> +            'Development Status :: 5 - Production/Stable',
> +            'License :: OSI Approved :: GNU General Public License v2 (GPLv2)',
> +            'Natural Language :: English',
> +            'Operating System :: OS Independent',
> +        ],
> +        'platforms': [],
> +        'keywords': [],
> +        'setup_requires': [
> +            'setuptools',
> +            'setuptools_scm',
> +        ],
> +        'install_requires': [
> +        ],
> +        'python_requires': '>=3.6',
> +        'long_description_content_type': 'text/x-rst',
> +    }
> +
> +    with open("README.rst", "r") as fh:
> +        kwargs['long_description'] = fh.read()
> +
> +    setuptools.setup(**kwargs)
> +
> +if __name__ == '__main__':
> +    main()
> 


