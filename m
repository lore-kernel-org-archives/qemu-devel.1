Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FDFC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 13:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B36C206CC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 13:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTWR+RXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B36C206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJdrx-0007D4-5b
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 09:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJdrA-0006jp-0w
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 09:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJdr8-0004vh-CY
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 09:56:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39422
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJdr8-0004vI-9D
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 09:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585749393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JOqBma9+UFfJo3HPmQvmne9LTHaivD2AZU9Ns3lKIYY=;
 b=dTWR+RXuef0XVJGQ21UcSALwKd4YE8as9msusRnFBEY8evzzXGdFEeWSWKTfqYCmn27UYp
 T7G24z9wo/WjTGcEuqMH//2C17380mFUHN95tytxFlEi4D2PDWhyMJ3xjEEU3lAdiC2NfK
 2BDo9BoAcmXN8MrG/hbeWN9akoTD/Hw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-OfvD1MvFOPqjN8SYyTOetg-1; Wed, 01 Apr 2020 09:56:29 -0400
X-MC-Unique: OfvD1MvFOPqjN8SYyTOetg-1
Received: by mail-ed1-f71.google.com with SMTP id x93so2244ede.19
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 06:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JOqBma9+UFfJo3HPmQvmne9LTHaivD2AZU9Ns3lKIYY=;
 b=UwSEYst88T7X4SToUXYj6ZD1BYWAE7LUWsdMW0xQ1kSc2TZabgN9B9fls1AwgoifAB
 Nd4L0TMqAAwhbTj9EOkjCo8NBtl8meGins8B5FtqKICpRVRxP1bE2rN4HXv3lyEro388
 OYDieqf09v/vWJo4d626qzUpTBuMHuoY+iD7StFTidnhgRQPRmsyQfYimu2sJ75DjjIE
 YG90XFM/+Is/7PrIQgS3RlIYZK040o46yCoA8g3zf5tFyhSQWHO8PDtQdE55o48c0WEl
 JyaUUrUIoMxQHpYITNf4dlM70azxblbYPWAf9FMIwTj9iRThUUTBjQ43jyT0fSZ09PTz
 dEww==
X-Gm-Message-State: ANhLgQ1Eaupy4yWsQK5fLF50eWcwilMjfzw4sAWDHgI+T81BDodozlPW
 /P25yxXP35JiSDnvj019cbp2UZCQMjofn+q1edCLxJfd6/ETYDEmIISbj7Y9UbS3RVMItmfzill
 9Z44dosxh0HBVENE=
X-Received: by 2002:a17:906:8c3:: with SMTP id
 o3mr20811857eje.218.1585749387984; 
 Wed, 01 Apr 2020 06:56:27 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vumTgcHdAYxHY0BsiGx8z+HlqsxfZb+cAea4QxR0kHuek/q33UgRvXTrAxJl+i8b5eI0Db7oA==
X-Received: by 2002:a17:906:8c3:: with SMTP id
 o3mr20811819eje.218.1585749387702; 
 Wed, 01 Apr 2020 06:56:27 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z13sm463687edj.81.2020.04.01.06.56.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2020 06:56:26 -0700 (PDT)
Subject: Re: [PATCH] Compress lines for immediate return
To: Simran Singhal <singhalsimran0@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200401121101.GA26994@simran-Inspiron-5558>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d93af7ef-59d3-ceda-6847-1f5c92eaea2b@redhat.com>
Date: Wed, 1 Apr 2020 15:56:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200401121101.GA26994@simran-Inspiron-5558>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Simran,

On 4/1/20 2:11 PM, Simran Singhal wrote:
> Compress two lines into a single line if immediate return statement is found.

How did you find these changes? Manual audit, some tool?

> 
> It also remove variables progress, val, data, ret and sock
> as they are no longer needed.
> 
> Remove space between function "mixer_load" and '(' to fix the
> checkpatch.pl error:-
> ERROR: space prohibited between function name and open parenthesis '('
> 
> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
> ---
>   block/file-posix.c      | 3 +--
>   block/nfs.c             | 3 +--
>   block/nvme.c            | 4 +---
>   block/vhdx.c            | 3 +--
>   hw/audio/ac97.c         | 4 +---
>   hw/audio/adlib.c        | 5 +----
>   hw/display/cirrus_vga.c | 4 +---
>   migration/ram.c         | 4 +---
>   ui/gtk.c                | 3 +--
>   util/qemu-sockets.c     | 5 +----
>   10 files changed, 10 insertions(+), 28 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 7e19bbff5f..dc01f0d4d3 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1627,8 +1627,7 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
>   
>       /* If we couldn't manage to unmap while guaranteed that the area reads as
>        * all-zero afterwards, just write zeroes without unmapping */
> -    ret = handle_aiocb_write_zeroes(aiocb);
> -    return ret;
> +    return handle_aiocb_write_zeroes(aiocb);
>   }
>   
>   #ifndef HAVE_COPY_FILE_RANGE
> diff --git a/block/nfs.c b/block/nfs.c
> index cc2413d5ab..100f15bd1f 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -623,8 +623,7 @@ static int nfs_file_open(BlockDriverState *bs, QDict *options, int flags,
>       }
>   
>       bs->total_sectors = ret;
> -    ret = 0;
> -    return ret;
> +    return 0;
>   }
>   
>   static QemuOptsList nfs_create_opts = {
> diff --git a/block/nvme.c b/block/nvme.c
> index 7b7c0cc5d6..eb2f54dd9d 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -575,11 +575,9 @@ static bool nvme_poll_cb(void *opaque)
>   {
>       EventNotifier *e = opaque;
>       BDRVNVMeState *s = container_of(e, BDRVNVMeState, irq_notifier);
> -    bool progress = false;
>   
>       trace_nvme_poll_cb(s);
> -    progress = nvme_poll_queues(s);
> -    return progress;
> +    return nvme_poll_queues(s);
>   }
>   
>   static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
> diff --git a/block/vhdx.c b/block/vhdx.c
> index 33e57cd656..2c0e7ee44d 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -411,8 +411,7 @@ int vhdx_update_headers(BlockDriverState *bs, BDRVVHDXState *s,
>       if (ret < 0) {
>           return ret;
>       }
> -    ret = vhdx_update_header(bs, s, generate_data_write_guid, log_guid);
> -    return ret;
> +    return vhdx_update_header(bs, s, generate_data_write_guid, log_guid);
>   }
>   
>   /* opens the specified header block from the VHDX file header section */
> diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
> index 1ec87feec0..8a9b9924c4 100644
> --- a/hw/audio/ac97.c
> +++ b/hw/audio/ac97.c
> @@ -573,11 +573,9 @@ static uint32_t nam_readb (void *opaque, uint32_t addr)
>   static uint32_t nam_readw (void *opaque, uint32_t addr)
>   {
>       AC97LinkState *s = opaque;
> -    uint32_t val = ~0U;
>       uint32_t index = addr;

Why remove 'val' and keep 'index'?

>       s->cas = 0;
> -    val = mixer_load (s, index);
> -    return val;
> +    return mixer_load(s, index);
>   }
>   
>   static uint32_t nam_readl (void *opaque, uint32_t addr)
> diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
> index d6c1fb0586..7c3b67dcfb 100644
> --- a/hw/audio/adlib.c
> +++ b/hw/audio/adlib.c
> @@ -120,13 +120,10 @@ static void adlib_write(void *opaque, uint32_t nport, uint32_t val)
>   static uint32_t adlib_read(void *opaque, uint32_t nport)
>   {
>       AdlibState *s = opaque;
> -    uint8_t data;
>       int a = nport & 3;

Why remove 'data' and keep 'a'?

>   
>       adlib_kill_timers (s);
> -    data = OPLRead (s->opl, a);
> -
> -    return data;
> +    return OPLRead (s->opl, a);
>   }
>   
>   static void timer_handler (void *opaque, int c, double interval_Sec)
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index 0d391e1300..1f29731ffe 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -2411,12 +2411,10 @@ static uint64_t cirrus_linear_bitblt_read(void *opaque,
>                                             unsigned size)
>   {
>       CirrusVGAState *s = opaque;
> -    uint32_t ret;

Why remove 'ret' and keep 's'?

>   
>       /* XXX handle bitblt */
>       (void)s;
> -    ret = 0xff;
> -    return ret;
> +    return 0xff;
>   }
>   
>   static void cirrus_linear_bitblt_write(void *opaque,
> diff --git a/migration/ram.c b/migration/ram.c
> index 04f13feb2e..06cba88632 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2135,9 +2135,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
>       }
>       trace_ram_postcopy_send_discard_bitmap();
>   
> -    ret = postcopy_each_ram_send_discard(ms);
> -
> -    return ret;
> +    return postcopy_each_ram_send_discard(ms);
>   }
>   
>   /**
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 030b251c61..83f2f5d49b 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1650,8 +1650,7 @@ static GSList *gd_vc_menu_init(GtkDisplayState *s, VirtualConsole *vc,
>                        G_CALLBACK(gd_menu_switch_vc), s);
>       gtk_menu_shell_append(GTK_MENU_SHELL(view_menu), vc->menu_item);
>   
> -    group = gtk_radio_menu_item_get_group(GTK_RADIO_MENU_ITEM(vc->menu_item));
> -    return group;
> +    return gtk_radio_menu_item_get_group(GTK_RADIO_MENU_ITEM(vc->menu_item));
>   }
>   
>   #if defined(CONFIG_VTE)
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index bcc06d0e01..86c48b9fa5 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -765,15 +765,12 @@ static int vsock_connect_addr(const struct sockaddr_vm *svm, Error **errp)
>   static int vsock_connect_saddr(VsockSocketAddress *vaddr, Error **errp)
>   {
>       struct sockaddr_vm svm;
> -    int sock = -1;
>   
>       if (!vsock_parse_vaddr_to_sockaddr(vaddr, &svm, errp)) {
>           return -1;
>       }
>   
> -    sock = vsock_connect_addr(&svm, errp);
> -
> -    return sock;
> +    return vsock_connect_addr(&svm, errp);
>   }
>   
>   static int vsock_listen_saddr(VsockSocketAddress *vaddr,
> 


