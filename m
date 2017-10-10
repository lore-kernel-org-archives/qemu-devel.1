Received: from eggs.gnu.org ([2001:4830:134:3::10]:50459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1e22zc-0001Le-PM
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 18:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1e22zY-0000lv-NN
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 18:27:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1e22zY-0000ki-EG
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 18:27:12 -0400
Date: Tue, 10 Oct 2017 18:27:10 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1212636564.28308506.1507674430255.JavaMail.zimbra@redhat.com>
In-Reply-To: <19890c79-6745-5474-fa93-8d5e931f0b7d@linux.vnet.ibm.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-28-marcandre.lureau@redhat.com>
	<19890c79-6745-5474-fa93-8d5e931f0b7d@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 27/42] tpm: remove unused opened code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, amarnath valluri <amarnath.valluri@intel.com>

Hi

----- Original Message -----
> On 10/09/2017 06:56 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   include/sysemu/tpm_backend.h | 12 ------------
> >   backends/tpm.c               | 42
> >   ------------------------------------------
> >   tpm.c                        |  6 ------
> >   3 files changed, 60 deletions(-)
> >
> > diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.=
h
> > index b12ae5b625..a893e586ae 100644
> > --- a/include/sysemu/tpm_backend.h
> > +++ b/include/sysemu/tpm_backend.h
> > @@ -81,8 +81,6 @@ struct TPMBackendClass {
> >  =20
> >       TpmTypeOptions *(*get_tpm_options)(TPMBackend *t);
> >  =20
> > -    void (*opened)(TPMBackend *s, Error **errp);
> > -
> >       void (*handle_request)(TPMBackend *s, TPMBackendCmd *cmd);
> >   };
> >  =20
> > @@ -172,16 +170,6 @@ bool tpm_backend_get_tpm_established_flag(TPMBacke=
nd
> > *s);
> >    */
> >   int tpm_backend_reset_tpm_established_flag(TPMBackend *s, uint8_t loc=
ty);
> >  =20
> > -/**
> > - * tpm_backend_open:
> > - * @s: the backend to open
> > - * @errp: a pointer to return the #Error object if an error occurs.
> > - *
> > - * This function will open the backend if it is not already open.  Cal=
ling
> > this
> > - * function on an already opened backend will not result in an error.
> > - */
> > -void tpm_backend_open(TPMBackend *s, Error **errp);
> > -
> >   /**
> >    * tpm_backend_get_tpm_version:
> >    * @s: the backend to call into
> > diff --git a/backends/tpm.c b/backends/tpm.c
> > index 0c48d18775..7e636fbc7a 100644
> > --- a/backends/tpm.c
> > +++ b/backends/tpm.c
> > @@ -159,52 +159,10 @@ TPMInfo *tpm_backend_query_tpm(TPMBackend *s)
> >       return info;
> >   }
> >  =20
> > -static bool tpm_backend_prop_get_opened(Object *obj, Error **errp)
> > -{
> > -    TPMBackend *s =3D TPM_BACKEND(obj);
> > -
> > -    return s->opened;
> > -}
> > -
> > -void tpm_backend_open(TPMBackend *s, Error **errp)
> > -{
> > -    object_property_set_bool(OBJECT(s), true, "opened", errp);
> > -}
> > -
> > -static void tpm_backend_prop_set_opened(Object *obj, bool value, Error
> > **errp)
> > -{
> > -    TPMBackend *s =3D TPM_BACKEND(obj);
> > -    TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
> > -    Error *local_err =3D NULL;
> > -
> > -    if (value =3D=3D s->opened) {
> > -        return;
> > -    }
> > -
> > -    if (!value && s->opened) {
> > -        error_setg(errp, QERR_PERMISSION_DENIED);
> > -        return;
> > -    }
> > -
> > -    if (k->opened) {
> > -        k->opened(s, &local_err);
> > -        if (local_err) {
> > -            error_propagate(errp, local_err);
> > -            return;
> > -        }
> > -    }
> > -
> > -    s->opened =3D true;
> > -}
> > -
> >   static void tpm_backend_instance_init(Object *obj)
> >   {
> >       TPMBackend *s =3D TPM_BACKEND(obj);
> >  =20
> > -    object_property_add_bool(obj, "opened",
> > -                             tpm_backend_prop_get_opened,
> > -                             tpm_backend_prop_set_opened,
> > -                             NULL);
> >       s->bh =3D qemu_bh_new(tpm_backend_request_completed_bh, s);
> >   }
> >  =20
> > diff --git a/tpm.c b/tpm.c
> > index ce1543fcb4..a46ee5f144 100644
> > --- a/tpm.c
> > +++ b/tpm.c
> > @@ -134,12 +134,6 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts
> > *opts, Error **errp)
> >           return 1;
> >       }
> >  =20
> > -    tpm_backend_open(drv, &local_err);
> > -    if (local_err) {
> > -        error_report_err(local_err);
> > -        return 1;
> > -    }
> > -
> >       QLIST_INSERT_HEAD(&tpm_backends, drv, list);
> >  =20
> >       return 0;
>=20
> Since nothing is setting the "opened' anymore, would anyone notice
> because this has changed or is something else doing that now? Otherwise
> I don't mind removing it...

Was it ever used? I see the property was added in commit 8f0605cc9caacbcc64=
7a6df9ae541ed2da4b9bb0.

Code adapted from rng backend. But rng backend set "opened" on UserCreatabl=
eClass.complete() (TPM backend doesn't, but probably could - I have an expe=
rimental patch for that)

I think we can remove it that code safely.
