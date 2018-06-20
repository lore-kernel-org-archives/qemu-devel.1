Received: from eggs.gnu.org ([2001:4830:134:3::10]:50283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVhY6-00026c-Ug
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 14:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVhY0-0005X4-VS
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 14:09:42 -0400
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
	<20180609151758.17343-5-vsementsov@virtuozzo.com>
	<899fcefc-84f1-7238-c77b-9c925c9872c5@redhat.com>
	<37e9fc1c-9c65-2121-12c9-4b648fea3947@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d297899a-5019-4d14-37fd-6d35b932d0d8@redhat.com>
Date: Wed, 20 Jun 2018 13:09:25 -0500
MIME-Version: 1.0
In-Reply-To: <37e9fc1c-9c65-2121-12c9-4b648fea3947@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 4/6] nbd/server: implement dirty bitmap
 export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On 06/20/2018 12:04 PM, Vladimir Sementsov-Ogievskiy wrote:
> 20.06.2018 19:27, Eric Blake wrote:
>> On 06/09/2018 10:17 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Handle new NBD meta namespace: "qemu", and corresponding queries:
>>> "qemu:dirty-bitmap:<export bitmap name>".
>>>
>>> With new metadata context negotiated, BLOCK_STATUS query will reply
>>> with dirty-bitmap data, converted to extents. New public function
>>> nbd_export_bitmap selects bitmap to export. For now, only one bitmap
>>> may be exported.
>>>

>> =C2=A0static int nbd_co_send_extents(NBDClient *client, uint64_t handl=
e,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBDExtent *extents, unsigned nb_exte=
nts,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBDExtent *extents, unsigned int=20
>> nb_extents,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t length, bool last,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t context_id, Error **errp=
)
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0 NBDStructuredMeta chunk;
>> @@ -1890,7 +1897,9 @@ static int nbd_co_send_extents(NBDClient=20
>> *client, uint64_t handle,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {.iov_base =3D extent=
s, .iov_len =3D nb_extents *=20
>> sizeof(extents[0])}
>> =C2=A0=C2=A0=C2=A0=C2=A0 };
>>
>> -=C2=A0=C2=A0=C2=A0 set_be_chunk(&chunk.h, 0, NBD_REPLY_TYPE_BLOCK_STA=
TUS,
>> +=C2=A0=C2=A0=C2=A0 trace_nbd_co_send_extents(handle, nb_extents, cont=
ext_id, length,=20
>> last);
>=20
> hm, length variable added only to be traced.. Ok, but a bit strange.

Yes. It doesn't affect what goes over the wire, but when it comes to=20
tracing, knowing the sum of the extents can be quite helpful (especially=20
knowing if the server's reply is shorter or longer than the client's=20
request, and the fact that when two or more contexts are negotiated by=20
the client, the different contexts can have different length replies)


>> +static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap,=20
>> uint64_t offset,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint64_t *length, NBDExtent=20
>> *extents,
>=20
> length - in-out? worth comment?

Sure.

>=20
>> + unsigned int nb_extents,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 bool dont_fragment)
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0 uint64_t begin =3D offset, end;
>> -=C2=A0=C2=A0=C2=A0 uint64_t overall_end =3D offset + length;
>> -=C2=A0=C2=A0=C2=A0 unsigned i =3D 0;
>> +=C2=A0=C2=A0=C2=A0 uint64_t overall_end =3D offset + *length;
>> +=C2=A0=C2=A0=C2=A0 unsigned int i =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmapIter *it;
>> =C2=A0=C2=A0=C2=A0=C2=A0 bool dirty;
>>
>> @@ -1983,23 +1994,25 @@ static unsigned=20
>> bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_unlock(bitmap);
>>
>> +=C2=A0=C2=A0=C2=A0 *length =3D end - begin;
>=20
> hm, it will always be zero, as at the end of the previous loop we have=20
> "begin =3D end;"

Ah, then it should be end - offset. Thanks for the careful review.

In fact, since ONLY the final extent can be larger than 2G (all earlier=20
extents were short of the overall_end, and the incoming length is=20
32-bit), but the NBD protocol says that at most one extent can go beyond=20
the original request, we do NOT want to split a >2G extent into multiple=20
extents, but rather cap it to just shy of 4G at the granularity offered=20
by the bitmap itself.  At which point add_extents() never returns more=20
than 1, and can just be inlined.

>=20
>> return i;
>> =C2=A0}
>>
>> =C2=A0static int nbd_co_send_bitmap(NBDClient *client, uint64_t handle=
,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap, uint64_t offse=
t,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t length, bool dont_fragment,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t length, bool dont_fragment,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t context_id, Error **errp)
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> -=C2=A0=C2=A0=C2=A0 unsigned nb_extents =3D dont_fragment ? 1 : NBD_MA=
X_BITMAP_EXTENTS;
>> +=C2=A0=C2=A0=C2=A0 unsigned int nb_extents =3D dont_fragment ? 1 :=20
>> NBD_MAX_BITMAP_EXTENTS;
>> =C2=A0=C2=A0=C2=A0=C2=A0 NBDExtent *extents =3D g_new(NBDExtent, nb_ex=
tents);
>> +=C2=A0=C2=A0=C2=A0 uint64_t final_length =3D length;
>>
>> -=C2=A0=C2=A0=C2=A0 nb_extents =3D bitmap_to_extents(bitmap, offset, l=
ength, extents,=20
>> nb_extents,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dont_fragmen=
t);
>> +=C2=A0=C2=A0=C2=A0 nb_extents =3D bitmap_to_extents(bitmap, offset, &=
final_length,=20
>> extents,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nb_extents, =
dont_fragment);
>>
>> -=C2=A0=C2=A0=C2=A0 ret =3D nbd_co_send_extents(client, handle, extent=
s, nb_extents,=20
>> context_id,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errp);
>> +=C2=A0=C2=A0=C2=A0 ret =3D nbd_co_send_extents(client, handle, extent=
s, nb_extents,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 final_length, true, context_id, errp);
>=20
> hmm in-out pointer field only to trace final_length? may be just trace=20
> it in bitmap_to_extents?

No, because base:allocation also benefits from tracing final_length.

>=20
> also, it's not trivial, that the function now sends FLAG_DONE. I think,=
=20
> worth add a comment, or
> a parameter like for nbd_co_send_block_status. It will simplify=20
> introducing new contexts in future.

Do we anticipate adding any in the near future? But adding a parameter=20
that is always true so that the callsite becomes more obvious on when to=20
pass the done flag may indeed make future additions easier to spot in=20
one place.

So here's what else I'll squash in:

diff --git i/nbd/server.c w/nbd/server.c
index e84aea6cf03..7a96b296839 100644
--- i/nbd/server.c
+++ w/nbd/server.c
@@ -1881,9 +1881,10 @@ static int=20
blockstatus_to_extent_be(BlockDriverState *bs, uint64_t offset,

  /* nbd_co_send_extents
   *
- * @last controls whether NBD_REPLY_FLAG_DONE is sent.
- *
- * @extents should already be in big-endian format.
+ * @length is only for tracing purposes (and may be smaller or larger
+ * than the client's original request). @last controls whether
+ * NBD_REPLY_FLAG_DONE is sent. @extents should already be in
+ * big-endian format.
   */
  static int nbd_co_send_extents(NBDClient *client, uint64_t handle,
                                 NBDExtent *extents, unsigned int=20
nb_extents,
@@ -1925,33 +1926,12 @@ static int nbd_co_send_block_status(NBDClient=20
*client, uint64_t handle,
                                 context_id, errp);
  }

-/* Set several extents, describing region of given @length with given=20
@flags.
- * Do not set more than @nb_extents, return number of set extents.
+/*
+ * Populate @extents from a dirty bitmap. Unless @dont_fragment, the
+ * final extent may exceed the original @length. Store in @length the
+ * byte length encoded (which may be smaller or larger than the
+ * original), and return the number of extents used.
   */
-static unsigned int add_extents(NBDExtent *extents, unsigned nb_extents,
-                                uint64_t length, uint32_t flags)
-{
-    unsigned int i =3D 0;
-    uint32_t max_extent =3D 0x80000000U;
-    uint32_t max_extent_be =3D cpu_to_be32(max_extent);
-    uint32_t flags_be =3D cpu_to_be32(flags);
-
-    for (i =3D 0; i < nb_extents && length > max_extent;
-         i++, length -=3D max_extent)
-    {
-        extents[i].length =3D max_extent_be;
-        extents[i].flags =3D flags_be;
-    }
-
-    if (length > 0 && i < nb_extents) {
-        extents[i].length =3D cpu_to_be32(length);
-        extents[i].flags =3D flags_be;
-        i++;
-    }
-
-    return i;
-}
-
  static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap,=20
uint64_t offset,
                                        uint64_t *length, NBDExtent=20
*extents,
                                        unsigned int nb_extents,
@@ -1976,16 +1956,18 @@ static unsigned int=20
bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
              end =3D bdrv_dirty_iter_next(it);
          }
          if (end =3D=3D -1) {
-            end =3D bdrv_dirty_bitmap_size(bitmap);
+            /* Cap to an aligned value < 4G beyond begin. */
+            end =3D MIN(bdrv_dirty_bitmap_size(bitmap),
+                      begin + 0x100000000ULL -
+                      bdrv_dirty_bitmap_granularity(bitmap));
          }
          if (dont_fragment && end > overall_end) {
-            /* We MUST not exceed requested region if=20
NBD_CMD_FLAG_REQ_ONE flag
-             * is set */
              end =3D overall_end;
          }

-        i +=3D add_extents(extents + i, nb_extents - i, end - begin,
-                         dirty ? NBD_STATE_DIRTY : 0);
+        extents[i].length =3D cpu_to_be32(end - begin);
+        extents[i].flags =3D cpu_to_be32(dirty ? NBD_STATE_DIRTY : 0);
+        i++;
          begin =3D end;
          dirty =3D !dirty;
      }
@@ -1994,13 +1976,13 @@ static unsigned int=20
bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,

      bdrv_dirty_bitmap_unlock(bitmap);

-    *length =3D end - begin;
+    *length =3D end - offset;
      return i;
  }

  static int nbd_co_send_bitmap(NBDClient *client, uint64_t handle,
                                BdrvDirtyBitmap *bitmap, uint64_t offset,
-                              uint32_t length, bool dont_fragment,
+                              uint32_t length, bool dont_fragment, bool=20
last,
                                uint32_t context_id, Error **errp)
  {
      int ret;
@@ -2012,7 +1994,7 @@ static int nbd_co_send_bitmap(NBDClient *client,=20
uint64_t handle,
                                     nb_extents, dont_fragment);

      ret =3D nbd_co_send_extents(client, handle, extents, nb_extents,
-                              final_length, true, context_id, errp);
+                              final_length, last, context_id, errp);

      g_free(extents);

@@ -2253,7 +2235,7 @@ static coroutine_fn int=20
nbd_handle_request(NBDClient *client,
                                           client->exp->export_bitmap,
                                           request->from, request->len,
                                           request->flags &=20
NBD_CMD_FLAG_REQ_ONE,
-                                         NBD_META_ID_DIRTY_BITMAP, errp)=
;
+                                         true,=20
NBD_META_ID_DIRTY_BITMAP, errp);
                  if (ret < 0) {
                      return ret;
                  }


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
