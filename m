Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421D8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4DCA2080A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ee+IW49m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DCA2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSHF5-0006w3-Ca
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 06:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kSHDf-0006Ty-Lf
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kSHDd-0000Eb-PU
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602583665;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/IjdouMtbj9AyKFl1fX+EKkb1BAxPh+Rbp8KRc+Q+k=;
 b=Ee+IW49msYrIPUC9UAPAcQ0h1/41pCJZweXUDPL+NvKOa1oTriPWkrniR6GOHD/9DNCmKJ
 EIqRXCsuiuijAYfjHR8yqxrKmjHQrhlHCfFyf1LSF/yeL/69180n8NqkfmcEDe3qkztPmP
 EjhO27nNzV2KB/6Qh1WcXa5JJktcohA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-O3H9xJMvOHe6Xgzmac_rTw-1; Tue, 13 Oct 2020 06:07:43 -0400
X-MC-Unique: O3H9xJMvOHe6Xgzmac_rTw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4529E879511;
 Tue, 13 Oct 2020 10:07:42 +0000 (UTC)
Received: from redhat.com (ovpn-114-78.ams2.redhat.com [10.36.114.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE9B619C71;
 Tue, 13 Oct 2020 10:07:40 +0000 (UTC)
Date: Tue, 13 Oct 2020 11:07:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] hw/core/qdev-properties-system: Rewrite
 set_pci_host_devaddr using GLib
Message-ID: <20201013100737.GH70612@redhat.com>
References: <20201013100315.3554421-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201013100315.3554421-1-philmd@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Klaus Herman <kherman@inbox.lv>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 12:03:15PM +0200, Philippe Mathieu-Daudé wrote:
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
>  hw/core/qdev-properties-system.c | 61 ++++++++++++++------------------
>  1 file changed, 27 insertions(+), 34 deletions(-)
> 
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 49bdd125814..e6e081efd58 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -878,11 +878,11 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
>      DeviceState *dev = DEVICE(obj);
>      Property *prop = opaque;
>      PCIHostDeviceAddress *addr = qdev_get_prop_ptr(dev, prop);
> -    char *str, *p;
> -    const char *e;
> +    g_autofree char *str = NULL;
> +    g_autofree char **col_s0 = NULL;
> +    g_autofree char **dot_s = NULL;

These free the array, but not the array elements.

You need to use

   g_auto(GStrv) col_s0 = NULL

GStrv is a typedef for char **, that exists solely so that there is
a typename against which g_auto can be used.

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
> -- 
> 2.26.2
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


