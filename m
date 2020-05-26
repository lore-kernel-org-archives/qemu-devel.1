Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2671C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B0BF2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHSYCtpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0BF2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdbDV-0008Mo-Lg
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 11:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdbCn-0007Yh-2s
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:09:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25569
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdbCm-0000cM-Dd
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590505763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8UMbRx8sxAVJYkkGAPHemTM3IZ1mroELYfiuHDBGBfc=;
 b=jHSYCtpTVqkjJ5kzVJm4wDKX00wgLcpEtn1+6ytgB6Ou7ZFJpaO8ovrau7ddDmFzxqLz/T
 P9YE4ijr8lCqAXuXhFX4oIwZI9Ra+uf2kL8w5J3LtO9vflg9sgXab4AxhvBJvkVeF/DvDT
 tVWyl2otOKM0EiLPn6cKg4XlFkOe5+U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-Tgzp1yiXNpqU33QgdeIEHA-1; Tue, 26 May 2020 11:09:22 -0400
X-MC-Unique: Tgzp1yiXNpqU33QgdeIEHA-1
Received: by mail-ed1-f71.google.com with SMTP id w15so8465791edi.11
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 08:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=8UMbRx8sxAVJYkkGAPHemTM3IZ1mroELYfiuHDBGBfc=;
 b=saCKyLWXVzQrz3dyPS0V9JpBa5wATBYjxQSgNmHA/vgBLmCZxB+u6g2wlbevZf2yzj
 sj1I337GPSy6XgUYL0Pav0F9AGX+KOUsOTOQAMa6t/Qxv5Z6cJeXz5DK7A+boTEPGTNl
 D4j0f+8rK2zTiLGqUn1qMl4/JmRy6N2YY2o/tyA8D1LfPbXGXkuxCZdip3VJj58Uuvli
 Zbzl8ZkmA0RvORITPUraoroAKLTXTqRGid1XRl4sGY38dgT8ANUwYHaFJM51skI0Aj1H
 0zUndiF2aTvva+OtMaT/sDz9oQhy+O3c5yNZrgqR5rRbDbTzlsIaaKnUoOJ0j1UP3DtS
 uWBw==
X-Gm-Message-State: AOAM5332TJn3G/L96SklYRXSk6bOT+DX4Uzg0n12mKZ+0x157UV26V5y
 CCFHqcnMJ/9uQ4aToMEKmOg60ap/yQOXMusD+OczU4+oy9DHVvM6qDO29Pflh7jErUtX4gn968F
 evbpqtRU9GxhMSEM=
X-Received: by 2002:a05:6402:150f:: with SMTP id
 f15mr20823664edw.36.1590505760819; 
 Tue, 26 May 2020 08:09:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCNyTUS2l7yh395/049aZYQVIGb6FfDsV7YJQA5TlZoT3vrRmqiklm8kS09q947qBPH9ykcA==
X-Received: by 2002:a05:6402:150f:: with SMTP id
 f15mr20823647edw.36.1590505760601; 
 Tue, 26 May 2020 08:09:20 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id b13sm163207edw.50.2020.05.26.08.09.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 08:09:20 -0700 (PDT)
Subject: Re: [PATCH RFC 03/32] python//machine.py: remove bare except
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-4-jsnow@redhat.com>
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
Message-ID: <345f48fc-2ca0-2062-4830-e9f75ec4bced@redhat.com>
Date: Tue, 26 May 2020 17:09:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514055403.18902-4-jsnow@redhat.com>
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
> Catch only the timeout error; if there are other problems, allow the
> stack trace to be visible.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/lib/machine.py | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/python/qemu/lib/machine.py b/python/qemu/lib/machine.py
> index b9a98e2c86..e3ea523571 100644
> --- a/python/qemu/lib/machine.py
> +++ b/python/qemu/lib/machine.py
> @@ -342,7 +342,26 @@ def wait(self):
>          self._load_io_log()
>          self._post_shutdown()
>  
> -    def shutdown(self, has_quit=False):
> +    def _issue_shutdown(self, has_quit: bool = False) -> None:
> +        """
> +        Shutdown the VM.
> +        """
> +        if not self.is_running():
> +            return
> +
> +        if self._qmp is not None:
> +            if not has_quit:
> +                self._qmp.cmd('quit')
> +            self._qmp.close()
> +
> +            try:
> +                self._popen.wait(timeout=3)
> +            except subprocess.TimeoutExpired:
> +                self._popen.kill()
> +
> +        self._popen.wait()
> +
> +    def shutdown(self, has_quit: bool = False) -> None:
>          """
>          Terminate the VM and clean up
>          """
> @@ -353,17 +372,7 @@ def shutdown(self, has_quit=False):
>              self._console_socket.close()
>              self._console_socket = None
>  
> -        if self.is_running():
> -            if self._qmp:
> -                try:
> -                    if not has_quit:
> -                        self._qmp.cmd('quit')
> -                    self._qmp.close()
> -                    self._popen.wait(timeout=3)
> -                except:
> -                    self._popen.kill()
> -            self._popen.wait()
> -
> +        self._issue_shutdown(has_quit)
>          self._load_io_log()
>          self._post_shutdown()
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


