Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F834C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7C6D206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAHdNyef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C6D206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdc6Z-0002Rt-46
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdc1Q-0002oI-7g
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:01:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55666
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdc1O-0004f1-MW
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590508901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ajdISOaE6SNJINKmJABPeXQIezeFcAQ/S+lAQV/QSqs=;
 b=AAHdNyefBoOgvDMf+OZcrg7afv0eLwd5yxlPtzLHBjSjM2/ZYbF2m7ZCiriBGt4F7/yYH/
 iuybWYraJPtUU3Z0mlV7OrN1cU5RgVLZAcKRCwCJrxq49NIVe6KoSLkXVALIW57d61Y9fu
 oVJDhkidzTj9pSFYhwAbRJVDy+cHLTs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-Odu_pZJSMIWuqyW8fpnqeg-1; Tue, 26 May 2020 12:01:27 -0400
X-MC-Unique: Odu_pZJSMIWuqyW8fpnqeg-1
Received: by mail-ej1-f70.google.com with SMTP id u24so7466348ejg.9
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 09:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ajdISOaE6SNJINKmJABPeXQIezeFcAQ/S+lAQV/QSqs=;
 b=QLw+7Tx9ZqId5KxKEJHx86PtiXQxbAvwWso61BeoKA3/OYljD7T10tP0MKkEpWNEzK
 uGCTG7LAG3qPeWj9nGT7NtrKbamBfDpDDh5fy+EVB+P60Whg9TCbt7ZZW8EIUHYZ6uWO
 ekvSPvFCTmeFT/ThZ1/uCM3iFfGLFaw6GAAI5Vu/AywiNfEQnwd7hYjuHg6e9vlAf0PH
 84PqkguCIeL3ZV8Phpkdz0JCVMFWFbAdsK40YgUsdlzILD3IgtVpb61C3gFSwPCa9GnF
 UvoA7CFCQJ9XPk4tDXU6e6i/KrcPUvacJR+Nq44qITo3N+ZblC/v1J4vcB4/b5D2K8+H
 6F0g==
X-Gm-Message-State: AOAM5312Rm8L93XlqahQWX9D4ZtWia5nIGo9pw89zoRGGdaiRFEyP4pN
 /B5YgXReZWgneU3paWZu/JhZzEW+W+2zmknT5eGdXiJa2P3cDRapRuQfaNh4PVL8sctzI7Tfnhk
 xY8yQ/CClGcpYl0U=
X-Received: by 2002:a50:fc06:: with SMTP id i6mr21545249edr.40.1590508886085; 
 Tue, 26 May 2020 09:01:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeR3YfSJ5CWiZYuATvb083d+sc0jbaCXqWzN83f9Zmv5YdZ7R8m7IfzA1jkc6jJc+r+/esEA==
X-Received: by 2002:a50:fc06:: with SMTP id i6mr21545227edr.40.1590508885833; 
 Tue, 26 May 2020 09:01:25 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id 93sm294226edy.49.2020.05.26.09.01.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 09:01:25 -0700 (PDT)
Subject: Re: [PATCH RFC 13/32] python/qemu/lib: Adjust traceback typing
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-14-jsnow@redhat.com>
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
Message-ID: <b3e79fe0-b507-a846-60a3-056ad358ecb8@redhat.com>
Date: Tue, 26 May 2020 18:01:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514055403.18902-14-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:51:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> mypy considers it incorrect to use `bool` to statically return false,
> because it will assume that it could conceivably return True, and gives
> different analysis in that case. Use a None return to achieve the same
> effect, but make mypy happy.
> 
> Note: Pylint considers function signatures as code that might trip the
> duplicate-code checker. I'd rather not disable this as it does not
> trigger often in practice, so I'm disabling it as a one-off and filed a
> change request; see https://github.com/PyCQA/pylint/issues/3619
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/lib/machine.py |  8 ++++++--
>  python/qemu/lib/qmp.py     | 10 ++++++++--
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/python/qemu/lib/machine.py b/python/qemu/lib/machine.py
> index b2f0412197..2f94c851ed 100644
> --- a/python/qemu/lib/machine.py
> +++ b/python/qemu/lib/machine.py
> @@ -24,6 +24,8 @@
>  import shutil
>  import socket
>  import tempfile
> +from typing import Optional, Type
> +from types import TracebackType
>  
>  from . import qmp
>  
> @@ -127,9 +129,11 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
>      def __enter__(self):
>          return self
>  
> -    def __exit__(self, exc_type, exc_val, exc_tb):
> +    def __exit__(self,
> +                 exc_type: Optional[Type[BaseException]],
> +                 exc_val: Optional[BaseException],
> +                 exc_tb: Optional[TracebackType]) -> None:
>          self.shutdown()
> -        return False
>  
>      def add_monitor_null(self):
>          """
> diff --git a/python/qemu/lib/qmp.py b/python/qemu/lib/qmp.py
> index 73d49050ed..b91c9d5c1c 100644
> --- a/python/qemu/lib/qmp.py
> +++ b/python/qemu/lib/qmp.py
> @@ -14,7 +14,9 @@
>  from typing import (
>      Optional,
>      TextIO,
> +    Type,
>  )
> +from types import TracebackType
>  
>  
>  class QMPError(Exception):
> @@ -146,10 +148,14 @@ def __enter__(self):
>          # Implement context manager enter function.
>          return self
>  
> -    def __exit__(self, exc_type, exc_value, exc_traceback):
> +    def __exit__(self,
> +                 # pylint: disable=duplicate-code
> +                 # see https://github.com/PyCQA/pylint/issues/3619
> +                 exc_type: Optional[Type[BaseException]],
> +                 exc_val: Optional[BaseException],
> +                 exc_tb: Optional[TracebackType]) -> None:
>          # Implement context manager exit function.
>          self.close()
> -        return False
>  
>      def connect(self, negotiate=True):
>          """
> 

Acked-by: Philippe Mathieu-Daudé <philmd@redhat.com>


