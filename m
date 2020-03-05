Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D5AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28BC12072A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGH9EUtu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BC12072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9phP-0007cV-58
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 07:33:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j9pfn-0006Lj-14
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j9pfl-0000EL-Ev
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:32:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30185
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j9pfl-0000EC-9P
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583411536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/c4tPcg9zdQsleyJ1g34ff5K23HpsWjtKQ1shZofkUM=;
 b=FGH9EUtuzk7o2ccBb+IX38k215RNSxsQAbNwQ9j+LTTWNIVzc7RfRigznzLveAImjFzlTk
 22b+mH9qdu5vHRde9RbzpoMO+q29aIlSRhkIJlHseSqU6wdXoMOZArhf/5TYDULdWm7kfb
 DXqzKKAWM5b1ah2vsHDKpJAYpcGPnfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-mRSDrheMOKyDEJx4qLwsvw-1; Thu, 05 Mar 2020 07:32:13 -0500
X-MC-Unique: mRSDrheMOKyDEJx4qLwsvw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58F4D101FC60;
 Thu,  5 Mar 2020 12:32:11 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5A9873891;
 Thu,  5 Mar 2020 12:31:58 +0000 (UTC)
Date: Thu, 5 Mar 2020 12:31:55 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v5 41/50] multi-process/mig: Enable VMSD save in the
 Proxy object
Message-ID: <20200305123155.GH3130@work-vm>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <f056d73bb7f749171626cb8abc5a317b0ec17845.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <f056d73bb7f749171626cb8abc5a317b0ec17845.1582576372.git.jag.raman@oracle.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
> Collect the VMSD from remote process on the source and save
> it to the channel leading to the destination
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>  v4 -> v5:
>   - Using qemu_file_shutdown() instead of qemu_thread_cancel(). Removed p=
atch
>     which introduced qemu_thread_cancel()
>=20
>  hw/proxy/qemu-proxy.c         | 135 ++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/proxy/qemu-proxy.h |   2 +
>  include/io/mpqemu-link.h      |   1 +
>  3 files changed, 138 insertions(+)
>=20
> diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
> index b1b9282..19f0dbb 100644
> --- a/hw/proxy/qemu-proxy.c
> +++ b/hw/proxy/qemu-proxy.c
> @@ -23,6 +23,14 @@
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
> @@ -35,6 +43,9 @@ static void broadcast_init(void);
>  static int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t *val=
, int l,
>                            unsigned int op);
> =20
> +#define PAGE_SIZE qemu_real_host_page_size
> +uint8_t *mig_data;
> +
>  static void childsig_handler(int sig, siginfo_t *siginfo, void *ctx)
>  {
>      /* TODO: Add proper handler. */
> @@ -460,6 +471,129 @@ static void pci_proxy_dev_inst_init(Object *obj)
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
> +
> +        if (qemu_file_get_error(data->rem)) {
> +            break;
> +        }
> +
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

This feels way too complicated.   Since we know f_remote is always just
a simple fd we're getting we don't need to use qio or qemu_file here;
just use the fd - nice and simple.

Then the code to read it can just use read(2) with a sensible size chunk
rather than reading a byte at a time.

> +    mig_data->dev =3D pdev;
> +
> +    qemu_thread_create(&thread, "Proxy MIG_OUT", proxy_mig_out, mig_data=
,
> +                       QEMU_THREAD_DETACHED);

I'm just checking why a thread is necessary; is this because you need to
be able to start reading before you block waiting for the remote to tell
you the size - worrying that if you don't start reading then the remote
might block waiting for us?

> +    msg.cmd =3D START_MIG_OUT;
> +    msg.bytestream =3D 0;
> +    msg.num_fds =3D 2;
> +    msg.fds[0] =3D fd[1];
> +    msg.fds[1] =3D GET_REMOTE_WAIT;
> +
> +    mpqemu_msg_send(&msg, pdev->mpqemu_link->com);
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

Hmm.  I suggest the following:

  a) You create a shared 'size' variable;  and initialize it to
    UINT64_MAX.
  b) The thread uses atomic_read(shared_size) to read that value.
  c) When you receive the size from the remote you do
     atomic_set(&shared_size, size);
  d) The thread does:
     while (received_size < atomic_read(&shared_size))

     so the thread will quit either on EOF or it hitting the size.

  e) We pthread_join here to wait for the thread
  f) We then check a received size to make sure it matches what we
expect.

That removes the tight loop.

> +    qemu_file_shutdown(f_remote);
> +
> +    qemu_fclose(f_remote);
> +    close(fd[1]);
> +
> +    return 0;
> +}
> +
> +static int proxy_post_save(void *opaque)
> +{
> +    MigrationState *ms =3D migrate_get_current();
> +    PCIProxyDev *pdev =3D opaque;
> +    uint64_t pos =3D 0;
> +
> +    while (pos < pdev->migsize) {
> +        qemu_put_byte(ms->to_dst_file, mig_data[pos]);
> +        pos++;
> +    }
> +
> +    qemu_fflush(ms->to_dst_file);
> +
> +    return 0;

I don't think you need that.

> +}
> +
> +const VMStateDescription vmstate_pci_proxy_device =3D {
> +    .name =3D "PCIProxyDevice",
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 1,
> +    .pre_save =3D proxy_pre_save,
> +    .post_save =3D proxy_post_save,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(parent_dev, PCIProxyDev),
> +        VMSTATE_UINT64(migsize, PCIProxyDev),

I think instead you should use a VMSTATE_VBUFFER here to save
the mig_data.
What we should do is the post_save should g_free the buffer.
(mig_data should be a field in proxy).

Dave


> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
>  {
>      PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
> @@ -471,6 +605,7 @@ static void pci_proxy_dev_class_init(ObjectClass *kla=
ss, void *data)
>      k->config_write =3D pci_proxy_write_config;
> =20
>      dc->reset =3D proxy_device_reset;
> +    dc->vmsd =3D &vmstate_pci_proxy_device;
>  }
> =20
>  static const TypeInfo pci_proxy_dev_type_info =3D {
> diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.=
h
> index 5de8129..537c227 100644
> --- a/include/hw/proxy/qemu-proxy.h
> +++ b/include/hw/proxy/qemu-proxy.h
> @@ -75,6 +75,8 @@ struct PCIProxyDev {
>                          bool need_spawn, Error **errp);
> =20
>      ProxyMemoryRegion region[PCI_NUM_REGIONS];
> +
> +    uint64_t migsize;
>  };
> =20
>  typedef struct PCIProxyDevClass {
> diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
> index d2234ca..b42c003 100644
> --- a/include/io/mpqemu-link.h
> +++ b/include/io/mpqemu-link.h
> @@ -63,6 +63,7 @@ typedef enum {
>      PROXY_PING,
>      MMIO_RETURN,
>      DEVICE_RESET,
> +    START_MIG_OUT,
>      MAX,
>  } mpqemu_cmd_t;
> =20
> --=20
> 1.8.3.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


