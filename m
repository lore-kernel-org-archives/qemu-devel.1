Received: from eggs.gnu.org ([2001:4830:134:3::10]:33127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e42N2-0003Kz-TO
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 06:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e42Mz-0006aC-Op
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 06:11:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e42Mz-0006ZT-IA
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 06:11:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D392E356E8
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:11:34 +0000 (UTC)
Date: Mon, 16 Oct 2017 11:11:28 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171016101128.GD17583@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171013081450.29647-1-kraxel@redhat.com>
	<20171013095724.GE20515@redhat.com>
	<1508145553.15782.7.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1508145553.15782.7.camel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/11] Ui 20171013 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Oct 16, 2017 at 11:19:13AM +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> > I'm afraid this is quite likely to fail build smoke test again. I've
> > just tried a build on OpenBSD with the bash -> sh fix in it, and I
> > found that it still tried to build the keycodemap files in parallel
> > with checking out the GIT submodules. It also tried to run the
> > mkdir -p dtc/libfdt in parallel and this caused git to refuse to
> > checkout the dtc module due to that empty dir existing. So there's
> > still some deps problems in here I think that let make build in
> > the wrong order :-(
>=20
> > In all my debugging the one thing I've seen work correctly is the
> > re-running of configure (via config.status), which always happens
> > earlier and is serialized wrt everything else. So I wonder if we
> > should change direction slightly, and have configure checkout the
> > submodules. Then just make sure that config.status is triggered
> > when submodules are out of date.
>=20
> I've noticed configure running *in parallel* to other stuff.=20
> Reproducer:
>=20
>   (1) Apply patch #1
>   (2) run normal build
>   (3) make -C dtc clean
>   (4) touch configure
>   (5) make
>=20
> Watch configure and dtc build running in parallel.
> I think the added Makefile dependency breaks it.
>=20
> Incremental fix (also pushed to queue/ui):
>=20
> --- a/Makefile
> +++ b/Makefile
> @@ -35,8 +35,6 @@ endif
> =C2=A0
> =C2=A0.git-submodule-status: git-submodule-update config-host.mak
> =C2=A0
> -Makefile: .git-submodule-status
> -
> =C2=A0# Check that we're not trying to do an out-of-tree build from
> =C2=A0# a tree that's been used for an in-tree build.
> =C2=A0ifneq ($(realpath $(SRC_PATH)),$(realpath .))
> @@ -107,6 +105,7 @@ endif
> =C2=A0GENERATED_FILES +=3D $(TRACE_HEADERS)
> =C2=A0GENERATED_FILES +=3D $(TRACE_SOURCES)
> =C2=A0GENERATED_FILES +=3D $(BUILD_DIR)/trace-events-all
> +GENERATED_FILES +=3D .git-submodule-status
> =C2=A0
> =C2=A0trace-group-name =3D $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/=
_/g')

Yep, that looks to have fixed the races I was able to reproduce


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
