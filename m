Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEEDC54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 14:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE76A20736
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 14:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boEozuI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE76A20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRzXy-0000HA-W6
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 10:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jRzXK-0008Ae-FJ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jRzXJ-0003yK-F2
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:42:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41535
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jRzXJ-0003xR-12
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587739355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P/yYcCvHxfxCN44CZ7vyQicIdssrpJJM4lcGCCGuT4s=;
 b=boEozuI9IwEvWFZI8DjmbXUDODQ+YjMFbRjmg/9YxZ7aG4lgeIIoW9UTRH99hXvyDu3Vaf
 MOhGH14oJbvJIf695iDSOgqK29WTNgQgzvWQE1ovTxeIekuDEwhyL40YKXWLN90ZzyEgaB
 VxMjUWjBo/c1RUWLgc8tPtF2JhSBqFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-5HE8ueVMP0CqfH_73TnWVw-1; Fri, 24 Apr 2020 10:42:30 -0400
X-MC-Unique: 5HE8ueVMP0CqfH_73TnWVw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B785D180F112;
 Fri, 24 Apr 2020 14:42:29 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-159.ams2.redhat.com
 [10.36.113.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE8E01001B2C;
 Fri, 24 Apr 2020 14:42:21 +0000 (UTC)
Subject: Re: [PATCH 4/5] ramfb: add sanity checks to
 ramfb_create_display_surface
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20200422100211.30614-1-kraxel@redhat.com>
 <20200422100211.30614-5-kraxel@redhat.com>
 <b4af9628-1585-9dc5-214d-b55db4760da1@redhat.com>
 <20200423114129.lil77p4iqy3jc5v7@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <7eb38a07-a50c-2695-2ca7-822f5c1408eb@redhat.com>
Date: Fri, 24 Apr 2020 16:42:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200423114129.lil77p4iqy3jc5v7@sirius.home.kraxel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:11:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 hqm03ster@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/23/20 13:41, Gerd Hoffmann wrote:
>   Hi,
> 
>> - if "linesize" is nonzero, make sure it is a whole multiple of the
>> required word size (?)
>>
>> - if "linesize" is nonzero, make sure it is not bogus with relation to
>> "width". I'm thinking something like:
> 
> Yep, the whole linesize is a bit bogus, noticed after sending out this
> series, I have a followup patch for that (see below).
> 
> take care,
>   Gerd
> 
> From 154dcff73dc533fc95c88bd960ed65108af6c734 Mon Sep 17 00:00:00 2001
> From: Gerd Hoffmann <kraxel@redhat.com>
> Date: Wed, 22 Apr 2020 12:07:59 +0200
> Subject: [PATCH] ramfb: fix size calculation
> 
> size calculation isn't correct with guest-supplied stride, the last
> display line isn't accounted for correctly.
> 
> For the typical case of stride > linesize (add padding) we error on the
> safe side (calculated size is larger than actual size).
> 
> With stride < linesize (scanlines overlap) the calculated size is
> smaller than the actual size though so our guest memory mapping might
> end up being too small.
> 
> While being at it also fix ramfb_create_display_surface to use hwaddr
> for the parameters.  That way all calculation are done with hwaddr type
> and we can't get funny effects from type castings.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/ramfb.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index be884c9ea837..928d74d10bc7 100644
> --- a/hw/display/ramfb.c
> +++ b/hw/display/ramfb.c
> @@ -44,10 +44,10 @@ static void ramfb_unmap_display_surface(pixman_image_t *image, void *unused)
>  
>  static DisplaySurface *ramfb_create_display_surface(int width, int height,
>                                                      pixman_format_code_t format,
> -                                                    int linesize, uint64_t addr)
> +                                                    hwaddr stride, hwaddr addr)
>  {
>      DisplaySurface *surface;
> -    hwaddr size;
> +    hwaddr size, mapsize, linesize;
>      void *data;
>  
>      if (width < 16 || width > VBE_DISPI_MAX_XRES ||
> @@ -55,19 +55,20 @@ static DisplaySurface *ramfb_create_display_surface(int width, int height,
>          format == 0 /* unknown format */)
>          return NULL;
>  
> -    if (linesize == 0) {
> -        linesize = width * PIXMAN_FORMAT_BPP(format) / 8;
> +    linesize = width * PIXMAN_FORMAT_BPP(format) / 8;
> +    if (stride == 0) {
> +        stride = linesize;
>      }
>  
> -    size = (hwaddr)linesize * height;
> -    data = cpu_physical_memory_map(addr, &size, false);
> -    if (size != (hwaddr)linesize * height) {
> -        cpu_physical_memory_unmap(data, size, 0, 0);
> +    mapsize = size = stride * (height - 1) + linesize;
> +    data = cpu_physical_memory_map(addr, &mapsize, false);
> +    if (size != mapsize) {
> +        cpu_physical_memory_unmap(data, mapsize, 0, 0);
>          return NULL;
>      }
>  
>      surface = qemu_create_displaysurface_from(width, height,
> -                                              format, linesize, data);
> +                                              format, stride, data);
>      pixman_image_set_destroy_function(surface->image,
>                                        ramfb_unmap_display_surface, NULL);
>  
> 

I don't understand two things about this patch:

- "stride" can still be smaller than "linesize" (scanlines can still
overlap). Why is that not a problem?

- assuming "stride > linesize" (i.e., strictly larger), we don't seem to
map the last complete stride, and that seems to be intentional. Is that
safe with regard to qemu_create_displaysurface_from()? Ultimately the
stride is passed to pixman_image_create_bits(), and the underlying
"data" may not be large enough for that. What am I missing?

Hm... bonus question: qemu_create_displaysurface_from() still accepts
"linesize" as a signed int. (Not sure about pixman_image_create_bits().)
Should we do something specific to prevent that value from being
negative? The guest gives us a uint32_t.

Thanks
Laszlo


