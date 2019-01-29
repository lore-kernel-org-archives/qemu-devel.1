Received: from eggs.gnu.org ([209.51.188.92]:50805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goSgx-0001go-1j
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 07:40:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goSgk-0003hA-8g
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 07:40:31 -0500
Date: Tue, 29 Jan 2019 13:39:31 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190129133931.54d64d58.cohuck@redhat.com>
In-Reply-To: <1548689558-23960-1-git-send-email-imammedo@redhat.com>
References: <ae5efb07-6079-e102-4c21-65bdd5c9d9a2@redhat.com>
	<1548689558-23960-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] s390x: remove direct reference to
 mem_path global form s390x code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net, david@redhat.com, philmd@redhat.com

On Mon, 28 Jan 2019 16:32:38 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

In the subject: s/form/from/

> I plan to deprecate -mem-path option and replace it with memory-backend,
> for that it's necessary to get rid of mem_path global variable.
> Do it for s390x case, replacing it with alternative way to enable
> 1Mb hugepages capability.
>=20
> To do that, replace qemu_mempath_getpagesize() with qemu_getrampagesize()
> which also checks for -mem-path provided RAM.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
> v3:
>   fixup, typo in commit msg (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>)
> v2:
>   * s/qemu_mempath_getpagesize/qemu_getrampagesiz/ and drop the rest of c=
hanges
>           David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/kvm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 2ebf26a..90766fa 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -287,7 +287,7 @@ void kvm_s390_crypto_reset(void)
> =20
>  static int kvm_s390_configure_mempath_backing(KVMState *s)
>  {
> -    size_t path_psize =3D qemu_mempath_getpagesize(mem_path);
> +    size_t path_psize =3D qemu_getrampagesize();
> =20
>      if (path_psize =3D=3D 4 * KiB) {
>          return 0;
> @@ -319,7 +319,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
>      MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> =20
> -    if (mem_path && kvm_s390_configure_mempath_backing(s)) {
> +    if (kvm_s390_configure_mempath_backing(s)) {
>          return -EINVAL;
>      }
> =20

This needs an #include "exec/ram_addr.h", or the compilation fails.

Should I fix it up while applying, or will you resend?
