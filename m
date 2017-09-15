Received: from eggs.gnu.org ([2001:4830:134:3::10]:56259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dsmsw-0001Cw-GR
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 05:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dsmss-0003sj-Gk
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 05:26:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dsmss-0003sF-7u
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 05:26:02 -0400
References: <20170915084030.40988-1-aik@ozlabs.ru>
	<20170915084030.40988-12-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <165a7fa9-6ebb-3e95-2d95-7df2f550f1de@redhat.com>
Date: Fri, 15 Sep 2017 11:25:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170915084030.40988-12-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH qemu v2 11/13] memory: Share FlatView's and
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

On 15/09/2017 10:40, Alexey Kardashevskiy wrote:
> +
> +static bool flatview_can_share(FlatView *old_view, FlatView *new_view)
> +{
> +    MemoryRegion *old_root =3D memory_region_unalias_entire(old_view->=
root);
> +    MemoryRegion *new_root =3D memory_region_unalias_entire(new_view->=
root);
> +
> +    if (old_root =3D=3D new_root) {
> +        return true;
> +    }
> +
> +    if (!old_root->enabled && !new_root->enabled) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +

I think you can improve this by keeping the root in the address space
(removing the previous patch).  Instead, the FlatView's root can be the
one with resolved aliases.  Then old_root is just old_view->root, and if
an empty FlatView has a NULL root this just becomes

   the_other_view->root =3D=3D memory_region_unalias_entire(as->root);

>=20
> +
> +    /* Build list of unique FlatViews, FV::root is the key */
> +    QTAILQ_FOREACH(old_view, &flat_views, flat_views_link) {
> +        found =3D false;
> +        QTAILQ_FOREACH(new_view, &fvs_tmp, flat_views_link) {
> +            if (flatview_can_share(old_view, new_view)) {
> +                found =3D true;
> +                break;
> +            }
> +        }
> +        if (found) {
> +            continue;
> +        }
> +
> +        new_view =3D generate_memory_topology(old_view->root);
> +        flatview_render_new(old_view, new_view);
> +        QTAILQ_INSERT_TAIL(&fvs_tmp, new_view, flat_views_link);
> +    }

I don't understand the algorithm here.  Why is it visiting &flat_views
rather than the list of address spaces?  I would have thought it enough
to do

   for each address space
        if there is a (new) flat view that we can share
            add a reference
        else
            render a new flat view and add it to fvs_tmp

   flat_views =3D fvs_tmp;

   for each address space
        old_view =3D address_space_to_flatview(as);
        find the new flat view to use in fvs_tmp
        address_space_update_topology_pass(..., false);
        address_space_update_topology_pass(..., true);
        QTAILQ_REMOVE(&old_view->address_spaces, ...);
        atomic_rcu_set(&as->current_map, new_view);
        flatview_unref(old_view);
        QTAILQ_INSERT_TAIL(&new_view->address_spaces, ...);


It's also not clear to me what you need the FlatView's address_spaces
list for.  (It's probably something trivial that I'm missing, or maybe
it goes away with the previous change).

>=20
>  AddressSpace *address_space_init_shareable(MemoryRegion *root, const c=
har *name)
>  {
>      AddressSpace *as;
> =20
> -    QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
> -        if (root =3D=3D address_space_root(as) && as->malloced) {
> -            as->ref_count++;
> -            return as;
> -        }
> -    }
> -
>      as =3D g_malloc0(sizeof *as);
>      address_space_init(as, root, name);
> -    as->malloced =3D true;
> +
>      return as;
>  }
> =20

This belongs in the next patch; leaving as->malloced in
do_address_space_destroy and the reference count in
address_space_destroy is not a big complication.

Paolo
