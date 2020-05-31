Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7401C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 11:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82BA3206F1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 11:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOq+rBN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82BA3206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfM3y-0006S2-Q9
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 07:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfM3M-0005uO-NJ
 for qemu-devel@nongnu.org; Sun, 31 May 2020 07:22:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26135
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfM3K-00017X-Dm
 for qemu-devel@nongnu.org; Sun, 31 May 2020 07:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590924172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0pIaTHDt9akIuY2VT1CaSo9T9Y6UQ51k0f/fXqILKgg=;
 b=SOq+rBN/ysngaM6dGao/E3flZiUa1U5MyP+91o1P32xqRyXqKlYUvxVk0l6N+lEkWmqULD
 WoqcQM0PRV6YfSAadgfKI9XWDKGDV+6QdOqZsxHFw8vlCElArN4ZwTkrBFUxyV7jdOnLbP
 /IPMAe1NP8Nk/Wtptb99jzbY1wpxkGI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-M5eLMt1hOX6FNxraXVM8_Q-1; Sun, 31 May 2020 07:22:48 -0400
X-MC-Unique: M5eLMt1hOX6FNxraXVM8_Q-1
Received: by mail-wr1-f72.google.com with SMTP id m14so1533694wrj.12
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 04:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=0pIaTHDt9akIuY2VT1CaSo9T9Y6UQ51k0f/fXqILKgg=;
 b=BGs+wxfMWhY5L/ez0gZH7lYXbrSVyyOjTb4w2UZOM06brAoyWwODKAUzdpN5lIPcyr
 zqT8FQEeVphgQNoDVB34I54ydVj5kJEl7KeQM418LNYinRRkojbSPio4X8WS5FtWEAbB
 psK2ObD8Ssst9NfffmlbUDpr2LLdMJTR41v9q4DgpzxX7w3mYL2gu7EEYRxOFh5y/mN0
 2Tzhsk6IIfhE7Ii7SNQvWnm3n7QwrzZ7/7zt/2Or2zUEaQzjlO4ui5GEpnw4xW1y19rX
 8ISuQ/kLt38mDOLVJBgJR1ofXNp9o4+VW0GFDDO+gEL6Hy3qFT0GkkyBEhO6oUa9dcP0
 w8tw==
X-Gm-Message-State: AOAM532YMuepC7YqKiz/hefmSuWu36vKjdxdhjLPo8z9vTfGe/0TX+l+
 IewAsE7KIgeMJQBiJrpRW5XZ5xHPpLxhurb1xTlELsMlpKhhIlV7+WgfZO/4uBbRDAPpDHJlOs0
 T4CYJ3BzzZloINLQ=
X-Received: by 2002:a5d:5585:: with SMTP id i5mr16870230wrv.112.1590924167507; 
 Sun, 31 May 2020 04:22:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE0m6eOOH9sh2N4YnF0H50inF6JB3cOmAlCns+l1A9hOt6Ny9kfVkBY1PRREnMJPx7NzlwVA==
X-Received: by 2002:a5d:5585:: with SMTP id i5mr16870210wrv.112.1590924167131; 
 Sun, 31 May 2020 04:22:47 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id d4sm16332777wre.22.2020.05.31.04.22.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2020 04:22:46 -0700 (PDT)
Subject: Re: [PATCH v8 11/12] python/qemu: Add ConsoleSocket for optional use
 in QEMUMachine
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20200529203458.1038-1-robert.foley@linaro.org>
 <20200529203458.1038-12-robert.foley@linaro.org>
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
Message-ID: <ac472970-1258-a82c-77da-edb8393c9a99@redhat.com>
Date: Sun, 31 May 2020 13:22:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529203458.1038-12-robert.foley@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 05:58:14
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
Cc: peter.puhov@linaro.org, alex.bennee@linaro.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 10:34 PM, Robert Foley wrote:
> We add the ConsoleSocket object, which has a socket interface
> and which will consume all arriving characters on the
> socket, placing them into an in memory buffer.
> This will also provide those chars via recv() as
> would a regular socket.
> ConsoleSocket also has the option of dumping
> the console bytes to a log file.
> 
> We also give QEMUMachine the option of using ConsoleSocket
> to drain and to use for logging console to a file.
> By default QEMUMachine does not use ConsoleSocket.
> 
> This is added in preparation for use by basevm.py in a later commit.
> This is a workaround we found was needed for basevm.py since
> there is a known issue where QEMU will hang waiting
> for console characters to be consumed.
> 
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> Acked-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  python/qemu/console_socket.py | 118 ++++++++++++++++++++++++++++++++++
>  python/qemu/machine.py        |  23 +++++--
>  2 files changed, 137 insertions(+), 4 deletions(-)
>  create mode 100644 python/qemu/console_socket.py
> 
> diff --git a/python/qemu/console_socket.py b/python/qemu/console_socket.py
> new file mode 100644
> index 0000000000..2fe1c20d64
> --- /dev/null
> +++ b/python/qemu/console_socket.py
> @@ -0,0 +1,118 @@
> +#!/usr/bin/env python3
> +#
> +# This python module implements a ConsoleSocket object which is
> +# designed always drain the socket itself, and place
> +# the bytes into a in memory buffer for later processing.
> +#
> +# Optionally a file path can be passed in and we will also
> +# dump the characters to this file for debug.
> +#
> +# Copyright 2020 Linaro
> +#
> +# Authors:
> +#  Robert Foley <robert.foley@linaro.org>
> +#
> +# This code is licensed under the GPL version 2 or later.  See
> +# the COPYING file in the top-level directory.
> +#
> +import asyncore
> +import socket
> +import threading
> +import io
> +import os
> +import sys
> +from collections import deque
> +import time
> +import traceback
> +
> +class ConsoleSocket(asyncore.dispatcher):
> +
> +    def __init__(self, address, file=None):
> +        self._recv_timeout_sec = 300
> +        self._buffer = deque()
> +        self._asyncore_thread = None
> +        self._sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
> +        self._sock.connect(address)
> +        self._logfile = None
> +        if file:
> +            self._logfile = open(file, "w")
> +        asyncore.dispatcher.__init__(self, sock=self._sock)
> +        self._thread_start()
> +        self._open = True

Please set _open before starting the thread (invert last 2 lines).

> +
> +    def _thread_start(self):
> +        """Kick off a thread to wait on the asyncore.loop"""
> +        if self._asyncore_thread is not None:
> +            return
> +        self._asyncore_thread = threading.Thread(target=asyncore.loop,
> +                                                 kwargs={'timeout':1})
> +        self._asyncore_thread.daemon = True
> +        self._asyncore_thread.start()
> +
> +    def handle_close(self):
> +        """redirect close to base class"""
> +        # Call the base class close, but not self.close() since
> +        # handle_close() occurs in the context of the thread which
> +        # self.close() attempts to join.
> +        asyncore.dispatcher.close(self)
> +
> +    def close(self):
> +        """Close the base object and wait for the thread to terminate"""
> +        if self._open:
> +            self._open = False
> +            asyncore.dispatcher.close(self)
> +            if self._asyncore_thread is not None:
> +                thread, self._asyncore_thread = self._asyncore_thread, None
> +                thread.join()
> +            if self._logfile:
> +                self._logfile.close()
> +                self._logfile = None
> +
> +    def handle_read(self):
> +        """process arriving characters into in memory _buffer"""
> +        try:
> +            data = asyncore.dispatcher.recv(self, 1)
> +            # latin1 is needed since there are some chars
> +            # we are receiving that cannot be encoded to utf-8
> +            # such as 0xe2, 0x80, 0xA6.
> +            string = data.decode("latin1")
> +        except:
> +            print("Exception seen.")
> +            traceback.print_exc()
> +            return
> +        if self._logfile:
> +            self._logfile.write("{}".format(string))
> +            self._logfile.flush()
> +        for c in string:
> +            self._buffer.append(c)

           self._buffer.extend(string) ?

> +
> +    def recv(self, n=1):

Please make a sleep_delay_s argument:

       def recv(self, n=1, sleep_delay_s=0.1):

> +        """Return chars from in memory buffer"""
> +        start_time = time.time()
> +        while len(self._buffer) < n:
> +            time.sleep(0.1)

               time.sleep(sleep_delay_s)

> +            elapsed_sec = time.time() - start_time
> +            if elapsed_sec > self._recv_timeout_sec:
> +                raise socket.timeout
> +        chars = ''.join([self._buffer.popleft() for i in range(n)])
> +        # We choose to use latin1 to remain consistent with
> +        # handle_read() and give back the same data as the user would
> +        # receive if they were reading directly from the
> +        # socket w/o our intervention.
> +        return chars.encode("latin1")
> +
> +    def set_blocking(self):
> +        """Maintain compatibility with socket API"""
> +        pass
> +
> +    def settimeout(self, seconds):
> +        """Set current timeout on recv"""
> +        self._recv_timeout_sec = seconds
> +
> +class ByteBuffer(deque):
> +    """Simple in memory buffer with read/write interface"""
> +    def write(self, bytes):
> +        for i in bytes:
> +            self.append(i)

           self.extend(bytes) ?

However 'bytes' seems a reserved keyword.

> +    def read(self, n):
> +        return ''.join([self.popleft() for i in range(n)])
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index b9a98e2c86..ee9c337f55 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -24,6 +24,7 @@ import subprocess
>  import shutil
>  import socket
>  import tempfile
> +from qemu.console_socket import ConsoleSocket
>  
>  from . import qmp
>  
> @@ -71,7 +72,8 @@ class QEMUMachine(object):
>  
>      def __init__(self, binary, args=None, wrapper=None, name=None,
>                   test_dir="/var/tmp", monitor_address=None,
> -                 socket_scm_helper=None, sock_dir=None):
> +                 socket_scm_helper=None, sock_dir=None,
> +                 drain_console=False, console_log=None):
>          '''
>          Initialize a QEMUMachine
>  
> @@ -82,6 +84,9 @@ class QEMUMachine(object):
>          @param test_dir: where to create socket and log file
>          @param monitor_address: address for QMP monitor
>          @param socket_scm_helper: helper program, required for send_fd_scm()
> +        @param sock_dir: where to create socket (overrides test_dir for sock)
> +        @param console_log: (optional) path to console log file
> +        @param drain_console: (optional) True to drain console socket to buffer
>          @note: Qemu process is not started until launch() is used.
>          '''
>          if args is None:
> @@ -118,6 +123,12 @@ class QEMUMachine(object):
>          self._console_address = None
>          self._console_socket = None
>          self._remove_files = []
> +        self._console_log_path = console_log
> +        if self._console_log_path:
> +            # In order to log the console, buffering needs to be enabled.
> +            self._drain_console = True
> +        else:
> +            self._drain_console = drain_console
>  
>          # just in case logging wasn't configured by the main script:
>          logging.basicConfig()
> @@ -568,7 +579,11 @@ class QEMUMachine(object):
>          Returns a socket connected to the console
>          """
>          if self._console_socket is None:
> -            self._console_socket = socket.socket(socket.AF_UNIX,
> -                                                 socket.SOCK_STREAM)
> -            self._console_socket.connect(self._console_address)
> +            if self._drain_console:
> +                self._console_socket = ConsoleSocket(self._console_address,
> +                                                    file=self._console_log_path)
> +            else:
> +                self._console_socket = socket.socket(socket.AF_UNIX,
> +                                                     socket.SOCK_STREAM)
> +                self._console_socket.connect(self._console_address)
>          return self._console_socket
> 

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


