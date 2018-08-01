Received: from eggs.gnu.org ([2001:4830:134:3::10]:40425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fknVB-0002OK-W8
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 05:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fknV8-0008Ja-TK
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 05:33:06 -0400
Reply-To: thuth@redhat.com
References: <20180731090900.187430-1-frankja@linux.ibm.com>
	<20180731090900.187430-3-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <07437701-20fa-a1df-ec6a-785f47da50e8@redhat.com>
Date: Wed, 1 Aug 2018 11:32:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180731090900.187430-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] s390x: Enable KVM huge page backing
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, qemu-s390x@nongnu.org

On 07/31/2018 11:09 AM, Janosch Frank wrote:
> QEMU has had huge page support for a longer time already, but KVM
> memory management under s390x needed some changes to work with huge
> backings.
>=20
> Now that we have support, let's enable it if requested and
> available. Otherwise we now properly tell the user if there is no
> support and back out instead of failing to run the VM later on.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  target/s390x/kvm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index d923cf4240..26e6937498 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -285,6 +285,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
>      MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> =20
> +    if (mem_path && kvm_vm_enable_cap(s, KVM_CAP_S390_HPAGE, 0)) {
> +        error_report("Huge page backing was specified, "
> +                     "but this KVM does not support huge pages");
> +        return -EINVAL;
> +    }

I think you should also check the page size of the mem_path (e.g. with
qemu_mempath_getpagesize() ?), since a mem_path does not automatically
mean huge pages, does it?

 Thomas


PS: Please CC: qemu-s390x@nongnu.org for s390x patches!
