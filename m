Received: from eggs.gnu.org ([2001:4830:134:3::10]:47748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYXqz-000388-RF
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 08:52:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYXqx-0005uJ-66
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 08:52:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eYXqw-0005rs-Su
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 08:52:39 -0500
References: <20180107122336.29333-1-richiejp@f-m.fm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fd5f5f12-e081-6f19-54af-3b560139bb78@redhat.com>
Date: Mon, 8 Jan 2018 07:52:35 -0600
MIME-Version: 1.0
In-Reply-To: <20180107122336.29333-1-richiejp@f-m.fm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nRF6KikCy7s6p1r6B6yUGIx7rN8epJadK"
Subject: Re: [Qemu-devel] [PATCH 1/2] Add save-snapshot,
 load-snapshot and delete-snapshot to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Palethorpe <richiejp@f-m.fm>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com, armbru@redhat.com, rpalethorpe@suse.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nRF6KikCy7s6p1r6B6yUGIx7rN8epJadK
From: Eric Blake <eblake@redhat.com>
To: Richard Palethorpe <richiejp@f-m.fm>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com, armbru@redhat.com,
 rpalethorpe@suse.com
Message-ID: <fd5f5f12-e081-6f19-54af-3b560139bb78@redhat.com>
Subject: Re: [PATCH 1/2] Add save-snapshot, load-snapshot and delete-snapshot
 to QAPI
References: <20180107122336.29333-1-richiejp@f-m.fm>
In-Reply-To: <20180107122336.29333-1-richiejp@f-m.fm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/07/2018 06:23 AM, Richard Palethorpe wrote:
> Add QAPI wrapper functions for the existing snapshot functionality. The=
se
> functions behave the same way as the HMP savevm, loadvm and delvm
> commands. This will allow applications, such as OpenQA, to programmatic=
ally
> revert the VM to a previous state with no dependence on HMP or qemu-img=
=2E

That's already possible; libvirt uses QMP's human-monitor-command to
access these HMP commands programmatically.

We've had discussions in the past about what it would take to have
specific QMP commands for these operations; the biggest problem is that
these commands promote the use of internal snapshots, and there are
enough performance and other issues with internal snapshots that we are
not yet ready to commit to a long-term interface for making their use
easier.  At this point, our recommendation is to prefer external snapshot=
s.

https://lists.gnu.org/archive/html/qemu-devel/2016-01/msg02427.html is
an example thread that has tried to tackle the QMP-ification of these
HMP commands in the past; here we are two years later, and I'm still not
sure we are ready.

I'm worried that taking this commands as-is will bake in an interface
that we don't want to support in the long term.  In particular, the
qemu-img counterpart of taking an internal snapshot of an offline guest
is different from QMP context where the guest is running and would
always include a snapshot of CPU state in addition to disk state; I'm
also worried that the command is too broad, compared to doing a
transaction built on lower-level building blocks (take an internal
snapshot of disk storage, coupled with take an internal snapshot of cpu
state to be placed into a particular BDS); the HMP command is a bit hard
to use because the internal snapshot of CPU state has no user control
over which BDS will actually hold the state (other than which disk was
installed/hot-plugged first), whereas at the lower level, we probably do
want to allow management more fine-grained control over where the
internal snapshot lands.

Also, when sending a two-patch series, be sure to include a 0/2 cover
letter.  More patch submission hints at
https://wiki.qemu.org/Contribute/SubmitAPatch

>=20
> I used the term snapshot instead of VM because I think it is less ambig=
uous
> and matches the internal function names.
>=20
> Signed-off-by: Richard Palethorpe <richiejp@f-m.fm>
> ---
>  migration/savevm.c | 27 ++++++++++++++++++++++
>  qapi-schema.json   | 66 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 93 insertions(+)
>=20

> +++ b/qapi-schema.json
> @@ -1125,6 +1125,72 @@
>  { 'command': 'pmemsave',
>    'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
> =20
> +##
> +# @save-snapshot:
> +#
> +# Save a snapshot of the entire Virtual Machine
> +#
> +# @name: A string identifying the snapshot. This can later be used wit=
h
> +#        @load-snapshot or @delete-snapshot
> +#
> +# Since: 2.12.0
> +#
> +# Returns: If successful, nothing
> +#
> +# Notes: The equivalent HMP command is savevm. This stores all of the =
virtual

I don't see why we have to document HMP commands in the QMP document.

> +#        machine's current state within the virtual machine's
> +#        image(s)/storage. If the VM is currently running, this includ=
es the
> +#        state of the CPU and RAM. Later the VM can be reverted to thi=
s state.

How would the VM _not_ be currently running at the point where QMP can
be executed?

> +#
> +#        qemu-img can also be used to manipulate snapshots.
> +#
> +# Examples:
> +#
> +# -> { "execute": "save-snapshot", "arguments": { "name": "lastgood" }=
 }
> +# <- { "return": {} }
> +##
> +{ 'command': 'save-snapshot',
> +  'data': {'name': 'str'} }
> +
> +##
> +# @load-snapshot:
> +#
> +# Load a snapshot of the entire Virtual Machine, completely reverting =
it to
> +# that state
> +#
> +# Since: 2.12.0
> +#
> +# Returns: If successful, nothing
> +#
> +# Notes: The equivalent HMP command is loadvm. See the @save-snapshot =
notes.
> +#
> +# Examples:
> +#
> +# -> { "execute": "load-snapshot", "arguments": { "name": "lastgood" }=
 }
> +# <- { "return": {} }
> +##
> +{ 'command': 'load-snapshot',
> +  'data': {'name': 'str'} }
> +
> +##
> +# @delete-snapshot:
> +#
> +# Delete a VM snapshot
> +#
> +# Since: 2.12.0
> +#
> +# Returns: If successful, nothing
> +#
> +# Notes: The equivalent HMP command is delvm. See the @save-snapshot n=
otes.
> +#
> +# Examples:
> +#
> +# -> { "execute": "delete-snapshot", "arguments": { "name": "lastgood"=
 } }
> +# <- { "return": {} }
> +##
> +{ 'command': 'delete-snapshot',
> +  'data': {'name': 'str'} }
> +
>  ##
>  # @cont:
>  #
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nRF6KikCy7s6p1r6B6yUGIx7rN8epJadK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpTd6MACgkQp6FrSiUn
Q2q8lgf8C7Il0227giUrz61eEA8KxyaayQa36LuhpTENdTe5vU9CrvbDs0FXsmZC
1Dl1K4gCQm1lSm1pPU1ExucRB0cUxjxJYSfxjvU5JD4MBBUsItAg6eMrZn9JaRy4
87dbQThpv8hB3nVAKnY4VBrZmsWeU1B6bgbSvB+/clJ/xqz8eczhtLQhG8T81X2k
Du+bPPe1vUCrrCYiOiWTbU/vaSW9hR6Xd3rgy/aNYe63Su/WJsxBS8S8fukqQ60l
8MSnHe/N/kmXjHWcRqYArDaYBshNHA6lL9eNO6FLzXHvyNJNQNHx3S+UUJjAhO83
D33Cgr0tBOU8AdlTskM7DiQ+XBzCKw==
=G7x/
-----END PGP SIGNATURE-----

--nRF6KikCy7s6p1r6B6yUGIx7rN8epJadK--
