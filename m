Received: from eggs.gnu.org ([2001:4830:134:3::10]:54562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1co5Xg-0000qL-05
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 05:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1co5Xc-0007Uj-Ts
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 05:48:28 -0400
Received: from 4.mo68.mail-out.ovh.net ([46.105.59.63]:54300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1co5Xc-0007UT-Ko
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 05:48:24 -0400
Received: from player763.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id D8FAC45FC3
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 10:48:22 +0100 (CET)
Date: Wed, 15 Mar 2017 10:48:14 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170315104814.0e49c4d3@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <1489449360-14411-5-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1703131650550.21520@sstabellini-ThinkPad-X260>
	<1489449360-14411-1-git-send-email-sstabellini@kernel.org>
	<1489449360-14411-5-git-send-email-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/B.ClX9VVPeRzk1Mxdi=i6g9";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 5/9] xen/9pfs: connect to the frontend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, anthony.perard@citrix.com, Stefano Stabellini <stefano@aporeto.com>, jgross@suse.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

--Sig_/B.ClX9VVPeRzk1Mxdi=i6g9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Mar 2017 16:55:56 -0700
Stefano Stabellini <sstabellini@kernel.org> wrote:

> Write the limits of the backend to xenstore. Connect to the frontend.
> Upon connection, allocate the rings according to the protocol
> specification.
>=20
> Initialize a QEMUBH to schedule work upon receiving an event channel
> notification from the frontend.
>=20
> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> CC: anthony.perard@citrix.com
> CC: jgross@suse.com
> CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> CC: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/xen-9p-backend.c | 159 +++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 158 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index 35032d3..0e4a133 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -17,8 +17,35 @@
>  #include "qemu/config-file.h"
>  #include "fsdev/qemu-fsdev.h"
> =20
> +#define VERSIONS "1"
> +#define MAX_RINGS 8
> +#define MAX_RING_ORDER 8
> +
> +struct Xen9pfsRing {
> +    struct Xen9pfsDev *priv;
> +
> +    int ref;
> +    xenevtchn_handle   *evtchndev;
> +    int evtchn;
> +    int local_port;
> +    struct xen_9pfs_data_intf *intf;
> +    unsigned char *data;
> +    struct xen_9pfs_data ring;
> +
> +    QEMUBH *bh;
> +
> +    /* local copies, so that we can read/write PDU data directly from
> +     * the ring */
> +    RING_IDX out_cons, out_size, in_cons;
> +    bool inprogress;
> +};
> +

QEMU Coding style requires a typedef. FWIW, maybe you could also convert
other structured types like XenDevice or XenDevOps.

>  typedef struct Xen9pfsDev {
>      struct XenDevice xendev;  /* must be first */
> +    V9fsState state;
> +
> +    int num_rings;
> +    struct Xen9pfsRing *rings;
>  } Xen9pfsDev;
> =20
>  static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
> @@ -67,22 +94,152 @@ static int xen_9pfs_init(struct XenDevice *xendev)
>      return 0;
>  }
> =20
> +static void xen_9pfs_bh(void *opaque)
> +{
> +}
> +
> +static void xen_9pfs_evtchn_event(void *opaque)
> +{
> +}
> +
>  static int xen_9pfs_free(struct XenDevice *xendev)
>  {
> -    return -1;
> +    int i;
> +    struct Xen9pfsDev *xen_9pdev =3D container_of(xendev, struct Xen9pfs=
Dev, xendev);
> +

Coding style.

> +    for (i =3D 0; i < xen_9pdev->num_rings; i++) {
> +        if (xen_9pdev->rings[i].data !=3D NULL) {
> +            xengnttab_unmap(xen_9pdev->xendev.gnttabdev,
> +                    xen_9pdev->rings[i].data,
> +                    (1 << XEN_9PFS_RING_ORDER));
> +        }
> +        if (xen_9pdev->rings[i].intf !=3D NULL) {
> +            xengnttab_unmap(xen_9pdev->xendev.gnttabdev,
> +                    xen_9pdev->rings[i].intf,
> +                    1);
> +        }
> +        if (xen_9pdev->rings[i].evtchndev > 0) {
> +            qemu_set_fd_handler(xenevtchn_fd(xen_9pdev->rings[i].evtchnd=
ev),
> +                    NULL, NULL, NULL);
> +            xenevtchn_unbind(xen_9pdev->rings[i].evtchndev, xen_9pdev->r=
ings[i].local_port);
> +        }
> +        if (xen_9pdev->rings[i].bh !=3D NULL) {
> +            qemu_bh_delete(xen_9pdev->rings[i].bh);
> +        }
> +    }
> +    g_free(xen_9pdev->rings);
> +    return 0;
>  }
> =20
>  static int xen_9pfs_connect(struct XenDevice *xendev)
>  {
> +    int i;
> +    struct Xen9pfsDev *xen_9pdev =3D container_of(xendev, struct Xen9pfs=
Dev, xendev);

Coding style.

> +    V9fsState *s =3D &xen_9pdev->state;
> +    QemuOpts *fsdev;
> +    char *security_model, *path;
> +
> +    if (xenstore_read_fe_int(&xen_9pdev->xendev, "num-rings",
> +                             &xen_9pdev->num_rings) =3D=3D -1 ||
> +        xen_9pdev->num_rings > MAX_RINGS) {
> +        return -1;
> +    }
> +
> +    xen_9pdev->rings =3D g_malloc0(xen_9pdev->num_rings * sizeof(struct =
Xen9pfsRing));
> +    for (i =3D 0; i < xen_9pdev->num_rings; i++) {
> +        char str[16];
> +
> +        xen_9pdev->rings[i].priv =3D xen_9pdev;
> +        xen_9pdev->rings[i].evtchn =3D -1;
> +        xen_9pdev->rings[i].local_port =3D -1;
> +
> +        sprintf(str, "ring-ref%u", i);
> +        if (xenstore_read_fe_int(&xen_9pdev->xendev, str,
> +                                 &xen_9pdev->rings[i].ref) =3D=3D -1) {
> +            goto out;
> +        }
> +        sprintf(str, "event-channel-%u", i);
> +        if (xenstore_read_fe_int(&xen_9pdev->xendev, str,
> +                                 &xen_9pdev->rings[i].evtchn) =3D=3D -1)=
 {
> +            goto out;
> +        }
> +
> +        xen_9pdev->rings[i].intf =3D  xengnttab_map_grant_ref(
> +                xen_9pdev->xendev.gnttabdev,
> +                xen_9pdev->xendev.dom,
> +                xen_9pdev->rings[i].ref,
> +                PROT_READ | PROT_WRITE);
> +        if (!xen_9pdev->rings[i].intf) {
> +            goto out;
> +        }
> +        xen_9pdev->rings[i].data =3D xengnttab_map_domain_grant_refs(
> +                xen_9pdev->xendev.gnttabdev,
> +                (1 << XEN_9PFS_RING_ORDER),
> +                xen_9pdev->xendev.dom,
> +                xen_9pdev->rings[i].intf->ref,
> +                PROT_READ | PROT_WRITE);
> +        if (!xen_9pdev->rings[i].data) {
> +            goto out;
> +        }
> +        xen_9pdev->rings[i].ring.in =3D xen_9pdev->rings[i].data;
> +        xen_9pdev->rings[i].ring.out =3D xen_9pdev->rings[i].data + XEN_=
9PFS_RING_SIZE;
> +
> +        xen_9pdev->rings[i].bh =3D qemu_bh_new(xen_9pfs_bh, &xen_9pdev->=
rings[i]);
> +        xen_9pdev->rings[i].out_cons =3D 0;
> +        xen_9pdev->rings[i].out_size =3D 0;
> +        xen_9pdev->rings[i].inprogress =3D false;
> +
> +
> +        xen_9pdev->rings[i].evtchndev =3D xenevtchn_open(NULL, 0);
> +        if (xen_9pdev->rings[i].evtchndev =3D=3D NULL) {
> +            goto out;
> +        }
> +        fcntl(xenevtchn_fd(xen_9pdev->rings[i].evtchndev), F_SETFD, FD_C=
LOEXEC);
> +        xen_9pdev->rings[i].local_port =3D xenevtchn_bind_interdomain
> +            (xen_9pdev->rings[i].evtchndev, xendev->dom, xen_9pdev->ring=
s[i].evtchn);
> +        if (xen_9pdev->rings[i].local_port =3D=3D -1) {
> +            xen_pv_printf(xendev, 0, "xenevtchn_bind_interdomain failed =
port=3D%d\n",
> +                          xen_9pdev->rings[i].evtchn);
> +            goto out;
> +        }
> +        xen_pv_printf(xendev, 2, "bind evtchn port %d\n", xendev->local_=
port);
> +        qemu_set_fd_handler(xenevtchn_fd(xen_9pdev->rings[i].evtchndev),
> +                xen_9pfs_evtchn_event, NULL, &xen_9pdev->rings[i]);
> +    }
> +
> +    security_model =3D xenstore_read_be_str(xendev, "security_model");
> +    path =3D xenstore_read_be_str(xendev, "path");
> +    s->fsconf.fsdev_id =3D g_malloc(strlen("xen9p") + 6);
> +    sprintf(s->fsconf.fsdev_id, "xen9p%d", xendev->dev);

Please use g_strdup_printf().

> +    s->fsconf.tag =3D xenstore_read_fe_str(xendev, "tag");
> +    v9fs_register_transport(s, &xen_9p_transport);
> +    fsdev =3D qemu_opts_create(qemu_find_opts("fsdev"),
> +            s->fsconf.tag,
> +            1, NULL);
> +    qemu_opt_set(fsdev, "fsdriver", "local", NULL);
> +    qemu_opt_set(fsdev, "path", path, NULL);
> +    qemu_opt_set(fsdev, "security_model", security_model, NULL);
> +    qemu_opts_set_id(fsdev, s->fsconf.fsdev_id);
> +    qemu_fsdev_add(fsdev);
> +    v9fs_device_realize_common(s, NULL);
> +
>      return 0;
> +
> +out:
> +    xen_9pfs_free(xendev);
> +    return -1;
>  }
> =20
>  static void xen_9pfs_alloc(struct XenDevice *xendev)
>  {
> +    xenstore_write_be_str(xendev, "versions", VERSIONS);
> +    xenstore_write_be_int(xendev, "max-rings", MAX_RINGS);
> +    xenstore_write_be_int(xendev, "max-ring-page-order", MAX_RING_ORDER);
>  }
> =20
>  static void xen_9pfs_disconnect(struct XenDevice *xendev)
>  {
> +    /* Dynamic hotplug of PV filesystems at runtime is not supported. */

Does this mean that this function is never called ? Or that it should
report an error ? Or print one ?

In any case, it looks weird that it doesn't free the fsdev_id that
was allocated in xen_9pfs_connect().

>  }
> =20
>  struct XenDevOps xen_9pfs_ops =3D {


--Sig_/B.ClX9VVPeRzk1Mxdi=i6g9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljJDd4ACgkQAvw66wEB28LI7QCdFWpL8eL5pXE05U+Ywj+3WeTQ
R7sAn2p13I6J9bgjEBB1lU7hPfIZBKRi
=axKI
-----END PGP SIGNATURE-----

--Sig_/B.ClX9VVPeRzk1Mxdi=i6g9--
