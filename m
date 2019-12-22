Return-Path: <SRS0=nsQZ=2M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C37C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 12:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1686C20663
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 12:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUsQJj4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1686C20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ij0WF-0000ns-5V
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 07:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ij0Uc-0008Uq-8p
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 07:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ij0Ub-0008IS-35
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 07:37:54 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35939)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ij0Ua-0008ED-R3
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 07:37:52 -0500
Received: by mail-wm1-x342.google.com with SMTP id p17so13587206wma.1
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2019 04:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eNYo1Ug1kIiutbMCyzGzA07EZ1COuyJ5YIOb1PmMs5I=;
 b=pUsQJj4jF7RTaSRNtoDUJl/iBH8FNAEvtimhdCdNWUJpdkEuJxB51KpUzudfs0Qisy
 9E07ggk1WyDwZkMMv1EvwKZdQ/bK+YeCE5udmhKIYjm/9oKxRJMTf5+DFZNVSXTN74is
 NZGmnsZnsnq2obitGtDmSh1AIXddYl5nHD+pzu3mzkcr3IusKFJf4V9M1a5foWQOxyvR
 ABSBijhG09DXrUUkL7e/KmXIOaHrkQ6+Pyzrt2Qucs3OzmGmyQ/Tl1R+5up4omDa6iw/
 wVWBQnhLhH+keA7ExpC5hdyRVu4eK/ZaNi4a25ElLlbjaUTXrzhZ6iylYVe9DfHeorWp
 nd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=eNYo1Ug1kIiutbMCyzGzA07EZ1COuyJ5YIOb1PmMs5I=;
 b=TidYz2SEexBvRK4sRTkETohE7xz3ve2JFHMx9K88wYjB3EO/flQH7RMXYIdo2YYDUB
 2KfaBKmGYEHkKJtnxAlgR3C21eqiBGNKXeNGfuHy1hFPIR6S1rDJNeTOZVJD+pVoQr8p
 PItVH3m1BlG2em09YDRHQsfbRQrZa5Htd2RSiFXj4eQ99q0wn320G9gUAQnlUGkZQwfl
 qTtYiN+Wo77KXCyYt4hWYKIZyqJdd5JxvvvT01L25gNRlSC3D40iw+bB9A+Vkcnp8k7s
 P0g+UyQS/5AVpdQGAfKERuWWw1p83CCOrivKFTAyOLUj3OJ+eNILJH8IctB4fjpew88c
 tuSQ==
X-Gm-Message-State: APjAAAV3ycY/dOktHXsUZl0THEabgYYFkSKL0FKCY8/bLxPTPGJYgpUN
 vh1kSmwuRQ3UV5MI3uRqkznzGVkBCFQ=
X-Google-Smtp-Source: APXvYqwGo+hW7Id05J3065h1QMn3vypF8oTbDpZPXev9arG0NZv1N0Nk/Fzkh2yHFP4brBhFFoOI3w==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr27674903wmk.15.1577018271373; 
 Sun, 22 Dec 2019 04:37:51 -0800 (PST)
Received: from [10.0.0.124] ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id a1sm16191172wmj.40.2019.12.22.04.37.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Dec 2019 04:37:50 -0800 (PST)
Subject: Re: [PATCH v5 5/6] hppa: Add emulation of Artist graphics
To: Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
References: <20191220211512.3289-1-svens@stackframe.org>
 <20191220211512.3289-6-svens@stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <8e0f79d6-46ba-a121-b6cc-8c0a5cc4ea14@amsat.org>
Date: Sun, 22 Dec 2019 13:37:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220211512.3289-6-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/20/19 10:15 PM, Sven Schnelle wrote:
> This adds emulation of Artist graphics good enough
> to get a Text console on both Linux and HP-UX. The
> X11 server from HP-UX also works.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  hw/display/Kconfig       |    4 +
>  hw/display/Makefile.objs |    1 +
>  hw/display/artist.c      | 1450 ++++++++++++++++++++++++++++++++++++++
>  hw/display/trace-events  |    9 +
>  hw/hppa/Kconfig          |    1 +
>  hw/hppa/hppa_hardware.h  |    1 +
>  hw/hppa/machine.c        |    9 +
>  7 files changed, 1475 insertions(+)
>  create mode 100644 hw/display/artist.c
> 
[...]
> diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
> index 507f91e05d..4a2fe2df60 100644
> --- a/hw/hppa/hppa_hardware.h
> +++ b/hw/hppa/hppa_hardware.h
> @@ -22,6 +22,7 @@
>  #define LASI_PS2KBD_HPA 0xffd08000
>  #define LASI_PS2MOU_HPA 0xffd08100
>  #define LASI_GFX_HPA    0xf8000000
> +#define ARTIST_FB_ADDR  0xf9000000
>  #define CPU_HPA         0xfffb0000
>  #define MEMORY_HPA      0xfffbf000
>  
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 33e3769d0b..6c67399054 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -75,6 +75,7 @@ static void machine_hppa_init(MachineState *machine)
>      MemoryRegion *cpu_region;
>      long i;
>      unsigned int smp_cpus = machine->smp.cpus;
> +    SysBusDevice *s;
>  
>      ram_size = machine->ram_size;
>  
> @@ -127,6 +128,14 @@ static void machine_hppa_init(MachineState *machine)
>      dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
>      lsi53c8xx_handle_legacy_cmdline(dev);
>  
> +    if (vga_interface_type != VGA_NONE) {
> +        dev = qdev_create(NULL, "artist");
> +        qdev_init_nofail(dev);
> +        s = SYS_BUS_DEVICE(dev);
> +        sysbus_mmio_map(s, 0, LASI_GFX_HPA);
> +        sysbus_mmio_map(s, 1, ARTIST_FB_ADDR);

How is this chipset connected on the board?
If it is a card you can plug on a bus, you can use a condition.
If it is soldered or part of another chipset, then it has to be mapped
unconditionally.
IOW I think you should drop the 'if (vga_interface_type != VGA_NONE)' check.

> +    }
> +
>      /* Network setup.  e1000 is good enough, failing Tulip support.  */
>      for (i = 0; i < nb_nics; i++) {
>          if (!enable_lasi_lan()) {
> 

