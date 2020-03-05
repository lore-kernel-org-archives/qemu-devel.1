Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2654AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F572072D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJw1XsBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F572072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9sor-0005X3-3l
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 10:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j9snm-0004qL-5B
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:52:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j9snj-0000zP-3W
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:52:46 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46581
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j9snf-0000y2-7Y
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583423558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PwPbI082GbNviqH9+izMOWokLmMaAXZcPtNJA9ceA5Q=;
 b=aJw1XsBH7eQYZLsbV6CH0HARCuA0npbUvdm2F78BV8+CtAFMhbIHMpr86CkcVLxUTycpAw
 PoH9LtXNpc2jc3LrsFE3xsrpOaJmxa3LELDi8RL4nKcbxJTn7XdEU353LABpf8rZeVK9tA
 9m08wzJYvlQyNLiFMd14N+1OqzVpEWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-NLHx4FVGMNO-M6SSuLyWEQ-1; Thu, 05 Mar 2020 10:52:34 -0500
X-MC-Unique: NLHx4FVGMNO-M6SSuLyWEQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC9A01005510;
 Thu,  5 Mar 2020 15:52:32 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57A74272A2;
 Thu,  5 Mar 2020 15:52:20 +0000 (UTC)
Date: Thu, 5 Mar 2020 15:52:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jag Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v5 36/50] multi-process/mon: enable QMP module support in
 the remote process
Message-ID: <20200305155217.GL3130@work-vm>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <0de0baf0df7df660c67573d4d355543d00f23f07.1582576372.git.jag.raman@oracle.com>
 <20200305104340.GF3130@work-vm>
 <3f8b1d31-432e-0e1d-fc81-0deeb123f8ed@oracle.com>
MIME-Version: 1.0
In-Reply-To: <3f8b1d31-432e-0e1d-fc81-0deeb123f8ed@oracle.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
> On 3/5/2020 5:43 AM, Dr. David Alan Gilbert wrote:
> > * Jagannathan Raman (jag.raman@oracle.com) wrote:
> > > Build system changes to enable QMP module in the remote process
> > >=20
> > > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> >=20
> > It's odd that this is labelled as QMP changes yet a lot of the code is
> > actually HMP de-staticing.
>=20
> This patch builds the QMP related code into the remote process. In order
> to facilitate the build, we need to de-staticize a bunch of HMP
> functions.
>=20
> May be we could update the patch title to reflect the destaticing as
> well.

Or split it into two.

Dave

> Thanks!
> --
> Jag
>=20
> >=20
> > Dave
> >=20
> > > ---
> > >   Makefile.objs              |  9 +++++
> > >   Makefile.target            | 35 +++++++++++++++++--
> > >   hmp-commands.hx            |  5 +--
> > >   hw/core/Makefile.objs      |  1 +
> > >   monitor/Makefile.objs      |  4 +++
> > >   monitor/misc.c             | 84 +++++++++++++++++++++++++----------=
-----------
> > >   monitor/monitor-internal.h | 38 +++++++++++++++++++++
> > >   qapi/Makefile.objs         |  2 ++
> > >   qom/Makefile.objs          |  1 +
> > >   ui/Makefile.objs           |  2 ++
> > >   10 files changed, 139 insertions(+), 42 deletions(-)
> > >=20
> > > diff --git a/Makefile.objs b/Makefile.objs
> > > index 689a722..4b5db09 100644
> > > --- a/Makefile.objs
> > > +++ b/Makefile.objs
> > > @@ -32,6 +32,7 @@ remote-pci-obj-$(CONFIG_MPQEMU) +=3D migration/
> > >   remote-pci-obj-$(CONFIG_MPQEMU) +=3D remote/
> > >   remote-pci-obj-$(CONFIG_MPQEMU) +=3D accel/
> > >   remote-pci-obj-$(CONFIG_MPQEMU) +=3D util/
> > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D monitor/
> > >   remote-pci-obj-$(CONFIG_MPQEMU) +=3D cpus-common.o
> > >   remote-pci-obj-$(CONFIG_MPQEMU) +=3D dma-helpers.o
> > > @@ -44,6 +45,9 @@ remote-pci-obj-$(CONFIG_MPQEMU) +=3D iothread.o
> > >   # remote-lsi-obj-y is code used to implement remote LSI device
> > >   remote-lsi-obj-$(CONFIG_MPQEMU) +=3D hw/
> > > +remote-lsi-obj-$(CONFIG_MPQEMU) +=3D ui/
> > > +
> > > +remote-lsi-obj-$(CONFIG_MPQEMU) +=3D device-hotplug.o
> > >   ###################################################################=
####
> > >   # crypto-obj-y is code used by both qemu system emulation and qemu-=
img
> > > @@ -105,6 +109,11 @@ common-obj-y +=3D qapi/
> > >   endif # CONFIG_SOFTMMU
> > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D qapi/
> > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D blockdev-nbd.o
> > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D job-qmp.o
> > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D balloon.o
> > > +
> > >   ###################################################################=
####
> > >   # Target-independent parts used in system and user emulation
> > >   common-obj-y +=3D cpus-common.o
> > > diff --git a/Makefile.target b/Makefile.target
> > > index 035c23b..4ead5c3 100644
> > > --- a/Makefile.target
> > > +++ b/Makefile.target
> > > @@ -142,13 +142,32 @@ remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D accel/=
stubs/hax-stub.o
> > >   remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D accel/stubs/whpx-stub.o
> > >   remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/vl-stub.o
> > >   remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/net-stub.o
> > > -remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/monitor.o
> > >   remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/replay.o
> > >   remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/xen-mapcache.o
> > >   remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/audio.o
> > >   remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/monitor.o
> > > +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/migration.o
> > > +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/ui-stub.o
> > > +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/gdbstub.o
> > > +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/qapi-target.o
> > > +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/qapi-misc.o
> > >   remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D remote/memory.o
> > > +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D arch_init.o
> > > +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D monitor/misc.o
> > > +
> > > +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D qapi/qapi-introspect.o
> > > +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D qapi/qapi-commands-block-co=
re.o
> > > +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D qapi/qapi-commands-block.o
> > > +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D qapi/qapi-commands-misc.o
> > > +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D qapi/qapi-commands.o
> > > +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D qapi/qapi-commands-machine-=
target.o
> > > +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D qapi/qapi-commands-misc-tar=
get.o
> > > +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D qapi/qapi-visit-machine-tar=
get.o
> > > +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D qapi/qapi-visit-misc-target=
.o
> > > +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D qapi/qapi-types-machine-tar=
get.o
> > > +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D qapi/qapi-types-misc-target=
.o
> > > +remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D qapi/qapi-init-commands.o
> > >   endif
> > >   #########################################################
> > > @@ -203,6 +222,10 @@ endif
> > >   generated-files-y +=3D hmp-commands.h hmp-commands-info.h
> > >   generated-files-y +=3D config-devices.h
> > > +ifdef CONFIG_MPQEMU
> > > +generated-files-y +=3D hmp-scsi-commands.h hmp-scsi-commands-info.h
> > > +endif
> > > +
> > >   endif # CONFIG_SOFTMMU
> > >   dummy :=3D $(call unnest-vars,,obj-y)
> > > @@ -288,10 +311,18 @@ hmp-commands.h: $(SRC_PATH)/hmp-commands.hx $(S=
RC_PATH)/scripts/hxtool
> > >   hmp-commands-info.h: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/s=
cripts/hxtool
> > >   =09$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,=
"GEN","$(TARGET_DIR)$@")
> > > +ifdef CONFIG_MPQEMU
> > > +hmp-scsi-commands.h: $(SRC_PATH)/hmp-commands.hx $(SRC_PATH)/scripts=
/hxtool
> > > +=09$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -tgt scsi < $<=
 > $@)
> > > +
> > > +hmp-scsi-commands-info.h: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PAT=
H)/scripts/hxtool
> > > +=09$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -tgt scsi < $<=
 > $@)
> > > +endif
> > > +
> > >   clean: clean-target
> > >   =09rm -f *.a *~ $(PROGS)
> > >   =09rm -f $(shell find . -name '*.[od]')
> > > -=09rm -f hmp-commands.h gdbstub-xml.c
> > > +=09rm -f hmp-commands.h gdbstub-xml.c hmp-scsi-commands.h hmp-scsi-c=
ommands-info.h
> > >   =09rm -f trace/generated-helpers.c trace/generated-helpers.c-timest=
amp
> > >   ifdef CONFIG_TRACE_SYSTEMTAP
> > >   =09rm -f *.stp
> > > diff --git a/hmp-commands.hx b/hmp-commands.hx
> > > index ecc6169..a1932c4 100644
> > > --- a/hmp-commands.hx
> > > +++ b/hmp-commands.hx
> > > @@ -14,7 +14,8 @@ ETEXI
> > >           .args_type  =3D "name:S?",
> > >           .params     =3D "[cmd]",
> > >           .help       =3D "show the help",
> > > -        .cmd        =3D do_help_cmd,
> > > +        .cmd        =3D hmp_do_help_cmd,
> > > +        .targets    =3D "scsi",
> > >           .flags      =3D "p",
> > >       },
> > > @@ -618,7 +619,7 @@ ETEXI
> > >           .args_type  =3D "fmt:/,val:l",
> > >           .params     =3D "/fmt expr",
> > >           .help       =3D "print expression value (use $reg for CPU r=
egister access)",
> > > -        .cmd        =3D do_print,
> > > +        .cmd        =3D hmp_do_print,
> > >       },
> > >   STEXI
> > > diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> > > index e3e8084..251b77b 100644
> > > --- a/hw/core/Makefile.objs
> > > +++ b/hw/core/Makefile.objs
> > > @@ -49,3 +49,4 @@ remote-pci-obj-$(CONFIG_MPQEMU) +=3D numa.o
> > >   remote-pci-obj-$(CONFIG_MPQEMU) +=3D cpu.o
> > >   remote-pci-obj-$(CONFIG_MPQEMU) +=3D vmstate-if.o
> > >   remote-pci-obj-$(CONFIG_MPQEMU) +=3D resettable.o
> > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D machine-qmp-cmds.o
> > > diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
> > > index 9244d90..48d8017 100644
> > > --- a/monitor/Makefile.objs
> > > +++ b/monitor/Makefile.objs
> > > @@ -2,3 +2,7 @@ obj-y +=3D misc.o
> > >   common-obj-y +=3D monitor.o qmp.o hmp.o
> > >   common-obj-y +=3D qmp-cmds.o qmp-cmds-control.o
> > >   common-obj-y +=3D hmp-cmds.o
> > > +
> > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D monitor.o qmp.o hmp.o
> > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D qmp-cmds.o qmp-cmds-control.o
> > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D hmp-cmds.o
> > > diff --git a/monitor/misc.c b/monitor/misc.c
> > > index 6c41293..f1f09bf 100644
> > > --- a/monitor/misc.c
> > > +++ b/monitor/misc.c
> > > @@ -177,12 +177,12 @@ int hmp_compare_cmd(const char *name, const cha=
r *list)
> > >       return 0;
> > >   }
> > > -static void do_help_cmd(Monitor *mon, const QDict *qdict)
> > > +void hmp_do_help_cmd(Monitor *mon, const QDict *qdict)
> > >   {
> > >       help_cmd(mon, qdict_get_try_str(qdict, "name"));
> > >   }
> > > -static void hmp_trace_event(Monitor *mon, const QDict *qdict)
> > > +void hmp_trace_event(Monitor *mon, const QDict *qdict)
> > >   {
> > >       const char *tp_name =3D qdict_get_str(qdict, "name");
> > >       bool new_state =3D qdict_get_bool(qdict, "option");
> > > @@ -226,7 +226,7 @@ static void hmp_trace_file(Monitor *mon, const QD=
ict *qdict)
> > >   }
> > >   #endif
> > > -static void hmp_info_help(Monitor *mon, const QDict *qdict)
> > > +void hmp_info_help(Monitor *mon, const QDict *qdict)
> > >   {
> > >       help_cmd(mon, "info");
> > >   }
> > > @@ -314,7 +314,7 @@ int monitor_get_cpu_index(void)
> > >       return cs ? cs->cpu_index : UNASSIGNED_CPU_INDEX;
> > >   }
> > > -static void hmp_info_registers(Monitor *mon, const QDict *qdict)
> > > +void hmp_info_registers(Monitor *mon, const QDict *qdict)
> > >   {
> > >       bool all_cpus =3D qdict_get_try_bool(qdict, "cpustate_all", fal=
se);
> > >       CPUState *cs;
> > > @@ -337,7 +337,7 @@ static void hmp_info_registers(Monitor *mon, cons=
t QDict *qdict)
> > >   }
> > >   #ifdef CONFIG_TCG
> > > -static void hmp_info_jit(Monitor *mon, const QDict *qdict)
> > > +void hmp_info_jit(Monitor *mon, const QDict *qdict)
> > >   {
> > >       if (!tcg_enabled()) {
> > >           error_report("JIT information is only available with accel=
=3Dtcg");
> > > @@ -348,13 +348,13 @@ static void hmp_info_jit(Monitor *mon, const QD=
ict *qdict)
> > >       dump_drift_info();
> > >   }
> > > -static void hmp_info_opcount(Monitor *mon, const QDict *qdict)
> > > +void hmp_info_opcount(Monitor *mon, const QDict *qdict)
> > >   {
> > >       dump_opcount_info();
> > >   }
> > >   #endif
> > > -static void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
> > > +void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
> > >   {
> > >       int64_t max =3D qdict_get_try_int(qdict, "max", 10);
> > >       bool mean =3D qdict_get_try_bool(qdict, "mean", false);
> > > @@ -365,7 +365,7 @@ static void hmp_info_sync_profile(Monitor *mon, c=
onst QDict *qdict)
> > >       qsp_report(max, sort_by, coalesce);
> > >   }
> > > -static void hmp_info_history(Monitor *mon, const QDict *qdict)
> > > +void hmp_info_history(Monitor *mon, const QDict *qdict)
> > >   {
> > >       MonitorHMP *hmp_mon =3D container_of(mon, MonitorHMP, common);
> > >       int i;
> > > @@ -385,7 +385,7 @@ static void hmp_info_history(Monitor *mon, const =
QDict *qdict)
> > >       }
> > >   }
> > > -static void hmp_info_cpustats(Monitor *mon, const QDict *qdict)
> > > +void hmp_info_cpustats(Monitor *mon, const QDict *qdict)
> > >   {
> > >       CPUState *cs =3D mon_get_cpu();
> > > @@ -396,7 +396,7 @@ static void hmp_info_cpustats(Monitor *mon, const=
 QDict *qdict)
> > >       cpu_dump_statistics(cs, 0);
> > >   }
> > > -static void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
> > > +void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
> > >   {
> > >       const char *name =3D qdict_get_try_str(qdict, "name");
> > >       bool has_vcpu =3D qdict_haskey(qdict, "vcpu");
> > > @@ -456,7 +456,7 @@ void qmp_client_migrate_info(const char *protocol=
, const char *hostname,
> > >       error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "protocol", "spi=
ce");
> > >   }
> > > -static void hmp_logfile(Monitor *mon, const QDict *qdict)
> > > +void hmp_logfile(Monitor *mon, const QDict *qdict)
> > >   {
> > >       Error *err =3D NULL;
> > > @@ -466,7 +466,7 @@ static void hmp_logfile(Monitor *mon, const QDict=
 *qdict)
> > >       }
> > >   }
> > > -static void hmp_log(Monitor *mon, const QDict *qdict)
> > > +void hmp_log(Monitor *mon, const QDict *qdict)
> > >   {
> > >       int mask;
> > >       const char *items =3D qdict_get_str(qdict, "items");
> > > @@ -483,7 +483,7 @@ static void hmp_log(Monitor *mon, const QDict *qd=
ict)
> > >       qemu_set_log(mask);
> > >   }
> > > -static void hmp_singlestep(Monitor *mon, const QDict *qdict)
> > > +void hmp_singlestep(Monitor *mon, const QDict *qdict)
> > >   {
> > >       const char *option =3D qdict_get_try_str(qdict, "option");
> > >       if (!option || !strcmp(option, "on")) {
> > > @@ -495,7 +495,7 @@ static void hmp_singlestep(Monitor *mon, const QD=
ict *qdict)
> > >       }
> > >   }
> > > -static void hmp_gdbserver(Monitor *mon, const QDict *qdict)
> > > +void hmp_gdbserver(Monitor *mon, const QDict *qdict)
> > >   {
> > >       const char *device =3D qdict_get_try_str(qdict, "device");
> > >       if (!device)
> > > @@ -511,7 +511,7 @@ static void hmp_gdbserver(Monitor *mon, const QDi=
ct *qdict)
> > >       }
> > >   }
> > > -static void hmp_watchdog_action(Monitor *mon, const QDict *qdict)
> > > +void hmp_watchdog_action(Monitor *mon, const QDict *qdict)
> > >   {
> > >       const char *action =3D qdict_get_str(qdict, "action");
> > >       if (select_watchdog_action(action) =3D=3D -1) {
> > > @@ -653,7 +653,7 @@ static void memory_dump(Monitor *mon, int count, =
int format, int wsize,
> > >       }
> > >   }
> > > -static void hmp_memory_dump(Monitor *mon, const QDict *qdict)
> > > +void hmp_memory_dump(Monitor *mon, const QDict *qdict)
> > >   {
> > >       int count =3D qdict_get_int(qdict, "count");
> > >       int format =3D qdict_get_int(qdict, "format");
> > > @@ -663,7 +663,7 @@ static void hmp_memory_dump(Monitor *mon, const Q=
Dict *qdict)
> > >       memory_dump(mon, count, format, size, addr, 0);
> > >   }
> > > -static void hmp_physical_memory_dump(Monitor *mon, const QDict *qdic=
t)
> > > +void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
> > >   {
> > >       int count =3D qdict_get_int(qdict, "count");
> > >       int format =3D qdict_get_int(qdict, "format");
> > > @@ -693,7 +693,7 @@ static void *gpa2hva(MemoryRegion **p_mr, hwaddr =
addr, Error **errp)
> > >       return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_re=
gion);
> > >   }
> > > -static void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
> > > +void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
> > >   {
> > >       hwaddr addr =3D qdict_get_int(qdict, "addr");
> > >       Error *local_err =3D NULL;
> > > @@ -713,7 +713,7 @@ static void hmp_gpa2hva(Monitor *mon, const QDict=
 *qdict)
> > >       memory_region_unref(mr);
> > >   }
> > > -static void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
> > > +void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
> > >   {
> > >       target_ulong addr =3D qdict_get_int(qdict, "addr");
> > >       MemTxAttrs attrs;
> > > @@ -768,7 +768,7 @@ out:
> > >       return ret;
> > >   }
> > > -static void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
> > > +void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
> > >   {
> > >       hwaddr addr =3D qdict_get_int(qdict, "addr");
> > >       Error *local_err =3D NULL;
> > > @@ -795,7 +795,7 @@ static void hmp_gpa2hpa(Monitor *mon, const QDict=
 *qdict)
> > >   }
> > >   #endif
> > > -static void do_print(Monitor *mon, const QDict *qdict)
> > > +void hmp_do_print(Monitor *mon, const QDict *qdict)
> > >   {
> > >       int format =3D qdict_get_int(qdict, "format");
> > >       hwaddr val =3D qdict_get_int(qdict, "val");
> > > @@ -821,7 +821,7 @@ static void do_print(Monitor *mon, const QDict *q=
dict)
> > >       monitor_printf(mon, "\n");
> > >   }
> > > -static void hmp_sum(Monitor *mon, const QDict *qdict)
> > > +void hmp_sum(Monitor *mon, const QDict *qdict)
> > >   {
> > >       uint32_t addr;
> > >       uint16_t sum;
> > > @@ -841,7 +841,7 @@ static void hmp_sum(Monitor *mon, const QDict *qd=
ict)
> > >   static int mouse_button_state;
> > > -static void hmp_mouse_move(Monitor *mon, const QDict *qdict)
> > > +void hmp_mouse_move(Monitor *mon, const QDict *qdict)
> > >   {
> > >       int dx, dy, dz, button;
> > >       const char *dx_str =3D qdict_get_str(qdict, "dx_str");
> > > @@ -865,7 +865,7 @@ static void hmp_mouse_move(Monitor *mon, const QD=
ict *qdict)
> > >       qemu_input_event_sync();
> > >   }
> > > -static void hmp_mouse_button(Monitor *mon, const QDict *qdict)
> > > +void hmp_mouse_button(Monitor *mon, const QDict *qdict)
> > >   {
> > >       static uint32_t bmap[INPUT_BUTTON__MAX] =3D {
> > >           [INPUT_BUTTON_LEFT]       =3D MOUSE_EVENT_LBUTTON,
> > > @@ -882,7 +882,7 @@ static void hmp_mouse_button(Monitor *mon, const =
QDict *qdict)
> > >       mouse_button_state =3D button_state;
> > >   }
> > > -static void hmp_ioport_read(Monitor *mon, const QDict *qdict)
> > > +void hmp_ioport_read(Monitor *mon, const QDict *qdict)
> > >   {
> > >       int size =3D qdict_get_int(qdict, "size");
> > >       int addr =3D qdict_get_int(qdict, "addr");
> > > @@ -916,7 +916,7 @@ static void hmp_ioport_read(Monitor *mon, const Q=
Dict *qdict)
> > >                      suffix, addr, size * 2, val);
> > >   }
> > > -static void hmp_ioport_write(Monitor *mon, const QDict *qdict)
> > > +void hmp_ioport_write(Monitor *mon, const QDict *qdict)
> > >   {
> > >       int size =3D qdict_get_int(qdict, "size");
> > >       int addr =3D qdict_get_int(qdict, "addr");
> > > @@ -938,7 +938,7 @@ static void hmp_ioport_write(Monitor *mon, const =
QDict *qdict)
> > >       }
> > >   }
> > > -static void hmp_boot_set(Monitor *mon, const QDict *qdict)
> > > +void hmp_boot_set(Monitor *mon, const QDict *qdict)
> > >   {
> > >       Error *local_err =3D NULL;
> > >       const char *bootdevice =3D qdict_get_str(qdict, "bootdevice");
> > > @@ -951,7 +951,7 @@ static void hmp_boot_set(Monitor *mon, const QDic=
t *qdict)
> > >       }
> > >   }
> > > -static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
> > > +void hmp_info_mtree(Monitor *mon, const QDict *qdict)
> > >   {
> > >       bool flatview =3D qdict_get_try_bool(qdict, "flatview", false);
> > >       bool dispatch_tree =3D qdict_get_try_bool(qdict, "dispatch_tree=
", false);
> > > @@ -964,7 +964,7 @@ static void hmp_info_mtree(Monitor *mon, const QD=
ict *qdict)
> > >   int64_t dev_time;
> > > -static void hmp_info_profile(Monitor *mon, const QDict *qdict)
> > > +void hmp_info_profile(Monitor *mon, const QDict *qdict)
> > >   {
> > >       static int64_t last_cpu_exec_time;
> > >       int64_t cpu_exec_time;
> > > @@ -981,7 +981,7 @@ static void hmp_info_profile(Monitor *mon, const =
QDict *qdict)
> > >       dev_time =3D 0;
> > >   }
> > >   #else
> > > -static void hmp_info_profile(Monitor *mon, const QDict *qdict)
> > > +void hmp_info_profile(Monitor *mon, const QDict *qdict)
> > >   {
> > >       monitor_printf(mon, "Internal profiler not compiled\n");
> > >   }
> > > @@ -990,7 +990,7 @@ static void hmp_info_profile(Monitor *mon, const =
QDict *qdict)
> > >   /* Capture support */
> > >   static QLIST_HEAD (capture_list_head, CaptureState) capture_head;
> > > -static void hmp_info_capture(Monitor *mon, const QDict *qdict)
> > > +void hmp_info_capture(Monitor *mon, const QDict *qdict)
> > >   {
> > >       int i;
> > >       CaptureState *s;
> > > @@ -1001,7 +1001,7 @@ static void hmp_info_capture(Monitor *mon, cons=
t QDict *qdict)
> > >       }
> > >   }
> > > -static void hmp_stopcapture(Monitor *mon, const QDict *qdict)
> > > +void hmp_stopcapture(Monitor *mon, const QDict *qdict)
> > >   {
> > >       int i;
> > >       int n =3D qdict_get_int(qdict, "n");
> > > @@ -1017,7 +1017,7 @@ static void hmp_stopcapture(Monitor *mon, const=
 QDict *qdict)
> > >       }
> > >   }
> > > -static void hmp_wavcapture(Monitor *mon, const QDict *qdict)
> > > +void hmp_wavcapture(Monitor *mon, const QDict *qdict)
> > >   {
> > >       const char *path =3D qdict_get_str(qdict, "path");
> > >       int freq =3D qdict_get_try_int(qdict, "freq", 44100);
> > > @@ -1070,7 +1070,7 @@ static void hmp_warn_acl(void)
> > >       warn_acl =3D true;
> > >   }
> > > -static void hmp_acl_show(Monitor *mon, const QDict *qdict)
> > > +void hmp_acl_show(Monitor *mon, const QDict *qdict)
> > >   {
> > >       const char *aclname =3D qdict_get_str(qdict, "aclname");
> > >       QAuthZList *auth =3D find_auth(mon, aclname);
> > > @@ -1097,7 +1097,7 @@ static void hmp_acl_show(Monitor *mon, const QD=
ict *qdict)
> > >       }
> > >   }
> > > -static void hmp_acl_reset(Monitor *mon, const QDict *qdict)
> > > +void hmp_acl_reset(Monitor *mon, const QDict *qdict)
> > >   {
> > >       const char *aclname =3D qdict_get_str(qdict, "aclname");
> > >       QAuthZList *auth =3D find_auth(mon, aclname);
> > > @@ -1114,7 +1114,7 @@ static void hmp_acl_reset(Monitor *mon, const Q=
Dict *qdict)
> > >       monitor_printf(mon, "acl: removed all rules\n");
> > >   }
> > > -static void hmp_acl_policy(Monitor *mon, const QDict *qdict)
> > > +void hmp_acl_policy(Monitor *mon, const QDict *qdict)
> > >   {
> > >       const char *aclname =3D qdict_get_str(qdict, "aclname");
> > >       const char *policy =3D qdict_get_str(qdict, "policy");
> > > @@ -1155,7 +1155,7 @@ static QAuthZListFormat hmp_acl_get_format(cons=
t char *match)
> > >       }
> > >   }
> > > -static void hmp_acl_add(Monitor *mon, const QDict *qdict)
> > > +void hmp_acl_add(Monitor *mon, const QDict *qdict)
> > >   {
> > >       const char *aclname =3D qdict_get_str(qdict, "aclname");
> > >       const char *match =3D qdict_get_str(qdict, "match");
> > > @@ -1208,7 +1208,7 @@ static void hmp_acl_add(Monitor *mon, const QDi=
ct *qdict)
> > >       }
> > >   }
> > > -static void hmp_acl_remove(Monitor *mon, const QDict *qdict)
> > > +void hmp_acl_remove(Monitor *mon, const QDict *qdict)
> > >   {
> > >       const char *aclname =3D qdict_get_str(qdict, "aclname");
> > >       const char *match =3D qdict_get_str(qdict, "match");
> > > @@ -1678,13 +1678,21 @@ int monitor_fd_param(Monitor *mon, const char=
 *fdname, Error **errp)
> > >   /* Please update hmp-commands.hx when adding or changing commands *=
/
> > >   static HMPCommand hmp_info_cmds[] =3D {
> > > +#if defined(SCSI_PROCESS)
> > > +#include "hmp-scsi-commands-info.h"
> > > +#else
> > >   #include "hmp-commands-info.h"
> > > +#endif
> > >       { NULL, NULL, },
> > >   };
> > >   /* hmp_cmds and hmp_info_cmds would be sorted at runtime */
> > >   HMPCommand hmp_cmds[] =3D {
> > > +#if defined(SCSI_PROCESS)
> > > +#include "hmp-scsi-commands.h"
> > > +#else
> > >   #include "hmp-commands.h"
> > > +#endif
> > >       { NULL, NULL, },
> > >   };
> > > diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> > > index 3e6baba..26349cb 100644
> > > --- a/monitor/monitor-internal.h
> > > +++ b/monitor/monitor-internal.h
> > > @@ -183,4 +183,42 @@ int hmp_compare_cmd(const char *name, const char=
 *list);
> > >   void qmp_query_qmp_schema(QDict *qdict, QObject **ret_data,
> > >                                    Error **errp);
> > > +void hmp_do_help_cmd(Monitor *mon, const QDict *qdict);
> > > +void hmp_trace_event(Monitor *mon, const QDict *qdict);
> > > +void hmp_info_help(Monitor *mon, const QDict *qdict);
> > > +void hmp_info_registers(Monitor *mon, const QDict *qdict);
> > > +void hmp_info_jit(Monitor *mon, const QDict *qdict);
> > > +void hmp_info_opcount(Monitor *mon, const QDict *qdict);
> > > +void hmp_info_sync_profile(Monitor *mon, const QDict *qdict);
> > > +void hmp_info_history(Monitor *mon, const QDict *qdict);
> > > +void hmp_info_cpustats(Monitor *mon, const QDict *qdict);
> > > +void hmp_info_trace_events(Monitor *mon, const QDict *qdict);
> > > +void hmp_logfile(Monitor *mon, const QDict *qdict);
> > > +void hmp_log(Monitor *mon, const QDict *qdict);
> > > +void hmp_singlestep(Monitor *mon, const QDict *qdict);
> > > +void hmp_gdbserver(Monitor *mon, const QDict *qdict);
> > > +void hmp_watchdog_action(Monitor *mon, const QDict *qdict);
> > > +void hmp_memory_dump(Monitor *mon, const QDict *qdict);
> > > +void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict);
> > > +void hmp_gpa2hva(Monitor *mon, const QDict *qdict);
> > > +void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
> > > +void hmp_gpa2hpa(Monitor *mon, const QDict *qdict);
> > > +void hmp_do_print(Monitor *mon, const QDict *qdict);
> > > +void hmp_sum(Monitor *mon, const QDict *qdict);
> > > +void hmp_mouse_move(Monitor *mon, const QDict *qdict);
> > > +void hmp_mouse_button(Monitor *mon, const QDict *qdict);
> > > +void hmp_ioport_read(Monitor *mon, const QDict *qdict);
> > > +void hmp_ioport_write(Monitor *mon, const QDict *qdict);
> > > +void hmp_boot_set(Monitor *mon, const QDict *qdict);
> > > +void hmp_info_mtree(Monitor *mon, const QDict *qdict);
> > > +void hmp_info_profile(Monitor *mon, const QDict *qdict);
> > > +void hmp_info_capture(Monitor *mon, const QDict *qdict);
> > > +void hmp_stopcapture(Monitor *mon, const QDict *qdict);
> > > +void hmp_wavcapture(Monitor *mon, const QDict *qdict);
> > > +void hmp_acl_show(Monitor *mon, const QDict *qdict);
> > > +void hmp_acl_reset(Monitor *mon, const QDict *qdict);
> > > +void hmp_acl_policy(Monitor *mon, const QDict *qdict);
> > > +void hmp_acl_add(Monitor *mon, const QDict *qdict);
> > > +void hmp_acl_remove(Monitor *mon, const QDict *qdict);
> > > +
> > >   #endif
> > > diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
> > > index 20fcc37..a8a3925 100644
> > > --- a/qapi/Makefile.objs
> > > +++ b/qapi/Makefile.objs
> > > @@ -31,3 +31,5 @@ obj-y +=3D qapi-events.o
> > >   obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-commands-%.o)
> > >   obj-y +=3D qapi-commands.o
> > >   obj-y +=3D qapi-init-commands.o
> > > +
> > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D $(QAPI_COMMON_MODULES:%=3Dqapi-=
commands-%.o)
> > > diff --git a/qom/Makefile.objs b/qom/Makefile.objs
> > > index 07e50e5..16603d7 100644
> > > --- a/qom/Makefile.objs
> > > +++ b/qom/Makefile.objs
> > > @@ -5,3 +5,4 @@ common-obj-$(CONFIG_SOFTMMU) +=3D qom-hmp-cmds.o qom-=
qmp-cmds.o
> > >   remote-pci-obj-$(CONFIG_MPQEMU) +=3D object.o qom-qobject.o contain=
er.o
> > >   remote-pci-obj-$(CONFIG_MPQEMU) +=3D object_interfaces.o
> > > +remote-pci-obj-$(CONFIG_MPQEMU) +=3D qom-qmp-cmds.o qom-hmp-cmds.o
> > > diff --git a/ui/Makefile.objs b/ui/Makefile.objs
> > > index e6da6ff..c3ac572 100644
> > > --- a/ui/Makefile.objs
> > > +++ b/ui/Makefile.objs
> > > @@ -68,3 +68,5 @@ console-gl.o-libs +=3D $(OPENGL_LIBS)
> > >   egl-helpers.o-libs +=3D $(OPENGL_LIBS)
> > >   egl-context.o-libs +=3D $(OPENGL_LIBS)
> > >   egl-headless.o-libs +=3D $(OPENGL_LIBS)
> > > +
> > > +remote-lsi-obj-$(CONFIG_MPQEMU) +=3D vnc-stubs.o
> > > --=20
> > > 1.8.3.1
> > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


