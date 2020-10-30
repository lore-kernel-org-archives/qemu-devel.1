Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23C1C55179
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 08:59:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3899A20709
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 08:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKD2+GzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3899A20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYQGC-0006l7-1z
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 04:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYQDP-00044q-CX
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 04:56:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYQDL-0001n0-PB
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 04:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604048210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dET9UuwScDJNxpB95/AZCa5VsEJpmgQlCAPKT4rHLOU=;
 b=ZKD2+GzXjQaEtG5pantIKDMWcEBcwjmrfqOIkMVM5vtnyjIKgBn2Pn7Kbcld2mBFPp/ko6
 ar9A04yNG4uTRUiUMGQYfLyEoBbiPVXGtvAcyPNZ3Rtn/5a9BC5ndEoQ+iPaCEY/KwsBK4
 faRpsemnJ/my1Fw8o+bslu91vxaS334=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-nV-yY5pxMMCPnF13o1y1_A-1; Fri, 30 Oct 2020 04:56:48 -0400
X-MC-Unique: nV-yY5pxMMCPnF13o1y1_A-1
Received: by mail-wm1-f69.google.com with SMTP id s12so1498051wmj.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 01:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dET9UuwScDJNxpB95/AZCa5VsEJpmgQlCAPKT4rHLOU=;
 b=RS6v5qexzgfCyeXXxuKgDZO+VqhjgsBFXozZxBB3HCPUb4s/KDLdMZYJRzInqO4Hp4
 0Dz0AB2t+hM+CNxb+Q/ACGesU0UZC9TkUs4NyKCX2mfMCvUV/dmHjqrrcSjRdvjBDytx
 5dfYw68CWHV6pMPoqidbRyamoZmTHi0DAf5PQJK5eGhiwR8SeElOMKUpzap3OKIh3cXe
 mrlfo3net2uxmWgGBlJ/UUEJLO83WsNElrzEUBq+GCHdruBM2xPn4zQZ61ytWh1A8xu0
 c0iembT0xhgHhq32D4BsOtZJTzAQkNv9p/fw3vCcDQC1h5pw05srZs5nZCqq5EGbYCSB
 3ncQ==
X-Gm-Message-State: AOAM531NF5Eb5RbH1lZx+T3/kxGvRC1K851lhAX4yGnpe4Vcm6X7GWc+
 3Z2kU3x//HiI36LkbecuzuguSTwdcI/vw0WTQtajYsHW9xVUak3sLEDW5GVyyVcTryus/lcM4uz
 Unu/uDm6OklavRN4=
X-Received: by 2002:adf:f810:: with SMTP id s16mr1636298wrp.424.1604048206888; 
 Fri, 30 Oct 2020 01:56:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxAppKfJElnXvO6gFT0OH5F9xiUU7hcTNyCaX/a5EWcqhJUpzdycSC1T3zVIkCh+x6Qq8I7A==
X-Received: by 2002:adf:f810:: with SMTP id s16mr1636279wrp.424.1604048206693; 
 Fri, 30 Oct 2020 01:56:46 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id c8sm9044296wrv.26.2020.10.30.01.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 01:56:46 -0700 (PDT)
Date: Fri, 30 Oct 2020 04:56:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 05/24] vhost-user: Register "chardev" as class property
Message-ID: <20201030045638-mutt-send-email-mst@kernel.org>
References: <20200921221045.699690-1-ehabkost@redhat.com>
 <20200921221045.699690-6-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200921221045.699690-6-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 21, 2020 at 06:10:26PM -0400, Eduardo Habkost wrote:
> Class properties make QOM introspection simpler and easier, as
> they don't require an object to be instantiated.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  backends/vhost-user.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/backends/vhost-user.c b/backends/vhost-user.c
> index 9e6e1985465..858fdeae26c 100644
> --- a/backends/vhost-user.c
> +++ b/backends/vhost-user.c
> @@ -175,9 +175,9 @@ static char *get_chardev(Object *obj, Error **errp)
>      return NULL;
>  }
>  
> -static void vhost_user_backend_init(Object *obj)
> +static void vhost_user_backend_class_init(ObjectClass *oc, void *data)
>  {
> -    object_property_add_str(obj, "chardev", get_chardev, set_chardev);
> +    object_class_property_add_str(oc, "chardev", get_chardev, set_chardev);
>  }
>  
>  static void vhost_user_backend_finalize(Object *obj)
> @@ -195,7 +195,7 @@ static const TypeInfo vhost_user_backend_info = {
>      .name = TYPE_VHOST_USER_BACKEND,
>      .parent = TYPE_OBJECT,
>      .instance_size = sizeof(VhostUserBackend),
> -    .instance_init = vhost_user_backend_init,
> +    .class_init = vhost_user_backend_class_init,
>      .instance_finalize = vhost_user_backend_finalize,
>      .class_size = sizeof(VhostUserBackendClass),
>  };
> -- 
> 2.26.2


