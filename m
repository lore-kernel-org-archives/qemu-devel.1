Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD473C388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 09:00:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9CA20704
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 09:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LD+2p9gE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9CA20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbK5N-0007TE-24
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 04:00:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbK4R-000704-Tz
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 03:59:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56067)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbK4Q-0006NH-60
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 03:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604739577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3fejYZCGdqtP2PcGYj2CLQRph7/f+1FTFxzQ7+HwqdY=;
 b=LD+2p9gEfhtqjImOMdpWR06x8dI/q4zCrdm1aajwF90pc9oX8EVZecMOG5QCNf5EVy+FuU
 dtzHFVQcOGSCNriMFjn6Am272sDsTwZyumQLYSrZgUbPGvE1QVi6D1HuS1p/LRjpgCALK1
 tmXaQVNSWLWY9bV5G/yGqVWO5EXfdfc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-Yb8XU3cWN8iu3rJIFY83hg-1; Sat, 07 Nov 2020 03:59:35 -0500
X-MC-Unique: Yb8XU3cWN8iu3rJIFY83hg-1
Received: by mail-wr1-f72.google.com with SMTP id w6so1505834wrk.1
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 00:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3fejYZCGdqtP2PcGYj2CLQRph7/f+1FTFxzQ7+HwqdY=;
 b=e/5q5PRa4mxvPQeK7++8ZIUxGfSZNMUQcBg2AkjApmmfE7FpuDAOHR1bGdoqDCtpON
 KJLBGaBFyaX2DAwNPSQzgeVZoY63n0HGEjeGZpXju+nsyccPq+mQA+nEMD0Scn/zwZgw
 7r5aHmQFOWrk1AeHiMNQwU/g5iZ+X7GwaJ0Thqtq3m88pzKFD40o998UmNM0v3DgvGOe
 cdt0T4cCzjnawxEWQCULlqHVyjjYpcAhxtUWtx0ED8UsqnmzMtB4nSMTvosBm4+tVG0b
 RIZjH0sJu5Pd+lPF+rYXkXL1VxL6huswkiOn2oQgxFRIPhMaujGCDR/LxDH5FbUqeTvR
 LBig==
X-Gm-Message-State: AOAM530ZKbo+nFqrdzd+1AIGJdd6mNZ1TXhu3KFBAXOJv+ISj5oru631
 SPQAECWbOGuQBglTKy0rUNIDk+V6+6IX2dII+LBYeJLyEqIBpBG8V2UjSW9kAGY27bPgUv9QPyE
 IUrh5dRmGhUvs2Pw=
X-Received: by 2002:a5d:4a50:: with SMTP id v16mr1253253wrs.106.1604739574647; 
 Sat, 07 Nov 2020 00:59:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzuR5VshvhFhngXsyBP9eXh2ASexJxv6Nr09Lo5B67i/F0+gJW8AVyexzmy3RN+vbmETl7iuw==
X-Received: by 2002:a5d:4a50:: with SMTP id v16mr1253236wrs.106.1604739574434; 
 Sat, 07 Nov 2020 00:59:34 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id k18sm5799347wrx.96.2020.11.07.00.59.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Nov 2020 00:59:33 -0800 (PST)
Subject: Re: [PATCH-for-5.2 v2] hw/core/qdev-properties-system: Rewrite
 set_pci_host_devaddr using GLib
To: qemu-devel@nongnu.org
References: <20201013102252.3562860-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <60f5af9c-4153-7702-cd99-b317a6de89c0@redhat.com>
Date: Sat, 7 Nov 2020 09:59:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201013102252.3562860-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/07 03:59:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Klaus Herman <kherman@inbox.lv>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping for 5.2 as this is a bugfix.

On 10/13/20 12:22 PM, Philippe Mathieu-Daudé wrote:
> set_pci_host_devaddr() is hard to follow, thus bug-prone.
> We indeed introduced a bug in commit bccb20c49df, as the
> same line might be used to parse a bus (up to 0xff) or a
> slot (up to 0x1f). Instead of making things worst, rewrite
> using g_strsplit().
> 
> Fixes: bccb20c49df ("Use qemu_strtoul() in set_pci_host_devaddr()")
> Reported-by: Klaus Herman <kherman@inbox.lv>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v2: Free g_strsplit() with g_auto(GStrv) (Daniel)
> ---
>  hw/core/qdev-properties-system.c | 61 ++++++++++++++------------------
>  1 file changed, 27 insertions(+), 34 deletions(-)
> 
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 49bdd125814..36d4fd8b22a 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -878,11 +878,11 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
>      DeviceState *dev = DEVICE(obj);
>      Property *prop = opaque;
>      PCIHostDeviceAddress *addr = qdev_get_prop_ptr(dev, prop);
> -    char *str, *p;
> -    const char *e;
> +    g_autofree char *str = NULL;
> +    g_auto(GStrv) col_s0 = NULL;
> +    g_auto(GStrv) dot_s = NULL;
> +    char **col_s;
>      unsigned long val;
> -    unsigned long dom = 0, bus = 0;
> -    unsigned int slot = 0, func = 0;
>  
>      if (dev->realized) {
>          qdev_prop_set_after_realize(dev, name, errp);
> @@ -893,57 +893,50 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
>          return;
>      }
>  
> -    p = str;
> -    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0xffff || e == p) {
> +    col_s = col_s0 = g_strsplit(str, ":", 3);
> +    if (!col_s || !col_s[0] || !col_s[1]) {
>          goto inval;
>      }
> -    if (*e != ':') {
> -        goto inval;
> -    }
> -    bus = val;
>  
> -    p = (char *)e + 1;
> -    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e == p) {
> -        goto inval;
> -    }
> -    if (*e == ':') {
> -        dom = bus;
> -        bus = val;
> -        p = (char *)e + 1;
> -        if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e == p) {
> +    /* domain */
> +    if (col_s[2]) {
> +        if (qemu_strtoul(col_s[0], NULL, 16, &val) < 0 || val > 0xffff) {
>              goto inval;
>          }
> +        addr->domain = val;
> +        col_s++;
> +    } else {
> +        addr->domain = 0;
>      }
> -    slot = val;
>  
> -    if (*e != '.') {
> +    /* bus */
> +    if (qemu_strtoul(col_s[0], NULL, 16, &val) < 0 || val > 0xff) {
>          goto inval;
>      }
> -    p = (char *)e + 1;
> -    if (qemu_strtoul(p, &e, 10, &val) < 0 || val > 7 || e == p) {
> -        goto inval;
> -    }
> -    func = val;
> +    addr->bus = val;
>  
> -    if (bus > 0xff) {
> +    /* <slot>.<func> */
> +    dot_s = g_strsplit(col_s[1], ".", 2);
> +    if (!dot_s || !dot_s[0] || !dot_s[1]) {
>          goto inval;
>      }
>  
> -    if (*e) {
> +    /* slot */
> +    if (qemu_strtoul(dot_s[0], NULL, 16, &val) < 0 || val > 0x1f) {
>          goto inval;
>      }
> +    addr->slot = val;
>  
> -    addr->domain = dom;
> -    addr->bus = bus;
> -    addr->slot = slot;
> -    addr->function = func;
> +    /* func */
> +    if (qemu_strtoul(dot_s[1], NULL, 10, &val) < 0 || val > 7) {
> +        goto inval;
> +    }
> +    addr->function = val;
>  
> -    g_free(str);
>      return;
>  
>  inval:
>      error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
> -    g_free(str);
>  }
>  
>  const PropertyInfo qdev_prop_pci_host_devaddr = {
> 


