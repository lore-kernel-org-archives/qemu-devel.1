Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC2EC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3BD208A9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTRxUyMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3BD208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLoTK-0004Dd-Pn
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 10:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLoSD-0002xm-Mm
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 10:12:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLoSB-0003iz-Pu
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 10:12:05 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601043122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hiGgOlBDrtGKa0h8qZjIuHbTmwJLYa2yfpgUuMwsQ6M=;
 b=hTRxUyMB8VXXLV/DAzKiF6DZUDIsFxl/u9MOJ3Mi9yIoEYD+58z8qtfX475k8CbCeFEnHR
 46gsBoHNsm83J8Q+5efplAmfowhUWq/AheaRYP91OkvsB36jFp0g0F279+/uN8jsl7EZI7
 BOQE15xLltzUMNLGOGOyDYdNWYLgDOQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-tf7Ln1opMNu3iW-g9omOYg-1; Fri, 25 Sep 2020 10:11:58 -0400
X-MC-Unique: tf7Ln1opMNu3iW-g9omOYg-1
Received: by mail-wr1-f72.google.com with SMTP id d9so1119315wrv.16
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 07:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hiGgOlBDrtGKa0h8qZjIuHbTmwJLYa2yfpgUuMwsQ6M=;
 b=nH0Z9P9u1HXtBXFO+Bpthr/Mdl3UppSASXAPSgG19ZJTM+7GbBMKfPeAz2ptWW5pUe
 jyrGar7Ozva0nXkISOEfCl1+uFQheZfG35NnJNdYDsKVrgSUaiUkrI+6QoRD4ZQ3acFN
 yzSiJzWhZUJEqQEDc7wdgG1UrDJpjPKufaRxqQq3b1AOQrTuMf+FLrZev7QqnQWAAHHv
 UBmujAvM5G/pFlIGPli9cV9uXMwfef2/plT1G7UlpTLJUdoQlVRilea55dnSpgw00Blu
 l8RVGI3y6TMgLW087q0zvt/2L28aMKY5EoMYad3nE7z+myG2cX3RkRW12kYHFmAnkzhi
 mkdQ==
X-Gm-Message-State: AOAM533hEd/5Yu0jgdoEijq0lp8PMIilzI7eZPsTUSR3i4Q6eFIcXqbd
 LryP/1NjVP7/N9DOWHNDF1YiDBCguPsj3E9J6vJRV+UrTfZ5w8U3ZVaFtYLDjPRcKCpeLHIkH9P
 8mwcbysJdjPT+i8M=
X-Received: by 2002:a5d:40c4:: with SMTP id b4mr4755973wrq.151.1601043116421; 
 Fri, 25 Sep 2020 07:11:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGox8KPQ0OPgKBzEc5deDJluuhjRPeTYykl2hLl/xjTwA5rTpniReFNJyArQ8MtEzKTYG6MA==
X-Received: by 2002:a5d:40c4:: with SMTP id b4mr4755948wrq.151.1601043116191; 
 Fri, 25 Sep 2020 07:11:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf?
 ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
 by smtp.gmail.com with ESMTPSA id k6sm2972034wmf.30.2020.09.25.07.11.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 07:11:55 -0700 (PDT)
Subject: Re: [PATCH 3/4] block: move block exports to libblockdev
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200925134229.246169-1-stefanha@redhat.com>
 <20200925134229.246169-4-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <48e58e9a-0feb-66b4-0e41-9ee01e2e272f@redhat.com>
Date: Fri, 25 Sep 2020 16:11:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925134229.246169-4-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/20 15:42, Stefan Hajnoczi wrote:
> Block exports are used by softmmu, qemu-storage-daemon, and qemu-nbd.
> They are not used by other programs and are not otherwise needed in
> libblock.
> 
> Undo the recent move of blockdev-nbd.c from blockdev_ss into block_ss.
> Two stubs are required to support this:
> 1. bdrv_close_all() (libblock) calls blk_exp_close_all() (libblockdev).
> 2. qemu_system_killed() is called by os-posix.c (libblockdev) and not
>    implemented in qemu-nbd.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Another possibility is to call os_setup_signal_handling in qemu-nbd.c
where we currently set the SIGTERM handler.  The existing
termsig_handler can be repurposed as qemu_system_killed.

Paolo


> ---
>  stubs/blk-exp-close-all.c  |  7 +++++++
>  stubs/qemu-system-killed.c | 10 ++++++++++
>  block/export/meson.build   |  4 ++--
>  meson.build                |  4 ++--
>  nbd/meson.build            |  2 ++
>  stubs/meson.build          |  2 ++
>  6 files changed, 25 insertions(+), 4 deletions(-)
>  create mode 100644 stubs/blk-exp-close-all.c
>  create mode 100644 stubs/qemu-system-killed.c
> 
> diff --git a/stubs/blk-exp-close-all.c b/stubs/blk-exp-close-all.c
> new file mode 100644
> index 0000000000..1c71316763
> --- /dev/null
> +++ b/stubs/blk-exp-close-all.c
> @@ -0,0 +1,7 @@
> +#include "qemu/osdep.h"
> +#include "block/export.h"
> +
> +/* Only used in programs that support block exports (libblockdev.fa) */
> +void blk_exp_close_all(void)
> +{
> +}
> diff --git a/stubs/qemu-system-killed.c b/stubs/qemu-system-killed.c
> new file mode 100644
> index 0000000000..9af131917b
> --- /dev/null
> +++ b/stubs/qemu-system-killed.c
> @@ -0,0 +1,10 @@
> +#include "qemu/osdep.h"
> +#include "sysemu/runstate.h"
> +
> +/*
> + * This function is needed by os-posix.c but only implemented by softmmu and
> + * qemu-storage-daemon. Other programs may have no need for it.
> + */
> +void qemu_system_killed(int signal, pid_t pid)
> +{
> +}
> diff --git a/block/export/meson.build b/block/export/meson.build
> index 469a7aa0f5..a2772a0dce 100644
> --- a/block/export/meson.build
> +++ b/block/export/meson.build
> @@ -1,2 +1,2 @@
> -block_ss.add(files('export.c'))
> -block_ss.add(when: 'CONFIG_VHOST_USER', if_true: files('vhost-user-blk-server.c'))
> +blockdev_ss.add(files('export.c'))
> +blockdev_ss.add(when: 'CONFIG_VHOST_USER', if_true: files('vhost-user-blk-server.c'))
> diff --git a/meson.build b/meson.build
> index 18d689b423..0e9528adab 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -835,7 +835,6 @@ subdir('dump')
>  
>  block_ss.add(files(
>    'block.c',
> -  'blockdev-nbd.c',
>    'blockjob.c',
>    'job.c',
>    'qemu-io-cmds.c',
> @@ -848,6 +847,7 @@ subdir('block')
>  
>  blockdev_ss.add(files(
>    'blockdev.c',
> +  'blockdev-nbd.c',
>    'iothread.c',
>    'job-qmp.c',
>  ))
> @@ -1171,7 +1171,7 @@ if have_tools
>    qemu_io = executable('qemu-io', files('qemu-io.c'),
>               dependencies: [block, qemuutil], install: true)
>    qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
> -               dependencies: [block, qemuutil], install: true)
> +               dependencies: [blockdev, qemuutil], install: true)
>  
>    subdir('storage-daemon')
>    subdir('contrib/rdmacm-mux')
> diff --git a/nbd/meson.build b/nbd/meson.build
> index 0c00a776d3..2baaa36948 100644
> --- a/nbd/meson.build
> +++ b/nbd/meson.build
> @@ -1,5 +1,7 @@
>  block_ss.add(files(
>    'client.c',
>    'common.c',
> +))
> +blockdev_ss.add(files(
>    'server.c',
>  ))
> diff --git a/stubs/meson.build b/stubs/meson.build
> index e0b322bc28..60234571b1 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -1,6 +1,7 @@
>  stub_ss.add(files('arch_type.c'))
>  stub_ss.add(files('bdrv-next-monitor-owned.c'))
>  stub_ss.add(files('blk-commit-all.c'))
> +stub_ss.add(files('blk-exp-close-all.c'))
>  stub_ss.add(files('blockdev-close-all-bdrv-states.c'))
>  stub_ss.add(files('change-state-handler.c'))
>  stub_ss.add(files('clock-warp.c'))
> @@ -25,6 +26,7 @@ stub_ss.add(files('monitor.c'))
>  stub_ss.add(files('monitor-core.c'))
>  stub_ss.add(files('pci-bus.c'))
>  stub_ss.add(files('pci-host-piix.c'))
> +stub_ss.add(files('qemu-system-killed.c'))
>  stub_ss.add(files('qemu-timer-notify-cb.c'))
>  stub_ss.add(files('qmp_memory_device.c'))
>  stub_ss.add(files('qtest.c'))
> 


