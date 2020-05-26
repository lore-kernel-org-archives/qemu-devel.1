Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEECC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:05:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5FEC206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBWxamuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FEC206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdc4d-0006xu-4Z
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdc2y-000590-RE
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:03:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45729
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdc2x-00059v-DF
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590508998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gL1QzzECW4in1I2RrNVQmk6a2JBsbpFVLZpwwa8IWFw=;
 b=GBWxamuI8moiHeZlmYwGzcBT9JRCJUptUnWOkQfYSdAidL6Q/iovcAvXKiRGyIVsgYcPG2
 2sLKBseGGAeq/AtADyNkKmt7rE6NvpnfjO8hTaegB3oBjy2xQWWnuy+/Um5TYI67RI3ffZ
 of2cWhxXw9if67/k4luWQRmN5RSESw0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-zx7JRDGBOpWFBX1DdLKXbg-1; Tue, 26 May 2020 12:03:14 -0400
X-MC-Unique: zx7JRDGBOpWFBX1DdLKXbg-1
Received: by mail-ej1-f71.google.com with SMTP id f17so7438969ejc.7
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 09:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=gL1QzzECW4in1I2RrNVQmk6a2JBsbpFVLZpwwa8IWFw=;
 b=fQJ1sRH/HdmTILysOQ/GTTyft6Cd/KiFMe6xKjY8QXVDP+E18fbKTD+zhhgui9x7Hh
 mLHXij+y4BmXVOSZ0MrUA2syQYgiGX4S60QXXpDAGI2NfjXCiOyvsu87WsxLWGYtURAQ
 5LL8sI0UTsBMX7HEwyt21izODjBG8euW6Flc8FBs+RKQJE2zQHpl0+4jh9aa6hBhgWIN
 6eoaLGDD3P4+qX/mu1vCzl0knwe3by/dNJsrsAcJVG0h9hlZJb20ewoHn+k6n2EzQSor
 DFqmRwINzI2Mu8cEdCdwlqQ4BCftdaTry+KKTGrx5skVMxZWUVIotbMKow5c00rF4wca
 8a/A==
X-Gm-Message-State: AOAM530J4YyViKjv0u3agkzCA7ZZCBuASxmsgJtzmhpB6zR2a+BnEHcA
 0CqSPFZE2koqvzCLJtojCz1xVv0XIoJXf20uhvaJkmxz8lORnwsiGD8R09sCM0886jAxnE977C/
 XXF7pPGbwp7T3mDE=
X-Received: by 2002:a17:907:2701:: with SMTP id
 w1mr1675482ejk.317.1590508993195; 
 Tue, 26 May 2020 09:03:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCz7ODxTebM2Pif50iZHfJh0fEwlCc8MqcKQ207lyL8lDazN7wtrYka7MlBWvXzJpCPyRCsQ==
X-Received: by 2002:a17:907:2701:: with SMTP id
 w1mr1675461ejk.317.1590508992986; 
 Tue, 26 May 2020 09:03:12 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id v12sm306479eda.39.2020.05.26.09.03.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 09:03:12 -0700 (PDT)
Subject: Re: [PATCH RFC 18/32] python//qmp.py: add casts to JSON
 deserialization
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-19-jsnow@redhat.com>
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
Message-ID: <2a058902-a31e-275f-1025-ef012a0c9efd@redhat.com>
Date: Tue, 26 May 2020 18:03:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514055403.18902-19-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:19:28
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
> mypy and python type hints are not powerful enough to properly describe
> JSON messages in Python 3.6. The best we can do, generally, is describe
> them as Dict[str, Any].
> 
> Add casts to coerce this type for static analysis; but do NOT enforce
> this type at runtime in any way.
> 
> Note: Python 3.8 adds a TypedDict construct which allows for the
> description of more arbitrary Dictionary shapes. There is a third-party
> module, "Pydantic", which is compatible with 3.6 that can be used
> instead of the JSON library that parses JSON messages to fully-typed
> Python objects, and may be preferable in some cases.
> 
> (That is well beyond the scope of this commit or series.)
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/lib/qmp.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/python/qemu/lib/qmp.py b/python/qemu/lib/qmp.py
> index 0036204218..e460234f2e 100644
> --- a/python/qemu/lib/qmp.py
> +++ b/python/qemu/lib/qmp.py
> @@ -13,6 +13,7 @@
>  import logging
>  from typing import (
>      Any,
> +    cast,
>      Dict,
>      Optional,
>      TextIO,
> @@ -129,7 +130,10 @@ def __json_read(self, only_event=False):
>              data = self.__sockfile.readline()
>              if not data:
>                  return None
> -            resp = json.loads(data)
> +            # By definition, any JSON received from QMP is a QMPMessage,
> +            # and we are asserting only at static analysis time that it
> +            # has a particular shape.
> +            resp = cast(QMPMessage, json.loads(data))
>              if 'event' in resp:
>                  self.logger.debug("<<< %s", resp)
>                  self.__events.append(resp)
> @@ -261,7 +265,7 @@ def command(self, cmd, **kwds):
>          ret = self.cmd(cmd, kwds)
>          if 'error' in ret:
>              raise QMPResponseError(ret)
> -        return ret['return']
> +        return cast(QMPReturnValue, ret['return'])
>  
>      def pull_event(self, wait=False):
>          """
> 

Acked-by: Philippe Mathieu-Daudé <philmd@redhat.com>


