Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50049C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 19:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E14222AAE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 19:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpD5Qmfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E14222AAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvQhn-00044e-DF
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 15:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvQh4-0003IR-P6
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 15:34:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21294
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvQh2-0007Oe-A8
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 15:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594755259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OIlolgW26i2170Q4bHeki5x9m++/vjnIl612w2ytYgk=;
 b=fpD5QmfxBKlAq8xVxX1SXsWITGnN+nR4aE1NwBMKuDabPGDN86SNpOgbyffVzaKrpajo81
 luvg8sYowq73gAm6J4f3+wnTyKjF9XIwPRQU8/iN7AMiDD1Z3EfnteXhOwfd25fP0DCQKF
 jICYgzZjgthQto3jfSoI788MTCuQKb8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-eECj7FhSNdiruRsrZ-j3Lg-1; Tue, 14 Jul 2020 15:34:18 -0400
X-MC-Unique: eECj7FhSNdiruRsrZ-j3Lg-1
Received: by mail-wm1-f69.google.com with SMTP id f68so3407798wmf.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 12:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=OIlolgW26i2170Q4bHeki5x9m++/vjnIl612w2ytYgk=;
 b=n31khpU1E+s1kXrcEmJCJBZT13YnTqOVnm3iBx2JTZm6VGZXrx7LzOirARP2LywnZn
 s2jITLaZ7jDgnyhfMDlVSrwz2zZ+fgdMBI124CIyuBTeO9n3GqeFPzyP/xX5xXcQYLA2
 C5B/+aJKH7mhO0pkirQ/CVp/yZJ4SMSPfUwqf7jJ1FiQtwCanHR/LM836j4SW1QiYYsG
 mgAzNJVC7W3EadamuvboWF1kgC7tHE/KddEV+XKqQfoEcMD23jja8NjgqXwEwr50FP4P
 hNHukq6WMKqXc07rRLCeMSdcAFEWtcuDka54jFs1VOsJc45aYDUWyWgOezCnCDKqxOWF
 +ONw==
X-Gm-Message-State: AOAM530rG3NRWaeN0gAwHFIkPXM5qGiTjTmnBC9SNKoJN30IJxuIb3Id
 JAhGNyN60/gqN2MEz/0gvPKwwi96SrcT83adKu6E0TbQzpIMk94fjzepDyRLtnBHW6oF75XB4zJ
 d1jrDQw7QW48ZKGo=
X-Received: by 2002:a1c:7c16:: with SMTP id x22mr5164095wmc.76.1594755256495; 
 Tue, 14 Jul 2020 12:34:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEsHYut0V8SOAPM6bg98/QVsFIg696+OY2eHpn2PQx/LKMHiZqJsu7fSX31PhuPnUQPdxr7g==
X-Received: by 2002:a1c:2bc1:: with SMTP id r184mr5495066wmr.133.1594753811074; 
 Tue, 14 Jul 2020 12:10:11 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id v11sm8015883wmb.3.2020.07.14.12.10.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 12:10:10 -0700 (PDT)
Subject: Re: [PATCH v5 10/12] python/machine.py: split shutdown into hard and
 soft flavors
To: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20200710050649.32434-1-jsnow@redhat.com>
 <20200710050649.32434-11-jsnow@redhat.com>
 <20200714041311.GH2983508@localhost.localdomain>
 <76e06449-66ab-05f3-086a-862486523bc6@redhat.com>
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
Message-ID: <25c999d3-3fbb-8d0c-b893-9c6ba0e27025@redhat.com>
Date: Tue, 14 Jul 2020 21:10:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <76e06449-66ab-05f3-086a-862486523bc6@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
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
Cc: kwolf@redhat.com, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/14/20 8:13 PM, John Snow wrote:
> 
> 
> On 7/14/20 12:13 AM, Cleber Rosa wrote:
>> On Fri, Jul 10, 2020 at 01:06:47AM -0400, John Snow wrote:
>>> This is done primarily to avoid the 'bare except' pattern, which
>>> suppresses all exceptions during shutdown and can obscure errors.
>>>
>>> Replace this with a pattern that isolates the different kind of shutdown
>>> paradigms (_hard_shutdown and _soft_shutdown), and a new fallback shutdown
>>> handler (_do_shutdown) that gracefully attempts one before the other.
>>>
>>> This split now also ensures that no matter what happens,
>>> _post_shutdown() is always invoked.
>>>
>>> shutdown() changes in behavior such that if it attempts to do a graceful
>>> shutdown and is unable to, it will now always raise an exception to
>>> indicate this. This can be avoided by the test writer in three ways:
>>>
>>> 1. If the VM is expected to have already exited or is in the process of
>>> exiting, wait() can be used instead of shutdown() to clean up resources
>>> instead. This helps avoid race conditions in shutdown.
>>>
>>> 2. If a test writer is expecting graceful shutdown to fail, shutdown
>>> should be called in a try...except block.
>>>
>>> 3. If the test writer has no interest in performing a graceful shutdown
>>> at all, kill() can be used instead.
>>>
>>>
>>> Handling shutdown in this way makes it much more explicit which type of
>>> shutdown we want and allows the library to report problems with this
>>> process.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  python/qemu/machine.py | 95 +++++++++++++++++++++++++++++++++++-------
>>>  1 file changed, 80 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
>>> index aaa173f046..b24ce8a268 100644
>>> --- a/python/qemu/machine.py
>>> +++ b/python/qemu/machine.py
>>> @@ -48,6 +48,12 @@ class QEMUMachineAddDeviceError(QEMUMachineError):
>>>      """
>>>  
>>>  
>>> +class AbnormalShutdown(QEMUMachineError):
>>> +    """
>>> +    Exception raised when a graceful shutdown was requested, but not performed.
>>> +    """
>>> +
>>> +
>>>  class MonitorResponseError(qmp.QMPError):
>>>      """
>>>      Represents erroneous QMP monitor reply
>>> @@ -365,6 +371,7 @@ def _early_cleanup(self) -> None:
>>>          """
>>>          Perform any cleanup that needs to happen before the VM exits.
>>>  
>>> +        May be invoked by both soft and hard shutdown in failover scenarios.
>>>          Called additionally by _post_shutdown for comprehensive cleanup.
>>>          """
>>>          # If we keep the console socket open, we may deadlock waiting
>>> @@ -374,32 +381,90 @@ def _early_cleanup(self) -> None:
>>>              self._console_socket.close()
>>>              self._console_socket = None
>>>  
>>> +    def _hard_shutdown(self) -> None:
>>> +        """
>>> +        Perform early cleanup, kill the VM, and wait for it to terminate.
>>> +
>>> +        :raise subprocess.Timeout: When timeout is exceeds 60 seconds
>>> +            waiting for the QEMU process to terminate.
>>> +        """
>>> +        self._early_cleanup()
>>
>> Like I commented on patch 5, I don't think the *current* type of
>> cleanup done is needed on a scenario like this...
>>
>>> +        self._popen.kill()
>>
>> ... as I don't remember QEMU's SIGKILL handler to be susceptible to
>> the race condition that motivated the closing of the console file in
>> the first place.  But, I also can not prove it's not susceptible at
>> this time.
>>
> 
> It probably isn't. It was for consistency in when and where that hook is
> called, again. It does happen to be "pointless" here.
> 
>> Note: I have some old patches that added tests for QEMUMachine itself.
>> I intend to respin them on top of your work, so we may have a clearer
>> understanding of the QEMU behaviors we need to handle.  So, feel free
>> to take the prudent route here, and keep the early cleanup.
>>
> 
> Oh, adding formal tests to this folder would be incredible; especially
> if we wanted to package it on PyPI. Basically a necessity.
> 
>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>> Tested-by: Cleber Rosa <crosa@redhat.com>
>>
> 

Queuing with this hunk from jsnow:

-- >8 --
@@ -455,6 +444,9 @@ def shutdown(self, has_quit: bool = False,
         Terminate the VM (gracefully if possible) and perform cleanup.
         Cleanup will always be performed.

+        If the VM has not yet been launched, or shutdown(), wait(), or
kill()
+        have already been called, this method does nothing.
+
         :param has_quit: When true, do not attempt to issue 'quit' QMP
command.
         :param hard: When true, do not attempt graceful shutdown, and
                      suppress the SIGKILL warning log message.
---


