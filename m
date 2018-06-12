Received: from eggs.gnu.org ([2001:4830:134:3::10]:41527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fSrfz-000144-UM
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 18:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fSrft-000125-MI
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 18:22:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1fSrft-000112-ED
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 18:22:01 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5CMJ6ch136523
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 18:22:00 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jjpc6h218-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 18:22:00 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 12 Jun 2018 16:21:59 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180515100949.248bc43b.cohuck@redhat.com>
References: <20180515063128.7040-1-olaf@aepfle.de>
	<d17ae62a-03a5-61fa-934a-4cb917d14222@redhat.com>
	<20180515100949.248bc43b.cohuck@redhat.com>
Date: Tue, 12 Jun 2018 17:21:43 -0500
Message-Id: <152884210382.21982.6157008274157617034@sif>
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH v2] replace functions which
 are only available in glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Olaf Hering <olaf@aepfle.de>, qemu-trivial@nongnu.org, "open list:All patches   CC here" <qemu-devel@nongnu.org>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Quoting Cornelia Huck (2018-05-15 03:09:49)
> On Tue, 15 May 2018 09:18:52 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> =

> > On 15.05.2018 08:31, Olaf Hering wrote:
> > > Currently the minimal supported version of glib is 2.22.
> > > Since testing is done with a glib that claims to be 2.22, but in fact
> > > has APIs from newer version of glib, this bug was not caught during
> > > submit of the patch referenced below.
> > > =

> > > Replace g_realloc_n, which is available only since 2.24, with g_renew.
> > > =

> > > Fixes commit 418026ca43 ("util: Introduce vfio helpers")
> > > =

> > > Signed-off-by: Olaf Hering <olaf@aepfle.de>
> > > ---
> > >  This must go into stable-2.12.  =

> > =

> > In that case please CC: qemu-stable@nongnu.org (done now).
> > =

> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > =

> > >  util/vfio-helpers.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > =

> > > diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> > > index 006674c916..1d9272efa4 100644
> > > --- a/util/vfio-helpers.c
> > > +++ b/util/vfio-helpers.c
> > > @@ -522,8 +522,7 @@ static IOVAMapping *qemu_vfio_add_mapping(QEMUVFI=
OState *s,
> > >  =

> > >      assert(index >=3D 0);
> > >      s->nr_mappings++;
> > > -    s->mappings =3D g_realloc_n(s->mappings, sizeof(s->mappings[0]),
> > > -                              s->nr_mappings);
> > > +    s->mappings =3D g_renew(IOVAMapping, s->mappings, s->nr_mappings=
);
> > >      insert =3D &s->mappings[index];
> > >      shift =3D s->nr_mappings - index - 1;
> > >      if (shift) {
> > > @@ -577,8 +576,7 @@ static void qemu_vfio_undo_mapping(QEMUVFIOState =
*s, IOVAMapping *mapping,
> > >      memmove(mapping, &s->mappings[index + 1],
> > >              sizeof(s->mappings[0]) * (s->nr_mappings - index - 1));
> > >      s->nr_mappings--;
> > > -    s->mappings =3D g_realloc_n(s->mappings, sizeof(s->mappings[0]),
> > > -                              s->nr_mappings);
> > > +    s->mappings =3D g_renew(IOVAMapping, s->mappings, s->nr_mappings=
);
> > >  }
> > >  =

> > >  /* Check if the mapping list is (ascending) ordered. */
> > >   =

> =

> This looks fine to me, so
> =

> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> =

> But this leads to another question: What do we do if we want a fix only
> in stable? Hypothetical scenario: Same parameters as for this patch
> (glib version bump, newer function sneaked in), but the older function
> that could be used in stable is clearly worse (IOW, we don't want it in
> the new version). Do we have a process to get a change only into stable?
> =


I've answered in the form of a patch :)

  "docs: add details regarding submitting stable-specific patches"

but here's a recent example:

  https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg04999.html
