Received: from eggs.gnu.org ([209.51.188.92]:35998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtVJp-00080C-AQ
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:29:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtVJm-0000CM-Nk
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:29:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gtVJm-00008B-3W
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:29:34 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02B9C80F8F
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 10:29:33 +0000 (UTC)
Date: Tue, 12 Feb 2019 10:29:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190212102929.GE9386@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190206132331.1694-1-quintela@redhat.com>
	<20190206132331.1694-3-quintela@redhat.com>
	<20190207123338.GG19438@redhat.com> <87ftstxsd0.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ftstxsd0.fsf@trasno.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] multifd: Drop x-multifd-page-count
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Feb 12, 2019 at 10:34:35AM +0100, Juan Quintela wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > On Wed, Feb 06, 2019 at 02:23:29PM +0100, Juan Quintela wrote:
> >> Libvirt don't want to expose (and explain it).  And testing looks li=
ke
> >> 128 is good for all use cases, so just drop it.
> >
> > One significant concern inline...
> >
> >>=20
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> ---
> >>  hmp.c                 |  7 -------
> >>  migration/migration.c | 30 ------------------------------
> >>  migration/migration.h |  1 -
> >>  migration/ram.c       | 13 ++++++++-----
> >>  qapi/migration.json   | 13 +------------
> >>  5 files changed, 9 insertions(+), 55 deletions(-)
> >
> >
> >> @@ -718,7 +721,7 @@ static void multifd_send_fill_packet(MultiFDSend=
Params *p)
> >>      packet->magic =3D cpu_to_be32(MULTIFD_MAGIC);
> >>      packet->version =3D cpu_to_be32(MULTIFD_VERSION);
> >>      packet->flags =3D cpu_to_be32(p->flags);
> >> -    packet->size =3D cpu_to_be32(migrate_multifd_page_count());
> >> +    packet->size =3D cpu_to_be32(MULTIFD_PAGE_COUNT);
> >>      packet->used =3D cpu_to_be32(p->pages->used);
> >>      packet->packet_num =3D cpu_to_be64(p->packet_num);
> >>
> >
> > Here the source QEMU sends the page size - which is now
> > a hardcoded constant - to the target QEMU.
> >
> >> @@ -756,10 +759,10 @@ static int multifd_recv_unfill_packet(MultiFDR=
ecvParams *p, Error **errp)
> >>      p->flags =3D be32_to_cpu(packet->flags);
> >> =20
> >>      packet->size =3D be32_to_cpu(packet->size);
> >> -    if (packet->size > migrate_multifd_page_count()) {
> >> +    if (packet->size > MULTIFD_PAGE_COUNT) {
> >>          error_setg(errp, "multifd: received packet "
> >>                     "with size %d and expected maximum size %d",
> >> -                   packet->size, migrate_multifd_page_count()) ;
> >> +                   packet->size, MULTIFD_PAGE_COUNT) ;
> >>          return -1;
> >>      }
> >>
> >
> > Here the dest QEMU receives the page size that the source QEMU used, =
and
> > checks that it is not larger than its constant.
> >
> > IIUC, the implication here is that if we ever increase the size of th=
is
> > constant in future QEMU, we will break live migration from new to old
> > QEMU due to this check.  In fact your previous patch in this series h=
as
> > done exactly that, so this appears to mean QEMU 4.0 -> QEMU 3.2
> > multifd migration is broken now.
> >
> > Alternatively if we decrease the size of the constant in future
> > QEMU, we will break live migration from old QEMU to new QEMU which
> > is even worse.
> >
> > This problem existed before this patch, if the management app was
> > not explicitly using migrate-set-parameters to set the page count
> > on both sides of QEMU. So we're already broken, but at least the
> > feature was marked experimental.
> >
> > What is the purpose of this packet size check ?  Is it something
> > we can safely remove, so that we can increase or decrease the
> > size at will without breaking migration compat.
>=20
> We have a "dinamyc" array of pages of that size.  What we check is that
> the array fits into the part that we have assigned.
>=20
> We "could" wait until this moment to create the arrays, I need to look
> into that.  Notice that what the check does is making sure that whatewe=
r
> we receive is not bigger than the space that we have allocated.
>=20
> At this point, that check can only fail if we are "being" attacked and
> we have a malformed string.  We check during negotiation that this valu=
e
> is ok.
>=20
> We should check this *also* in the initial packet, and then this check
> should never be true.

Right but checking earlier will still have the same problem I describe
with back compatibility if we ever change the page count in future QEMU,
as the limit checked by one QEMU may be smaller than what the other QEMU
is intentionally sending.  I don't see where we have a bi-directional
channel that would allow the 2 QEMUs to negotiate a mutually acceptable
page count :-(

> From a management point of view, what do you preffer here?

The earlier we check requirements the better, as it means we get the
error reported sooner, before wasting time of data transmisions.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
