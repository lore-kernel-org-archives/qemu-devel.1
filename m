Received: from eggs.gnu.org ([209.51.188.92]:34238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkS9O-0005sP-Ns
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:17:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkS9J-0000Gr-9J
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:17:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gkS9J-0000FQ-1c
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:17:21 -0500
Date: Fri, 18 Jan 2019 11:17:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190118111711.GJ20660@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190118093935.GA1142@beluga.usersys.redhat.com>
	<20190118101638.GE20660@redhat.com>
	<20190118111150.GA28476@wheatley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190118111150.GA28476@wheatley>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] AMD SEV's /dev/sev permissions and probing QEMU
 for capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Martin Kletzander <mkletzan@redhat.com>
Cc: Erik Skultety <eskultet@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, brijesh.singh@amd.com, dinechin@redhat.com

On Fri, Jan 18, 2019 at 12:11:50PM +0100, Martin Kletzander wrote:
> On Fri, Jan 18, 2019 at 10:16:38AM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> > I've just realized there is a potential 3rd solution. Remember there =
is
> > actually nothing inherantly special about the 'root' user as an accou=
nt
> > ID. 'root' gains its powers from the fact that it has many capabiliti=
es
> > by default.  'qemu' can't access /dev/sev because it is owned by a
> > different user (happens to be root) and 'qemu' does not have capabili=
ties.
> >=20
> > So we can make probing work by using our capabilities code to grant
> > CAP_DAC_OVERRIDE to the qemu process we spawn. So probing still runs
> > as 'qemu', but can none the less access /dev/sev while it is owned
> > by root.  We were not using 'qemu' for sake of security, as the probi=
ng
> > process is not executing any untrusthworthy code, so we don't  loose =
any
> > security protection by granting CAP_DAC_OVERRIDE.
> >=20
>=20
> IMHO CAP_DAC_OVERRIDE is a lot, especially on systems without SELinux.

Probing of QEMU capabilities is not a security critical task. QEMU is
run with "-machine none" so does not even create the virtual machine
hardware, nor have any guest image that it would run. All it is running
is the QEMU class initialization code. The only way for that to act in
a malicious way is for a backdoor to have been inserted when QEMU was
built by the OS vendor, or fo the QEMU binary on disk to have been
replaced by something malcious (which would require root privileges
itself).


We must of coure *NEVER* give CAP_DAC_OVERRIDE to a QEMU that is running
the real, untrustworty, end user VM.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
