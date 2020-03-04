Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F83EC3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 19:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D7C2166E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 19:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTc7fSxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D7C2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9ZI3-0003XO-9f
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 14:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j9ZGg-00027U-1y
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 14:01:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j9ZGa-0006Zu-QR
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 14:01:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23690
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j9ZGa-0006ZG-M4
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 14:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583348472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTqlpx3/csh01T0S03C4Pxnk6l4XbIJiWbXuAfXiVN4=;
 b=KTc7fSxgpT+IcFBzKy0J5F5sSt7RIra8c6fONtqQjd7rq/i5fsHJwkcMAhwiaqW8vNDGLJ
 jURBuW19ZOroWtRIbdURZMC/3R1BdkaDh7x+xLDPtr+SVaQ2GKVVkqMaMiwH5Rgvz+8hHo
 cEm0huogca2gKy1WGH9mVSOvgkHAoks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-HYm81kdbMiKCfCZ8rIwj5A-1; Wed, 04 Mar 2020 14:01:06 -0500
X-MC-Unique: HYm81kdbMiKCfCZ8rIwj5A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B4BE802582;
 Wed,  4 Mar 2020 19:01:04 +0000 (UTC)
Received: from work-vm (ovpn-116-225.ams2.redhat.com [10.36.116.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 419267389E;
 Wed,  4 Mar 2020 19:00:48 +0000 (UTC)
Date: Wed, 4 Mar 2020 19:00:45 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jag Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v5 12/50] multi-process: remote process initialization
Message-ID: <20200304190045.GK4104@work-vm>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <264de034fcdc1000bada4a93ac7e0856fef591f2.1582576372.git.jag.raman@oracle.com>
 <20200304102959.GB4104@work-vm>
 <8be42511-b355-f375-7dc2-6bbf949ba36f@oracle.com>
MIME-Version: 1.0
In-Reply-To: <8be42511-b355-f375-7dc2-6bbf949ba36f@oracle.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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

* Jag Raman (jag.raman@oracle.com) wrote:
>=20
>=20
> On 3/4/2020 5:29 AM, Dr. David Alan Gilbert wrote:
> > * Jagannathan Raman (jag.raman@oracle.com) wrote:
> > > Adds the handler to process message from QEMU,
> > > Initialize remote process main loop, handles SYNC_SYSMEM
> > > message by updating its "system_memory" container using
> > > shared file descriptors received from QEMU.
> > >=20
> > > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > > ---
> > >   v4 -> v5:
> > >    - We checked if we could use functions already defined in
> > >      util/main-loop.c instead of using g_main_loop_run. However,
> > >      we couldn't find a suitable function that's generic enough
> > >      to do this. All of them have emulator code embedded in them
> > >      which is not used by the remote process. We are therefore
> > >      not making any change to this patch
> > >=20
> > >   remote/remote-main.c | 85 +++++++++++++++++++++++++++++++++++++++++=
+++++++++++
> > >   1 file changed, 85 insertions(+)
> > >=20
> > > diff --git a/remote/remote-main.c b/remote/remote-main.c
> > > index ecf30e0..56315cd 100644
> > > --- a/remote/remote-main.c
> > > +++ b/remote/remote-main.c
> > > @@ -12,6 +12,7 @@
> > >   #include "qemu-common.h"
> > >   #include <stdio.h>
> > > +#include <unistd.h>
> > >   #include "qemu/module.h"
> > >   #include "remote/pcihost.h"
> > > @@ -19,12 +20,96 @@
> > >   #include "hw/boards.h"
> > >   #include "hw/qdev-core.h"
> > >   #include "qemu/main-loop.h"
> > > +#include "remote/memory.h"
> > > +#include "io/mpqemu-link.h"
> > > +#include "qapi/error.h"
> > > +#include "qemu/main-loop.h"
> > > +#include "sysemu/cpus.h"
> > > +#include "qemu-common.h"
> > > +#include "hw/pci/pci.h"
> > > +#include "qemu/thread.h"
> > > +#include "qemu/main-loop.h"
> > > +#include "qemu/config-file.h"
> > > +#include "sysemu/sysemu.h"
> > > +#include "block/block.h"
> > > +#include "exec/ramlist.h"
> > > +
> > > +static MPQemuLinkState *mpqemu_link;
> > > +PCIDevice *remote_pci_dev;
> > > +
> > > +static void process_msg(GIOCondition cond, MPQemuChannel *chan)
> > > +{
> > > +    MPQemuMsg *msg =3D NULL;
> > > +    Error *err =3D NULL;
> > > +
> > > +    if ((cond & G_IO_HUP) || (cond & G_IO_ERR)) {
> > > +        goto finalize_loop;
> > > +    }
> > > +
> > > +    msg =3D g_malloc0(sizeof(MPQemuMsg));
> > > +
> > > +    if (mpqemu_msg_recv(msg, chan) < 0) {
> > > +        error_setg(&err, "Failed to receive message");
> >=20
> > Please give error messages more context, e.g. the device or process nam=
e
> > or something like that so that; it helps when we get a user
> > reporting a crash and they report 'Unknown command' in their log, but
> > then we have to figure out where to point them.
>=20
> Ah OK, we'll add the exec name & PID of the QEMU process that spawned
> this remote process in the error messages.

Great, if you can get something to say which process this particular one
is it would be good; so if you've got multiple remote processes we know
which one spat out the error.

Dave

> Thank you!
> --
> Jag
>=20
> >=20
> > > +        goto finalize_loop;
> > > +    }
> > > +
> > > +    switch (msg->cmd) {
> > > +    case INIT:
> > > +        break;
> > > +    case PCI_CONFIG_WRITE:
> > > +        break;
> > > +    case PCI_CONFIG_READ:
> > > +        break;
> > > +    default:
> > > +        error_setg(&err, "Unknown command");
> > > +        goto finalize_loop;
> > > +    }
> > > +
> > > +    g_free(msg->data2);
> > > +    g_free(msg);
> > > +
> > > +    return;
> > > +
> > > +finalize_loop:
> > > +    if (err) {
> > > +        error_report_err(err);
> > > +    }
> > > +    g_free(msg);
> > > +    mpqemu_link_finalize(mpqemu_link);
> > > +    mpqemu_link =3D NULL;
> > > +}
> > >   int main(int argc, char *argv[])
> > >   {
> > > +    Error *err =3D NULL;
> > > +
> > >       module_call_init(MODULE_INIT_QOM);
> > > +    bdrv_init_with_whitelist();
> > > +
> > > +    if (qemu_init_main_loop(&err)) {
> > > +        error_report_err(err);
> > > +        return -EBUSY;
> > > +    }
> > > +
> > > +    qemu_init_cpu_loop();
> > > +
> > > +    page_size_init();
> > > +
> > > +    qemu_mutex_init(&ram_list.mutex);
> > > +
> >=20
> > So these are some subset of the things from qemu_init; I guess
> > we'll have to be careful when we add stuff to vl.c to think what should
> > also be added here.
> >=20
> > Dave
> >=20
> > >       current_machine =3D MACHINE(REMOTE_MACHINE(object_new(TYPE_REMO=
TE_MACHINE)));
> > > +    mpqemu_link =3D mpqemu_link_create();
> > > +    if (!mpqemu_link) {
> > > +        printf("Could not create MPQemu link\n");
> > > +        return -1;
> > > +    }
> > > +
> > > +    mpqemu_init_channel(mpqemu_link, &mpqemu_link->com, STDIN_FILENO=
);
> > > +    mpqemu_link_set_callback(mpqemu_link, process_msg);
> > > +
> > > +    mpqemu_start_coms(mpqemu_link);
> > > +
> > >       return 0;
> > >   }
> > > --=20
> > > 1.8.3.1
> > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


