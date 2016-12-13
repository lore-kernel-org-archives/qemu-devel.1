Received: from eggs.gnu.org ([2001:4830:134:3::10]:56225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGkSK-0005Af-A5
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:37:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGkSF-0008Lg-I4
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:37:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cGkSF-0008LJ-9f
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:37:03 -0500
Date: Tue, 13 Dec 2016 10:37:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20161213103700.GD3103@stefanha-x1.localdomain>
References: <20161212204313.anhjire2gkwd6gzi@grep.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline
In-Reply-To: <20161212204313.anhjire2gkwd6gzi@grep.be>
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
To: Wouter Verhelst <w@uter.be>
Cc: Eric Blake <eblake@redhat.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Pargmann <mpa@pengutronix.de>, "Denis V. Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 12, 2016 at 09:43:13PM +0100, Wouter Verhelst wrote:
> +- `NBD_OPT_LIST_META_CONTEXT` (10)
> +
> +    Return a list of `NBD_REP_META_CONTEXT` replies, one per context,
> +    followed by an `NBD_REP_ACK`. If a server replies to such a request
> +    with no error message, clients MAY send NBD_CMD_BLOCK_STATUS
> +    commands during the transmission phase.
> +
> +    If the query string is syntactically invalid, the server SHOULD send
> +    `NBD_REP_ERR_INVALID`. If the query string is syntactically valid
> +    but finds no metadata contexts, the server MUST send a single
> +    reply of type `NBD_REP_ACK`.
> +
> +    This option MUST NOT be requested unless structured replies have
> +    been negotiated first. If a client attempts to do so, a server
> +    SHOULD send `NBD_REP_ERR_INVALID`.
> +
> +    Data:
> +    - 32 bits, length of export name
> +    - String, name of export for which we wish to list or select metadata
> +      contexts.
> +    - 32 bits, length of query
> +    - String, query to select a subset of the available metadata
> +      contexts. If this is not specified (i.e., the "length of query"
> +      field is 0 and no query is sent), then the server MUST send all
> +      the metadata contexts it knows about. If specified, this query
> +      string MUST start with a name that uniquely identifies a server
> +      implementation; e.g., the reference implementation that
> +      accompanies this document would support query strings starting
> +      with 'nbd-server:'

What about querying "base:" if the NBD spec adds more standard metadata
contexts in the future?  "base:" does not "uniquely identify a server
implementation" but it should still be possible to query it so that
additional contexts can be added to this spec in the future.

Is the query matching algorithm defined anywhere?  I guess it is
strncmp(query, context, strlen(query)) but I'm not sure from this text.

Another common syntax would use an asterisk wildcard ('*') so that it's
possible to differentiate between full matches and (wildcard) partial
matches.

> +
> +    The server MUST reply with a list of `NBD_REP_META_CONTEXT` replies,
> +    followed by `NBD_REP_ACK`. The metadata context ID in these replies
> +    is reserved and SHOULD be set to zero; clients SHOULD disregard it.
> +
> +- `NBD_OPT_SET_META_CONTEXT` (11)
> +
> +    Change the set of active metadata contexts. Issuing this command
> +    replaces all previously-set metadata contexts; clients must ensure
> +    that all metadata contexts they're interested in are selected with
> +    the final query that they sent.
> +
> +    Data:
> +    - 32 bits, length of query
> +    - String, query to select metadata contexts. The syntax of this
> +      query is implementation-defined, except that it MUST start with a
> +      namespace. This namespace may be one of the following:
> +        - `base:`, for metadata contexts defined by this document;
> +        - `nbd-server:`, for metadata contexts defined by the
> +          implementation that accompanies this document (none
> +          currently);
> +        - `x-*:`, where `*` can be replaced by any random string not
> +          containing colons, for local experiments. This SHOULD NOT be
> +          used by metadata contexts that are expected to e widely used.

s/ e / be /

> +        - third-party implementations can register additional
> +          namespaces by simple request to the mailinglist.

Does this mean it is possible to activate multiple contexts but only if
their namespace is identical?  That seems like an arbitrary limitation.

In other words, the spec suggests you can activate nbd-server:a and
nbd-server:b but you cannot activate base:a and nbd-server:a.

I'd prefer a programming model where the contexts don't need to be set
for the lifetime of the connection.  Instead the client passes a bitmap
(64-bits?) of contexts along with each BLOCK_STATUS command.  That way
the client can select contexts on a per-command basis.  It's unlikely
that more than 64 contexts need to be available at once but I admit it's
an arbitrary limitation...

I guess you've considered this model and decided it's better to
negotiate upfront, it's wasteful to enable multiple contexts and then
discard the response data on the client side because only a subset is
needed for this command invocation.

> +
> +    The server MUST reply with a number of `NBD_REP_META_CONTEXT`
> +    replies, one for each selected metadata context, each with a unique
> +    metadata context ID. It is not an error if a
> +    `NBD_OPT_SET_META_CONTEXT` option does not select any metadata
> +    context, provided the client then does not attempt to issue
> +    `NBD_CMD_BLOCK_STATUS` commands.
> +
>  #### Option reply types
> =20
>  These values are used in the "reply type" field, sent by the server
> @@ -882,7 +989,7 @@ during option haggling in the fixed newstyle negotiat=
ion.
>      information is available, or when sending data related to the option
>      (in the case of `NBD_OPT_LIST`) has finished. No data.
> =20
> -* `NBD_REP_SERVER` (2)
> +- `NBD_REP_SERVER` (2)
> =20
>      A description of an export. Data:
> =20
> @@ -897,10 +1004,18 @@ during option haggling in the fixed newstyle negot=
iation.
>        particular client request, this field is defined to be a string
>        suitable for direct display to a human being.
> =20
> -* `NBD_REP_INFO` (3)
> +- `NBD_REP_INFO` (3)
> =20
>      Defined by the experimental `INFO` [extension](https://github.com/Ne=
tworkBlockDevice/nbd/blob/extension-info/doc/proto.md).
> =20
> +- `NBD_REP_META_CONTEXT` (4)
> +
> +    A description of a metadata context. Data:
> +
> +    - 32 bits, NBD metadata context ID.
> +    - String, name of the metadata context. This is not required to be
> +      a human-readable string, but it MUST be valid UTF-8 data.
> +
>  There are a number of error reply types, all of which are denoted by
>  having bit 31 set. All error replies MAY have some data set, in which
>  case that data is an error message string suitable for display to the us=
er.
> @@ -938,15 +1053,62 @@ case that data is an error message string suitable=
 for display to the user.
> =20
>      Defined by the experimental `INFO` [extension](https://github.com/Ne=
tworkBlockDevice/nbd/blob/extension-info/doc/proto.md).
> =20
> -* `NBD_REP_ERR_SHUTDOWN` (2^32 + 7)
> +* `NBD_REP_ERR_SHUTDOWN` (2^31 + 7)
> =20
>      The server is unwilling to continue negotiation as it is in the
>      process of being shut down.
> =20
> -* `NBD_REP_ERR_BLOCK_SIZE_REQD` (2^32 + 8)
> +* `NBD_REP_ERR_BLOCK_SIZE_REQD` (2^31 + 8)

Are these separate fixes that slipped into the patch?  Not directly
relevant to BLOCK_STATUS.

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYT89MAAoJEJykq7OBq3PIOyUH/2+cjEFnMCOWUrtgSJFgW9Sr
9olKbEAWi8mOQ7VNBHdjP+pQ6c0iigyBudRcWdrKxht1iBQrIomzUHu8oJsTn3um
pfOem4mEgQeFLnfQ8O//4k2z8XNbiZxwJqDkS2l8WiAjAffI9rFunAa3O/Grun8I
vmY8LBwAbSylXh4QPUEZt34XUPvXd4Ogv5iJvmKw/bR/8MgzGI99KWoHLkphQr1D
IjxvttFEXcaFXmvcjHeJSd04aqPA5BjoMOI9lircc38LRQiDOk2cUqi9YqFZ8xmY
S2EQR/G2uJbUysmKKl4Hi+gYWj5w/LOT9a3o4CN+XLDv2fP0UAjd8P14O62eu1I=
=tSiE
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
