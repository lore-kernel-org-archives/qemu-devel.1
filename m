Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA43C54E8D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C68206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NuxJTARc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C68206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYVKk-0004Ex-Vj
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 09:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYVJS-0002ra-OZ
 for qemu-devel@nongnu.org; Tue, 12 May 2020 09:51:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40945
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYVJR-0005KQ-O5
 for qemu-devel@nongnu.org; Tue, 12 May 2020 09:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589291472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ZhEFRCbpTP3nZuV+XBjBn1ZdjfqCI4q0BQ8G2sQtBw=;
 b=NuxJTARc0utu2UDycpX+yc/fWioQOoZwdh/1UHI4XJ1eMVseCE2tWy7hPvMVCa2NI2ps+j
 AxLn6ZFTdKQ1DHiWUzFAoFE0WHbXZdKS6E17eVMBVNFn7WI7zUZi5GFa6QFzPLOPwfKkwS
 KWVEFWc0W/NWCNBZC6kWQ7rrsbDyiCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-WwWsbyXdNduuXRGERw5mLQ-1; Tue, 12 May 2020 09:51:09 -0400
X-MC-Unique: WwWsbyXdNduuXRGERw5mLQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 089C0460;
 Tue, 12 May 2020 13:51:07 +0000 (UTC)
Received: from localhost (ovpn-112-75.ams2.redhat.com [10.36.112.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 903E26E6E9;
 Tue, 12 May 2020 13:50:56 +0000 (UTC)
Date: Tue, 12 May 2020 14:50:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH RESEND v6 20/36] multi-process: Forward PCI config space
 acceses to the remote process
Message-ID: <20200512135055.GJ300009@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <901295bf44c731d232bb60579ffb48dce5b05cc4.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <901295bf44c731d232bb60579ffb48dce5b05cc4.1587614626.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pWOmaDnDlrCGjNh4"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:20:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

--pWOmaDnDlrCGjNh4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 09:13:55PM -0700, elena.ufimtseva@oracle.com wrote:
> +static int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t *val=
, int l,
> +                          unsigned int op)
> +{
> +    MPQemuMsg msg;
> +    struct conf_data_msg conf_data;
> +    int wait;
> +
> +    memset(&msg, 0, sizeof(MPQemuMsg));
> +    conf_data.addr =3D addr;
> +    conf_data.val =3D (op =3D=3D PCI_CONFIG_WRITE) ? *val : 0;
> +    conf_data.l =3D l;
> +
> +    msg.data2 =3D (uint8_t *)&conf_data;
> +    if (!msg.data2) {
> +        return -ENOMEM;

This can never happen since conf_data is on the stack.

> +    }
> +
> +    msg.size =3D sizeof(conf_data);
> +    msg.cmd =3D op;
> +    msg.bytestream =3D 1;
> +
> +    if (op =3D=3D PCI_CONFIG_WRITE) {
> +        msg.num_fds =3D 0;
> +    } else {
> +        /* TODO: Dont create fd each time for send. */
> +        wait =3D GET_REMOTE_WAIT;
> +        msg.num_fds =3D 1;
> +        msg.fds[0] =3D wait;
> +    }
> +
> +    mpqemu_msg_send(&msg, dev->mpqemu_link->dev);
> +
> +    if (op =3D=3D PCI_CONFIG_READ) {

Are you sure it's correct for writes to be posted instead of waiting for
completion?

> +        *val =3D (uint32_t)wait_for_remote(wait);
> +        PUT_REMOTE_WAIT(wait);
> +    }
> +
> +    return 0;
> +}
> +
> +static uint32_t pci_proxy_read_config(PCIDevice *d, uint32_t addr, int l=
en)
> +{
> +    uint32_t val;
> +
> +    (void)pci_default_read_config(d, addr, len);

Please add a comment explaining why this local read is necessary.

> +
> +    config_op_send(PCI_PROXY_DEV(d), addr, &val, len, PCI_CONFIG_READ);
> +
> +    return val;
> +}
> +
> +static void pci_proxy_write_config(PCIDevice *d, uint32_t addr, uint32_t=
 val,
> +                                   int l)
> +{
> +    pci_default_write_config(d, addr, val, l);

Please add a comment explaining why this local write is necessary.

> +
> +    config_op_send(PCI_PROXY_DEV(d), addr, &val, l, PCI_CONFIG_WRITE);
> +}
...
> diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
> index f780b65181..ef4a07b81a 100644
> --- a/io/mpqemu-link.c
> +++ b/io/mpqemu-link.c
> @@ -381,6 +381,12 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
>              return false;
>          }
>          break;
> +    case PCI_CONFIG_WRITE:
> +    case PCI_CONFIG_READ:
> +        if (msg->size !=3D sizeof(struct conf_data_msg)) {
> +            return false;
> +        }

conf_data_msg.l is not validated.

> +        break;
>      default:
>          break;
>      }
> diff --git a/remote/remote-main.c b/remote/remote-main.c
> index f541baae6a..834574e172 100644
> --- a/remote/remote-main.c
> +++ b/remote/remote-main.c
> @@ -53,6 +53,32 @@ gchar *print_pid_exec(gchar *str)
> =20
>  #define LINK_TO_DEV(link) ((PCIDevice *)link->opaque)
> =20
> +static void process_config_write(PCIDevice *dev, MPQemuMsg *msg)
> +{
> +    struct conf_data_msg *conf =3D (struct conf_data_msg *)msg->data2;
> +
> +    qemu_mutex_lock_iothread();

The qemu_mutex_lock_iothread() can be dropped once this is integrated in
to QEMU's event loop.

> +    pci_default_write_config(dev, conf->addr, conf->val, conf->l);

It is not safe to call this function with arbitrary addr input values.

> +    qemu_mutex_unlock_iothread();
> +}
> +
> +static void process_config_read(PCIDevice *dev, MPQemuMsg *msg)
> +{
> +    struct conf_data_msg *conf =3D (struct conf_data_msg *)msg->data2;
> +    uint32_t val;
> +    int wait;
> +
> +    wait =3D msg->fds[0];
> +
> +    qemu_mutex_lock_iothread();
> +    val =3D pci_default_read_config(dev, conf->addr, conf->l);

It is not safe to call this function with arbitrary addr input values.

--pWOmaDnDlrCGjNh4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl66qb8ACgkQnKSrs4Gr
c8jRaAf/QNZpSvC5K4gCXTdR2WmeK7+a++ib6/B3hhJgTZDlBt5eHf+MBdTHDlFv
ydtblUFfKpDeLQRhPj+8MZjxZlIiZ3ajSXuy+lNYqa6q0YvW8gp1UeEgE8lXgy//
YUmaNHrx1Kt+rtk3fbYs97uD9G5R1ybSbEi+wrF3IGnhcb/mVRWAa2wqkMRAgrQd
vRLoeYWhaNpMdOKbEgsn5q+nuAxC1r6j3Dsr0JMt9SzcZhdze70XFSr7K8vrcryb
Hdj4++7ia9QES1C9cskG5MozPjBkmIfqHqTwvPT1qnCck5/KAneeRBXZSjHJB3Iv
Wj6NhunyNGZsqv1J5CTpEgbyjqBwwA==
=ka/A
-----END PGP SIGNATURE-----

--pWOmaDnDlrCGjNh4--


