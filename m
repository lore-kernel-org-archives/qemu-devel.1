Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05866C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90EA206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6VbDxPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90EA206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iheJD-00006J-Pk
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 13:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iheHx-0007lY-S3
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:43:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iheHu-00064O-2J
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:43:13 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>)
 id 1iheHd-0004e3-45; Wed, 18 Dec 2019 13:42:53 -0500
Received: by mail-ot1-x344.google.com with SMTP id c22so3616302otj.13;
 Wed, 18 Dec 2019 10:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=vdc7c2ZECxTvNbOFuw1UY9DxWRQM8Qpyp/hnHr/Pka0=;
 b=n6VbDxPLfgdlycFyv+OgHxF6f0IJWN8rU8sX25mL7sTyny6IXsHDHGJSLnKhXqtVxe
 C4it7c1LJDOTJ/6AuiWSWkzL6Uz4DG7H2GGmn1QyP7RR4UjieSUAerBAqHvq0PklbR/9
 SXdiYFuhkTkSm3ZVnDNFcCNcqDxXzdQVOt/kSNAos/ZKzLOwEbV9pfONdKTbKb8KD8b9
 4lhP6BdG585D3/yGVq+L3ccHZ/Av9O0FfY6inFo89oR9tlD9uALQzqWnapMS/tpIeTx9
 iPlVD80aDw9Oo/jCwNCLFvsP0DRu1fzyBprq7an1VhFIKOVCiA+kzMRgxzppkWZT1bp8
 X6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=vdc7c2ZECxTvNbOFuw1UY9DxWRQM8Qpyp/hnHr/Pka0=;
 b=O7WpK0FUIU13cAy/cOT4sKo/F7N902sWlKV8liFxUd2ExliTFWNV2cbq3I+H0Cx0KH
 +zTEnsBDloyCEcdMhhHCcARY7+rgJ/hsayf+W7XL3k67c2BQx+LJtt43v2gzLOv+YT0i
 JJykFRTcFNCM9cCz21MYVu+n7HTx8d1ul0OLSpbILGrZ8GHHLRnAGZfKGze+MGPuKZca
 bnMY4Y5CNrS2GpYViJbJv2gpGoM8BuqsH3o5awjX0sKunoxDlZ3RwpFGNul/6fPwCBFS
 bCCnb1L/uP7Fgqh7dnKkTt4ltUIHxqsKeJh3N9/zCnCX5qotktXBPAkPb3O5PHDymxXA
 9ASw==
X-Gm-Message-State: APjAAAXdKYKx+63Kjob5u4lM9/9QnMNSo4HQQTp4jDfoLq/PwcSu6hkE
 I4gmuTZMjWgU9/l6WzuzFQ==
X-Google-Smtp-Source: APXvYqxhvwL7Ko4GqC8alGzYhj0GoHravPYqnlTNUHFVpzc+SRzF/nv0GBOeOnhYv3AX9p9LvgYAkA==
X-Received: by 2002:a9d:3425:: with SMTP id v34mr3959172otb.142.1576694571690; 
 Wed, 18 Dec 2019 10:42:51 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id f3sm1060407oto.57.2019.12.18.10.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 10:42:51 -0800 (PST)
Received: from minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:69de:55d9:4498:6ca0])
 by serve.minyard.net (Postfix) with ESMTPSA id 816DB180058;
 Wed, 18 Dec 2019 18:42:50 +0000 (UTC)
Date: Wed, 18 Dec 2019 12:42:49 -0600
From: Corey Minyard <minyard@acm.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v2 14/14] chardev: Use QEMUChrEvent enum in
 IOEventHandler typedef
Message-ID: <20191218184249.GF7025@minyard.net>
References: <20191218172009.8868-1-philmd@redhat.com>
 <20191218172009.8868-15-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191218172009.8868-15-philmd@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Reply-To: minyard@acm.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, KONRAD Frederic <frederic.konrad@adacore.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Alberto Garcia <berto@igalia.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-block@nongnu.org,
 Zhang Chen <chen.zhang@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, Joel Stanley <joel@jms.id.au>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, qemu-riscv@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Michael Walle <michael@walle.cc>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 18, 2019 at 06:20:09PM +0100, Philippe Mathieu-Daudé wrote:
> The Chardev events are listed in the QEMUChrEvent enum.
> 
> By using the enum in the IOEventHandler typedef we:
> 
> - make the IOEventHandler type more explicit (this handler
>   process out-of-band information, while the IOReadHandler
>   is in-band),
> - help static code analyzers.

For the IPMI part:

Acked-by: Corey Minyard <cminyard@mvista.com>

> 
> This patch was produced with the following spatch script:
> 
>   @match@
>   expression backend, opaque, context, set_open;
>   identifier fd_can_read, fd_read, fd_event, be_change;
>   @@
>   qemu_chr_fe_set_handlers(backend, fd_can_read, fd_read, fd_event,
>                            be_change, opaque, context, set_open);
> 
>   @depends on match@
>   identifier opaque, event;
>   identifier match.fd_event;
>   @@
>    static
>   -void fd_event(void *opaque, int event)
>   +void fd_event(void *opaque, QEMUChrEvent event)
>    {
>    ...
>    }
> 
> Then the following files were manually modified:
> 
>   - include/chardev/char-fe.h
>   - include/chardev/char.h
>   - include/chardev/char-mux.h
>   - chardev/char.c
>   - chardev/char-mux.c
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>
> Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Alex Bennée" <alex.bennee@linaro.org>
> Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
> Cc: Andrzej Zaborowski <balrogg@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>
> Cc: Fabien Chouteau <chouteau@adacore.com>
> Cc: KONRAD Frederic <frederic.konrad@adacore.com>
> Cc: Peter Chubb <peter.chubb@nicta.com.au>
> Cc: Alberto Garcia <berto@igalia.com>
> Cc: Michael Walle <michael@walle.cc>
> Cc: Thomas Huth <huth@tuxfamily.org>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Amit Shah <amit@kernel.org>
> Cc: Corey Minyard <minyard@acm.org>
> Cc: Paul Burton <pburton@wavecomp.com>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Zhang Chen <chen.zhang@intel.com>
> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-block@nongnu.org
> Cc: qemu-s390x@nongnu.org
> Cc: qemu-riscv@nongnu.org
> ---
>  include/chardev/char-fe.h       | 2 +-
>  include/chardev/char-mux.h      | 2 +-
>  include/chardev/char.h          | 4 ++--
>  backends/cryptodev-vhost-user.c | 2 +-
>  chardev/char-mux.c              | 8 ++++----
>  chardev/char.c                  | 4 ++--
>  gdbstub.c                       | 2 +-
>  hw/arm/pxa2xx.c                 | 2 +-
>  hw/arm/strongarm.c              | 2 +-
>  hw/block/vhost-user-blk.c       | 2 +-
>  hw/char/cadence_uart.c          | 2 +-
>  hw/char/digic-uart.c            | 2 +-
>  hw/char/escc.c                  | 2 +-
>  hw/char/etraxfs_ser.c           | 2 +-
>  hw/char/exynos4210_uart.c       | 2 +-
>  hw/char/grlib_apbuart.c         | 2 +-
>  hw/char/imx_serial.c            | 2 +-
>  hw/char/ipoctal232.c            | 2 +-
>  hw/char/lm32_juart.c            | 2 +-
>  hw/char/lm32_uart.c             | 2 +-
>  hw/char/mcf_uart.c              | 2 +-
>  hw/char/milkymist-uart.c        | 2 +-
>  hw/char/nrf51_uart.c            | 2 +-
>  hw/char/pl011.c                 | 2 +-
>  hw/char/serial.c                | 2 +-
>  hw/char/sh_serial.c             | 2 +-
>  hw/char/terminal3270.c          | 2 +-
>  hw/char/virtio-console.c        | 2 +-
>  hw/char/xilinx_uartlite.c       | 2 +-
>  hw/ipmi/ipmi_bmc_extern.c       | 2 +-
>  hw/mips/boston.c                | 2 +-
>  hw/mips/mips_malta.c            | 2 +-
>  hw/riscv/riscv_htif.c           | 2 +-
>  hw/riscv/sifive_uart.c          | 2 +-
>  hw/usb/ccid-card-passthru.c     | 2 +-
>  hw/usb/dev-serial.c             | 2 +-
>  hw/usb/redirect.c               | 2 +-
>  monitor/hmp.c                   | 2 +-
>  monitor/qmp.c                   | 2 +-
>  net/filter-mirror.c             | 2 +-
>  net/vhost-user.c                | 4 ++--
>  qtest.c                         | 2 +-
>  tests/test-char.c               | 6 +++---
>  tests/vhost-user-test.c         | 2 +-
>  44 files changed, 52 insertions(+), 52 deletions(-)
> 
> diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
> index 67601dc9a4..a553843364 100644
> --- a/include/chardev/char-fe.h
> +++ b/include/chardev/char-fe.h
> @@ -4,7 +4,7 @@
>  #include "chardev/char.h"
>  #include "qemu/main-loop.h"
>  
> -typedef void IOEventHandler(void *opaque, int event);
> +typedef void IOEventHandler(void *opaque, QEMUChrEvent event);
>  typedef int BackendChangeHandler(void *opaque);
>  
>  /* This is the backend as seen by frontend, the actual backend is
> diff --git a/include/chardev/char-mux.h b/include/chardev/char-mux.h
> index 572cefd517..417fe32eed 100644
> --- a/include/chardev/char-mux.h
> +++ b/include/chardev/char-mux.h
> @@ -56,6 +56,6 @@ typedef struct MuxChardev {
>      object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX)
>  
>  void mux_set_focus(Chardev *chr, int focus);
> -void mux_chr_send_all_event(Chardev *chr, int event);
> +void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
>  
>  #endif /* CHAR_MUX_H */
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index 087b202b62..00589a6025 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -210,7 +210,7 @@ void qemu_chr_be_update_read_handlers(Chardev *s,
>   *
>   * Send an event from the back end to the front end.
>   */
> -void qemu_chr_be_event(Chardev *s, int event);
> +void qemu_chr_be_event(Chardev *s, QEMUChrEvent event);
>  
>  int qemu_chr_add_client(Chardev *s, int fd);
>  Chardev *qemu_chr_find(const char *name);
> @@ -273,7 +273,7 @@ typedef struct ChardevClass {
>      void (*chr_accept_input)(Chardev *chr);
>      void (*chr_set_echo)(Chardev *chr, bool echo);
>      void (*chr_set_fe_open)(Chardev *chr, int fe_open);
> -    void (*chr_be_event)(Chardev *s, int event);
> +    void (*chr_be_event)(Chardev *s, QEMUChrEvent event);
>      /* Return 0 if succeeded, 1 if failed */
>      int (*chr_machine_done)(Chardev *chr);
>  } ChardevClass;
> diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
> index f1b407955f..6edada8e9e 100644
> --- a/backends/cryptodev-vhost-user.c
> +++ b/backends/cryptodev-vhost-user.c
> @@ -152,7 +152,7 @@ cryptodev_vhost_claim_chardev(CryptoDevBackendVhostUser *s,
>      return chr;
>  }
>  
> -static void cryptodev_vhost_user_event(void *opaque, int event)
> +static void cryptodev_vhost_user_event(void *opaque, QEMUChrEvent event)
>  {
>      CryptoDevBackendVhostUser *s = opaque;
>      CryptoDevBackend *b = CRYPTODEV_BACKEND(s);
> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> index 200c62a0d0..46c44af67c 100644
> --- a/chardev/char-mux.c
> +++ b/chardev/char-mux.c
> @@ -117,7 +117,7 @@ static void mux_print_help(Chardev *chr)
>      }
>  }
>  
> -static void mux_chr_send_event(MuxChardev *d, int mux_nr, int event)
> +static void mux_chr_send_event(MuxChardev *d, int mux_nr, QEMUChrEvent event)
>  {
>      CharBackend *be = d->backends[mux_nr];
>  
> @@ -126,7 +126,7 @@ static void mux_chr_send_event(MuxChardev *d, int mux_nr, int event)
>      }
>  }
>  
> -static void mux_chr_be_event(Chardev *chr, int event)
> +static void mux_chr_be_event(Chardev *chr, QEMUChrEvent event)
>  {
>      MuxChardev *d = MUX_CHARDEV(chr);
>  
> @@ -232,7 +232,7 @@ static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
>          }
>  }
>  
> -void mux_chr_send_all_event(Chardev *chr, int event)
> +void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
>  {
>      MuxChardev *d = MUX_CHARDEV(chr);
>      int i;
> @@ -247,7 +247,7 @@ void mux_chr_send_all_event(Chardev *chr, int event)
>      }
>  }
>  
> -static void mux_chr_event(void *opaque, int event)
> +static void mux_chr_event(void *opaque, QEMUChrEvent event)
>  {
>      mux_chr_send_all_event(CHARDEV(opaque), event);
>  }
> diff --git a/chardev/char.c b/chardev/char.c
> index 739da1155b..4f598f8175 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -48,7 +48,7 @@ static Object *get_chardevs_root(void)
>      return container_get(object_get_root(), "/chardevs");
>  }
>  
> -static void chr_be_event(Chardev *s, int event)
> +static void chr_be_event(Chardev *s, QEMUChrEvent event)
>  {
>      CharBackend *be = s->be;
>  
> @@ -59,7 +59,7 @@ static void chr_be_event(Chardev *s, int event)
>      be->chr_event(be->opaque, event);
>  }
>  
> -void qemu_chr_be_event(Chardev *s, int event)
> +void qemu_chr_be_event(Chardev *s, QEMUChrEvent event)
>  {
>      /* Keep track if the char device is open */
>      switch (event) {
> diff --git a/gdbstub.c b/gdbstub.c
> index 4cf8af365e..ce304ff482 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -3171,7 +3171,7 @@ static void gdb_chr_receive(void *opaque, const uint8_t *buf, int size)
>      }
>  }
>  
> -static void gdb_chr_event(void *opaque, int event)
> +static void gdb_chr_event(void *opaque, QEMUChrEvent event)
>  {
>      int i;
>      GDBState *s = (GDBState *) opaque;
> diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
> index cdafde2f76..950ff4239a 100644
> --- a/hw/arm/pxa2xx.c
> +++ b/hw/arm/pxa2xx.c
> @@ -1955,7 +1955,7 @@ static void pxa2xx_fir_rx(void *opaque, const uint8_t *buf, int size)
>      pxa2xx_fir_update(s);
>  }
>  
> -static void pxa2xx_fir_event(void *opaque, int event)
> +static void pxa2xx_fir_event(void *opaque, QEMUChrEvent event)
>  {
>  }
>  
> diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
> index 6bee034914..c6776e8479 100644
> --- a/hw/arm/strongarm.c
> +++ b/hw/arm/strongarm.c
> @@ -1093,7 +1093,7 @@ static void strongarm_uart_receive(void *opaque, const uint8_t *buf, int size)
>      strongarm_uart_update_int_status(s);
>  }
>  
> -static void strongarm_uart_event(void *opaque, int event)
> +static void strongarm_uart_event(void *opaque, QEMUChrEvent event)
>  {
>      StrongARMUARTState *s = opaque;
>      if (event == CHR_EVENT_BREAK) {
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index ccaf2ad978..98b383f90e 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -361,7 +361,7 @@ static gboolean vhost_user_blk_watch(GIOChannel *chan, GIOCondition cond,
>      return true;
>  }
>  
> -static void vhost_user_blk_event(void *opaque, int event)
> +static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
>  {
>      DeviceState *dev = opaque;
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
> index 0e315b2376..51791bd217 100644
> --- a/hw/char/cadence_uart.c
> +++ b/hw/char/cadence_uart.c
> @@ -348,7 +348,7 @@ static void uart_receive(void *opaque, const uint8_t *buf, int size)
>      }
>  }
>  
> -static void uart_event(void *opaque, int event)
> +static void uart_event(void *opaque, QEMUChrEvent event)
>  {
>      CadenceUARTState *s = opaque;
>      uint8_t buf = '\0';
> diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
> index 974a2619dd..033eba0a6a 100644
> --- a/hw/char/digic-uart.c
> +++ b/hw/char/digic-uart.c
> @@ -131,7 +131,7 @@ static void uart_rx(void *opaque, const uint8_t *buf, int size)
>      s->reg_rx = *buf;
>  }
>  
> -static void uart_event(void *opaque, int event)
> +static void uart_event(void *opaque, QEMUChrEvent event)
>  {
>  }
>  
> diff --git a/hw/char/escc.c b/hw/char/escc.c
> index 8f7bf322cb..c40c1d28f1 100644
> --- a/hw/char/escc.c
> +++ b/hw/char/escc.c
> @@ -634,7 +634,7 @@ static void serial_receive1(void *opaque, const uint8_t *buf, int size)
>      serial_receive_byte(s, buf[0]);
>  }
>  
> -static void serial_event(void *opaque, int event)
> +static void serial_event(void *opaque, QEMUChrEvent event)
>  {
>      ESCCChannelState *s = opaque;
>      if (event == CHR_EVENT_BREAK)
> diff --git a/hw/char/etraxfs_ser.c b/hw/char/etraxfs_ser.c
> index 15ac12ef22..f34f767c60 100644
> --- a/hw/char/etraxfs_ser.c
> +++ b/hw/char/etraxfs_ser.c
> @@ -202,7 +202,7 @@ static int serial_can_receive(void *opaque)
>      return sizeof(s->rx_fifo) - s->rx_fifo_len;
>  }
>  
> -static void serial_event(void *opaque, int event)
> +static void serial_event(void *opaque, QEMUChrEvent event)
>  {
>  
>  }
> diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
> index d6b6b62366..7e5c5ce789 100644
> --- a/hw/char/exynos4210_uart.c
> +++ b/hw/char/exynos4210_uart.c
> @@ -528,7 +528,7 @@ static void exynos4210_uart_receive(void *opaque, const uint8_t *buf, int size)
>  }
>  
>  
> -static void exynos4210_uart_event(void *opaque, int event)
> +static void exynos4210_uart_event(void *opaque, QEMUChrEvent event)
>  {
>      Exynos4210UartState *s = (Exynos4210UartState *)opaque;
>  
> diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
> index fe3cbf41a3..8e59c3bc6e 100644
> --- a/hw/char/grlib_apbuart.c
> +++ b/hw/char/grlib_apbuart.c
> @@ -155,7 +155,7 @@ static void grlib_apbuart_receive(void *opaque, const uint8_t *buf, int size)
>      }
>  }
>  
> -static void grlib_apbuart_event(void *opaque, int event)
> +static void grlib_apbuart_event(void *opaque, QEMUChrEvent event)
>  {
>      trace_grlib_apbuart_event(event);
>  }
> diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
> index fddde9b43d..d09c210709 100644
> --- a/hw/char/imx_serial.c
> +++ b/hw/char/imx_serial.c
> @@ -323,7 +323,7 @@ static void imx_receive(void *opaque, const uint8_t *buf, int size)
>      imx_put_data(opaque, *buf);
>  }
>  
> -static void imx_event(void *opaque, int event)
> +static void imx_event(void *opaque, QEMUChrEvent event)
>  {
>      if (event == CHR_EVENT_BREAK) {
>          imx_put_data(opaque, URXD_BRK | URXD_FRMERR | URXD_ERR);
> diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
> index 66c163ba26..80e9dff701 100644
> --- a/hw/char/ipoctal232.c
> +++ b/hw/char/ipoctal232.c
> @@ -503,7 +503,7 @@ static void hostdev_receive(void *opaque, const uint8_t *buf, int size)
>      }
>  }
>  
> -static void hostdev_event(void *opaque, int event)
> +static void hostdev_event(void *opaque, QEMUChrEvent event)
>  {
>      SCC2698Channel *ch = opaque;
>      switch (event) {
> diff --git a/hw/char/lm32_juart.c b/hw/char/lm32_juart.c
> index e0b1bd6555..da9dd5668b 100644
> --- a/hw/char/lm32_juart.c
> +++ b/hw/char/lm32_juart.c
> @@ -104,7 +104,7 @@ static int juart_can_rx(void *opaque)
>      return !(s->jrx & JRX_FULL);
>  }
>  
> -static void juart_event(void *opaque, int event)
> +static void juart_event(void *opaque, QEMUChrEvent event)
>  {
>  }
>  
> diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
> index 32f29c44cf..8d7a475c91 100644
> --- a/hw/char/lm32_uart.c
> +++ b/hw/char/lm32_uart.c
> @@ -235,7 +235,7 @@ static int uart_can_rx(void *opaque)
>      return !(s->regs[R_LSR] & LSR_DR);
>  }
>  
> -static void uart_event(void *opaque, int event)
> +static void uart_event(void *opaque, QEMUChrEvent event)
>  {
>  }
>  
> diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
> index 58323baf43..2de3680b5d 100644
> --- a/hw/char/mcf_uart.c
> +++ b/hw/char/mcf_uart.c
> @@ -256,7 +256,7 @@ static void mcf_uart_push_byte(mcf_uart_state *s, uint8_t data)
>      mcf_uart_update(s);
>  }
>  
> -static void mcf_uart_event(void *opaque, int event)
> +static void mcf_uart_event(void *opaque, QEMUChrEvent event)
>  {
>      mcf_uart_state *s = (mcf_uart_state *)opaque;
>  
> diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
> index c358ca07f3..1c7b61480e 100644
> --- a/hw/char/milkymist-uart.c
> +++ b/hw/char/milkymist-uart.c
> @@ -180,7 +180,7 @@ static int uart_can_rx(void *opaque)
>      return !(s->regs[R_STAT] & STAT_RX_EVT);
>  }
>  
> -static void uart_event(void *opaque, int event)
> +static void uart_event(void *opaque, QEMUChrEvent event)
>  {
>  }
>  
> diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
> index 2777afe366..b67fd21089 100644
> --- a/hw/char/nrf51_uart.c
> +++ b/hw/char/nrf51_uart.c
> @@ -245,7 +245,7 @@ static int uart_can_receive(void *opaque)
>      return s->rx_started ? (UART_FIFO_LENGTH - s->rx_fifo_len) : 0;
>  }
>  
> -static void uart_event(void *opaque, int event)
> +static void uart_event(void *opaque, QEMUChrEvent event)
>  {
>      NRF51UARTState *s = NRF51_UART(opaque);
>  
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index 84ad8ff9fb..23cd544cc5 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -280,7 +280,7 @@ static void pl011_receive(void *opaque, const uint8_t *buf, int size)
>      pl011_put_fifo(opaque, *buf);
>  }
>  
> -static void pl011_event(void *opaque, int event)
> +static void pl011_event(void *opaque, QEMUChrEvent event)
>  {
>      if (event == CHR_EVENT_BREAK)
>          pl011_put_fifo(opaque, 0x400);
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index b4aa250950..992b5ee944 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -634,7 +634,7 @@ static void serial_receive1(void *opaque, const uint8_t *buf, int size)
>      serial_update_irq(s);
>  }
>  
> -static void serial_event(void *opaque, int event)
> +static void serial_event(void *opaque, QEMUChrEvent event)
>  {
>      SerialState *s = opaque;
>      DPRINTF("event %x\n", event);
> diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
> index 07dc16be13..167f4d8cb9 100644
> --- a/hw/char/sh_serial.c
> +++ b/hw/char/sh_serial.c
> @@ -358,7 +358,7 @@ static void sh_serial_receive1(void *opaque, const uint8_t *buf, int size)
>      }
>  }
>  
> -static void sh_serial_event(void *opaque, int event)
> +static void sh_serial_event(void *opaque, QEMUChrEvent event)
>  {
>      sh_serial_state *s = opaque;
>      if (event == CHR_EVENT_BREAK)
> diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
> index 2aab04fd4b..f7aba12565 100644
> --- a/hw/char/terminal3270.c
> +++ b/hw/char/terminal3270.c
> @@ -142,7 +142,7 @@ static void terminal_read(void *opaque, const uint8_t *buf, int size)
>      }
>  }
>  
> -static void chr_event(void *opaque, int event)
> +static void chr_event(void *opaque, QEMUChrEvent event)
>  {
>      Terminal3270 *t = opaque;
>      CcwDevice *ccw_dev = CCW_DEVICE(t);
> diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
> index cbb304d270..a7d34fe0ed 100644
> --- a/hw/char/virtio-console.c
> +++ b/hw/char/virtio-console.c
> @@ -145,7 +145,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
>      virtio_serial_write(port, buf, size);
>  }
>  
> -static void chr_event(void *opaque, int event)
> +static void chr_event(void *opaque, QEMUChrEvent event)
>  {
>      VirtConsole *vcon = opaque;
>      VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(vcon);
> diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
> index 2c47275068..aa6bf02e21 100644
> --- a/hw/char/xilinx_uartlite.c
> +++ b/hw/char/xilinx_uartlite.c
> @@ -206,7 +206,7 @@ static int uart_can_rx(void *opaque)
>      return s->rx_fifo_len < sizeof(s->rx_fifo);
>  }
>  
> -static void uart_event(void *opaque, int event)
> +static void uart_event(void *opaque, QEMUChrEvent event)
>  {
>  
>  }
> diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
> index adf2afe728..16a4117ab0 100644
> --- a/hw/ipmi/ipmi_bmc_extern.c
> +++ b/hw/ipmi/ipmi_bmc_extern.c
> @@ -379,7 +379,7 @@ static void receive(void *opaque, const uint8_t *buf, int size)
>      handle_hw_op(ibe, hw_op);
>  }
>  
> -static void chr_event(void *opaque, int event)
> +static void chr_event(void *opaque, QEMUChrEvent event)
>  {
>      IPMIBmcExtern *ibe = opaque;
>      IPMIInterface *s = ibe->parent.intf;
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index ca7d813a52..29b476b4bd 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -98,7 +98,7 @@ enum boston_plat_reg {
>      PLAT_SYS_CTL        = 0x48,
>  };
>  
> -static void boston_lcd_event(void *opaque, int event)
> +static void boston_lcd_event(void *opaque, QEMUChrEvent event)
>  {
>      BostonState *s = opaque;
>      if (event == CHR_EVENT_OPENED && !s->lcd_inited) {
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 783cd99848..72c03baa8e 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -545,7 +545,7 @@ static void malta_fpga_reset(void *opaque)
>      snprintf(s->display_text, 9, "        ");
>  }
>  
> -static void malta_fgpa_display_event(void *opaque, int event)
> +static void malta_fgpa_display_event(void *opaque, QEMUChrEvent event)
>  {
>      MaltaFPGAState *s = opaque;
>  
> diff --git a/hw/riscv/riscv_htif.c b/hw/riscv/riscv_htif.c
> index 4f7b11dc37..ca87a5cf9f 100644
> --- a/hw/riscv/riscv_htif.c
> +++ b/hw/riscv/riscv_htif.c
> @@ -96,7 +96,7 @@ static void htif_recv(void *opaque, const uint8_t *buf, int size)
>   * Called by the char dev to supply special events to the HTIF console.
>   * Not used for HTIF.
>   */
> -static void htif_event(void *opaque, int event)
> +static void htif_event(void *opaque, QEMUChrEvent event)
>  {
>  
>  }
> diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
> index a403ae90f5..9350482662 100644
> --- a/hw/riscv/sifive_uart.c
> +++ b/hw/riscv/sifive_uart.c
> @@ -162,7 +162,7 @@ static int uart_can_rx(void *opaque)
>      return s->rx_fifo_len < sizeof(s->rx_fifo);
>  }
>  
> -static void uart_event(void *opaque, int event)
> +static void uart_event(void *opaque, QEMUChrEvent event)
>  {
>  }
>  
> diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
> index e53696c07a..3d40b700db 100644
> --- a/hw/usb/ccid-card-passthru.c
> +++ b/hw/usb/ccid-card-passthru.c
> @@ -307,7 +307,7 @@ static void ccid_card_vscard_read(void *opaque, const uint8_t *buf, int size)
>      }
>  }
>  
> -static void ccid_card_vscard_event(void *opaque, int event)
> +static void ccid_card_vscard_event(void *opaque, QEMUChrEvent event)
>  {
>      PassthruState *card = opaque;
>  
> diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
> index 2ba6870b37..9646fe77da 100644
> --- a/hw/usb/dev-serial.c
> +++ b/hw/usb/dev-serial.c
> @@ -461,7 +461,7 @@ static void usb_serial_read(void *opaque, const uint8_t *buf, int size)
>      s->recv_used += size;
>  }
>  
> -static void usb_serial_event(void *opaque, int event)
> +static void usb_serial_event(void *opaque, QEMUChrEvent event)
>  {
>      USBSerialState *s = opaque;
>  
> diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
> index ddc1a59cb4..0068aa8a19 100644
> --- a/hw/usb/redirect.c
> +++ b/hw/usb/redirect.c
> @@ -1354,7 +1354,7 @@ static void usbredir_chardev_read(void *opaque, const uint8_t *buf, int size)
>      usbredirparser_do_write(dev->parser);
>  }
>  
> -static void usbredir_chardev_event(void *opaque, int event)
> +static void usbredir_chardev_event(void *opaque, QEMUChrEvent event)
>  {
>      USBRedirDevice *dev = opaque;
>  
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 706ebe7074..944fa9651e 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -1322,7 +1322,7 @@ static void monitor_read(void *opaque, const uint8_t *buf, int size)
>      cur_mon = old_mon;
>  }
>  
> -static void monitor_event(void *opaque, int event)
> +static void monitor_event(void *opaque, QEMUChrEvent event)
>  {
>      Monitor *mon = opaque;
>      MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 6c46be40f8..54c06ba824 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -337,7 +337,7 @@ static QDict *qmp_greeting(MonitorQMP *mon)
>          ver, cap_list);
>  }
>  
> -static void monitor_qmp_event(void *opaque, int event)
> +static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
>  {
>      QDict *data;
>      MonitorQMP *mon = opaque;
> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> index 8d36009c53..d83e815545 100644
> --- a/net/filter-mirror.c
> +++ b/net/filter-mirror.c
> @@ -132,7 +132,7 @@ static void redirector_chr_read(void *opaque, const uint8_t *buf, int size)
>      }
>  }
>  
> -static void redirector_chr_event(void *opaque, int event)
> +static void redirector_chr_event(void *opaque, QEMUChrEvent event)
>  {
>      NetFilterState *nf = opaque;
>      MirrorState *s = FILTER_REDIRECTOR(nf);
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index c54c9c7d4c..17532daaf3 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -218,7 +218,7 @@ static gboolean net_vhost_user_watch(GIOChannel *chan, GIOCondition cond,
>      return TRUE;
>  }
>  
> -static void net_vhost_user_event(void *opaque, int event);
> +static void net_vhost_user_event(void *opaque, QEMUChrEvent event);
>  
>  static void chr_closed_bh(void *opaque)
>  {
> @@ -249,7 +249,7 @@ static void chr_closed_bh(void *opaque)
>      }
>  }
>  
> -static void net_vhost_user_event(void *opaque, int event)
> +static void net_vhost_user_event(void *opaque, QEMUChrEvent event)
>  {
>      const char *name = opaque;
>      NetClientState *ncs[MAX_QUEUE_NUM];
> diff --git a/qtest.c b/qtest.c
> index 8b50e2783e..12432f99cf 100644
> --- a/qtest.c
> +++ b/qtest.c
> @@ -722,7 +722,7 @@ static int qtest_can_read(void *opaque)
>      return 1024;
>  }
>  
> -static void qtest_event(void *opaque, int event)
> +static void qtest_event(void *opaque, QEMUChrEvent event)
>  {
>      int i;
>  
> diff --git a/tests/test-char.c b/tests/test-char.c
> index 45e42af290..3afc9b1b8d 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -54,7 +54,7 @@ static void fe_read(void *opaque, const uint8_t *buf, int size)
>      quit = true;
>  }
>  
> -static void fe_event(void *opaque, int event)
> +static void fe_event(void *opaque, QEMUChrEvent event)
>  {
>      FeHandler *h = opaque;
>      bool new_open_state;
> @@ -633,7 +633,7 @@ typedef struct {
>  
>  
>  static void
> -char_socket_event(void *opaque, int event)
> +char_socket_event(void *opaque, QEMUChrEvent event)
>  {
>      CharSocketTestData *data = opaque;
>      data->event = event;
> @@ -1006,7 +1006,7 @@ static void char_socket_client_test(gconstpointer opaque)
>  }
>  
>  static void
> -count_closed_event(void *opaque, int event)
> +count_closed_event(void *opaque, QEMUChrEvent event)
>  {
>      int *count = opaque;
>      if (event == CHR_EVENT_CLOSED) {
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index 91ea373ba5..2324b964ad 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -499,7 +499,7 @@ static TestServer *test_server_new(const gchar *name)
>      return server;
>  }
>  
> -static void chr_event(void *opaque, int event)
> +static void chr_event(void *opaque, QEMUChrEvent event)
>  {
>      TestServer *s = opaque;
>  
> -- 
> 2.21.0
> 

