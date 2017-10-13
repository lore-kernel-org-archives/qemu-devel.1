Received: from eggs.gnu.org ([2001:4830:134:3::10]:38351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e34EL-0002NO-Rr
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 13:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e34EK-0002u8-G2
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 13:58:41 -0400
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
	<20171012095319.136610-11-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <af788c65-e7f5-65f4-07e4-1978807d40e4@redhat.com>
Date: Fri, 13 Oct 2017 12:58:28 -0500
MIME-Version: 1.0
In-Reply-To: <20171012095319.136610-11-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u19RCICsJTFc5gXQgFW2nDvFiMf0sCU10"
Subject: Re: [Qemu-devel] [PATCH v3 10/13] nbd/client: refactor
 nbd_receive_starttls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u19RCICsJTFc5gXQgFW2nDvFiMf0sCU10
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <af788c65-e7f5-65f4-07e4-1978807d40e4@redhat.com>
Subject: Re: [PATCH v3 10/13] nbd/client: refactor nbd_receive_starttls
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
 <20171012095319.136610-11-vsementsov@virtuozzo.com>
In-Reply-To: <20171012095319.136610-11-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 04:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> Split out nbd_receive_simple_option to be reused for structured reply

s/receive/request/, but see [1]

> option.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/client.c     | 64 ++++++++++++++++++++++++++++++++++++++++--------=
--------
>  nbd/trace-events |  7 ++++---
>  2 files changed, 50 insertions(+), 21 deletions(-)
>=20
> diff --git a/nbd/client.c b/nbd/client.c
> index cd5a2c80ac..c8702a80b1 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -540,35 +540,63 @@ static int nbd_receive_query_exports(QIOChannel *=
ioc,
>      }
>  }
> =20
> -static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
> -                                        QCryptoTLSCreds *tlscreds,
> -                                        const char *hostname, Error **=
errp)
> +/* nbd_request_simple_option
> + * return 1 for successful negotiation,
> + *        0 if operation is unsupported,
> + *        -1 with errp set for any other error
> + */
> +static int nbd_request_simple_option(QIOChannel *ioc, int opt, Error *=
*errp)
>  {
>      nbd_opt_reply reply;

Unrelated, but a potential cleanup for a future patch: we really should
be using our preferred naming scheme, where this would be NBDOptReply or
similar.

> -    QIOChannelTLS *tioc;
> -    struct NBDTLSHandshakeData data =3D { 0 };
> =20
> -    trace_nbd_receive_starttls_request();
> -    if (nbd_send_option_request(ioc, NBD_OPT_STARTTLS, 0, NULL, errp) =
< 0) {
> -        return NULL;
> +    trace_nbd_receive_simple_option_request(opt, nbd_opt_lookup(opt));=


Naming of the trace doesn't quite match the naming of the function...

> +    if (nbd_send_option_request(ioc, opt, 0, NULL, errp) < 0) {
> +        return -1;
>      }
> =20
> -    trace_nbd_receive_starttls_reply();
> -    if (nbd_receive_option_reply(ioc, NBD_OPT_STARTTLS, &reply, errp) =
< 0) {
> -        return NULL;
> +    trace_nbd_receive_simple_option_reply(opt, nbd_opt_lookup(opt));

[1] ...However, trace_nbd_request_simple_option_request sounds silly.
Can we get by with the shorter nbd_simple_option() as the function name,
then have two traces nbd_simple_option_request and
nbd_simple_option_reply?  Or, recognize that nbd_receive_option_reply()
already traces everything, so this trace is redundant with that one.  In
fact, nbd_send_option_request also traces everything (it doesn't trace
payload, but we aren't sending payload; the only time we need two traces
instead of one is if the local trace can document payload before the
common trace documents everything else.  Another reason for redundant
traces is if you envision needing to trace one local thing without being
overwhelmed by the noise of a common trace firing for unrelated events,
but NBD startup is not that frequent to need fine-grained filtering on
the traces).

> +    if (nbd_receive_option_reply(ioc, opt, &reply, errp) < 0) {
> +        return -1;
>      }
> =20
> -    if (reply.type !=3D NBD_REP_ACK) {
> -        error_setg(errp, "Server rejected request to start TLS %" PRIx=
32,
> -                   reply.type);
> +    if (reply.length !=3D 0) {
> +        error_setg(errp, "Option %d ('%s') response length is %" PRIu3=
2
> +                   " (it should be zero)", opt, nbd_opt_lookup(opt),
> +                   reply.length);
>          nbd_send_opt_abort(ioc);

Just thinking aloud here. For starttls, the NBD spec already says
payload must be 0 length. But for NBD_OPT_STRUCTURED_REPLY, which is not
yet standardized, it is conceivable that in the future, we might have a
way for the server to return a payload to the ACK reply, which informs
the client what additional options have been unlocked by negotiating
structured reply (after all, we document that some options should not be
negotiated unless structured reply is negotiated first).  We don't have
that in the spec now, but writing our client to reject any payload from
the server (rather than silently ignoring the payload) means that we
can't ever write a server with that extended reply.  So it's worth
discussing on the NBD list whether we want to make any guarantees about
forcing a 0-length payload vs. allowing clients to ignore an
unrecognized non-empty payload.  Depending on what the NBD community
decides, the easiest approach here would be a 'bool ignore_payload'
parameter, true when requesting OPT_STRUCTURED_REPLY, false when
requesting OPT_STARTTLS.  But as this is all speculation, I'm also fine
with checking in your stricter version as-is for now; we have until qemu
2.11 is released to tweak our implementation as followups based on
conversations on the NBD list.

> +
> +    trace_nbd_receive_simple_option_approved(opt, nbd_opt_lookup(opt))=
;

Another trace that doesn't add much value.

So, here's what I'm squashing, before I give:
Reviewed-by: Eric Blake <eblake@redhat.com>

diff --git i/nbd/client.c w/nbd/client.c
index c8702a80b1..fa64ec1c5b 100644
--- i/nbd/client.c
+++ w/nbd/client.c
@@ -540,7 +540,7 @@ static int nbd_receive_query_exports(QIOChannel *ioc,=

     }
 }

-/* nbd_request_simple_option
+/* nbd_request_simple_option: Send an option request, and parse the repl=
y
  * return 1 for successful negotiation,
  *        0 if operation is unsupported,
  *        -1 with errp set for any other error
@@ -549,12 +549,10 @@ static int nbd_request_simple_option(QIOChannel
*ioc, int opt, Error **errp)
 {
     nbd_opt_reply reply;

-    trace_nbd_receive_simple_option_request(opt, nbd_opt_lookup(opt));
     if (nbd_send_option_request(ioc, opt, 0, NULL, errp) < 0) {
         return -1;
     }

-    trace_nbd_receive_simple_option_reply(opt, nbd_opt_lookup(opt));
     if (nbd_receive_option_reply(ioc, opt, &reply, errp) < 0) {
         return -1;
     }
@@ -579,7 +577,6 @@ static int nbd_request_simple_option(QIOChannel
*ioc, int opt, Error **errp)
         return -1;
     }

-    trace_nbd_receive_simple_option_approved(opt, nbd_opt_lookup(opt));
     return 1;
 }

diff --git i/nbd/trace-events w/nbd/trace-events
index 0c8138ab92..59c0718a6b 100644
--- i/nbd/trace-events
+++ w/nbd/trace-events
@@ -9,9 +9,6 @@ nbd_opt_go_info_unknown(int info, const char *name)
"Ignoring unknown info %d (%
 nbd_opt_go_info_block_size(uint32_t minimum, uint32_t preferred,
uint32_t maximum) "Block sizes are 0x%" PRIx32 ", 0x%" PRIx32 ", 0x%" PRI=
x32
 nbd_receive_query_exports_start(const char *wantname) "Querying export
list for '%s'"
 nbd_receive_query_exports_success(const char *wantname) "Found desired
export name '%s'"
-nbd_receive_simple_option_request(int opt, const char *name)
"Requesting option %d (%s) from server"
-nbd_receive_simple_option_reply(int opt, const char *name) "Getting
reply for option %d (%s) from server"
-nbd_receive_simple_option_approved(int opt, const char *name) "Option
%d (%s) approved"
 nbd_receive_starttls_new_client(void) "Setting up TLS"
 nbd_receive_starttls_tls_handshake(void) "Starting TLS handshake"
 nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receiving
negotiation tlscreds=3D%p hostname=3D%s"


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--u19RCICsJTFc5gXQgFW2nDvFiMf0sCU10
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlng/sQACgkQp6FrSiUn
Q2rnqwgAitNoeivRagUJ4cEQd4KkyZBpyMpxEnvlRatgIKZJxWn14ZtNK8ely96L
Bevo/ad1kwUM5W8GHLgMX1us3JOt8TAAgLsMl4fS8U3Ny/l9vuhZ+OSB8LS47AQz
hqN1ElgOpjGyoWP7UXSqcgXUBCEEaDvTjCFyXyKiBZ9G+H92RdYSwNm8RhpiS+8T
e7K7hLRBiIXb9ORMBbJiY0HPQ1JwEYwwZbHdBqF0oMQ9o28v9JAiWIca5j6hhadO
ztSIk+T34li+GN5luxJniklKWxGdb7252/R1RtxlH0CEss1wLOuKpRo0W7SWWs3j
frtQFuo2imKLxx2CIzNyghAM1UcQpQ==
=7x3R
-----END PGP SIGNATURE-----

--u19RCICsJTFc5gXQgFW2nDvFiMf0sCU10--
