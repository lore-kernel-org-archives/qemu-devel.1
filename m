Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783DAC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C969620786
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNZfftB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C969620786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kagFS-0003dL-MV
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 09:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kagEQ-0002t3-Vv
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:27:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kagEO-0003cN-Aj
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604586434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wnbw+nor7/LV/tYWObnqggroqgTzbgDAIp5ur+bzuqQ=;
 b=BNZfftB5omlQmDA7tOQ3jE79JVyraYrGjVzcQ6OE2ZZpmiHAN4Ztbv4UX5rPBNI61T4Q4h
 8MJWco4EykM2WpcBu8JQE8TgdfFQ4wimRbDQbDhemTjfM9Tno3seCJ2zoiMkRKVRjTzgs2
 Pk8SPAeErhsrrBPLJ9deGtkMVvIuzk8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-dATV3HJcM2WHxv-lTg5hJQ-1; Thu, 05 Nov 2020 09:26:34 -0500
X-MC-Unique: dATV3HJcM2WHxv-lTg5hJQ-1
Received: by mail-wr1-f69.google.com with SMTP id u1so796236wri.6
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 06:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Wnbw+nor7/LV/tYWObnqggroqgTzbgDAIp5ur+bzuqQ=;
 b=bW1SEGPLV2qIXfLa45TMRbqHOL00uFNc2BfT2YZQ+nIrXnY82qjMnPTxN9fYgZ7m8P
 QEhUq8E2XD0HOquxmgSNvclTPuNK5wUkmyUymtYxWZo+2FuTcQFffFX/o6nGm8VJr3Ub
 1soQcfSJWqliWtkXIdIl4q6lFqfAW+jr9bFyXOEcBEseAklNeHjR0P7iJqJKrlqLs2Wf
 a5uSrEYGRg+l7+3T1I/DKOjauFhVHdR1coX9nXdi1if/iOeeDg/qWxLkG7vwhvFWSoCD
 f6uscRt8tABlB+Z9z/ds22JFsSz2tLop1Pig6nVdPXdMoJeoEW/RnDrmpoPUVugjlIeq
 NCSw==
X-Gm-Message-State: AOAM531BzzeKpMRzUxZpb/7dkQjevOZh2BjB+mQwQlbVrhB44yg8L7fP
 MzdfSq7ShgKOzZA8xnwy1wiz6nOXICSrLlB2f/7zlNBbDCjATrkyymHf7FKFHo7sYwm2G5jYV5B
 oioYK9YieTpg7s0o=
X-Received: by 2002:adf:e446:: with SMTP id t6mr3158044wrm.46.1604586392766;
 Thu, 05 Nov 2020 06:26:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyiqFpoKwprQR9u20o5x4cLJCFzLjwvy1xdSvO/Dq3k/9jPRP3fwe57yfSYnD7KkRxOMlxoXA==
X-Received: by 2002:adf:e446:: with SMTP id t6mr3158034wrm.46.1604586392612;
 Thu, 05 Nov 2020 06:26:32 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t6sm2693130wrp.68.2020.11.05.06.26.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 06:26:32 -0800 (PST)
Subject: Re: [PATCH 1/6] usb-storage: switch trace events
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20201105134112.25119-1-kraxel@redhat.com>
 <20201105134112.25119-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b533058d-3f6c-9200-6ea1-701688953149@redhat.com>
Date: Thu, 5 Nov 2020 15:26:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105134112.25119-2-kraxel@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 2:41 PM, Gerd Hoffmann wrote:
> Replace most DPRINTF macros with trace events.
> Drop some DPRINTF macros.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/dev-storage.c | 42 +++++++++++++++++-------------------------
>  hw/usb/trace-events  | 12 ++++++++++++
>  2 files changed, 29 insertions(+), 25 deletions(-)
...

> diff --git a/hw/usb/trace-events b/hw/usb/trace-events
> index a3292d46248f..38e05fc7f4db 100644
> --- a/hw/usb/trace-events
> +++ b/hw/usb/trace-events
> @@ -252,6 +252,18 @@ usb_hub_attach(int addr, int nr) "dev %d, port %d"
>  usb_hub_detach(int addr, int nr) "dev %d, port %d"
>  usb_hub_status_report(int addr, int status) "dev %d, status 0x%x"
>  
> +# dev-storage.c
> +usb_msd_reset(void) ""
> +usb_msd_maxlun(unsigned maxlun) "%d"
> +usb_msd_send_status(unsigned status, unsigned tag, size_t size) "status %d, tag 0x%x, len %zd"
> +usb_msd_data_in(unsigned packet, unsigned remaining, unsigned total) "%d/%d (scsi %d)"
> +usb_msd_data_out(unsigned packet, unsigned remaining) "%d/%d"
> +usb_msd_packet_async(void) ""
> +usb_msd_packet_complete(void) ""
> +usb_msd_cmd_submit(unsigned lun, unsigned tag, unsigned flags, unsigned len, unsigned data_len) "lun %u, tag 0x%x, flags 0x%08x, len %d, data-len %d"
> +usb_msd_cmd_complete(unsigned status, unsigned tag) "status %d, tag 0x%x"

Using '%u' format for unsigned type:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


