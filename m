Received: from eggs.gnu.org ([2001:4830:134:3::10]:36431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1e1s4d-00087Q-N8
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1e1s4a-0005cP-I9
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:47:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1e1s4a-0005bB-9l
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:47:40 -0400
Date: Tue, 10 Oct 2017 06:47:36 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <267628815.28174009.1507632456608.JavaMail.zimbra@redhat.com>
In-Reply-To: <1507623384.4061.29.camel@intel.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-32-marcandre.lureau@redhat.com>
	<1507623384.4061.29.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 31/42] tpm-backend: move set 'id' to common
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>
Cc: qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com

Hi

----- Original Message -----
> On Tue, 2017-10-10 at 00:56 +0200, Marc-Andr=C3=A9 Lureau wrote:
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> > =C2=A0include/sysemu/tpm_backend.h |=C2=A0=C2=A02 +-
> > =C2=A0hw/tpm/tpm_emulator.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0| 12 +++---------
> > =C2=A0hw/tpm/tpm_passthrough.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=
=A09 +++------
> > =C2=A0tpm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0|=C2=A0=C2=A03 ++-
> > =C2=A04 files changed, 9 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/include/sysemu/tpm_backend.h
> > b/include/sysemu/tpm_backend.h
> > index 594bb50782..881be97ee3 100644
> > --- a/include/sysemu/tpm_backend.h
> > +++ b/include/sysemu/tpm_backend.h
> > @@ -64,7 +64,7 @@ struct TPMBackendClass {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* get a descriptive text of the backend =
to display to the user
> > */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *desc;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0TPMBackend *(*create)(QemuOpts *opts, const ch=
ar *id);
> > +=C2=A0=C2=A0=C2=A0=C2=A0TPMBackend *(*create)(QemuOpts *opts);
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* start up the TPM on the backend - opti=
onal */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*startup_tpm)(TPMBackend *t);
> > diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> > index 36454837b3..315819329b 100644
> > --- a/hw/tpm/tpm_emulator.c
> > +++ b/hw/tpm/tpm_emulator.c
> > @@ -453,22 +453,16 @@ err:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;
> > =C2=A0}
> > =C2=A0
> > -static TPMBackend *tpm_emulator_create(QemuOpts *opts, const char
> > *id)
> > +static TPMBackend *tpm_emulator_create(QemuOpts *opts)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TPMBackend *tb =3D TPM_BACKEND(object_new=
(TYPE_TPM_EMULATOR));
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0tb->id =3D g_strdup(id);
> > -
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (tpm_emulator_handle_device_opts(TPM_E=
MULATOR(tb), opts)) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto err_exit;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object_unref(OBJECT(tb=
));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return tb;
> > -
> > -err_exit:
> > -=C2=A0=C2=A0=C2=A0=C2=A0object_unref(OBJECT(tb));
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static TpmTypeOptions *tpm_emulator_get_tpm_options(TPMBackend *t=
b)
> > diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> > index 9326cbfdc9..7371d50739 100644
> > --- a/hw/tpm/tpm_passthrough.c
> > +++ b/hw/tpm/tpm_passthrough.c
> > @@ -284,13 +284,10 @@
> > tpm_passthrough_handle_device_opts(TPMPassthruState *tpm_pt, QemuOpts
> > *opts)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 1;
> > =C2=A0}
> > =C2=A0
> > -static TPMBackend *tpm_passthrough_create(QemuOpts *opts, const char
> > *id)
> > +static TPMBackend *tpm_passthrough_create(QemuOpts *opts)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Object *obj =3D object_new(TYPE_TPM_PASST=
HROUGH);
> > -=C2=A0=C2=A0=C2=A0=C2=A0TPMBackend *tb =3D TPM_BACKEND(obj);
> > -=C2=A0=C2=A0=C2=A0=C2=A0TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(t=
b);
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0tb->id =3D g_strdup(id);
> > +=C2=A0=C2=A0=C2=A0=C2=A0TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(o=
bj);
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (tpm_passthrough_handle_device_opts(tp=
m_pt, opts)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto err_exit;
> > @@ -301,7 +298,7 @@ static TPMBackend
> > *tpm_passthrough_create(QemuOpts *opts, const char *id)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto err_exit;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0return tb;
> > +=C2=A0=C2=A0=C2=A0=C2=A0return TPM_BACKEND(obj);
> > =C2=A0
> > =C2=A0err_exit:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object_unref(obj);
> > diff --git a/tpm.c b/tpm.c
> > index a46ee5f144..37298f3f03 100644
> > --- a/tpm.c
> > +++ b/tpm.c
> > @@ -129,11 +129,12 @@ static int tpm_init_tpmdev(void *dummy,
> > QemuOpts *opts, Error **errp)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 1;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0drv =3D be->create(opts, id);
> > +=C2=A0=C2=A0=C2=A0=C2=A0drv =3D be->create(opts);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!drv) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 1;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0drv->id =3D g_strdup(id);
> I kind of oppose this change, instead what about adding new TPMBackend
> api say - TPMBackend* tpm_backend_create(const char *type, const
> QemuOpts *opts), that should handle this common code, and returns the
> newly instantiated backend object.

That would be a more complicated refactoring than what I propose here, whic=
h is basic common code refactoring. To clarify your proposal, make a follow=
-up patch?

Another interesting approach would be to implement USER_CREATABLE (I have a=
n experimental patch for that). This allows to use -object tpm-passthrough,=
id=3D..,path=3D.. and will change the way backends are created & initialize=
d.
