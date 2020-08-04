Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C61C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 12:47:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A2E2067D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 12:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5DjJzcN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A2E2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2wLk-0001QV-BB
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 08:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2wL3-0000ws-Ln
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 08:46:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24241
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2wKx-0000Ll-6C
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 08:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596545193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vo8Ff+Khu04kYxtRm4zRiFYS8Sg4mAjOT71PvAH1qrA=;
 b=X5DjJzcNnoCGv190NOlFtkZ/hKzK75kQdSE7LEOPsFM79i4ODkj9gXim+KusAuC3vccqap
 mh7dt2bcKDtZLMgaeSJBdDdfVEKmOwx4e3yCrJNmDwTSDMl0KSDSTPUi8wM8AKDGbD5Itt
 zmfiN0h5RxlTnU9UTfpTxujlyx3YvH8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-O9Ez6QPoNmGQMZolNcYKMA-1; Tue, 04 Aug 2020 08:46:31 -0400
X-MC-Unique: O9Ez6QPoNmGQMZolNcYKMA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D302F106B24C;
 Tue,  4 Aug 2020 12:46:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BEFBC88F37;
 Tue,  4 Aug 2020 12:46:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 520D51141D60; Tue,  4 Aug 2020 14:46:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v6 02/12] monitor: Use getter/setter functions for cur_mon
References: <20200528153742.274164-1-kwolf@redhat.com>
 <20200528153742.274164-3-kwolf@redhat.com>
Date: Tue, 04 Aug 2020 14:46:28 +0200
In-Reply-To: <20200528153742.274164-3-kwolf@redhat.com> (Kevin Wolf's message
 of "Thu, 28 May 2020 17:37:32 +0200")
Message-ID: <87lfiubmu3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> cur_mon really needs to be coroutine-local as soon as we move monitor
> command handlers to coroutines and let them yield. As a first step, just
> remove all direct accesses to cur_mon so that we can implement this in
> the getter function later.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/monitor/monitor.h  |  3 ++-
>  audio/wavcapture.c         |  8 ++++----
>  dump/dump.c                |  2 +-
>  hw/scsi/vhost-scsi.c       |  2 +-
>  hw/virtio/vhost-vsock.c    |  2 +-
>  migration/fd.c             |  4 ++--
>  monitor/hmp.c              | 10 +++++-----
>  monitor/misc.c             | 14 +++++++++-----
>  monitor/monitor.c          | 15 ++++++++++++++-
>  monitor/qmp-cmds-control.c |  2 ++
>  monitor/qmp-cmds.c         |  2 +-
>  monitor/qmp.c              |  6 +++---
>  net/socket.c               |  2 +-
>  net/tap.c                  |  6 +++---
>  stubs/monitor-core.c       |  5 ++++-
>  tests/test-util-sockets.c  | 22 +++++++++++-----------
>  trace/control.c            |  2 +-
>  util/qemu-error.c          |  4 ++--
>  util/qemu-print.c          |  3 ++-
>  util/qemu-sockets.c        |  1 +
>  20 files changed, 70 insertions(+), 45 deletions(-)
>
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 0dcaefd4f9..43cc746078 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -5,7 +5,6 @@
>  #include "qapi/qapi-types-misc.h"
>  #include "qemu/readline.h"
>  
> -extern __thread Monitor *cur_mon;
>  typedef struct MonitorHMP MonitorHMP;
>  typedef struct MonitorOptions MonitorOptions;
>  
> @@ -13,6 +12,8 @@ typedef struct MonitorOptions MonitorOptions;
>  
>  extern QemuOptsList qemu_mon_opts;
>  
> +Monitor *monitor_cur(void);
> +void monitor_set_cur(Monitor *mon);
>  bool monitor_cur_is_qmp(void);
>  
>  void monitor_init_globals(void);
> diff --git a/audio/wavcapture.c b/audio/wavcapture.c
> index 8d7ce2eda1..e7dc97d16e 100644
> --- a/audio/wavcapture.c
> +++ b/audio/wavcapture.c
> @@ -1,5 +1,5 @@
>  #include "qemu/osdep.h"
> -#include "monitor/monitor.h"
> +#include "qemu/qemu-print.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "audio.h"
> @@ -94,9 +94,9 @@ static void wav_capture_info (void *opaque)
>      WAVState *wav = opaque;
>      char *path = wav->path;
>  
> -    monitor_printf (cur_mon, "Capturing audio(%d,%d,%d) to %s: %d bytes\n",
> -                    wav->freq, wav->bits, wav->nchannels,
> -                    path ? path : "<not available>", wav->bytes);
> +    qemu_printf("Capturing audio(%d,%d,%d) to %s: %d bytes\n",
> +                wav->freq, wav->bits, wav->nchannels,
> +                path ? path : "<not available>", wav->bytes);
>  }
>  

A bit more than purely mechanical transformation.  Fine with me.

>  static struct capture_ops wav_capture_ops = {
> diff --git a/dump/dump.c b/dump/dump.c
> index 248ea06370..36d26159a0 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -1989,7 +1989,7 @@ void qmp_dump_guest_memory(bool paging, const char *file,
>  
>  #if !defined(WIN32)
>      if (strstart(file, "fd:", &p)) {
> -        fd = monitor_get_fd(cur_mon, p, errp);
> +        fd = monitor_get_fd(monitor_cur(), p, errp);

All callers pass cur_mon.  Perhaps we'd be better off without the
parameter.  Observation, not demand.

>          if (fd == -1) {
>              return;
>          }
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index c1b012aea4..3920825bd6 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -177,7 +177,7 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
>      }
>  
>      if (vs->conf.vhostfd) {
> -        vhostfd = monitor_fd_param(cur_mon, vs->conf.vhostfd, errp);
> +        vhostfd = monitor_fd_param(monitor_cur(), vs->conf.vhostfd, errp);

Likewise.

>          if (vhostfd == -1) {
>              error_prepend(errp, "vhost-scsi: unable to parse vhostfd: ");
>              return;
> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
> index 4a228f5168..e72c9005b4 100644
> --- a/hw/virtio/vhost-vsock.c
> +++ b/hw/virtio/vhost-vsock.c
> @@ -317,7 +317,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>      }
>  
>      if (vsock->conf.vhostfd) {
> -        vhostfd = monitor_fd_param(cur_mon, vsock->conf.vhostfd, errp);
> +        vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
>          if (vhostfd == -1) {
>              error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
>              return;
> diff --git a/migration/fd.c b/migration/fd.c
> index 0a29ecdebf..6f2f50475f 100644
> --- a/migration/fd.c
> +++ b/migration/fd.c
> @@ -26,7 +26,7 @@
>  void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **errp)
>  {
>      QIOChannel *ioc;
> -    int fd = monitor_get_fd(cur_mon, fdname, errp);
> +    int fd = monitor_get_fd(monitor_cur(), fdname, errp);
>      if (fd == -1) {
>          return;
>      }
> @@ -55,7 +55,7 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
>  void fd_start_incoming_migration(const char *fdname, Error **errp)
>  {
>      QIOChannel *ioc;
> -    int fd = monitor_fd_param(cur_mon, fdname, errp);
> +    int fd = monitor_fd_param(monitor_cur(), fdname, errp);
>      if (fd == -1) {
>          return;
>      }
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index d598dd02bb..f609fcf75b 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -1301,11 +1301,11 @@ cleanup:
>  static void monitor_read(void *opaque, const uint8_t *buf, int size)
>  {
>      MonitorHMP *mon;
> -    Monitor *old_mon = cur_mon;
> +    Monitor *old_mon = monitor_cur();
>      int i;
>  
> -    cur_mon = opaque;
> -    mon = container_of(cur_mon, MonitorHMP, common);
> +    monitor_set_cur(opaque);
> +    mon = container_of(monitor_cur(), MonitorHMP, common);

Simpler:

       MonitorHMP *mon = container_of(opaque, MonitorHMP, common);

>  
>      if (mon->rs) {
>          for (i = 0; i < size; i++) {
> @@ -1313,13 +1313,13 @@ static void monitor_read(void *opaque, const uint8_t *buf, int size)
>          }
>      } else {
>          if (size == 0 || buf[size - 1] != 0) {
> -            monitor_printf(cur_mon, "corrupted command\n");
> +            monitor_printf(&mon->common, "corrupted command\n");
>          } else {
>              handle_hmp_command(mon, (char *)buf);
>          }
>      }
>  
> -    cur_mon = old_mon;
> +    monitor_set_cur(old_mon);
>  }
>  
>  static void monitor_event(void *opaque, QEMUChrEvent event)
> diff --git a/monitor/misc.c b/monitor/misc.c
> index bdf49e49e5..6cf7f60872 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -126,13 +126,13 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
>  
>      monitor_data_init(&hmp.common, false, true, false);
>  
> -    old_mon = cur_mon;
> -    cur_mon = &hmp.common;
> +    old_mon = monitor_cur();
> +    monitor_set_cur(&hmp.common);
>  
>      if (has_cpu_index) {
>          int ret = monitor_set_cpu(&hmp.common, cpu_index);
>          if (ret < 0) {
> -            cur_mon = old_mon;
> +            monitor_set_cur(old_mon);
>              error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
>                         "a CPU number");
>              goto out;
> @@ -140,7 +140,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
>      }
>  
>      handle_hmp_command(&hmp, command_line);
> -    cur_mon = old_mon;
> +    monitor_set_cur(old_mon);
>  
>      qemu_mutex_lock(&hmp.common.mon_lock);
>      if (qstring_get_length(hmp.common.outbuf) > 0) {
> @@ -258,6 +258,7 @@ static void monitor_init_qmp_commands(void)
>  /* Set the current CPU defined by the user. Callers must hold BQL. */
>  int monitor_set_cpu(Monitor *mon, int cpu_index)
>  {
> +    Monitor *cur_mon = monitor_cur();
>      CPUState *cpu;
>  
>      cpu = qemu_get_cpu(cpu_index);

As Eric observed, this hunk adds dead code.

> @@ -272,6 +273,7 @@ int monitor_set_cpu(Monitor *mon, int cpu_index)
>  /* Callers must hold BQL. */
>  static CPUState *mon_get_cpu_sync(bool synchronize)
>  {
> +    Monitor *cur_mon = monitor_cur();
>      CPUState *cpu = NULL;
>  
>      if (cur_mon->mon_cpu_path) {
> @@ -1232,6 +1234,7 @@ static void hmp_acl_remove(Monitor *mon, const QDict *qdict)
>  
>  void qmp_getfd(const char *fdname, Error **errp)
>  {
> +    Monitor *cur_mon = monitor_cur();
>      mon_fd_t *monfd;
>      int fd, tmp_fd;
>  
> @@ -1272,6 +1275,7 @@ void qmp_getfd(const char *fdname, Error **errp)
>  
>  void qmp_closefd(const char *fdname, Error **errp)
>  {
> +    Monitor *cur_mon = monitor_cur();
>      mon_fd_t *monfd;
>      int tmp_fd;
>  
> @@ -1361,7 +1365,7 @@ AddfdInfo *qmp_add_fd(bool has_fdset_id, int64_t fdset_id, bool has_opaque,
>                        const char *opaque, Error **errp)
>  {
>      int fd;
> -    Monitor *mon = cur_mon;
> +    Monitor *mon = monitor_cur();
>      AddfdInfo *fdinfo;
>  
>      fd = qemu_chr_fe_get_msgfd(&mon->chr);
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 125494410a..182ba136b4 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -66,13 +66,24 @@ MonitorList mon_list;
>  int mon_refcount;
>  static bool monitor_destroyed;
>  
> -__thread Monitor *cur_mon;
> +static __thread Monitor *cur_monitor;
> +
> +Monitor *monitor_cur(void)
> +{
> +    return cur_monitor;
> +}
> +
> +void monitor_set_cur(Monitor *mon)
> +{
> +    cur_monitor = mon;
> +}

All uses of monitor_set_cur() look like this:

    old_mon = monitor_cur();
    monitor_set_cur(new_mon);
    ...
    monitor_set_cur(old_mon);

If we let monitor_set_cur() return the old value, this becomes

    old_mon = monitor_set_cur(new_mon);
    ...
    monitor_set_cur(old_mon);

I like this better.

>  
>  /**
>   * Is the current monitor, if any, a QMP monitor?
>   */
>  bool monitor_cur_is_qmp(void)
>  {
> +    Monitor *cur_mon = monitor_cur();

Blank line between declarations and statements, please.  More of the
same below.

>      return cur_mon && monitor_is_qmp(cur_mon);
>  }
>  
> @@ -209,6 +220,7 @@ int monitor_printf(Monitor *mon, const char *fmt, ...)
>   */
>  int error_vprintf(const char *fmt, va_list ap)
>  {
> +    Monitor *cur_mon = monitor_cur();
>      if (cur_mon && !monitor_cur_is_qmp()) {
>          return monitor_vprintf(cur_mon, fmt, ap);
>      }
> @@ -217,6 +229,7 @@ int error_vprintf(const char *fmt, va_list ap)
>  
>  int error_vprintf_unless_qmp(const char *fmt, va_list ap)
>  {
> +    Monitor *cur_mon = monitor_cur();
>      if (!cur_mon) {
>          return vfprintf(stderr, fmt, ap);
>      }
> diff --git a/monitor/qmp-cmds-control.c b/monitor/qmp-cmds-control.c
> index 8f04cfa6e6..a456762f6a 100644
> --- a/monitor/qmp-cmds-control.c
> +++ b/monitor/qmp-cmds-control.c
> @@ -69,6 +69,7 @@ static bool qmp_caps_accept(MonitorQMP *mon, QMPCapabilityList *list,
>  void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
>                            Error **errp)
>  {
> +    Monitor *cur_mon = monitor_cur();
>      MonitorQMP *mon;
>  
>      assert(monitor_is_qmp(cur_mon));
> @@ -119,6 +120,7 @@ static void query_commands_cb(const QmpCommand *cmd, void *opaque)
>  CommandInfoList *qmp_query_commands(Error **errp)
>  {
>      CommandInfoList *list = NULL;
> +    Monitor *cur_mon = monitor_cur();
>      MonitorQMP *mon;
>  
>      assert(monitor_is_qmp(cur_mon));
> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> index 864cbfa32e..c7bf6bb4dc 100644
> --- a/monitor/qmp-cmds.c
> +++ b/monitor/qmp-cmds.c
> @@ -327,7 +327,7 @@ void qmp_add_client(const char *protocol, const char *fdname,
>      Chardev *s;
>      int fd;
>  
> -    fd = monitor_get_fd(cur_mon, fdname, errp);
> +    fd = monitor_get_fd(monitor_cur(), fdname, errp);
>      if (fd < 0) {
>          return;
>      }
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index d433ceae5b..5e9abd4711 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -139,12 +139,12 @@ static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
>      QDict *rsp;
>      QDict *error;
>  
> -    old_mon = cur_mon;
> -    cur_mon = &mon->common;
> +    old_mon = monitor_cur();
> +    monitor_set_cur(&mon->common);
>  
>      rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon));
>  
> -    cur_mon = old_mon;
> +    monitor_set_cur(old_mon);
>  
>      if (mon->commands == &qmp_cap_negotiation_commands) {
>          error = qdict_get_qdict(rsp, "error");
> diff --git a/net/socket.c b/net/socket.c
> index c92354049b..93bee968a8 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -727,7 +727,7 @@ int net_init_socket(const Netdev *netdev, const char *name,
>      if (sock->has_fd) {
>          int fd;
>  
> -        fd = monitor_fd_param(cur_mon, sock->fd, errp);
> +        fd = monitor_fd_param(monitor_cur(), sock->fd, errp);
>          if (fd == -1) {
>              return -1;
>          }
> diff --git a/net/tap.c b/net/tap.c
> index 6207f61f84..fd7d15936d 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -689,7 +689,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
>          }
>  
>          if (vhostfdname) {
> -            vhostfd = monitor_fd_param(cur_mon, vhostfdname, &err);
> +            vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, &err);
>              if (vhostfd == -1) {
>                  if (tap->has_vhostforce && tap->vhostforce) {
>                      error_propagate(errp, err);
> @@ -789,7 +789,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
>              return -1;
>          }
>  
> -        fd = monitor_fd_param(cur_mon, tap->fd, &err);
> +        fd = monitor_fd_param(monitor_cur(), tap->fd, &err);
>          if (fd == -1) {
>              error_propagate(errp, err);
>              return -1;
> @@ -836,7 +836,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
>          }
>  
>          for (i = 0; i < nfds; i++) {
> -            fd = monitor_fd_param(cur_mon, fds[i], &err);
> +            fd = monitor_fd_param(monitor_cur(), fds[i], &err);
>              if (fd == -1) {
>                  error_propagate(errp, err);
>                  ret = -1;
> diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
> index 6cff1c4e1d..0cd2d864b2 100644
> --- a/stubs/monitor-core.c
> +++ b/stubs/monitor-core.c
> @@ -3,7 +3,10 @@
>  #include "qemu-common.h"
>  #include "qapi/qapi-emit-events.h"
>  
> -__thread Monitor *cur_mon;
> +Monitor *monitor_cur(void)
> +{
> +    return NULL;
> +}

Is this meant to be called?  If not, abort().

>  
>  void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
>  {
> diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
> index 2ca1e99f17..36fabb5e46 100644
> --- a/tests/test-util-sockets.c
> +++ b/tests/test-util-sockets.c
> @@ -53,27 +53,27 @@ static void test_fd_is_socket_good(void)
>  static int mon_fd = -1;
>  static const char *mon_fdname;
>  
> -int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
> -{
> -    g_assert(cur_mon);
> -    g_assert(mon == cur_mon);
> -    if (mon_fd == -1 || !g_str_equal(mon_fdname, fdname)) {
> -        error_setg(errp, "No fd named %s", fdname);
> -        return -1;
> -    }
> -    return dup(mon_fd);
> -}
> -
>  /* Syms in libqemustub.a are discarded at .o file granularity.
>   * To replace monitor_get_fd() we must ensure everything in
>   * stubs/monitor.c is defined, to make sure monitor.o is discarded
>   * otherwise we get duplicate syms at link time.
>   */
>  __thread Monitor *cur_mon;

Hmm.  Since monitor.o's @cur_mon now has internal linkage, the comment
doesn't apply to @cur_mon anymore.  Easy to fix: move the variable
before the comment.  Bonus: you don't have to move monitor_get_fd()
then.

Hmm^2, the comment is stale:

* "libqemustub.a"

  Gone since Commit ebedb37c8d "Makefile: Remove libqemustub.a".  Almost
  three years.  git-grep finds three more occurences, all bogus.

* "stubs/monitor.c"

  Commit 6ede81d576 "stubs: Update monitor stubs for
  qemu-storage-daemon" moved stuff from stubs/monitor.c to
  monitor-core.c.

* "we must ensure everything in stubs/monitor.c is defined"

  We don't.

Mind to clean that up beforehand?

> +Monitor *monitor_cur(void) { return cur_mon; }

Is this meant to be called?  If not, abort().

>  int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); }
>  void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp) {}
>  void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp) {}
>  
> +int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
> +{
> +    g_assert(cur_mon);
> +    g_assert(mon == cur_mon);
> +    if (mon_fd == -1 || !g_str_equal(mon_fdname, fdname)) {
> +        error_setg(errp, "No fd named %s", fdname);
> +        return -1;
> +    }
> +    return dup(mon_fd);
> +}
>  
>  static void test_socket_fd_pass_name_good(void)
>  {
> diff --git a/trace/control.c b/trace/control.c
> index 2ffe000818..62993daf64 100644
> --- a/trace/control.c
> +++ b/trace/control.c
> @@ -176,7 +176,7 @@ void trace_enable_events(const char *line_buf)
>  {
>      if (is_help_option(line_buf)) {
>          trace_list_events();
> -        if (cur_mon == NULL) {
> +        if (monitor_cur() == NULL) {
>              exit(0);
>          }
>      } else {
> diff --git a/util/qemu-error.c b/util/qemu-error.c
> index dac7c7dc50..8d4ed723f5 100644
> --- a/util/qemu-error.c
> +++ b/util/qemu-error.c
> @@ -169,7 +169,7 @@ static void print_loc(void)
>      int i;
>      const char *const *argp;
>  
> -    if (!cur_mon && progname) {
> +    if (!monitor_cur() && progname) {
>          fprintf(stderr, "%s:", progname);
>          sep = " ";
>      }
> @@ -206,7 +206,7 @@ static void vreport(report_type type, const char *fmt, va_list ap)
>      GTimeVal tv;
>      gchar *timestr;
>  
> -    if (error_with_timestamp && !cur_mon) {
> +    if (error_with_timestamp && !monitor_cur()) {
>          g_get_current_time(&tv);
>          timestr = g_time_val_to_iso8601(&tv);
>          error_printf("%s ", timestr);
> diff --git a/util/qemu-print.c b/util/qemu-print.c
> index e79d6b8396..69ba612f56 100644
> --- a/util/qemu-print.c
> +++ b/util/qemu-print.c
> @@ -20,6 +20,7 @@
>   */
>  int qemu_vprintf(const char *fmt, va_list ap)
>  {
> +    Monitor *cur_mon = monitor_cur();
>      if (cur_mon) {
>          return monitor_vprintf(cur_mon, fmt, ap);
>      }
> @@ -48,7 +49,7 @@ int qemu_printf(const char *fmt, ...)
>  int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
>  {
>      if (!stream) {
> -        return monitor_vprintf(cur_mon, fmt, ap);
> +        return monitor_vprintf(monitor_cur(), fmt, ap);
>      }
>      return vfprintf(stream, fmt, ap);
>  }
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index b37d288866..40c18ba142 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -1092,6 +1092,7 @@ fail:
>  
>  static int socket_get_fd(const char *fdstr, int num, Error **errp)
>  {
> +    Monitor *cur_mon = monitor_cur();
>      int fd;
>      if (num != 1) {
>          error_setg_errno(errp, EINVAL, "socket_get_fd: too many connections");


