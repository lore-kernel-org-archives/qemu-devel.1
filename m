Received: from eggs.gnu.org ([2001:4830:134:3::10]:39403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRMy7-0008HF-VE
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 15:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRMy3-0005ZY-0L
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 15:22:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51950 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRMy2-0005Yy-RJ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 15:22:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76226402509A
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 19:22:34 +0000 (UTC)
References: <20180608170231.27912-1-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <acdb161e-fb99-e92c-6651-3f7850eaf64a@redhat.com>
Date: Fri, 8 Jun 2018 15:22:33 -0400
MIME-Version: 1.0
In-Reply-To: <20180608170231.27912-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Purge uses of banned g_assert_FOO()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org



On 06/08/2018 01:02 PM, Markus Armbruster wrote:
> We banned use of certain g_assert_FOO() functions outside tests, and
> made checkpatch.pl flag them (commit 6e9389563e5).  We neglected to
> purge existing uses.  Do that now.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

I've apparently got a real knack for using APIs that I ought not to.

The commit message for 6e93... makes sense, though, so this does too.

Reviewed-by: John Snow <jsnow@redhat.com>


> ---
>  hw/ide/ahci.c                 |  2 +-
>  hw/ppc/spapr_ovec.c           | 12 ++++++------
>  hw/usb/dev-smartcard-reader.c |  2 +-
>  qom/object.c                  | 10 +++++-----
>  util/qht.c                    |  2 +-
>  5 files changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 24dbad5125..75cccbea47 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -387,7 +387,7 @@ static uint64_t ahci_mem_read(void *opaque, hwaddr =
addr, unsigned size)
>      if (ofst + size <=3D 4) {
>          val =3D lo >> (ofst * 8);
>      } else {
> -        g_assert_cmpint(size, >, 1);
> +        g_assert(size > 1);
> =20
>          /* If the 64bit read is unaligned, we will produce undefined
>           * results. AHCI does not support unaligned 64bit reads. */
> diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
> index 41df4c35ba..318bf33de4 100644
> --- a/hw/ppc/spapr_ovec.c
> +++ b/hw/ppc/spapr_ovec.c
> @@ -113,7 +113,7 @@ void spapr_ovec_cleanup(sPAPROptionVector *ov)
>  void spapr_ovec_set(sPAPROptionVector *ov, long bitnr)
>  {
>      g_assert(ov);
> -    g_assert_cmpint(bitnr, <, OV_MAXBITS);
> +    g_assert(bitnr < OV_MAXBITS);
> =20
>      set_bit(bitnr, ov->bitmap);
>  }
> @@ -121,7 +121,7 @@ void spapr_ovec_set(sPAPROptionVector *ov, long bit=
nr)
>  void spapr_ovec_clear(sPAPROptionVector *ov, long bitnr)
>  {
>      g_assert(ov);
> -    g_assert_cmpint(bitnr, <, OV_MAXBITS);
> +    g_assert(bitnr < OV_MAXBITS);
> =20
>      clear_bit(bitnr, ov->bitmap);
>  }
> @@ -129,7 +129,7 @@ void spapr_ovec_clear(sPAPROptionVector *ov, long b=
itnr)
>  bool spapr_ovec_test(sPAPROptionVector *ov, long bitnr)
>  {
>      g_assert(ov);
> -    g_assert_cmpint(bitnr, <, OV_MAXBITS);
> +    g_assert(bitnr < OV_MAXBITS);
> =20
>      return test_bit(bitnr, ov->bitmap) ? true : false;
>  }
> @@ -186,7 +186,7 @@ sPAPROptionVector *spapr_ovec_parse_vector(target_u=
long table_addr, int vector)
>      int i;
> =20
>      g_assert(table_addr);
> -    g_assert_cmpint(vector, >=3D, 1); /* vector numbering starts at 1 =
*/
> +    g_assert(vector >=3D 1);      /* vector numbering starts at 1 */
> =20
>      addr =3D vector_addr(table_addr, vector);
>      if (!addr) {
> @@ -195,7 +195,7 @@ sPAPROptionVector *spapr_ovec_parse_vector(target_u=
long table_addr, int vector)
>      }
> =20
>      vector_len =3D ldub_phys(&address_space_memory, addr++) + 1;
> -    g_assert_cmpint(vector_len, <=3D, OV_MAXBYTES);
> +    g_assert(vector_len <=3D OV_MAXBYTES);
>      ov =3D spapr_ovec_new();
> =20
>      for (i =3D 0; i < vector_len; i++) {
> @@ -225,7 +225,7 @@ int spapr_ovec_populate_dt(void *fdt, int fdt_offse=
t,
>       * encoding/sizing expected in ibm,client-architecture-support
>       */
>      vec_len =3D (lastbit =3D=3D OV_MAXBITS) ? 1 : lastbit / BITS_PER_B=
YTE + 1;
> -    g_assert_cmpint(vec_len, <=3D, OV_MAXBYTES);
> +    g_assert(vec_len <=3D OV_MAXBYTES);
>      /* guest expects vector len encoded as vec_len - 1, since the leng=
th byte
>       * is assumed and not included, and the first byte of the vector
>       * is assumed as well
> diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reade=
r.c
> index 2131e33d27..13d0befd9c 100644
> --- a/hw/usb/dev-smartcard-reader.c
> +++ b/hw/usb/dev-smartcard-reader.c
> @@ -786,7 +786,7 @@ static void ccid_write_data_block(USBCCIDState *s, =
uint8_t slot, uint8_t seq,
>          DPRINTF(s, D_VERBOSE, "error %d\n", p->b.bError);
>      }
>      if (len) {
> -        g_assert_nonnull(data);
> +        assert(data);
>          memcpy(p->abData, data, len);
>      }
>      ccid_reset_error_status(s);
> diff --git a/qom/object.c b/qom/object.c
> index cb7a8cd589..794bd9a3f5 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -295,7 +295,7 @@ static void type_initialize(TypeImpl *ti)
>          GSList *e;
>          int i;
> =20
> -        g_assert_cmpint(parent->class_size, <=3D, ti->class_size);
> +        g_assert(parent->class_size <=3D ti->class_size);
>          memcpy(ti->class, parent->class, parent->class_size);
>          ti->class->interfaces =3D NULL;
>          ti->class->properties =3D g_hash_table_new_full(
> @@ -372,9 +372,9 @@ static void object_initialize_with_type(void *data,=
 size_t size, TypeImpl *type)
>      g_assert(type !=3D NULL);
>      type_initialize(type);
> =20
> -    g_assert_cmpint(type->instance_size, >=3D, sizeof(Object));
> +    g_assert(type->instance_size >=3D sizeof(Object));
>      g_assert(type->abstract =3D=3D false);
> -    g_assert_cmpint(size, >=3D, type->instance_size);
> +    g_assert(size >=3D type->instance_size);
> =20
>      memset(obj, 0, type->instance_size);
>      obj->class =3D type->class;
> @@ -475,7 +475,7 @@ static void object_finalize(void *data)
>      object_property_del_all(obj);
>      object_deinit(obj, ti);
> =20
> -    g_assert_cmpint(obj->ref, =3D=3D, 0);
> +    g_assert(obj->ref =3D=3D 0);
>      if (obj->free) {
>          obj->free(obj);
>      }
> @@ -917,7 +917,7 @@ void object_unref(Object *obj)
>      if (!obj) {
>          return;
>      }
> -    g_assert_cmpint(obj->ref, >, 0);
> +    g_assert(obj->ref > 0);
> =20
>      /* parent always holds a reference to its children */
>      if (atomic_fetch_dec(&obj->ref) =3D=3D 1) {
> diff --git a/util/qht.c b/util/qht.c
> index ff4d2e6974..55b0738cd1 100644
> --- a/util/qht.c
> +++ b/util/qht.c
> @@ -759,7 +759,7 @@ static void qht_do_resize_reset(struct qht *ht, str=
uct qht_map *new, bool reset)
>          return;
>      }
> =20
> -    g_assert_cmpuint(new->n_buckets, !=3D, old->n_buckets);
> +    g_assert(new->n_buckets !=3D old->n_buckets);
>      qht_map_iter__all_locked(ht, old, qht_map_copy, new);
>      qht_map_debug__all_locked(new);
> =20
>=20

--=20
=E2=80=94js
