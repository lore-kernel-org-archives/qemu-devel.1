Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81961C47417
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA97722CEB
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 15:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxtLWckk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA97722CEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUuvZ-0004xQ-Qr
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 10:51:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iUuum-00046S-B4
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iUuuj-0003Lo-T9
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:50:39 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33261
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iUuuj-0003LY-Me
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573660236;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RCzFXhgCn1KD9azKiB9kWwhDcW92M71M5idnAkHgrQc=;
 b=FxtLWckkYSJaQaXOkmuH6ioT5sQ/znLdFE+hfrreXQq5aOXxmiLZ39tQLK+eURWSjSJZvc
 GlEJyB7mG5OJNw4DvH6INUgOYm/rtkwFrtpU5HvBfx19Ema7JrJRje8Fd3KkS1t/O298F3
 m92NJ1qoRuLR1+1hqlQjawR6mSRMtTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-TWjkcE1kNhO65BK5cNkNLg-1; Wed, 13 Nov 2019 10:50:33 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE820803CEB;
 Wed, 13 Nov 2019 15:50:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4705360471;
 Wed, 13 Nov 2019 15:50:21 +0000 (UTC)
Date: Wed, 13 Nov 2019 15:50:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 41/49] multi-process/mig: Enable VMSD save in the
 Proxy object
Message-ID: <20191113155019.GH2445240@redhat.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <8b15ab3d4fe51b792897ffc87e221bfb9317a836.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <8b15ab3d4fe51b792897ffc87e221bfb9317a836.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: TWjkcE1kNhO65BK5cNkNLg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, thuth@redhat.com,
 john.g.johnson@oracle.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 quintela@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 ross.lagerwall@citrix.com, mreitz@redhat.com, kanth.ghatraju@oracle.com,
 kraxel@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 liran.alon@oracle.com, marcandre.lureau@gmail.com, kwolf@redhat.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 05:09:22AM -0400, Jagannathan Raman wrote:
> Collect the VMSD from remote process on the source and save
> it to the channel leading to the destination
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>  New patch in v4
>=20
>  hw/proxy/qemu-proxy.c         | 132 ++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/proxy/qemu-proxy.h |   2 +
>  include/io/mpqemu-link.h      |   1 +
>  3 files changed, 135 insertions(+)
>=20
> diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
> index 623a6c5..ce72e6a 100644
> --- a/hw/proxy/qemu-proxy.c
> +++ b/hw/proxy/qemu-proxy.c
> @@ -52,6 +52,14 @@
>  #include "util/event_notifier-posix.c"
>  #include "hw/boards.h"
>  #include "include/qemu/log.h"
> +#include "io/channel.h"
> +#include "migration/qemu-file-types.h"
> +#include "qapi/error.h"
> +#include "io/channel-util.h"
> +#include "migration/qemu-file-channel.h"
> +#include "migration/qemu-file.h"
> +#include "migration/migration.h"
> +#include "migration/vmstate.h"
> =20
>  QEMUTimer *hb_timer;
>  static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
> @@ -62,6 +70,9 @@ static void stop_heartbeat_timer(void);
>  static void childsig_handler(int sig, siginfo_t *siginfo, void *ctx);
>  static void broadcast_msg(MPQemuMsg *msg, bool need_reply);
> =20
> +#define PAGE_SIZE getpagesize()
> +uint8_t *mig_data;
> +
>  static void childsig_handler(int sig, siginfo_t *siginfo, void *ctx)
>  {
>      /* TODO: Add proper handler. */
> @@ -357,14 +368,135 @@ static void pci_proxy_dev_inst_init(Object *obj)
>      dev->mem_init =3D false;
>  }
> =20
> +typedef struct {
> +    QEMUFile *rem;
> +    PCIProxyDev *dev;
> +} proxy_mig_data;
> +
> +static void *proxy_mig_out(void *opaque)
> +{
> +    proxy_mig_data *data =3D opaque;
> +    PCIProxyDev *dev =3D data->dev;
> +    uint8_t byte;
> +    uint64_t data_size =3D PAGE_SIZE;
> +
> +    mig_data =3D g_malloc(data_size);
> +
> +    while (true) {
> +        byte =3D qemu_get_byte(data->rem);

There is a pretty large set of APIs hiding behind the qemu_get_byte
call, which does not give me confidence that...

> +        mig_data[dev->migsize++] =3D byte;
> +        if (dev->migsize =3D=3D data_size) {
> +            data_size +=3D PAGE_SIZE;
> +            mig_data =3D g_realloc(mig_data, data_size);
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +static int proxy_pre_save(void *opaque)
> +{
> +    PCIProxyDev *pdev =3D opaque;
> +    proxy_mig_data *mig_data;
> +    QEMUFile *f_remote;
> +    MPQemuMsg msg =3D {0};
> +    QemuThread thread;
> +    Error *err =3D NULL;
> +    QIOChannel *ioc;
> +    uint64_t size;
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
> +    qio_channel_set_name(QIO_CHANNEL(ioc), "PCIProxyDevice-mig");
> +
> +    f_remote =3D qemu_fopen_channel_input(ioc);
> +
> +    pdev->migsize =3D 0;
> +
> +    mig_data =3D g_malloc0(sizeof(proxy_mig_data));
> +    mig_data->rem =3D f_remote;
> +    mig_data->dev =3D pdev;
> +
> +    qemu_thread_create(&thread, "Proxy MIG_OUT", proxy_mig_out, mig_data=
,
> +                       QEMU_THREAD_DETACHED);
> +
> +    msg.cmd =3D START_MIG_OUT;
> +    msg.bytestream =3D 0;
> +    msg.num_fds =3D 2;
> +    msg.fds[0] =3D fd[1];
> +    msg.fds[1] =3D GET_REMOTE_WAIT;
> +
> +    mpqemu_msg_send(pdev->mpqemu_link, &msg, pdev->mpqemu_link->com);
> +    size =3D wait_for_remote(msg.fds[1]);
> +    PUT_REMOTE_WAIT(msg.fds[1]);
> +
> +    assert(size !=3D ULLONG_MAX);
> +
> +    /*
> +     * migsize is being update by a separate thread. Using volatile to
> +     * instruct the compiler to fetch the value of this variable from
> +     * memory during every read
> +     */
> +    while (*((volatile uint64_t *)&pdev->migsize) < size) {
> +    }
> +
> +    qemu_thread_cancel(&thread);

....this is a safe way to stop the thread executing without
resulting in memory being leaked.

In addition thread cancellation is asynchronous, so the thread
may still be using the QEMUFile object while....

> +    qemu_fclose(f_remote);

..this is closing it. This feels like it is a crash danger.


> +    close(fd[1]);
> +
> +    return 0;
> +}

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


