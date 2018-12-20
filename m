Received: from eggs.gnu.org ([2001:4830:134:3::10]:41957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ga5Te-0000Iv-Do
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 16:03:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ga5Td-00026D-Hy
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 16:03:30 -0500
References: <20181220022952.20493-1-jsnow@redhat.com>
	<20181220022952.20493-4-jsnow@redhat.com>
	<5c6ab855-5fb3-bbe0-f7ee-528fc2aa52da@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <13dea930-e726-ca56-e62e-11b7586ca270@redhat.com>
Date: Thu, 20 Dec 2018 16:03:19 -0500
MIME-Version: 1.0
In-Reply-To: <5c6ab855-5fb3-bbe0-f7ee-528fc2aa52da@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 03/11] blockdev: n-ary bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 12/19/18 9:48 PM, Eric Blake wrote:
> On 12/19/18 8:29 PM, John Snow wrote:
>> Especially outside of transactions, it is helpful to provide
>> all-or-nothing semantics for bitmap merges. This facilitates
>> the coalescing of multiple bitmaps into a single target for
>> the "checkpoint" interpretation when assembling bitmaps that
>> represent arbitrary points in time from component bitmaps.
>>
>> This is an incompatible change from the preliminary version
>> of the API.
>=20
> but that doesn't matter because it was in the x- namespace, and we're
> about to rename it anyway.
>=20

Yes, just an "FYI".

>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 75 ++++++++++++++++++++++++++++++--------------
>> =C2=A0 qapi/block-core.json | 22 ++++++-------
>> =C2=A0 2 files changed, 62 insertions(+), 35 deletions(-)
>>
>=20
>> +static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(const char *node,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 const char *target,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 strList *bitmaps,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 HBitmap **backup,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Error **errp)
>> =C2=A0 {
>=20
>> -=C2=A0=C2=A0=C2=A0 bdrv_merge_dirty_bitmap(dst, src, NULL, errp);
>> +=C2=A0=C2=A0=C2=A0 for (lst =3D bitmaps; lst; lst =3D lst->next) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 src =3D bdrv_find_dirty_bi=
tmap(bs, lst->value);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!src) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror_setg(errp, "Dirty bitmap '%s' not found", lst->value);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ds=
t =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_merge_dirty_bitmap(an=
on, src, NULL, &local_err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror_propagate(errp, local_err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ds=
t =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>=20
> Appears to be a silent no-op when given "bitmaps":[] as the source.=C2=A0=
 An
> alternative would be requiring at least one source in the list, but I
> don't see it as worth changing the patch to special-case an empty list
> differently from a no-op.
> >> @@ -1943,23 +1943,23 @@
>> =C2=A0 ##
>> =C2=A0 # @x-block-dirty-bitmap-merge:
>> =C2=A0 #
>> -# FIXME: Rename @src_name and @dst_name to src-name and dst-name.
>> -#
>> -# Merge @src_name dirty bitmap to @dst_name dirty bitmap. @src_name
>> dirty
>> -# bitmap is unchanged. On error, @dst_name is unchanged.
>> +# Merge dirty bitmaps listed in @bitmaps to the @target dirty bitmap.
>> +# The @bitmaps dirty bitmaps are unchanged.
>> +# On error, @target is unchanged.
>> =C2=A0 #
>> =C2=A0 # Returns: nothing on success
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If @nod=
e is not a valid block device, DeviceNotFound
>> -#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If @dst_name =
or @src_name is not found, GenericError
>> -#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If bitmaps ha=
s different sizes or granularities, GenericError
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If any bitmap=
 in @bitmaps or @target is not found,
>> GenericError
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If any of the=
 bitmaps have different sizes or granularities,
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 GenericError
>> =C2=A0 #
>> =C2=A0 # Since: 3.0
>=20
> Could do s/3.0/4.0/ to match the incompatible change here, but you do i=
t
> in the later patch where your remove the x-.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

Yeah, I think I'll just leave it this way, so all the version
graduations are in the same patch.

Thank you!
