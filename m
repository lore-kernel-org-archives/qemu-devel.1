Received: from eggs.gnu.org ([2001:4830:134:3::10]:57286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fB0Gn-0005ll-V3
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:54:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fB0Gm-00006R-9J
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:54:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37464 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fB0Gm-00006N-2h
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:54:16 -0400
Date: Tue, 24 Apr 2018 16:54:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180424155407.GK20310@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524156319-11465-16-git-send-email-ian.jackson@eu.citrix.com>
	<b8d20908-c76c-1dc2-2c14-31c185abbbfc@amsat.org>
	<23263.17660.17771.980752@mariner.uk.xensource.com>
	<20180424151830.GI20310@redhat.com>
	<baa5df1e-3e65-4213-045a-ca064fb69c3f@redhat.com>
	<1e72b98a-5553-5990-2327-c86c75952e87@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e72b98a-5553-5990-2327-c86c75952e87@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: Ian Jackson <ian.jackson@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Ross Lagerwall <ross.lagerwall@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Alistair Francis <alistair.francis@xilinx.com>

On Tue, Apr 24, 2018 at 10:43:09AM -0500, Eric Blake wrote:
> On 04/24/2018 10:40 AM, Eric Blake wrote:
> > On 04/24/2018 10:18 AM, Daniel P. Berrang=C3=A9 wrote:
> >=20
> >>>  - static void vreport(report_type type, const char *fmt, va_list a=
p)
> >>>  + static void vreport(report_type type, int errnoval, const char *=
fmt, va_list ap)
> >>> ...
> >>>  +     if (errnoval >=3D 0) {
> >>>  +         error_printf(": %s", strerror(errnoval);
> >>>  +     }
> >>>
> >>> and then add both
> >>>   error_report_errno
> >>>   error_vreport_errno
> >>> with the obvious semantics.
> >>
> >> That would be nice, because then we can make these two functions act=
ually
> >> use strerror_r() instead of strerror(), for thread safety on all pla=
tforms.
> >=20
> > Except that strerror_r() is a bear to use portably, given that glibc'=
s
> > default declaration differs from the POSIX requirement (you can force
> > glibc to give you the POSIX version, but doing so causes you to lose
> > access to many other useful extensions).  It's rather telling that 'g=
it
> > grep strerror_r' currently comes up empty.
>=20
> That said, glib's g_strerror() may be suitable for this purpose,
> although we are currently using it only in tests/ivshmem-test.c.

Yes, that uses strerror_r internally, or strerror_s on Windows:

https://gitlab.gnome.org/GNOME/glib/blob/master/glib/gstrfuncs.c#L1236


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
