Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97583C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FC9120781
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAohCaIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC9120781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRbq3-0001Od-Fr
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 09:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRbpF-0000nv-Lw
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRbpD-0000bp-HH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:23:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36156
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jRbpD-0000bU-1R
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587648208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nBH3YsLIAwZO/7MbFlEYTZynAvmNcFIfG78D0VUovvs=;
 b=ZAohCaISJGXngmzM2TBgoFF+oiRkpct3aHQbfhldZHUOAr9dxIvioiWcsROsbnkfMbo57O
 wVQxsyZTIbldL4SR4XAycvO210i/TAGp/Z9Ng/s5IinLQrDY9hKoSMGb6sYrlcYPY/kl+N
 3DmBEooioJ8hlJ0DaOGNYzFyFPQLV4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-Dt95i3JgM8yRkJkzQy95_w-1; Thu, 23 Apr 2020 09:23:27 -0400
X-MC-Unique: Dt95i3JgM8yRkJkzQy95_w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 942C718FF67B;
 Thu, 23 Apr 2020 13:23:06 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-28.ams2.redhat.com [10.36.114.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26D785C1BE;
 Thu, 23 Apr 2020 13:23:03 +0000 (UTC)
Date: Thu, 23 Apr 2020 15:23:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 4/9] qcow2: Support BDRV_REQ_ZERO_WRITE for truncate
Message-ID: <20200423132302.GA23654@linux.fritz.box>
References: <20200422152129.167074-1-kwolf@redhat.com>
 <20200422152129.167074-5-kwolf@redhat.com>
 <84c6ca49-aef3-adf4-2efe-68357dd20ce8@redhat.com>
 <20200422155835.GC7155@linux.fritz.box>
 <20d12788-2d62-12a4-0949-f29594054026@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20d12788-2d62-12a4-0949-f29594054026@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: vsementsov@virtuozzo.com, berto@igalia.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 22.04.2020 um 18:14 hat Eric Blake geschrieben:
> On 4/22/20 10:58 AM, Kevin Wolf wrote:
>=20
> > > > @@ -4214,6 +4215,35 @@ static int coroutine_fn qcow2_co_truncate(Bl=
ockDriverState *bs, int64_t offset,
> > > >            g_assert_not_reached();
> > > >        }
> > > > +    if ((flags & BDRV_REQ_ZERO_WRITE) && offset > old_length) {
> > > > +        uint64_t zero_start =3D QEMU_ALIGN_UP(old_length, s->clust=
er_size);
> > > > +        uint64_t zero_end =3D QEMU_ALIGN_UP(offset, s->cluster_siz=
e);
> > >=20
> > > This rounds up beyond the new size...
> > >=20
> > > > +
> > > > +        /* Use zero clusters as much as we can */
> > > > +        ret =3D qcow2_cluster_zeroize(bs, zero_start, zero_end - z=
ero_start, 0);
> > >=20
> > > and then requests that the extra be zeroed.  Does that always work, e=
ven
> > > when it results in pdrv_co_pwrite_zeroes beyond the end of s->data_fi=
le?
> >=20
> > You mean the data_file_is_raw() path in qcow2_cluster_zeroize()? It's
> > currently not a code path that is run because we only set
> > BDRV_REQ_ZERO_WRITE for truncate if the image has a backing file, and
> > data_file_is_raw() doesn't work with backing files.
>=20
> Good point.
>=20
> >=20
> > But hypothetically, if someone called truncate with BDRV_REQ_ZERO_WRITE
> > for such a file, I think it would fail.
> >=20
> > > If so,
> > >=20
> > > Reviewed-by: Eric Blake <eblake@redhat.com>
> > >=20
> > > otherwise, you may have to treat the tail specially, the same way you
> > > treated an unaligned head.
> >=20
> > Actually, do I even need to round the tail?
> >=20
> >      /* Caller must pass aligned values, except at image end */
> >      assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
> >      assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
> >             end_offset =3D=3D bs->total_sectors << BDRV_SECTOR_BITS);
> >=20
> > So qcow2_cluster_zeroize() seems to accept the unaligned tail. It would
> > still set the zero flag for the partial last cluster and for the
> > external data file, bdrv_co_pwrite_zeroes() would have the correct size=
.
>=20
> Then I'm in favor of NOT rounding the tail.  That's an easy enough change
> and we've now justified that it does what we want, so R-b stands with tha=
t
> one-line tweak.

Would have been too easy... bs->total_sectors isn't updated yet, so the
assertion does fail.

I can make the assertion check end_offset >=3D ... instead. That should
still check what we wanted to check here and allow the unaligned
extension.

This feels like the better option to me compared to updating
bs->total_sectors earlier and then undoing that change in every error
path.

Kevin


