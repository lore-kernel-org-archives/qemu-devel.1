Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC23C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A3221527
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyCpxWoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A3221527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPX6D-0006yL-CI
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 16:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kPWkv-0002mm-SJ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 16:06:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40593)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kPWkt-0000L2-Il
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 16:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601928400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTPbRsoAdIdaieEFBEjZBBCyhx5pQwTJSbQV3jAJ6SU=;
 b=UyCpxWoP0es+zgGXwRYhbZIK+NaZrzBJ6hphcukRp5J3z6MPr4sCr0WC8OjeqiGFF4EpNX
 w/ma4CCfTYNjnZnXZWk2gleCn4L/jevjQO8Hciq2vgrQt9NVYOdCraWC/m/sl6yOF5wdRt
 RWSMXXnq+8ww8/z+MKlcaDjux4pxnDc=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-FvJboAegOGyCx8Ji-aWsSA-1; Mon, 05 Oct 2020 16:06:38 -0400
X-MC-Unique: FvJboAegOGyCx8Ji-aWsSA-1
Received: by mail-il1-f199.google.com with SMTP id 9so7700391ile.22
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 13:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WTPbRsoAdIdaieEFBEjZBBCyhx5pQwTJSbQV3jAJ6SU=;
 b=lx0czp+TnsKmbLO3IxIRp5ks3+ErAbNOUvA1et3t9cOwLjtQSnYDpicwYJ+bUXnten
 tGWURvmb3RNGHWItmJhGKegiPfaXEaIH/NBhdlnucS73FSbOrXlFDitNi/7OUBPf2nBI
 tKcWgn/lwxfPZAIOTJZ1BR+pnP2RYJPatevP/l0betTBf5GHf6rL3WFC/d9WGgv8SAWi
 M1zdk3XCrRlWbt2JjZk4Yq75zHc06lnpn3NUtyytSicY57hZkImEswZCH4SGIvN3C+Ry
 y01+SjJ4xhDqAAw00Ew8rpohKFZeHLYlrFumr1NHF6ji2TvRUBjAe1Cn+d7vzkIu2BgM
 tzcw==
X-Gm-Message-State: AOAM533yn01M9AyqpJH/DmfQvkWDcq5oGPWFUw/ErvAVIFGmZT7cVRgw
 j+FO82p1OJplwPsAGCYvCQoSIF+1/kXbPqv2+nu9iJwE3+sBKv+GtjGjycbazwBUaMC5kgjgmWB
 JXKCkS1b7xilxFWaKcF5tWbqWb+zXDBs=
X-Received: by 2002:a05:6638:f03:: with SMTP id
 h3mr1475952jas.36.1601928397926; 
 Mon, 05 Oct 2020 13:06:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHeq++59ug/FUJZEuILeI66AoE0E9EjsPWMsMSyjda7KgIWHEu8lzgCZAeVCL2ael7rB2747RXED0HzC5gRSI=
X-Received: by 2002:a05:6638:f03:: with SMTP id
 h3mr1475938jas.36.1601928397723; 
 Mon, 05 Oct 2020 13:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHOaf96qxm6_qigD+DuoJ5GpS9rOqXe4Gv=2UnujiiwcfN0HHQ@mail.gmail.com>
In-Reply-To: <CAHOaf96qxm6_qigD+DuoJ5GpS9rOqXe4Gv=2UnujiiwcfN0HHQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 6 Oct 2020 00:06:26 +0400
Message-ID: <CAMxuvazRhrB8baHp3p=NmzCX5hQBDF6mYDDaQ5Ow1TZu96T2Uw@mail.gmail.com>
Subject: Re: [PATCH] qom: fix objects with improper parent type
To: Sergey Nizovtsev <snizovtsev@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial <qemu-trivial@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 30, 2020 at 3:47 AM Sergey Nizovtsev <snizovtsev@gmail.com> wro=
te:
>
> Some objects accidentally inherit ObjectClass instead of Object.
> They compile silently but may crash after downcasting.
>
> In this patch, we introduce a coccinelle script to find broken
> declarations and fix them manually with proper base type.
>
> Signed-off-by: Sergey Nizovtsev <snizovtsev@gmail.com>

thanks!!
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

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
> +type parent_t =3D~ ".*Class$";
> +@@
> +struct obj_t {
> +    parent_t fld;
> +    ...
> +};
> +
> +@script:python filter depends on match@
> +obj_t << match.obj_t;
> +@@
> +is_class_obj =3D obj_t.endswith('Class')
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
>      QemuUUID guid;                /* The 128-bit GUID seen by the guest =
*/
>      uint8_t vmgenid_addr_le[8];   /* Address of the GUID (little-endian)=
 */
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
>


