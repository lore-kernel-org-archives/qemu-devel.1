Received: from eggs.gnu.org ([2001:4830:134:3::10]:40333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPYHE-0004rt-OA
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:26:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPYHD-0004By-Kd
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:26:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPYHD-0004Bq-CX
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:26:03 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F34B3D94C
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 17:26:03 +0000 (UTC)
Date: Fri, 6 Jan 2017 17:25:58 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170106172558.GX31112@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-2-berrange@redhat.com>
	<878tqo2jgs.fsf@ac.upc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878tqo2jgs.fsf@ac.upc.edu>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/47] trace: introduce some Makefile
 rules for module code gen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Jan 06, 2017 at 06:20:51PM +0100, Llu=C3=ADs Vilanova wrote:
> Daniel P Berrange writes:
>=20
> > Introduce rules that are able to generate trace.[ch] files
> > in every subdirectory which has a trace-events file.
>=20
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  .gitignore                               |  6 +++
> >  Makefile                                 | 65 ++++++++++++++++++++++=
+++++-----
> >  Makefile.objs                            |  5 +++
> >  Makefile.target                          |  7 +++-
> >  scripts/tracetool/backend/dtrace.py      |  7 +++-
> >  scripts/tracetool/backend/ust.py         |  7 +++-
> >  scripts/tracetool/format/ust_events_c.py |  2 +-
> >  scripts/tracetool/format/ust_events_h.py |  7 +++-
> >  tests/Makefile.include                   |  2 +-
> >  trace/Makefile.objs                      | 23 ++++++++---
> >  10 files changed, 109 insertions(+), 22 deletions(-)
>=20
> > diff --git a/.gitignore b/.gitignore
> > index e43c304..fe6add3 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -111,3 +111,9 @@ tags
> >  TAGS
> >  docker-src.*
> >  *~
> > +trace.h
> > +trace.c
> > +trace-events-common
> > +trace-ust.h
> > +trace-dtrace.h
> > +trace-dtrace.dtrace
> > diff --git a/Makefile b/Makefile
> > index 214cbad..181802b 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -70,11 +70,53 @@ GENERATED_SOURCES +=3D trace/generated-helpers.c
> =20
> >  ifeq ($(findstring ust,$(TRACE_BACKENDS)),ust)
> >  GENERATED_HEADERS +=3D trace/generated-ust-provider.h
> > +GENERATED_HEADERS +=3D trace/generated-ust-provider-all.h
> >  GENERATED_SOURCES +=3D trace/generated-ust.c
> >  endif
> =20
> >  GENERATED_HEADERS +=3D module_block.h
> =20
> > +GENERATED_HEADERS +=3D $(trace-events-subdirs:%=3D%/trace.h)
> > +GENERATED_SOURCES +=3D $(trace-events-subdirs:%=3D%/trace.c)
> > +GENERATED_DTRACE =3D
> > +ifdef CONFIG_TRACE_DTRACE
> > +GENERATED_HEADERS +=3D $(trace-events-subdirs:%=3D%/trace-dtrace.h)
> > +GENERATED_DTRACE +=3D $(trace-events-subdirs:%=3D%/trace-dtrace.dtra=
ce)
> > +endif
> > +ifdef CONFIG_TRACE_UST
> > +GENERATED_HEADERS +=3D $(trace-events-subdirs:%=3D%/trace-ust.h)
> > +endif
> > +
> > +%/trace.h: $(SRC_PATH)/%/trace-events $(tracetool-y)
> > +	$(call quiet-command,$(TRACETOOL) \
> > +		--format=3Dh \
> > +		--backends=3D$(TRACE_BACKENDS) \
> > +		$< > $@,"GEN","$@")
> > +
> > +%/trace.c: $(SRC_PATH)/%/trace-events $(tracetool-y)
> > +	$(call quiet-command,$(TRACETOOL) \
> > +		--format=3Dc \
> > +		--backends=3D$(TRACE_BACKENDS) \
> > +		$< > $@,"GEN","$@")
> > +
> > +%/trace-ust.h: $(SRC_PATH)/%/trace-events $(tracetool-y)
> > +	$(call quiet-command,$(TRACETOOL) \
> > +		--format=3Dust-events-h \
> > +		--backends=3D$(TRACE_BACKENDS) \
> > +		$< > $@,"GEN","$@")
>=20
> There's a discrepancy between generation in trace/Makefile.objs, where =
timestamp
> files are used to filter out internal changes in tracetool, and here.

I took the view that the timestamp comparisons are an uneccessary
complexity - we don't do that for other places where we generate
code from scripts.

> > diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/=
backend/dtrace.py
> > index 79505c6..1319990 100644
> > --- a/scripts/tracetool/backend/dtrace.py
> > +++ b/scripts/tracetool/backend/dtrace.py
> > @@ -36,7 +36,12 @@ def binary():
> =20
> =20
> >  def generate_h_begin(events, group):
> > -    out('#include "trace/generated-tracers-dtrace.h"',
> > +    if group =3D=3D "common":
> > +        include =3D "trace/generated-tracers-dtrace.h"
> > +    else:
> > +        include =3D "trace-dtrace.h"
> > +
> > +    out('#include "%s"' % include,
> >          '')
>=20
> Why is the top-level events file treated as a special case?

This is temporary until the end of the series when the special
cases go away


Regards,
Daniel
--=20
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange=
/ :|
|: http://libvirt.org              -o-             http://virt-manager.or=
g :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr=
/ :|
