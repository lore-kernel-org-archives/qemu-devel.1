Received: from eggs.gnu.org ([2001:4830:134:3::10]:42338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWQ7e-0007MC-By
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:08:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWQ7b-0001K3-2E
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:08:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cWQ7a-0001It-Pu
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:08:30 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CAA317FB6A
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 16:08:29 +0000 (UTC)
Date: Wed, 25 Jan 2017 16:08:24 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170125160824.GC29006@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170124110151.937-1-berrange@redhat.com>
	<20170124110151.937-7-berrange@redhat.com>
	<87d1fci916.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87d1fci916.fsf@frigg.lan>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 6/8] trace: switch to modular code
 generation for sub-directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Jan 24, 2017 at 08:53:57PM +0200, Llu=C3=ADs Vilanova wrote:
> Daniel P Berrange writes:
>=20
> > Introduce rules in the top level Makefile that are able to generate
> > trace.[ch] files in every subdirectory which has a trace-events file.
>=20
> > The top level directory is handled specially, so instead of creating
> > trace.h, it creates trace-root.h. This allows sub-directories to
> > include the top level trace-root.h file, without ambiguity wrt to
> > the trace.g file in the current sub-dir.
>=20
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> [...]
> > diff --git a/Makefile b/Makefile
> > index 9f8968d..a8fa28a 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -56,25 +56,136 @@ GENERATED_SOURCES +=3D qmp-marshal.c qapi-types.=
c qapi-visit.c qapi-event.c
> >  GENERATED_HEADERS +=3D qmp-introspect.h
> >  GENERATED_SOURCES +=3D qmp-introspect.c
> =20
> > -GENERATED_HEADERS +=3D trace/generated-tracers.h
> > -ifeq ($(findstring dtrace,$(TRACE_BACKENDS)),dtrace)
> > -GENERATED_HEADERS +=3D trace/generated-tracers-dtrace.h
> > -endif
> > -GENERATED_SOURCES +=3D trace/generated-tracers.c
> > -
> >  GENERATED_HEADERS +=3D trace/generated-tcg-tracers.h
> =20
> >  GENERATED_HEADERS +=3D trace/generated-helpers-wrappers.h
> >  GENERATED_HEADERS +=3D trace/generated-helpers.h
> >  GENERATED_SOURCES +=3D trace/generated-helpers.c
> =20
> > -ifeq ($(findstring ust,$(TRACE_BACKENDS)),ust)
> > -GENERATED_HEADERS +=3D trace/generated-ust-provider.h
> > -GENERATED_SOURCES +=3D trace/generated-ust.c
> > +ifdef CONFIG_TRACE_UST
> > +GENERATED_HEADERS +=3D trace-ust-all.h
> > +GENERATED_SOURCES +=3D trace-ust-all.c
> >  endif
> =20
> >  GENERATED_HEADERS +=3D module_block.h
> =20
> > +TRACE_HEADERS =3D trace-root.h $(trace-events-subdirs:%=3D%/trace.h)
> > +TRACE_SOURCES =3D trace-root.c $(trace-events-subdirs:%=3D%/trace.c)
> > +TRACE_DTRACE =3D
> > +ifdef CONFIG_TRACE_DTRACE
> > +TRACE_HEADERS +=3D trace-dtrace-root.h $(trace-events-subdirs:%=3D%/=
trace-dtrace.h)
> > +TRACE_DTRACE +=3D trace-dtrace-root.dtrace $(trace-events-subdirs:%=3D=
%/trace-dtrace.dtrace)
> > +endif
> > +ifdef CONFIG_TRACE_UST
> > +TRACE_HEADERS +=3D trace-ust-root.h $(trace-events-subdirs:%=3D%/tra=
ce-ust.h)
> > +endif
> > +
> > +GENERATED_HEADERS +=3D $(TRACE_HEADERS)
> > +GENERATED_SOURCES +=3D $(TRACE_SOURCES)
> > +
> > +trace-group-name =3D $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/_/g=
')
> > +
> > +%/trace.h: %/trace.h-timestamp
> > +	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
> > +%/trace.h-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y)
> > +	$(call quiet-command,$(TRACETOOL) \
> > +		--group=3D$(call trace-group-name,$@) \
>=20
> Shouldn't you call trace-group-name with $*? To make sure it only conta=
ins the
> directories *below* SRC_PATH.

$@ is a relative path already

Regards,
Daniel
--=20
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange=
/ :|
|: http://libvirt.org              -o-             http://virt-manager.or=
g :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr=
/ :|
