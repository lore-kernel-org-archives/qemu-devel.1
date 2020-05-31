Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71067C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 10:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C99D20707
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 10:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJniKKvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C99D20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfKrT-000127-Fo
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 06:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfKpU-0007U8-G3
 for qemu-devel@nongnu.org; Sun, 31 May 2020 06:04:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57870
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfKpT-0000vs-I0
 for qemu-devel@nongnu.org; Sun, 31 May 2020 06:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590919470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aU9nFs1GP63KSG6Kmz8EvWC+0SAmyinTlqgG9tydzqQ=;
 b=jJniKKvUI0H7cf15WNQqlI/YsoS4EJC7mKECIoI/HmQ8avZ5ACkj+bZATK0sN0NboALnew
 Nf6CRxzjZfrjIorJ13ubJMPq1T6cPYbmIGOZvq4iy77z15O6RQZ7OUG1G2HgmkSyFe9Ydq
 4aXJ9Bxh8vQi0f1q3EP+9t0Anj8iP6c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-Cqlb2Z1rOAesuS45n3yOMw-1; Sun, 31 May 2020 06:04:29 -0400
X-MC-Unique: Cqlb2Z1rOAesuS45n3yOMw-1
Received: by mail-wr1-f70.google.com with SMTP id n6so3303353wrv.6
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 03:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=aU9nFs1GP63KSG6Kmz8EvWC+0SAmyinTlqgG9tydzqQ=;
 b=IYNn9uUDAfOTg8IHJAeQjyAavA1XshWqs+SQR77m3zf1dk4dCl+oqF4mynbLmHucyF
 jZiJKA/kiaMWxOtfmOrauB/ObD8bMocswichzGwdGFlTESBVHgqEA+S88r6ynGc00cuA
 Iowf863qI+Gqa2cay3E2Nv+zZoQW/Sifs1JdOoyLA0AIojF13r9/+TNtKP3r9s2vozCA
 tuVSX8sTKqD2DToqqKhygMwxhz0dA6b3IS1pr0UonWJ/r7NB/aiG3cts2wr8V+forMcY
 f2pXEQwGLXVOdoBoFvHpUxrlC0AF16FlOJcvLZygoIa9/YB+BDnzJFNdmOyfJjy6B4ha
 YVZw==
X-Gm-Message-State: AOAM533xJVyWmvvRQWOmPh4SVBZEONFzagDzX/+YwNKGc1z1AkZoPIX3
 9dRcUJk63yrU+lDlMmSa3y84pUJvcFLkjgl0FPVICnX7io0c9BCvklTNmOZTvGZqm7RUMudpq1I
 x3bBLD0LxFJfj53o=
X-Received: by 2002:adf:ecce:: with SMTP id s14mr5097568wro.154.1590919467894; 
 Sun, 31 May 2020 03:04:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMcLM9KNY36URvyQJ8G+GXbEkWizAapZoY25T7ZHluJXgcOq9CEdRWxtEzhrsDdB9ImZ7K3A==
X-Received: by 2002:adf:ecce:: with SMTP id s14mr5097549wro.154.1590919467718; 
 Sun, 31 May 2020 03:04:27 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id 128sm7127128wme.39.2020.05.31.03.04.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2020 03:04:27 -0700 (PDT)
Subject: Re: [PATCH RFC 29/32] python//qtest.py: Check before accessing _qtest
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-30-jsnow@redhat.com>
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
Message-ID: <36b372d6-1318-bfc6-12a2-ff2381d55d36@redhat.com>
Date: Sun, 31 May 2020 12:04:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514055403.18902-30-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 05:59:21
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

On 5/14/20 7:54 AM, John Snow wrote:
> It can be None; so add assertions or exceptions where appropriate to
> guard the access accordingly.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/lib/qtest.py | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/python/qemu/lib/qtest.py b/python/qemu/lib/qtest.py
> index a8be0c782f..05c63a1d58 100644
> --- a/python/qemu/lib/qtest.py
> +++ b/python/qemu/lib/qtest.py
> @@ -126,7 +126,8 @@ def _pre_launch(self):
>          super()._pre_launch()
>          self._qtest = QEMUQtestProtocol(self._qtest_path, server=True)
>  
> -    def _post_launch(self):
> +    def _post_launch(self) -> None:
> +        assert self._qtest is not None
>          super()._post_launch()
>          self._qtest.accept()
>  
> @@ -134,6 +135,13 @@ def _post_shutdown(self):
>          super()._post_shutdown()
>          self._remove_if_exists(self._qtest_path)
>  
> -    def qtest(self, cmd):
> -        '''Send a qtest command to guest'''
> +    def qtest(self, cmd: str) -> str:
> +        """
> +        Send a qtest command to the guest.
> +
> +        :param cmd: qtest command to send
> +        :return: qtest server response
> +        """
> +        if self._qtest is None:
> +            raise RuntimeError("qtest socket not available")
>          return self._qtest.cmd(cmd)
> 

Thanks, applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


