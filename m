Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1209AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE072075F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKKyAgIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE072075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdbyR-0007sF-1O
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 11:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdbxL-0007IR-3k
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:57:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52524
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdbxJ-0003Zn-4s
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590508648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uHfewdW+B25fwKTErGP5EiUy1IJ0SQfvNK1I6bygjRA=;
 b=NKKyAgIUZhaK+GKIWAPKhGGhHhyvKQbwXIH1kvH/pgNOTsdVSpdFD+wA0Awjrx7ZNqPJDx
 FaKfvq0pZeSq5sZzvD2bkUY4Br3UNTZ9abNy3TXySuXoTb9Ovtj0zaod/yecU6fdJGneZY
 47vPYi521Jky2cPcXM5WTAN1rvx8NSc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-_F2VPq--NH6CiEvtdVKOCg-1; Tue, 26 May 2020 11:57:26 -0400
X-MC-Unique: _F2VPq--NH6CiEvtdVKOCg-1
Received: by mail-ej1-f71.google.com with SMTP id pj20so7472381ejb.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 08:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=uHfewdW+B25fwKTErGP5EiUy1IJ0SQfvNK1I6bygjRA=;
 b=PoXU1VbNlPakE8L1C1LbWeR9a/UfSj4kwSS4xSHIPJioXQCosL/CU0gHQtfXf97ztG
 SxEQgiCitpMQvyc3g38Lknd27aNyDq7YPYWCgqyMbxPAMjVLgRhWGt3iuNTb0S3/mKt1
 xF2ZpRQ2XavBx4NkeFWILk3J8ByvVRx0NDCBYXGS5ts1taVtHmTUQSocI+hT7j93LF78
 +oVZQnSh7F9AfwsF4ML2pGoz1CqyI33GgRN0nv6/T4mS2Z5UZmwwAUUc4rKYSXV2JSE2
 s5xU1G5Ae0ZHkBtPc+O/d1YV+FD3k2LJMz9zTu+VpAwa8J0vibbzjwShE4JHkbeAhPMi
 BK2w==
X-Gm-Message-State: AOAM5304I0pQFL3pkdA/uQ3DxvPHBWbcaeU1w6AfgTxzwXY5c7i87wk9
 BpFsb20Zn67skTckvVq1LDbKPqa8IUPJOh8AwmlCO3FHvxeMVvDFM9EhWjSZonYvT2PDI1Q36DC
 TayWqvbUTGMR9370=
X-Received: by 2002:a17:906:3652:: with SMTP id
 r18mr1679481ejb.526.1590508645327; 
 Tue, 26 May 2020 08:57:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAzb3ZfJjoP8hMaL9VGwMySjRLqni0IHu3PnbMmYN1wccHUFOLAWR0fHBhaBtor2iw77rdvQ==
X-Received: by 2002:a17:906:3652:: with SMTP id
 r18mr1679453ejb.526.1590508644988; 
 Tue, 26 May 2020 08:57:24 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id h20sm239012eja.61.2020.05.26.08.57.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 08:57:24 -0700 (PDT)
Subject: Re: [PATCH RFC 04/32] python/qemu/lib: delint, add pylintrc
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-5-jsnow@redhat.com>
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
Message-ID: <3c8bdd85-fa93-b788-8040-58ca2cf0e296@redhat.com>
Date: Tue, 26 May 2020 17:57:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514055403.18902-5-jsnow@redhat.com>
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
> Bring our these files up to speed with pylint 2.5.0.
> Add a pylintrc file to formalize which pylint subset
> we are targeting.
> 
> The similarity ignore is there to suppress similarity
> reports across imports, which for typing constants,
> are going to trigger this report erroneously.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/lib/machine.py |  6 ++--
>  python/qemu/lib/pylintrc   | 58 ++++++++++++++++++++++++++++++++++++++
>  python/qemu/lib/qtest.py   | 42 +++++++++++++++++----------
>  3 files changed, 88 insertions(+), 18 deletions(-)
>  create mode 100644 python/qemu/lib/pylintrc
> 
> diff --git a/python/qemu/lib/machine.py b/python/qemu/lib/machine.py
> index e3ea523571..c79fc8fb89 100644
> --- a/python/qemu/lib/machine.py
> +++ b/python/qemu/lib/machine.py
> @@ -58,7 +58,7 @@ def __init__(self, reply):
>          self.reply = reply
>  
>  
> -class QEMUMachine(object):
> +class QEMUMachine:
>      """
>      A QEMU VM
>  
> @@ -242,7 +242,7 @@ def _base_args(self):
>                           'chardev=mon,mode=control'])
>          if self._machine is not None:
>              args.extend(['-machine', self._machine])
> -        for i in range(self._console_index):
> +        for _ in range(self._console_index):
>              args.extend(['-serial', 'null'])
>          if self._console_set:
>              self._console_address = os.path.join(self._sock_dir,
> @@ -383,7 +383,7 @@ def shutdown(self, has_quit: bool = False) -> None:
>                  command = ' '.join(self._qemu_full_args)
>              else:
>                  command = ''
> -            LOG.warning(msg, -exitcode, command)
> +            LOG.warning(msg, -int(exitcode), command)
>  
>          self._launched = False
>  
> diff --git a/python/qemu/lib/pylintrc b/python/qemu/lib/pylintrc
> new file mode 100644
> index 0000000000..5d6ae7367d
> --- /dev/null
> +++ b/python/qemu/lib/pylintrc
> @@ -0,0 +1,58 @@
> +[MASTER]
> +
> +[MESSAGES CONTROL]
> +
> +# Disable the message, report, category or checker with the given id(s). You
> +# can either give multiple identifiers separated by comma (,) or put this
> +# option multiple times (only on the command line, not in the configuration
> +# file where it should appear only once). You can also use "--disable=all" to
> +# disable everything first and then reenable specific checks. For example, if
> +# you want to run only the similarities checker, you can use "--disable=all
> +# --enable=similarities". If you want to run only the classes checker, but have
> +# no Warning level messages displayed, use "--disable=all --enable=classes
> +# --disable=W".
> +disable=too-many-arguments,
> +        too-many-instance-attributes,
> +        too-many-public-methods,

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +
> +[REPORTS]
> +
> +[REFACTORING]
> +
> +[MISCELLANEOUS]
> +
> +[LOGGING]
> +
> +[BASIC]
> +
> +# Good variable names which should always be accepted, separated by a comma.
> +good-names=i,
> +           j,
> +           k,
> +           ex,
> +           Run,
> +           _,
> +           fd,
> +
> +[VARIABLES]
> +
> +[STRING]
> +
> +[SPELLING]
> +
> +[FORMAT]
> +
> +[SIMILARITIES]
> +
> +# Ignore imports when computing similarities.
> +ignore-imports=yes
> +
> +[TYPECHECK]
> +
> +[CLASSES]
> +
> +[IMPORTS]
> +
> +[DESIGN]
> +
> +[EXCEPTIONS]
> diff --git a/python/qemu/lib/qtest.py b/python/qemu/lib/qtest.py
> index d24ad04256..53d814c064 100644
> --- a/python/qemu/lib/qtest.py
> +++ b/python/qemu/lib/qtest.py
> @@ -1,5 +1,11 @@
> -# QEMU qtest library
> -#
> +"""
> +QEMU qtest library
> +
> +qtest offers the QEMUQtestProtocol and QEMUQTestMachine classes, which
> +offer a connection to QEMU's qtest protocol socket, and a qtest-enabled
> +subclass of QEMUMachine, respectively.
> +"""
> +
>  # Copyright (C) 2015 Red Hat Inc.
>  #
>  # Authors:
> @@ -17,19 +23,21 @@
>  from .machine import QEMUMachine
>  
>  
> -class QEMUQtestProtocol(object):
> +class QEMUQtestProtocol:
> +    """
> +    QEMUQtestProtocol implements a connection to a qtest socket.
> +
> +    :param address: QEMU address, can be either a unix socket path (string)
> +                    or a tuple in the form ( address, port ) for a TCP
> +                    connection
> +    :param server: server mode, listens on the socket (bool)
> +    :raise socket.error: on socket connection errors
> +
> +    .. note::
> +       No conection is estabalished by __init__(), this is done
> +       by the connect() or accept() methods.
> +    """
>      def __init__(self, address, server=False):
> -        """
> -        Create a QEMUQtestProtocol object.
> -
> -        @param address: QEMU address, can be either a unix socket path (string)
> -                        or a tuple in the form ( address, port ) for a TCP
> -                        connection
> -        @param server: server mode, listens on the socket (bool)
> -        @raise socket.error on socket connection errors
> -        @note No connection is established, this is done by the connect() or
> -              accept() methods
> -        """
>          self._address = address
>          self._sock = self._get_sock()
>          self._sockfile = None
> @@ -73,15 +81,19 @@ def cmd(self, qtest_cmd):
>          return resp
>  
>      def close(self):
> +        """Close this socket."""
>          self._sock.close()
>          self._sockfile.close()
>  
>      def settimeout(self, timeout):
> +        """Set a timeout, in seconds."""
>          self._sock.settimeout(timeout)
>  
>  
>  class QEMUQtestMachine(QEMUMachine):
> -    '''A QEMU VM'''
> +    """
> +    A QEMU VM, with a qtest socket available.
> +    """
>  
>      def __init__(self, binary, args=None, name=None, test_dir="/var/tmp",
>                   socket_scm_helper=None, sock_dir=None):
> 


