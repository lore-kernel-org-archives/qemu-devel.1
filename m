Received: from eggs.gnu.org ([2001:4830:134:3::10]:44006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwubl-0002HG-JE
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwubk-0001ar-5O
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:29:25 -0400
References: <20170926175942.GE14717@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c8191d37-28e3-1acd-797f-0c456f44541e@redhat.com>
Date: Tue, 26 Sep 2017 13:29:13 -0500
MIME-Version: 1.0
In-Reply-To: <20170926175942.GE14717@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KioL5cHgcNF31iCHnQRB1DXekXA6DulBh"
Subject: Re: [Qemu-devel] blockdev-commit design
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, jcody@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KioL5cHgcNF31iCHnQRB1DXekXA6DulBh
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 jcody@redhat.com
Message-ID: <c8191d37-28e3-1acd-797f-0c456f44541e@redhat.com>
Subject: Re: blockdev-commit design
References: <20170926175942.GE14717@localhost.localdomain>
In-Reply-To: <20170926175942.GE14717@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/26/2017 12:59 PM, Kevin Wolf wrote:
> Hi,
>=20
> as the next step after my commit block job fixes, I'm trying to
> implement a new, clean version of the QMP command, which I'm calling
> blockdev-commit for consistency with all the other "modern" QMP
> commands.
>=20
> I'll start with the schema that I have so far:
>=20
> { 'command': 'blockdev-commit',
>   'data': { 'job-id': 'str', 'top': 'str', '*base': 'str'
>             '*backing-file': 'str', '*speed': 'int',
>             '*filter-node-name': 'str' } }

Seems okay at first glance, modulo your discussion below on active vs.
passive.

>=20
> In comparison with the old command, the important changes are:
>=20
>   * top/base are node names instead of file names.

I can agree to that.  Do we still allow device names to resolve into the
top-most node attached to the device? That matters for 'top', but not
for 'base'.

>=20
>   * You don't need to specify the active layer any more (not the least
>     because there could very well be more than one of them), but top
>     becomes mandatory instead.

Libvirt should be fine with that.

>=20
>   * top/base don't accept device (BlockBackend) names, so for
>     consistency with other block jobs, job-id becomes mandatory.
>=20
>     Possible alternative: Accept device names and make them the default=

>     for job-id. This is more consistent with existing blockdev-*
>     commands, but I consider BlockBackend names deprecated, so I prefer=

>     not adding them here.

Oh, you're answering my question above.  I'm okay if job-id is
mandatory, even if we allow the shortcut of a device name for 'top'
mapping to its attached active node.

>=20
>   * filer-node-name is kept optional for now. Should we make it
>     mandatory, too?
>=20
> This was the easy part. Then I started looking at the code and found a
> few a bit more interesting questions:
>=20
>   * The old block-commit command decides between an "actual" commit job=

>     and the mirror-based active commit based on whether top is the
>     active layer.

And libvirt HAS to know whether it is requesting an active vs.
intermediate commit job up front, because the two code paths have
different expected signals for handling job completion (it is only
active commit that reaches a ready point between phases, requiring
further QMP commands to end the job).

>=20
>     We don't get an option for the active layer any more now, so this
>     isn't how things can work for blockdev-commit. We could probably
>     check whether top has a BlockBackend parent, but that's not really
>     what we're interested in anyway. Maybe the best we could do to
>     decide this automatically is to check whether there is any parent o=
f
>     top that requires write permissions. If there is, we need active
>     commit, otherwise the "normal" one is good enough.
>=20
>     However, who says that the intentions of the user stay as we deduce=

>     them at the start of the block job? Who says that the user doesn't
>     want to add a writable disk as a user of the node while the block
>     job is running?
>=20
>     The optimal solution to this would be that the commit filter node
>     responds to permission requests and switches between active and
>     "normal" commit mode. I'm not sure how hard this would be to
>     implement.
>=20
>     As long as we don't have the automatic switch, do we have to allow
>     the user to specify explicitly which mode they want instead of
>     automatically choosing one?

When committing one read-only image into another, you don't need the
active mode.  On the other hand, committing a writeable image generally
means you don't want to lose any data, even as further writes happen
while the job is ongoing.  Does a "normal" mode commit make sense on a
writeable image (perhaps as a point-in-time operation: all data that was
present when the job started gets written, but if we do a NEW write, we
make sure to FIRST commit the old data into the backing file then do the
write into the active layer, and mark that cluster as no longer needing
commit), differently from an "active" mode commit (a write to the active
layer dirties the cluster, and we make as many passes as necessary,
possibly writing some clusters to the backing file multiple times, so
that the backing file contains the contents at the point the job ends
rather than starts).

With our existing active commit code, is there a way to do an
intermediate style commit instead of an active commit (by passing the
node name instead of the device name, even though it resolves to the
same 'top' node)?

Maybe an optional boolean is worth having, where we default to active if
'top' is writable and 'normal' otherwise; but can set the boolean to
force 'normal' even on a writable, and where setting the boolean on
something that is not writable is either a no-op or an error?

>=20
>   * The 'backing-file' option (which specifies the new backing file
>     string for parents after the commit job completes) is currently not=

>     allowed if top is the active layer. If we allow graph changes, this=

>     doesn't seem to make sense to me because even if top doesn't have a=

>     parent node when the job starts, it could have one when it's
>     completed.

Based on your recent patch series, I think we're still murky on exactly
what graph changes the op-blockers are going to prevent.  But allowing
'backing-file' even when 'top' starts life as the active layer makes
sense, as we may create a snapshot or some other operation that changes
'top' into something that is no longer active, without invalidating the
fact that we are doing a commit job (but there's also the tricky issue
of whether libvirt should expect only one event with no followup command
to end the job, or two events marking the two phases where a followup is
necessary).

>=20
> Any opinions on this, especially the active/normal commit thing?
>=20
> Kevin
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KioL5cHgcNF31iCHnQRB1DXekXA6DulBh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnKnHkACgkQp6FrSiUn
Q2oszwf+PNkv26Q4nkzSCYjn5+YBfRTTOlnm5hFHllX57FK0yqhAx4kZNGQjYWJY
pPdWjMJEdMaggAvSAUi+CSvSWPZNGDD6pCpaDIb4IHyAvGVfuhcwZdKrqpj0q6VR
G0Yh8jgft126HU1QBDyyqtCuw8vWpN913x2teKasuCKNDBsuUwKbY1T6rvM1oeDV
0rqyJKUODbgUSzCS/zCjGb8vzUG6P52Yyj55D88Z5Z/Dqh77EoUaSIbkM/GEDXba
6ZGJP9MVUL/ErxziPj2PV06r/LSYepfhvGnCS1l1Z67ipGQjessJL880ZnfJWkL7
fCVcGp9twN+uCqLHz27niO3PHFUKWg==
=osra
-----END PGP SIGNATURE-----

--KioL5cHgcNF31iCHnQRB1DXekXA6DulBh--
