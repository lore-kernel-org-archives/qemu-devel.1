Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ACFC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 18:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B12D1206F8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 18:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCgkFZIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12D1206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK52K-0007r5-T6
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 14:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jK51m-0007R0-8d
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 14:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jK51k-000889-Em
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 14:57:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56765
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jK51k-00086z-5k
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 14:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585853838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FKJKb/9T8nr3wcZKZu36h9rkNEKoln7jQvp+1NwX9jg=;
 b=RCgkFZIzJy3WF58YNasmUQVhfX9+/c2/8IDRBTCdi13XIWxc6EtOVtaAAs4c1s0ODuvQyw
 8k8cW/UQJBgdpDpRc53anEuhE/KGXailSJfTIhVqJqGfw0icT+JCutXBPdKf711plp9Fy4
 VAn8klVbHnz0HtJGh8H4JOTZhkLd0AI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-be0HZf0HMX6kOoDifoEqaQ-1; Thu, 02 Apr 2020 14:57:17 -0400
X-MC-Unique: be0HZf0HMX6kOoDifoEqaQ-1
Received: by mail-wr1-f70.google.com with SMTP id e10so1878669wru.6
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 11:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FKJKb/9T8nr3wcZKZu36h9rkNEKoln7jQvp+1NwX9jg=;
 b=qh/2tOmmD6IKMV3j9ID+6d1qDo9U9AZGqGrCfdeDY2Xpwpun8MTv85+nrG9EY2uh2J
 mqrkCOMvKzfGNkRbtCasqz6H0RI3rzUMmEocLUOMhSAQQNqrnKOq7lysOykfyN1Cr6By
 9et+nKXFYtL1w0sKpFf7T/yj9W7XbpHqZ1rM9Yyl4Ky4gmiZPymGYvGd+NXfKIlnHnDC
 GmjIMtPZiYj7YFiQ41GCfUpOM/dXIra6Kl7qz/6a1EY1SNg6mk+79Yc+RZ4OZlarhPQf
 oVU9cYDEvou3VtSqrdxkrbVXcuZABd2nnJWwKTrAZZsK3goJmSWPT3BEXvpnJ7zHfnZd
 S6GA==
X-Gm-Message-State: AGi0PuZZ2Ojb8APTwN/+CH/94nZwo1MgpxIYpnrlygog4+xYgfQ8Ox5o
 lgDvdFximve9UTwH7zvYr4cgMVJ5B+M5NbbPa6Nbya2LJwPkJ2DfjmEc6uFxD6euaF+0NBVADyX
 HkzUaI5bHoTc9O8k=
X-Received: by 2002:adf:f38a:: with SMTP id m10mr4953692wro.168.1585853835731; 
 Thu, 02 Apr 2020 11:57:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypIQbyJyeDS9VsklKgr45EzSCiHkNuhRVCi59rrXFdzLR12R+9ge0c2dMV0mp2o3eNBgJSPdhQ==
X-Received: by 2002:adf:f38a:: with SMTP id m10mr4953661wro.168.1585853835421; 
 Thu, 02 Apr 2020 11:57:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1868:42dd:216c:2c09?
 ([2001:b07:6468:f312:1868:42dd:216c:2c09])
 by smtp.gmail.com with ESMTPSA id j6sm9165192wrb.4.2020.04.02.11.57.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2020 11:57:14 -0700 (PDT)
Subject: Re: [PATCH for-5.0 v2] xen: fixup RAM memory region initialization
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200402145418.5139-1-imammedo@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <80d74c4b-b46b-705c-ecc2-d680fcf7bf66@redhat.com>
Date: Thu, 2 Apr 2020 20:57:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200402145418.5139-1-imammedo@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: anthony.perard@citrix.com, peter.maydell@linaro.org, rth@twiddle.net,
 ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/04/20 16:54, Igor Mammedov wrote:
> Since bd457782b3b0 ("x86/pc: use memdev for RAM") Xen
> machine fails to start with:
>    qemu-system-i386: xen: failed to populate ram at 0
> 
> The reason is that xen_ram_alloc() which is called by
> memory_region_init_ram(), compares memory region with
> statically allocated 'global' ram_memory memory region
> that it uses for RAM, and does nothing in case it matches.
> 
> While it's possible feed machine->ram to xen_ram_alloc()
> in the same manner to keep that hack working, I'd prefer
> not to keep that circular dependency and try to untangle that.
> 
> However it doesn't look trivial to fix, so as temporary
> fixup opt out Xen machine from memdev based RAM allocation,
> and let xen_ram_alloc() do its trick for now.
> 
> Reported-by: Anthony PERARD <anthony.perard@citrix.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>   * make it work with -M pc,accel=xen
> ---
>  hw/xen/xen-common.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
> index 15650d7f6a..a15070f7f6 100644
> --- a/hw/xen/xen-common.c
> +++ b/hw/xen/xen-common.c
> @@ -19,6 +19,7 @@
>  #include "sysemu/runstate.h"
>  #include "migration/misc.h"
>  #include "migration/global_state.h"
> +#include "hw/boards.h"
>  
>  //#define DEBUG_XEN
>  
> @@ -151,6 +152,8 @@ static void xen_setup_post(MachineState *ms, AccelState *accel)
>  
>  static int xen_init(MachineState *ms)
>  {
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +
>      xen_xc = xc_interface_open(0, 0, 0);
>      if (xen_xc == NULL) {
>          xen_pv_printf(NULL, 0, "can't open xen interface\n");
> @@ -170,6 +173,10 @@ static int xen_init(MachineState *ms)
>          return -1;
>      }
>      qemu_add_vm_change_state_handler(xen_change_state_handler, NULL);
> +    /*
> +     * opt out of system RAM being allocated by generic code
> +     */
> +    mc->default_ram_id = NULL;
>      return 0;
>  }
>  
> 

Monkey patching the class is slightly disgusting. :)  It would be better
to use a new ms->default_ram_id, and assign it from the class in
instance_init, but I've queued it anyway.

Paolo


