Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A374C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 00:03:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA29B21D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 00:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aeXqIazZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA29B21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihjIJ-00027K-0K
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 19:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihjHH-00017h-58
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:02:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihjHD-0001Lv-Ed
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:02:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25853
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihjHB-0001Jx-CR
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:02:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576713764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WHsFh5eJSfMeu4wPfvJ+K1fpKQDGAOLYcMoi3cHlETA=;
 b=aeXqIazZcnu55GspQV3SZiUE9H1+59/3ukff3pk9FHD68sJfaf6IeGDEHZkeAmUpxdPQrk
 cw67GWZhktBmFLYb5Mbl9I0+19QSEAokJHIqjZE3uZxkrP4A1p2qG7fmkxiCLY7bHqMoqM
 oY5+CsvN1XFhN2znhppowPqHC1JHSJU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-4d7TVy19PcacewJKqYFOqA-1; Wed, 18 Dec 2019 19:02:42 -0500
Received: by mail-wr1-f72.google.com with SMTP id z10so241955wrt.21
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 16:02:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WHsFh5eJSfMeu4wPfvJ+K1fpKQDGAOLYcMoi3cHlETA=;
 b=nK20dCvGbU8Tfcykv1U5yvEToi3cQU7DppJgYjRTeL5o+oQad2yUoy/rz6qpvMEb/T
 Wi59X1CL5NofkmRsNT2AifmWsDqa2g9wYxipHlTP64bEZSOYvMskIxJw6TX3bofmtfm8
 oe8XZaKSqFWwu9UuGIQsaK5pkTm1orP0+0DGFR9Xz/05t+WQ0CZX9lDqG2uYD/kY4OKg
 sQxOYYU0KhEevgmvOt9x4YRnGDjKi5QTbHk+yNJnAADYObTt/DTC2aX7db//VCwMoyc5
 PswHgkPGpy2Yr5OQnRZLn3ArizpuZk3+xMGasWag4lndrFikx63iK/sw5wPVJVZyjETe
 W93w==
X-Gm-Message-State: APjAAAWIx0lb5ogFY5dPKQcWb9ViRwxIumP9cjgnlcz5srndmcxC43jw
 frwxmpPhfuIZQkjMtqt9+h10NQuXRRB3tLo7woxRaBk1qoxILQqBgIoGJ9xOzYWFvGnrEsyXUBy
 dLhnv5N8MzlmxoUU=
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr6158475wrq.232.1576713761455; 
 Wed, 18 Dec 2019 16:02:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqwyXVlbK6SedZTYLGPyXfMtx1BsyfwMTJb2VhglaAecSctx7rR3OHHOOGUwW0jc0+S8TYq5gQ==
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr6158448wrq.232.1576713761179; 
 Wed, 18 Dec 2019 16:02:41 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id j130sm4518107wmb.18.2019.12.18.16.02.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 16:02:40 -0800 (PST)
Subject: Re: [PATCH v8 1/4] Acceptance tests: introduce BLD_DIR, SRC_DIR and
 LNK_DIR
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20191218232500.23530-1-crosa@redhat.com>
 <20191218232500.23530-2-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3362e435-73be-f5c3-a672-6208f2bacd95@redhat.com>
Date: Thu, 19 Dec 2019 01:02:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218232500.23530-2-crosa@redhat.com>
Content-Language: en-US
X-MC-Unique: 4d7TVy19PcacewJKqYFOqA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/19/19 12:24 AM, Cleber Rosa wrote:
> Some tests may benefit from using resources from a build directory.
> This introduces three variables that can help tests find resources in
> those directories.
> 
> First, a BLD_DIR is assumed to exist, given that the primary form of
> running the acceptance tests is from a build directory (which may or
> may not be the same as the source tree, that is, the SRC_DIR).

Can we name this BUILD_DIR?

This would be more in line with the other buildsys files (configure/make).

> If the directory containing the acceptance tests happens to be a link
> to a directory (kept as LNK_DIR), it's assumed to it points to the
> source tree (SRC_DIR), which is the behavior defined on the QEMU
> Makefiles.  If the directory containing the acceptance tests is not a
> link, then a in-tree build is assumed, and the BLD_DIR and SRC_DIR are
> the same and LNK_DIR is set None.

Similarly, can we name this CURRENT_DIR instead of LNK_DIR?

> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/acceptance/avocado_qemu/__init__.py | 27 ++++++++++++++++++-----
>   1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
> index 6618ea67c1..ac7597f7fe 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -16,8 +16,23 @@ import tempfile
>   
>   import avocado
>   
> -SRC_ROOT_DIR = os.path.join(os.path.dirname(__file__), '..', '..', '..')
> -sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
> +#: The QEMU build root directory.  It may also be the source directory
> +#: if building from the source dir, but it's safer to use BLD_DIR for
> +#: that purpose.  Be aware that if this code is moved outside of a source
> +#: and build tree, it will not be accurate.
> +BLD_DIR = os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(__file__))))
> +
> +if os.path.islink(os.path.dirname(os.path.dirname(__file__))):
> +    #: The link to the acceptance tests dir in the source code directory.  If
> +    #: build dir is the same as the source dir, this is set to None
> +    LNK_DIR = os.path.dirname(os.path.dirname(__file__))
> +    #: The QEMU root source directory
> +    SRC_DIR = os.path.dirname(os.path.dirname(os.readlink(LNK_DIR)))
> +else:
> +    LNK_DIR = None
> +    SRC_DIR = BLD_DIR
> +
> +sys.path.append(os.path.join(SRC_DIR, 'python'))
>   
>   from qemu.machine import QEMUMachine
>   
> @@ -49,10 +64,10 @@ def pick_default_qemu_bin(arch=None):
>       if is_readable_executable_file(qemu_bin_relative_path):
>           return qemu_bin_relative_path
>   
> -    qemu_bin_from_src_dir_path = os.path.join(SRC_ROOT_DIR,
> +    qemu_bin_from_bld_dir_path = os.path.join(BLD_DIR,
>                                                 qemu_bin_relative_path)
> -    if is_readable_executable_file(qemu_bin_from_src_dir_path):
> -        return qemu_bin_from_src_dir_path
> +    if is_readable_executable_file(qemu_bin_from_bld_dir_path):
> +        return qemu_bin_from_bld_dir_path
>   
>   
>   def wait_for_console_pattern(test, success_message, failure_message=None):
> @@ -122,7 +137,7 @@ class Test(avocado.Test):
>           self.qemu_bin = self.params.get('qemu_bin',
>                                           default=default_qemu_bin)
>           if self.qemu_bin is None:
> -            self.cancel("No QEMU binary defined or found in the source tree")
> +            self.cancel("No QEMU binary defined or found in the build tree")
>   
>       def _new_vm(self, *args):
>           vm = QEMUMachine(self.qemu_bin, sock_dir=tempfile.mkdtemp())
> 


