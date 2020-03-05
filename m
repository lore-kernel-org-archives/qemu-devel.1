Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34471C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39FF208CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmgKpWN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39FF208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9sRN-00017Z-73
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 10:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j9sQN-000081-PN
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:28:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j9sQM-0001ZQ-L8
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:28:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59373
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j9sQM-0001Z2-Gy
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583422114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzH4IPOccJyvR5DzRyg/LlZ/N8YVLJrqgjdwZzfz4oY=;
 b=gmgKpWN3uC1AK3eTL8S3GssoRcL9kfLHiuJl7cGk3TGkJea+fukZQQeB0ZJ4QWT/pdpaB0
 GmZntXiuzccTQcr0dRkJgXSYo8qCNRrqfPoNGEptcTTHlfwldFk3Z+JFF1z6CBpiLqEjuc
 22OsI6FXiGpTsm21B3kjOLQORH1sovs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-h0gilozcOM-Qzxwb7fIfdA-1; Thu, 05 Mar 2020 10:28:32 -0500
X-MC-Unique: h0gilozcOM-Qzxwb7fIfdA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B42C38017CC;
 Thu,  5 Mar 2020 15:28:29 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BF1639A;
 Thu,  5 Mar 2020 15:28:16 +0000 (UTC)
Date: Thu, 5 Mar 2020 15:28:14 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v5 43/50] multi-process/mig: Load VMSD in the proxy object
Message-ID: <20200305152814.GJ3130@work-vm>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <728f5cdb2108ccfd0916c1efcc8c7dab99daf6ad.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <728f5cdb2108ccfd0916c1efcc8c7dab99daf6ad.1582576372.git.jag.raman@oracle.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, liran.alon@oracle.com,
 stefanha@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jagannathan Raman (jag.raman@oracle.com) wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> The Proxy object loads the VMSD of remote process in source
> and send it to the remote process in the destination
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>  hw/proxy/qemu-proxy.c    | 50 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/io/mpqemu-link.h |  1 +
>  2 files changed, 51 insertions(+)
>=20
> diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
> index 19f0dbb..1649f60 100644
> --- a/hw/proxy/qemu-proxy.c
> +++ b/hw/proxy/qemu-proxy.c
> @@ -581,12 +581,62 @@ static int proxy_post_save(void *opaque)
>      return 0;
>  }
> =20
> +static int proxy_post_load(void *opaque, int version_id)
> +{
> +    MigrationIncomingState *mis =3D migration_incoming_get_current();
> +    PCIProxyDev *pdev =3D opaque;
> +    QEMUFile *f_remote;
> +    MPQemuMsg msg =3D {0};
> +    Error *err =3D NULL;
> +    QIOChannel *ioc;
> +    uint64_t size;
> +    uint8_t byte;
> +    int fd[2];
> +
> +    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd)) {
> +        return -1;
> +    }
> +
> +    ioc =3D qio_channel_new_fd(fd[0], &err);
> +    if (err) {
> +        error_report_err(err);
> +        return -1;
> +    }
> +
> +    qio_channel_set_name(QIO_CHANNEL(ioc), "proxy-migration-channel");
> +
> +    f_remote =3D qemu_fopen_channel_output(ioc);
> +
> +    msg.cmd =3D START_MIG_IN;
> +    msg.bytestream =3D 0;
> +    msg.num_fds =3D 1;
> +    msg.fds[0] =3D fd[1];
> +
> +    mpqemu_msg_send(&msg, pdev->mpqemu_link->com);
> +
> +    size =3D pdev->migsize;
> +
> +    while (size) {
> +        byte =3D qemu_get_byte(mis->from_src_file);
> +        qemu_put_byte(f_remote, byte);

My suggestion on the previous patch about using the VMSTATE_BUFFERV
means you'd malloc on size, and do the put_byte's to the remote in the
post_load.

> +        size--;
> +    }
> +
> +    qemu_fflush(f_remote);
> +    qemu_fclose(f_remote);
> +
> +    close(fd[1]);
> +
> +    return 0;
> +}
> +
>  const VMStateDescription vmstate_pci_proxy_device =3D {
>      .name =3D "PCIProxyDevice",
>      .version_id =3D 2,
>      .minimum_version_id =3D 1,
>      .pre_save =3D proxy_pre_save,
>      .post_save =3D proxy_post_save,
> +    .post_load =3D proxy_post_load,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_PCI_DEVICE(parent_dev, PCIProxyDev),
>          VMSTATE_UINT64(migsize, PCIProxyDev),
> diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
> index b42c003..01371fc 100644
> --- a/include/io/mpqemu-link.h
> +++ b/include/io/mpqemu-link.h
> @@ -64,6 +64,7 @@ typedef enum {
>      MMIO_RETURN,
>      DEVICE_RESET,
>      START_MIG_OUT,
> +    START_MIG_IN,
>      MAX,
>  } mpqemu_cmd_t;
> =20
> --=20
> 1.8.3.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


