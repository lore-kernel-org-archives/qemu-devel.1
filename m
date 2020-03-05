Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F03BC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF312072D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UR3Y0P0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF312072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9uC6-0004Ad-Di
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 12:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j9u9w-0000mR-DI
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:19:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j9u9t-0002C8-To
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:19:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56377
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j9u9t-0002BN-Nq
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:19:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583428781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hTJFqVA0lABDlwKUj390+GQUd6YzHgnGqXSwcitn4Ng=;
 b=UR3Y0P0PHaxO7QGSu+fUyWL1lcO9is7Na5IhwC2F2+waEykW35AWn15TUr2QkKdLv56wqk
 lBgOa61By00n79/H5ywLsNtfq9tGjNfLUtZ4dRxmXtU3kEXI8sR5v8JWmM1TSEC2XW9ZnU
 N/ReoMgHAmfB4AXEM4Qg14T5+b5olAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-Fl_dFMqvNy66D5n2Qgo5AQ-1; Thu, 05 Mar 2020 12:19:36 -0500
X-MC-Unique: Fl_dFMqvNy66D5n2Qgo5AQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86724107ACC9;
 Thu,  5 Mar 2020 17:19:34 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DB4F8B75C;
 Thu,  5 Mar 2020 17:19:21 +0000 (UTC)
Date: Thu, 5 Mar 2020 17:19:19 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [PATCH v5 40/50] multi-process/mig: build migration module in
 the remote process
Message-ID: <20200305171919.GO3130@work-vm>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <96a495711764282ff90504cec6734eff563ceb4d.1582576372.git.jag.raman@oracle.com>
 <20200304155859.GG4104@work-vm>
 <240f3182-80bb-f808-f93a-a41634eaff54@oracle.com>
 <20200304195201.GM4104@work-vm>
 <ce7ed38a-f17b-3a94-3a26-91abed632d17@oracle.com>
 <20200305101059.GC3130@work-vm> <20200305170746.GB26883@flaka>
MIME-Version: 1.0
In-Reply-To: <20200305170746.GB26883@flaka>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 Jag Raman <jag.raman@oracle.com>, quintela@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, liran.alon@oracle.com,
 stefanha@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Elena Ufimtseva (elena.ufimtseva@oracle.com) wrote:
> On Thu, Mar 05, 2020 at 10:10:59AM +0000, Dr. David Alan Gilbert wrote:
> > * Jag Raman (jag.raman@oracle.com) wrote:
> > >=20
> > >=20
> > > On 3/4/2020 2:52 PM, Dr. David Alan Gilbert wrote:
> > > > * Jag Raman (jag.raman@oracle.com) wrote:
> > > > >=20
> > > > >=20
> > > > > On 3/4/2020 10:58 AM, Dr. David Alan Gilbert wrote:
> > > > > > * Jagannathan Raman (jag.raman@oracle.com) wrote:
> > > > > > > Add Makefile support to enable migration in remote process
> > > > > > >=20
> > > > > > > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > > > > > > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > > > > > > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > > > > > > ---
> > > > > > >    Makefile.objs           |  4 +++-
> > > > > > >    Makefile.target         |  1 +
> > > > > > >    migration/Makefile.objs | 13 ++++++++++++-
> > > > > > >    net/Makefile.objs       |  2 ++
> > > > > > >    softmmu/vl.c            |  2 --
> > > > > > >    stubs/migration.c       | 49 +++++++++++++++++++++++++++++=
++++++++++++++++++++
> > > > > > >    stubs/net-stub.c        | 21 +++++++++++++++++++++
> > > > > > >    stubs/qapi-misc.c       |  2 ++
> > > > > > >    stubs/replay.c          |  8 ++++++++
> > > > > > >    stubs/vl-stub.c         | 24 ++++++++++++++++++++++++
> > > > > > >    vl-parse.c              |  3 +++
> > > > > > >    11 files changed, 125 insertions(+), 4 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/Makefile.objs b/Makefile.objs
> > > > > > > index 4b5db09..65009da 100644
> > > > > > > --- a/Makefile.objs
> > > > > > > +++ b/Makefile.objs
> > > > > > > @@ -74,6 +74,8 @@ common-obj-y +=3D qdev-monitor.o device-hot=
plug.o
> > > > > > >    common-obj-$(CONFIG_WIN32) +=3D os-win32.o
> > > > > > >    common-obj-$(CONFIG_POSIX) +=3D os-posix.o
> > > > > > > +remote-pci-obj-$(CONFIG_POSIX) +=3D os-posix.o
> > > > > > > +
> > > > > > >    common-obj-$(CONFIG_LINUX) +=3D fsdev/
> > > > > > >    common-obj-y +=3D accel/
> > > > > > > @@ -104,11 +106,11 @@ common-obj-y +=3D vl-parse.o
> > > > > > >    ##########################################################=
#############
> > > > > > >    # qapi
> > > > > > > -
> > > > > > >    common-obj-y +=3D qapi/
> > > > > > >    endif # CONFIG_SOFTMMU
> > > > > > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D net/
> > > > > > >    remote-pci-obj-$(CONFIG_MPQEMU) +=3D qapi/
> > > > > > >    remote-pci-obj-$(CONFIG_MPQEMU) +=3D blockdev-nbd.o
> > > > > > >    remote-pci-obj-$(CONFIG_MPQEMU) +=3D job-qmp.o
> > > > > > > diff --git a/Makefile.target b/Makefile.target
> > > > > > > index 4ead5c3..4012ae5 100644
> > > > > > > --- a/Makefile.target
> > > > > > > +++ b/Makefile.target
> > > > > > > @@ -240,6 +240,7 @@ all-remote-pci-obj-y +=3D exec.o
> > > > > > >    all-remote-pci-obj-y +=3D exec-vary.o
> > > > > > >    all-remote-pci-obj-y +=3D ioport.o
> > > > > > >    all-remote-pci-obj-y +=3D cpus.o
> > > > > > > +all-remote-pci-obj-y +=3D migration/ram.o
> > > > > > >    endif
> > > > > > >    remote-pci-obj-y :=3D
> > > > > > > diff --git a/migration/Makefile.objs b/migration/Makefile.obj=
s
> > > > > > > index e7cdc76..21f9d8d 100644
> > > > > > > --- a/migration/Makefile.objs
> > > > > > > +++ b/migration/Makefile.objs
> > > > > > > @@ -15,4 +15,15 @@ common-obj-$(CONFIG_LIVE_BLOCK_MIGRATION) =
+=3D block.o
> > > > > > >    rdma.o-libs :=3D $(RDMA_LIBS)
> > > > > > > -remote-pci-obj-$(CONFIG_MPQEMU) +=3D qemu-file.o vmstate.o q=
json.o vmstate-types.o
> > > > > > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D migration.o socket.o fd=
.o exec.o
> > > > > > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D tls.o channel.o savevm.=
o
> > > > > > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D colo.o colo-failover.o
> > > > > > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D vmstate.o vmstate-types=
.o page_cache.o
> > > > > > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D qemu-file.o global_stat=
e.o
> > > > > > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D qemu-file-channel.o
> > > > > > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D xbzrle.o postcopy-ram.o
> > > > > > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D qjson.o
> > > > > > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D block-dirty-bitmap.o
> > > > > > > +remote-pci-obj-$(CONFIG_RDMA) +=3D rdma.o
> > > > > > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D block.o
> > > > > > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D multifd.o
> > > > > >=20
> > > > > > Hmm, are you really going to want all this lot in your remote p=
rocess?
> > > > > > Assuming it's just devices, I can understand the first line or =
two, but
> > > > > > it seems odd to have all of this.
> > > > >=20
> > > > > Yeah, we ended up needing to compile these in to enable migration=
. We
> > > > > are only using "fd" to enable migration. Although we don't use tl=
s,
> > > > > xbzrle, rdma, multifd, etc... for example, the migration code doe=
s
> > > > > support these protocols and, therefore, we had to compile them in=
.
> > > >=20
> > > > But are you even running a migration stream from the remote process=
?
> > > > Aren't you just doing vmstate migration of devices; i.e. do you nee=
d
> > > > anything relating to incremental RAM migration (e.g. xbzrle, rdma,
> > > > postcopy).
> > >=20
> > > We are running a migration stream from the remote process. We are onl=
y
> > > doing the vmstate migration of devices, and not anything incremental
> > > related to RAM.
> > >=20
> > > We are using QEMU's existing migration infrastructure (vmstate_save /
> > > qemu_loadvm_section_start_full) to move the vmstate. Based on my limi=
ted
> > > experience with the migration code, I get that it comes as a suite.
> > > Without some refactoring, we would need to build all of the files wit=
hin
> > > the migration folder.
> > >=20
> > > The vmstate functions communicate over QEMUFile, which would be using
> > > fd, tcp, rdma, etc... at the backend. These functions also need other
> > > functions defined in migration.c, which require the building of xbzrl=
e,
> > > postcopy, etc...
> >=20
> > OK, I bet we can refactor some of that to be modular fairly easily; som=
e
> > is harder than others.  For example there are different QEMUFile
> > subclasses for RDMA, so you should be able to have just the top level
> > QEMUFile and the implementations you need.
> > Similarly the vmstate code shouldn't depend on the ram code;  we can
> > look at splitting it up some how.
> >
>=20
> Hi Dave
>=20
> We did initially tried to split some of the vmstate code, and it was a lo=
t of code to add to
> already big patchset. So we could do this split later on as a separate se=
ries.
> Would that be an option or you would rather see it in this set?

I'd say see if there are any easy things you can split; if there are
then lets take those as part of this series.

Dave

> Thank you!
>=20
> Elena=20
> > Dave
> >=20
> > > Thank you!
> > > --
> > > Jag
> > >=20
> > > >=20
> > > > Dave
> > > >=20
> > > > > Thank you!
> > > > > --
> > > > > Jag
> > > > >=20
> > > > > >=20
> > > > > > Dave
> > > > > >=20
> > > > > > > diff --git a/net/Makefile.objs b/net/Makefile.objs
> > > > > > > index c5d076d..a8ad986 100644
> > > > > > > --- a/net/Makefile.objs
> > > > > > > +++ b/net/Makefile.objs
> > > > > > > @@ -30,3 +30,5 @@ common-obj-$(CONFIG_WIN32) +=3D tap-win32.o
> > > > > > >    vde.o-libs =3D $(VDE_LIBS)
> > > > > > >    common-obj-$(CONFIG_CAN_BUS) +=3D can/
> > > > > > > +
> > > > > > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D announce.o
> > > > > > > diff --git a/softmmu/vl.c b/softmmu/vl.c
> > > > > > > index 4a4f52c..42d5682 100644
> > > > > > > --- a/softmmu/vl.c
> > > > > > > +++ b/softmmu/vl.c
> > > > > > > @@ -128,7 +128,6 @@ const char* keyboard_layout =3D NULL;
> > > > > > >    ram_addr_t ram_size;
> > > > > > >    const char *mem_path =3D NULL;
> > > > > > >    int mem_prealloc =3D 0; /* force preallocation of physical=
 target memory */
> > > > > > > -bool enable_mlock =3D false;
> > > > > > >    bool enable_cpu_pm =3D false;
> > > > > > >    int nb_nics;
> > > > > > >    NICInfo nd_table[MAX_NICS];
> > > > > > > @@ -168,7 +167,6 @@ const char *prom_envs[MAX_PROM_ENVS];
> > > > > > >    int boot_menu;
> > > > > > >    bool boot_strict;
> > > > > > >    uint8_t *boot_splash_filedata;
> > > > > > > -int only_migratable; /* turn it off unless user states other=
wise */
> > > > > > >    bool wakeup_suspend_enabled;
> > > > > > >    int icount_align_option;
> > > > > > > diff --git a/stubs/migration.c b/stubs/migration.c
> > > > > > > index 28ccf80..dbd12db 100644
> > > > > > > --- a/stubs/migration.c
> > > > > > > +++ b/stubs/migration.c
> > > > > > > @@ -6,6 +6,35 @@
> > > > > > >    #include "qapi/qapi-types-migration.h"
> > > > > > >    #include "qapi/qapi-commands-migration.h"
> > > > > > >    #include "qapi/qapi-types-net.h"
> > > > > > > +#include "net/filter.h"
> > > > > > > +#include "net/colo-compare.h"
> > > > > > > +
> > > > > > > +#pragma weak qmp_query_migrate_capabilities
> > > > > > > +#pragma weak qmp_query_migrate_parameters
> > > > > > > +#pragma weak migrate_announce_params
> > > > > > > +#pragma weak qmp_query_migrate
> > > > > > > +#pragma weak qmp_migrate_set_capabilities
> > > > > > > +#pragma weak qmp_migrate_set_parameters
> > > > > > > +#pragma weak qmp_migrate_incoming
> > > > > > > +#pragma weak qmp_migrate_recover
> > > > > > > +#pragma weak qmp_migrate_pause
> > > > > > > +#pragma weak qmp_migrate
> > > > > > > +#pragma weak qmp_migrate_cancel
> > > > > > > +#pragma weak qmp_migrate_continue
> > > > > > > +#pragma weak qmp_migrate_set_cache_size
> > > > > > > +#pragma weak qmp_query_migrate_cache_size
> > > > > > > +#pragma weak qmp_migrate_set_speed
> > > > > > > +#pragma weak qmp_migrate_set_downtime
> > > > > > > +#pragma weak qmp_migrate_start_postcopy
> > > > > > > +#pragma weak migration_global_dump
> > > > > > > +#pragma weak save_snapshot
> > > > > > > +#pragma weak qmp_xen_save_devices_state
> > > > > > > +#pragma weak load_snapshot
> > > > > > > +#pragma weak qmp_xen_set_replication
> > > > > > > +#pragma weak qmp_query_xen_replication_status
> > > > > > > +#pragma weak qmp_xen_colo_do_checkpoint
> > > > > > > +#pragma weak qmp_query_colo_status
> > > > > > > +#pragma weak qmp_x_colo_lost_heartbeat
> > > > > > >    MigrationInfo *qmp_query_migrate(Error **errp)
> > > > > > >    {
> > > > > > > @@ -160,3 +189,23 @@ AnnounceParameters *migrate_announce_par=
ams(void)
> > > > > > >        return NULL;
> > > > > > >    }
> > > > > > > +
> > > > > > > +void colo_notify_filters_event(int event, Error **errp)
> > > > > > > +{
> > > > > > > +    qemu_debug_assert(0);
> > > > > > > +}
> > > > > > > +
> > > > > > > +void colo_notify_compares_event(void *opaque, int event, Err=
or **errp)
> > > > > > > +{
> > > > > > > +    qemu_debug_assert(0);
> > > > > > > +}
> > > > > > > +
> > > > > > > +void colo_compare_register_notifier(Notifier *notify)
> > > > > > > +{
> > > > > > > +    qemu_debug_assert(0);
> > > > > > > +}
> > > > > > > +
> > > > > > > +void colo_compare_unregister_notifier(Notifier *notify)
> > > > > > > +{
> > > > > > > +    qemu_debug_assert(0);
> > > > > > > +}
> > > > > > > diff --git a/stubs/net-stub.c b/stubs/net-stub.c
> > > > > > > index 962827e..ddfd1e4 100644
> > > > > > > --- a/stubs/net-stub.c
> > > > > > > +++ b/stubs/net-stub.c
> > > > > > > @@ -5,6 +5,8 @@
> > > > > > >    #include "qapi/qapi-commands-net.h"
> > > > > > >    #include "qapi/qapi-commands-rocker.h"
> > > > > > > +#pragma weak qmp_announce_self
> > > > > > > +
> > > > > > >    int qemu_find_net_clients_except(const char *id, NetClient=
State **ncs,
> > > > > > >                                     NetClientDriver type, int=
 max)
> > > > > > >    {
> > > > > > > @@ -98,3 +100,22 @@ void netdev_add(QemuOpts *opts, Error **e=
rrp)
> > > > > > >    {
> > > > > > >        qemu_debug_assert(0);
> > > > > > >    }
> > > > > > > +
> > > > > > > +NetClientState *qemu_get_queue(NICState *nic)
> > > > > > > +{
> > > > > > > +    qemu_debug_assert(0);
> > > > > > > +
> > > > > > > +    return NULL;
> > > > > > > +}
> > > > > > > +
> > > > > > > +ssize_t qemu_send_packet_raw(NetClientState *nc, const uint8=
_t *buf, int size)
> > > > > > > +{
> > > > > > > +    qemu_debug_assert(0);
> > > > > > > +
> > > > > > > +    return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +void qemu_foreach_nic(qemu_nic_foreach func, void *opaque)
> > > > > > > +{
> > > > > > > +    qemu_debug_assert(0);
> > > > > > > +}
> > > > > > > diff --git a/stubs/qapi-misc.c b/stubs/qapi-misc.c
> > > > > > > index 3eeedd9..824eac1 100644
> > > > > > > --- a/stubs/qapi-misc.c
> > > > > > > +++ b/stubs/qapi-misc.c
> > > > > > > @@ -5,6 +5,8 @@
> > > > > > >    #include "./qapi/qapi-types-dump.h"
> > > > > > >    #include "qapi/qapi-commands-dump.h"
> > > > > > > +#pragma weak qmp_xen_load_devices_state
> > > > > > > +
> > > > > > >    void qmp_dump_guest_memory(bool paging, const char *file,
> > > > > > >                               bool has_detach, bool detach,
> > > > > > >                               bool has_begin, int64_t begin, =
bool has_length,
> > > > > > > diff --git a/stubs/replay.c b/stubs/replay.c
> > > > > > > index 9b53c0c..6fc7850 100644
> > > > > > > --- a/stubs/replay.c
> > > > > > > +++ b/stubs/replay.c
> > > > > > > @@ -1,4 +1,5 @@
> > > > > > >    #include "qemu/osdep.h"
> > > > > > > +#include "qemu-common.h"
> > > > > > >    #include "sysemu/replay.h"
> > > > > > >    ReplayMode replay_mode;
> > > > > > > @@ -106,3 +107,10 @@ void replay_account_executed_instruction=
s(void)
> > > > > > >    void replay_add_blocker(Error *reason)
> > > > > > >    {
> > > > > > >    }
> > > > > > > +
> > > > > > > +bool replay_can_snapshot(void)
> > > > > > > +{
> > > > > > > +    qemu_debug_assert(0);
> > > > > > > +
> > > > > > > +    return false;
> > > > > > > +}
> > > > > > > diff --git a/stubs/vl-stub.c b/stubs/vl-stub.c
> > > > > > > index 606f078..5f308c1 100644
> > > > > > > --- a/stubs/vl-stub.c
> > > > > > > +++ b/stubs/vl-stub.c
> > > > > > > @@ -14,6 +14,8 @@
> > > > > > >    #include "disas/disas.h"
> > > > > > >    #include "audio/audio.h"
> > > > > > > +#pragma weak qemu_add_exit_notifier
> > > > > > > +
> > > > > > >    bool tcg_allowed;
> > > > > > >    bool xen_allowed;
> > > > > > >    bool boot_strict;
> > > > > > > @@ -169,3 +171,25 @@ int wav_start_capture(AudioState *state,=
 CaptureState *s, const char *path,
> > > > > > >        return -1;
> > > > > > >    }
> > > > > > > +
> > > > > > > +void qemu_system_killed(int signal, pid_t pid)
> > > > > > > +{
> > > > > > > +    qemu_debug_assert(0);
> > > > > > > +}
> > > > > > > +
> > > > > > > +void qemu_system_reset(ShutdownCause reason)
> > > > > > > +{
> > > > > > > +    qemu_debug_assert(0);
> > > > > > > +}
> > > > > > > +
> > > > > > > +bool runstate_store(char *str, size_t size)
> > > > > > > +{
> > > > > > > +    qemu_debug_assert(0);
> > > > > > > +
> > > > > > > +    return false;
> > > > > > > +}
> > > > > > > +
> > > > > > > +void qemu_add_exit_notifier(Notifier *notify)
> > > > > > > +{
> > > > > > > +    qemu_debug_assert(0);
> > > > > > > +}
> > > > > > > diff --git a/vl-parse.c b/vl-parse.c
> > > > > > > index 1f6a3f0..423f4a0 100644
> > > > > > > --- a/vl-parse.c
> > > > > > > +++ b/vl-parse.c
> > > > > > > @@ -27,6 +27,9 @@
> > > > > > >    #include "vl.h"
> > > > > > > +int only_migratable; /* turn it off unless user states other=
wise */
> > > > > > > +bool enable_mlock;
> > > > > > > +
> > > > > > >    /*********************************************************=
**/
> > > > > > >    /* QEMU Block devices */
> > > > > > > --=20
> > > > > > > 1.8.3.1
> > > > > > >=20
> > > > > > --
> > > > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > > > >=20
> > > > >=20
> > > > --
> > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > >=20
> > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


