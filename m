Received: from eggs.gnu.org ([2001:4830:134:3::10]:50744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cGm28-00018r-0M
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:18:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cGm23-0000iS-TB
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:18:12 -0500
Received: from [2a01:4f8:140:52e5::2] (port=36868 helo=latin.grep.be)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wouter@grep.be>) id 1cGm23-0000iH-Is
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:18:07 -0500
Date: Tue, 13 Dec 2016 13:17:49 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20161213121749.l572tsrnmnhnckvq@grep.be>
References: <20161212204313.anhjire2gkwd6gzi@grep.be>
	<20161213103700.GD3103@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b355bnarjb2gzp7s"
Content-Disposition: inline
In-Reply-To: <20161213103700.GD3103@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Nbd] [PATCH v5] doc: Add NBD_CMD_BLOCK_STATUS
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Pargmann <mpa@pengutronix.de>, "Denis V. Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>


--b355bnarjb2gzp7s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2016 at 10:37:00AM +0000, Stefan Hajnoczi wrote:
> On Mon, Dec 12, 2016 at 09:43:13PM +0100, Wouter Verhelst wrote:
> > +- `NBD_OPT_LIST_META_CONTEXT` (10)
> > +
> > +    Return a list of `NBD_REP_META_CONTEXT` replies, one per context,
> > +    followed by an `NBD_REP_ACK`. If a server replies to such a request
> > +    with no error message, clients MAY send NBD_CMD_BLOCK_STATUS
> > +    commands during the transmission phase.
> > +
> > +    If the query string is syntactically invalid, the server SHOULD se=
nd
> > +    `NBD_REP_ERR_INVALID`. If the query string is syntactically valid
> > +    but finds no metadata contexts, the server MUST send a single
> > +    reply of type `NBD_REP_ACK`.
> > +
> > +    This option MUST NOT be requested unless structured replies have
> > +    been negotiated first. If a client attempts to do so, a server
> > +    SHOULD send `NBD_REP_ERR_INVALID`.
> > +
> > +    Data:
> > +    - 32 bits, length of export name
> > +    - String, name of export for which we wish to list or select metad=
ata
> > +      contexts.
> > +    - 32 bits, length of query
> > +    - String, query to select a subset of the available metadata
> > +      contexts. If this is not specified (i.e., the "length of query"
> > +      field is 0 and no query is sent), then the server MUST send all
> > +      the metadata contexts it knows about. If specified, this query
> > +      string MUST start with a name that uniquely identifies a server
> > +      implementation; e.g., the reference implementation that
> > +      accompanies this document would support query strings starting
> > +      with 'nbd-server:'
>=20
> What about querying "base:" if the NBD spec adds more standard metadata
> contexts in the future?  "base:" does not "uniquely identify a server
> implementation" but it should still be possible to query it so that
> additional contexts can be added to this spec in the future.

If that happens, we can update the spec to define how you can select
more than one context.

> Is the query matching algorithm defined anywhere?  I guess it is
> strncmp(query, context, strlen(query)) but I'm not sure from this text.

It was my intent to allow namespaces to define their own matching
algorithm. A simple strncmp could certainly work, but I could imagine
that some more complicated scheme could work too (e.g., a syntax to ask
"all snapshots created between date X and date Y")

> Another common syntax would use an asterisk wildcard ('*') so that it's
> possible to differentiate between full matches and (wildcard) partial
> matches.

Yes.

> > +    The server MUST reply with a list of `NBD_REP_META_CONTEXT` replie=
s,
> > +    followed by `NBD_REP_ACK`. The metadata context ID in these replies
> > +    is reserved and SHOULD be set to zero; clients SHOULD disregard it.
> > +
> > +- `NBD_OPT_SET_META_CONTEXT` (11)
> > +
> > +    Change the set of active metadata contexts. Issuing this command
> > +    replaces all previously-set metadata contexts; clients must ensure
> > +    that all metadata contexts they're interested in are selected with
> > +    the final query that they sent.
> > +
> > +    Data:
> > +    - 32 bits, length of query
> > +    - String, query to select metadata contexts. The syntax of this
> > +      query is implementation-defined, except that it MUST start with a
> > +      namespace. This namespace may be one of the following:
> > +        - `base:`, for metadata contexts defined by this document;
> > +        - `nbd-server:`, for metadata contexts defined by the
> > +          implementation that accompanies this document (none
> > +          currently);
> > +        - `x-*:`, where `*` can be replaced by any random string not
> > +          containing colons, for local experiments. This SHOULD NOT be
> > +          used by metadata contexts that are expected to e widely used.
>=20
> s/ e / be /

Thanks, fixed that.

> > +        - third-party implementations can register additional
> > +          namespaces by simple request to the mailinglist.
>=20
> Does this mean it is possible to activate multiple contexts but only if
> their namespace is identical?  That seems like an arbitrary limitation.
>
> In other words, the spec suggests you can activate nbd-server:a and
> nbd-server:b but you cannot activate base:a and nbd-server:a.

As written, it does. It was my intent (hence the addition of a field
"length of query") to add the ability to send multiple queries in one
SET_META_CONTEXT, and then this wouldn't be a problem. I now see that I
forgot to add the wording to that effect.

I'm adding the following to remedy this oversight:

diff --git a/doc/proto.md b/doc/proto.md
index 5737abe..e03f434 100644
--- a/doc/proto.md
+++ b/doc/proto.md
@@ -971,6 +971,9 @@ of the newstyle negotiation.
         - third-party implementations can register additional
           namespaces by simple request to the mailinglist.
=20
+    These two fields MAY be repeated as much as is necessary to select all
+    metadata contexts the client is interested in.
+
     The server MUST reply with a number of `NBD_REP_META_CONTEXT`
     replies, one for each selected metadata context, each with a unique
     metadata context ID. It is not an error if a

> I'd prefer a programming model where the contexts don't need to be set
> for the lifetime of the connection.  Instead the client passes a bitmap
> (64-bits?) of contexts along with each BLOCK_STATUS command.  That way
> the client can select contexts on a per-command basis.  It's unlikely
> that more than 64 contexts need to be available at once but I admit it's
> an arbitrary limitation...
>=20
> I guess you've considered this model and decided it's better to
> negotiate upfront, it's wasteful to enable multiple contexts and then
> discard the response data on the client side because only a subset is
> needed for this command invocation.

I do agree that it might be nice to be able to enable or disable
particular metadata contexts for the lifetime of one BLOCK_STATUS
command. However, the problem then becomes one of "where do we do that".
The request header has a fixed size, and there is no space for such data
in the request header. This could be worked around in ways that do not
break compatibility with older implementations (not in the least because
we're defining a new command that needs to be negotiated first, and so
we could say that the server needs to understand a new request format),
but I haven't found a way to do so that doesn't strike me as "very
ugly".

In addition, most use cases that we've been presented with seem to
require only one or (at most) a handful of metadata contexts. In that
case, the ability to select which metadata contexts are to be used in
transmission doesn't strike me as a very useful possibility, which would
be used often. Given that, and given the problems described in the
previous paragraph, I'm not convinced it's worth complicating things
much over.

However, I could be convinced otherwise by strong arguments and by a
suggested spec for how to pass the required information in a clean way.

> > +    The server MUST reply with a number of `NBD_REP_META_CONTEXT`
> > +    replies, one for each selected metadata context, each with a unique
> > +    metadata context ID. It is not an error if a
> > +    `NBD_OPT_SET_META_CONTEXT` option does not select any metadata
> > +    context, provided the client then does not attempt to issue
> > +    `NBD_CMD_BLOCK_STATUS` commands.
> > +
> >  #### Option reply types
> > =20
> >  These values are used in the "reply type" field, sent by the server
> > @@ -882,7 +989,7 @@ during option haggling in the fixed newstyle negoti=
ation.
> >      information is available, or when sending data related to the opti=
on
> >      (in the case of `NBD_OPT_LIST`) has finished. No data.
> > =20
> > -* `NBD_REP_SERVER` (2)
> > +- `NBD_REP_SERVER` (2)
> > =20
> >      A description of an export. Data:
> > =20
> > @@ -897,10 +1004,18 @@ during option haggling in the fixed newstyle neg=
otiation.
> >        particular client request, this field is defined to be a string
> >        suitable for direct display to a human being.
> > =20
> > -* `NBD_REP_INFO` (3)
> > +- `NBD_REP_INFO` (3)
> > =20
> >      Defined by the experimental `INFO` [extension](https://github.com/=
NetworkBlockDevice/nbd/blob/extension-info/doc/proto.md).
> > =20
> > +- `NBD_REP_META_CONTEXT` (4)
> > +
> > +    A description of a metadata context. Data:
> > +
> > +    - 32 bits, NBD metadata context ID.
> > +    - String, name of the metadata context. This is not required to be
> > +      a human-readable string, but it MUST be valid UTF-8 data.
> > +
> >  There are a number of error reply types, all of which are denoted by
> >  having bit 31 set. All error replies MAY have some data set, in which
> >  case that data is an error message string suitable for display to the =
user.
> > @@ -938,15 +1053,62 @@ case that data is an error message string suitab=
le for display to the user.
> > =20
> >      Defined by the experimental `INFO` [extension](https://github.com/=
NetworkBlockDevice/nbd/blob/extension-info/doc/proto.md).
> > =20
> > -* `NBD_REP_ERR_SHUTDOWN` (2^32 + 7)
> > +* `NBD_REP_ERR_SHUTDOWN` (2^31 + 7)
> > =20
> >      The server is unwilling to continue negotiation as it is in the
> >      process of being shut down.
> > =20
> > -* `NBD_REP_ERR_BLOCK_SIZE_REQD` (2^32 + 8)
> > +* `NBD_REP_ERR_BLOCK_SIZE_REQD` (2^31 + 8)
>=20
> Are these separate fixes that slipped into the patch?  Not directly
> relevant to BLOCK_STATUS.

Yeah, like I said, they were. I should probably update master (and
structured reply) to fix this, but it's not been as important ;-)

--=20
< ron> I mean, the main *practical* problem with C++, is there's like a doz=
en
       people in the world who think they really understand all of its rule=
s,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12

--b355bnarjb2gzp7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEhzp22k7Yad9NSkS9wpQPlRvfCp0FAlhP5ukACgkQwpQPlRvf
Cp3Q1g//e5DZO6I2TktkiujW0ITHkVQMHtfyc9NXHfn1tMLyPdZrXY45qSOEa797
GRo8TgUhgsB8yl0Nd0w3z7hOEY8tvsQHoeJBrnzThndBJHg23IbWO01prCelgllo
pXVmV8IBqYWA6ysIStOA4mT33VxxBCMCNV1Y6X7x0QZDkldOaLIexFuClu09UB8F
jHFjSQLlaN6LVvxjm27sWokShNXPaGrEegV7UznSU8yYb+6ZgAAYsOFkXXgP5ux8
WP9r0qyPTQTE8rg5roTfmFexremzikW8k6CHhqz+96DoSKpZsMPbmQL8pq/Ynl1V
afE3egR9HP//YiNf1X0UG+94rDvk7vyJ019uW1wX0g1aILlpOSJotKn9Pb7HxwrR
q3OPdCB6jqP1K/qFpPTVfVGQTEkL4rcvVjSVTHGrr9Cveq5/VeuXO19UfLsr2Cig
DyQXdgoBt4HpBvYKiVMp65gq/38AxONJi3aPCM8iPS4W1Spt1/nastroJrCK3yCO
S6OIT8Iblo/XJnfCiLRkiT2/84Chk0KIm6C93kqH/0Hho+pxQiVRiohCH8Pvm8oI
j4JvO0JZ6wII3lAf25Ikmkjn5qZ5U5OwxH3ISm0m0UGc2WAYgMl1UpINQN/MXp1J
La4QP5a5fbqOGOr5aEhkXyceDHBnT3HII21xHxVFriPLIoBS9Ns=
=FMtd
-----END PGP SIGNATURE-----

--b355bnarjb2gzp7s--
