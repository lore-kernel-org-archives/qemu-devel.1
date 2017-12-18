Received: from eggs.gnu.org ([2001:4830:134:3::10]:59722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eQxNV-0002en-73
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:31:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eQxNI-00059O-Be
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:30:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eQxNI-00058V-4V
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:30:40 -0500
Date: Mon, 18 Dec 2017 16:30:31 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171218163031.4936361e.cohuck@redhat.com>
In-Reply-To: <8772a2e8-49f8-4674-ff9b-d9df102af52f@redhat.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1513446109-9013-26-git-send-email-stefanb@linux.vnet.ibm.com>
	<8772a2e8-49f8-4674-ff9b-d9df102af52f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v1 25/32] qdev: add DEFINE_PROP_TPMBE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>

On Mon, 18 Dec 2017 16:10:50 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

> On 16/12/2017 18:41, Stefan Berger wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >=20
> > A property to lookup a tpm backend.
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > ---
> >  hw/core/qdev-properties-system.c | 64 ++++++++++++++++++++++++++++++++=
++++++++
> >  include/hw/qdev-properties.h     |  3 ++
> >  2 files changed, 67 insertions(+) =20
>=20
> This one breaks my build:
>=20
> ...
>   LINK    ppc64-softmmu/qemu-system-ppc64
> ../hw/core/qdev-properties-system.o: In function `release_tpm':
> /home/lvivier/qemu/hw/core/qdev-properties-system.c:291: undefined
> reference to `tpm_backend_reset'
> ../hw/core/qdev-properties-system.o: In function `set_tpm':
> /home/lvivier/qemu/hw/core/qdev-properties-system.c:274: undefined
> reference to `qemu_find_tpm_be'
> /home/lvivier/qemu/hw/core/qdev-properties-system.c:278: undefined
> reference to `tpm_backend_init'
> collect2: error: ld returned 1 exit status
>=20
> The following #ifdef fixes the problem for me:
>=20
> diff --git a/hw/core/qdev-properties-system.c
> b/hw/core/qdev-properties-system.c
> index c173646..b6eca3b 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -239,6 +239,7 @@ const PropertyInfo qdev_prop_chr =3D {
>=20
>  /* --- character device --- */
>=20
> +#if defined(CONFIG_TPM)
>  static void get_tpm(Object *obj, Visitor *v, const char *name, void
> *opaque,
>                      Error **errp)
>  {
> @@ -299,6 +300,7 @@ const PropertyInfo qdev_prop_tpm =3D {
>      .set   =3D set_tpm,
>      .release =3D release_tpm,
>  };
> +#endif
>=20
>  /* --- netdev device --- */
>  static void get_netdev(Object *obj, Visitor *v, const char *name,
>=20
> Thanks,
> Laurent
>=20

This seems to be a popular error today :)

https://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg03511.html
