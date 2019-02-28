Received: from eggs.gnu.org ([209.51.188.92]:56032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gzIpx-0001k1-JV
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:22:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gzIpw-0007VM-6z
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:22:45 -0500
Date: Thu, 28 Feb 2019 10:22:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190228102236.GC9217@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190227012132.16271-1-david@gibson.dropbear.id.au>
	<20190227110127.GE31688@redhat.com>
	<b9f4a52e-43e0-c209-4743-2f039e96a6b9@redhat.com>
	<20190227140843.GI31688@redhat.com>
	<87d0ndujej.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87d0ndujej.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, otubo@redhat.com, pbonzini@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Wed, Feb 27, 2019 at 08:21:40PM +0100, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Wed, Feb 27, 2019 at 07:59:11AM -0600, Eric Blake wrote:
> >> On 2/27/19 5:01 AM, Daniel P. Berrang=C3=A9 wrote:
> >> > On Wed, Feb 27, 2019 at 12:21:32PM +1100, David Gibson wrote:
> >> >> At present, when seccomp support is compiled out with --disable-s=
eccomp
> >> >> we fail with an error if the user puts -sandbox on the command li=
ne.
> >> >>
> >> >> That kind of makes sense, but it's a bit strange that we reject a=
 request
> >> >> to disable sandboxing with "-sandbox off" saying we don't support
> >> >> sandboxing.
> >> >>
> >> >> This puts in a small sandbox to (correctly) silently ignore -sand=
box off
> >> >> when we don't have sandboxing support compiled in.  This makes li=
fe easier
> >> >> for testcases, since they can safely specify "-sandbox off" witho=
ut having
> >> >> to care if the qemu they're using is compiled with sandbox suppor=
t or not.
>=20
> I can't see such test cases.  Can you give specific examples?
>=20
> >> >> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>=20
> >> > '-sandbox off'  is just syntax sugar for '-sandbox enable=3Doff', =
with
> >> > the default arg name handled by QemuOpts.
> >>=20
> >> Except that libvirt probes, via query-command-line-options, whether =
the
> >> '-sandbox' option supports the 'enable' key.  You risk breaking
> >> introspection (where libvirt knows NOT to use enable=3Don|off) if -s=
andbox
> >> enable=3Doff is advertised even when the feature is not compiled in.
> >
> > It is even more complex than that. Libvirt looks for "elevateprivileg=
es"
> > option to decide to enable the sandbox. It only looks for "enable" wh=
en
> > libvirt is configured to disable the sandbox, at which point is sets
> > "-sandbox off". So I don't think my suggestion should break it.
> >
> > I do hate the idea of QEMU tailoring its CLI handling to suit the
> > current specific impl of one client app though.
> >
> > If anything I'd suggest we should completely disable any parsing
> > of -sandbox when seccomp is disabled, rather than leaving getopt
> > to parse -sandbox and then raise an error.
>=20
> I'm confused.  Are you proposing to silently ignore -sandbox OPTARG
> regardless of OPTARG when CONFIG_SECCOMP is off?  If yes, I object.  If
> a user asks for a sandbox, and we can't give him one, we should at leas=
t
> tell him as much.

No, i mean remove "case QEMU_OPTION_sandbox:" from the code, which
will cause us to report '-sandbox' as an unsupported argument.

> Currently, we have both
>=20
>     #ifdef CONFIG_FOO
>                 case QEMU_OPTION_FOO:
>                     ...
>                     break;
>     #endif

This is what I was suggesting for -sandbox above.

>=20
> and
>=20
>=20
>                 case QEMU_OPTION_FOO:
>     #ifdef CONFIG_FOO
>                     ...
>                     break;
>     #else
>                     error_report("FOO support is disabled");
>                     exit(1);
>     #endif

This is what -sandbox does currently.

>=20
> The patch adds a third variant.  We need fewer variants, not more.
>=20
> For what it's worth, conditional QMP commands do not exist when
> disabled, like the first variant above.  In particular, introspection
> doesn't have them.  Nicely obvious.
>=20
> QAPIfying the command line (yes, yes, overdue) should make it more like
> QMP.
>=20
> Wanting nicer errors than "unknown option / command" is legitimate.
>=20
> Wanting to accept "switch FOO off" even though FOO is disabled is also
> legitimate.
>=20
> Patches that provide such UI niceties while keeping introspection nicel=
y
> obvious would be acceptable to me, provided they're not too complex.
> But they should be general, not a one-off.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
