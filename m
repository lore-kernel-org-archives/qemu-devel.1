Received: from eggs.gnu.org ([2001:4830:134:3::10]:51538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDUJo-0005FM-FQ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDUJn-0003gP-6u
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:55:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gDUJm-0003eM-Sg
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:55:55 -0400
Date: Fri, 19 Oct 2018 13:55:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181019125545.GT13722@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181009130442.26296-1-berrange@redhat.com>
	<20181009130442.26296-11-berrange@redhat.com>
	<d8312d1b-4c21-65f7-72eb-380a91f4459f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d8312d1b-4c21-65f7-72eb-380a91f4459f@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 10/11] authz: add QAuthZPAM object type
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

On Fri, Oct 19, 2018 at 12:02:57PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 09/10/2018 15:04, Daniel P. Berrang=C3=A9 wrote:
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
> >  authz/Makefile.objs     |   3 +
> >  authz/pamacct.c         | 149 ++++++++++++++++++++++++++++++++++++++=
++
> >  authz/trace-events      |   3 +
> >  configure               |  37 ++++++++++
> >  include/authz/pamacct.h | 100 +++++++++++++++++++++++++++
> >  qemu-options.hx         |  35 ++++++++++
> >  6 files changed, 327 insertions(+)
> >  create mode 100644 authz/pamacct.c
> >  create mode 100644 include/authz/pamacct.h
> >=20
> > diff --git a/configure b/configure
> > index f89d293585..bca8fd1b49 100755
> > --- a/configure
> > +++ b/configure
> > +##########################################
> > +# PAM probe
> > +
> > +if test "x$auth_pam" !=3D "no"; then
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
> > +	    feature_not_found "PAM" "Install pam-devel"
>=20
> Not all distributions name this package 'pam-devel', but I think we get
> the message.

I'll squash in

diff --git a/configure b/configure
index 3ec5578c5a..db35d52e12 100755
--- a/configure
+++ b/configure
@@ -2902,7 +2902,7 @@ EOF
        auth_pam=3Dyes
     else
        if test "$auth_pam" =3D "yes"; then
-           feature_not_found "PAM" "Install pam-devel"
+           feature_not_found "PAM" "Install PAM development package"
        else
            auth_pam=3Dno
        fi


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
