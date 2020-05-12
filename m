Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F21C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 11:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA8F206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 11:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0gji6XX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA8F206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYTRJ-0005JN-Nr
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 07:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYTQc-0004pq-NV
 for qemu-devel@nongnu.org; Tue, 12 May 2020 07:50:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22874
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYTQb-0000vu-VB
 for qemu-devel@nongnu.org; Tue, 12 May 2020 07:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589284228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N4qk5cMFNaLkQ+ykHae6XHaQyCYiLj1hIgNduDy2ESI=;
 b=f0gji6XXmlh6qH8GKnYm270Es4aXyJ8EBZ6F6wayRJWldDAEzHgZ9W92V7pyyrk7NzcyUW
 JxGVhyyBTIyVcNBL/EjXzThPMtVlTq2K067MdYgLbdgVYNYQdzZTmVx3WPEofno7B/nrfu
 RIY3YMxKadL+Nlw8Auk4gdvKHHRXibs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-3F2dKDbYOROs2JaKpGteag-1; Tue, 12 May 2020 07:50:26 -0400
X-MC-Unique: 3F2dKDbYOROs2JaKpGteag-1
Received: by mail-wm1-f69.google.com with SMTP id h6so9849719wmi.7
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 04:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N4qk5cMFNaLkQ+ykHae6XHaQyCYiLj1hIgNduDy2ESI=;
 b=ZIG25Tc1v3lYGBGFFsy9EAt7Bv1DuxVjdNvlTwDfcj3dNcZJn2qEgBDCpcz4qS3qPt
 5bdPuoSpXUiF1In+rQWYzV2eWtU+y/qa3NkQ5bT380Gran4dxjPu9a9B5tJjNIH897Nn
 TR2wmjDlLDcrJQHV5Rg4OZ+waZrUQAF/i2oSI2S/CpaFvLRgqs5u+TKFOX0Np5H0sBTn
 PMBv+rZtTG6/UXeCNv0EH/+SRdL1iD//Zt8L939IQQ6aL2AoV4V07VsG2pTFVjNorbjS
 8WupjXY767xqF9vkXnIJI087UP9UwLqLlOw4gHxi8fAGNm+uwSIHnFoAN1uWoT407FA6
 q4ng==
X-Gm-Message-State: AGi0PubrvDEDj1s84JF2DjKonMmSBSqKzm7QaBMMMuIuJIvx/W0tplTR
 8sCYIrKoWoojS6uPB8TsNRDGyBUQ/ov2dPGGUl20pdnarfTGXOZkCCVJVB8Z+EuXPsUszBNufgZ
 7K3n1QvN9mMEd1+U=
X-Received: by 2002:adf:face:: with SMTP id a14mr24308558wrs.397.1589284225414; 
 Tue, 12 May 2020 04:50:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ5wIS+OGMNUDdbqZDV9yJicSviQ59V8EpULFERXRwJYV6k8yEkSMJO+sQkl6EkFEqwtTVurA==
X-Received: by 2002:adf:face:: with SMTP id a14mr24308543wrs.397.1589284225250; 
 Tue, 12 May 2020 04:50:25 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id b14sm19358766wmb.18.2020.05.12.04.50.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2020 04:50:24 -0700 (PDT)
Subject: Re: [PATCH 05/10] ui/gtk: remove unused variable ignore_keys
To: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <2393388c-86c3-4d7e-178e-2c7e6d14a8de@t-online.de>
 <20200510184304.9267-5-vr_qemu@t-online.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3ce054cc-ec25-03f0-9d39-b0a525bc3b16@redhat.com>
Date: Tue, 12 May 2020 13:50:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200510184304.9267-5-vr_qemu@t-online.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:41:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

On 5/10/20 8:42 PM, Volker Rümelin wrote:
> Since the removal of GTK2 code 

"... in commit 89d85cde7 ..."

> the code around ignore_keys is
> unused. See commit 1a01716a30 "gtk: Avoid accel key leakage
> into guest on console switch" why it was needed before.
> 
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>

With description updated:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   ui/gtk.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/ui/gtk.c b/ui/gtk.c
> index c70bfc2be4..5a25e3fa4c 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -168,8 +168,6 @@ struct GtkDisplayState {
>   
>       bool external_pause_update;
>   
> -    bool ignore_keys;
> -
>       DisplayOptions *opts;
>   };
>   
> @@ -1085,14 +1083,8 @@ static gboolean gd_text_key_down(GtkWidget *widget,
>   static gboolean gd_key_event(GtkWidget *widget, GdkEventKey *key, void *opaque)
>   {
>       VirtualConsole *vc = opaque;
> -    GtkDisplayState *s = vc->s;
>       int qcode;
>   
> -    if (s->ignore_keys) {
> -        s->ignore_keys = (key->type == GDK_KEY_PRESS);
> -        return TRUE;
> -    }
> -
>   #ifdef WIN32
>       /* on windows, we ought to ignore the reserved key event? */
>       if (key->hardware_keycode == 0xff)
> @@ -1189,7 +1181,6 @@ static void gd_menu_switch_vc(GtkMenuItem *item, void *opaque)
>           gtk_notebook_set_current_page(nb, page);
>           gtk_widget_grab_focus(vc->focus);
>       }
> -    s->ignore_keys = false;
>   }
>   
>   static void gd_accel_switch_vc(void *opaque)
> 


