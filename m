Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D0BC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65711208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBZ3HspG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65711208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIF4h-00049m-Dy
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kIEq6-0001PG-K5
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:33:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54346
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kIEq4-0005CC-Jd
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600191234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XENmoH7C8V+9rCfXTMLkLk3REHs8UyGiv5+1qy8dkFg=;
 b=iBZ3HspGRWrhpGeIBPCFB5EUk0vPiESPwA4x7AMFmV5ww3yRoyRIzO0Naf/4vrxJ1hzYtq
 DfUDmrjZJuQjxVnTbWNCQvwwzRaR2HqqXIAzQ5EaER9Xde2SMQq645ta1N+HgtzKyyptia
 txANpHOl9Ae4QXN8SxG6H/+TBb1LTTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-xtUhON8dM9itwNkADnHLEQ-1; Tue, 15 Sep 2020 13:33:52 -0400
X-MC-Unique: xtUhON8dM9itwNkADnHLEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 710C7191E2A2;
 Tue, 15 Sep 2020 17:33:51 +0000 (UTC)
Received: from work-vm (ovpn-115-25.ams2.redhat.com [10.36.115.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DC7F60BE5;
 Tue, 15 Sep 2020 17:33:37 +0000 (UTC)
Date: Tue, 15 Sep 2020 18:33:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 22/32] char: qio_channel_socket_accept reuse fd
Message-ID: <20200915173334.GD2922@work-vm>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-23-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1596122076-341293-23-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:11:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Steve Sistare (steven.sistare@oracle.com) wrote:
> From: Mark Kanda <mark.kanda@oracle.com>
> 
> Add an fd argument to qio_channel_socket_accept.  If not -1, the channel
> uses that fd instead of accepting a new socket connection.  All callers
> pass -1 in this patch, so no functional change.

Doesn't some of this just come from the fact you're insisting on reusing
the command line?   We should be able to open a chardev on an fd
shouldn't we?

Dave

> Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/io/channel-socket.h    |  3 ++-
>  io/channel-socket.c            | 12 +++++++++---
>  io/net-listener.c              |  4 ++--
>  scsi/qemu-pr-helper.c          |  2 +-
>  tests/qtest/tpm-emu.c          |  2 +-
>  tests/test-char.c              |  2 +-
>  tests/test-io-channel-socket.c |  4 ++--
>  7 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
> index 777ff59..0ffc560 100644
> --- a/include/io/channel-socket.h
> +++ b/include/io/channel-socket.h
> @@ -248,6 +248,7 @@ qio_channel_socket_get_remote_address(QIOChannelSocket *ioc,
>  /**
>   * qio_channel_socket_accept:
>   * @ioc: the socket channel object
> + * @reuse_fd: fd to reuse; -1 otherwise
>   * @errp: pointer to a NULL-initialized error object
>   *
>   * If the socket represents a server, then this accepts
> @@ -258,7 +259,7 @@ qio_channel_socket_get_remote_address(QIOChannelSocket *ioc,
>   */
>  QIOChannelSocket *
>  qio_channel_socket_accept(QIOChannelSocket *ioc,
> -                          Error **errp);
> +                          int reuse_fd, Error **errp);
>  
>  
>  #endif /* QIO_CHANNEL_SOCKET_H */
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index e1b4667..dde12bf 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -352,7 +352,7 @@ void qio_channel_socket_dgram_async(QIOChannelSocket *ioc,
>  
>  QIOChannelSocket *
>  qio_channel_socket_accept(QIOChannelSocket *ioc,
> -                          Error **errp)
> +                          int reuse_fd, Error **errp)
>  {
>      QIOChannelSocket *cioc;
>  
> @@ -362,8 +362,14 @@ qio_channel_socket_accept(QIOChannelSocket *ioc,
>  
>   retry:
>      trace_qio_channel_socket_accept(ioc);
> -    cioc->fd = qemu_accept(ioc->fd, (struct sockaddr *)&cioc->remoteAddr,
> -                           &cioc->remoteAddrLen);
> +
> +    if (reuse_fd != -1) {
> +        cioc->fd = reuse_fd;
> +    } else {
> +        cioc->fd = qemu_accept(ioc->fd, (struct sockaddr *)&cioc->remoteAddr,
> +                               &cioc->remoteAddrLen);
> +    }
> +
>      if (cioc->fd < 0) {
>          if (errno == EINTR) {
>              goto retry;
> diff --git a/io/net-listener.c b/io/net-listener.c
> index 5d8a226..bbdea1e 100644
> --- a/io/net-listener.c
> +++ b/io/net-listener.c
> @@ -45,7 +45,7 @@ static gboolean qio_net_listener_channel_func(QIOChannel *ioc,
>      QIOChannelSocket *sioc;
>  
>      sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
> -                                     NULL);
> +                                     -1, NULL);
>      if (!sioc) {
>          return TRUE;
>      }
> @@ -194,7 +194,7 @@ static gboolean qio_net_listener_wait_client_func(QIOChannel *ioc,
>      QIOChannelSocket *sioc;
>  
>      sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
> -                                     NULL);
> +                                     -1, NULL);
>      if (!sioc) {
>          return TRUE;
>      }
> diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
> index 57ad830..0e6d683 100644
> --- a/scsi/qemu-pr-helper.c
> +++ b/scsi/qemu-pr-helper.c
> @@ -800,7 +800,7 @@ static gboolean accept_client(QIOChannel *ioc, GIOCondition cond, gpointer opaqu
>      PRHelperClient *prh;
>  
>      cioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
> -                                     NULL);
> +                                     -1, NULL);
>      if (!cioc) {
>          return TRUE;
>      }
> diff --git a/tests/qtest/tpm-emu.c b/tests/qtest/tpm-emu.c
> index 2e8eb7b..19e5dab 100644
> --- a/tests/qtest/tpm-emu.c
> +++ b/tests/qtest/tpm-emu.c
> @@ -83,7 +83,7 @@ void *tpm_emu_ctrl_thread(void *data)
>      g_cond_signal(&s->data_cond);
>  
>      qio_channel_wait(QIO_CHANNEL(lioc), G_IO_IN);
> -    ioc = QIO_CHANNEL(qio_channel_socket_accept(lioc, &error_abort));
> +    ioc = QIO_CHANNEL(qio_channel_socket_accept(lioc, -1, &error_abort));
>      g_assert(ioc);
>  
>      {
> diff --git a/tests/test-char.c b/tests/test-char.c
> index 614bdac..1bb6ae0 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -884,7 +884,7 @@ char_socket_client_server_thread(gpointer data)
>      QIOChannelSocket *cioc;
>  
>  retry:
> -    cioc = qio_channel_socket_accept(ioc, &error_abort);
> +    cioc = qio_channel_socket_accept(ioc, -1, &error_abort);
>      g_assert_nonnull(cioc);
>  
>      if (char_socket_ping_pong(QIO_CHANNEL(cioc), NULL) != 0) {
> diff --git a/tests/test-io-channel-socket.c b/tests/test-io-channel-socket.c
> index d43083a..0d410cf 100644
> --- a/tests/test-io-channel-socket.c
> +++ b/tests/test-io-channel-socket.c
> @@ -75,7 +75,7 @@ static void test_io_channel_setup_sync(SocketAddress *listen_addr,
>      qio_channel_set_delay(*src, false);
>  
>      qio_channel_wait(QIO_CHANNEL(lioc), G_IO_IN);
> -    *dst = QIO_CHANNEL(qio_channel_socket_accept(lioc, &error_abort));
> +    *dst = QIO_CHANNEL(qio_channel_socket_accept(lioc, -1, &error_abort));
>      g_assert(*dst);
>  
>      test_io_channel_set_socket_bufs(*src, *dst);
> @@ -143,7 +143,7 @@ static void test_io_channel_setup_async(SocketAddress *listen_addr,
>      g_assert(!data.err);
>  
>      qio_channel_wait(QIO_CHANNEL(lioc), G_IO_IN);
> -    *dst = QIO_CHANNEL(qio_channel_socket_accept(lioc, &error_abort));
> +    *dst = QIO_CHANNEL(qio_channel_socket_accept(lioc, -1, &error_abort));
>      g_assert(*dst);
>  
>      qio_channel_set_delay(*src, false);
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


