Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5BEC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00726222C9
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XaQxHgGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00726222C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUtbl-0002o7-4d
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 09:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iUtam-0002LI-Tu
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:25:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iUtal-0002Pd-J7
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:25:56 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:60610)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iUtak-0002Jj-Ve; Wed, 13 Nov 2019 09:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=fo9fXrt/4QKP5axhScAZ9lsv1vh7e+e52quUdpTznIE=; 
 b=XaQxHgGw3F9HrQPEM80TDX2jske9jOfEytgrptmfLq6PrxaiwE0kuyZ++EwJEb/gUfIVb7sfHPIy9B81lY72hpRSlzd9aJOdMiAv5sdcoj0NuopWICxK2wCCJEdOflZMaODVJJXyVjjULSm3xXbkGIxr+4c97Z0WesoOpCjrKPyrt91+uTHBKELztzMUNOSLOlsZkBMwW/+/iUejz/AoDxXsc9e0PlUMm181pvw0z1CZBFdAAN7/7Ry5zWmkMQZVbOWlecmaxxAG8JDJq7RdCNAnvLZBSiEf2SIAEj375qI0dDppIxqb6v10Vzew+B5O+7cV5/vsejhhRkrnO1KlBw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iUtaP-0003SO-SI; Wed, 13 Nov 2019 15:25:33 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1iUtaP-0006be-Pj; Wed, 13 Nov 2019 15:25:33 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2 03/26] qcow2: Process QCOW2_CLUSTER_ZERO_ALLOC
 clusters in handle_copied()
In-Reply-To: <7daa553e-b74c-3573-5b67-e140436deb7a@redhat.com>
References: <cover.1572125022.git.berto@igalia.com>
 <fe73f28b44ecaea8a0104e11078f38f563da5925.1572125022.git.berto@igalia.com>
 <7daa553e-b74c-3573-5b67-e140436deb7a@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 13 Nov 2019 15:25:33 +0100
Message-ID: <w515zjn26qq.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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

On Wed 30 Oct 2019 03:24:08 PM CET, Max Reitz wrote:
>>  static void calculate_l2_meta(BlockDriverState *bs, uint64_t host_offse=
t,
>>                                uint64_t guest_offset, uint64_t bytes,
>> -                              QCowL2Meta **m, bool keep_old)
>> +                              uint64_t *l2_slice, QCowL2Meta **m, bool =
keep_old)
>>  {
>>      BDRVQcow2State *s =3D bs->opaque;
>> -    unsigned cow_start_from =3D 0;
>> +    int l2_index =3D offset_to_l2_slice_index(s, guest_offset);
>> +    uint64_t l2_entry;
>> +    unsigned cow_start_from, cow_end_to;
>>      unsigned cow_start_to =3D offset_into_cluster(s, guest_offset);
>>      unsigned cow_end_from =3D cow_start_to + bytes;
>> -    unsigned cow_end_to =3D ROUND_UP(cow_end_from, s->cluster_size);
>>      unsigned nb_clusters =3D size_to_clusters(s, cow_end_from);
>>      QCowL2Meta *old_m =3D *m;
>> +    QCow2ClusterType type;
>> +
>> +    /* Return if there's no COW (all clusters are normal and we keep th=
em) */
>> +    if (keep_old) {
>> +        int i;
>> +        for (i =3D 0; i < nb_clusters; i++) {
>> +            l2_entry =3D be64_to_cpu(l2_slice[l2_index + i]);
>
> I=E2=80=99d assert somewhere that l2_index + nb_clusters - 1 won=E2=80=99=
t overflow.
>
>> +            if (qcow2_get_cluster_type(bs, l2_entry) !=3D QCOW2_CLUSTER=
_NORMAL) {
>
> Wouldn=E2=80=99t cluster_needs_cow() be better?

The semantics of cluster_needs_cow() change in this patch (which also
updates the documentation). But I should maybe change the name instead.

>> +                break;
>> +            }
>> +        }
>> +        if (i =3D=3D nb_clusters) {
>> +            return;
>> +        }
>> +    }
>
> So I understand we always need to create an L2Meta structure in all
> other cases because we at least need to turn those clusters into
> normal clusters?  (Even if they=E2=80=99re already allocated, as in the c=
ase
> of allocated zero clusters.)

That's correct.

>> -/* Returns true if writing to a cluster requires COW */
>> +/* Returns true if the cluster is unallocated or has refcount > 1 */
>>  static bool cluster_needs_cow(BlockDriverState *bs, uint64_t l2_entry)
>>  {
>>      switch (qcow2_get_cluster_type(bs, l2_entry)) {
>>      case QCOW2_CLUSTER_NORMAL:
>> +    case QCOW2_CLUSTER_ZERO_ALLOC:
>>          if (l2_entry & QCOW_OFLAG_COPIED) {
>>              return false;
>
> Don=E2=80=99t zero-allocated clusters need COW always?  (Because the at t=
he
> given host offset isn=E2=80=99t guaranteed to be zero.)

Yeah, hence the semantics change I described earlier. I should probably
call it cluster_needs_new_allocation() or something like that, which is
what this means now ("true if unallocated or refcount > 1").

>> - * Returns the number of contiguous clusters that can be used for an al=
locating
>> - * write, but require COW to be performed (this includes yet unallocate=
d space,
>> - * which must copy from the backing file)
>> + * Returns the number of contiguous clusters that can be written to
>> + * using one single write request, starting from @l2_index.
>> + * At most @nb_clusters are checked.
>> + *
>> + * If @want_cow is true this counts clusters that are either
>> + * unallocated, or allocated but with refcount > 1.
>
> +(So they need to be newly allocated and COWed)?

Yes. Which in this context is the same as "newly allocated" I guess,
because every newly allocated cluster requires COW.

> (Or is the past participle of COW COWn?  Or maybe CedOW?)

:-))

>> + * If @want_cow is false this counts clusters that are already
>> + * allocated and can be written to using their current locations
>
> s/using their current locations/in-place/?

Ok.

>> @@ -1475,13 +1489,14 @@ static int handle_alloc(BlockDriverState *bs, ui=
nt64_t guest_offset,
>>      *bytes =3D MIN(*bytes, nb_bytes - offset_into_cluster(s, guest_offs=
et));
>>      assert(*bytes !=3D 0);
>>=20=20
>> -    calculate_l2_meta(bs, alloc_cluster_offset, guest_offset, *bytes,
>> -                      m, keep_old_clusters);
>> +    calculate_l2_meta(bs, alloc_cluster_offset, guest_offset, *bytes, l=
2_slice,
>> +                      m, false);
>>=20=20
>> -    return 1;
>> +    ret =3D 1;
>>=20=20
>> -fail:
>> -    if (*m && (*m)->nb_clusters > 0) {
>> +out:
>> +    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
>
> Is this a bug fix?

No, we call qcow2_cache_put() later because calculate_l2_meta() needs
l2_slice.

Berto

