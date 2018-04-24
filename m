Received: from eggs.gnu.org ([2001:4830:134:3::10]:44160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fAziS-0004BA-8U
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fAziO-0005N1-1n
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:18:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50170 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fAziN-0005KV-TW
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:18:43 -0400
Date: Tue, 24 Apr 2018 16:18:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180424151830.GI20310@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524156319-11465-16-git-send-email-ian.jackson@eu.citrix.com>
	<b8d20908-c76c-1dc2-2c14-31c185abbbfc@amsat.org>
	<23263.17660.17771.980752@mariner.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23263.17660.17771.980752@mariner.uk.xensource.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 15/16] os-posix: cleanup: Replace perror
 with error_report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@citrix.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Ross Lagerwall <ross.lagerwall@citrix.com>, xen-devel@lists.xenproject.org, Anthony PERARD <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Apr 24, 2018 at 03:53:48PM +0100, Ian Jackson wrote:
> Philippe Mathieu-Daud=C3=A9 writes ("Re: [Qemu-devel] [PATCH 15/16] os-=
posix: cleanup: Replace perror with error_report"):
> > On 04/19/2018 01:45 PM, Ian Jackson wrote:
> > > -        perror("mlockall");
> > > +        error_report("mlockall: %s", strerror(errno));
> > >      }
> > > =20
> > >      return ret;
> >=20
> > Thinking loudly, maybe we can refactor as error_report_errno(const ch=
ar
> > *desc)...
>=20
> git-grep 'error_report.*errno' shows a lot of call sites that do
> something more exciting than const char *desc would support.
>=20
> I think the right approach would be
>=20
>  - static void vreport(report_type type, const char *fmt, va_list ap)
>  + static void vreport(report_type type, int errnoval, const char *fmt,=
 va_list ap)
> ...
>  +     if (errnoval >=3D 0) {
>  +         error_printf(": %s", strerror(errnoval);
>  +     }
>=20
> and then add both
>   error_report_errno
>   error_vreport_errno
> with the obvious semantics.

That would be nice, because then we can make these two functions actually
use strerror_r() instead of strerror(), for thread safety on all platform=
s.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
