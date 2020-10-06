Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AF5C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 05:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5332078A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 05:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcYnKnS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5332078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPfyF-0008Py-CN
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 01:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kPfx9-0007qA-Nk
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 01:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kPfx6-0006kw-JC
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 01:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601963755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UrZygpvh9pmqOkW8TdeRxz0K0eh5T3/89hZCaKcyY/I=;
 b=ZcYnKnS8SDAl0GkGlINNMF8brj7IXdB/WVcZIvegjweD9MzBqH9icjRt3IUkcWeIfTsvW+
 c/a5Tpaulwdt1nhcPvX8W1XxmRkA7BL5oocHucmvCb8/rfY4wFi3HFyJHkdQZxGyB3ycD6
 AjgAkf843thQiJEUQ/daVVBfcS7uWVs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-FDdbKRevNxafX7kgDbMx8Q-1; Tue, 06 Oct 2020 01:55:53 -0400
X-MC-Unique: FDdbKRevNxafX7kgDbMx8Q-1
Received: by mail-wr1-f72.google.com with SMTP id l20so1695263wrc.20
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 22:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UrZygpvh9pmqOkW8TdeRxz0K0eh5T3/89hZCaKcyY/I=;
 b=cvIGGkPjNBb6GhmizPHKYcobVe132vCXKMx/ukdtUzs1/YEpkUJbkspBjTrnNDfYHr
 e7w9pYxKn6rop4PGjDqvJOIqa0tP4bjmWeMxsxoJYVhO6Gq9HWKUpMOhfI8xPzIZRsva
 vkIBMWQtcoqvz2ECWx3z1H2Q6GK4cuqhrz5YB06Xj/LqgL60YPoHtmjUCuoLqySfBub8
 wwFAs0TJ9M/m9E6WAtArl33x7FdILEcKnsxagHJ012zTOhiyeRLuooV4B1qf8cun3nrT
 pbFFXCmCe3pT+HPg1XEu+msezHV8qUc0AHu5XjsCyGea8lyDbDqiI4vUDi0SrY1EmJOe
 iTzg==
X-Gm-Message-State: AOAM53302eZ3dHMKFfLqYChfwR4zPO3eXCXi+oNp0owg1BLfiftm0s8n
 szv1GKRzf5eYvrCGxhNJXuU785QC9EMRqsY1v9rCokICofL3IpVWE3JOwEf3PVsrf8/H4Q6qtV0
 hWGOpijdBQthpdVc=
X-Received: by 2002:a1c:b409:: with SMTP id d9mr2990664wmf.106.1601963752292; 
 Mon, 05 Oct 2020 22:55:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyK2vxD+CstKvWFKlAjmVbDkxmqD44/PqMkmg1/gQj1fUTFDQFkP6mcI/QpU8A0/fg269rHAg==
X-Received: by 2002:a1c:b409:: with SMTP id d9mr2990625wmf.106.1601963751857; 
 Mon, 05 Oct 2020 22:55:51 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id q20sm2192164wmc.39.2020.10.05.22.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 22:55:50 -0700 (PDT)
Date: Tue, 6 Oct 2020 01:55:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergey Nizovtsev <snizovtsev@gmail.com>
Subject: Re: [PATCH] qom: fix objects with improper parent type
Message-ID: <20201006015528-mutt-send-email-mst@kernel.org>
References: <CAHOaf96qxm6_qigD+DuoJ5GpS9rOqXe4Gv=2UnujiiwcfN0HHQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHOaf96qxm6_qigD+DuoJ5GpS9rOqXe4Gv=2UnujiiwcfN0HHQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Ben Warren <ben@skyportsystems.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 04:47:14PM -0700, Sergey Nizovtsev wrote:
> Some objects accidentally inherit ObjectClass instead of Object.
> They compile silently but may crash after downcasting.
> 
> In this patch, we introduce a coccinelle script to find broken
> declarations and fix them manually with proper base type.
> 
> Signed-off-by: Sergey Nizovtsev <snizovtsev@gmail.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

which tree should this go in through?

> ---
>  scripts/coccinelle/qobject-parent-type.cocci | 26 ++++++++++++++++++++
>  include/hw/acpi/vmgenid.h                    |  2 +-
>  include/hw/misc/vmcoreinfo.h                 |  2 +-
>  include/net/can_host.h                       |  2 +-
>  MAINTAINERS                                  |  1 +
>  5 files changed, 30 insertions(+), 3 deletions(-)
>  create mode 100644 scripts/coccinelle/qobject-parent-type.cocci
> 
> diff --git a/scripts/coccinelle/qobject-parent-type.cocci
> b/scripts/coccinelle/qobject-parent-type.cocci
> new file mode 100644
> index 0000000000..9afb3edd97
> --- /dev/null
> +++ b/scripts/coccinelle/qobject-parent-type.cocci
> @@ -0,0 +1,26 @@
> +// Highlight object declarations that don't look like object class but
> +// accidentally inherit from it.
> +
> +@match@
> +identifier obj_t, fld;
> +type parent_t =~ ".*Class$";
> +@@
> +struct obj_t {
> +    parent_t fld;
> +    ...
> +};
> +
> +@script:python filter depends on match@
> +obj_t << match.obj_t;
> +@@
> +is_class_obj = obj_t.endswith('Class')
> +cocci.include_match(not is_class_obj)
> +
> +@replacement depends on filter@
> +identifier match.obj_t, match.fld;
> +type match.parent_t;
> +@@
> +struct obj_t {
> +*   parent_t fld;
> +    ...
> +};
> diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
> index d50fbacb8e..cb4ad37fc5 100644
> --- a/include/hw/acpi/vmgenid.h
> +++ b/include/hw/acpi/vmgenid.h
> @@ -19,7 +19,7 @@
>  OBJECT_DECLARE_SIMPLE_TYPE(VmGenIdState, VMGENID)
> 
>  struct VmGenIdState {
> -    DeviceClass parent_obj;
> +    DeviceState parent_obj;
>      QemuUUID guid;                /* The 128-bit GUID seen by the guest */
>      uint8_t vmgenid_addr_le[8];   /* Address of the GUID (little-endian) */
>  };
> diff --git a/include/hw/misc/vmcoreinfo.h b/include/hw/misc/vmcoreinfo.h
> index ebada6617a..0b7b55d400 100644
> --- a/include/hw/misc/vmcoreinfo.h
> +++ b/include/hw/misc/vmcoreinfo.h
> @@ -24,7 +24,7 @@ DECLARE_INSTANCE_CHECKER(VMCoreInfoState, VMCOREINFO,
>  typedef struct fw_cfg_vmcoreinfo FWCfgVMCoreInfo;
> 
>  struct VMCoreInfoState {
> -    DeviceClass parent_obj;
> +    DeviceState parent_obj;
> 
>      bool has_vmcoreinfo;
>      FWCfgVMCoreInfo vmcoreinfo;
> diff --git a/include/net/can_host.h b/include/net/can_host.h
> index 4e3ce3f954..caab71bdda 100644
> --- a/include/net/can_host.h
> +++ b/include/net/can_host.h
> @@ -35,7 +35,7 @@
>  OBJECT_DECLARE_TYPE(CanHostState, CanHostClass, CAN_HOST)
> 
>  struct CanHostState {
> -    ObjectClass oc;
> +    Object oc;
> 
>      CanBusState *bus;
>      CanBusClientState bus_client;
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5eed1e692b..2160b8196a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2402,6 +2402,7 @@ F: qobject/
>  F: include/qapi/qmp/
>  X: include/qapi/qmp/dispatch.h
>  F: scripts/coccinelle/qobject.cocci
> +F: scripts/coccinelle/qobject-parent-type.cocci
>  F: tests/check-qdict.c
>  F: tests/check-qjson.c
>  F: tests/check-qlist.c
> -- 
> 2.28.0


