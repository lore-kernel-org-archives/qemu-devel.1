Received: from eggs.gnu.org ([2001:4830:134:3::10]:32871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVGCi-0000QK-6V
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVGCg-0000zI-KC
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:57:48 -0400
Date: Tue, 19 Jun 2018 13:57:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180619125734.GV20929@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180615155103.11924-1-berrange@redhat.com>
	<20180615155103.11924-6-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180615155103.11924-6-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/6] vnc: allow specifying a custom
 authorization object name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>

On Fri, Jun 15, 2018 at 04:51:02PM +0100, Daniel P. Berrang=C3=A9 wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>=20
> The VNC server has historically had support for ACLs to check both the
> SASL username and the TLS x509 distinguished name. The VNC server was
> responsible for creating the initial ACL, and the client app was then
> responsible for populating it with rules using the HMP 'acl_add' comman=
d.
>=20
> This is not satisfactory for a variety of reasons. There is no way to
> populate the ACLs from the command line, users are forced to use the
> HMP. With multiple network services all supporting TLS and ACLs now, it
> is desirable to be able to define a single ACL that is referenced by al=
l
> services.
>=20
> To address these limitations, two new options are added to the VNC
> server CLI. The 'tls-authz' option takes the ID of a QAuthZ object to
> use for checking TLS x509 distinguished names, and the 'sasl-authz'
> option takes the ID of another object to use for checking SASL username=
s.
>=20
> In this example, we setup two authorization rules. The first allows any
> client with a certificate issued by the 'RedHat' organization in the
> 'London' locality. The second ACL allows clients with either the
> 'joe@REDHAT.COM' or  'fred@REDHAT.COM' kerberos usernames. Both checks
> must pass for the user to be allowed.
>=20
>     $QEMU -object tls-creds-x509,id=3Dtls0,dir=3D/home/berrange/qemutls=
,\
>                   endpoint=3Dserver,verify-peer=3Dyes \
>           -object authz-simple,id=3Dauthz0,policy=3Ddeny,\
>                   rules.0.match=3DO=3DRedHat,,L=3DLondon,rules.0.policy=
=3Dallow \
>           -object authz-simple,id=3Dauthz1,policy=3Ddeny,\
>                   rules.0.match=3Dfred@REDHAT.COM,rules.0.policy=3Dallo=
w \
>                   rules.0.match=3Djoe@REDHAT.COM,rules.0.policy=3Dallow=
 \

Opps this msg is outdated, since we don't have ability to express
such nested properties with -object since I dropped my hacky impl
of that.

>           -vnc 0.0.0.0:1,tls-creds=3Dtls0,tls-authz=3Dauthz0,
> 	       sasl,sasl-authz=3Dauthz1 \
>           ...other QEMU args...
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-doc.texi | 11 +++-------
>  ui/vnc.c      | 58 +++++++++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 52 insertions(+), 17 deletions(-)
>=20
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index cd05760cac..5b7e3faab2 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2917,15 +2917,10 @@ The @code{-localtime} option has been replaced =
by @code{-rtc base=3Dlocaltime}.
> =20
>  The @code{-startdate} option has been replaced by @code{-rtc base=3D@v=
ar{date}}.
> =20
> -@subsection -virtioconsole (since 3.0.0)
> +@subsection -vnc acl (since 3.0.0)
> =20
> -Option @option{-virtioconsole} has been replaced by
> -@option{-device virtconsole}.
> -
> -@subsection -clock (since 3.0.0)
> -
> -The @code{-clock} option is ignored since QEMU version 1.7.0. There is=
 no
> -replacement since it is not needed anymore.
> +The @code{acl} option to the @code{-vnc} argument has been replaced
> +by the @code{tls-authz} and @code{sasl-authz} options.
> =20
>  @section QEMU Machine Protocol (QMP) commands
> =20
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 9fb8430c35..2da9433ca7 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3407,6 +3407,12 @@ static QemuOptsList qemu_vnc_opts =3D {
>          },{
>              .name =3D "acl",
>              .type =3D QEMU_OPT_BOOL,
> +        },{
> +            .name =3D "tls-authz",
> +            .type =3D QEMU_OPT_STRING,
> +        },{
> +            .name =3D "sasl-authz",
> +            .type =3D QEMU_OPT_STRING,
>          },{
>              .name =3D "lossy",
>              .type =3D QEMU_OPT_BOOL,
> @@ -3894,6 +3900,8 @@ void vnc_display_open(const char *id, Error **err=
p)
>      int saslErr;
>  #endif
>      int acl =3D 0;
> +    const char *tlsauthz;
> +    const char *saslauthz;
>      int lock_key_sync =3D 1;
>      int key_delay_ms;
> =20
> @@ -3999,7 +4007,33 @@ void vnc_display_open(const char *id, Error **er=
rp)
>              }
>          }
>      }
> +    if (qemu_opt_get(opts, "acl")) {
> +        error_report("The 'acl' option to -vnc is deprecated. "
> +                     "Please use the 'tls-authz' and 'sasl-authz' "
> +                     "options instead");
> +    }
>      acl =3D qemu_opt_get_bool(opts, "acl", false);
> +    tlsauthz =3D qemu_opt_get(opts, "tls-authz");
> +    if (acl && tlsauthz) {
> +        error_setg(errp, "'acl' option is mutually exclusive with the =
"
> +                   "'tls-authz' option");
> +        goto fail;
> +    }
> +    if (tlsauthz && !vd->tlscreds) {
> +        error_setg(errp, "'tls-authz' provided but TLS is not enabled"=
);
> +        goto fail;
> +    }
> +
> +    saslauthz =3D qemu_opt_get(opts, "sasl-authz");
> +    if (acl && saslauthz) {
> +        error_setg(errp, "'acl' option is mutually exclusive with the =
"
> +                   "'sasl-authz' option");
> +        goto fail;
> +    }
> +    if (saslauthz && !sasl) {
> +        error_setg(errp, "'sasl-authz' provided but SASL auth is not e=
nabled");
> +        goto fail;
> +    }
> =20
>      share =3D qemu_opt_get(opts, "share");
>      if (share) {
> @@ -4029,7 +4063,9 @@ void vnc_display_open(const char *id, Error **err=
p)
>          vd->non_adaptive =3D true;
>      }
> =20
> -    if (acl) {
> +    if (tlsauthz) {
> +        vd->tlsauthzid =3D g_strdup(tlsauthz);
> +    } else if (acl) {
>          if (strcmp(vd->id, "default") =3D=3D 0) {
>              vd->tlsauthzid =3D g_strdup("vnc.x509dname");
>          } else {
> @@ -4040,15 +4076,19 @@ void vnc_display_open(const char *id, Error **e=
rrp)
>                                                &error_abort));
>      }
>  #ifdef CONFIG_VNC_SASL
> -    if (acl && sasl) {
> -        if (strcmp(vd->id, "default") =3D=3D 0) {
> -            vd->sasl.authzid =3D g_strdup("vnc.username");
> -        } else {
> -            vd->sasl.authzid =3D g_strdup_printf("vnc.%s.username", vd=
->id);
> +    if (sasl) {
> +        if (saslauthz) {
> +            vd->sasl.authzid =3D g_strdup(saslauthz);
> +        } else if (acl) {
> +            if (strcmp(vd->id, "default") =3D=3D 0) {
> +                vd->sasl.authzid =3D g_strdup("vnc.username");
> +            } else {
> +                vd->sasl.authzid =3D g_strdup_printf("vnc.%s.username"=
, vd->id);
> +            }
> +            vd->sasl.authz =3D QAUTHZ(qauthz_list_new(vd->sasl.authzid=
,
> +                                                    QAUTHZ_LIST_POLICY=
_DENY,
> +                                                    &error_abort));
>          }
> -        vd->sasl.authz =3D QAUTHZ(qauthz_list_new(vd->sasl.authzid,
> -                                                QAUTHZ_LIST_POLICY_DEN=
Y,
> -                                                &error_abort));
>      }
>  #endif
> =20
> --=20
> 2.17.0
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
