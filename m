Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081D8C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:01:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DC672231B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9Jswmln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC672231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZbKe-00020F-I3
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 10:01:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZbIw-0000Kx-8k
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:59:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34421)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZbIl-0002VO-Ta
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604329158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XdmDUDB2KsVatqCFQs3MMXSY2ZPPqVfNhlc61MSh75o=;
 b=V9JswmlnGaigefWjuK3X2OxnPIPUR61N2uCDwfpOoCOrYgiFJe834BkAcrFQLI999FtddO
 9s0OszjZufATy/Sdykh0GxyZQKdIfH8fDigexS+cCMa+7R41Uu+1GQhjkvm5b6M6yY9FV4
 63ipSzbHcE0LGt6pbRNiY2EGyGYS32w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-vOuRLHzMPF-UQTjRFZBqGw-1; Mon, 02 Nov 2020 09:59:16 -0500
X-MC-Unique: vOuRLHzMPF-UQTjRFZBqGw-1
Received: by mail-wm1-f72.google.com with SMTP id t201so3440339wmt.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 06:59:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XdmDUDB2KsVatqCFQs3MMXSY2ZPPqVfNhlc61MSh75o=;
 b=aFned/tP/po0sIOflBX2R+9edpHuDDuZ2WAUUgZHEmkHXvpHZ6VvdfpdGyzikeUWjS
 cOuTfxc+NYtuabK2hA1Wex3JV4dDxbDqrNTmgXVtcz9TIU2I0EgvbZ6SujA9TQM34FjB
 tWBHQOSzqsilJW8bfQKCsSNSUycFr4p9TUFxY4xdYE3SVz5xAXAjb0eb5bWSep6PQU/P
 Z6IJMxHut6dZzXrm3lqUneCXRcaVhDkXktZ42NNVtfvsDdXYl9wk+Jz2IbnTszIIKyRj
 o3qjbzbqyv9+swYyj0ojUEmCemXDpXylQP5WThdwc0+zYjBK0hpCk07bHa97fBLut3Lf
 Onxw==
X-Gm-Message-State: AOAM532f7v9DrDSdj3YAKL2TbIOCMapN77omFKCKe2CLCq/jGg1sQq5S
 fIeDg7hLbWj2Q7lZ4LZ8au9Rwd+N8Q4qO/7HDCDi97kaJwAdpurXTzNJHnsnyIq1njP6gphUccO
 PiyINeAnnbuEVVKE=
X-Received: by 2002:a5d:420d:: with SMTP id n13mr20677192wrq.196.1604329155275; 
 Mon, 02 Nov 2020 06:59:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCcJquammWW4mQX7RTv3/3JY41AfdqsYf4dXGPfDdVgAWd6QQO/B/rBfuUzyV7dQmW733y5Q==
X-Received: by 2002:a5d:420d:: with SMTP id n13mr20677152wrq.196.1604329155073; 
 Mon, 02 Nov 2020 06:59:15 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id v6sm22402553wrb.53.2020.11.02.06.59.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 06:59:14 -0800 (PST)
Subject: Re: [RFC PATCH-for-5.2? 4/5] tests/acceptance: Only run tests tagged
 'gating-ci' on GitLab CI
To: "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20201102144245.2134077-1-philmd@redhat.com>
 <20201102144245.2134077-5-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f40e30a8-7be3-3f02-352a-9e5f60446d25@redhat.com>
Date: Mon, 2 Nov 2020 15:59:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102144245.2134077-5-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Fabien Chouteau <chouteau@adacore.com>, Aurelien Jarno <aurelien@aurel32.net>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 3:42 PM, Philippe Mathieu-Daudé wrote:
> To avoid breaking our CI each time a test is added, switch from the
> "run all but disable some" to "only run the tagged tests on CI".
> This way we can add a test to the repository, and promote it to
> 'gating-ci' once it is proven stable enough.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> 
> TODO: where to add documentation?
> 
> - docs/devel/testing.rst (too big, split?)
> - tests/acceptance/README.rst
> 
> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 3a0524ce740..f39ba760c17 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -126,7 +126,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
>              $(TESTS_VENV_DIR)/bin/python -m avocado \
>              --show=$(AVOCADO_SHOW) run --job-results-dir=$(TESTS_RESULTS_DIR) \
>              --filter-by-tags-include-empty --filter-by-tags-include-empty-key \
> -            $(AVOCADO_TAGS) \
> +            $(AVOCADO_TAGS) -t gating-ci \

This doesn't work as expected, since we have:

AVOCADO_TAGS=$(patsubst %-softmmu,-t arch:%, $(filter
%-softmmu,$(TARGET_DIRS)))

And avocado '-t' works as logical OR, not logical AND.

OTOH it seems this variable predate the auto-skip feature
(when a binary is not present).

So I'll test this instead, which is simpler:

-- >8 --
@@ -90,7 +90,7 @@ TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
 # Any number of command separated loggers are accepted.  For more
 # information please refer to "avocado --help".
 AVOCADO_SHOW=app
-AVOCADO_TAGS=$(patsubst %-softmmu,-t arch:%, $(filter
%-softmmu,$(TARGET_DIRS)))
+AVOCADO_TAGS=-t gating-ci

 $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
        $(call quiet-command, \
---


