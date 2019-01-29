Received: from eggs.gnu.org ([209.51.188.92]:42490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1goU5R-00009e-L6
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:10:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1goU5Q-0002Kn-AM
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:10:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1goU5P-0002Jj-Tl
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:10:00 -0500
Date: Tue, 29 Jan 2019 09:09:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190129085131-mutt-send-email-mst@kernel.org>
References: <cover.1548771590.git.yi.z.zhang@linux.intel.com>
	<4f91d5a46fc26d5672c91d80b78e986d4267c612.1548771590.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f91d5a46fc26d5672c91d80b78e986d4267c612.1548771590.git.yi.z.zhang@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 3/3] docs: Added MAP_SYNC documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhang, Yi" <yi.z.zhang@linux.intel.com>
Cc: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, richardw.yang@linux.intel.com, ehabkost@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com, dan.j.williams@intel.com

On Tue, Jan 29, 2019 at 10:49:18PM +0800, Zhang, Yi wrote:
> From: Zhang Yi <yi.z.zhang@linux.intel.com>
>=20
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> ---
>  docs/nvdimm.txt | 29 ++++++++++++++++++++++++++++-
>  qemu-options.hx |  4 ++++
>  2 files changed, 32 insertions(+), 1 deletion(-)
>=20
> diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
> index 5f158a6..9da96aa 100644
> --- a/docs/nvdimm.txt
> +++ b/docs/nvdimm.txt
> @@ -142,11 +142,38 @@ backend of vNVDIMM:
>  Guest Data Persistence
>  ----------------------
> =20
> +vNVDIMM is designed and implemented to guarantee the guest data
> +persistence on the backends in case of host crash or a power failures.
> +However, there are still some requirements and limitations
> +as explained below.
> +

I'd just drop the above paragraph.

>  Though QEMU supports multiple types of vNVDIMM backends on Linux,
> -currently the only one that can guarantee the guest write persistence
> +if MAP_SYNC is not supported by the host kernel and the backends,
> +the only backend that can guarantee the guest write persistence
>  is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
>  which all guest access do not involve any host-side kernel cache.
> =20
> +mmap(2) flag MAP_SYNC is added since Linux kernel 4.15. On such
> +systems, QEMU can mmap(2) the dax backend files with MAP_SYNC, which
> +ensures filesystem metadata consistency in case of a host crash or a p=
ower
> +failure. Enabling MAP_SYNC in QEMU requires below conditions
> +
> + - 'pmem' option of memory-backend-file is 'on':
> +   The backend is a file supporting DAX, e.g., a file on an ext4 or
> +   xfs file system mounted with '-o dax'. if your pmem=3Don ,but the b=
ackend is
> +   not a file supporting DAX, mapping with this flag results in an EOP=
NOTSUPP
> +   warning. then MAP_SYNC will be ignored
> +
> + - 'share' option of memory-backend-file is 'on':
> +   MAP_SYNC flag available only with the MAP_SHARED_VALIDATE mapping t=
ype.
> +
> + - 'MAP_SYNC' is supported on linux kernel.(default opened since Linux=
 4.15)
> +
> +Otherwise, We will ignore the MAP_SYNC flag.
> +
> +For more details, please reference mmap(2) man page:
> +http://man7.org/linux/man-pages/man2/mmap.2.html.
> +


OK above is too low level so it doesn't really help anyone. Instead
it describes code internals and will quickly get out of sync
(pun intended). Let's look at the manpage:

	Shared file mappings with this flag provide the guarantee that
              while some memory is writably mapped in the address space o=
f
              the process, it will be visible in the same file at the sam=
e
              offset even after the system crashes or is rebooted.  In co=
n=E2=80=90
              junction with the use of appropriate CPU instructions, this
              provides users of such mappings with a more efficient way o=
f
              making data modifications persistent.

OK this is more readable. We already have:

	Though QEMU supports multiple types of vNVDIMM backends on Linux,
	the only backend that can guarantee the guest write persistence
	is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
	which all guest access do not involve any host-side kernel cache.

Let's add:

When using a file supporting DAX (direct mapping of persistent memory)
as a backend, write persistence is guaranteed if the host kernel
has support for the MAP_SYNC flag in the mmap system call
(available since Linux 4.15 and on certain distro kernels)
and additionally both 'pmem' and 'share' flags are set to 'on'
on the backend.

If these conditions are not satisfied i.e. if either 'pmem' or 'share'
are not set, if the backend file does not support DAX
or if MAP_SYNC is not supported by the host kernel, write
persistence is not guaranteed after a system crash.
For compatibility reasons, these conditions are silently ignored if not
satisfied. Currently, no way is provided to test for them.


>  When using other types of backends, it's suggested to set 'unarmed'
>  option of '-device nvdimm' to 'on', which sets the unarmed flag of the
>  guest NVDIMM region mapping structure.  This unarmed flag indicates
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 08f8516..0cd41f4 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4002,6 +4002,10 @@ using the SNIA NVM programming model (e.g. Intel=
 NVDIMM).
>  If @option{pmem} is set to 'on', QEMU will take necessary operations t=
o
>  guarantee the persistence of its own writes to @option{mem-path}
>  (e.g. in vNVDIMM label emulation and live migration).
> +Also, we will map the backend-file with MAP_SYNC flag, which can ensur=
e
> +the file metadata is in sync to @option{mem-path} in case of host cras=
h
> +or a power failure. MAP_SYNC requires support from both the host kerne=
l
> +(since Linux kernel 4.15) and @option{mem-path} (only files supporting=
 DAX).
> =20
>  @item -object memory-backend-ram,id=3D@var{id},merge=3D@var{on|off},du=
mp=3D@var{on|off},share=3D@var{on|off},prealloc=3D@var{on|off},size=3D@va=
r{size},host-nodes=3D@var{host-nodes},policy=3D@var{default|preferred|bin=
d|interleave}
> =20
> --=20
> 2.7.4
