Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09BFC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF57206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/zOrRJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF57206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYSOX-0002c2-Io
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 06:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYSNn-0001ij-Uv
 for qemu-devel@nongnu.org; Tue, 12 May 2020 06:43:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42179
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYSNm-0001Xp-DW
 for qemu-devel@nongnu.org; Tue, 12 May 2020 06:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589280208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J+aa880KFm2vtzNV3B0csctoqCvRTURKPDP34ckFiDE=;
 b=B/zOrRJydyL2s0NWK/JVTRH9Y+iam8HoDEeVHZ0F/XuR6yzQ7A8htP4l9pgKnRG5yFe7wR
 qKni6fYNH6YXZaSu9Flm95vq6QntPWnRZil5SKSGVmEAnhkLMV1Sl/5tLJUPo+AlNumb3u
 QvKHtuhR3llAZMKzpn1vzn7t5CPPzJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-iIzxV5uFO7yjrpiZOx0Hag-1; Tue, 12 May 2020 06:43:24 -0400
X-MC-Unique: iIzxV5uFO7yjrpiZOx0Hag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 921B2100A8E7;
 Tue, 12 May 2020 10:43:22 +0000 (UTC)
Received: from localhost (ovpn-112-75.ams2.redhat.com [10.36.112.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A8146E6E5;
 Tue, 12 May 2020 10:43:16 +0000 (UTC)
Date: Tue, 12 May 2020 11:43:14 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH RESEND v6 14/36] multi-process: setup a machine object
 for remote device process
Message-ID: <20200512104314.GE300009@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <6b44b86adfae6324f4dd62a24c1d84961627fca1.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <6b44b86adfae6324f4dd62a24c1d84961627fca1.1587614626.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
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

--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 09:13:49PM -0700, elena.ufimtseva@oracle.com wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
>=20
> remote-machine object sets up various subsystems of the remote device
> process. Instantiate PCI host bridge object and initialize RAM, IO &
> PCI memory regions.
>=20
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  MAINTAINERS                   |  2 +
>  Makefile.objs                 |  1 +
>  exec.c                        |  3 +-
>  include/exec/address-spaces.h |  2 +
>  include/remote/machine.h      | 30 +++++++++++++
>  remote/Makefile.objs          |  2 +
>  remote/machine.c              | 84 +++++++++++++++++++++++++++++++++++
>  remote/remote-main.c          |  7 +++

Now that the separate remote emulation program is going away I think it
makes sense to move the PCIe host and machine type into hw/:

  hw/pci-host/remote.c <-- PCIe host
  hw/i386/remote.c     <-- machine type (could be moved again later if
                           other architectures are supported)

> diff --git a/exec.c b/exec.c
> index d0ac9545f4..5b1e414099 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -161,7 +161,6 @@ typedef struct subpage_t {
>  #define PHYS_SECTION_UNASSIGNED 0
> =20
>  static void io_mem_init(void);
> -static void memory_map_init(void);

The memory_map_init() change is unnecessary once a softmmu target is
used since it will be called from cpu_exec_init_all().

> +static void remote_machine_init(Object *obj)
> +{
> +    RemMachineState *s =3D REMOTE_MACHINE(obj);
> +    RemPCIHost *rem_host;
> +    MemoryRegion *system_memory, *system_io, *pci_memory;
> +
> +    Error *error_abort =3D NULL;
> +
> +    object_property_add_child(object_get_root(), "machine", obj, &error_=
abort);
> +    if (error_abort) {

error_abort aborts the program so handling it is not necessary.

> +        error_report_err(error_abort);
> +    }
> +
> +    memory_map_init();
> +
> +    system_memory =3D get_system_memory();
> +    system_io =3D get_system_io();
> +
> +    pci_memory =3D g_new(MemoryRegion, 1);
> +    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
> +
> +    rem_host =3D REMOTE_HOST_DEVICE(qdev_create(NULL, TYPE_REMOTE_HOST_D=
EVICE));
> +
> +    rem_host->mr_pci_mem =3D pci_memory;
> +    rem_host->mr_sys_mem =3D system_memory;
> +    rem_host->mr_sys_io =3D system_io;
> +
> +    s->host =3D rem_host;
> +
> +    object_property_add_child(OBJECT(s), "remote-device", OBJECT(rem_hos=
t),
> +                              &error_abort);
> +    if (error_abort) {

error_abort aborts the program so handling it is not necessary.

> +        error_report_err(error_abort);
> +        return;
> +    }
> +
> +    qemu_mutex_lock_iothread();

This will be executed with the iothread lock held. There is no need to
acquire it.

> +    memory_region_add_subregion_overlap(system_memory, 0x0, pci_memory, =
-1);
> +    qemu_mutex_unlock_iothread();
> +
> +    qdev_init_nofail(DEVICE(rem_host));
> +}

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl66fcIACgkQnKSrs4Gr
c8jiFwf9HRk/FIENRdfjUij/mKYSL+eUA8e0KBr7TOrX+IAeMIaAfHOncw+fQIDx
mfvSs5gr2n8CJvwEIJaHuJSeCX0GJx8Q3w7uLy6U1wJ7/R6O8Gv7nD3u/3Y7bshU
GSRpmkqKD3aM8XE667VUAsNpAdc+TrEeIMrN2K6VtrrinPRV1opwlrDUhj0NLPT1
1Bx/zv86lQM+EayaWf4QnUC+6VTUxuWw4KKtzmm3ABO24N9vaUDkfY0YvdnaIT6u
qjWBUgt1LvfPpP8AwazgRZNzJrH0QA3WOHPtdk+N9tLio1Q5yA2UvfWOpdXfhb8O
oHssl2vL2xxmy3ntwu02WdtMV0qSaw==
=4Xpj
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--


