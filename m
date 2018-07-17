Received: from eggs.gnu.org ([2001:4830:134:3::10]:38999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ffSRf-0004Pb-US
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ffSRa-0006P0-0i
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:03:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ffSRZ-0006OR-O8
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:03:17 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6HFxpWk008068
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:03:16 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k9jmtjy13-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:03:16 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 17 Jul 2018 10:03:15 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180717093418.GI18603@redhat.com>
References: <20180624124540.6659-1-sameeh@daynix.com>
	<153177183866.7766.1789433991037567183@sif>
	<20180717093418.GI18603@redhat.com>
Date: Tue, 17 Jul 2018 11:03:04 -0500
Message-Id: <153184338480.16660.1516498461297252224@sif>
Subject: Re: [Qemu-devel] [PATCH] qga-win: Handle fstrim for OSes lower than
 Win8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org, Yan Vugenfirer <yan@daynix.com>

Quoting Daniel P. Berrang=C3=A9 (2018-07-17 04:34:18)
> On Mon, Jul 16, 2018 at 03:10:38PM -0500, Michael Roth wrote:
> > Quoting Sameeh Jubran (2018-06-24 07:45:40)
> > > From: Sameeh Jubran <sjubran@redhat.com>
> > > =

> > > The defrag.exe tool which is used for executing the fstrim command
> > > on Windows doesn't support retrim for OSes lower than Win8. This
> > > commit handles this case and returns a suitable error.
> > > =

> > > Output of fstrim before this commit:
> > > {"execute":"guest-fstrim"}
> > > {"return": {"paths": [{"path": "C:\\", "error": "An invalid command l=
ine option
> > > was specified. (0x89000008)"}, {"path": "F:\\", "error": "An invalid =
command
> > > line option was specified. (0x89000008)"}, {"path": "S:\\", "error": =
"An
> > > invalid command line option was specified. (0x89000008)"}]}}
> > > =

> > > Reported on:
> > > https://bugzilla.redhat.com/show_bug.cgi?id=3D1594113
> > > =

> > > Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> > > ---
> > >  qga/commands-win32.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > =

> > > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > > index d79974f212..0bdcd9dd38 100644
> > > --- a/qga/commands-win32.c
> > > +++ b/qga/commands-win32.c
> > > @@ -30,6 +30,7 @@
> > >  #include <lm.h>
> > >  #include <wtsapi32.h>
> > >  #include <wininet.h>
> > > +#include <versionhelpers.h>
> > =

> > I have this queued locally but the mingw64 build environment I've been
> > using (fc20) doesn't support this header and I'm running into some odd
> =

> Please tell me that fc20 is a typo, and you're actually using the modern
> fc28 :-)  Fedora 20 went end of life 3 years ago, so is not considered
> a supported platform for QEMU per our policy here:
> =

>   https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platforms

I'm only using it for mingw builds, but yes, it's definitely time to move to
something a bit less ancient.

> =

> > null pointer / 0xc0000005 / access violation issues with the binary
> > generated in newer tool chains. I'll send a pull for this next week when
> > I can get it tested.
> > =

> > What build envionment are you using?
> =

> Regards,
> Daniel
> -- =

> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>=20
