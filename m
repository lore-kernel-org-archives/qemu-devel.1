Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6446C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:35:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E58206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5yKzHzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E58206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWwX-0003IM-K7
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYWW0-0007PV-Cg
 for qemu-devel@nongnu.org; Tue, 12 May 2020 11:08:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58072
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYWVy-0004VL-9F
 for qemu-devel@nongnu.org; Tue, 12 May 2020 11:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589296092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vNHC52nYCih4FTkBSaQsPKMpbSE5D5EXaaoMW35VIJw=;
 b=W5yKzHzbGcVXwYEU4Dw3gZVBWJUtv9s4e8F5w4bg9gQ21JJz4yCPEuRspdzSu4FlQs5ugq
 DQX99xEEitNSstkRwgVEyZsX65+ZePK/FJTXbCMhCue3w9kLhdJoSnCtFayFCjRi9RkaKs
 762tIRpt9VZfHjpG8IM8lN/8ufb+7pU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-iS__Ame4P-KdZsBwGb8p1g-1; Tue, 12 May 2020 11:08:08 -0400
X-MC-Unique: iS__Ame4P-KdZsBwGb8p1g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3D021841920;
 Tue, 12 May 2020 15:08:06 +0000 (UTC)
Received: from localhost (ovpn-112-75.ams2.redhat.com [10.36.112.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B37725D782;
 Tue, 12 May 2020 15:08:00 +0000 (UTC)
Date: Tue, 12 May 2020 16:07:59 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH RESEND v6 22/36] multi-process: Synchronize remote memory
Message-ID: <20200512150759.GL300009@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <63a7f84be8c1c86d1bdea5f538239d0d9c3cdb06.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <63a7f84be8c1c86d1bdea5f538239d0d9c3cdb06.1587614626.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lR6P3/j+HGelbRkf"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--lR6P3/j+HGelbRkf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 09:13:57PM -0700, elena.ufimtseva@oracle.com wrote:
> diff --git a/hw/proxy/memory-sync.c b/hw/proxy/memory-sync.c
> new file mode 100644
> index 0000000000..b3f57747f3
> --- /dev/null
> +++ b/hw/proxy/memory-sync.c
> @@ -0,0 +1,217 @@
> +/*
> + * Copyright =A9 2018, 2020 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include <sys/types.h>
> +#include <stdio.h>
> +#include <string.h>

These headers should already be included by "qemu/osdep.h".

> +static void proxy_ml_region_addnop(MemoryListener *listener,
> +                                   MemoryRegionSection *section)
> +{
> +    RemoteMemSync *sync =3D container_of(listener, RemoteMemSync, listen=
er);
> +    bool need_add =3D true;
> +    uint64_t mrs_size, mrs_gpa, mrs_page;
> +    uintptr_t mrs_host;
> +    RAMBlock *mrs_rb;
> +    MemoryRegionSection *prev_sec;
> +
> +    if (!(memory_region_is_ram(section->mr) &&
> +          !memory_region_is_rom(section->mr))) {
> +        return;
> +    }
> +
> +    mrs_rb =3D section->mr->ram_block;
> +    mrs_page =3D (uint64_t)qemu_ram_pagesize(mrs_rb);
> +    mrs_size =3D int128_get64(section->size);
> +    mrs_gpa =3D section->offset_within_address_space;
> +    mrs_host =3D (uintptr_t)memory_region_get_ram_ptr(section->mr) +
> +               section->offset_within_region;

These variables are only used in the if (sync->n_mr_sections) case. This
function could be split into a something like this:

  static void proxy_ml_region_addnop(MemoryListener *listener,
                                     MemoryRegionSection *section)
      RemoteMemSync *sync =3D container_of(listener, RemoteMemSync, listene=
r);

      if (!(memory_region_is_ram(section->mr) &&
            !memory_region_is_rom(section->mr))) {
          return;
      }

      if (try_merge(sync, section)) {
          return;
      }

      ...add new section...
  }

And the try_merge() helper function has the rest of the code:

  /* Returns true if the section was merged */
  static bool try_merge(RemoteMemSync *sync, MemoryRegionSection *section)
  {
      if (sync->n_mr_sections =3D=3D 0) {
          return false;
      }

      ...most of the code...
  }

> +
> +    if (get_fd_from_hostaddr(mrs_host, NULL) <=3D 0) {

0 is a valid fd number, the comparison should probably be < 0?

> +        return;
> +    }
> +
> +    mrs_host =3D mrs_host & ~(mrs_page - 1);
> +    mrs_gpa =3D mrs_gpa & ~(mrs_page - 1);
> +    mrs_size =3D ROUND_UP(mrs_size, mrs_page);

Why is it necessary to align to the RAM block's page size?

Can mrs_host and mrs_size be misaligned to the RAM block's page size?

Why round the *guest* physical address down using the *host* page size?

> +
> +    if (sync->n_mr_sections) {
> +        prev_sec =3D sync->mr_sections + (sync->n_mr_sections - 1);
> +        uint64_t prev_gpa_start =3D prev_sec->offset_within_address_spac=
e;
> +        uint64_t prev_size =3D int128_get64(prev_sec->size);
> +        uint64_t prev_gpa_end   =3D range_get_last(prev_gpa_start, prev_=
size);
> +        uint64_t prev_host_start =3D
> +            (uintptr_t)memory_region_get_ram_ptr(prev_sec->mr) +
> +            prev_sec->offset_within_region;
> +        uint64_t prev_host_end =3D range_get_last(prev_host_start, prev_=
size);

Is it okay not to do the page alignment stuff for the previous
MemoryRegionSection?

> +void deconfigure_memory_sync(RemoteMemSync *sync)
> +{
> +    memory_listener_unregister(&sync->listener);
> +}

This function is unused? It must be tied into the mpqemu_link lifecycle.
It must be possible to hot plug/unplug proxy PCI devices without memory
leaks or use-after-frees.

> diff --git a/include/hw/proxy/memory-sync.h b/include/hw/proxy/memory-syn=
c.h
> new file mode 100644
> index 0000000000..d8329c9b52
> --- /dev/null
> +++ b/include/hw/proxy/memory-sync.h
> @@ -0,0 +1,37 @@
> +/*
> + * Copyright =A9 2018, 2020 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef MEMORY_SYNC_H
> +#define MEMORY_SYNC_H
> +
> +#include <sys/types.h>
> +
> +#include "qemu/osdep.h"
> +#include "qom/object.h"
> +#include "exec/memory.h"
> +#include "io/mpqemu-link.h"
> +
> +#define TYPE_MEMORY_LISTENER "memory-listener"

This name is too generic. There is already a C struct called
MemoryListener. Please call this class "remote-memory-sync".

I'm not sure if a QOM object is needed here. Can this just be a plain C
struct? If you're not using QOM object-orientated features then there is
no need to define a QOM object.

> @@ -39,8 +40,13 @@ typedef struct ProxyMemoryRegion {
>  struct PCIProxyDev {
>      PCIDevice parent_dev;
> =20
> +    int n_mr_sections;
> +    MemoryRegionSection *mr_sections;

Is it necessary to duplicate these fields here since a RemoteMemSync
field is also being added and it contains these same fields?

--lR6P3/j+HGelbRkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl66u88ACgkQnKSrs4Gr
c8gYrwgAwzO8Secg9+YCzGbKCOq3UwE9PZmja9ta7ZgHUF9OwOkq2CxRpvSjpHRN
2in8/0q8dXIPg6lhN7jI7FDmKRu06rb/7y12eVvJcPHjIZUWfhu9QjeKdHlN9YKQ
wI4aM/iZdGNP+dJZk05VZNGupv13BvwRFUwAQm28yviTAA65e7pgwvxp2kOioZIy
a3gTUU8oF0ioE3a4uaxUvJZ2aqh3Culw7vCsBdUBCGNT/Nt6exlQZYexlxPKhwiQ
XTqLfZ8WyyOalqTKcAAnEo3mL0rxnP9iir9dgy/zAnH4QFgeOulci6YgSOafSMVX
kjZ2Wohf8ekqGUDgxBUe6io4UGMPyw==
=JRnl
-----END PGP SIGNATURE-----

--lR6P3/j+HGelbRkf--


