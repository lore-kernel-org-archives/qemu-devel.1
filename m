Received: from eggs.gnu.org ([2001:4830:134:3::10]:37816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gV01N-0004fX-KB
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:13:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gV01J-0001fW-Cv
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:13:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gV01J-0001dp-3N
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:13:13 -0500
References: <1544049083-16087-1-git-send-email-liam.merwick@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c7e0dcd0-11fe-9ddd-defb-78e51a59d072@redhat.com>
Date: Thu, 6 Dec 2018 21:13:07 +0100
MIME-Version: 1.0
In-Reply-To: <1544049083-16087-1-git-send-email-liam.merwick@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/3] qboot changes for PVH boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>
Cc: qemu-devel@nongnu.org, sgarzare@redhat.com, maran.wilson@oracle.com

On 05/12/18 23:31, Liam Merwick wrote:
> For certain applications it is desirable to rapidly boot a KVM virtual
> machine. In cases where legacy hardware and software support within the
> guest is not needed, QEMU should be able to boot directly into the
> uncompressed Linux kernel binary with minimal firmware involvement.
>=20
> There already exists an ABI to allow this for Xen PVH guests and the AB=
I
> is supported by Linux and FreeBSD:
>=20
>    https://xenbits.xen.org/docs/unstable/misc/pvh.html
>=20
> Details on the Linux changes: https://lkml.org/lkml/2018/4/16/1002
>=20
> This patch series provides qboot support to populate the start_info str=
uct
> needed by the direct boot ABI and to configure the guest e820 tables to
> enable QEMU to use that same entry point for booting KVM guests.
>=20
> Us=D1=96ng the methods/scripts documented by the NEMU team at
>=20
>    https://github.com/intel/nemu/wiki/Measuring-Boot-Latency
>    https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg00200.html
>=20
> below are some timings measured (vmlinux and bzImage from the same buil=
d).
> Time to get to kernel start is almost halved (95=E1=B9=81s -> 48ms)

I had a few comments on patch 2, but overall it looks fine.  Can you
send a pull request on GitHub?

Thanks,

Paolo

> QEMU + qboot + vmlinux (PVH + 4.20-rc4)
>  qemu_init_end: 41.550521
>  fw_start: 41.667139 (+0.116618)
>  fw_do_boot: 47.448495 (+5.781356)
>  linux_startup_64: 47.720785 (+0.27229)
>  linux_start_kernel: 48.399541 (+0.678756)
>  linux_start_user: 296.952056 (+248.552515)
>=20
> QEMU + qboot + bzImage:
>  qemu_init_end: 29.209276
>  fw_start: 29.317342 (+0.108066)
>  linux_start_boot: 36.679362 (+7.36202)
>  linux_startup_64: 94.531349 (+57.851987)
>  linux_start_kernel: 94.900913 (+0.369564)
>  linux_start_user: 401.060971 (+306.160058)
>=20
> QEMU + bzImage:
>  qemu_init_end: 30.424430
>  linux_startup_64: 893.770334 (+863.345904)
>  linux_start_kernel: 894.17049 (+0.400156)
>  linux_start_user: 1208.679768 (+314.509278)
>=20
>=20
> Liam Merwick (3):
>   pvh: Add x86/HVM direct boot ABI header file
>   pvh: use x86/HVM direct boot ABI
>   pvh: add benchmark exit point
>=20
>  benchmark.h          |   3 +-
>  fw_cfg.c             |  79 +++++++++++++++++++++++++++-
>  include/start_info.h | 146 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  linuxboot.c          |   2 +-
>  main.c               |   3 ++
>  tables.c             |   9 ++++
>  6 files changed, 239 insertions(+), 3 deletions(-)
>  create mode 100644 include/start_info.h
>=20
