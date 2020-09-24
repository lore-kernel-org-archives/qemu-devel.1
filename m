Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE0FC4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8046A20BED
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgNRYnPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8046A20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNOv-0005HV-EQ
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLNO8-0004ki-QH
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:18:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49685)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLNO6-0005Oo-O9
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=teWFRFZq1sKgPVKZpQvIPG5rxRH86raA1pvW+a/jw6Q=;
 b=HgNRYnPYMlguCB7Ukm9pDI6wZANRoIwAE5AYdy3COqaePk7qqNUqksaH2F8rjL5XSX8HVo
 7n1Yp9vwaBZQy4o9g6BVQ+z+LAqivbK/McZvTtwUMm29DXkk/Fzw9maTcoDfyjtQ5aPyTP
 M6eyC6SarYfFpzeJGufi4+v7MHQ2XjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-UsC9bQa2OW6HSsFCHRkp6Q-1; Thu, 24 Sep 2020 05:17:59 -0400
X-MC-Unique: UsC9bQa2OW6HSsFCHRkp6Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1C18802EA4
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:17:58 +0000 (UTC)
Received: from work-vm (ovpn-114-250.ams2.redhat.com [10.36.114.250])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 250E55576C;
 Thu, 24 Sep 2020 09:17:57 +0000 (UTC)
Date: Thu, 24 Sep 2020 10:17:55 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, armbru@redhat.com
Subject: Re: [PATCH v2] monitor: Use LOCK_GUARD macros
Message-ID: <20200924091755.GB4980@work-vm>
References: <20200922095741.101911-1-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922095741.101911-1-dgilbert@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Use the lock guard macros in monitor/misc.c - saves
> a lot of unlocks in error paths, and the occasional goto.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Queued

> --
> v2:
>   The file changed quite a bit since my original posting, so reworked.
> 
> ---
>  monitor/misc.c | 44 ++++++++++++++------------------------------
>  1 file changed, 14 insertions(+), 30 deletions(-)
> 
> diff --git a/monitor/misc.c b/monitor/misc.c
> index 0b1b9b196c..9df917f464 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -141,13 +141,13 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
>      handle_hmp_command(&hmp, command_line);
>      cur_mon = old_mon;
>  
> -    qemu_mutex_lock(&hmp.common.mon_lock);
> -    if (qstring_get_length(hmp.common.outbuf) > 0) {
> -        output = g_strdup(qstring_get_str(hmp.common.outbuf));
> -    } else {
> -        output = g_strdup("");
> +    WITH_QEMU_LOCK_GUARD(&hmp.common.mon_lock) {
> +        if (qstring_get_length(hmp.common.outbuf) > 0) {
> +            output = g_strdup(qstring_get_str(hmp.common.outbuf));
> +        } else {
> +            output = g_strdup("");
> +        }
>      }
> -    qemu_mutex_unlock(&hmp.common.mon_lock);
>  
>  out:
>      monitor_data_destroy(&hmp.common);
> @@ -1248,7 +1248,7 @@ void qmp_getfd(const char *fdname, Error **errp)
>          return;
>      }
>  
> -    qemu_mutex_lock(&cur_mon->mon_lock);
> +    QEMU_LOCK_GUARD(&cur_mon->mon_lock);
>      QLIST_FOREACH(monfd, &cur_mon->fds, next) {
>          if (strcmp(monfd->name, fdname) != 0) {
>              continue;
> @@ -1256,7 +1256,6 @@ void qmp_getfd(const char *fdname, Error **errp)
>  
>          tmp_fd = monfd->fd;
>          monfd->fd = fd;
> -        qemu_mutex_unlock(&cur_mon->mon_lock);
>          /* Make sure close() is outside critical section */
>          close(tmp_fd);
>          return;
> @@ -1267,7 +1266,6 @@ void qmp_getfd(const char *fdname, Error **errp)
>      monfd->fd = fd;
>  
>      QLIST_INSERT_HEAD(&cur_mon->fds, monfd, next);
> -    qemu_mutex_unlock(&cur_mon->mon_lock);
>  }
>  
>  void qmp_closefd(const char *fdname, Error **errp)
> @@ -1299,7 +1297,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
>  {
>      mon_fd_t *monfd;
>  
> -    qemu_mutex_lock(&mon->mon_lock);
> +    QEMU_LOCK_GUARD(&mon->mon_lock);
>      QLIST_FOREACH(monfd, &mon->fds, next) {
>          int fd;
>  
> @@ -1313,12 +1311,10 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
>          QLIST_REMOVE(monfd, next);
>          g_free(monfd->name);
>          g_free(monfd);
> -        qemu_mutex_unlock(&mon->mon_lock);
>  
>          return fd;
>      }
>  
> -    qemu_mutex_unlock(&mon->mon_lock);
>      error_setg(errp, "File descriptor named '%s' has not been found", fdname);
>      return -1;
>  }
> @@ -1350,11 +1346,10 @@ void monitor_fdsets_cleanup(void)
>      MonFdset *mon_fdset;
>      MonFdset *mon_fdset_next;
>  
> -    qemu_mutex_lock(&mon_fdsets_lock);
> +    QEMU_LOCK_GUARD(&mon_fdsets_lock);
>      QLIST_FOREACH_SAFE(mon_fdset, &mon_fdsets, next, mon_fdset_next) {
>          monitor_fdset_cleanup(mon_fdset);
>      }
> -    qemu_mutex_unlock(&mon_fdsets_lock);
>  }
>  
>  AddfdInfo *qmp_add_fd(bool has_fdset_id, int64_t fdset_id, bool has_opaque,
> @@ -1389,7 +1384,7 @@ void qmp_remove_fd(int64_t fdset_id, bool has_fd, int64_t fd, Error **errp)
>      MonFdsetFd *mon_fdset_fd;
>      char fd_str[60];
>  
> -    qemu_mutex_lock(&mon_fdsets_lock);
> +    QEMU_LOCK_GUARD(&mon_fdsets_lock);
>      QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
>          if (mon_fdset->id != fdset_id) {
>              continue;
> @@ -1409,12 +1404,10 @@ void qmp_remove_fd(int64_t fdset_id, bool has_fd, int64_t fd, Error **errp)
>              goto error;
>          }
>          monitor_fdset_cleanup(mon_fdset);
> -        qemu_mutex_unlock(&mon_fdsets_lock);
>          return;
>      }
>  
>  error:
> -    qemu_mutex_unlock(&mon_fdsets_lock);
>      if (has_fd) {
>          snprintf(fd_str, sizeof(fd_str), "fdset-id:%" PRId64 ", fd:%" PRId64,
>                   fdset_id, fd);
> @@ -1430,7 +1423,7 @@ FdsetInfoList *qmp_query_fdsets(Error **errp)
>      MonFdsetFd *mon_fdset_fd;
>      FdsetInfoList *fdset_list = NULL;
>  
> -    qemu_mutex_lock(&mon_fdsets_lock);
> +    QEMU_LOCK_GUARD(&mon_fdsets_lock);
>      QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
>          FdsetInfoList *fdset_info = g_malloc0(sizeof(*fdset_info));
>          FdsetFdInfoList *fdsetfd_list = NULL;
> @@ -1460,7 +1453,6 @@ FdsetInfoList *qmp_query_fdsets(Error **errp)
>          fdset_info->next = fdset_list;
>          fdset_list = fdset_info;
>      }
> -    qemu_mutex_unlock(&mon_fdsets_lock);
>  
>      return fdset_list;
>  }
> @@ -1554,7 +1546,7 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
>  #else
>      MonFdset *mon_fdset;
>  
> -    qemu_mutex_lock(&mon_fdsets_lock);
> +    QEMU_LOCK_GUARD(&mon_fdsets_lock);
>      QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
>          MonFdsetFd *mon_fdset_fd;
>          MonFdsetFd *mon_fdset_fd_dup;
> @@ -1569,7 +1561,6 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
>          QLIST_FOREACH(mon_fdset_fd, &mon_fdset->fds, next) {
>              mon_fd_flags = fcntl(mon_fdset_fd->fd, F_GETFL);
>              if (mon_fd_flags == -1) {
> -                qemu_mutex_unlock(&mon_fdsets_lock);
>                  return -1;
>              }
>  
> @@ -1580,25 +1571,21 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
>          }
>  
>          if (fd == -1) {
> -            qemu_mutex_unlock(&mon_fdsets_lock);
>              errno = EACCES;
>              return -1;
>          }
>  
>          dup_fd = qemu_dup_flags(fd, flags);
>          if (dup_fd == -1) {
> -            qemu_mutex_unlock(&mon_fdsets_lock);
>              return -1;
>          }
>  
>          mon_fdset_fd_dup = g_malloc0(sizeof(*mon_fdset_fd_dup));
>          mon_fdset_fd_dup->fd = dup_fd;
>          QLIST_INSERT_HEAD(&mon_fdset->dup_fds, mon_fdset_fd_dup, next);
> -        qemu_mutex_unlock(&mon_fdsets_lock);
>          return dup_fd;
>      }
>  
> -    qemu_mutex_unlock(&mon_fdsets_lock);
>      errno = ENOENT;
>      return -1;
>  #endif
> @@ -1609,7 +1596,7 @@ static int64_t monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
>      MonFdset *mon_fdset;
>      MonFdsetFd *mon_fdset_fd_dup;
>  
> -    qemu_mutex_lock(&mon_fdsets_lock);
> +    QEMU_LOCK_GUARD(&mon_fdsets_lock);
>      QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
>          QLIST_FOREACH(mon_fdset_fd_dup, &mon_fdset->dup_fds, next) {
>              if (mon_fdset_fd_dup->fd == dup_fd) {
> @@ -1619,17 +1606,14 @@ static int64_t monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
>                      if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
>                          monitor_fdset_cleanup(mon_fdset);
>                      }
> -                    goto err;
> +                    return -1;
>                  } else {
> -                    qemu_mutex_unlock(&mon_fdsets_lock);
>                      return mon_fdset->id;
>                  }
>              }
>          }
>      }
>  
> -err:
> -    qemu_mutex_unlock(&mon_fdsets_lock);
>      return -1;
>  }
>  
> -- 
> 2.26.2
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


