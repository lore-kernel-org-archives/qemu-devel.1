Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E23C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 047A820658
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsZ9DJXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047A820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJg1K-0000Fn-3O
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 12:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJg0R-00085I-AA
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJg0P-00089f-82
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:14:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47143
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJg0P-000871-26
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585757656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ao7dCKGnlZKFlEK7iPffU2e9tqVZy7nJlMRwqLi4mW4=;
 b=QsZ9DJXrYUjOuEe2OEl/FYlXn1Dwhj74iIsInUV+LdYt+woP23ePNKD7lO6uRSME0i/X0g
 KVzGZjx1SXYikd9hO5+oRcAZIDvNmHFWO9jyR18BdUB+Alwdj5ctwfO7fyzCYiltG1EhZK
 iX0u14WlzT+Oiz/fyMYRUYFrcU0IAS4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-73s3EVfaO52SpY_mGF5Ayw-1; Wed, 01 Apr 2020 12:14:14 -0400
X-MC-Unique: 73s3EVfaO52SpY_mGF5Ayw-1
Received: by mail-ed1-f69.google.com with SMTP id f19so381016edt.5
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 09:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ao7dCKGnlZKFlEK7iPffU2e9tqVZy7nJlMRwqLi4mW4=;
 b=hcNe2p+cm9I38a+7jJf935Zs/LV2VihksXSc+P5c0E9RGnPiS33sqzvMp4iDJXjvMe
 odlUaMW0M6Lr+FwXPnkUWlbXPcdkJZvtEnT1KKD3VcJyxgT6tc8tAZvVkEYXKNCYJApD
 Vrr4hBN1xD7l3w8AHGNGRFBRMobsYtS+KKXzHDCwOQ35oFyYrLSgy64ISyd9kYDwRaMC
 HiQzVsHLdKYGAkc+2YIXdAC95CyVJj3kk9/SdtCQHyBcBQZBk8VKIgJW3beuXztndMl8
 qJaS5VKqtsBBwYblEKVKI3f8VK2P2PDDnqauHIYwo23Uleo60+zkmZOGBCTLl2ripoX6
 zzJA==
X-Gm-Message-State: ANhLgQ22bCkDz1RzoOZLaqAxXc2uofYip+0+rBa6ZE4omMPP3TeVwc5A
 211l/lMFdPw3q+7f0zL2/a07EqmCCk+Scboj5BaGdndejLbVyJ8EPtO7+jeaSuR2YO/liIvXLzO
 S9aJE/U368obcm2k=
X-Received: by 2002:a17:906:e4a:: with SMTP id
 q10mr21678240eji.371.1585757653160; 
 Wed, 01 Apr 2020 09:14:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsjnTYrLetXganFy1+x4jIgAoh3U67ltaGOBxp9JVwwaj8Mw4R++cOP/Du2iwlYwz1vPgCOVQ==
X-Received: by 2002:a17:906:e4a:: with SMTP id
 q10mr21678214eji.371.1585757652855; 
 Wed, 01 Apr 2020 09:14:12 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f5sm634783ejc.70.2020.04.01.09.14.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2020 09:14:12 -0700 (PDT)
Subject: Re: [Qemu-devel] [PULL 06/25] xen: create xenstore areas for
 XenDevice-s
To: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org
References: <20190114135154.16826-1-anthony.perard@citrix.com>
 <20190114135154.16826-7-anthony.perard@citrix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <772fab5a-59ab-050f-9fef-f3b050cfc5cd@redhat.com>
Date: Wed, 1 Apr 2020 18:14:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20190114135154.16826-7-anthony.perard@citrix.com>
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
Cc: xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Anthony, Paul.

Cc'ing Markus too.

On 1/14/19 2:51 PM, Anthony PERARD wrote:
> From: Paul Durrant <paul.durrant@citrix.com>
> 
> This patch adds a new source module, xen-bus-helper.c, which builds on
> basic libxenstore primitives to provide functions to create (setting
> permissions appropriately) and destroy xenstore areas, and functions to
> 'printf' and 'scanf' nodes therein. The main xen-bus code then uses
> these primitives [1] to initialize and destroy the frontend and backend
> areas for a XenDevice during realize and unrealize respectively.
> 
> The 'xen-block' implementation is extended with a 'get_name' method that
> returns the VBD number. This number is required to 'name' the xenstore
> areas.
> 
> NOTE: An exit handler is also added to make sure the xenstore areas are
>        cleaned up if QEMU terminates without devices being unrealized.
> 
> [1] The 'scanf' functions are actually not yet needed, but they will be
>      needed by code delivered in subsequent patches.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> Reviewed-by: Anthony Perard <anthony.perard@citrix.com>
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
>   hw/block/xen-block.c            |   9 +
>   hw/xen/Makefile.objs            |   2 +-
>   hw/xen/trace-events             |  12 +-
>   hw/xen/xen-bus-helper.c         | 150 +++++++++++++++
>   hw/xen/xen-bus.c                | 321 +++++++++++++++++++++++++++++++-
>   include/hw/xen/xen-bus-helper.h |  39 ++++
>   include/hw/xen/xen-bus.h        |  12 ++
>   7 files changed, 540 insertions(+), 5 deletions(-)
>   create mode 100644 hw/xen/xen-bus-helper.c
>   create mode 100644 include/hw/xen/xen-bus-helper.h
> 
[...]
> +static void xen_device_exit(Notifier *n, void *data)
> +{
> +    XenDevice *xendev = container_of(n, XenDevice, exit);
> +
> +    xen_device_unrealize(DEVICE(xendev), &error_abort);
>   }
>   
>   static void xen_device_realize(DeviceState *dev, Error **errp)
>   {
>       XenDevice *xendev = XEN_DEVICE(dev);
>       XenDeviceClass *xendev_class = XEN_DEVICE_GET_CLASS(xendev);
> +    XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
>       const char *type = object_get_typename(OBJECT(xendev));
>       Error *local_err = NULL;
>   
> -    trace_xen_device_realize(type);
> +    if (xendev->frontend_id == DOMID_INVALID) {
> +        xendev->frontend_id = xen_domid;
> +    }
> +
> +    if (xendev->frontend_id >= DOMID_FIRST_RESERVED) {
> +        error_setg(errp, "invalid frontend-id");
> +        goto unrealize;
> +    }
> +
> +    if (!xendev_class->get_name) {
> +        error_setg(errp, "get_name method not implemented");
> +        goto unrealize;
> +    }
> +
> +    xendev->name = xendev_class->get_name(xendev, &local_err);
> +    if (local_err) {
> +        error_propagate_prepend(errp, local_err,
> +                                "failed to get device name: ");
> +        goto unrealize;
> +    }
> +
> +    trace_xen_device_realize(type, xendev->name);
> +
> +    xen_device_backend_create(xendev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        goto unrealize;
> +    }
> +
> +    xen_device_frontend_create(xendev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        goto unrealize;
> +    }
>   
>       if (xendev_class->realize) {
>           xendev_class->realize(xendev, &local_err);
> @@ -72,18 +364,43 @@ static void xen_device_realize(DeviceState *dev, Error **errp)
>           }
>       }
>   
> +    xen_device_backend_printf(xendev, "frontend", "%s",
> +                              xendev->frontend_path);
> +    xen_device_backend_printf(xendev, "frontend-id", "%u",
> +                              xendev->frontend_id);
> +    xen_device_backend_printf(xendev, "online", "%u", 1);
> +    xen_device_backend_printf(xendev, "hotplug-status", "connected");
> +
> +    xen_device_backend_set_state(xendev, XenbusStateInitWait);
> +
> +    xen_device_frontend_printf(xendev, "backend", "%s",
> +                               xendev->backend_path);
> +    xen_device_frontend_printf(xendev, "backend-id", "%u",
> +                               xenbus->backend_id);
> +
> +    xen_device_frontend_set_state(xendev, XenbusStateInitialising);
> +
> +    xendev->exit.notify = xen_device_exit;
> +    qemu_add_exit_notifier(&xendev->exit);
>       return;
>   
>   unrealize:
>       xen_device_unrealize(dev, &error_abort);

It seems if unrealize() fails, the error stored in &local_err is never 
reported. Not sure if this can be improved although.

>   }
>   
> +static Property xen_device_props[] = {
> +    DEFINE_PROP_UINT16("frontend-id", XenDevice, frontend_id,
> +                       DOMID_INVALID),
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
>   static void xen_device_class_init(ObjectClass *class, void *data)
>   {
>       DeviceClass *dev_class = DEVICE_CLASS(class);
>   
>       dev_class->realize = xen_device_realize;
>       dev_class->unrealize = xen_device_unrealize;
> +    dev_class->props = xen_device_props;
>       dev_class->bus_type = TYPE_XEN_BUS;
>   }
>   
[...]


