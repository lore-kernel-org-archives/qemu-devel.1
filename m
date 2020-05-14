Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE5CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:17:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB9120575
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsmKe+51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB9120575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ7BC-0006pv-7Q
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ6qx-000163-3l
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:56:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59706
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ6qw-0002GG-1t
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589435777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=68jLqOJB/BM2cWHsomEjtXhy2xP7EBKU5fvCrHn51ys=;
 b=JsmKe+51XCvwkMq4jd0n9/NTdk+OW3f47DdBqjR/Cc/5R1z0l5H5RmG+EdOfD/vUEo56Ue
 sxUbBOwPqWJcHhzVuCT0HPC7c+PXzJ7OUBaQyro20kaxr/3ExYCitgUcIgoFONMsf2RpwJ
 gO7Aev/5Lh6sqO3eFdGSoqSF6Ob7kHw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-PNfZYxiDM66ofE1RnxErdA-1; Thu, 14 May 2020 01:56:15 -0400
X-MC-Unique: PNfZYxiDM66ofE1RnxErdA-1
Received: by mail-wm1-f70.google.com with SMTP id w2so12932657wmc.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 22:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=68jLqOJB/BM2cWHsomEjtXhy2xP7EBKU5fvCrHn51ys=;
 b=CpIXK9p3rRp0s7Wv8/n7uuNm11keFHeyYa8pOQd6vbyet5SP3hR2mfm/p+vpTjh1j+
 P/lby/Ky+xHIHoHfROo8gJSDPJgPxmZV72S3A3g6Y2iiwQzY2E4SVaXq7nIoWynWL9+i
 udtcv71jQ/25iOvJcS8Bp4OA6YynUpLrUVTULnkCvwyvr/6kkGuYTh/4IePDIjK2KPiZ
 QTbkJ2NCjhqCPYZ9ItUoPnVRfIR+Ee5u1lauXF1jLVxdAz6TDXXG3FOJPz7Vl47Ih5Fz
 ICiiIoEwKs1BiUptK3GAxTZkQrrJ/podWRZ/F1LMhTyE6ogCsWMVBoySQexaDdXlPjGd
 i9yg==
X-Gm-Message-State: AOAM533Eu3GfJ6vFerUy5pi5ia+sOZpl69nKp3xHBig9KPD5mKnXO8RL
 Sjyva6xJJ8Qy4IamzyvEVEPOGdM0PEOjCvatznGShEUL/9V7W9VF+7l+CrAXkjguaCxA7UcbKjD
 JPSzQXKGNqdKt1Gg=
X-Received: by 2002:adf:fdd0:: with SMTP id i16mr3296622wrs.389.1589435774530; 
 Wed, 13 May 2020 22:56:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzEoSiYV8JjE7oiEdWPeqWa4FTFpc6GtdM5q+TMKAaGECgfn79ugz2bB++hSUq2RhyXfNZyg==
X-Received: by 2002:adf:fdd0:: with SMTP id i16mr3296595wrs.389.1589435774223; 
 Wed, 13 May 2020 22:56:14 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id v20sm2628071wrd.9.2020.05.13.22.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 22:56:13 -0700 (PDT)
Subject: Re: [PATCH] python: remove more instances of sys.version_info
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514035230.25756-1-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <960e3cfa-73ea-c5bf-7fba-0007acc0d6e7@redhat.com>
Date: Thu, 14 May 2020 07:56:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514035230.25756-1-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 5:52 AM, John Snow wrote:
> We guarantee 3.5+ everywhere; remove more dead checks. In general, try
> to avoid using version checks and instead prefer to attempt behavior
> when possible.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   scripts/analyze-migration.py             |  5 -----
>   scripts/decodetree.py                    | 25 +++++++++---------------
>   scripts/qmp/qmp-shell                    |  3 ---
>   tests/docker/docker.py                   |  5 +++--
>   tests/qemu-iotests/nbd-fault-injector.py |  5 +----
>   5 files changed, 13 insertions(+), 30 deletions(-)
> 
> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> index 96a31d3974..95838cbff3 100755
> --- a/scripts/analyze-migration.py
> +++ b/scripts/analyze-migration.py
> @@ -25,11 +25,6 @@
>   import sys
>   
>   
> -MIN_PYTHON = (3, 2)
> -if sys.version_info < MIN_PYTHON:
> -    sys.exit("Python %s.%s or later is required.\n" % MIN_PYTHON)
> -
> -
>   def mkdir_p(path):
>       try:
>           os.makedirs(path)
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index 46ab917807..f9d204aa36 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -75,13 +75,6 @@ def output(*args):
>           output_fd.write(a)
>   
>   
> -if sys.version_info >= (3, 4):
> -    re_fullmatch = re.fullmatch
> -else:
> -    def re_fullmatch(pat, str):
> -        return re.match('^' + pat + '$', str)
> -
> -
>   def output_autogen():
>       output('/* This file is autogenerated by scripts/decodetree.py.  */\n\n')
>   
> @@ -428,18 +421,18 @@ def parse_field(lineno, name, toks):
>       width = 0
>       func = None
>       for t in toks:
> -        if re_fullmatch('!function=' + re_ident, t):
> +        if re.fullmatch('!function=' + re_ident, t):
>               if func:
>                   error(lineno, 'duplicate function')
>               func = t.split('=')
>               func = func[1]
>               continue
>   
> -        if re_fullmatch('[0-9]+:s[0-9]+', t):
> +        if re.fullmatch('[0-9]+:s[0-9]+', t):
>               # Signed field extract
>               subtoks = t.split(':s')
>               sign = True
> -        elif re_fullmatch('[0-9]+:[0-9]+', t):
> +        elif re.fullmatch('[0-9]+:[0-9]+', t):
>               # Unsigned field extract
>               subtoks = t.split(':')
>               sign = False
> @@ -488,11 +481,11 @@ def parse_arguments(lineno, name, toks):
>       flds = []
>       extern = False
>       for t in toks:
> -        if re_fullmatch('!extern', t):
> +        if re.fullmatch('!extern', t):
>               extern = True
>               anyextern = True
>               continue
> -        if not re_fullmatch(re_ident, t):
> +        if not re.fullmatch(re_ident, t):
>               error(lineno, 'invalid argument set token "{0}"'.format(t))
>           if t in flds:
>               error(lineno, 'duplicate argument "{0}"'.format(t))
> @@ -621,13 +614,13 @@ def parse_generic(lineno, is_format, name, toks):
>               continue
>   
>           # 'Foo=%Bar' imports a field with a different name.
> -        if re_fullmatch(re_ident + '=%' + re_ident, t):
> +        if re.fullmatch(re_ident + '=%' + re_ident, t):
>               (fname, iname) = t.split('=%')
>               flds = add_field_byname(lineno, flds, fname, iname)
>               continue
>   
>           # 'Foo=number' sets an argument field to a constant value
> -        if re_fullmatch(re_ident + '=[+-]?[0-9]+', t):
> +        if re.fullmatch(re_ident + '=[+-]?[0-9]+', t):
>               (fname, value) = t.split('=')
>               value = int(value)
>               flds = add_field(lineno, flds, fname, ConstField(value))
> @@ -635,7 +628,7 @@ def parse_generic(lineno, is_format, name, toks):
>   
>           # Pattern of 0s, 1s, dots and dashes indicate required zeros,
>           # required ones, or dont-cares.
> -        if re_fullmatch('[01.-]+', t):
> +        if re.fullmatch('[01.-]+', t):
>               shift = len(t)
>               fms = t.replace('0', '1')
>               fms = fms.replace('.', '0')
> @@ -652,7 +645,7 @@ def parse_generic(lineno, is_format, name, toks):
>               fixedmask = (fixedmask << shift) | fms
>               undefmask = (undefmask << shift) | ubm
>           # Otherwise, fieldname:fieldwidth
> -        elif re_fullmatch(re_ident + ':s?[0-9]+', t):
> +        elif re.fullmatch(re_ident + ':s?[0-9]+', t):
>               (fname, flen) = t.split(':')
>               sign = False
>               if flen[0] == 's':
> diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
> index a01d31de1e..c5eef06f3f 100755
> --- a/scripts/qmp/qmp-shell
> +++ b/scripts/qmp/qmp-shell
> @@ -77,9 +77,6 @@ import re
>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
>   from qemu import qmp
>   
> -if sys.version_info[0] == 2:

:)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> -    input = raw_input
> -
>   class QMPCompleter(list):
>       def complete(self, text, state):
>           for cmd in self:
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index d8268c1111..5a9735db78 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -258,12 +258,13 @@ def _kill_instances(self, *args, **kwargs):
>           return self._do_kill_instances(True)
>   
>       def _output(self, cmd, **kwargs):
> -        if sys.version_info[1] >= 6:
> +        try:
>               return subprocess.check_output(self._command + cmd,
>                                              stderr=subprocess.STDOUT,
>                                              encoding='utf-8',
>                                              **kwargs)
> -        else:
> +        except TypeError:
> +            # 'encoding' argument was added in 3.6+
>               return subprocess.check_output(self._command + cmd,
>                                              stderr=subprocess.STDOUT,
>                                              **kwargs).decode('utf-8')
> diff --git a/tests/qemu-iotests/nbd-fault-injector.py b/tests/qemu-iotests/nbd-fault-injector.py
> index 588d62aebf..78f42c4214 100755
> --- a/tests/qemu-iotests/nbd-fault-injector.py
> +++ b/tests/qemu-iotests/nbd-fault-injector.py
> @@ -47,10 +47,7 @@
>   import socket
>   import struct
>   import collections
> -if sys.version_info.major >= 3:
> -    import configparser
> -else:
> -    import ConfigParser as configparser
> +import configparser
>   
>   FAKE_DISK_SIZE = 8 * 1024 * 1024 * 1024 # 8 GB
>   
> 


