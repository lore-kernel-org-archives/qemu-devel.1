Received: from eggs.gnu.org ([2001:4830:134:3::10]:59653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQusD-0007s7-I7
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQusC-0004Vn-C3
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:22:41 -0400
Date: Thu, 7 Jun 2018 14:22:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180607132231.GR28827@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180601091835.21620-1-famz@redhat.com>
	<20180601124345.GC3458@redhat.com>
	<87602uwx5z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87602uwx5z.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] file-posix: Consolidate the locking error
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu, Jun 07, 2018 at 03:20:24PM +0200, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Fri, Jun 01, 2018 at 05:18:35PM +0800, Fam Zheng wrote:
> >> When hot-plugging a block device fails due to image locking errors,
> >> users won't see the helpful 'Is another process using the image?'
> >> message in QMP because currently the error hint is not carried over
> >> there.
> >>=20
> >> Even though extending QMP to include hint is a conceivably easy task=
,
> >> Libvirt will need some change to consume that data.
> >>=20
> >> Before that is fully sorted out, let's just do the easy fix by joini=
ng
> >> the two lines.
> >
> > There are many places in QEMU which uses error hints and these are al=
l
> > invisible to libvirt. Arbitrarily picking one hint to remove, while
> > leaving everything else unfixed is not a very satisfactory approach.
> >
> > If QEMU passes the hint in QMP, it is trivial for libvirt to be chang=
ed
> > to append the hint when reporting its own error message, so can we ju=
st
> > focus on fixing the root cause instead of special casing file-posix.c
>=20
> Intended use of hints according to error.h:
>=20
>  * Intended use is adding helpful hints on the human user interface,
>  * e.g. a list of valid values.  It's not for clarifying a confusing
>  * error message.
>=20
> I admit this guidance is widely ignored.

Perhaps if we rename the function "error_append_hmp_hint" it would
make it obvious this is targetted at CLI users, and not QMP users,
and so encourage people to write better initial messages  ?

>=20
> When used as intended, the hints need not make any sense in QMP!
> Consider this example in qemu-option.c:
>=20
>         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name,
>                    "a non-negative number below 2^64");
>         error_append_hint(errp, "Optional suffix k, M, G, T, P or E mea=
ns"
>                           " kilo-, mega-, giga-, tera-, peta-\n"
>                           "and exabytes, respectively.\n");
>=20
> The suffixes are only available in the human interface.
>=20
> Aside: we have lots of code consuming input from both QMP and HMP / CLI=
.
> The error reporting is generally atrocious for at least one of the two.
>=20
> Perhaps we could use separate functions for providing syntax hints and
> for clarifying confusing error messages.  Patches welcome, but they
> better convert all existing uses.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
