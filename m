Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F93C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:11:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11522207ED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwCiJkbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11522207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jicAX-0006O5-B5
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 07:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jic9d-0005Iq-Cn
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:10:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39145
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jic9c-0001ob-Cr
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591701051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YaUc9EDOQ35mTac1f1OIkr0FAAbwhfJx7pPcCOjKLww=;
 b=AwCiJkbrsB69UnVLJB/En/wve/rZq7142qfoKYZs7cSXmIlzYXS3YDim4fLSwez9fMag6l
 3F1oHxBPdTDr/eVjdcw7iVp9lvJbwE7AtSba1nh1k/VRANmvUXLved4Ps5CdsQojoCeHIb
 5QP88cxhIPRH+q1sSO0ptWbBLDv8wRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-lMt9fToYNNqA2nnPPaNbHA-1; Tue, 09 Jun 2020 07:10:49 -0400
X-MC-Unique: lMt9fToYNNqA2nnPPaNbHA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89A4C1005512;
 Tue,  9 Jun 2020 11:10:48 +0000 (UTC)
Received: from localhost (ovpn-115-52.ams2.redhat.com [10.36.115.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5057C5D9C9;
 Tue,  9 Jun 2020 11:10:45 +0000 (UTC)
Date: Tue, 9 Jun 2020 12:10:44 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2] hw/virtio/vhost: re-factor vhost-section and allow
 DIRTY_MEMORY_CODE
Message-ID: <20200609111044.GD92564@stefanha-x1.localdomain>
References: <20200604134022.10564-1-alex.bennee@linaro.org>
 <20200605090334.GB59930@stefanha-x1.localdomain>
 <87o8px4xxp.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87o8px4xxp.fsf@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2020 at 11:19:30AM +0100, Alex Benn=E9e wrote:
>=20
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > On Thu, Jun 04, 2020 at 02:40:22PM +0100, Alex Benn=E9e wrote:
> >> The purpose of vhost_section is to identify RAM regions that need to
> >> be made available to a vhost client. However when running under TCG
> >> all RAM sections have DIRTY_MEMORY_CODE set which leads to problems
> >> down the line.
> >>=20
> >> Re-factor the code so:
> >>=20
> >>   - steps are clearer to follow
> >>   - reason for rejection is recorded in the trace point
> >>   - we allow DIRTY_MEMORY_CODE when TCG is enabled
> >>=20
> >> We expand the comment to explain that kernel based vhost has specific
> >> support for migration tracking.
> >>=20
> >> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> >> Cc: Michael S. Tsirkin <mst@redhat.com>
> >> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> >>=20
> >> ---
> >> v2
> >>   - drop enum, add trace_vhost_reject_section
> >>   - return false at any fail point
> >>   - unconditionally add DIRTY_MEMORY_CODE to handled cases
> >>   - slightly re-word the explanatory comment and commit message
> >> ---
> >>  hw/virtio/vhost.c      | 55 ++++++++++++++++++++++++++++++-----------=
-
> >>  hw/virtio/trace-events |  3 ++-
> >>  2 files changed, 41 insertions(+), 17 deletions(-)
> >>=20
> >> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >> index aff98a0ede5..120c0cc747b 100644
> >> --- a/hw/virtio/vhost.c
> >> +++ b/hw/virtio/vhost.c
> >> @@ -27,6 +27,7 @@
> >>  #include "migration/blocker.h"
> >>  #include "migration/qemu-file-types.h"
> >>  #include "sysemu/dma.h"
> >> +#include "sysemu/tcg.h"
> >>  #include "trace.h"
> >> =20
> >>  /* enabled until disconnected backend stabilizes */
> >> @@ -403,26 +404,48 @@ static int vhost_verify_ring_mappings(struct vho=
st_dev *dev,
> >>      return r;
> >>  }
> >> =20
> >> +/*
> >> + * vhost_section: identify sections needed for vhost access
> >> + *
> >> + * We only care about RAM sections here (where virtqueue can live). I=
f
> >
> > It's not just the virtqueue. Arbitrary guest RAM buffers can be placed
> > into the virtqueue so we need to pass all guest RAM to the vhost device
> > backend.
> >
> >> + * we find one we still allow the backend to potentially filter it ou=
t
> >> + * of our list.
> >> + */
> >>  static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection =
*section)
> >>  {
> >> -    bool result;
> >> -    bool log_dirty =3D memory_region_get_dirty_log_mask(section->mr) =
&
> >> -                     ~(1 << DIRTY_MEMORY_MIGRATION);
> >> -    result =3D memory_region_is_ram(section->mr) &&
> >> -        !memory_region_is_rom(section->mr);
> >> -
> >> -    /* Vhost doesn't handle any block which is doing dirty-tracking o=
ther
> >> -     * than migration; this typically fires on VGA areas.
> >> -     */
> >> -    result &=3D !log_dirty;
> >> +    MemoryRegion *mr =3D section->mr;
> >> +
> >> +    if (memory_region_is_ram(mr) && !memory_region_is_rom(mr)) {
> >> +        uint8_t dirty_mask =3D memory_region_get_dirty_log_mask(mr);
> >> +        uint8_t handled_dirty;
> >> +
> >> +        /*
> >> +         * Kernel based vhost doesn't handle any block which is doing
> >> +         * dirty-tracking other than migration for which it has
> >> +         * specific logging support. However for TCG the kernel never
> >> +         * gets involved anyway so we can also ignore it's
> >> +         * self-modiying code detection flags.
> >> +         */
> >> +        handled_dirty =3D (1 << DIRTY_MEMORY_MIGRATION);
> >> +        handled_dirty |=3D (1 << DIRTY_MEMORY_CODE);
> >
> > Wait, how is vhost going to support TCG self-modifying code detection?
> >
> > It seems like this change will allow vhost devices to run, but now QEMU
> > will miss out on self-modifying code. Do we already enable vhost dirty
> > memory logging for DIRTY_MEMORY_CODE memory somehwere?
>=20
> Well any guest code running will still trigger the SMC detection. It's
> true we currently don't have a mechanism if the vhost-user client
> updates an executable page.

Seems like a problem. If it didn't matter we could get rid of
DIRTY_MEMORY_CODE entirely.

If an exception is being made here because I/O devices aren't expected
to trigger SMC in real-world guests, please document it.

Stefan

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7fbjQACgkQnKSrs4Gr
c8jGqwf/XNI4hxhwW6MnkmX6GEDdbiuauAdWALDza4HhC7ynuKaETVmX2Dh5jyFw
tPkJ8fFqLpz0BIb/wWc/d7TMweb+fVCmlyV5T239sf14Cc5aNdcmr0ctS5sS5rBE
MIrUxgtyOT42WAc8Hd3rxRXwpLemjnB2SWqfKjmT1ARyBOPqhHzwIJKDgMxH10nM
mvrakWYVE/Ltoj+z6youPG3Fcb/Mx4+baW90pRon4F5iZmV492QnNlFU7y4SQso6
eQia8HDTmUNi1Ka9+mrSil3HZ6tAi8Dkv8zF0kivzNSFFj/fi73ELOwFe3Y7HNG/
3IAFh9Zv4k0ggu2IdriMkMLuU7DsBg==
=ZsR5
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--


