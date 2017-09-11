Received: from eggs.gnu.org ([2001:4830:134:3::10]:47468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drLA4-0006Sz-Mn
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drLA1-0008G8-Gp
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:37:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1drLA1-0008FX-83
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:37:45 -0400
References: <20170907092010.3605-1-aik@ozlabs.ru>
	<20170907092010.3605-4-aik@ozlabs.ru>
	<984ae4a4-3045-e880-b39e-da846b1e2821@redhat.com>
	<b0ddd613-701c-4814-8241-d15d6917643f@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <32ae1779-0d00-0d1b-194f-130477531fdc@redhat.com>
Date: Mon, 11 Sep 2017 11:37:41 +0200
MIME-Version: 1.0
In-Reply-To: <b0ddd613-701c-4814-8241-d15d6917643f@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH qemu 3/4] memory: Share flat views and
 dispatch trees between address spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

On 11/09/2017 11:06, Alexey Kardashevskiy wrote:
> On 11/09/17 17:40, Paolo Bonzini wrote:
>> On 07/09/2017 11:20, Alexey Kardashevskiy wrote:
>>> =20
>>>      /* Accessed via RCU.  */
>>>      struct FlatView *current_map;
>>> =20
>>>      int ioeventfd_nb;
>>>      struct MemoryRegionIoeventfd *ioeventfds;
>>> -    struct AddressSpaceDispatch *dispatch;
>>> -    struct AddressSpaceDispatch *next_dispatch;
>>> +
>>
>> The rough idea of the patch matches my suggestion indeed.  However, I =
am
>> not sure why all of the changes in patch 2 are needed.
>=20
> For this:
>=20
>  struct MemoryRegionSection {
>      MemoryRegion *mr;
> -    AddressSpace *address_space;
> +    AddressSpaceDispatch *dispatch;
>=20
> as there are many ASes attached to the same flatview/dispatch.

Ok, this makes sense.  Maybe it should be a flatview rather than an
AddressSpaceDispatch (a FlatView is essentially a list of
MemoryRegionSections; attaching the ASD to the FlatView is more or less
an implementation detail).


> And because of that, there is also:
>=20
>  struct IOMMUTLBEntry {
> -    AddressSpace    *target_as;
> +    AddressSpaceDispatch *target_dispatch;
>=20
> as the "section" in address_space_get_iotlb_entry() does not have
> address_space any more, even though the only user of it -
> vhost_device_iotlb_miss() - only checks if (iotlb.target_dispatch !=3D =
NULL).

You could change address_space_do_translate's "as" to AddressSpace **as.
 Then, address_space_get_iotlb_entry can populate the .target_as from
the output value of the argument.

>> In addition, you could change the computation of FlatView's root to
>> resolve 2^64-sized aliases;
>=20
> Here we reached the boundary of my english :)
>=20
> Roots are given when AS/Flatview is created, and aliases are resolved a=
lready.
>=20

Currently, you're doing

+        if (view->root =3D=3D root) {
+            as->current_map =3D flatview_get(view);
+            break;
+        }

(and by the way the above doesn't resolve aliases; aliases are only
resolved by render_memory_region).

Instead, the FlatViews should be shared at transaction commit time.  At
the beginning of commit, the list of flat views is empty.  As you
process each AddressSpace, you resolve the root alias(*) and search for
the resulting MemoryRegion in the list of FlatViews.  If you find it,
you do flatview_ref and point as->current_map to the FlatView you just
found.  Otherwise, you do generate_memory_topology etc. as in the old cod=
e.

(*) something like

	MemoryRegion *mr =3D as->root;
	MemoryRegion *root_mr;
	while (mr->alias && !mr->alias_offset &&
	       int128_ge(mr->size, mr->alias->size)) {
	    /* The alias is included in its entirety.  Use it as
	     * the "real" root, so that we can share more FlatViews.
	     */
	    mr =3D mr->alias;
	}=09

	/* We found the "real" root, but maybe we can use a shared empty
	 * FlatView instead?
	 */
        for (root_mr =3D mr; root_mr; root_mr =3D root_mr->alias) {
	    if (!root_mr->enabled) {
		/* Use a shared empty FlatView.  */
		return NULL;
	    }
        }

        return mr;

Also:

> +static FlatView *flatview_get(FlatView *view)
>  {
> -    FlatView *view;
> -
>      rcu_read_lock();
> -    view =3D atomic_rcu_read(&as->current_map);
> +    view =3D atomic_rcu_read(&view);

This is "view =3D view" so it makes little sense, and then in the caller

+    view =3D flatview_get(as->current_map);

as->current_map is accessed without atomic_rcu_read.  So
address_space_get_flatview must stay.  Probably this will solve itself
when you do the rest.

Paolo

>> also set it to NULL if the AddressSpace's
>> root is disabled or the alias it resolves to is disabled (and so on
>> recursively until a non-alias is found).  This should remove the need
>> for address_space_root() and the change to pci_init_bus_master.
>=20
>=20
>=20
>=20
