Received: from eggs.gnu.org ([209.51.188.92]:37638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gx9sZ-0005Wz-B1
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gx9sY-0004Wp-2m
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:24:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gx9sX-0004Uu-Mp
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:24:33 -0500
Date: Fri, 22 Feb 2019 12:24:23 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190222122423.GR25234@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190215155709.15777-1-berrange@redhat.com>
	<20190215155709.15777-11-berrange@redhat.com>
	<81a05e66-016c-db53-c3f5-2607bb8c515e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <81a05e66-016c-db53-c3f5-2607bb8c515e@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 10/11] authz: add QAuthZPAM object type
 for authorizing using PAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Fri, Feb 22, 2019 at 01:34:12AM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi Daniel,
>=20
> On 2/15/19 4:57 PM, Daniel P. Berrang=C3=A9 wrote:
> > From: "Daniel P. Berrange" <berrange@redhat.com>
> >=20
> > Add an authorization backend that talks to PAM to check whether the u=
ser
> > identity is allowed. This only uses the PAM account validation facili=
ty,
> > which is essentially just a check to see if the provided username is =
permitted
> > access. It doesn't use the authentication or session parts of PAM, si=
nce
> > that's dealt with by the relevant part of QEMU (eg VNC server).
> >=20
> > Consider starting QEMU with a VNC server and telling it to use TLS wi=
th
> > x509 client certificates and configuring it to use an PAM to validate
> > the x509 distinguished name. In this example we're telling it to use =
PAM
> > for the QAuthZ impl with a service name of "qemu-vnc"
> >=20
> >  $ qemu-system-x86_64 \
> >      -object tls-creds-x509,id=3Dtls0,dir=3D/home/berrange/security/q=
emutls,\
> >              endpoint=3Dserver,verify-peer=3Dyes \
> >      -object authz-pam,id=3Dauthz0,service=3Dqemu-vnc \
> >      -vnc :1,tls-creds=3Dtls0,tls-authz=3Dauthz0
> >=20
> > This requires an /etc/pam/qemu-vnc file to be created with the auth
> > rules. A very simple file based whitelist can be setup using
> >=20
> >   $ cat > /etc/pam/qemu-vnc <<EOF
> >   account         requisite       pam_listfile.so item=3Duser sense=3D=
allow file=3D/etc/qemu/vnc.allow
> >   EOF
> >=20
> > The /etc/qemu/vnc.allow file simply contains one username per line. A=
ny
> > username not in the file is denied. The usernames in this example are
> > the x509 distinguished name from the client's x509 cert.
> >=20
> >   $ cat > /etc/qemu/vnc.allow <<EOF
> >   CN=3Dlaptop.berrange.com,O=3DBerrange Home,L=3DLondon,ST=3DLondon,C=
=3DGB
> >   EOF
> >=20
> > More interesting would be to configure PAM to use an LDAP backend, so
> > that the QEMU authorization check data can be centralized instead of
> > requiring each compute host to have file maintained.
> >=20
> > The main limitation with this PAM module is that the rules apply to a=
ll
> > QEMU instances on the host. Setting up different rules per VM, would
> > require creating a separate PAM service name & config file for every
> > guest. An alternative approach for the future might be to not pass in
> > the plain username to PAM, but instead combine the VM name or UUID wi=
th
> > the username. This requires further consideration though.
> >=20
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---

> > +static bool qauthz_pam_is_allowed(QAuthZ *authz,
> > +                                  const char *identity,
> > +                                  Error **errp)
> > +{
> > +    QAuthZPAM *pauthz =3D QAUTHZ_PAM(authz);
> > +    const struct pam_conv pam_conversation =3D { 0 };
> > +    pam_handle_t *pamh =3D NULL;
> > +    int ret;
> > +
> > +    trace_qauthz_pam_check(authz, identity, pauthz->service);
> > +    ret =3D pam_start(pauthz->service,
> > +                    identity,
> > +                    &pam_conversation,
> > +                    &pamh);
> > +    if (ret !=3D PAM_SUCCESS) {
> > +        error_setg(errp, "Unable to start PAM transaction: %s",
> > +                   pam_strerror(NULL, ret));
> > +        return false;
> > +    }
> > +
> > +    ret =3D pam_acct_mgmt(pamh, PAM_SILENT);
> > +    if (ret !=3D PAM_SUCCESS) {
> > +        error_setg(errp, "Unable to authorize user '%s': %s",
> > +                   identity, pam_strerror(pamh, ret));
> > +        goto cleanup;
> > +    }
> > +
> > + cleanup:
> > +    pam_end(pamh, ret);
> > +    return ret =3D=3D PAM_SUCCESS;
> > +}
>=20
> I still need to digest this function (reading more about PAM).

FWIW there's reasonably good manpages 'pam(3)' and 'pam(8)' are
starting points.


> > @@ -2864,6 +2870,33 @@ else
> >  fi
> > =20
> > =20
> > +##########################################
> > +# PAM probe
> > +
> > +if test "x$auth_pam" !=3D "no"; then
>=20
> Either check "x$auth_pam" !=3D "xno", or "$auth_pam" !=3D "no" (the lat=
ter
> seems to follow the style of this file).
>=20
> Currently this condition is always true, so the script always calls
> compile_prog. And if an user has PAM locally installed, it is not
> possible to not use it.

Opps, yes, did I say I hate shell :-)

>=20
> > +    cat > $TMPC <<EOF
> > +#include <security/pam_appl.h>
> > +#include <stdio.h>
> > +int main(void) {
> > +   const char *service_name =3D "qemu";
> > +   const char *user =3D "frank";
> > +   const struct pam_conv *pam_conv =3D NULL;
> > +   pam_handle_t *pamh =3D NULL;
> > +   pam_start(service_name, user, pam_conv, &pamh);
> > +   return 0;
> > +}
> > +EOF
> > +    if compile_prog "" "-lpam" ; then
> > +	auth_pam=3Dyes
> > +    else
> > +	if test "$auth_pam" =3D "yes"; then
> > +	    feature_not_found "PAM" "Install PAM development package"
> > +	else
> > +	    auth_pam=3Dno
> > +	fi
> > +    fi

I notice some indentation damage here now due to tabs that I'll also
fix.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
