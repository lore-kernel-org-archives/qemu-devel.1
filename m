Received: from eggs.gnu.org ([2001:4830:134:3::10]:47083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1degxr-0005TH-DV
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1degxm-0000sQ-HX
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:16:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1degxm-0000sB-Bu
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:16:50 -0400
Date: Mon, 7 Aug 2017 14:16:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170807141645.3392b3bf@gondolin>
In-Reply-To: <150210580404.1343.7325713896658799315.stgit@bahia.lan>
References: <150210580404.1343.7325713896658799315.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] kvm: workaround build break on
 gcc-7.1.1 / fedora26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>

On Mon, 07 Aug 2017 13:36:44 +0200
Greg Kurz <groug@kaod.org> wrote:

> Building QEMU on fedora26 with the latest gcc package fails:
>=20
>   CC      ppc64-softmmu/target/ppc/kvm.o
> In file included from include/sysemu/hw_accel.h:16:0,
>                  from target/ppc/kvm.c:31:
> target/ppc/kvm.c: In function =E2=80=98kvmppc_booke_watchdog_enable=E2=80=
=99:
> include/sysemu/kvm.h:449:35: error: =E2=80=98args_tmp[i]=E2=80=99 may be =
used uninitialized
>  in this function [-Werror=3Dmaybe-uninitialized]
>              cap.args[i] =3D args_tmp[i];                               \
>                                    ^
> target/ppc/kvm.c: In function =E2=80=98kvmppc_set_papr=E2=80=99:
> include/sysemu/kvm.h:449:35: error: =E2=80=98args_tmp[i]=E2=80=99 may be =
used uninitialized
>  in this function [-Werror=3Dmaybe-uninitialized]
> cc1: all warnings being treated as errors
>=20
> $ rpm -q gcc
> gcc-7.1.1-3.fc26.ppc64le
>=20
> The compiler should obviously optimize this code away when no extra
> agument is passed to kvm_vm_enable_cap() and kvm_vcpu_enable_cap(),
> but it doesn't. This bug should be fixed one day in gcc, but we can
> also change our code pattern so that we don't hit the issue anymore.
> We workaround this, by using memcpy() instead of open-coding the copy.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - use memcpy()
> ---
>  include/sysemu/kvm.h |   14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
