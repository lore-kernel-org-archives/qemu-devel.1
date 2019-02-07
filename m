Received: from eggs.gnu.org ([209.51.188.92]:40693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grj0B-0008U7-03
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:42:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grj0A-0003xf-0c
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:41:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1grj09-0003wU-Q0
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:41:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5DAE788E65
	for <qemu-devel@nongnu.org>; Thu,  7 Feb 2019 12:41:55 +0000 (UTC)
Date: Thu, 7 Feb 2019 12:41:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190207124134.GH19438@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190206132331.1694-1-quintela@redhat.com>
	<20190206132331.1694-2-quintela@redhat.com>
	<20190207113312.GD19438@redhat.com> <877eebg5j4.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877eebg5j4.fsf@trasno.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] multifd: Change page count default to
 128
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

On Thu, Feb 07, 2019 at 01:13:51PM +0100, Juan Quintela wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > On Wed, Feb 06, 2019 at 02:23:28PM +0100, Juan Quintela wrote:
> >> I haven't seend any problem about using 64 or 128.  And it make much
> >> less contention on the locks.  Just change it.
> >
> > Isn't there a issue with having a fixed page count given the
> > very different default page sizes across architectures ?
> >
> > x86 is 4kb pages, while ppc64 uses 64kb pages IIUC.
> >
> > This would mean current value of 64 pages, would correspond
> > to 1/4 MB on x86, and 4 MB on ppc64.  The new value would
> > be 1/2 MB on x86 and 8 MB on ppc64.
>=20
> I saw no difference (on x86 between 64 and 128 pages).  Bigger pages
> means half the contention on the locks and better for compression (see
> next series).

1/4 MB -> 1/2 MB is not all that significant a change, but  1/2 MB
vs 8 MB  is very significant.

I wouldn't be surprised if this difference in values results in
rather different performance characteristics for multifd migrate
between x86 and ppc64.

> > Should we instead be measuring this tunable in units that
> > are independant of page size ? eg meansure in KB, with a
> > requirement that the value is a multiple of the page size.
> > Then set the default to 512 KB ?
>=20
> See next patch, I just dropped the tunable altogether.  Libvirt don't
> want to support it (difficult to explain), and in the past you asked me
> to choose a sane value and live with it O:-)
> It was good for testing, though.

Yep, I think its good if QEMU choose a sane value. I'm just wondering
whether the value chosen is actually suitable for non-x86 architectures.

> Once there, is there a good value for a network packet?

I don't have any particular suggestion here. Probably would have to
look at real performance measurements of migration vs guest workload
to understand if we've got a good size.

> I put it in pages because it facilitates the coding, but doing a:
> CONSTANT/qemu_target_page_size() is not going to complicate anything
> either.



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
