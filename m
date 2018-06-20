Received: from eggs.gnu.org ([2001:4830:134:3::10]:42657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVe0r-0001yr-Ep
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVe0p-00046v-Vi
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:23:09 -0400
Date: Wed, 20 Jun 2018 15:22:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180620142252.GM2549@work-vm>
References: <20180620121423.16979-1-berrange@redhat.com>
	<20180620121423.16979-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180620121423.16979-2-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/6] qemu-nbd: add support for
 authorization of TLS clients
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>=20
> Currently any client which can complete the TLS handshake is able to us=
e
> the NBD server. The server admin can turn on the 'verify-peer' option
> for the x509 creds to require the client to provide a x509 certificate.
> This means the client will have to acquire a certificate from the CA
> before they are permitted to use the NBD server. This is still a fairly
> low bar to cross.
>=20
> This adds a '--tls-authz OBJECT-ID' option to the qemu-nbd command whic=
h
> takes the ID of a previously added 'QAuthZ' object instance. This will
> be used to validate the client's x509 distinguished name. Clients
> failing the authorization check will not be permitted to use the NBD
> server.
>=20
> For example to setup authorization that only allows connection from a c=
lient
> whose x509 certificate distinguished name is
>=20
>    CN=3Dlaptop.example.com,O=3DExample Org,L=3DLondon,ST=3DLondon,C=3DG=
B
>=20
> use:
>=20
>   qemu-nbd --object tls-creds-x509,id=3Dtls0,dir=3D/home/berrange/qemut=
ls,\
>                     endpoint=3Dserver,verify-peer=3Dyes \
>            --object authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop.exam=
ple.com,,\
>                     O=3DExample Org,,L=3DLondon,,ST=3DLondon,,C=3DGB \

I'm confused about how that gets parsed, what differentiates the ,s
that separate the arguments (e.g. ,id=3D  ,identity=3D) and the ,s that
separate the options within the identity string (e.g. the ,ST=3DLondon)
Would:
  --object authz-simple,identity=3DCN=3Dlaptop.example.com,,O=3DExample O=
rg,,L=3DLondon,,ST=3DLondon,,C=3DGB,id=3Dauth0

be equivalent?

Dave


>            --tls-creds tls0 \
>            --tls-authz authz0
> 	   ....other qemu-nbd args...
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  include/block/nbd.h |  2 +-
>  nbd/server.c        | 10 +++++-----
>  qemu-nbd.c          | 13 ++++++++++++-
>  qemu-nbd.texi       |  4 ++++
>  4 files changed, 22 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index fcdcd54502..80ea9d240c 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -307,7 +307,7 @@ void nbd_export_close_all(void);
>  void nbd_client_new(NBDExport *exp,
>                      QIOChannelSocket *sioc,
>                      QCryptoTLSCreds *tlscreds,
> -                    const char *tlsaclname,
> +                    const char *tlsauthz,
>                      void (*close_fn)(NBDClient *, bool));
>  void nbd_client_get(NBDClient *client);
>  void nbd_client_put(NBDClient *client);
> diff --git a/nbd/server.c b/nbd/server.c
> index 9e1f227178..4f10f08dc0 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -100,7 +100,7 @@ struct NBDClient {
> =20
>      NBDExport *exp;
>      QCryptoTLSCreds *tlscreds;
> -    char *tlsaclname;
> +    char *tlsauthz;
>      QIOChannelSocket *sioc; /* The underlying data channel */
>      QIOChannel *ioc; /* The current I/O channel which may differ (eg T=
LS) */
> =20
> @@ -677,7 +677,7 @@ static QIOChannel *nbd_negotiate_handle_starttls(NB=
DClient *client,
> =20
>      tioc =3D qio_channel_tls_new_server(ioc,
>                                        client->tlscreds,
> -                                      client->tlsaclname,
> +                                      client->tlsauthz,
>                                        errp);
>      if (!tioc) {
>          return NULL;
> @@ -1250,7 +1250,7 @@ void nbd_client_put(NBDClient *client)
>          if (client->tlscreds) {
>              object_unref(OBJECT(client->tlscreds));
>          }
> -        g_free(client->tlsaclname);
> +        g_free(client->tlsauthz);
>          if (client->exp) {
>              QTAILQ_REMOVE(&client->exp->clients, client, next);
>              nbd_export_put(client->exp);
> @@ -2140,7 +2140,7 @@ static coroutine_fn void nbd_co_client_start(void=
 *opaque)
>  void nbd_client_new(NBDExport *exp,
>                      QIOChannelSocket *sioc,
>                      QCryptoTLSCreds *tlscreds,
> -                    const char *tlsaclname,
> +                    const char *tlsauthz,
>                      void (*close_fn)(NBDClient *, bool))
>  {
>      NBDClient *client;
> @@ -2153,7 +2153,7 @@ void nbd_client_new(NBDExport *exp,
>      if (tlscreds) {
>          object_ref(OBJECT(client->tlscreds));
>      }
> -    client->tlsaclname =3D g_strdup(tlsaclname);
> +    client->tlsauthz =3D g_strdup(tlsauthz);
>      client->sioc =3D sioc;
>      object_ref(OBJECT(client->sioc));
>      client->ioc =3D QIO_CHANNEL(sioc);
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index 51b9d38c72..c0c9c805c0 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -52,6 +52,7 @@
>  #define QEMU_NBD_OPT_TLSCREDS      261
>  #define QEMU_NBD_OPT_IMAGE_OPTS    262
>  #define QEMU_NBD_OPT_FORK          263
> +#define QEMU_NBD_OPT_TLSAUTHZ      264
> =20
>  #define MBR_SIZE 512
> =20
> @@ -66,6 +67,7 @@ static int shared =3D 1;
>  static int nb_fds;
>  static QIONetListener *server;
>  static QCryptoTLSCreds *tlscreds;
> +static const char *tlsauthz;
> =20
>  static void usage(const char *name)
>  {
> @@ -355,7 +357,7 @@ static void nbd_accept(QIONetListener *listener, QI=
OChannelSocket *cioc,
>      nb_fds++;
>      nbd_update_server_watch();
>      nbd_client_new(newproto ? NULL : exp, cioc,
> -                   tlscreds, NULL, nbd_client_closed);
> +                   tlscreds, tlsauthz, nbd_client_closed);
>  }
> =20
>  static void nbd_update_server_watch(void)
> @@ -533,6 +535,7 @@ int main(int argc, char **argv)
>          { "image-opts", no_argument, NULL, QEMU_NBD_OPT_IMAGE_OPTS },
>          { "trace", required_argument, NULL, 'T' },
>          { "fork", no_argument, NULL, QEMU_NBD_OPT_FORK },
> +        { "tls-authz", no_argument, NULL, QEMU_NBD_OPT_TLSAUTHZ },
>          { NULL, 0, NULL, 0 }
>      };
>      int ch;
> @@ -755,6 +758,9 @@ int main(int argc, char **argv)
>              g_free(trace_file);
>              trace_file =3D trace_opt_parse(optarg);
>              break;
> +        case QEMU_NBD_OPT_TLSAUTHZ:
> +            tlsauthz =3D optarg;
> +            break;
>          case QEMU_NBD_OPT_FORK:
>              fork_process =3D true;
>              break;
> @@ -819,6 +825,11 @@ int main(int argc, char **argv)
>                           error_get_pretty(local_err));
>              exit(EXIT_FAILURE);
>          }
> +    } else {
> +        if (tlsauthz) {
> +            error_report("--tls-authz is not permitted without --tls-c=
reds");
> +            exit(EXIT_FAILURE);
> +        }
>      }
> =20
>      if (disconnect) {
> diff --git a/qemu-nbd.texi b/qemu-nbd.texi
> index 9a84e81eed..7f9503cf05 100644
> --- a/qemu-nbd.texi
> +++ b/qemu-nbd.texi
> @@ -91,6 +91,10 @@ of the TLS credentials object previously created wit=
h the --object
>  option.
>  @item --fork
>  Fork off the server process and exit the parent once the server is run=
ning.
> +@item --tls-authz=3DID
> +Specify the ID of a qauthz object previously created with the
> +--object option. This will be used to authorize connecting users
> +against their x509 distinguished name.
>  @item -v, --verbose
>  Display extra debugging information
>  @item -h, --help
> --=20
> 2.17.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
