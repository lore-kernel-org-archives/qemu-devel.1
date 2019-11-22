Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB15C43215
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9885A2072E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nh4VDiXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9885A2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY6IG-0002zp-OZ
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 05:36:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iY6Hb-0002VF-5O
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:35:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iY6HZ-0005qb-9X
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:35:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44379
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iY6HZ-0005qA-4V
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:35:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574418920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tauPVqIvP7BfNqrd6bPGL+XPJn98GCELC0LILon9Jyw=;
 b=Nh4VDiXShNO9v8BKpiU7rPjEwU0CpJ20hOaZ7GBg5lRHMIbsrba4HuREnGklIQH/e7oAbL
 PfcsRVd7WuLzaMysvdAOQeKnJCb7VzWr+TDvrsmvsbkCCbWL9fAqCdM1YmjGTCpIiMBXme
 f2IkGllafeLPsNirONguT/dLkHLt0q8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-Xe8eXR1tODerhidZFNnvhQ-1; Fri, 22 Nov 2019 05:35:19 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D063A10054E3;
 Fri, 22 Nov 2019 10:35:16 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 188D45DF2C;
 Fri, 22 Nov 2019 10:34:57 +0000 (UTC)
Date: Fri, 22 Nov 2019 10:34:55 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jag Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 41/49] multi-process/mig: Enable VMSD save in the
 Proxy object
Message-ID: <20191122103455.GC2785@work-vm>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <8b15ab3d4fe51b792897ffc87e221bfb9317a836.1571905346.git.jag.raman@oracle.com>
 <20191113155019.GH2445240@redhat.com>
 <2f2985ea-8449-9cd7-efa9-1eb8d286bbfe@oracle.com>
 <20191113171126.GL2445240@redhat.com>
 <456fe446-65f7-1769-6ea8-a63e2ca5d523@oracle.com>
MIME-Version: 1.0
In-Reply-To: <456fe446-65f7-1769-6ea8-a63e2ca5d523@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Xe8eXR1tODerhidZFNnvhQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, thuth@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 ehabkost@redhat.com, john.g.johnson@oracle.com, liran.alon@oracle.com,
 rth@twiddle.net, konrad.wilk@oracle.com, qemu-devel@nongnu.org,
 armbru@redhat.com, ross.lagerwall@citrix.com, quintela@redhat.com,
 mst@redhat.com, kraxel@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 kanth.ghatraju@oracle.com, mreitz@redhat.com, kwolf@redhat.com,
 marcandre.lureau@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jag Raman (jag.raman@oracle.com) wrote:
>=20
>=20
> On 11/13/2019 12:11 PM, Daniel P. Berrang=E9 wrote:
> > On Wed, Nov 13, 2019 at 11:32:09AM -0500, Jag Raman wrote:
> > >=20
> > >=20
> > > On 11/13/2019 10:50 AM, Daniel P. Berrang=E9 wrote:
> > > > On Thu, Oct 24, 2019 at 05:09:22AM -0400, Jagannathan Raman wrote:
> > > > > Collect the VMSD from remote process on the source and save
> > > > > it to the channel leading to the destination
> > > > >=20
> > > > > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > > > > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > > > > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > > > > ---
> > > > >    New patch in v4
> > > > >=20
> > > > >    hw/proxy/qemu-proxy.c         | 132 ++++++++++++++++++++++++++=
++++++++++++++++
> > > > >    include/hw/proxy/qemu-proxy.h |   2 +
> > > > >    include/io/mpqemu-link.h      |   1 +
> > > > >    3 files changed, 135 insertions(+)
> > > > >=20
> > > > > diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
> > > > > index 623a6c5..ce72e6a 100644
> > > > > --- a/hw/proxy/qemu-proxy.c
> > > > > +++ b/hw/proxy/qemu-proxy.c
> > > > > @@ -52,6 +52,14 @@
> > > > >    #include "util/event_notifier-posix.c"
> > > > >    #include "hw/boards.h"
> > > > >    #include "include/qemu/log.h"
> > > > > +#include "io/channel.h"
> > > > > +#include "migration/qemu-file-types.h"
> > > > > +#include "qapi/error.h"
> > > > > +#include "io/channel-util.h"
> > > > > +#include "migration/qemu-file-channel.h"
> > > > > +#include "migration/qemu-file.h"
> > > > > +#include "migration/migration.h"
> > > > > +#include "migration/vmstate.h"
> > > > >    QEMUTimer *hb_timer;
> > > > >    static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp=
);
> > > > > @@ -62,6 +70,9 @@ static void stop_heartbeat_timer(void);
> > > > >    static void childsig_handler(int sig, siginfo_t *siginfo, void=
 *ctx);
> > > > >    static void broadcast_msg(MPQemuMsg *msg, bool need_reply);
> > > > > +#define PAGE_SIZE getpagesize()
> > > > > +uint8_t *mig_data;
> > > > > +
> > > > >    static void childsig_handler(int sig, siginfo_t *siginfo, void=
 *ctx)
> > > > >    {
> > > > >        /* TODO: Add proper handler. */
> > > > > @@ -357,14 +368,135 @@ static void pci_proxy_dev_inst_init(Object=
 *obj)
> > > > >        dev->mem_init =3D false;
> > > > >    }
> > > > > +typedef struct {
> > > > > +    QEMUFile *rem;
> > > > > +    PCIProxyDev *dev;
> > > > > +} proxy_mig_data;
> > > > > +
> > > > > +static void *proxy_mig_out(void *opaque)
> > > > > +{
> > > > > +    proxy_mig_data *data =3D opaque;
> > > > > +    PCIProxyDev *dev =3D data->dev;
> > > > > +    uint8_t byte;
> > > > > +    uint64_t data_size =3D PAGE_SIZE;
> > > > > +
> > > > > +    mig_data =3D g_malloc(data_size);
> > > > > +
> > > > > +    while (true) {
> > > > > +        byte =3D qemu_get_byte(data->rem);
> > > >=20
> > > > There is a pretty large set of APIs hiding behind the qemu_get_byte
> > > > call, which does not give me confidence that...
> > > >=20
> > > > > +        mig_data[dev->migsize++] =3D byte;
> > > > > +        if (dev->migsize =3D=3D data_size) {
> > > > > +            data_size +=3D PAGE_SIZE;
> > > > > +            mig_data =3D g_realloc(mig_data, data_size);
> > > > > +        }
> > > > > +    }
> > > > > +
> > > > > +    return NULL;
> > > > > +}
> > > > > +
> > > > > +static int proxy_pre_save(void *opaque)
> > > > > +{
> > > > > +    PCIProxyDev *pdev =3D opaque;
> > > > > +    proxy_mig_data *mig_data;
> > > > > +    QEMUFile *f_remote;
> > > > > +    MPQemuMsg msg =3D {0};
> > > > > +    QemuThread thread;
> > > > > +    Error *err =3D NULL;
> > > > > +    QIOChannel *ioc;
> > > > > +    uint64_t size;
> > > > > +    int fd[2];
> > > > > +
> > > > > +    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd)) {
> > > > > +        return -1;
> > > > > +    }
> > > > > +
> > > > > +    ioc =3D qio_channel_new_fd(fd[0], &err);
> > > > > +    if (err) {
> > > > > +        error_report_err(err);
> > > > > +        return -1;
> > > > > +    }
> > > > > +
> > > > > +    qio_channel_set_name(QIO_CHANNEL(ioc), "PCIProxyDevice-mig")=
;
> > > > > +
> > > > > +    f_remote =3D qemu_fopen_channel_input(ioc);
> > > > > +
> > > > > +    pdev->migsize =3D 0;
> > > > > +
> > > > > +    mig_data =3D g_malloc0(sizeof(proxy_mig_data));
> > > > > +    mig_data->rem =3D f_remote;
> > > > > +    mig_data->dev =3D pdev;
> > > > > +
> > > > > +    qemu_thread_create(&thread, "Proxy MIG_OUT", proxy_mig_out, =
mig_data,
> > > > > +                       QEMU_THREAD_DETACHED);
> > > > > +
> > > > > +    msg.cmd =3D START_MIG_OUT;
> > > > > +    msg.bytestream =3D 0;
> > > > > +    msg.num_fds =3D 2;
> > > > > +    msg.fds[0] =3D fd[1];
> > > > > +    msg.fds[1] =3D GET_REMOTE_WAIT;
> > > > > +
> > > > > +    mpqemu_msg_send(pdev->mpqemu_link, &msg, pdev->mpqemu_link->=
com);
> > > > > +    size =3D wait_for_remote(msg.fds[1]);
> > > > > +    PUT_REMOTE_WAIT(msg.fds[1]);
> > > > > +
> > > > > +    assert(size !=3D ULLONG_MAX);
> > > > > +
> > > > > +    /*
> > > > > +     * migsize is being update by a separate thread. Using volat=
ile to
> > > > > +     * instruct the compiler to fetch the value of this variable=
 from
> > > > > +     * memory during every read
> > > > > +     */
> > > > > +    while (*((volatile uint64_t *)&pdev->migsize) < size) {
> > > > > +    }
> > > > > +
> > > > > +    qemu_thread_cancel(&thread);
> > > >=20
> > > > ....this is a safe way to stop the thread executing without
> > > > resulting in memory being leaked.
> > > >=20
> > > > In addition thread cancellation is asynchronous, so the thread
> > > > may still be using the QEMUFile object while....
> > > >=20
> > > > > +    qemu_fclose(f_remote);
> > >=20
> > > The above "wait_for_remote()" call waits for the remote process to
> > > finish with Migration, and return the size of the VMSD.
> > >=20
> > > It should be safe to cancel the thread and close the file, once the
> > > remote process is done sending the VMSD and we have read "size" bytes
> > > from it, is it not?
> >=20
> > Ok, so the thread is doing
> >=20
> >      while (true) {
> >          byte =3D qemu_get_byte(data->rem);
> >          ...do something with byte...
> >      }
> >=20
> > so when the thread is cancelled it is almost certainly in the
> > qemu_get_byte() call. Since you say wait_for_remote() syncs
> > with the end of migration, I'll presume there's no more data
> > to be read but the file is still open.
> >=20
> > If we're using a blocking FD here we'll probably be stuck in
> > read() when we're cancelled, and cancellation would probably
> > be ok from looking at the current impl of QEMUFile / QIOChannel.
> > If we're handling any error scenario though there could be a
> > "Error *local_err" that needs freeing before cancellation.
> >=20
> > If the fclose is processed before cancellation takes affect
> > on the target thread though we could have a race.
> >=20
> >    1. proxy_mig_out blocked in read from qemu_fill_buffer
> >=20
> >    2. main thread request async cancel
> >=20
> >    3. main thread calls qemu_fclose which closes the FD
> >       and free's the QEMUFile object
> >=20
> >    4. proxy_mig_out thread returns from read() with
> >       ret =3D=3D 0 (EOF)
>=20
> This wasn't happening. It would be convenient if it did.
>=20
> When the file was closed by the main thread, the async thread was still
> hung at qemu_fill_buffer(), instead of returning 0 (EOF). That's reason
> why we took the thread-cancellation route. We'd be glad to remove
> qemu_thread_cancel().
>=20
> >=20
> >    5. proxy_mig_out thread calls qemu_file_set_error_obj
> >       on a QEMUFole object free'd in (3). use after free. opps
> >=20
> >    6. ..async cancel request gets delivered....
> >=20
> > admittedly it is fairly unlikely for the async cancel
> > to be delayed for so long that this sequence happens, but
> > unexpected things can happen when we really don't want them.
>=20
> Absolutely, we don't want to leave anything to chance.
>=20
> >=20
> > IMHO the safe way to deal with this would be a lock-step
> > sequence between the threads
> >=20
> >     1. proxy_mig_out blocked in read from qemu_fill_buffer
> >     2. main thread closes the FD with qemu_file_shutdown()
> >        closing both directions
>=20
> Will give qemu_file_shutdown() a try.

Yes, shutdown() is quite nice - but note it does need to be a socket.

Dave

> Thank you!
> --
> Jag
>=20
> >=20
> >     3. proxy_mig_out returns from read with ret =3D=3D 0 (EOF)
> >=20
> >     4. proxy_mig_out thread breaks out of its inifinite loop
> >        due to EOF and exits
> >=20
> >     5. main thread calls pthread_join on proxy_mig_out
> >=20
> >     6. main thread calls qemu_fclose()
> >=20
> > this is easier to reason about the safety of than the cancel based
> > approach IMHO.
> >=20
> > Regards,
> > Daniel
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


