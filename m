Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142D3C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3074206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuWzdNjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3074206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juxw4-0002Ou-6E
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 08:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juxvM-0001wx-NO
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:51:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33325
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juxvL-0003YK-3r
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594644670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bplBZcXWkAsFuh7cwMMrTFfVw2JqA0Q0dpABGMhzwM0=;
 b=AuWzdNjncxOsnlKK4g1/canW2dOdQO+AwypVCiL3R83q2l25mvOvSbFBcppTl1H0iAHGht
 g5PSFcPO71Ss0P7DPekj5NNEY9DzZw+DaoYB7cbosNbBGrP9vTbiQwVk+LV1WM0RiTaB2u
 JbFZYVQRotCy7692HrOecLzbS0UVEtU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-sLA8laM5OECt_wy3nNwiuw-1; Mon, 13 Jul 2020 08:51:08 -0400
X-MC-Unique: sLA8laM5OECt_wy3nNwiuw-1
Received: by mail-ed1-f71.google.com with SMTP id a4so20892294edr.18
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 05:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=bplBZcXWkAsFuh7cwMMrTFfVw2JqA0Q0dpABGMhzwM0=;
 b=U+pCh4LBClZSzHeX5d8UYVErpfxX0GjzCbjrLnru1UbCdHTwH5ItL5zMGlAK2Xh2cY
 5w3/Uox98sgjC3BufbjJhRhf5UCa9kcBcrFPr8CYT9lVvUtEYmgcLcfNCS5jcaXUEw8c
 DnSNl/r1eqGXnwl5IuFGP5ftkPgvXgBpoaIyzd3PHN+JrwsqFAN9WBthtMOAUpZR2UfD
 yX34hdyC8Sud4aszAyDcQeHt6xyI1QmF371HAweszjeU9sTQUVjhDN9UtU6LluPzz4fP
 V44WBKQ2bzRUYrROgcytBNQLhXNMMGaU01DTWALRaycNyu2SpAxbXnwvadHMtxg423SV
 2v5w==
X-Gm-Message-State: AOAM530W7GeGOs5qZRz3BOYbs0iV6YS1rbQVUX24d53MMX7hEmp2EZ5X
 AEJcKxxBfJS6HxwKmIxTbxwC0DHAOg6rptIyJaoDi0ZAOVGfoefqvmqzgHTLyhTus1zL2SoQv3z
 Q98lR3t1QzA+d7p4=
X-Received: by 2002:aa7:c54f:: with SMTP id s15mr94228161edr.175.1594644667474; 
 Mon, 13 Jul 2020 05:51:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOzzGxdpN6lI7QCq1syoB1DsOazV0ud8HOon6UyM9yrnApoOkP86CV+Rap2nl/dgMIa/Z9GA==
X-Received: by 2002:aa7:c54f:: with SMTP id s15mr94228151edr.175.1594644667301; 
 Mon, 13 Jul 2020 05:51:07 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id g21sm11443428edr.45.2020.07.13.05.51.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 05:51:06 -0700 (PDT)
Subject: Re: [PATCH] vfio: fix use-after-free in display
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200713124520.23266-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <efedf130-518d-fd3a-04b6-b501bf06cc8c@redhat.com>
Date: Mon, 13 Jul 2020 14:51:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200713124520.23266-1-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 2:45 PM, Gerd Hoffmann wrote:
> Calling ramfb_display_update() might replace the DisplaySurface with the
> boot display, which in turn will free the currently active
> DisplaySurface.
> 
> So clear our DisplaySurface pinter (dpy->region.surface pointer) to (a)
> avoid use-after-free and (b) force replacing the boot display with the
> real display when switching back.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/vfio/display.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index a57a22674d62..342054193b3c 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -405,6 +405,7 @@ static void vfio_display_region_update(void *opaque)
>      if (!plane.drm_format || !plane.size) {
>          if (dpy->ramfb) {
>              ramfb_display_update(dpy->con, dpy->ramfb);
> +            dpy->region.surface = NULL;
>          }
>          return;
>      }
> 

More generic fix:

-- >8 --
--- a/ui/console.c
+++ b/ui/console.c
@@ -1580,10 +1580,10 @@ void dpy_gfx_replace_surface(QemuConsole *con,
                              DisplaySurface *surface)
 {
     DisplayState *s = con->ds;
-    DisplaySurface *old_surface = con->surface;
+    QemuConsole *old_con = con;
     DisplayChangeListener *dcl;

-    assert(old_surface != surface || surface == NULL);
+    assert(con->surface != surface || surface == NULL);

     con->surface = surface;
     QLIST_FOREACH(dcl, &s->listeners, next) {
@@ -1594,7 +1594,8 @@ void dpy_gfx_replace_surface(QemuConsole *con,
             dcl->ops->dpy_gfx_switch(dcl, surface);
         }
     }
-    qemu_free_displaysurface(old_surface);
+    qemu_free_displaysurface(old_con->surface);
+    old_con->surface = NULL;
 }
---


