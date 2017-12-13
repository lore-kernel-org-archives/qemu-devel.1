Received: from eggs.gnu.org ([2001:4830:134:3::10]:38300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eP95z-0006VB-1W
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:37:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eP95u-0005lf-3k
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:37:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eP95t-0005kV-TC
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:37:14 -0500
Date: Wed, 13 Dec 2017 15:37:02 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171213153702.GF7173@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7cm2iqirTL37Ot+N"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-6-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 05/26] qjson: add "opaque" field to
 JSONMessageParser
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--7cm2iqirTL37Ot+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:51:39PM +0800, Peter Xu wrote:
> diff --git a/qga/main.c b/qga/main.c
> index 62a62755bd..3b5ebbc1ee 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -593,7 +593,8 @@ static void process_command(GAState *s, QDict *req)
>  }
> =20
>  /* handle requests/control events coming in over the channel */
> -static void process_event(JSONMessageParser *parser, GQueue *tokens)
> +static void process_event(JSONMessageParser *parser, GQueue *tokens,
> +                          void *opaque)
>  {
>      GAState *s =3D container_of(parser, GAState, parser);
>      QDict *qdict;
> @@ -1320,7 +1321,7 @@ static int run_agent(GAState *s, GAConfig *config, =
int socket_activation)
>      s->command_state =3D ga_command_state_new();
>      ga_command_state_init(s, s->command_state);
>      ga_command_state_init_all(s->command_state);
> -    json_message_parser_init(&s->parser, process_event);
> +    json_message_parser_init(&s->parser, process_event, NULL);

This patch leaves the code with 2 ways of getting at state from the
parser pointer:
1. Use container_of() like existing users.
2. Use the new (unused) opaque argument.

Given that #1 exists, is this patch really necessary?

Please explain in the commit description, don't make me look ahead in
the patch series.

Stefan

--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMUkeAAoJEJykq7OBq3PIfLoH/02RVr2LKw2dCS3EMTD/JyEL
29poH+HGUQJVEWqrMB57HfBYxRQ18AcCzkQN+kYLa8ou0xC1b42aOMezRs5okk9H
otgbxpgDvq9yD6hl4IT05gqbpQLD4jwr9nUJqrjN3bbM2ZDr1RKufA5urk215u0r
XpJzs9t2ph8H5iapCB9Npy6nwfjqpzJaXImjFFWq5/iT2X0Y2OBF+Bn8iFcEcqCJ
POVyVceEw2Xi3VlokE/E8fX7L5eBuhXapx4EmNBUQ44uel7OKK4uu4esfXwQoone
/NUlxDPhpYMUwRDt4nSXQ1f1w0D3qQvAcWgjxq9Ne2bnSViFclVL5xDEgzTiRJE=
=831w
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--
