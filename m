Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0ACCC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 07:55:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 166892078B
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 07:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ii5fEqbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166892078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR9iw-0003GU-WF
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 03:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kR9hz-0002pB-4a
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:54:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23540)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kR9hw-0006Ga-Hq
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602316463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0n+wqwXrPamRqfrJ/aTsgNwXNp+95C9iZBp+FDzUG48=;
 b=ii5fEqbraVmEl5snijivW/rW7ZuLQU7/yRsQLxDULQY4lmnJhB+qkDQSfiMENw83vOGJaQ
 le0+8ivP9bkKo/dNV/TQjJm6sL+SSvIBY/63zNoNQSeQBM9uzXJdQ6aiIWyNAr8svQ4dBn
 uZfX/zyCpmczwA785FW2li8CDH1IiiI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-1Ua9gyOjO5KzKW6nGb_XMw-1; Sat, 10 Oct 2020 03:54:19 -0400
X-MC-Unique: 1Ua9gyOjO5KzKW6nGb_XMw-1
Received: by mail-wm1-f69.google.com with SMTP id g125so4897601wme.1
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 00:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0n+wqwXrPamRqfrJ/aTsgNwXNp+95C9iZBp+FDzUG48=;
 b=UY7kFyxTHoCaHsFna9YMkqF/PRUXFbwzHLxXoSm1lDdzh41jTi20L+Sn2CTsiiJDhF
 XqJc96gUqSqZaS7+O5DsQJ9+nGMU8P0lG6ejgNiNTe1nKJzGe/pM4ZG066v3elvqvshE
 +7BAUZYNQwtt2g+/XWWw6Q9SDcfe4smwBtFd/WtDUwEflWrib+aLsLMesqqpJBlv6hPn
 UZbTrx7LyNY2+pGy0p4FZEM8wiflpFZL+wR5dDbTqTW2Lqe4jY+k4zXGw/QH80ZJwhM0
 VFnHNz4PtvyE9awFzQYRPw/baa1RKQU9iZKWrApNjMGbyY6YhwvYpy1rrIJWV0fBwXn6
 pmKA==
X-Gm-Message-State: AOAM530fqh5HOV0EkFCzez0AicMG188eU6AXAFLyRxUiS7Sov0jOU0Ra
 vfLtZc68aG7DakOS6APOW9Si7j5gJo4Uzf5jx/zMJZ7UQwOEmqphs6fBT6QjoYaagBZDoH5aY3C
 mIkPpcEssS417w9M=
X-Received: by 2002:a1c:e903:: with SMTP id q3mr1725494wmc.42.1602316458178;
 Sat, 10 Oct 2020 00:54:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfhW0HlJ0zgb7+ce/H1U2Jrk/EXLbyVrkIku+R7DUq9f1uooWUBX/qhzvz7cW4QCxsZSIYDg==
X-Received: by 2002:a1c:e903:: with SMTP id q3mr1725479wmc.42.1602316457956;
 Sat, 10 Oct 2020 00:54:17 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u202sm4424506wmu.23.2020.10.10.00.54.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2020 00:54:17 -0700 (PDT)
Subject: Re: [PATCH v2] tests/acceptance: Test case for detecting -object
 crashes
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201009202905.1845802-1-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8daa726a-a359-c533-acb0-e3294b4c8aa7@redhat.com>
Date: Sat, 10 Oct 2020 09:54:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201009202905.1845802-1-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 02:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 10:29 PM, Eduardo Habkost wrote:
> Add a simple test case that will run QEMU directly (without QMP)
> just to check for crashes when using `-object`.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * "Running command:" log message instead of "Command:" (Cleber)
> * Use universal_newlines=True instead of encoding='utf-8' (Cleber)
> * Rename devices() to get_devices() (Cleber)
> * Use @avocado.fail_on(subprocess.CalledProcessError) (Cleber)
> * Reword test_crash() docstring (Cleber)
> * Reorder imports

Assuming:
Based-on: <20201008202713.1416823-1-ehabkost@redhat.com>

I get:

  (1/2) tests/acceptance/object_option.py:ObjectOption.test_help: 
qemu-system-avr: No machine specified, and there is no default
Use -machine help to list supported machines
FAIL: CalledProcessError(1, ['./qemu-system-avr', '-object', 'help']) 
(0.19 s)
  (2/2) tests/acceptance/object_option.py:ObjectOption.test_crash: 
qemu-system-avr: No machine specified, and there is no default
Use -machine help to list supported machines
FAIL: CalledProcessError(1, ['./qemu-system-avr', '-object', 'help']) 
(0.18 s)

> ---
>   tests/acceptance/object_option.py | 53 +++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
>   create mode 100644 tests/acceptance/object_option.py
> 
> diff --git a/tests/acceptance/object_option.py b/tests/acceptance/object_option.py
> new file mode 100644
> index 0000000000..511c03a36f
> --- /dev/null
> +++ b/tests/acceptance/object_option.py
> @@ -0,0 +1,53 @@
> +# Copyright (c) 2020 Red Hat, Inc.
> +#
> +# Author:
> +#  Eduardo Habkost <ehabkost@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +import shlex
> +import subprocess
> +
> +import avocado
> +import avocado_qemu
> +
> +
> +class ObjectOption(avocado_qemu.Test):
> +    """Check if ``-object`` option behaves as expected"""
> +
> +    def run(self, cmd, *args, **kwargs):
> +        cmdstr = ' '.join(shlex.quote(c) for c in cmd)
> +        self.log.info("Running command: %s", cmdstr)
> +        return subprocess.run(cmd, universal_newlines=True, *args, **kwargs)
> +
> +    def get_devices(self):
> +        out = self.run([self.qemu_bin, '-object', 'help'],
> +                       check=True, stdout=subprocess.PIPE).stdout
> +        lines = out.split('\n')
> +        return [l.strip() for l in lines[1:] if l.strip()]
> +
> +    @avocado.fail_on(subprocess.CalledProcessError)
> +    def test_help(self):
> +        """Check if ``-object ...,help`` behaves as expected"""
> +        for device in self.get_devices():
> +            self.run([self.qemu_bin, '-object', '%s,help' % (device)],
> +                     check=True,
> +                     stdout=subprocess.DEVNULL)
> +
> +    @avocado.fail_on(subprocess.CalledProcessError)
> +    def test_crash(self):
> +        """Check that QEMU doesn't crash when using ``-object ...``"""
> +        for device in self.get_devices():
> +            r = self.run([self.qemu_bin, '-object',
> +                                '%s,id=obj0' % (device),
> +                                '-monitor', 'stdio'],
> +                         input='quit\n',
> +                         stdout=subprocess.DEVNULL,
> +                         stderr=subprocess.PIPE)
> +            if r.returncode not in (0, 1):
> +                self.log.warn("QEMU stderr: %s", r.stderr)
> +                self.log.warn("QEMU exit code: %d", r.returncode)
> +                if r.returncode < 0:
> +                    self.fail("QEMU crashed")
> +                else:
> +                    self.fail("Unexpected exit code")
> 


