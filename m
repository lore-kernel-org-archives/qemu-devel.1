Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B084CA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58782087E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7ObotMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58782087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPoui-00061a-U9
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 10:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iPotb-0004fQ-AM
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iPotY-0004k0-CY
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:24:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42345
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iPotX-0004ge-UV
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572445459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=plkJY0C/aZf78lmD1aV0GSNuoekGyo1Fnt/0bDkTTEY=;
 b=f7ObotMkVlL5ixeigv59PX6aukYyCWKJVb3TXSzsY6nxMipX81R+Be17EOljut4va7mC5f
 6Kg0XdFXHK8Iv7i14CDR1flI9HPtcPOGtye1rWBa5m01tJAqj5Rj27Y6StJ7JStoeZIGHJ
 yAOc83h+Mq2+DGgUGWsmqEPjviM2ioo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-TuzqJk3IN3WY6SjDcWbAiQ-1; Wed, 30 Oct 2019 10:24:14 -0400
X-MC-Unique: TuzqJk3IN3WY6SjDcWbAiQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70D351005509;
 Wed, 30 Oct 2019 14:24:12 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-147.ams2.redhat.com
 [10.36.117.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A85BB5D713;
 Wed, 30 Oct 2019 14:24:09 +0000 (UTC)
Subject: Re: [RFC PATCH v2 03/26] qcow2: Process QCOW2_CLUSTER_ZERO_ALLOC
 clusters in handle_copied()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1572125022.git.berto@igalia.com>
 <fe73f28b44ecaea8a0104e11078f38f563da5925.1572125022.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <7daa553e-b74c-3573-5b67-e140436deb7a@redhat.com>
Date: Wed, 30 Oct 2019 15:24:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <fe73f28b44ecaea8a0104e11078f38f563da5925.1572125022.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aPNGd6XBQxExpsGtHpoyPavmTX05kcMzK"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aPNGd6XBQxExpsGtHpoyPavmTX05kcMzK
Content-Type: multipart/mixed; boundary="EsCPfOW89gs68CLvtF5utEeum2fIsf16T"

--EsCPfOW89gs68CLvtF5utEeum2fIsf16T
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.10.19 23:25, Alberto Garcia wrote:
> When writing to a qcow2 file there are two functions that take a
> virtual offset and return a host offset, possibly allocating new
> clusters if necessary:
>=20
>    - handle_copied() looks for normal data clusters that are already
>      allocated and have a reference count of 1. In those clusters we
>      can simply write the data and there is no need to perform any
>      copy-on-write.
>=20
>    - handle_alloc() looks for clusters that do need copy-on-write,
>      either because they haven't been allocated yet, because their
>      reference count is !=3D 1 or because they are ZERO_ALLOC clusters.
>=20
> The ZERO_ALLOC case is a bit special because those are clusters that
> are already allocated and they could perfectly be dealt with in
> handle_copied() (as long as copy-on-write is performed when required).
>=20
> In fact, there is extra code specifically for them in handle_alloc()
> that tries to reuse the existing allocation if possible and frees them
> otherwise.
>=20
> This patch changes the handling of ZERO_ALLOC clusters so the
> semantics of these two functions are now like this:
>=20
>    - handle_copied() looks for clusters that are already allocated and
>      which we can overwrite (NORMAL and ZERO_ALLOC clusters with a
>      reference count of 1).
>=20
>    - handle_alloc() looks for clusters for which we need a new
>      allocation (all other cases).
>=20
> One importante difference after this change is that clusters found in
> handle_copied() may now require copy-on-write, but this will be anyway
> necessary once we add support for subclusters.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 177 +++++++++++++++++++++++-------------------
>  1 file changed, 96 insertions(+), 81 deletions(-)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index aa1010a515..ee6b46f917 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1021,7 +1021,8 @@ void qcow2_alloc_cluster_abort(BlockDriverState *bs=
, QCowL2Meta *m)
> =20
>  /*
>   * For a given write request, create a new QCowL2Meta structure and
> - * add it to @m.
> + * add it to @m. If the write request does not need copy-on-write or
> + * changes to the L2 metadata then this function does nothing.
>   *
>   * @host_offset points to the beginning of the first cluster.
>   *
> @@ -1034,15 +1035,51 @@ void qcow2_alloc_cluster_abort(BlockDriverState *=
bs, QCowL2Meta *m)
>   */
>  static void calculate_l2_meta(BlockDriverState *bs, uint64_t host_offset=
,
>                                uint64_t guest_offset, uint64_t bytes,
> -                              QCowL2Meta **m, bool keep_old)
> +                              uint64_t *l2_slice, QCowL2Meta **m, bool k=
eep_old)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
> -    unsigned cow_start_from =3D 0;
> +    int l2_index =3D offset_to_l2_slice_index(s, guest_offset);
> +    uint64_t l2_entry;
> +    unsigned cow_start_from, cow_end_to;
>      unsigned cow_start_to =3D offset_into_cluster(s, guest_offset);
>      unsigned cow_end_from =3D cow_start_to + bytes;
> -    unsigned cow_end_to =3D ROUND_UP(cow_end_from, s->cluster_size);
>      unsigned nb_clusters =3D size_to_clusters(s, cow_end_from);
>      QCowL2Meta *old_m =3D *m;
> +    QCow2ClusterType type;
> +
> +    /* Return if there's no COW (all clusters are normal and we keep the=
m) */
> +    if (keep_old) {
> +        int i;
> +        for (i =3D 0; i < nb_clusters; i++) {
> +            l2_entry =3D be64_to_cpu(l2_slice[l2_index + i]);

I=E2=80=99d assert somewhere that l2_index + nb_clusters - 1 won=E2=80=99t =
overflow.

> +            if (qcow2_get_cluster_type(bs, l2_entry) !=3D QCOW2_CLUSTER_=
NORMAL) {

Wouldn=E2=80=99t cluster_needs_cow() be better?

> +                break;
> +            }
> +        }
> +        if (i =3D=3D nb_clusters) {
> +            return;
> +        }
> +    }

So I understand we always need to create an L2Meta structure in all
other cases because we at least need to turn those clusters into normal
clusters?  (Even if they=E2=80=99re already allocated, as in the case of
allocated zero clusters.)

> +
> +    /* Get the L2 entry from the first cluster */
> +    l2_entry =3D be64_to_cpu(l2_slice[l2_index]);
> +    type =3D qcow2_get_cluster_type(bs, l2_entry);
> +
> +    if (type =3D=3D QCOW2_CLUSTER_NORMAL && keep_old) {
> +        cow_start_from =3D cow_start_to;
> +    } else {
> +        cow_start_from =3D 0;
> +    }
> +
> +    /* Get the L2 entry from the last cluster */
> +    l2_entry =3D be64_to_cpu(l2_slice[l2_index + nb_clusters - 1]);
> +    type =3D qcow2_get_cluster_type(bs, l2_entry);
> +
> +    if (type =3D=3D QCOW2_CLUSTER_NORMAL && keep_old) {
> +        cow_end_to =3D cow_end_from;
> +    } else {
> +        cow_end_to =3D ROUND_UP(cow_end_from, s->cluster_size);
> +    }
> =20
>      *m =3D g_malloc0(sizeof(**m));
>      **m =3D (QCowL2Meta) {
> @@ -1068,18 +1105,18 @@ static void calculate_l2_meta(BlockDriverState *b=
s, uint64_t host_offset,
>      QLIST_INSERT_HEAD(&s->cluster_allocs, *m, next_in_flight);
>  }
> =20
> -/* Returns true if writing to a cluster requires COW */
> +/* Returns true if the cluster is unallocated or has refcount > 1 */
>  static bool cluster_needs_cow(BlockDriverState *bs, uint64_t l2_entry)
>  {
>      switch (qcow2_get_cluster_type(bs, l2_entry)) {
>      case QCOW2_CLUSTER_NORMAL:
> +    case QCOW2_CLUSTER_ZERO_ALLOC:
>          if (l2_entry & QCOW_OFLAG_COPIED) {
>              return false;

Don=E2=80=99t zero-allocated clusters need COW always?  (Because the at the
given host offset isn=E2=80=99t guaranteed to be zero.)

>          }
>      case QCOW2_CLUSTER_UNALLOCATED:
>      case QCOW2_CLUSTER_COMPRESSED:
>      case QCOW2_CLUSTER_ZERO_PLAIN:
> -    case QCOW2_CLUSTER_ZERO_ALLOC:
>          return true;
>      default:
>          abort();
> @@ -1087,20 +1124,34 @@ static bool cluster_needs_cow(BlockDriverState *b=
s, uint64_t l2_entry)
>  }
> =20
>  /*
> - * Returns the number of contiguous clusters that can be used for an all=
ocating
> - * write, but require COW to be performed (this includes yet unallocated=
 space,
> - * which must copy from the backing file)
> + * Returns the number of contiguous clusters that can be written to
> + * using one single write request, starting from @l2_index.
> + * At most @nb_clusters are checked.
> + *
> + * If @want_cow is true this counts clusters that are either
> + * unallocated, or allocated but with refcount > 1.

+(So they need to be newly allocated and COWed)?

(Or is the past participle of COW COWn?  Or maybe CedOW?)

> + *
> + * If @want_cow is false this counts clusters that are already
> + * allocated and can be written to using their current locations

s/using their current locations/in-place/?

> + * (including QCOW2_CLUSTER_ZERO_ALLOC).
>   */
>  static int count_cow_clusters(BlockDriverState *bs, int nb_clusters,

Hm, well, it=E2=80=99s not really cow anymore.  Would
count_single_write_clusters() work?

> -    uint64_t *l2_slice, int l2_index)
> +                              uint64_t *l2_slice, int l2_index, bool wan=
t_cow)
>  {
> +    BDRVQcow2State *s =3D bs->opaque;
> +    uint64_t l2_entry =3D be64_to_cpu(l2_slice[l2_index]);
> +    uint64_t expected_offset =3D l2_entry & L2E_OFFSET_MASK;
>      int i;
> =20
>      for (i =3D 0; i < nb_clusters; i++) {
> -        uint64_t l2_entry =3D be64_to_cpu(l2_slice[l2_index + i]);
> -        if (!cluster_needs_cow(bs, l2_entry)) {
> +        l2_entry =3D be64_to_cpu(l2_slice[l2_index + i]);
> +        if (cluster_needs_cow(bs, l2_entry) !=3D want_cow) {
>              break;
>          }
> +        if (!want_cow && expected_offset !=3D (l2_entry & L2E_OFFSET_MAS=
K)) {
> +            break;
> +        }
> +        expected_offset +=3D s->cluster_size;
>      }
> =20
>      assert(i <=3D nb_clusters);
> @@ -1228,18 +1279,17 @@ static int handle_copied(BlockDriverState *bs, ui=
nt64_t guest_offset,
> =20
>      cluster_offset =3D be64_to_cpu(l2_slice[l2_index]);
> =20
> -    /* Check how many clusters are already allocated and don't need COW =
*/
> -    if (qcow2_get_cluster_type(bs, cluster_offset) =3D=3D QCOW2_CLUSTER_=
NORMAL
> -        && (cluster_offset & QCOW_OFLAG_COPIED))
> -    {
> +    if (!cluster_needs_cow(bs, cluster_offset)) {
>          /* If a specific host_offset is required, check it */
>          bool offset_matches =3D
>              (cluster_offset & L2E_OFFSET_MASK) =3D=3D *host_offset;
> =20
>          if (offset_into_cluster(s, cluster_offset & L2E_OFFSET_MASK)) {
> -            qcow2_signal_corruption(bs, true, -1, -1, "Data cluster offs=
et "
> +            qcow2_signal_corruption(bs, true, -1, -1, "%s cluster offset=
 "
>                                      "%#llx unaligned (guest offset: %#" =
PRIx64
> -                                    ")", cluster_offset & L2E_OFFSET_MAS=
K,
> +                                    ")", cluster_offset & QCOW_OFLAG_ZER=
O ?
> +                                    "Preallocated zero" : "Data",
> +                                    cluster_offset & L2E_OFFSET_MASK,
>                                      guest_offset);
>              ret =3D -EIO;
>              goto out;
> @@ -1252,15 +1302,17 @@ static int handle_copied(BlockDriverState *bs, ui=
nt64_t guest_offset,
>          }
> =20
>          /* We keep all QCOW_OFLAG_COPIED clusters */
> -        keep_clusters =3D
> -            count_contiguous_clusters(bs, nb_clusters, s->cluster_size,
> -                                      &l2_slice[l2_index],
> -                                      QCOW_OFLAG_COPIED | QCOW_OFLAG_ZER=
O);
> +        keep_clusters =3D count_cow_clusters(bs, nb_clusters, l2_slice,
> +                                           l2_index, false);
>          assert(keep_clusters <=3D nb_clusters);
> =20
>          *bytes =3D MIN(*bytes,
>                   keep_clusters * s->cluster_size
>                   - offset_into_cluster(s, guest_offset));
> +        assert(*bytes !=3D 0);
> +
> +        calculate_l2_meta(bs, cluster_offset & L2E_OFFSET_MASK, guest_of=
fset,
> +                          *bytes, l2_slice, m, true);

We wouldn=E2=80=99t need calculate_l2_meta() here if the clusters really al=
l
didn=E2=80=99t need COW.

We do need it because cluster_needs_cow() returns false for zero
clusters, which isn=E2=80=99t what the function name says.

> =20
>          ret =3D 1;
>      } else {
> @@ -1361,12 +1413,10 @@ static int handle_alloc(BlockDriverState *bs, uin=
t64_t guest_offset,
>      BDRVQcow2State *s =3D bs->opaque;
>      int l2_index;
>      uint64_t *l2_slice;
> -    uint64_t entry;
>      uint64_t nb_clusters;
>      int ret;
> -    bool keep_old_clusters =3D false;
> =20
> -    uint64_t alloc_cluster_offset =3D INV_OFFSET;
> +    uint64_t alloc_cluster_offset;
> =20
>      trace_qcow2_handle_alloc(qemu_coroutine_self(), guest_offset, *host_=
offset,
>                               *bytes);
> @@ -1392,67 +1442,31 @@ static int handle_alloc(BlockDriverState *bs, uin=
t64_t guest_offset,
>          return ret;
>      }
> =20
> -    entry =3D be64_to_cpu(l2_slice[l2_index]);
> -    nb_clusters =3D count_cow_clusters(bs, nb_clusters, l2_slice, l2_ind=
ex);
> +    nb_clusters =3D count_cow_clusters(bs, nb_clusters, l2_slice, l2_ind=
ex, true);
> =20
>      /* This function is only called when there were no non-COW clusters,=
 so if
>       * we can't find any unallocated or COW clusters either, something i=
s
>       * wrong with our code. */
>      assert(nb_clusters > 0);
> =20
> -    if (qcow2_get_cluster_type(bs, entry) =3D=3D QCOW2_CLUSTER_ZERO_ALLO=
C &&
> -        (entry & QCOW_OFLAG_COPIED) &&
> -        (*host_offset =3D=3D INV_OFFSET ||
> -         start_of_cluster(s, *host_offset) =3D=3D (entry & L2E_OFFSET_MA=
SK)))
> -    {
> -        int preallocated_nb_clusters;
> -
> -        if (offset_into_cluster(s, entry & L2E_OFFSET_MASK)) {
> -            qcow2_signal_corruption(bs, true, -1, -1, "Preallocated zero=
 "
> -                                    "cluster offset %#llx unaligned (gue=
st "
> -                                    "offset: %#" PRIx64 ")",
> -                                    entry & L2E_OFFSET_MASK, guest_offse=
t);
> -            ret =3D -EIO;
> -            goto fail;
> -        }
> -
> -        /* Try to reuse preallocated zero clusters; contiguous normal cl=
usters
> -         * would be fine, too, but count_cow_clusters() above has limite=
d
> -         * nb_clusters already to a range of COW clusters */
> -        preallocated_nb_clusters =3D
> -            count_contiguous_clusters(bs, nb_clusters, s->cluster_size,
> -                                      &l2_slice[l2_index], QCOW_OFLAG_CO=
PIED);
> -        assert(preallocated_nb_clusters > 0);
> -
> -        nb_clusters =3D preallocated_nb_clusters;
> -        alloc_cluster_offset =3D entry & L2E_OFFSET_MASK;
> -
> -        /* We want to reuse these clusters, so qcow2_alloc_cluster_link_=
l2()
> -         * should not free them. */
> -        keep_old_clusters =3D true;
> +    /* Allocate, if necessary at a given offset in the image file */

Well, it=E2=80=99s always necessary now.

> +    alloc_cluster_offset =3D *host_offset =3D=3D INV_OFFSET ? INV_OFFSET=
 :
> +        start_of_cluster(s, *host_offset);
> +    ret =3D do_alloc_cluster_offset(bs, guest_offset, &alloc_cluster_off=
set,
> +                                  &nb_clusters);
> +    if (ret < 0) {
> +        goto out;
>      }
> =20
> -    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
> -
> -    if (alloc_cluster_offset =3D=3D INV_OFFSET) {
> -        /* Allocate, if necessary at a given offset in the image file */
> -        alloc_cluster_offset =3D *host_offset =3D=3D INV_OFFSET ? INV_OF=
FSET :
> -                               start_of_cluster(s, *host_offset);
> -        ret =3D do_alloc_cluster_offset(bs, guest_offset, &alloc_cluster=
_offset,
> -                                      &nb_clusters);
> -        if (ret < 0) {
> -            goto fail;
> -        }
> -
> -        /* Can't extend contiguous allocation */
> -        if (nb_clusters =3D=3D 0) {
> -            *bytes =3D 0;
> -            return 0;
> -        }
> -
> -        assert(alloc_cluster_offset !=3D INV_OFFSET);
> +    /* Can't extend contiguous allocation */
> +    if (nb_clusters =3D=3D 0) {
> +        *bytes =3D 0;
> +        ret =3D 0;
> +        goto out;
>      }
> =20
> +    assert(alloc_cluster_offset !=3D INV_OFFSET);
> +
>      /*
>       * Save info needed for meta data update.
>       *
> @@ -1475,13 +1489,14 @@ static int handle_alloc(BlockDriverState *bs, uin=
t64_t guest_offset,
>      *bytes =3D MIN(*bytes, nb_bytes - offset_into_cluster(s, guest_offse=
t));
>      assert(*bytes !=3D 0);
> =20
> -    calculate_l2_meta(bs, alloc_cluster_offset, guest_offset, *bytes,
> -                      m, keep_old_clusters);
> +    calculate_l2_meta(bs, alloc_cluster_offset, guest_offset, *bytes, l2=
_slice,
> +                      m, false);
> =20
> -    return 1;
> +    ret =3D 1;
> =20
> -fail:
> -    if (*m && (*m)->nb_clusters > 0) {
> +out:
> +    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);

Is this a bug fix?

Max

> +    if (ret < 0 && *m && (*m)->nb_clusters > 0) {
>          QLIST_REMOVE(*m, next_in_flight);
>      }
>      return ret;
>=20



--EsCPfOW89gs68CLvtF5utEeum2fIsf16T--

--aPNGd6XBQxExpsGtHpoyPavmTX05kcMzK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl25nQgACgkQ9AfbAGHV
z0ANVQf/T+X4KDUXRc1s6tQ88tFC/BpPUmhjqT4xrKyx79DXQWaHd0xe66T/mVHj
gUgwvN14sIvuOm0Jq+OGFp9kwIVn57vDuRkqyl9vfgHo4AzgEDjn8PstBXvzhq0D
/mF2lhukVVAlcI/YsVSNObD0/+3mq2z67i7Qs8vV+wRcLXgRjIOydi0Jxgx28Orh
YBry6Gzbtx0QcyPnhIt2deOGFH78q7oTBUfluhdm2ayjoTRLdmcVPPdspEDU9Yx5
/VOnUNI4Hy8pjsjIUYg7UOfrKVVtcBxlJHlhW9WmnHLSWwASvDtdsDIfqNrRYXcp
n5OTnL5NB1TCtKfcNPWd8xGY4Cb3Ig==
=xrAN
-----END PGP SIGNATURE-----

--aPNGd6XBQxExpsGtHpoyPavmTX05kcMzK--


