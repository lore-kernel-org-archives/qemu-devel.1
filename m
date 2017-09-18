Received: from eggs.gnu.org ([2001:4830:134:3::10]:54794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dtxB6-0004GD-EJ
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dtxB2-0004ly-61
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:37:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dtxB1-0004lN-Vw
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:37:36 -0400
References: <20170918101709.30421-1-aik@ozlabs.ru>
	<20170918101709.30421-12-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a0ca1e5e-75f9-3d5c-d291-1dc0da8bf5aa@redhat.com>
Date: Mon, 18 Sep 2017 16:37:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170918101709.30421-12-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH qemu v3 11/13] memory: Share FlatView's and
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

On 18/09/2017 12:17, Alexey Kardashevskiy wrote:
> +        physmr =3D memory_region_unalias_entire(old_view->root);
> +
> +        key =3D !physmr->enabled ? 0 : physmr;
> +        new_view =3D (FlatView *) g_hash_table_lookup(views, key);
> +        if (new_view) {
> +            continue;
> +        }
> +
> +        new_view =3D generate_memory_topology(physmr);
> +
> +        new_view->dispatch =3D address_space_dispatch_new(new_view);
> +        for (i =3D 0; i < new_view->nr; i++) {
> +            MemoryRegionSection mrs =3D
> +                section_from_flat_range(&new_view->ranges[i], new_view=
);
> +            flatview_add_to_dispatch(new_view, &mrs);
> +        }
> +        address_space_dispatch_compact(new_view->dispatch);
> +
> +        g_hash_table_insert(views, key, new_view);
> +    }
> +
> +    /* Replace FVs in ASes */
> +    QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
> +        old_view =3D as->current_map;
> +        physmr =3D memory_region_unalias_entire(old_view->root);
> +
> +        key =3D !physmr->enabled ? 0 : physmr;

This is duplicate, perhaps memory_region_unalias_entire should do it
instead?  Does it make sense for flatview->root to be NULL, or does it
break something else?  If something breaks, disregard the remaining
comments.

(BTW, maybe you can rename the function to memory_region_get_flatview_roo=
t).

>=20
> +
> +    /* Unref FVs from temporary table */
> +    g_hash_table_foreach_remove(views, flatview_unref_g_hash, 0);
> +    g_hash_table_unref(views);
>  }

You can avoid g_hash_table_foreach_remove and also flatview_unref_g_hash
instead use g_hash_table_new_full (casting flatview_unref to
GDestroyNotify should work fine).

>=20
> @@ -2690,13 +2721,6 @@ AddressSpace *address_space_init_shareable(Memor=
yRegion *root, const char *name)
>  {
>      AddressSpace *as;
> =20
> -    QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
> -        if (root =3D=3D as->root && as->malloced) {
> -            as->ref_count++;
> -            return as;
> -        }
> -    }
> -
>      as =3D g_malloc0(sizeof *as);
>      address_space_init(as, root, name);
>      as->malloced =3D true;

Is this on purpose because it's now pointless?  Maybe it should be
pointed out in the commit message.

Paolo
