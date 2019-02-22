Received: from eggs.gnu.org ([209.51.188.92]:34937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gxCH8-0000TB-7C
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:58:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gxC8s-0005V6-6y
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:49:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gxC8p-0005Jf-Ts
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:49:33 -0500
Date: Fri, 22 Feb 2019 14:49:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190222144912.GC25234@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190215155709.15777-1-berrange@redhat.com>
	<20190215155709.15777-11-berrange@redhat.com>
	<81a05e66-016c-db53-c3f5-2607bb8c515e@redhat.com>
	<20190222122423.GR25234@redhat.com>
	<23bcdd12-bcc6-f452-f1df-55bcbcd90bec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23bcdd12-bcc6-f452-f1df-55bcbcd90bec@redhat.com>
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

On Fri, Feb 22, 2019 at 02:27:26PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi Daniel,
>=20
> On 2/22/19 1:24 PM, Daniel P. Berrang=C3=A9 wrote:
> > On Fri, Feb 22, 2019 at 01:34:12AM +0100, Philippe Mathieu-Daud=C3=A9=
 wrote:
> >> Hi Daniel,
> >>
> >> On 2/15/19 4:57 PM, Daniel P. Berrang=C3=A9 wrote:
> >>> From: "Daniel P. Berrange" <berrange@redhat.com>
> >>>
> >>> Add an authorization backend that talks to PAM to check whether the=
 user
> >>> identity is allowed. This only uses the PAM account validation faci=
lity,
> >>> which is essentially just a check to see if the provided username i=
s permitted
> >>> access. It doesn't use the authentication or session parts of PAM, =
since
> >>> that's dealt with by the relevant part of QEMU (eg VNC server).
> >>>
> >>> Consider starting QEMU with a VNC server and telling it to use TLS =
with
> >>> x509 client certificates and configuring it to use an PAM to valida=
te
> >>> the x509 distinguished name. In this example we're telling it to us=
e PAM
> >>> for the QAuthZ impl with a service name of "qemu-vnc"
> >>>
> >>>  $ qemu-system-x86_64 \
> >>>      -object tls-creds-x509,id=3Dtls0,dir=3D/home/berrange/security=
/qemutls,\
> >>>              endpoint=3Dserver,verify-peer=3Dyes \
> >>>      -object authz-pam,id=3Dauthz0,service=3Dqemu-vnc \
> >>>      -vnc :1,tls-creds=3Dtls0,tls-authz=3Dauthz0
> >>>
> >>> This requires an /etc/pam/qemu-vnc file to be created with the auth
> >>> rules. A very simple file based whitelist can be setup using
> >>>
> >>>   $ cat > /etc/pam/qemu-vnc <<EOF
> >>>   account         requisite       pam_listfile.so item=3Duser sense=
=3Dallow file=3D/etc/qemu/vnc.allow
> >>>   EOF
> >>>
> >>> The /etc/qemu/vnc.allow file simply contains one username per line.=
 Any
> >>> username not in the file is denied. The usernames in this example a=
re
> >>> the x509 distinguished name from the client's x509 cert.
> >>>
> >>>   $ cat > /etc/qemu/vnc.allow <<EOF
> >>>   CN=3Dlaptop.berrange.com,O=3DBerrange Home,L=3DLondon,ST=3DLondon=
,C=3DGB
> >>>   EOF
> >>>
> >>> More interesting would be to configure PAM to use an LDAP backend, =
so
> >>> that the QEMU authorization check data can be centralized instead o=
f
> >>> requiring each compute host to have file maintained.
> >>>
> >>> The main limitation with this PAM module is that the rules apply to=
 all
> >>> QEMU instances on the host. Setting up different rules per VM, woul=
d
> >>> require creating a separate PAM service name & config file for ever=
y
> >>> guest. An alternative approach for the future might be to not pass =
in
> >>> the plain username to PAM, but instead combine the VM name or UUID =
with
> >>> the username. This requires further consideration though.
> >>>
> >>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> >>> ---
> >=20
> >>> +static bool qauthz_pam_is_allowed(QAuthZ *authz,
> >>> +                                  const char *identity,
> >>> +                                  Error **errp)
> >>> +{
> >>> +    QAuthZPAM *pauthz =3D QAUTHZ_PAM(authz);
> >>> +    const struct pam_conv pam_conversation =3D { 0 };
> >>> +    pam_handle_t *pamh =3D NULL;
> >>> +    int ret;
> >>> +
> >>> +    trace_qauthz_pam_check(authz, identity, pauthz->service);
> >>> +    ret =3D pam_start(pauthz->service,
> >>> +                    identity,
> >>> +                    &pam_conversation,
> >>> +                    &pamh);
> >>> +    if (ret !=3D PAM_SUCCESS) {
> >>> +        error_setg(errp, "Unable to start PAM transaction: %s",
> >>> +                   pam_strerror(NULL, ret));
>=20
> "In an error case is the content of pamh undefined."
> So it is safer to use NULL here indeed.
>=20
> >>> +        return false;
> >>> +    }
> >>> +
> >>> +    ret =3D pam_acct_mgmt(pamh, PAM_SILENT);
> >>> +    if (ret !=3D PAM_SUCCESS) {
> >>> +        error_setg(errp, "Unable to authorize user '%s': %s",
> >>> +                   identity, pam_strerror(pamh, ret));
> >>> +        goto cleanup;
> >>> +    }
> >>> +
> >>> + cleanup:
> >>> +    pam_end(pamh, ret);
> >>> +    return ret =3D=3D PAM_SUCCESS;
>=20
> Hmm I find this fragile.
>=20
> A 'cleanup' label means (to me) you expect someone to eventually add
> more code around, and I'm worried someone add a pam_smth() call after
> pam_acct_mgmt(), that sets ret to PAM_SUCCESS.
>=20
> It looks safer to me to simply not use any label here (for the current
> code, if it is extended, we'll see).

>=20
> If you agree on removing the 'cleanup' label in qauthz_pam_is_allowed()=
,
> for the whole patch:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks, I will squash this in:

diff --git a/authz/pamacct.c b/authz/pamacct.c
index 8fe4c8ee11..5038358cdc 100644
--- a/authz/pamacct.c
+++ b/authz/pamacct.c
@@ -47,15 +47,14 @@ static bool qauthz_pam_is_allowed(QAuthZ *authz,
     }
=20
     ret =3D pam_acct_mgmt(pamh, PAM_SILENT);
+    pam_end(pamh, ret);
     if (ret !=3D PAM_SUCCESS) {
         error_setg(errp, "Unable to authorize user '%s': %s",
                    identity, pam_strerror(pamh, ret));
-        goto cleanup;
+        return false;
     }
=20
- cleanup:
-    pam_end(pamh, ret);
-    return ret =3D=3D PAM_SUCCESS;
+    return true;
 }
=20
=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
