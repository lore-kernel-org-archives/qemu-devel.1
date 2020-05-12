Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041FFC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2520206D3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLNSf5Ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2520206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYURX-0008So-Uk
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 08:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYUQi-0007mJ-7y
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:54:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20468
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYUQf-0004xo-TV
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589288076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wAhGOfTfee6ikxUsTV5+SHt0o8uc/ijNpWdDTvXF/XA=;
 b=JLNSf5EpNLmIFq29SUWZHHruu1FMLR0oRnG9SH2Q81zkCL3aalK4/jd2razxlAeEKNSE4F
 18Wa8+DPhv/inkNjVZ0WcFGdPEKCibUbqTPw4jDDohGaGBBmduucfSozBPmY1TYEgNQy0H
 f9jFuxsBHjjt7o80R93GTXatG8KMAec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-bGF_LdAtNn6AoQplEt1yEA-1; Tue, 12 May 2020 08:54:34 -0400
X-MC-Unique: bGF_LdAtNn6AoQplEt1yEA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07B7C18A0738;
 Tue, 12 May 2020 12:54:30 +0000 (UTC)
Received: from localhost (ovpn-112-75.ams2.redhat.com [10.36.112.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8787D100034E;
 Tue, 12 May 2020 12:54:20 +0000 (UTC)
Date: Tue, 12 May 2020 13:54:19 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH RESEND v6 19/36] multi-process: Connect Proxy Object with
 device in the remote process
Message-ID: <20200512125419.GI300009@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <fc69772e2a3c5269052c3f1994045a3b3689f949.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <fc69772e2a3c5269052c3f1994045a3b3689f949.1587614626.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="u/L2/WlOHZg+YGU4"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--u/L2/WlOHZg+YGU4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 09:13:54PM -0700, elena.ufimtseva@oracle.com wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
>=20
> Send a message to the remote process to connect PCI device with the
> corresponding Proxy object in QEMU

The CONNECT_DEV message is no longer necessary with a 1 socket per
device architecture. Connecting to a specific UNIX domain socket (e.g.
vm001/lsi-scsi-1.sock) already identifies which device the proxy wishes
to talk to.

Each device should have an mpqemu link that accepts client connections.
You can either do that in the main loop or you can use IOThread to run
dedicated per-device threads.

>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>  hw/proxy/qemu-proxy.c    | 34 +++++++++++++++++++++++++++++++
>  include/io/mpqemu-link.h |  5 +++++
>  io/mpqemu-link.c         |  3 +++
>  remote/remote-main.c     | 43 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 85 insertions(+)
>=20
> diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
> index 40bf56fd37..9b5e429a88 100644
> --- a/hw/proxy/qemu-proxy.c
> +++ b/hw/proxy/qemu-proxy.c
> @@ -17,11 +17,45 @@
>  static void proxy_set_socket(Object *obj, const char *str, Error **errp)
>  {
>      PCIProxyDev *pdev =3D PCI_PROXY_DEV(obj);
> +    DeviceState *dev =3D DEVICE(obj);
> +    MPQemuMsg msg =3D { 0 };
> +    int wait, fd[2];
> =20
>      pdev->socket =3D atoi(str);
> =20
>      mpqemu_init_channel(pdev->mpqemu_link, &pdev->mpqemu_link->com,
>                          pdev->socket);
> +
> +    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd)) {
> +        error_setg(errp, "Failed to create socket for device channel");
> +        return;
> +    }

This extra connection can be removed. The reasons for having it have
gone away now that there is just 1 device per socket.

> +
> +    wait =3D GET_REMOTE_WAIT;
> +
> +    msg.cmd =3D CONNECT_DEV;
> +    msg.bytestream =3D 1;
> +    msg.data2 =3D (uint8_t *)g_strdup(dev->id);
> +    msg.size =3D sizeof(msg.data2);

The g_strdup() is unnecessary, dev->id can be used directly.

Should msg.size be strlen(dev->id) instead of sizeof(msg.data2)?

> +    msg.num_fds =3D 2;
> +    msg.fds[0] =3D wait;
> +    msg.fds[1] =3D fd[1];
> +
> +    mpqemu_msg_send(&msg, pdev->mpqemu_link->com);
> +
> +    if (wait_for_remote(wait)) {
> +        error_setg(errp, "Failed to connect device to the remote");
> +        close(fd[0]);
> +    } else {
> +        mpqemu_init_channel(pdev->mpqemu_link, &pdev->mpqemu_link->dev,
> +                            fd[0]);
> +    }
> +
> +    PUT_REMOTE_WAIT(wait);
> +
> +    close(fd[1]);
> +
> +    g_free(msg.data2);
>  }
> =20
>  static void proxy_init(Object *obj)
> diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
> index 73cc59b874..ebae9afc45 100644
> --- a/include/io/mpqemu-link.h
> +++ b/include/io/mpqemu-link.h
> @@ -38,6 +38,7 @@
>  typedef enum {
>      INIT =3D 0,
>      SYNC_SYSMEM,
> +    CONNECT_DEV,
>      MAX,
>  } mpqemu_cmd_t;
> =20
> @@ -120,8 +121,12 @@ struct MPQemuLinkState {
>      GMainLoop *loop;
> =20
>      MPQemuChannel *com;
> +    MPQemuChannel *dev;
> =20
>      mpqemu_link_callback callback;
> +
> +    void *opaque;
> +    QemuThread thread;
>  };
> =20
>  MPQemuLinkState *mpqemu_link_create(void);
> diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
> index 3f81cef96e..f780b65181 100644
> --- a/io/mpqemu-link.c
> +++ b/io/mpqemu-link.c
> @@ -46,6 +46,9 @@ MPQemuLinkState *mpqemu_link_create(void)
>      MPQemuLinkState *link =3D MPQEMU_LINK(object_new(TYPE_MPQEMU_LINK));
> =20
>      link->com =3D NULL;
> +    link->dev =3D NULL;
> +
> +    link->opaque =3D NULL;
> =20
>      return link;
>  }
> diff --git a/remote/remote-main.c b/remote/remote-main.c
> index dbd6ad2529..f541baae6a 100644
> --- a/remote/remote-main.c
> +++ b/remote/remote-main.c
> @@ -35,6 +35,9 @@
>  #include "exec/ramlist.h"
>  #include "remote/remote-common.h"
> =20
> +static void process_msg(GIOCondition cond, MPQemuLinkState *link,
> +                        MPQemuChannel *chan);
> +
>  static MPQemuLinkState *mpqemu_link;
> =20
>  gchar *print_pid_exec(gchar *str)
> @@ -48,6 +51,43 @@ gchar *print_pid_exec(gchar *str)
>      return str;
>  }
> =20
> +#define LINK_TO_DEV(link) ((PCIDevice *)link->opaque)
> +
> +static gpointer dev_thread(gpointer data)
> +{
> +    MPQemuLinkState *link =3D data;
> +
> +    mpqemu_start_coms(link, link->dev);
> +
> +    return NULL;
> +}
> +
> +static void process_connect_dev_msg(MPQemuMsg *msg)
> +{
> +    char *devid =3D (char *)msg->data2;

Input validation is missing for this message. We may not have data2 or
it may not have a NUL-terminator.

> +    MPQemuLinkState *link =3D NULL;
> +    DeviceState *dev =3D NULL;
> +    int wait =3D msg->fds[0];

msg->num_fds wasn't checked.

> +    int ret =3D 0;
> +
> +    dev =3D qdev_find_recursive(sysbus_get_default(), devid);
> +    if (!dev) {
> +        ret =3D 0xff;
> +        goto exit;
> +    }
> +
> +    link =3D mpqemu_link_create();
> +    link->opaque =3D (void *)PCI_DEVICE(dev);

Missing check to see if dev is a PCIDevice subclass.

--u/L2/WlOHZg+YGU4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl66nHsACgkQnKSrs4Gr
c8haiQgAu2YX3BH+VsevckWIx3k+o3Owc41EIjGHkAf5dH6o3V6lLSqmhHfRE12b
EGhNtKDMASn/aARcrbhjFhgvkjEV9FCkynAOysVMFaK32ir0UjXi8NkUWZM992IW
u8Cf82eNqFUnDmpGp2cFrUzO3cAYjfKfosqiUKga9EQOpIu1sygtGs3jh2sscr6w
A5xtfoKn1OmIZjvohF/ptX96WWSEszTroMcP/wK2A8pFA3mZIhvlxtDhuv9mDkU9
XlL1hYlGU4+BDgLALBro0LJLXO3dCF3HXYIKrQpZLyvOAtWaBwMa/ESybpFG/sMs
t59VHqJ+pycx3xoJq0xsv9h9Due6iA==
=W4p3
-----END PGP SIGNATURE-----

--u/L2/WlOHZg+YGU4--


