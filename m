Received: from eggs.gnu.org ([2001:4830:134:3::10]:50951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gCiZ7-00028K-GS
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gCiYv-0004wB-QW
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:56:28 -0400
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
	<20181012032431.32693-6-david@gibson.dropbear.id.au>
	<f21b8a98-3401-cf82-749d-2101fbe69a33@redhat.com>
	<20181013064009.GG16167@umbus.fritz.box>
	<d26f9429-1da8-20d2-e43b-bee1141fb62f@redhat.com>
	<20181017032859.GB30180@umbus.fritz.box>
From: David Hildenbrand <david@redhat.com>
Message-ID: <cee1e2e9-b10c-e8f3-c2a0-37555e03a6cf@redhat.com>
Date: Wed, 17 Oct 2018 11:56:09 +0200
MIME-Version: 1.0
In-Reply-To: <20181017032859.GB30180@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 5/5] virtio-balloon: Safely handle
 BALLOON_PAGE_SIZE < host page size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: dhildenb@redhat.com, imammedo@redhat.com, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

>>>> I am pretty sure that you can create misleading warnings in case you
>>>> migrate at the wrong time. (migrate while half the 64k page is infla=
ted,
>>>> on the new host the other part is inflated - a warning when switchin=
g to
>>>> another 64k page).
>>>
>>> Yes we can get bogus warnings across migration with this.  I was
>>> considering that an acceptable price, but I'm open to better
>>> alternatives.
>>
>> Is maybe reporting a warning on a 64k host when realizing the better
>> approach than on every inflation?
>>
>> "host page size does not match virtio-balloon page size. If the guest
>> has a different page size than the host, inflating the balloon might n=
ot
>> effectively free up memory."
>=20
> That might work - I'll see what I can come up with.  One complication
> is that theoretically at least, you can have multiple host page sizes
> (main memory in normal pages, a DIMM in hugepages).  That makes the
> condition on which the warning should be issued a bit fiddly to work
> out.

I assume issuing a warning on these strange systems would not hurt after
all. ("there is a chance this might not work")

>=20
>> Or reporting a warning whenever changing the balloon target size.
>=20
> I'm not sure what you mean by this.

I mean when setting e.g. qmp_balloon() to something !=3D 0. This avoids a
warning when a virtio-balloon device is silently created (e.g. by
libvirt?) but never used.

Checking in virtio_balloon_to_target would be sufficient I guess.

>=20
>>
>>>
>>>>> +        free(balloon->pbp);
>>>>> +        balloon->pbp =3D NULL;
>>>>>      }
>>>>> =20
>>>>> -    ram_block_discard_range(rb, ram_offset, rb_page_size);
>>>>> -    /* We ignore errors from ram_block_discard_range(), because it=
 has
>>>>> -     * already reported them, and failing to discard a balloon pag=
e is
>>>>> -     * not fatal */
>>>>> +    if (!balloon->pbp) {
>>>>> +        /* Starting on a new host page */
>>>>> +        size_t bitlen =3D BITS_TO_LONGS(subpages) * sizeof(unsigne=
d long);
>>>>> +        balloon->pbp =3D g_malloc0(sizeof(PartiallyBalloonedPage) =
+ bitlen);
>>>>> +        balloon->pbp->rb =3D rb;
>>>>> +        balloon->pbp->base =3D host_page_base;
>>>>> +    }
>>>>> +
>>>>> +    bitmap_set(balloon->pbp->bitmap,
>>>>> +               (ram_offset - balloon->pbp->base) / BALLOON_PAGE_SI=
ZE,
>>>>> +               subpages);
>>>>> +
>>>>> +    if (bitmap_full(balloon->pbp->bitmap, subpages)) {
>>>>> +        /* We've accumulated a full host page, we can actually dis=
card
>>>>> +         * it now */
>>>>> +
>>>>> +        ram_block_discard_range(rb, balloon->pbp->base, rb_page_si=
ze);
>>>>> +        /* We ignore errors from ram_block_discard_range(), becaus=
e it
>>>>> +         * has already reported them, and failing to discard a bal=
loon
>>>>> +         * page is not fatal */
>>>>> +
>>>>> +        free(balloon->pbp);
>>>>> +        balloon->pbp =3D NULL;
>>>>> +    }
>>>>>  }
>>>> No, not a fan of this approach.
>>>
>>> I can see why, but I really can't see what else to do without breakin=
g
>>> existing, supported, working (albeit by accident) setups.
>>
>> Is there any reason to use this more complicated "allow random freeing=
"
>> approach over a simplistic sequential freeing I propose? Then we can
>> simply migrate the last freed page and should be fine.
>=20
> Well.. your approach is probably simpler in terms of the calculations
> that need to be done, though only very slightly.  I think my approach
> is conceptually clearer though, since we're explicitly checking for
> exactly the condition we need, rather than something we thing should
> match up with that condition.

I prefer to keep it simple where possible. We expect sequential freeing,
so it's easy to implement with only one additional uint64_t that can be
easily migrated. Having to use bitmaps + alloc/free is not really needed.

If you insist, at least try to get rid of the malloc to e.g. simplify
migration. (otherwise, please add freeing code on unrealize(), I guess
you are missing that right now)

--=20

Thanks,

David / dhildenb
