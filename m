Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E26C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 01:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61ECF2075C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 01:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORirqgi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61ECF2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZm9N-0001Tf-H5
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 20:29:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZm8U-00012G-Bf
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 20:28:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZm8S-00060t-WD
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 20:28:54 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:40948)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prashantbhole.linux@gmail.com>)
 id 1iZm8S-00060D-Pc
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 20:28:52 -0500
Received: by mail-pf1-x42f.google.com with SMTP id i187so5939683pfc.7
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 17:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rnzomsGEvWmK6DHLbwnM4g9G/cfdaPXxWaOXimkAyMw=;
 b=ORirqgi30/+MzCdzTdz1sHRwkoZyJXrtDYEyOIwv5DoU+97RLUEWoEUtpqP/bgIT/N
 ksN/K2fpKXwSCvoxaH6jHXjKpgNg9r9kS+m3MP0me8tFxTBTV3vpc4B49+kLN79EDH1E
 D9v6I2f8X7U1wuJLgekiQvOr1l/dQ0XIFdVvQSZ+2YQomGlWxJbByDGpN8VqWYFWdoLZ
 +ooT8ZA1jAtCexlwgpbZZVqHXzFVnVeVlHPj6/Ib8lixxjZFhBQaCP+uJyuqUAn1Skju
 UwQqCDRwabmcwN7WmO08QGlHC8p5mHDouOIMvtiNlosQPzSRUYzhZWYBU2ObuA9L2Fy8
 dJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rnzomsGEvWmK6DHLbwnM4g9G/cfdaPXxWaOXimkAyMw=;
 b=HlN78oIz5yw7N9xU5DRb+AFDtVmTJKEKmaFsr3kaWG6tYDTAU80f/lhOXiN63zMU8B
 I7D7yQqezdbaZ9hF+qagfiLI5+EmfstgpO4/tZGTjTmfZdTfEiokOTk0INCQdH/SuQNY
 9JBJb6IDUGniadlvGw4Zkak1koklMZC16akTf80sb7WmwuD5C8q2hvQnCg8K3pxwehrF
 eAwUpqg69SXz2WpZ8QaEwgLcsHHCN4bpy9Bj8+88v1qdDUxdlrvJEWovaNW9YW3N9Zs5
 qtolKexgJ9cAzzP/WQ4zobCBnbmM4RWkQbYNjetpXZ45W9ra2fjx6JkPEmXhpf/23fRv
 CV2Q==
X-Gm-Message-State: APjAAAWauDUTe6XB2WpJkIK7RWjbK68F543Flby2ysmvQeoEX/Mp2lSm
 UnzQCb19ohLhIJ0HptSNkYU=
X-Google-Smtp-Source: APXvYqzwJd/ZbQ9JW8NIf8L1H0+wP7FB7dlPfL++npvf4Hp+lJvr4lRVhQChVxesWQVbW+25dAlWYg==
X-Received: by 2002:a63:5206:: with SMTP id g6mr1844261pgb.49.1574818131265;
 Tue, 26 Nov 2019 17:28:51 -0800 (PST)
Received: from [172.20.20.156] ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id 125sm14165429pfu.136.2019.11.26.17.28.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2019 17:28:50 -0800 (PST)
Subject: Re: [RFC 0/3] Qemu: virtio-net XDP offload
To: qemu-devel@nongnu.org
References: <157476438124.31055.4199785471534349367@37313f22b938>
From: Prashant Bhole <prashantbhole.linux@gmail.com>
Message-ID: <371adc67-33c1-0346-31d7-528057a997ce@gmail.com>
Date: Wed, 27 Nov 2019 10:27:57 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <157476438124.31055.4199785471534349367@37313f22b938>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42f
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
Cc: songliubraving@fb.com, jakub.kicinski@netronome.com, hawk@kernel.org,
 daniel@iogearbox.net, mst@redhat.com, netdev@vger.kernel.org,
 jasowang@redhat.com, john.fastabend@gmail.com, ast@kernel.org,
 davem@davemloft.net, kvm@vger.kernel.org, yhs@fb.com, andriin@fb.com,
 kafai@fb.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/26/19 7:33 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20191126100914.5150-1-prashantbhole.linux@gmail.com/
> 
> 
> 
> Hi,
> 
> This series failed the docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> make docker-image-centos7 V=1 NETWORK=1
> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
>    CC      ui/input-keymap.o
>    CC      ui/input-legacy.o
>    CC      ui/kbd-state.o
> /tmp/qemu-test/src/net/tap-linux.c:34:21: fatal error: bpf/bpf.h: No such file or directory
>   #include <bpf/bpf.h>

Sorry, I missed to enclose it in #ifdef CONFIG_LIBBPF.
It should be fixed whenever I'll post next revision.


Prashant


>                       ^
> compilation terminated.
> ---
>    SIGN    pc-bios/optionrom/linuxboot.bin
>    SIGN    pc-bios/optionrom/kvmvapic.bin
>    BUILD   pc-bios/optionrom/linuxboot_dma.img
> make: *** [net/tap-linux.o] Error 1
> make: *** Waiting for unfinished jobs....
>    BUILD   pc-bios/optionrom/pvh.img
>    BUILD   pc-bios/optionrom/linuxboot_dma.raw
> ---
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=be849bfed02d4ea7b19f7746fe037bd5', '-u', '1001', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-3d2z3wl3/src/docker-src.2019-11-26-05.31.05.21708:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=be849bfed02d4ea7b19f7746fe037bd5
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-3d2z3wl3/src'
> make: *** [docker-run-test-quick@centos7] Error 2
> 
> real    1m56.447s
> user    0m8.519s
> 
> 
> The full log is available at
> http://patchew.org/logs/20191126100914.5150-1-prashantbhole.linux@gmail.com/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 

