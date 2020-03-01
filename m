Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B7AC3F2CE
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 12:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B90B214DB
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 12:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LON9Ulte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B90B214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8NTF-0007mN-9F
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 07:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j8NSK-0007KQ-96
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 07:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j8NSI-0005Zq-2S
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 07:12:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52592
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j8NSH-0005ZR-Nj
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 07:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583064740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dmWI/5ZAU5BrqjFe3kbI/UMJC7L2+IoafrA6WsxayeU=;
 b=LON9Ulte9uoBzQmHo//7zLo/1sgHX/zoT2Khh3w8qIifcOY51FlADfmUuTJsmzvD4C82Yu
 ydDZjnkmbvB0Am838e9cgOGlRLrPr63/F1ks8GV2QJ3aQkLr0iIezOA9ghkjsfT1R+xmD1
 ZfUH4i5PGg3LtZlTfvbgqcYWYe9NgJE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-J0JwgQhuOv-Z4DaRLdxV1g-1; Sun, 01 Mar 2020 07:12:19 -0500
X-MC-Unique: J0JwgQhuOv-Z4DaRLdxV1g-1
Received: by mail-qk1-f197.google.com with SMTP id 205so7077950qkg.0
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2020 04:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=JmbknrdA9dn22HHIPzR6ACZiBcNY5ec5iKA8gp1KqVU=;
 b=szCrFne+ZNFW+TAx+FCxd01ksyvJ1JKPID2HYJtyvqU3EPIYnVBLmfRA6GKewpyrCv
 j7cfMAuLEJmKLJlsgbCojqJx/zYU2gT5Sg0YoVkBsy4zb9xjSvj0Rfl+l/6P0HbRxkNY
 gWog3w80I9oOpMbKuvuHMQkfUysfywsMyqnAUpZpsAZJSuw1wRohzXOHTvMKqppYM3j+
 Hifro17Y+EfdudmdoOcY26BwKlXtqcwcKb8ou52n3Sgf/Dc30/NeujC1GiAia8YHmRXP
 NrepXY0ryUXG+e+N0HHlvkZ6BD21zM3huotoeLDX/xITnYvgImd6MU66AwdKVBA/WktI
 /zPw==
X-Gm-Message-State: ANhLgQ2QJXdPBXzD9LINwCJctFHw6XBVizRg1no8oIkCPlG9fsbBAq5S
 S99WYROYapnDFPszxDajvqXWwtkHKPyG/aa/lReAp0EyWYwDnGjR8/dQDp8mYEd2AUm+7LnqrSX
 VnM7zDQEApCO2irk=
X-Received: by 2002:ac8:7296:: with SMTP id v22mr4698498qto.283.1583064738756; 
 Sun, 01 Mar 2020 04:12:18 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvig/+GIxZikRSZ9MAlIyIXMR2gwIDLF11AayyvWrU9jXN0sbPOs4DqiwlADELeSfdCSTNaYw==
X-Received: by 2002:ac8:7296:: with SMTP id v22mr4698490qto.283.1583064738497; 
 Sun, 01 Mar 2020 04:12:18 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
 by smtp.gmail.com with ESMTPSA id 133sm8352915qkh.109.2020.03.01.04.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2020 04:12:17 -0800 (PST)
Date: Sun, 1 Mar 2020 07:12:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 1/2] tests/vhost-user-bridge: move to contrib/
Message-ID: <20200301071119-mutt-send-email-mst@kernel.org>
References: <20200207095412.794912-1-lvivier@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200207095412.794912-1-lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 07, 2020 at 10:54:11AM +0100, Laurent Vivier wrote:
> vhost-user-bridge is not a test. Move it to contrib/ and
> add it to the tools list.
>=20
> It will be built only if tools (--enable-tools) and
> vhost-user (--enable-vhost-user) are enabled (both are set
> by default).
>=20
> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


I had to drop this series from my tree since it cause failures
on OSX. Pls use something like travis CI to test when you repost
a fixed version. Thanks!


> ---
>=20
> Notes:
>     v2: update docs
>=20
>  Makefile                                                      | 3 +++
>  Makefile.objs                                                 | 1 +
>  configure                                                     | 3 +++
>  contrib/vhost-user-bridge/Makefile.objs                       | 1 +
>  tests/vhost-user-bridge.c =3D> contrib/vhost-user-bridge/main.c | 0
>  docs/devel/migration.rst                                      | 2 +-
>  tests/Makefile.include                                        | 1 -
>  7 files changed, 9 insertions(+), 2 deletions(-)
>  create mode 100644 contrib/vhost-user-bridge/Makefile.objs
>  rename tests/vhost-user-bridge.c =3D> contrib/vhost-user-bridge/main.c (=
100%)
>=20
> diff --git a/Makefile b/Makefile
> index 461d40bea6c2..23342a433e11 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -442,6 +442,7 @@ dummy :=3D $(call unnest-vars,, \
>                  libvhost-user-obj-y \
>                  vhost-user-scsi-obj-y \
>                  vhost-user-blk-obj-y \
> +                vhost-user-bridge-obj-y \
>                  vhost-user-input-obj-y \
>                  vhost-user-gpu-obj-y \
>                  qga-vss-dll-obj-y \
> @@ -672,6 +673,8 @@ vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) li=
bvhost-user.a
>  =09$(call LINK, $^)
>  vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libvhost-user.a
>  =09$(call LINK, $^)
> +vhost-user-bridge$(EXESUF): $(vhost-user-bridge-obj-y) libvhost-user.a
> +=09$(call LINK, $^)
> =20
>  rdmacm-mux$(EXESUF): LIBS +=3D "-libumad"
>  rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
> diff --git a/Makefile.objs b/Makefile.objs
> index 26b9cff95436..0240100b9a17 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -109,6 +109,7 @@ vhost-user-scsi.o-cflags :=3D $(LIBISCSI_CFLAGS)
>  vhost-user-scsi.o-libs :=3D $(LIBISCSI_LIBS)
>  vhost-user-scsi-obj-y =3D contrib/vhost-user-scsi/
>  vhost-user-blk-obj-y =3D contrib/vhost-user-blk/
> +vhost-user-bridge-obj-y =3D contrib/vhost-user-bridge/
>  rdmacm-mux-obj-y =3D contrib/rdmacm-mux/
>  vhost-user-input-obj-y =3D contrib/vhost-user-input/
>  vhost-user-gpu-obj-y =3D contrib/vhost-user-gpu/
> diff --git a/configure b/configure
> index 115dc38085f3..0415eb5c99d3 100755
> --- a/configure
> +++ b/configure
> @@ -6223,6 +6223,9 @@ if test "$want_tools" =3D "yes" ; then
>    if [ "$curl" =3D "yes" ]; then
>        tools=3D"elf2dmp\$(EXESUF) $tools"
>    fi
> +  if [ "$vhost_user" =3D "yes" ]; then
> +      tools=3D"vhost-user-bridge\$(EXESUF) $tools"
> +  fi
>  fi
>  if test "$softmmu" =3D yes ; then
>    if test "$linux" =3D yes; then
> diff --git a/contrib/vhost-user-bridge/Makefile.objs b/contrib/vhost-user=
-bridge/Makefile.objs
> new file mode 100644
> index 000000000000..36a8d9b49a05
> --- /dev/null
> +++ b/contrib/vhost-user-bridge/Makefile.objs
> @@ -0,0 +1 @@
> +vhost-user-bridge-obj-y =3D main.o
> diff --git a/tests/vhost-user-bridge.c b/contrib/vhost-user-bridge/main.c
> similarity index 100%
> rename from tests/vhost-user-bridge.c
> rename to contrib/vhost-user-bridge/main.c
> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> index e88918f7639e..d00424460e23 100644
> --- a/docs/devel/migration.rst
> +++ b/docs/devel/migration.rst
> @@ -807,7 +807,7 @@ The Linux kernel userfault support works on `/dev/shm=
` memory and on `hugetlbfs`
>  for hugetlbfs which may be a problem in some configurations).
> =20
>  The vhost-user code in QEMU supports clients that have Postcopy support,
> -and the `vhost-user-bridge` (in `tests/`) and the DPDK package have chan=
ges
> +and the `vhost-user-bridge` (in `contrib/`) and the DPDK package have ch=
anges
>  to support postcopy.
> =20
>  The client needs to open a userfaultfd and register the areas
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 2f1cafed720d..78cdbe91aed5 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -586,7 +586,6 @@ include $(SRC_PATH)/tests/qtest/Makefile.include
> =20
>  tests/test-qga$(EXESUF): qemu-ga$(EXESUF)
>  tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)
> -tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o $(test-util-=
obj-y) libvhost-user.a
> =20
>  SPEED =3D quick
> =20
> --=20
> 2.24.1


