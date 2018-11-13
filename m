Received: from eggs.gnu.org ([2001:4830:134:3::10]:55258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gMa2p-0006jJ-2s
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 09:52:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gMa2l-0006i8-Jh
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 09:51:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gMa2c-0006Dd-4J
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 09:51:49 -0500
Date: Tue, 13 Nov 2018 14:51:24 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181113145124.GA2542@work-vm>
References: <20181108010258.27010-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181108010258.27010-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu] hmp: Print if memory section is
 registered in KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

* Alexey Kardashevskiy (aik@ozlabs.ru) wrote:
> This adds a "KVM" marker to the "into mtree -f" to tell the user if
> a particular memory section is registered as a KVM memory slot; useful
> for debugging purposes.
>=20
> Since it is memory sections which get registered in KVM (rather than
> memory regions), this only prints "KVM" for flatviews.
>=20
> For example:
>  Root memory region: system
>   0000000000000000-00000003ffffffff (prio 0, ram): ppc_spapr.ram KVM
>   0000200000000020-000020000000003f (prio 1, i/o): virtio-pci
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

=46rom HMP I'm ok with this, but I wonder if we should make this
code more general to other accelerators and not specific to kvm?

Dave

> ---
>  include/sysemu/kvm.h |  1 +
>  accel/kvm/kvm-all.c  |  7 +++++++
>  memory.c             | 10 ++++++++++
>  3 files changed, 18 insertions(+)
>=20
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 97d8d9d0d5..9eab5ac1b1 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -471,6 +471,7 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int si=
gmask_len);
>  #if !defined(CONFIG_USER_ONLY)
>  int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
>                                         hwaddr *phys_addr);
> +bool is_kvm_memory(hwaddr start_addr, hwaddr size);
>  #endif
> =20
>  #endif /* NEED_CPU_H */
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 4880a05399..d72808aaa6 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -216,6 +216,13 @@ static KVMSlot *kvm_lookup_matching_slot(KVMMemoryLi=
stener *kml,
>      return NULL;
>  }
> =20
> +bool is_kvm_memory(hwaddr start_addr, hwaddr size)
> +{
> +    KVMMemoryListener *kml =3D &kvm_state->memory_listener;
> +
> +    return NULL !=3D kvm_lookup_matching_slot(kml, start_addr, size);
> +}
> +
>  /*
>   * Calculate and align the start address and the size of the section.
>   * Return the size. If the size is 0, the aligned section is empty.
> diff --git a/memory.c b/memory.c
> index 51204aa079..56c733c687 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2916,6 +2916,7 @@ static void mtree_print_flatview(gpointer key, gpoi=
nter value,
>      int n =3D view->nr;
>      int i;
>      AddressSpace *as;
> +    bool print_kvm =3D false;
> =20
>      p(f, "FlatView #%d\n", fvi->counter);
>      ++fvi->counter;
> @@ -2927,6 +2928,9 @@ static void mtree_print_flatview(gpointer key, gpoi=
nter value,
>              p(f, ", alias %s", memory_region_name(as->root->alias));
>          }
>          p(f, "\n");
> +        if (as =3D=3D &address_space_memory) {
> +            print_kvm =3D true;
> +        }
>      }
> =20
>      p(f, " Root memory region: %s\n",
> @@ -2960,6 +2964,12 @@ static void mtree_print_flatview(gpointer key, gpo=
inter value,
>          if (fvi->owner) {
>              mtree_print_mr_owner(p, f, mr);
>          }
> +
> +        if (kvm_enabled() && print_kvm &&
> +            is_kvm_memory(int128_get64(range->addr.start),
> +                          MR_SIZE(range->addr.size) + 1)) {
> +            p(f, " KVM");
> +        }
>          p(f, "\n");
>          range++;
>      }
> --=20
> 2.17.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
