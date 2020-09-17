Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB689C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 180B320771
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOrr+XY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180B320771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIuAx-0007K6-0R
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 09:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIu7B-000360-Ht
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:38:21 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:40943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIu79-0005t4-Re
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:38:21 -0400
Received: by mail-wr1-x432.google.com with SMTP id j2so2116359wrx.7
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 06:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XwZN53n/qLErPz/2T0k6PxKoB8ZjIsCh1yqgRl2+UOI=;
 b=gOrr+XY+s3GNA1FYo26sdI7+LlJtB6DCYutk2KjEMfBgJ5v35CU9MPOZun3HHeJk2L
 WQy+9TkNApai2cZSKH8ACROgJWnlltp3vG8lZ4W/H23VEBxiIjq1tg3FgR5NT24IFdhg
 GLX49K4pPBfqY/m6mtHKxu8DMRfqeImDYxwFDX4U1qvQ7LKrElqn/kdLV1nG6jV6XSjs
 28C+FtoFhNKHx1hMfeRg1g3gie662mTfq1BLb8uwk7ksY/g4R8Flu8y9HPuIEmqBKs7o
 43qVIxLONqIrYGhnccv1sJbTTGkXKLCZyW2UR8X37qor+I+xwQkeO6GOyHSkjvQKvH3T
 u1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XwZN53n/qLErPz/2T0k6PxKoB8ZjIsCh1yqgRl2+UOI=;
 b=c4WPTNF0IaNSonejiVchv75oBWKAn+ICyW2PZZQXgLdLlXSSCG1DEREpUzPgoLlKud
 o4MO+HGRJ8Rg6J1Cq6AzMoj334P0luCR8JgHJadpb76jkto3z5dhlI0RtuzpfO3vzHO2
 ACKA7GtQU774Gigq6L3vB8Jp1Ik40lU+AkBGUEmTW0Joupj+axl3zfWINkcu/xPfomR2
 uUn9EKKewytNc5zYyj/KICnR6jnKWcH+dSNdw7IAaX5gCWxCooCQMA+3dmB3K3aKOGqx
 aYN3F+XRf3BTZ3EcDCCnWSPxe8DHfrJETizwFItyGuF2kj4hzk1xBzKzvQxn0j4EEoQN
 BnWg==
X-Gm-Message-State: AOAM532EjW/I6zWCRuRE4HEpJOf4iL1stMUrfGrpjv+bUvsmP40ObMy+
 YZ4eGtdYCkwMOclkjVfqZxw=
X-Google-Smtp-Source: ABdhPJx4FG86W34I1EmekpMCrqzxw7ssjtFUCdR0iQVgya5Rb6Ejp3dvAbcJzuKxQVB93ZgPIOi2MQ==
X-Received: by 2002:adf:ce01:: with SMTP id p1mr15881897wrn.61.1600349898318; 
 Thu, 17 Sep 2020 06:38:18 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id n4sm38465244wrp.61.2020.09.17.06.38.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 06:38:17 -0700 (PDT)
Subject: Re: [PATCH] docker.py: always use --rm
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200917104441.31738-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <faab2d69-4bd1-4878-d638-4c9414e56499@amsat.org>
Date: Thu, 17 Sep 2020 15:38:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200917104441.31738-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 12:44 PM, Paolo Bonzini wrote:
> Avoid that containers pile up.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/docker/Makefile.include | 1 -
>  tests/docker/docker.py        | 4 ++--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 3daabaa2fd..75704268ff 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -243,7 +243,6 @@ docker-run: docker-qemu-src
>  		$(DOCKER_SCRIPT) run 					\
>  			$(if $(NOUSER),,--run-as-current-user) 		\
>  			--security-opt seccomp=unconfined		\
> -			$(if $V,,--rm) 					\
>  			$(if $(DEBUG),-ti,)				\

Alternatively:

-                       $(if $V,,--rm)
-                       $(if $(DEBUG),-ti,)
+                       $(if $(DEBUG),-ti,--rm)

Anyhow:
Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  			$(if $(NETWORK),$(if $(subst $(NETWORK),,1),--net=$(NETWORK)),--net=none) \
>  			-e TARGET_LIST=$(subst $(SPACE),$(COMMA),$(TARGET_LIST))	\
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 356d7618f1..36b7868406 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -377,7 +377,7 @@ class Docker(object):
>              if self._command[0] == "podman":
>                  cmd.insert(0, '--userns=keep-id')
>  
> -        ret = self._do_check(["run", "--label",
> +        ret = self._do_check(["run", "--rm", "--label",
>                               "com.qemu.instance.uuid=" + label] + cmd,
>                               quiet=quiet)
>          if not keep:
> @@ -616,7 +616,7 @@ class CcCommand(SubCommand):
>          if argv and argv[0] == "--":
>              argv = argv[1:]
>          cwd = os.getcwd()
> -        cmd = ["--rm", "-w", cwd,
> +        cmd = ["-w", cwd,
>                 "-v", "%s:%s:rw" % (cwd, cwd)]
>          if args.paths:
>              for p in args.paths:
> 


