Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784BFC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 07:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44FE2206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 07:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8aEFDf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FE2206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJBhY-0000yB-DZ
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 03:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJBgv-0000XY-3w
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJBgt-0007ZF-Sw
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:52:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52172
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJBgt-0007Xb-Op
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585641127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZTnh6Sdl5OxEC/lg+y3pRCJ78pEV+Tne95Vbe6nU4zU=;
 b=U8aEFDf3SCo4nSn9UrW1a3lPBenpteJuy8Je29v4CslXdjIIxJFD12dcqYvzJFGtyiet8e
 vvkTdabB++SQ+kx9IeccLLMHq659gaeVC2owMeBoawE0I3LhN7TkS/anQzovJpQ/uQqAvA
 VQGefRNejCae5D6FB3USwwNEKrmT7E4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-oJxo8Gq7MQ2rg0k2bIZWhw-1; Tue, 31 Mar 2020 03:52:03 -0400
X-MC-Unique: oJxo8Gq7MQ2rg0k2bIZWhw-1
Received: by mail-ed1-f71.google.com with SMTP id w6so18054814edq.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 00:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZTnh6Sdl5OxEC/lg+y3pRCJ78pEV+Tne95Vbe6nU4zU=;
 b=JwH9+dEVjiEi4dZs91f174WvczZ4/dT6KvGeWPYCxn3ltDe1Q7/6S5gOWbUZYU8GbR
 MoeSJMqk8DKTIn5DqF2MivtLACY4C0ulv3e1T0VjoF6pbR0f6LcohKvMeBipiGznDSFf
 xHit8Pe9FofelyaXDlUYc08Ax1lU2HKCj10XirMsj62bmjsZ29GfRjJmU8jVrKnFHZ3y
 rW6jTapBvVi9kRsFuTOKt5rQ5pSDcPnwCtHvRHwNQHvrz64jLKx721ytwIXL4pl2bDpS
 JNWXppUiWBScE3kdH/ElMSyYZbnd4Xs48KkD9zTICN79Q4uD/ATKofsNxkg2/zp/yXw1
 D+Ig==
X-Gm-Message-State: ANhLgQ0Qc/mefLI/7sqqlX09cSWK1XbZCkDKugtLu6RVV7b+yyV7i0+K
 VKN9BNvxST+FHEKnfiZoNqS5evOoOFMKmlCC7xGzGliXswJE/MLDmhUgCyM5gszZUS6XexAikHl
 8QlEGbyx8NJ/gHJs=
X-Received: by 2002:a17:906:bcc7:: with SMTP id
 lw7mr14001485ejb.91.1585641122375; 
 Tue, 31 Mar 2020 00:52:02 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs4yJUhPFfPakmbmz7YCQGq/4HsLxzkb8yjS7ASRbvCrCa7IHwkjPKSvvjv6wJueWKCqRoQIA==
X-Received: by 2002:a17:906:bcc7:: with SMTP id
 lw7mr14001470ejb.91.1585641122037; 
 Tue, 31 Mar 2020 00:52:02 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id l62sm2171616edl.89.2020.03.31.00.52.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 00:52:01 -0700 (PDT)
Subject: Re: [PATCH v1] usb: Add read support for HCIVERSION register to XHCI
To: Cameron Esfahani <dirty@apple.com>, qemu-devel@nongnu.org
References: <20200330214444.43494-1-dirty@apple.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <71ec6105-b2f7-4805-c235-645c25a0b201@redhat.com>
Date: Tue, 31 Mar 2020 09:52:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200330214444.43494-1-dirty@apple.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Robert Mustacchi <rm@fingolfin.org>, Paolo Bonzini <pbonzini@redhat.com>,
 kraxel@redhat.com, Paul Menzel <pmenzel@molgen.mpg.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/30/20 11:44 PM, Cameron Esfahani via wrote:
> macOS will read HCIVERSION separate from CAPLENGTH.  Add a distinct
> handler for that register.

Apparently a fix for https://bugs.launchpad.net/qemu/+bug/1693050.

> 
> Signed-off-by: Cameron Esfahani <dirty@apple.com>
> ---
>   hw/usb/hcd-xhci.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index b330e36fe6..061f8438de 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -2739,6 +2739,9 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr reg, unsigned size)
>       case 0x00: /* HCIVERSION, CAPLENGTH */
>           ret = 0x01000000 | LEN_CAP;
>           break;
> +    case 0x02: /* HCIVERSION */
> +        ret = 0x0100;
> +        break;

But we have:

static const MemoryRegionOps xhci_cap_ops = {
     .read = xhci_cap_read,
     .write = xhci_cap_write,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
     .endianness = DEVICE_LITTLE_ENDIAN,
};

IIUC ".impl.min_access_size = 4" means the case 'reg == 2' can not 
happen. It seems we have a bug in memory.c elsewhere.

How can we reproduce?

If not easy, can you share the backtrace of:

-- >8 --
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index b330e36fe6..d021129f3f 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -2735,6 +2735,7 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr 
reg, unsigned size)
      XHCIState *xhci = ptr;
      uint32_t ret;

+    assert(reg != 2);
      switch (reg) {
      case 0x00: /* HCIVERSION, CAPLENGTH */
          ret = 0x01000000 | LEN_CAP;
---

>       case 0x04: /* HCSPARAMS 1 */
>           ret = ((xhci->numports_2+xhci->numports_3)<<24)
>               | (xhci->numintrs<<8) | xhci->numslots;
> 


