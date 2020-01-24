Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2E7C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136522070A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KeeyJYEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136522070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvP4-0000QT-84
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 04:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuvOT-0008QA-Nw
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuvOS-0002Rq-7F
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:36:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57110
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuvOS-0002RC-3o
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579858607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XX0pv/GfaFRtFfz6PQ/suaMJtYXgLMy7OJO8y4NOsEw=;
 b=KeeyJYEJSuV8JUzkjqXqBGwkxcMfdrlRmFUN+A3yIk8BhqZtMSqtsuAa5J+g8uKMBxYvmf
 4Qu5TirI/njN+swgBEZwbu6syaybw4XoZr2V2mvrg2QlZ5juDE4pyUHYXpgQl5OXelfCuH
 bM9gIIsO2CSgu+BVCt6HFRnRuUf+TvI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-M_yiTBKANuegYguJGvl1eA-1; Fri, 24 Jan 2020 04:36:43 -0500
Received: by mail-wr1-f71.google.com with SMTP id z10so874750wrt.21
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 01:36:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XX0pv/GfaFRtFfz6PQ/suaMJtYXgLMy7OJO8y4NOsEw=;
 b=FKdwf1QHQUiBx3EK6EGMeZK46chKEia1u7puBa4TMj5QexlFPYDjgUdR5H4gN6+C3d
 pT91/Lwlg/UyJzI4U8tUyMpvcQviAz+HSKZeKccl+wzzqsAo4IUJ34ZEhQjpBFApquVZ
 38KPslxlnyoq7CTgHPQvsx1Ti6yHITGFBrcCDzfL7NLIFN5MSuQb5lmvwA7EiYQQWWZF
 TgKEIHXWTgl1HbI8TCyWJdbwf6AaIHw/0w6dZRhODTlitLfphDFWlX/lVGti5srfsrRD
 Yzd6psbRdGt0z+YEvVOeuCTDs+hdjS1JHCr8/AdKgJ81zhRe/yL7zP7hxBg7l5WFk2lS
 gl7w==
X-Gm-Message-State: APjAAAVdKjH0Mh+b+2oiUfUeAu4on+2imFUtSbTIBHHM6eqBuyZOAqoR
 E5ZhxueIkDl3qwUU0td4xJoouEhVtjOwh93F3U0aUG8QsFhc+OAH6ExknLaVG65lStE1xw2WpZL
 POdMhP+/XbQSdR0I=
X-Received: by 2002:a1c:7718:: with SMTP id t24mr2457241wmi.119.1579858602759; 
 Fri, 24 Jan 2020 01:36:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqxOVF5MCr3wEEiIQ6wWRAgQh50iPrqy7AUULJ5LVSQMJuqAvfWWqydxa0sfWZKwIOTulm8FWA==
X-Received: by 2002:a1c:7718:: with SMTP id t24mr2457215wmi.119.1579858602459; 
 Fri, 24 Jan 2020 01:36:42 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id d12sm6679127wrp.62.2020.01.24.01.36.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 01:36:41 -0800 (PST)
Subject: Re: [PATCH v3 1/4] tests/acceptance: avocado_qemu: Introduce the
 'accel' test parameter
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20200122012753.9846-1-wainersm@redhat.com>
 <20200122012753.9846-2-wainersm@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <49356b32-5530-a2dc-9c7a-5a86e74b8cb6@redhat.com>
Date: Fri, 24 Jan 2020 10:36:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200122012753.9846-2-wainersm@redhat.com>
Content-Language: en-US
X-MC-Unique: M_yiTBKANuegYguJGvl1eA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: thuth@redhat.com, alex.bennee@linaro.org, ehabkost@redhat.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/22/20 2:27 AM, Wainer dos Santos Moschetta wrote:
> The test case may need to boot the VM with an accelerator that
> isn't actually enabled on the QEMU binary and/or present in the host. In
> this case the test behavior is undefined, and the best course of
> action is to skip its execution.
> 
> This change introduced the 'accel' parameter (and the handler of
> tag with same name) used to indicate the test case requires a
> given accelerator available. It was implemented a mechanism to
> skip the test case if the accelerator is not available. Moreover,
>   the QEMU -accel argument is set automatically to any VM
> launched if the parameter is present.
> 
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>   docs/devel/testing.rst                    | 16 ++++++++++++++++
>   tests/acceptance/avocado_qemu/__init__.py | 23 +++++++++++++++++++++++
>   2 files changed, 39 insertions(+)
> 
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index ab5be0c729..d17d0e90aa 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -759,6 +759,17 @@ name.  If one is not given explicitly, it will either be set to
>   ``None``, or, if the test is tagged with one (and only one)
>   ``:avocado: tags=machine:VALUE`` tag, it will be set to ``VALUE``.
>   
> +accel
> +~~~~~
> +The accelerator that will be set to all QEMUMachine instances created
> +by the test.
> +
> +The ``accel`` attribute will be set to the test parameter of the same
> +name.  If one is not given explicitly, it will either be set to
> +``None``, or, if the test is tagged with one (and only one)
> +``:avocado: tags=accel:VALUE`` tag, it will be set to ``VALUE``. Currently
> +``VALUE`` should be either ``kvm`` or ``tcg``.
> +
>   qemu_bin
>   ~~~~~~~~
>   
> @@ -800,6 +811,11 @@ machine
>   The machine type that will be set to all QEMUMachine instances created
>   by the test.
>   
> +accel
> +~~~~~
> +The accelerator that will be set to all QEMUMachine instances created
> +by the test. In case the accelerator is not available (both QEMU
> +binary and the host system are checked) then the test is canceled.
>   
>   qemu_bin
>   ~~~~~~~~
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
> index 6618ea67c1..c83a75ccbc 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -20,6 +20,7 @@ SRC_ROOT_DIR = os.path.join(os.path.dirname(__file__), '..', '..', '..')
>   sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
>   
>   from qemu.machine import QEMUMachine
> +from qemu.accel import kvm_available, tcg_available
>   
>   def is_readable_executable_file(path):
>       return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
> @@ -111,6 +112,8 @@ class Test(avocado.Test):
>   
>       def setUp(self):
>           self._vms = {}
> +        # VM argumments that are mapped from parameters
> +        self._param_to_vm_args = []
>   
>           self.arch = self.params.get('arch',
>                                       default=self._get_unique_tag_val('arch'))
> @@ -124,10 +127,30 @@ class Test(avocado.Test):
>           if self.qemu_bin is None:
>               self.cancel("No QEMU binary defined or found in the source tree")
>   
> +        self.accel = self.params.get('accel',
> +                                     default=self._get_unique_tag_val('accel'))
> +        if self.accel:
> +            avail = False
> +            if self.accel == 'kvm':
> +                if kvm_available(self.arch, self.qemu_bin):
> +                    avail = True
> +            elif self.accel == 'tcg':
> +                if tcg_available(self.qemu_bin):
> +                    avail = True
> +            else:
> +                self.cancel("Unknown accelerator: %s" % self.accel)
> +
> +            if avail:
> +                self._param_to_vm_args.extend(['-accel', self.accel])
> +            else:
> +                self.cancel("%s is not available" % self.accel)

Why refuse to test the other accelerators?

Isn't it better to QMP-ask QEMU which accelerator it supports, and SKIP 
if it isn't available?

> +
>       def _new_vm(self, *args):
>           vm = QEMUMachine(self.qemu_bin, sock_dir=tempfile.mkdtemp())
>           if args:
>               vm.add_args(*args)
> +        if self._param_to_vm_args:
> +            vm.add_args(*self._param_to_vm_args)
>           return vm
>   
>       @property
> 


