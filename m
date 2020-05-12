Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68153C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 11:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31414206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 11:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vhowr1z1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31414206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYTSb-0006Dk-DT
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 07:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYTRq-0005nX-9c
 for qemu-devel@nongnu.org; Tue, 12 May 2020 07:51:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27046
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYTRp-0001FT-Bg
 for qemu-devel@nongnu.org; Tue, 12 May 2020 07:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589284304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I058l6lbS0+t65MAHtM1zhsFjBG9Hn2FVlVRTJN100Q=;
 b=Vhowr1z1GxNsWF1EEPPEGfJXU2FDG9jvRiH9pyfbrAMY0Oj4BhkAafkMNMLWudEAZ/VG2P
 G0nm42XrESdqBKdwOH8t8VsmGSprr1TLgyn4dpHTd+AVG/Y9Ny92Q96kd+lq6jUyRFtIST
 8uFTVaGcoNYiQJKnKr+Hipd1b5QCojk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-Ir5LqJrXO2CYVrywcHsVig-1; Tue, 12 May 2020 07:51:42 -0400
X-MC-Unique: Ir5LqJrXO2CYVrywcHsVig-1
Received: by mail-wm1-f71.google.com with SMTP id t23so1299126wmi.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 04:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I058l6lbS0+t65MAHtM1zhsFjBG9Hn2FVlVRTJN100Q=;
 b=PBW4spdaK4zF0J4Hh40yg4WlXv8MROa4wIAdE85hmMC87nhodivHKsBY9vgzwjXU9B
 pf0/Obx3kp7+8tNeP9T2+QAqSj8zOyeitOMtw357fspSeRmrZ7ZV1p4FYDJSQ2mc61DK
 T1h4xR5bkNM+EZqWqBcGgdftsr05ZRhZwi7vZdEcBVlLNHcrN440byqZ+uJEEkm+4V2W
 3QRmWscF91wsDEfWNylFupxsZE1z7OWmjRiNlTX+D7R2cS+awiHRRxRm+/MJL8z/Ha+7
 BX3YLSww2MogIPGSdqu5MdNKHbwhjabzpKQyp4UOZbfPQgnpF0P1sXgWWI9ijIB8c4lj
 0Yeg==
X-Gm-Message-State: AGi0PuYEpJCBlpMjJ/lFvMWtQL6F3NQOZPl1KnMkwnp5zoWTIUnbYKLO
 hUMPKdnAjgJlemwDgSkXKoxGXy1WzL0XsH1AIfP4xe+PY8HibUZ1sqMsEMAgaMai4R0Bg49Jcqx
 c69CqZVj0U3+IbYg=
X-Received: by 2002:adf:ea44:: with SMTP id j4mr26298250wrn.38.1589284301077; 
 Tue, 12 May 2020 04:51:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypJo3mzZ6kvREet6NJH92mBo0JRbuMUMOyj6JJfoFn524dh++GH/n+fQJh8lGSe5dDBz+cEKew==
X-Received: by 2002:adf:ea44:: with SMTP id j4mr26298224wrn.38.1589284300850; 
 Tue, 12 May 2020 04:51:40 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id n24sm14648005wmi.40.2020.05.12.04.51.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2020 04:51:40 -0700 (PDT)
Subject: Re: [PATCH 08/10] ui/sdl2-input: use trace-events to debug key events
To: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <2393388c-86c3-4d7e-178e-2c7e6d14a8de@t-online.de>
 <20200510184304.9267-8-vr_qemu@t-online.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ff7ac93e-a5d7-b18e-59eb-f02eb36f3572@redhat.com>
Date: Tue, 12 May 2020 13:51:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200510184304.9267-8-vr_qemu@t-online.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/10/20 8:43 PM, Volker Rümelin wrote:
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> ---
>   ui/sdl2-input.c | 3 +++
>   ui/trace-events | 3 +++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
> index 1f9fe831b3..f068382209 100644
> --- a/ui/sdl2-input.c
> +++ b/ui/sdl2-input.c
> @@ -27,6 +27,7 @@
>   #include "ui/console.h"
>   #include "ui/input.h"
>   #include "ui/sdl2.h"
> +#include "trace.h"
>   
>   void sdl2_process_key(struct sdl2_console *scon,
>                         SDL_KeyboardEvent *ev)
> @@ -38,6 +39,8 @@ void sdl2_process_key(struct sdl2_console *scon,
>           return;
>       }
>       qcode = qemu_input_map_usb_to_qcode[ev->keysym.scancode];
> +    trace_sdl2_process_key(ev->keysym.scancode, qcode,
> +                           ev->type == SDL_KEYDOWN ? "down" : "up");
>       qkbd_state_key_event(scon->kbd, qcode, ev->type == SDL_KEYDOWN);
>   
>       if (!qemu_console_is_graphic(con)) {
> diff --git a/ui/trace-events b/ui/trace-events
> index 0dcda393c1..5367fd3f16 100644
> --- a/ui/trace-events
> +++ b/ui/trace-events
> @@ -75,6 +75,9 @@ input_event_abs(int conidx, const char *axis, int value) "con %d, axis %s, value
>   input_event_sync(void) ""
>   input_mouse_mode(int absolute) "absolute %d"
>   
> +# sdl2-input.c
> +sdl2_process_key(int sdl_scancode, int qcode, const char *action) "translated SDL scancode %d to QKeyCode %d (%s)"
> +
>   # spice-display.c
>   qemu_spice_add_memslot(int qid, uint32_t slot_id, unsigned long virt_start, unsigned long virt_end, int async) "%d %u: host virt 0x%lx - 0x%lx async=%d"
>   qemu_spice_del_memslot(int qid, uint32_t gid, uint32_t slot_id) "%d gid=%u sid=%u"
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


