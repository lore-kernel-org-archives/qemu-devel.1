Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39750C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 15:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D402075A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 15:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EokNCV1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D402075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRztr-00009A-4z
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 11:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jRzsy-0007w8-IF
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jRzsw-0005le-A6
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:05:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48706
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jRzsv-0005kC-M1
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587740696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O5pRK4htQyOtOsVl4dl3CN0QYAl6dttW6pkNYGeQ9xk=;
 b=EokNCV1x+fO/CwkxW4Vxocm7zuxmxggIjFcjBeqM0ZXGn0bUL54G7B7G7OsM3mPGMFd3ZT
 bqzrWbezKXZos5+ztk0hUKGuGGgTkLtIQgPHI6GtHVKQ+qAbKpOm7xdCNSW3HeOwwXDmF6
 8ESsdow1C2E/0Oc4HYYVgfN3iRdBnzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-jcwo1RfwMvG8iwX8fhH8tg-1; Fri, 24 Apr 2020 11:04:51 -0400
X-MC-Unique: jcwo1RfwMvG8iwX8fhH8tg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 052FA460;
 Fri, 24 Apr 2020 15:04:23 +0000 (UTC)
Received: from localhost (ovpn-114-136.ams2.redhat.com [10.36.114.136])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AF261001B2C;
 Fri, 24 Apr 2020 15:04:22 +0000 (UTC)
Date: Fri, 24 Apr 2020 16:04:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH RESEND v6 10/36] multi-process: build system for remote
 device process
Message-ID: <20200424150421.GC190507@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <622e5b5a9408c1e0bee41cd75a792ff784fc2874.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <622e5b5a9408c1e0bee41cd75a792ff784fc2874.1587614626.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:07:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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

--dkEUBIird37B8yKS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 09:13:45PM -0700, elena.ufimtseva@oracle.com wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
>=20
> Modify Makefile to support the building of the remote
> device process. Implements main() function of remote
> device process.
>=20
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  MAINTAINERS             |  8 ++++++
>  Makefile                |  2 ++
>  Makefile.objs           | 27 ++++++++++++++++++
>  Makefile.target         | 61 ++++++++++++++++++++++++++++++++++++++++-
>  accel/Makefile.objs     |  2 ++
>  backends/Makefile.objs  |  2 ++
>  block/Makefile.objs     |  2 ++
>  hw/Makefile.objs        |  7 +++++
>  hw/block/Makefile.objs  |  2 ++
>  hw/core/Makefile.objs   | 18 ++++++++++++
>  hw/nvram/Makefile.objs  |  2 ++
>  hw/pci/Makefile.objs    |  4 +++
>  hw/scsi/Makefile.objs   |  2 ++
>  migration/Makefile.objs |  2 ++
>  qom/Makefile.objs       |  3 ++
>  remote/Makefile.objs    |  1 +
>  remote/remote-main.c    | 23 ++++++++++++++++
>  stubs/replay.c          |  4 +++
>  18 files changed, 171 insertions(+), 1 deletion(-)
>  create mode 100644 remote/Makefile.objs
>  create mode 100644 remote/remote-main.c

This approach is okay for now but will result in a lot of Makefile
duplication in the long run.

Each hw .o file should specify its dependencies so that qemu-system-*
and the remote executable can link in the needed files.  The Kconfig
system can also help with this by enabling/disabling features.

Then the Makefiles don't need to duplicate *-obj-y and remote-pci-*.

> diff --git a/Makefile.objs b/Makefile.objs
> index f29c60c59d..f6654633b4 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -21,6 +21,33 @@ block-obj-$(CONFIG_REPLICATION) +=3D replication.o
> =20
>  block-obj-m =3D block/
> =20
> +#########################################################
> +# remote-pci-obj-y is common code used by remote devices
> +
> +remote-pci-obj-$(CONFIG_MPQEMU) +=3D hw/
> +remote-pci-obj-$(CONFIG_MPQEMU) +=3D qom/
> +remote-pci-obj-$(CONFIG_MPQEMU) +=3D backends/
> +remote-pci-obj-$(CONFIG_MPQEMU) +=3D block/
> +remote-pci-obj-$(CONFIG_MPQEMU) +=3D migration/

In the future migration can be split into the QEMU and remote parts.
The remote executable doesn't need all the live migration code.

> +remote-pci-obj-$(CONFIG_MPQEMU) +=3D remote/
> +remote-pci-obj-$(CONFIG_MPQEMU) +=3D accel/

Devices do not execute guest code so they should not need accel/.  kvm
and tcg functions were stubbed out earlier in this patch series, so I'm
surprised to see thing being built into the remote executable.

> @@ -121,6 +131,20 @@ LIBS :=3D $(libs_cpu) $(LIBS)
> =20
>  obj-$(CONFIG_PLUGIN) +=3D plugins/
> =20
> +ifeq ($(TARGET_NAME)-$(CONFIG_MPQEMU)-$(CONFIG_USER_ONLY), x86_64-y-)
> +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D accel/stubs/kvm-stub.o
> +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D accel/stubs/tcg-stub.o
> +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D accel/stubs/hax-stub.o
> +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D accel/stubs/whpx-stub.o
> +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/vl-stub.o
> +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/net-stub.o
> +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/monitor.o
> +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/replay.o
> +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/xen-mapcache.o
> +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/audio.o
> +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/monitor.o
> +endif

Stubs don't need to be explicitly included, they should be linked in via
libqemustub.a.

> diff --git a/remote/remote-main.c b/remote/remote-main.c
> new file mode 100644
> index 0000000000..7c0764ad01
> --- /dev/null
> +++ b/remote/remote-main.c
> @@ -0,0 +1,23 @@
> +/*
> + * Remote device initialization
> + *
> + * Copyright =A9 2018, 2020 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +
> +#include <stdio.h>

This is already included by "qemu/osdep.h"

> +
> +#include "qemu/module.h"
> +
> +int main(int argc, char *argv[])
> +{
> +    module_call_init(MODULE_INIT_QOM);
> +
> +    return 0;
> +}
> diff --git a/stubs/replay.c b/stubs/replay.c
> index 2e3feee6a9..9b53c0cb37 100644
> --- a/stubs/replay.c
> +++ b/stubs/replay.c
> @@ -102,3 +102,7 @@ int replay_get_instructions(void)
>  void replay_account_executed_instructions(void)
>  {
>  }
> +
> +void replay_add_blocker(Error *reason)
> +{
> +}

This can be moved to the stubs patch.

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6i//UACgkQnKSrs4Gr
c8i4igf/c000GJph3VsgJIXnHKWBRCFlz+3lpnezHoNj27WYUzHJDubmsd8ZHwyv
xT8NL54ptQnULiUng160ieLc2y08okO/2tlWGTDY71Nil5I4+9D2HLHkfRZLZxOI
sbnw545KqeD+7dDBIKTnIcQFkRFEZQ0x0pkaRQMUxHgbDvHdS81gfItGo5j3YB4r
J+w/vMKWwTDwoJ8vmRMVttVO/i9bxewPgl38DF8t6ptdCPgrMqn2iv8rni0ZG5jk
WECoxuxwsS8l5NCEi9J0jk7A2/1rgGiVAeKfq9zzO7NV9vMxyiEbt4xyX+LUCd9M
5+nfPhrW8Dl4adezCGwHhIblT9MiJA==
=8Vfp
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--


