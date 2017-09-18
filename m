Received: from eggs.gnu.org ([2001:4830:134:3::10]:34127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dtxRW-0006mO-J2
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dtxRT-0006Sm-B1
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:54:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dtxRT-0006Qv-34
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:54:35 -0400
References: <20170918101709.30421-1-aik@ozlabs.ru>
	<20170918101709.30421-2-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c01622e7-3e6d-cf90-a28c-aa31b4857887@redhat.com>
Date: Mon, 18 Sep 2017 16:54:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170918101709.30421-2-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH qemu v3 01/13] memory: Postpone flatview
 and dispatch tree building till all devices are added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

On 18/09/2017 12:16, Alexey Kardashevskiy wrote:
> Most devices use at least one address space and every time a new addres=
s
> space is added, flat views and dispatch trees are rebuild for all addre=
ss
> spaces. This is not a problem for a relatively small amount of devices =
but
> even 50 virtio-pci devices use more than 8GB of RAM.
>=20
> What happens that on every flatview/dispatch rebuild, new arrays are
> allocated and old ones release but the release is done via RCU so until
> an entire machine is build, they are not released.
>=20
> This wraps devices creation into memory_region_transaction_begin/commit
> to massively reduce amount of flat view/dispatch tree (re)allocations.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v2:
> * wrapped qemu_run_machine_init_done_notifiers() as well
> ---
>  vl.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/vl.c b/vl.c
> index 9e62e92aea..e4f2ece590 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4741,12 +4741,16 @@ int main(int argc, char **argv, char **envp)
>      igd_gfx_passthru();
> =20
>      /* init generic devices */
> +    memory_region_transaction_begin();
> +
>      rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
>      if (qemu_opts_foreach(qemu_find_opts("device"),
>                            device_init_func, NULL, NULL)) {
>          exit(1);
>      }
> =20
> +    memory_region_transaction_commit();
> +
>      cpu_synchronize_all_post_init();
> =20
>      rom_reset_order_override();
> @@ -4829,8 +4833,13 @@ int main(int argc, char **argv, char **envp)
>      /* TODO: once all bus devices are qdevified, this should be done
>       * when bus is created by qdev.c */
>      qemu_register_reset(qbus_reset_all_fn, sysbus_get_default());
> +
> +    memory_region_transaction_begin();
> +
>      qemu_run_machine_init_done_notifiers();
> =20
> +    memory_region_transaction_commit();
> +
>      if (rom_check_and_register_reset() !=3D 0) {
>          error_report("rom check and register reset failed");
>          exit(1);
>=20

This should not be necessary given the other patches; the PCI devices
have an empty address space at the beginning, so there are other less
intrusive optimizations to do instead with the same effect:

1) as a start, the "|=3D root->enabled" can resolve aliases.  This should
be enough for the PCI device case.

2) also, after patch 2 you know that the address space has no listeners
here, so the begin/commit isn't really needed.  Instead you can use the
open-coded loop to directly generate the FlatView.  This avoids touching
_all_ address spaces, which is already an improvement from O(n^2) to
O(n) rebuilds on device startup.

3) you can consult the list (or hash table :)) of live FlatViews (which
means you keep it live after memory_region_transaction_commit ends, and
only clear it on the next call), and reuse an existing FlatView.  Note
that the number of distinct FlatViews should be very few, so feel free
to revert from hash table to list in v4 if you prefer.

4) you can skip address_space_update_topology_pass if
QTAILQ_EMPTY(&as->listeners).  This can provide some startup speed
improvements.

Optimizations 2/3/4 should be moved to the end of the series, or even in
a separate post.  The first can be done in the beginning too, as you pref=
er.

Paolo
