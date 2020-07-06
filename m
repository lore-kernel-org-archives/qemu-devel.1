Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE1EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDBE8206E9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/8rzRM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBE8206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsaIm-0004Es-3M
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 19:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jsaI5-0003K7-H8
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:12:49 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jsaI3-0003Yc-VU
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:12:49 -0400
Received: by mail-pl1-x641.google.com with SMTP id d10so15937850pls.5
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 16:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yl8hw7t4YFATPURw6Wj4/4kj7kITZfsn1J1rYvi7Vbw=;
 b=j/8rzRM8S8A4g2FdCuazmErt/EGoM+Yg1VROM6vSzWXB6FBX5T4ZRDchsOSoMV9Ybz
 n0/YGiMaLY0lsjqgARHlNJLpfOPqOpeHy+hfBphHJFyQ4F72pV6YCRnRFfY/tr7DqfGj
 yWGCsKkALnmkY1nUdqiYBhYX1V/MeX11wDPYv2L7QW2TDAZ+UM2Zu/iUW/CX+/k3KG3l
 Ntgki5qyVj78mmgYKthE8zHzHSjW1Qw8I9U6qeVqzmeEVCHb/NpQQM40EdYqFXeL0CWt
 kttNwK5XDQBfqfGpzy0oR4I6fsygsggj4SWBl0Tg0pihpqnSt3BpkXSsqh3YTV2168Hb
 3zhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yl8hw7t4YFATPURw6Wj4/4kj7kITZfsn1J1rYvi7Vbw=;
 b=RpqYF/acBx7N72OW3W8F9b17glIFSvyNSgZzZgPIwWfTzc91x8XGoCjBFeRN8KxUWW
 sGzFrvqKnVXg+CpWKFC8prQ9xxEbstptHoGlxTGECBJjEj94x/xf5D7nZQ/VpaC/uZuW
 rWvWxCfBiAX22mMbSrsAZEU1y4Fbrq3ApAAE5q0iW+pyaYjP2q4HqbauxsyOWfj58Q82
 Ze4rJ5E9Ax3KJ4AzH54lhhlg2gPX8GgELMiSZ2QeQFhrA6IXQqvZPCzNpc+S3nsXgCIn
 0XHQXVPxedtgtetF11jmhyWNrW/wBT+TKdflaoLsTzuN3Iv6rmh65g2fm/kPK7MAH/38
 0m+w==
X-Gm-Message-State: AOAM531ivceyOP9mcRYkV2FNTkPv46sTf3fJ8fXMuzPfp26jBgA7ewtn
 CJdBKRE3eoBNGTuJmaNelX6GU0/N5JI=
X-Google-Smtp-Source: ABdhPJwG01qtIYUIVWx4kJ3HiVLojPJaCY0T7o16FFPngeVfTcjNLSVQlHKE9t5wJVYke1Qh+U801w==
X-Received: by 2002:a17:90a:db48:: with SMTP id
 u8mr1238233pjx.169.1594077162450; 
 Mon, 06 Jul 2020 16:12:42 -0700 (PDT)
Received: from [192.168.0.54] ([75.167.235.8])
 by smtp.gmail.com with ESMTPSA id i67sm18771973pfg.13.2020.07.06.16.12.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 16:12:41 -0700 (PDT)
Subject: Re: Failure prints during format or mounting a usb storage device
From: Paul Zimmerman <pauldzim@gmail.com>
To: Sai Pavan Boddu <saipava@xilinx.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <BY5PR02MB677298C4D2C2B63EF409AA5CCA6B0@BY5PR02MB6772.namprd02.prod.outlook.com>
 <CADBGO7-hp4Pyfn+rq9d=ZxHmpMwitv-oLjYPJmCKSH6cLHVx=w@mail.gmail.com>
 <CADBGO78-mqwapj+mdpFUO-puL0OZ_1QeBc+4yo4S9g1O4deNjg@mail.gmail.com>
Message-ID: <2d312ec0-d280-c0e3-2b1e-ff9c70c3168f@gmail.com>
Date: Mon, 6 Jul 2020 16:12:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CADBGO78-mqwapj+mdpFUO-puL0OZ_1QeBc+4yo4S9g1O4deNjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=pauldzim@gmail.com; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vikram Garhwal <fnuv@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/6/20 3:21 PM, Paul Zimmerman wrote:
> 
> On Sat, Jul 4, 2020 at 11:24 AM Paul Zimmerman <pauldzim@gmail.com <mailto:pauldzim@gmail.com>> wrote:
> 
> 
> 
>     On Sat, Jul 4, 2020 at 11:21 AM Sai Pavan Boddu <saipava@xilinx.com <mailto:saipava@xilinx.com>> wrote:
> 
>         Hi,____
> 
>         __ __
> 
>         We are seeing some errors when a usb-storage device is formatted or mounted on the guest. Below is commit I have bisected it.____
> 
>         __ __
> 
>         **************____
> 
>         Errors:____
> 
>         __ __
> 
>         / # mount /dev/sda /mnt____
> 
>         [New Thread 0x7fffd4680700 (LWP 23270)]____
> 
>         [   33.258454] usb 2-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd____
> 
>         [   33.399528] usb 2-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd____
> 
>         [   33.544621] usb 2-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd____
> 
>         [   33.560460] sd 2:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK____
> 
>         [   33.562405] sd 2:0:0:0: [sda] tag#0 CDB: Read(10) 28 00 00 00 10 00 00 00 01 00____
> 
>         [   33.563389] blk_update_request: I/O error, dev sda, sector 4096 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0____
> 
>         / # [Thread 0x7fffd4680700 (LWP 23270) exited]____
> 
>         __ __
> 
>         ================____
> 
>         Bisect commit :____
> 
>         __ __
> 
>         commit 7ad3d51ebb8a522ffcad391c4bef281245739dde____
> 
>         Author: Paul Zimmerman <pauldzim@gmail.com <mailto:pauldzim@gmail.com>>____
> 
>         Date:   Wed May 20 16:53:47 2020 -0700____
> 
>         __ __
> 
>              usb: add short-packet handling to usb-storage driver____
> 
>         __ __
> 
>              The dwc-hsotg (dwc2) USB host depends on a short packet to____
> 
>              indicate the end of an IN transfer. The usb-storage driver____
> 
>              currently doesn't provide this, so fix it.____
> 
>         __ __
> 
>              I have tested this change rather extensively using a PC____
> 
>              emulation with xhci, ehci, and uhci controllers, and have____
> 
>              not observed any regressions.____
> 
>         __ __
> 
>              Signed-off-by: Paul Zimmerman <pauldzim@gmail.com <mailto:pauldzim@gmail.com>>____
> 
>              Message-id: 20200520235349.21215-6-pauldzim@gmail.com <mailto:20200520235349.21215-6-pauldzim@gmail.com>____
> 
>              Signed-off-by: Peter Maydell peter.maydell@linaro.org <mailto:peter.maydell@linaro.org>____
> 
>         __ __
> 
>         =====================____
> 
>         Steps to reproduce:____
> 
>          1. x86_64-softmmu/qemu-system-x86_64 -kernel bzImage -nographic -append "console=ttyS0" -m 512M -initrd initramfs.cpio.gz -device qemu-xhci,id=xhci1 -drive file=./usb.img,if=none,id=stick____
>          2. Hotplug usb-storage:____
> 
>                                          device_add usb-storage,bus=xhci1.0,port=1,id=usbdev1,drive=stick____
> 
>          3. Format &  mount the detected device____
> 
>         mkfs.vfat -F 32 /dev/sda
>         mount /dev/sda /mnt____
> 
>         You can find the similar errors mentioned above at this stage.____
> 
>         ____
> 
>         Test Environment:____
> 
>                 Host:  Ubuntu 16.04 LTS____
> 
>                 Guest:  kernel version: 5.4.0 & BusyBox v1.31.1____
> 
>         __ __
> 
>         Thanks & Regards,____
> 
>         Sai Pavan____
> 
>         __ __
> 
>     I can try to reproduce this on Monday, if no one beats me to it.
> 
> 
> 
> I am able to reproduce this. Despite the errors in dmesg, the drive
> does end up mounting and working OK, which is probably why I didn’t
> spot it during testing. Sai, does the drive work OK for you too
> despite the errors?
> 
> Thanks,
> Paul

Gerd, do you know the purpose of the 'short_not_ok' parameter to
usb_packet_setup()? The simple patch below fixes the reported problem,
but I don't know if it could cause some other problems for XHCI.
hcd-ehci, hcd-ohci, hcd-uhci all set the parameter conditionally,
but hcd-xhci never sets it. I don't understand the purpose of the
parameter myself.

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index b330e36fe6..9fb96fdd66 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1614,7 +1614,7 @@ static int xhci_setup_packet(XHCITransfer *xfer)
  
      xhci_xfer_create_sgl(xfer, dir == USB_TOKEN_IN); /* Also sets int_req */
  
      xhci_xfer_create_sgl(xfer, dir == USB_TOKEN_IN); /* Also sets int_req */
      usb_packet_setup(&xfer->packet, dir, ep, xfer->streamid,
-                     xfer->trbs[0].addr, false, xfer->int_req);
+                     xfer->trbs[0].addr, dir == USB_TOKEN_IN, xfer->int_req);
      usb_packet_map(&xfer->packet, &xfer->sgl);
      DPRINTF("xhci: setup packet pid 0x%x addr %d ep %d\n",
              xfer->packet.pid, ep->dev->addr, ep->nr);

Thanks,
Paul

