Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4E6C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CC920769
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtpcFvC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CC920769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMbM6-0007Am-8y
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 13:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jMbLF-0006GS-J4
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jMbLD-0004W8-8z
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:51:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30738
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jMbLD-0004VJ-2O
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586454709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VMYoR79YuRGJZt0/i29aSL9aPic49rJ42YBNWsqSZV8=;
 b=RtpcFvC3e8USEAdQSFtC1iVj+49YcBAFliwqCYNkVJ86wDvyxBoDqpkKH7ZvLPW3QIcH/0
 25iq1QkLdE8jWCaot1+hTiiUw0qRzWTowZRMjS0eQolzSHleDypluDLY9K8GAuFwcn5Fco
 jgXEwgAR6Z1FpxwGpID3QZq6tjs+oqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-oXCL1vkaNaWzlawbZPQlqw-1; Thu, 09 Apr 2020 13:51:44 -0400
X-MC-Unique: oXCL1vkaNaWzlawbZPQlqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6A22107BA97;
 Thu,  9 Apr 2020 17:51:42 +0000 (UTC)
Received: from work-vm (ovpn-114-117.ams2.redhat.com [10.36.114.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 417A6100164D;
 Thu,  9 Apr 2020 17:51:30 +0000 (UTC)
Date: Thu, 9 Apr 2020 18:51:27 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v6 06/36] monitor: destaticize HMP commands
Message-ID: <20200409175127.GE3065@work-vm>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
 <5b37943ea8f27258f29b1c8a5cd8a4905ae82739.1586165555.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <5b37943ea8f27258f29b1c8a5cd8a4905ae82739.1586165555.git.elena.ufimtseva@oracle.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, liran.alon@oracle.com, stefanha@redhat.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* elena.ufimtseva@oracle.com (elena.ufimtseva@oracle.com) wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>

Hmm OK, so=20

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>


but it might be better where you can, to restrict these to the ones you
want to share with your processes; for example I doubt hmp_wavcapture
would be shared.

Dave

> ---
>  hmp-commands.hx            |  4 +-
>  monitor/misc.c             | 76 +++++++++++++++++++-------------------
>  monitor/monitor-internal.h | 38 +++++++++++++++++++
>  3 files changed, 78 insertions(+), 40 deletions(-)
>=20
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 7f0f3974ad..02cae25c24 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -11,7 +11,7 @@ HXCOMM HXCOMM can be used for comments, discarded from =
both rST and C.
>          .args_type  =3D "name:S?",
>          .params     =3D "[cmd]",
>          .help       =3D "show the help",
> -        .cmd        =3D do_help_cmd,
> +        .cmd        =3D hmp_do_help_cmd,
>          .flags      =3D "p",
>      },
> =20
> @@ -555,7 +555,7 @@ ERST
>          .args_type  =3D "fmt:/,val:l",
>          .params     =3D "/fmt expr",
>          .help       =3D "print expression value (use $reg for CPU regist=
er access)",
> -        .cmd        =3D do_print,
> +        .cmd        =3D hmp_do_print,
>      },
> =20
>  SRST
> diff --git a/monitor/misc.c b/monitor/misc.c
> index 6c45fa490f..c0eee6f4ab 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -178,12 +178,12 @@ int hmp_compare_cmd(const char *name, const char *l=
ist)
>      return 0;
>  }
> =20
> -static void do_help_cmd(Monitor *mon, const QDict *qdict)
> +void hmp_do_help_cmd(Monitor *mon, const QDict *qdict)
>  {
>      help_cmd(mon, qdict_get_try_str(qdict, "name"));
>  }
> =20
> -static void hmp_trace_event(Monitor *mon, const QDict *qdict)
> +void hmp_trace_event(Monitor *mon, const QDict *qdict)
>  {
>      const char *tp_name =3D qdict_get_str(qdict, "name");
>      bool new_state =3D qdict_get_bool(qdict, "option");
> @@ -227,7 +227,7 @@ static void hmp_trace_file(Monitor *mon, const QDict =
*qdict)
>  }
>  #endif
> =20
> -static void hmp_info_help(Monitor *mon, const QDict *qdict)
> +void hmp_info_help(Monitor *mon, const QDict *qdict)
>  {
>      help_cmd(mon, "info");
>  }
> @@ -315,7 +315,7 @@ int monitor_get_cpu_index(void)
>      return cs ? cs->cpu_index : UNASSIGNED_CPU_INDEX;
>  }
> =20
> -static void hmp_info_registers(Monitor *mon, const QDict *qdict)
> +void hmp_info_registers(Monitor *mon, const QDict *qdict)
>  {
>      bool all_cpus =3D qdict_get_try_bool(qdict, "cpustate_all", false);
>      CPUState *cs;
> @@ -338,7 +338,7 @@ static void hmp_info_registers(Monitor *mon, const QD=
ict *qdict)
>  }
> =20
>  #ifdef CONFIG_TCG
> -static void hmp_info_jit(Monitor *mon, const QDict *qdict)
> +void hmp_info_jit(Monitor *mon, const QDict *qdict)
>  {
>      if (!tcg_enabled()) {
>          error_report("JIT information is only available with accel=3Dtcg=
");
> @@ -349,13 +349,13 @@ static void hmp_info_jit(Monitor *mon, const QDict =
*qdict)
>      dump_drift_info();
>  }
> =20
> -static void hmp_info_opcount(Monitor *mon, const QDict *qdict)
> +void hmp_info_opcount(Monitor *mon, const QDict *qdict)
>  {
>      dump_opcount_info();
>  }
>  #endif
> =20
> -static void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
> +void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
>  {
>      int64_t max =3D qdict_get_try_int(qdict, "max", 10);
>      bool mean =3D qdict_get_try_bool(qdict, "mean", false);
> @@ -366,7 +366,7 @@ static void hmp_info_sync_profile(Monitor *mon, const=
 QDict *qdict)
>      qsp_report(max, sort_by, coalesce);
>  }
> =20
> -static void hmp_info_history(Monitor *mon, const QDict *qdict)
> +void hmp_info_history(Monitor *mon, const QDict *qdict)
>  {
>      MonitorHMP *hmp_mon =3D container_of(mon, MonitorHMP, common);
>      int i;
> @@ -386,7 +386,7 @@ static void hmp_info_history(Monitor *mon, const QDic=
t *qdict)
>      }
>  }
> =20
> -static void hmp_info_cpustats(Monitor *mon, const QDict *qdict)
> +void hmp_info_cpustats(Monitor *mon, const QDict *qdict)
>  {
>      CPUState *cs =3D mon_get_cpu();
> =20
> @@ -397,7 +397,7 @@ static void hmp_info_cpustats(Monitor *mon, const QDi=
ct *qdict)
>      cpu_dump_statistics(cs, 0);
>  }
> =20
> -static void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
> +void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
>  {
>      const char *name =3D qdict_get_try_str(qdict, "name");
>      bool has_vcpu =3D qdict_haskey(qdict, "vcpu");
> @@ -457,7 +457,7 @@ void qmp_client_migrate_info(const char *protocol, co=
nst char *hostname,
>      error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "protocol", "spice");
>  }
> =20
> -static void hmp_logfile(Monitor *mon, const QDict *qdict)
> +void hmp_logfile(Monitor *mon, const QDict *qdict)
>  {
>      Error *err =3D NULL;
> =20
> @@ -467,7 +467,7 @@ static void hmp_logfile(Monitor *mon, const QDict *qd=
ict)
>      }
>  }
> =20
> -static void hmp_log(Monitor *mon, const QDict *qdict)
> +void hmp_log(Monitor *mon, const QDict *qdict)
>  {
>      int mask;
>      const char *items =3D qdict_get_str(qdict, "items");
> @@ -484,7 +484,7 @@ static void hmp_log(Monitor *mon, const QDict *qdict)
>      qemu_set_log(mask);
>  }
> =20
> -static void hmp_singlestep(Monitor *mon, const QDict *qdict)
> +void hmp_singlestep(Monitor *mon, const QDict *qdict)
>  {
>      const char *option =3D qdict_get_try_str(qdict, "option");
>      if (!option || !strcmp(option, "on")) {
> @@ -496,7 +496,7 @@ static void hmp_singlestep(Monitor *mon, const QDict =
*qdict)
>      }
>  }
> =20
> -static void hmp_gdbserver(Monitor *mon, const QDict *qdict)
> +void hmp_gdbserver(Monitor *mon, const QDict *qdict)
>  {
>      const char *device =3D qdict_get_try_str(qdict, "device");
>      if (!device)
> @@ -512,7 +512,7 @@ static void hmp_gdbserver(Monitor *mon, const QDict *=
qdict)
>      }
>  }
> =20
> -static void hmp_watchdog_action(Monitor *mon, const QDict *qdict)
> +void hmp_watchdog_action(Monitor *mon, const QDict *qdict)
>  {
>      const char *action =3D qdict_get_str(qdict, "action");
>      if (select_watchdog_action(action) =3D=3D -1) {
> @@ -654,7 +654,7 @@ static void memory_dump(Monitor *mon, int count, int =
format, int wsize,
>      }
>  }
> =20
> -static void hmp_memory_dump(Monitor *mon, const QDict *qdict)
> +void hmp_memory_dump(Monitor *mon, const QDict *qdict)
>  {
>      int count =3D qdict_get_int(qdict, "count");
>      int format =3D qdict_get_int(qdict, "format");
> @@ -664,7 +664,7 @@ static void hmp_memory_dump(Monitor *mon, const QDict=
 *qdict)
>      memory_dump(mon, count, format, size, addr, 0);
>  }
> =20
> -static void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
> +void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
>  {
>      int count =3D qdict_get_int(qdict, "count");
>      int format =3D qdict_get_int(qdict, "format");
> @@ -694,7 +694,7 @@ static void *gpa2hva(MemoryRegion **p_mr, hwaddr addr=
, Error **errp)
>      return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_region)=
;
>  }
> =20
> -static void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
> +void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
>  {
>      hwaddr addr =3D qdict_get_int(qdict, "addr");
>      Error *local_err =3D NULL;
> @@ -714,7 +714,7 @@ static void hmp_gpa2hva(Monitor *mon, const QDict *qd=
ict)
>      memory_region_unref(mr);
>  }
> =20
> -static void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
> +void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
>  {
>      target_ulong addr =3D qdict_get_int(qdict, "addr");
>      MemTxAttrs attrs;
> @@ -769,7 +769,7 @@ out:
>      return ret;
>  }
> =20
> -static void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
> +void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
>  {
>      hwaddr addr =3D qdict_get_int(qdict, "addr");
>      Error *local_err =3D NULL;
> @@ -796,7 +796,7 @@ static void hmp_gpa2hpa(Monitor *mon, const QDict *qd=
ict)
>  }
>  #endif
> =20
> -static void do_print(Monitor *mon, const QDict *qdict)
> +void hmp_do_print(Monitor *mon, const QDict *qdict)
>  {
>      int format =3D qdict_get_int(qdict, "format");
>      hwaddr val =3D qdict_get_int(qdict, "val");
> @@ -822,7 +822,7 @@ static void do_print(Monitor *mon, const QDict *qdict=
)
>      monitor_printf(mon, "\n");
>  }
> =20
> -static void hmp_sum(Monitor *mon, const QDict *qdict)
> +void hmp_sum(Monitor *mon, const QDict *qdict)
>  {
>      uint32_t addr;
>      uint16_t sum;
> @@ -842,7 +842,7 @@ static void hmp_sum(Monitor *mon, const QDict *qdict)
> =20
>  static int mouse_button_state;
> =20
> -static void hmp_mouse_move(Monitor *mon, const QDict *qdict)
> +void hmp_mouse_move(Monitor *mon, const QDict *qdict)
>  {
>      int dx, dy, dz, button;
>      const char *dx_str =3D qdict_get_str(qdict, "dx_str");
> @@ -866,7 +866,7 @@ static void hmp_mouse_move(Monitor *mon, const QDict =
*qdict)
>      qemu_input_event_sync();
>  }
> =20
> -static void hmp_mouse_button(Monitor *mon, const QDict *qdict)
> +void hmp_mouse_button(Monitor *mon, const QDict *qdict)
>  {
>      static uint32_t bmap[INPUT_BUTTON__MAX] =3D {
>          [INPUT_BUTTON_LEFT]       =3D MOUSE_EVENT_LBUTTON,
> @@ -883,7 +883,7 @@ static void hmp_mouse_button(Monitor *mon, const QDic=
t *qdict)
>      mouse_button_state =3D button_state;
>  }
> =20
> -static void hmp_ioport_read(Monitor *mon, const QDict *qdict)
> +void hmp_ioport_read(Monitor *mon, const QDict *qdict)
>  {
>      int size =3D qdict_get_int(qdict, "size");
>      int addr =3D qdict_get_int(qdict, "addr");
> @@ -917,7 +917,7 @@ static void hmp_ioport_read(Monitor *mon, const QDict=
 *qdict)
>                     suffix, addr, size * 2, val);
>  }
> =20
> -static void hmp_ioport_write(Monitor *mon, const QDict *qdict)
> +void hmp_ioport_write(Monitor *mon, const QDict *qdict)
>  {
>      int size =3D qdict_get_int(qdict, "size");
>      int addr =3D qdict_get_int(qdict, "addr");
> @@ -939,7 +939,7 @@ static void hmp_ioport_write(Monitor *mon, const QDic=
t *qdict)
>      }
>  }
> =20
> -static void hmp_boot_set(Monitor *mon, const QDict *qdict)
> +void hmp_boot_set(Monitor *mon, const QDict *qdict)
>  {
>      Error *local_err =3D NULL;
>      const char *bootdevice =3D qdict_get_str(qdict, "bootdevice");
> @@ -952,7 +952,7 @@ static void hmp_boot_set(Monitor *mon, const QDict *q=
dict)
>      }
>  }
> =20
> -static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
> +void hmp_info_mtree(Monitor *mon, const QDict *qdict)
>  {
>      bool flatview =3D qdict_get_try_bool(qdict, "flatview", false);
>      bool dispatch_tree =3D qdict_get_try_bool(qdict, "dispatch_tree", fa=
lse);
> @@ -965,7 +965,7 @@ static void hmp_info_mtree(Monitor *mon, const QDict =
*qdict)
> =20
>  int64_t dev_time;
> =20
> -static void hmp_info_profile(Monitor *mon, const QDict *qdict)
> +void hmp_info_profile(Monitor *mon, const QDict *qdict)
>  {
>      static int64_t last_cpu_exec_time;
>      int64_t cpu_exec_time;
> @@ -982,7 +982,7 @@ static void hmp_info_profile(Monitor *mon, const QDic=
t *qdict)
>      dev_time =3D 0;
>  }
>  #else
> -static void hmp_info_profile(Monitor *mon, const QDict *qdict)
> +void hmp_info_profile(Monitor *mon, const QDict *qdict)
>  {
>      monitor_printf(mon, "Internal profiler not compiled\n");
>  }
> @@ -991,7 +991,7 @@ static void hmp_info_profile(Monitor *mon, const QDic=
t *qdict)
>  /* Capture support */
>  static QLIST_HEAD (capture_list_head, CaptureState) capture_head;
> =20
> -static void hmp_info_capture(Monitor *mon, const QDict *qdict)
> +void hmp_info_capture(Monitor *mon, const QDict *qdict)
>  {
>      int i;
>      CaptureState *s;
> @@ -1002,7 +1002,7 @@ static void hmp_info_capture(Monitor *mon, const QD=
ict *qdict)
>      }
>  }
> =20
> -static void hmp_stopcapture(Monitor *mon, const QDict *qdict)
> +void hmp_stopcapture(Monitor *mon, const QDict *qdict)
>  {
>      int i;
>      int n =3D qdict_get_int(qdict, "n");
> @@ -1018,7 +1018,7 @@ static void hmp_stopcapture(Monitor *mon, const QDi=
ct *qdict)
>      }
>  }
> =20
> -static void hmp_wavcapture(Monitor *mon, const QDict *qdict)
> +void hmp_wavcapture(Monitor *mon, const QDict *qdict)
>  {
>      const char *path =3D qdict_get_str(qdict, "path");
>      int freq =3D qdict_get_try_int(qdict, "freq", 44100);
> @@ -1071,7 +1071,7 @@ static void hmp_warn_acl(void)
>      warn_acl =3D true;
>  }
> =20
> -static void hmp_acl_show(Monitor *mon, const QDict *qdict)
> +void hmp_acl_show(Monitor *mon, const QDict *qdict)
>  {
>      const char *aclname =3D qdict_get_str(qdict, "aclname");
>      QAuthZList *auth =3D find_auth(mon, aclname);
> @@ -1098,7 +1098,7 @@ static void hmp_acl_show(Monitor *mon, const QDict =
*qdict)
>      }
>  }
> =20
> -static void hmp_acl_reset(Monitor *mon, const QDict *qdict)
> +void hmp_acl_reset(Monitor *mon, const QDict *qdict)
>  {
>      const char *aclname =3D qdict_get_str(qdict, "aclname");
>      QAuthZList *auth =3D find_auth(mon, aclname);
> @@ -1115,7 +1115,7 @@ static void hmp_acl_reset(Monitor *mon, const QDict=
 *qdict)
>      monitor_printf(mon, "acl: removed all rules\n");
>  }
> =20
> -static void hmp_acl_policy(Monitor *mon, const QDict *qdict)
> +void hmp_acl_policy(Monitor *mon, const QDict *qdict)
>  {
>      const char *aclname =3D qdict_get_str(qdict, "aclname");
>      const char *policy =3D qdict_get_str(qdict, "policy");
> @@ -1156,7 +1156,7 @@ static QAuthZListFormat hmp_acl_get_format(const ch=
ar *match)
>      }
>  }
> =20
> -static void hmp_acl_add(Monitor *mon, const QDict *qdict)
> +void hmp_acl_add(Monitor *mon, const QDict *qdict)
>  {
>      const char *aclname =3D qdict_get_str(qdict, "aclname");
>      const char *match =3D qdict_get_str(qdict, "match");
> @@ -1209,7 +1209,7 @@ static void hmp_acl_add(Monitor *mon, const QDict *=
qdict)
>      }
>  }
> =20
> -static void hmp_acl_remove(Monitor *mon, const QDict *qdict)
> +void hmp_acl_remove(Monitor *mon, const QDict *qdict)
>  {
>      const char *aclname =3D qdict_get_str(qdict, "aclname");
>      const char *match =3D qdict_get_str(qdict, "match");
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index 8f60ccc70a..bc8c9fa16b 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -183,4 +183,42 @@ int hmp_compare_cmd(const char *name, const char *li=
st);
>  void qmp_query_qmp_schema(QDict *qdict, QObject **ret_data,
>                                   Error **errp);
> =20
> +void hmp_do_help_cmd(Monitor *mon, const QDict *qdict);
> +void hmp_trace_event(Monitor *mon, const QDict *qdict);
> +void hmp_info_help(Monitor *mon, const QDict *qdict);
> +void hmp_info_registers(Monitor *mon, const QDict *qdict);
> +void hmp_info_jit(Monitor *mon, const QDict *qdict);
> +void hmp_info_opcount(Monitor *mon, const QDict *qdict);
> +void hmp_info_sync_profile(Monitor *mon, const QDict *qdict);
> +void hmp_info_history(Monitor *mon, const QDict *qdict);
> +void hmp_info_cpustats(Monitor *mon, const QDict *qdict);
> +void hmp_info_trace_events(Monitor *mon, const QDict *qdict);
> +void hmp_logfile(Monitor *mon, const QDict *qdict);
> +void hmp_log(Monitor *mon, const QDict *qdict);
> +void hmp_singlestep(Monitor *mon, const QDict *qdict);
> +void hmp_gdbserver(Monitor *mon, const QDict *qdict);
> +void hmp_watchdog_action(Monitor *mon, const QDict *qdict);
> +void hmp_memory_dump(Monitor *mon, const QDict *qdict);
> +void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict);
> +void hmp_gpa2hva(Monitor *mon, const QDict *qdict);
> +void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
> +void hmp_gpa2hpa(Monitor *mon, const QDict *qdict);
> +void hmp_do_print(Monitor *mon, const QDict *qdict);
> +void hmp_sum(Monitor *mon, const QDict *qdict);
> +void hmp_mouse_move(Monitor *mon, const QDict *qdict);
> +void hmp_mouse_button(Monitor *mon, const QDict *qdict);
> +void hmp_ioport_read(Monitor *mon, const QDict *qdict);
> +void hmp_ioport_write(Monitor *mon, const QDict *qdict);
> +void hmp_boot_set(Monitor *mon, const QDict *qdict);
> +void hmp_info_mtree(Monitor *mon, const QDict *qdict);
> +void hmp_info_profile(Monitor *mon, const QDict *qdict);
> +void hmp_info_capture(Monitor *mon, const QDict *qdict);
> +void hmp_stopcapture(Monitor *mon, const QDict *qdict);
> +void hmp_wavcapture(Monitor *mon, const QDict *qdict);
> +void hmp_acl_show(Monitor *mon, const QDict *qdict);
> +void hmp_acl_reset(Monitor *mon, const QDict *qdict);
> +void hmp_acl_policy(Monitor *mon, const QDict *qdict);
> +void hmp_acl_add(Monitor *mon, const QDict *qdict);
> +void hmp_acl_remove(Monitor *mon, const QDict *qdict);
> +
>  #endif
> --=20
> 2.25.GIT
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


