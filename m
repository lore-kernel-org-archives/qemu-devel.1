Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971DFC4741F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA0F7208FE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqnTEYGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0F7208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNFLE-0001X3-H6
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 09:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNFHB-0005oK-Sj
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:02:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNFGz-00040l-Oy
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:02:32 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601384540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mOQydJAVtnOzf7sQDV1+Kbju8NCONO8OuLqKt+DptMc=;
 b=YqnTEYGub+vkwB0yyGo0XH/Gdy0d/BpcOU+lVTXz1KQTyLJRD11DoXxckjNrMAAg4DUZ1E
 dCvJEufSf5gcxi+Htccb6hl7d3JkmEYf0PsWrgC6DQbdUfVs7PvPcLqsYf13Ya3tsUT4gO
 8bvnq+vRX3uye7MP1LmjXDqCqX4Of2w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-b5nrKig4OnOoSBUMSRMVmA-1; Tue, 29 Sep 2020 09:02:18 -0400
X-MC-Unique: b5nrKig4OnOoSBUMSRMVmA-1
Received: by mail-wm1-f71.google.com with SMTP id b14so1686705wmj.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 06:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mOQydJAVtnOzf7sQDV1+Kbju8NCONO8OuLqKt+DptMc=;
 b=p2FeUST4xDsMHJ+dUG1g3sqJbgxE0aBnSHok7RNLITuKaln/O+r1u+L/S8M0Zy0DPE
 ilLOO/FFzq6ESnrRAn5nkcyeoZIz6tBDTQcNh52pjEZTjA7dvAXOtDi2VF/FMC2avCxW
 Jy2ClY0ccu73LNfyH2bWPK83U+GCtiSOpp5oBZBnp6+nQhFA3xStPJieaUQ10gGDrQuA
 LCUAam46BPt0ozJJtct2kJKSAkIhLgUxSht/+7A7kiRjtpSGho1Cw1ZQukjw3m+5w/Dw
 V9douf2EF4JLR25JT8E5OV/ubae04GIuAPqf5BZPJ2aJ64xQZev8EkQEKCgapOjN20ey
 4eIw==
X-Gm-Message-State: AOAM533h/vLfCjlbMZjwAXdTAXWfwSILRfuKwALDpN2/AqFUDdQFLru0
 dlitXOB5yvCbgeIaTMpNJpfmcbqRBc3kN2DG34EVs4Gl+xBV9VeLrfg8hA8NHtl6letQ0/n6z7J
 w8nVhNEw0dSfiP9M=
X-Received: by 2002:a1c:4e02:: with SMTP id g2mr4280701wmh.3.1601384536601;
 Tue, 29 Sep 2020 06:02:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+YZZD+ktUtxBjhZ1IC7vCMtoHB8aCyD7l00bNIy+yG25V1iRtZO6CBNxSz5hEwQsRD6hOtg==
X-Received: by 2002:a1c:4e02:: with SMTP id g2mr4280647wmh.3.1601384536188;
 Tue, 29 Sep 2020 06:02:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9dbe:2c91:3d1b:58c6?
 ([2001:b07:6468:f312:9dbe:2c91:3d1b:58c6])
 by smtp.gmail.com with ESMTPSA id 9sm5529514wmf.7.2020.09.29.06.02.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 06:02:14 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] block: move block exports to libblockdev
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200929125516.186715-1-stefanha@redhat.com>
 <20200929125516.186715-4-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <63f11c66-6dd2-b545-3af4-1fde4848e2cc@redhat.com>
Date: Tue, 29 Sep 2020 15:02:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200929125516.186715-4-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/09/20 14:55, Stefan Hajnoczi wrote:
> Block exports are used by softmmu, qemu-storage-daemon, and qemu-nbd.
> They are not used by other programs and are not otherwise needed in
> libblock.
> 
> Undo the recent move of blockdev-nbd.c from blockdev_ss into block_ss.
> Since bdrv_close_all() (libblock) calls blk_exp_close_all()
> (libblockdev) a stub function is required..
> 
> Make qemu-ndb.c use signal handling utility functions instead of
> duplicating the code. This helps because os-posix.c is in libblockdev
> and it depends on a qemu_system_killed() symbol that qemu-nbd.c lacks.
> Once we use the signal handling utility functions we also end up
> providing the necessary symbol.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qemu-nbd.c                | 21 +++++++++------------
>  stubs/blk-exp-close-all.c |  7 +++++++
>  block/export/meson.build  |  4 ++--
>  meson.build               |  4 ++--
>  nbd/meson.build           |  2 ++
>  stubs/meson.build         |  1 +
>  6 files changed, 23 insertions(+), 16 deletions(-)
>  create mode 100644 stubs/blk-exp-close-all.c
> 
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index 6d7ac7490f..06774ca615 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -25,6 +25,7 @@
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "sysemu/block-backend.h"
> +#include "sysemu/runstate.h" /* for qemu_system_killed() prototype */
>  #include "block/block_int.h"
>  #include "block/nbd.h"
>  #include "qemu/main-loop.h"
> @@ -155,7 +156,11 @@ QEMU_COPYRIGHT "\n"
>  }
>  
>  #if HAVE_NBD_DEVICE
> -static void termsig_handler(int signum)
> +/*
> + * The client thread uses SIGTERM to interrupt the server.  A signal
> + * handler ensures that "qemu-nbd -v -c" exits with a nice status code.
> + */
> +void qemu_system_killed(int signum, pid_t pid)
>  {
>      atomic_cmpxchg(&state, RUNNING, TERMINATE);
>      qemu_notify_event();
> @@ -581,20 +586,12 @@ int main(int argc, char **argv)
>      const char *pid_file_name = NULL;
>      BlockExportOptions *export_opts;
>  
> +    os_setup_early_signal_handling();
> +
>  #if HAVE_NBD_DEVICE
> -    /* The client thread uses SIGTERM to interrupt the server.  A signal
> -     * handler ensures that "qemu-nbd -v -c" exits with a nice status code.
> -     */
> -    struct sigaction sa_sigterm;
> -    memset(&sa_sigterm, 0, sizeof(sa_sigterm));
> -    sa_sigterm.sa_handler = termsig_handler;
> -    sigaction(SIGTERM, &sa_sigterm, NULL);
> +    os_setup_signal_handling();
>  #endif /* HAVE_NBD_DEVICE */
>  
> -#ifdef CONFIG_POSIX
> -    signal(SIGPIPE, SIG_IGN);
> -#endif
> -
>      socket_init();
>      error_init(argv[0]);
>      module_call_init(MODULE_INIT_TRACE);
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
> index e0b322bc28..0fdcf93c09 100644
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
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


