Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0304C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:45:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9BF206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2Fr3Y/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9BF206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5nKP-0007hA-PR
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 05:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k5nIR-0003kf-KF
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:43:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33101
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k5nIO-0006py-1E
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597225422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WKLO7yyv5ntdbIaBRtMGcZmUc3SBFtDHhXuYVBS0KzI=;
 b=i2Fr3Y/sKr9WqKewmYEvBsUJKHd5zI5BtxqwT37A7xc/IAI136BiBFJvhMZMBpYbKfV19H
 X/8pG6tIr+OC/jFHntdgBh3X6ArIGEfDi/KLncgAQyUZgTUYr0iuisfmcLHAloix5zc66o
 lHHyeH1PS8QSdi7V+q9h7/bag4EyxW0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-LUMCcGi-PbacDzQWuO_z_A-1; Wed, 12 Aug 2020 05:43:40 -0400
X-MC-Unique: LUMCcGi-PbacDzQWuO_z_A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EEA31005E6B;
 Wed, 12 Aug 2020 09:43:39 +0000 (UTC)
Received: from work-vm (ovpn-113-233.ams2.redhat.com [10.36.113.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C5F860BF3;
 Wed, 12 Aug 2020 09:43:37 +0000 (UTC)
Date: Wed, 12 Aug 2020 10:43:35 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: Re: [PATCH 1/2] migration: unify the framework of socket-type channel
Message-ID: <20200812094335.GA2810@work-vm>
References: <20200806074030.174-1-longpeng2@huawei.com>
 <20200806074030.174-2-longpeng2@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200806074030.174-2-longpeng2@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 04:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Longpeng(Mike) (longpeng2@huawei.com) wrote:
> Currently, the only difference of tcp channel and unix channel in
> migration/socket.c is the way to build SocketAddress, but socket_parse()
> can handle these two types, so use it to instead of tcp_build_address()
> and unix_build_address().
> 
> The socket-type channel can be further unified based on the up, this
> would be helpful for us to add other socket-type channels.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>

Nice; this saves a chunk of code.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c | 18 ++++++-------
>  migration/socket.c    | 72 +++++++++++----------------------------------------
>  migration/socket.h    | 11 +++-----
>  3 files changed, 26 insertions(+), 75 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 8fe3633..3160b95 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -377,21 +377,20 @@ void migrate_add_address(SocketAddress *address)
>  
>  void qemu_start_incoming_migration(const char *uri, Error **errp)
>  {
> -    const char *p;
> +    const char *p = NULL;
>  
>      qapi_event_send_migration(MIGRATION_STATUS_SETUP);
>      if (!strcmp(uri, "defer")) {
>          deferred_incoming_migration(errp);
> -    } else if (strstart(uri, "tcp:", &p)) {
> -        tcp_start_incoming_migration(p, errp);
> +    } else if (strstart(uri, "tcp:", &p) ||
> +               strstart(uri, "unix:", NULL)) {
> +        socket_start_incoming_migration(p ? p : uri, errp);
>  #ifdef CONFIG_RDMA
>      } else if (strstart(uri, "rdma:", &p)) {
>          rdma_start_incoming_migration(p, errp);
>  #endif
>      } else if (strstart(uri, "exec:", &p)) {
>          exec_start_incoming_migration(p, errp);
> -    } else if (strstart(uri, "unix:", &p)) {
> -        unix_start_incoming_migration(p, errp);
>      } else if (strstart(uri, "fd:", &p)) {
>          fd_start_incoming_migration(p, errp);
>      } else {
> @@ -2064,7 +2063,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>  {
>      Error *local_err = NULL;
>      MigrationState *s = migrate_get_current();
> -    const char *p;
> +    const char *p = NULL;
>  
>      if (!migrate_prepare(s, has_blk && blk, has_inc && inc,
>                           has_resume && resume, errp)) {
> @@ -2072,16 +2071,15 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>          return;
>      }
>  
> -    if (strstart(uri, "tcp:", &p)) {
> -        tcp_start_outgoing_migration(s, p, &local_err);
> +    if (strstart(uri, "tcp:", &p) ||
> +        strstart(uri, "unix:", NULL)) {
> +        socket_start_outgoing_migration(s, p ? p : uri, &local_err);
>  #ifdef CONFIG_RDMA
>      } else if (strstart(uri, "rdma:", &p)) {
>          rdma_start_outgoing_migration(s, p, &local_err);
>  #endif
>      } else if (strstart(uri, "exec:", &p)) {
>          exec_start_outgoing_migration(s, p, &local_err);
> -    } else if (strstart(uri, "unix:", &p)) {
> -        unix_start_outgoing_migration(s, p, &local_err);
>      } else if (strstart(uri, "fd:", &p)) {
>          fd_start_outgoing_migration(s, p, &local_err);
>      } else {
> diff --git a/migration/socket.c b/migration/socket.c
> index 97c9efd..6016642 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -50,34 +50,6 @@ int socket_send_channel_destroy(QIOChannel *send)
>      return 0;
>  }
>  
> -static SocketAddress *tcp_build_address(const char *host_port, Error **errp)
> -{
> -    SocketAddress *saddr;
> -
> -    saddr = g_new0(SocketAddress, 1);
> -    saddr->type = SOCKET_ADDRESS_TYPE_INET;
> -
> -    if (inet_parse(&saddr->u.inet, host_port, errp)) {
> -        qapi_free_SocketAddress(saddr);
> -        return NULL;
> -    }
> -
> -    return saddr;
> -}
> -
> -
> -static SocketAddress *unix_build_address(const char *path)
> -{
> -    SocketAddress *saddr;
> -
> -    saddr = g_new0(SocketAddress, 1);
> -    saddr->type = SOCKET_ADDRESS_TYPE_UNIX;
> -    saddr->u.q_unix.path = g_strdup(path);
> -
> -    return saddr;
> -}
> -
> -
>  struct SocketConnectData {
>      MigrationState *s;
>      char *hostname;
> @@ -109,9 +81,10 @@ static void socket_outgoing_migration(QIOTask *task,
>      object_unref(OBJECT(sioc));
>  }
>  
> -static void socket_start_outgoing_migration(MigrationState *s,
> -                                            SocketAddress *saddr,
> -                                            Error **errp)
> +static void
> +socket_start_outgoing_migration_internal(MigrationState *s,
> +                                         SocketAddress *saddr,
> +                                         Error **errp)
>  {
>      QIOChannelSocket *sioc = qio_channel_socket_new();
>      struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
> @@ -135,27 +108,18 @@ static void socket_start_outgoing_migration(MigrationState *s,
>                                       NULL);
>  }
>  
> -void tcp_start_outgoing_migration(MigrationState *s,
> -                                  const char *host_port,
> -                                  Error **errp)
> +void socket_start_outgoing_migration(MigrationState *s,
> +                                     const char *str,
> +                                     Error **errp)
>  {
>      Error *err = NULL;
> -    SocketAddress *saddr = tcp_build_address(host_port, &err);
> +    SocketAddress *saddr = socket_parse(str, &err);
>      if (!err) {
> -        socket_start_outgoing_migration(s, saddr, &err);
> +        socket_start_outgoing_migration_internal(s, saddr, &err);
>      }
>      error_propagate(errp, err);
>  }
>  
> -void unix_start_outgoing_migration(MigrationState *s,
> -                                   const char *path,
> -                                   Error **errp)
> -{
> -    SocketAddress *saddr = unix_build_address(path);
> -    socket_start_outgoing_migration(s, saddr, errp);
> -}
> -
> -
>  static void socket_accept_incoming_migration(QIONetListener *listener,
>                                               QIOChannelSocket *cioc,
>                                               gpointer opaque)
> @@ -173,8 +137,9 @@ static void socket_accept_incoming_migration(QIONetListener *listener,
>  }
>  
>  
> -static void socket_start_incoming_migration(SocketAddress *saddr,
> -                                            Error **errp)
> +static void
> +socket_start_incoming_migration_internal(SocketAddress *saddr,
> +                                         Error **errp)
>  {
>      QIONetListener *listener = qio_net_listener_new();
>      size_t i;
> @@ -207,20 +172,13 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
>      }
>  }
>  
> -void tcp_start_incoming_migration(const char *host_port, Error **errp)
> +void socket_start_incoming_migration(const char *str, Error **errp)
>  {
>      Error *err = NULL;
> -    SocketAddress *saddr = tcp_build_address(host_port, &err);
> +    SocketAddress *saddr = socket_parse(str, &err);
>      if (!err) {
> -        socket_start_incoming_migration(saddr, &err);
> +        socket_start_incoming_migration_internal(saddr, &err);
>      }
>      qapi_free_SocketAddress(saddr);
>      error_propagate(errp, err);
>  }
> -
> -void unix_start_incoming_migration(const char *path, Error **errp)
> -{
> -    SocketAddress *saddr = unix_build_address(path);
> -    socket_start_incoming_migration(saddr, errp);
> -    qapi_free_SocketAddress(saddr);
> -}
> diff --git a/migration/socket.h b/migration/socket.h
> index 528c3b0..891dbcc 100644
> --- a/migration/socket.h
> +++ b/migration/socket.h
> @@ -23,13 +23,8 @@
>  void socket_send_channel_create(QIOTaskFunc f, void *data);
>  int socket_send_channel_destroy(QIOChannel *send);
>  
> -void tcp_start_incoming_migration(const char *host_port, Error **errp);
> +void socket_start_incoming_migration(const char *str, Error **errp);
>  
> -void tcp_start_outgoing_migration(MigrationState *s, const char *host_port,
> -                                  Error **errp);
> -
> -void unix_start_incoming_migration(const char *path, Error **errp);
> -
> -void unix_start_outgoing_migration(MigrationState *s, const char *path,
> -                                   Error **errp);
> +void socket_start_outgoing_migration(MigrationState *s, const char *str,
> +                                     Error **errp);
>  #endif
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


