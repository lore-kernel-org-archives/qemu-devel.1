Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C347C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 10:01:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C55442074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 10:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="McKW4i6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55442074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfKmI-0003NB-1F
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 06:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfKkV-0001wB-Er
 for qemu-devel@nongnu.org; Sun, 31 May 2020 05:59:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49963
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfKkU-0000Bs-8M
 for qemu-devel@nongnu.org; Sun, 31 May 2020 05:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590919161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LrxPG95m3Xqq9X3tJE2sAe55g0sqIpPvf4IWjsma3tk=;
 b=McKW4i6KVpbNoVw2E8FK0W4AOyJ12qLOtqPI5e9wi65YpJ4OzfVEAYcfNYBk+Ri/PUjP3v
 EvV3+yqSQYZ1M83s8rLRVQriofaTiGZMJphx0BTbvDZx+r6LAiXI99DwQRqqHUHJeNBT82
 kihhPFW6uJ+6cSaVT5Xm9TNES7XSfEY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-_bMjEE5jMlGF92cpWdm-rA-1; Sun, 31 May 2020 05:59:18 -0400
X-MC-Unique: _bMjEE5jMlGF92cpWdm-rA-1
Received: by mail-wr1-f69.google.com with SMTP id w16so3277044wru.18
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 02:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=LrxPG95m3Xqq9X3tJE2sAe55g0sqIpPvf4IWjsma3tk=;
 b=JEKj9LmcZxKPGzrIBGyYtBXc4EsUUz8m+BEGYK9ykzejPABCOFSdryftSh/D15bGWV
 82gW3fEpgkb6KwO8wcPlZ9Gjk9eaNpOnQ0oHEC9ERQB2Ajh21RaPkwfU3rsCSlqBVANa
 BzIGMN7akqbgO10CnwHR+PvOkg6ayP9qvHYi2dZ1Ol9OdCQxDqtnWGoxk4l3mOFb4CTi
 v0Kuv9J4dNso0JalgIshbo85Tc3hjrjBQPWN/VzZqpUCzV41r16wF9Wqit/SCZW2XTkh
 XqdWxNWOLOu6OCtahR5TzhZc5P6XyOYVOMlvvnd4dwoozH6URi3ADxCn8DFgHGY3WKjI
 UvGw==
X-Gm-Message-State: AOAM530vEaegca0SlKWVBdOxXZ+mSdNkA2x0FdTAnCD048fKs2iU4JuX
 bGj4PnbyJywQ4hNZjubBml22dgGTRKYPWI4s8cJ3F7sRYbhdJNpmGg5vOfvH04ooNpjqMAzmylh
 GlKV1zkTmWXUeiNs=
X-Received: by 2002:a05:600c:23cd:: with SMTP id
 p13mr17794782wmb.163.1590919156682; 
 Sun, 31 May 2020 02:59:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtKAM98OciEFPbo4cqvQ2G6C17Gp6RqAcP6GsNTHy73BfvpX3F8iSwS2bNMv0SqHPPi2C/gg==
X-Received: by 2002:a05:600c:23cd:: with SMTP id
 p13mr17794765wmb.163.1590919156455; 
 Sun, 31 May 2020 02:59:16 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id e5sm16792913wrw.19.2020.05.31.02.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2020 02:59:15 -0700 (PDT)
Subject: Re: [PATCH RFC 12/32] python/qemu/lib: fix socket.makefile() typing
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-13-jsnow@redhat.com>
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
Message-ID: <2647a1bf-4504-dbe5-417b-1e0c894eec5a@redhat.com>
Date: Sun, 31 May 2020 11:59:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514055403.18902-13-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

On 5/14/20 7:53 AM, John Snow wrote:
> Note:
> 
> A bug in typeshed (https://github.com/python/typeshed/issues/3977)
> misinterprets the type of makefile(). Work around this by explicitly
> stating that we are opening a text-mode file.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/lib/qmp.py   | 10 +++++++---
>  python/qemu/lib/qtest.py | 12 ++++++++----
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/python/qemu/lib/qmp.py b/python/qemu/lib/qmp.py
> index 6ae7693965..73d49050ed 100644
> --- a/python/qemu/lib/qmp.py
> +++ b/python/qemu/lib/qmp.py
> @@ -11,6 +11,10 @@
>  import errno
>  import socket
>  import logging
> +from typing import (
> +    Optional,
> +    TextIO,
> +)
>  
>  
>  class QMPError(Exception):
> @@ -61,7 +65,7 @@ def __init__(self, address, server=False, nickname=None):
>          self.__events = []
>          self.__address = address
>          self.__sock = self.__get_sock()
> -        self.__sockfile = None
> +        self.__sockfile: Optional[TextIO] = None
>          self._nickname = nickname
>          if self._nickname:
>              self.logger = logging.getLogger('QMP').getChild(self._nickname)
> @@ -157,7 +161,7 @@ def connect(self, negotiate=True):
>          @raise QMPCapabilitiesError if fails to negotiate capabilities
>          """
>          self.__sock.connect(self.__address)
> -        self.__sockfile = self.__sock.makefile()
> +        self.__sockfile = self.__sock.makefile(mode='r')
>          if negotiate:
>              return self.__negotiate_capabilities()
>          return None
> @@ -180,7 +184,7 @@ def accept(self, timeout=15.0):
>          """
>          self.__sock.settimeout(timeout)
>          self.__sock, _ = self.__sock.accept()
> -        self.__sockfile = self.__sock.makefile()
> +        self.__sockfile = self.__sock.makefile(mode='r')
>          return self.__negotiate_capabilities()
>  
>      def cmd_obj(self, qmp_cmd):
> diff --git a/python/qemu/lib/qtest.py b/python/qemu/lib/qtest.py
> index 7943487c2b..4c88590eb0 100644
> --- a/python/qemu/lib/qtest.py
> +++ b/python/qemu/lib/qtest.py
> @@ -19,6 +19,7 @@
>  
>  import socket
>  import os
> +from typing import Optional, TextIO
>  
>  from .machine import QEMUMachine
>  
> @@ -40,7 +41,7 @@ class QEMUQtestProtocol:
>      def __init__(self, address, server=False):
>          self._address = address
>          self._sock = self._get_sock()
> -        self._sockfile = None
> +        self._sockfile: Optional[TextIO] = None
>          if server:
>              self._sock.bind(self._address)
>              self._sock.listen(1)
> @@ -59,7 +60,7 @@ def connect(self):
>          @raise socket.error on socket connection errors
>          """
>          self._sock.connect(self._address)
> -        self._sockfile = self._sock.makefile()
> +        self._sockfile = self._sock.makefile(mode='r')
>  
>      def accept(self):
>          """
> @@ -68,7 +69,7 @@ def accept(self):
>          @raise socket.error on socket connection errors
>          """
>          self._sock, _ = self._sock.accept()
> -        self._sockfile = self._sock.makefile()
> +        self._sockfile = self._sock.makefile(mode='r')
>  
>      def cmd(self, qtest_cmd):
>          """
> @@ -76,6 +77,7 @@ def cmd(self, qtest_cmd):
>  
>          @param qtest_cmd: qtest command text to be sent
>          """
> +        assert self._sockfile is not None
>          self._sock.sendall((qtest_cmd + "\n").encode('utf-8'))
>          resp = self._sockfile.readline()
>          return resp
> @@ -83,7 +85,9 @@ def cmd(self, qtest_cmd):
>      def close(self):
>          """Close this socket."""
>          self._sock.close()
> -        self._sockfile.close()
> +        if self._sockfile:
> +            self._sockfile.close()
> +            self._sockfile = None
>  
>      def settimeout(self, timeout):
>          """Set a timeout, in seconds."""
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

And applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


