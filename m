Received: from eggs.gnu.org ([2001:4830:134:3::10]:55802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIb1F-0005bC-2g
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIb1A-0001X2-5Y
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:29:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIb19-0001Ud-Tb
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:29:00 -0400
References: <1496383606-18060-1-git-send-email-yang.zhong@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bba5be37-e002-b65e-41b9-358e7f6a3ec9@redhat.com>
Date: Wed, 7 Jun 2017 15:28:55 +0200
MIME-Version: 1.0
In-Reply-To: <1496383606-18060-1-git-send-email-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/4] tcg: split the tcg code and
 separate tcg files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, laurent.desnogues@gmail.com, anthony.xu@intel.com



On 02/06/2017 08:06, Yang Zhong wrote:
> In order to disable tcg, the first phase is to split some
> tcg code and separate those tcg related files into one
> directory. The next phase will disable tcg more easily and
> cleanly.
>  =20
> In the first phase, there are four patches to deal with split=20
> code and separate files.
> 1)split the tcg exec code.
>   a)split the tcg accelerators from accel.c file and re-name
>     tcg accelerator to tcg-all.c, like kvm-all.c did.
>   b)create one accel directory, which will include kvm,
>     tcg and general exec files.
> 2)move cputlb.c, cpu-exec-common.c and cpu-exec.c related tcg
>   exec file into accel/tcg/ subdirectory.
> 3)move tcg related backend files into accel/tcg/ directory
>   those files include translate-all.(ch), translate-common.c,
>   tci.c and tcg-runtime.c.
> 4)move kvm and exec.c file.
>   a)move kvm related accelerator files into accel/kvm/ directory.
>   b)move exec.c in accel/ directory.
>   c)stubs/ directory was created for kvm and tcg stub files.
>=20
> after those changes are done, the file tree like below
> accel
> =E2=94=9C=E2=94=80=E2=94=80 accel.c
> =E2=94=9C=E2=94=80=E2=94=80 exec.c
> =E2=94=9C=E2=94=80=E2=94=80 kvm
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 kvm-all.c
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 Makefile.objs
> =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 trace-events
> =E2=94=9C=E2=94=80=E2=94=80 Makefile.objs
> =E2=94=9C=E2=94=80=E2=94=80 stubs
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 kvm-stub.c
> =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 Makefile.objs
> =E2=94=94=E2=94=80=E2=94=80 tcg
>     =E2=94=9C=E2=94=80=E2=94=80 cpu-exec.c
>     =E2=94=9C=E2=94=80=E2=94=80 cpu-exec-common.c
>     =E2=94=9C=E2=94=80=E2=94=80 cputlb.c
>     =E2=94=9C=E2=94=80=E2=94=80 Makefile.objs
>     =E2=94=9C=E2=94=80=E2=94=80 tcg-all.c
>     =E2=94=9C=E2=94=80=E2=94=80 tcg-runtime.c
>     =E2=94=9C=E2=94=80=E2=94=80 tci.c
>     =E2=94=9C=E2=94=80=E2=94=80 trace-events
>     =E2=94=9C=E2=94=80=E2=94=80 translate-all.c
>     =E2=94=9C=E2=94=80=E2=94=80 translate-all.h
>     =E2=94=94=E2=94=80=E2=94=80 translate-common.c
> 3 directories, 19 files
>=20
> v3: squash patches and move tcg related backend files to accel/tcg/=20
>     according to Paolo's comments.
>     add kvm and tcg exec related patches into one patchset.
>=20
>=20
> Yang Zhong (4):
>   accel: split the tcg accelerator from accel.c file
>   tcg: move tcg related files into accel/tcg/ subdirectory
>   tcg: move tcg backend files into accel/tcg/
>   accel: move kvm related accelerator files into accel/
>=20
>  Makefile.objs                                      |  3 +-
>  Makefile.target                                    | 10 +---
>  accel/Makefile.objs                                |  5 ++
>  accel.c =3D> accel/accel.c                           | 27 ----------
>  exec.c =3D> accel/exec.c                             |  0
>  accel/kvm/Makefile.objs                            |  1 +
>  kvm-all.c =3D> accel/kvm/kvm-all.c                   |  2 +-
>  accel/kvm/trace-events                             | 13 +++++
>  accel/stubs/Makefile.objs                          |  1 +
>  kvm-stub.c =3D> accel/stubs/kvm-stub.c               |  0
>  accel/tcg/Makefile.objs                            |  4 ++
>  cpu-exec-common.c =3D> accel/tcg/cpu-exec-common.c   |  0
>  cpu-exec.c =3D> accel/tcg/cpu-exec.c                 |  2 +-
>  cputlb.c =3D> accel/tcg/cputlb.c                     |  0
>  accel/tcg/tcg-all.c                                | 61 ++++++++++++++=
++++++++
>  tcg-runtime.c =3D> accel/tcg/tcg-runtime.c           |  0
>  tci.c =3D> accel/tcg/tci.c                           |  0
>  accel/tcg/trace-events                             | 10 ++++
>  translate-all.c =3D> accel/tcg/translate-all.c       |  2 +-
>  translate-all.h =3D> accel/tcg/translate-all.h       |  0
>  translate-common.c =3D> accel/tcg/translate-common.c |  0
>  configure                                          |  2 +-
>  trace-events                                       | 21 --------
>  23 files changed, 103 insertions(+), 61 deletions(-)
>  create mode 100644 accel/Makefile.objs
>  rename accel.c =3D> accel/accel.c (87%)
>  rename exec.c =3D> accel/exec.c (100%)
>  create mode 100644 accel/kvm/Makefile.objs
>  rename kvm-all.c =3D> accel/kvm/kvm-all.c (99%)
>  create mode 100644 accel/kvm/trace-events
>  create mode 100644 accel/stubs/Makefile.objs
>  rename kvm-stub.c =3D> accel/stubs/kvm-stub.c (100%)
>  create mode 100644 accel/tcg/Makefile.objs
>  rename cpu-exec-common.c =3D> accel/tcg/cpu-exec-common.c (100%)
>  rename cpu-exec.c =3D> accel/tcg/cpu-exec.c (99%)
>  rename cputlb.c =3D> accel/tcg/cputlb.c (100%)
>  create mode 100644 accel/tcg/tcg-all.c
>  rename tcg-runtime.c =3D> accel/tcg/tcg-runtime.c (100%)
>  rename tci.c =3D> accel/tcg/tci.c (100%)
>  create mode 100644 accel/tcg/trace-events
>  rename translate-all.c =3D> accel/tcg/translate-all.c (99%)
>  rename translate-all.h =3D> accel/tcg/translate-all.h (100%)
>  rename translate-common.c =3D> accel/tcg/translate-common.c (100%)
>=20

Queued, thanks (except I'm not sure why you're moving exec.c, so I've
undone that, and tcg-runtime.c probably fits better in tcg/).

Paolo
