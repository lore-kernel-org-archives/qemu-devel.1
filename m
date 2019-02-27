Received: from eggs.gnu.org ([209.51.188.92]:60319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gyztE-000114-M9
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:08:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gyztC-0004gk-PT
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:08:52 -0500
Date: Wed, 27 Feb 2019 14:08:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190227140843.GI31688@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190227012132.16271-1-david@gibson.dropbear.id.au>
	<20190227110127.GE31688@redhat.com>
	<b9f4a52e-43e0-c209-4743-2f039e96a6b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9f4a52e-43e0-c209-4743-2f039e96a6b9@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Allow -sandbox off with --disable-seccomp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, otubo@redhat.com, pbonzini@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Wed, Feb 27, 2019 at 07:59:11AM -0600, Eric Blake wrote:
> On 2/27/19 5:01 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Feb 27, 2019 at 12:21:32PM +1100, David Gibson wrote:
> >> At present, when seccomp support is compiled out with --disable-secc=
omp
> >> we fail with an error if the user puts -sandbox on the command line.
> >>
> >> That kind of makes sense, but it's a bit strange that we reject a re=
quest
> >> to disable sandboxing with "-sandbox off" saying we don't support
> >> sandboxing.
> >>
> >> This puts in a small sandbox to (correctly) silently ignore -sandbox=
 off
> >> when we don't have sandboxing support compiled in.  This makes life =
easier
> >> for testcases, since they can safely specify "-sandbox off" without =
having
> >> to care if the qemu they're using is compiled with sandbox support o=
r not.
> >>
> >> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> > '-sandbox off'  is just syntax sugar for '-sandbox enable=3Doff', wit=
h
> > the default arg name handled by QemuOpts.
>=20
> Except that libvirt probes, via query-command-line-options, whether the
> '-sandbox' option supports the 'enable' key.  You risk breaking
> introspection (where libvirt knows NOT to use enable=3Don|off) if -sand=
box
> enable=3Doff is advertised even when the feature is not compiled in.

It is even more complex than that. Libvirt looks for "elevateprivileges"
option to decide to enable the sandbox. It only looks for "enable" when
libvirt is configured to disable the sandbox, at which point is sets
"-sandbox off". So I don't think my suggestion should break it.

I do hate the idea of QEMU tailoring its CLI handling to suit the
current specific impl of one client app though.

If anything I'd suggest we should completely disable any parsing
of -sandbox when seccomp is disabled, rather than leaving getopt
to parse -sandbox and then raise an error.

>=20
> >=20
> > If we want to keep ability to run "-sandbox off" we should do it via
> > the QEMU opts code we already have in the first part of the condition=
al,
> > so that "-sandbox enable=3Doff" also works as normal.
> >=20
> > Essentially we need to push the #ifdef CONFIG_SECCOMP down into the
> > parse_sandbox method, so that it parses the "enable" option normally
> > but rejects any value except disabled..
> >=20
> > The QemuOptsList should also be conditional to only register the
> > "enable"  arg and not the other bits.
>=20
> Whatever we do here had better be careful that the introspection used b=
y
> libvirt doesn't break, when libvirt is trying to learn when seccomp was
> not compiled in.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
