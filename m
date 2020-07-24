Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DE9C433E8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA4420768
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9HY6Mp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA4420768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyqhZ-0000gW-2N
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 01:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyqgk-0000D5-Gc
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 01:56:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43472
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyqgi-00031U-2y
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 01:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595570167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bw8VM6Kv7dfUBMmg551uil27WbftlRLXHT1Fwz/B2Nk=;
 b=e9HY6Mp9cSp9+3bRsNhGy5gvWGgeEDdZDj1GcjeT90M4F2gbk5kgFKy9tqH9zFCnOEhmRe
 4qSezraWv1KMabUC1IVCYebgDYE5yjTpHRgt0lhnzfU8InDhEcis201Bm3QcSz1ID1C+Al
 BnKypT8ilGk4cGrhrQSVGjtciUGXRgc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-7VQKIp68OWyNZ6BjpAHlYA-1; Fri, 24 Jul 2020 01:56:05 -0400
X-MC-Unique: 7VQKIp68OWyNZ6BjpAHlYA-1
Received: by mail-wm1-f69.google.com with SMTP id t26so2938912wmn.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 22:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bw8VM6Kv7dfUBMmg551uil27WbftlRLXHT1Fwz/B2Nk=;
 b=nUz5dmduYH+cWN9fLptYLPhUpL7G6FvBHoDhBFkaWr4knz71JOhjbiaxNMzVinyJOm
 kl0DPxhJt4odO5OQBVh0oH+D/9cnCvq/ZeNxS1jsKCkh8pn/Xt5qwSYP94aIh46bUr7t
 5nrZplWrPXcdlDYr60peyoIP3SPo8klmk002mLjz9kbl2jqNljTarNi9zWr/11oSKqZN
 TRn1tPhSlUBG1xyCF/0n2DZY0lFpSKwW5ksSEsaZtd2U4mIPmqDVgaKgBXGL8Wly8ID3
 7BnCvtRfW00KZJTvqTfrVlUTr9QVCNFJ+U3Bexi/z5DUGjXmWE3aAuMUzTsyXHIbB4pD
 mfkA==
X-Gm-Message-State: AOAM533EYwE7qD9rCoru1VQ2mQdV4FzSAXoc6rZdm9MbSfOb+9QC2YyE
 qUhaLEhyMCSw0+r6UufzdlABg82V1UQqx6pK22qIU7w/KjNphkCydeO3Vx6m20OzCs/OQ1CEZdx
 iRBN/4s+3xD3MWjg=
X-Received: by 2002:adf:ca03:: with SMTP id o3mr225850wrh.330.1595570164131;
 Thu, 23 Jul 2020 22:56:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxet66/DSQ49CyGHPr8tG4NIRvB+RRumCFKupr9yucb/6DKkoIROMrk1tJ005ZjYu77CPs3Gw==
X-Received: by 2002:adf:ca03:: with SMTP id o3mr225840wrh.330.1595570163901;
 Thu, 23 Jul 2020 22:56:03 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 78sm6126326wma.31.2020.07.23.22.56.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 22:56:03 -0700 (PDT)
Subject: Re: Avocado error fetching QEMU boot_linux.py assets
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: qemu-devel <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 avocado-devel <avocado-devel@redhat.com>
References: <9173c3d6-df1f-b719-f124-fc6cf3ecb9f6@redhat.com>
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
Message-ID: <7c12e791-ec29-809c-5ddf-30f3a14a4d6b@redhat.com>
Date: Fri, 24 Jul 2020 07:56:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9173c3d6-df1f-b719-f124-fc6cf3ecb9f6@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 01:23:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/24/20 7:43 AM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> [cross list post]
> 
> Using QEMU at commit 3cbc8970f5 I'm getting this error:
> 
> Fetching assets from tests/acceptance/boot_linux_console.py.
> Fetching assets from tests/acceptance/boot_linux.py.
> Traceback (most recent call last):
>   File "/usr/lib64/python3.7/runpy.py", line 193, in _run_module_as_main
>     "__main__", mod_spec)
>   File "/usr/lib64/python3.7/runpy.py", line 85, in _run_code
>     exec(code, run_globals)
>   File
> "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/__main__.py",
> line 11, in <module>
>     sys.exit(main.run())
>   File
> "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/core/app.py",
> line 91, in run
>     return method(self.parser.config)
>   File
> "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/plugins/assets.py",
> line 291, in run
>     success, fail = fetch_assets(test_file)
>   File
> "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/plugins/assets.py",
> line 200, in fetch_assets
>     handler = FetchAssetHandler(test_file, klass, method)
>   File
> "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/plugins/assets.py",
> line 65, in __init__
>     self.visit(self.tree)
>   File "/usr/lib64/python3.7/ast.py", line 271, in visit
>     return visitor(node)
>   File "/usr/lib64/python3.7/ast.py", line 279, in generic_visit
>     self.visit(item)
>   File "/usr/lib64/python3.7/ast.py", line 271, in visit
>     return visitor(node)
>   File
> "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/plugins/assets.py",
> line 139, in visit_ClassDef
>     self.generic_visit(node)
>   File "/usr/lib64/python3.7/ast.py", line 279, in generic_visit
>     self.visit(item)
>   File "/usr/lib64/python3.7/ast.py", line 271, in visit
>     return visitor(node)
>   File
> "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/plugins/assets.py",
> line 171, in visit_Assign
>     self.asgmts[cur_klass][cur_method][name] = node.value.s
> KeyError: 'launch_and_wait'

FYI here cur_klass='BootLinuxX8664' and name='chksum'.

> 
> Same if I revert these:
> 0f26d94ec9 ("tests/acceptance: skip s390x_ccw_vrtio_tcg on GitLab")
> 1c80c87c8c ("tests/acceptance: refactor boot_linux to allow code reuse")
> 
> If I remove boot_linux.py, all other files are processed correctly.
> 
> Any idea what can be wrong here?
> 
> Thanks,
> 
> Phil.
> 


