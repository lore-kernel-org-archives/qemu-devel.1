Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7D0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E3F920665
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/UtiA50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3F920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7qC-00019G-3E
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:08:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc7p8-0000R6-OC
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:07:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56906)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc7p6-0001ez-AA
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604930826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSgIStNE7n3kUA9M1cyWMAjAy3Xh7poWC18Y08kRzPQ=;
 b=I/UtiA50e8bQ8WDkCwvgjE+rawo2KI+P1cu9aHz6yAbM3ig/6Pmq1Lntj/wXWwTjAubGge
 IYH/LEcXSpJccgyM6ii69Zxo8X6cLc1ZpOFSlO1TRs56Z+xraiA/7AheNQ8DHZA2HWF6Dm
 s2SWWLo15VBMna7uK9+YZPAGcnwAgV4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-4RzLBPQVNAOq-cBNA8GE0A-1; Mon, 09 Nov 2020 09:07:04 -0500
X-MC-Unique: 4RzLBPQVNAOq-cBNA8GE0A-1
Received: by mail-wr1-f69.google.com with SMTP id e3so4378542wrn.19
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 06:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tSgIStNE7n3kUA9M1cyWMAjAy3Xh7poWC18Y08kRzPQ=;
 b=d1ouxCOv8vvuBi0DYIc1uWxZy6KKlsbWnPT31j2D2bGrd6M0P6k6bU0+RQSWBau6tl
 KM4mmoxbNGgeI7uslXvzP5Vg0HZeTJV/zJEA7P9+TowmN9vuml2AuPmbbBa1JcCwQEfQ
 AtsMJn2hE0ZnP7SBP7gHuOEfHn6nGIBR8n6iVLFaZMIgCtl7NsVvADbFVoOfDjJnF2xK
 HOPAQoILk9rBBG2n1rjQgkElaw2C8seBKzsW4+P6YV9BxNOOCrRPwy1j8WczblgSeA5U
 gRoKIkJWPopT7cJmw/Vf/CkfXkuMSM0YXqZV8budVptUx8DOpRW3n6w5kwUS7nHCjrNB
 EkQQ==
X-Gm-Message-State: AOAM530eWbinnbK/crP7Xdefwp2T8UADkxcJh9EbdB7S/Fj9My7i+fVr
 53tiweAheQFp0wWF2jM396Wy1H6hov8Djg1YoOClKEK4Ig2eJ81Qam8LPOqyVwBt6Xu832M0Y0q
 XMH9ohHmfOqOLdw4=
X-Received: by 2002:adf:eacb:: with SMTP id o11mr7960477wrn.208.1604930823600; 
 Mon, 09 Nov 2020 06:07:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNz6fUVtyDqFn6sCTDzC8gkdHXIGti6Hg7sTnaXziT0H0ZzH+U50xWZ9pZuy1HUreeRQbLQA==
X-Received: by 2002:adf:eacb:: with SMTP id o11mr7960463wrn.208.1604930823463; 
 Mon, 09 Nov 2020 06:07:03 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id n23sm12832704wmk.24.2020.11.09.06.07.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 06:07:02 -0800 (PST)
Subject: Re: [PATCH-for-5.2 v2] configure: Check vhost-user is available for
 vhost-user-blk-server
To: qemu-devel@nongnu.org
References: <20201109140341.2598016-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <651d47a4-43d4-d8af-97f8-2871481c53d0@redhat.com>
Date: Mon, 9 Nov 2020 15:07:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201109140341.2598016-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/9/20 3:03 PM, Philippe Mathieu-Daudé wrote:
> Check vhost-user is available when building vhost-user-blk-server.
> 
> This fixes:
> 
>  $ ../configure \
>       --disable-vhost-user --enable-vhost-user-blk-server && \
>    make qemu-nbd
>  ...
>  [505/505] Linking target qemu-nbd
>  FAILED: qemu-nbd
>  cc  -o qemu-nbd qemu-nbd.p/qemu-nbd.c.o -Wl,--as-needed -Wl,--no-undefined -pie -Wl,--whole-archive libblockdev.fa libblock.fa libcrypto.fa libauthz.fa libqom.fa libio.fa -Wl,--no-whole-archive -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -m64 -fstack-protector-strong -Wl,--start-group libqemuutil.a libblockdev.fa libblock.fa libcrypto.fa libauthz.fa libqom.fa libio.fa @block.syms -lgio-2.0 -lgobject-2.0 -lglib-2.0 -lgio-2.0 -lgobject-2.0 -lglib-2.0 -pthread -lgnutls -lutil -lm -lgthread-2.0 -lglib-2.0 -lbz2 -lgthread-2.0 -lglib-2.0 -lssh -lrbd -lrados -lcurl -lxml2 -lzstd -lacl -lgfapi -lglusterfs -lgfrpc -lgfxdr -luuid -laio /usr/lib64/libz.so -L/usr/lib64/iscsi -liscsi -lnettle -lgnutls -lpam -Wl,--end-group
>  /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): in function `vu_blk_process_vq':
>  block/export/vhost-user-blk-server.c:203: undefined reference to `vu_get_queue'
>  /usr/bin/ld: block/export/vhost-user-blk-server.c:208: undefined reference to `vu_queue_pop'
>  /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): in function `vu_blk_queue_set_started':
>  block/export/vhost-user-blk-server.c:228: undefined reference to `vu_get_queue'
>  /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): in function `vu_blk_req_complete':
>  block/export/vhost-user-blk-server.c:55: undefined reference to `vu_queue_push'
>  /usr/bin/ld: block/export/vhost-user-blk-server.c:56: undefined reference to `vu_queue_notify'
>  /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): in function `vu_blk_queue_set_started':
>  block/export/vhost-user-blk-server.c:229: undefined reference to `vu_set_queue_handler'
>  /usr/bin/ld: libqemuutil.a(util_vhost-user-server.c.o): in function `vu_client_trip':
>  util/vhost-user-server.c:176: undefined reference to `vu_dispatch'
>  /usr/bin/ld: util/vhost-user-server.c:180: undefined reference to `vu_deinit'
>  /usr/bin/ld: libqemuutil.a(util_vhost-user-server.c.o): in function `vu_accept':
>  util/vhost-user-server.c:291: undefined reference to `vu_init'
>  collect2: error: ld returned 1 exit status
>  ninja: build stopped: subcommand failed.
>  make: *** [Makefile:171: run-ninja] Error 1
> 
> Now we get:
> 
>  $ ../configure \
>       --disable-vhost-user --enable-vhost-user-blk-server && \
>  ERROR: --enable-vhost-user-blk-server requires --enable-vhost-user
> 
> Fixes: bc15e44cb21 ("configure: introduce --enable-vhost-user-blk-server")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Since v1:
> - Addressed Thomas review comments
> https://lists.gnu.org/archive/html/qemu-devel/2020-11/msg02188.html
> 
> Supersedes: <20201106190409.10571-1-philmd@redhat.com>
> ---
>  configure | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 805f7791503..39b65dcd070 100755
> --- a/configure
> +++ b/configure
> @@ -2375,6 +2375,10 @@ test "$vhost_user_fs" = "" && vhost_user_fs=$vhost_user
>  if test "$vhost_user_fs" = "yes" && test "$vhost_user" = "no"; then
>    error_exit "--enable-vhost-user-fs requires --enable-vhost-user"
>  fi
> +test "$vhost_user_blk_server" = "" && vhost_user_blk_server=$vhost_user
> +if test "$vhost_user_blk_server" = "yes" && test "$vhost_user" = "no"; then
> +  error_exit "--enable-vhost-user-blk-server requires --enable-vhost-user"
> +fi
>  #vhost-vdpa backends
>  test "$vhost_net_vdpa" = "" && vhost_net_vdpa=$vhost_vdpa
>  if test "$vhost_net_vdpa" = "yes" && test "$vhost_vdpa" = "no"; then
> @@ -2389,7 +2393,6 @@ if test "$vhost_net" = ""; then
>  fi
>  
>  # libvhost-user is Linux-only
> -test "$vhost_user_blk_server" = "" && vhost_user_blk_server=$linux

Pfff I didn't meant to commit this hunk.
I'll respin, sorry.

>  if test "$vhost_user_blk_server" = "yes" && test "$linux" = "no"; then
>    error_exit "--enable-vhost-user-blk-server is only available on Linux"
>  fi
> 


