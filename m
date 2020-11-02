Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BE2C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 20:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143CA21D40
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 20:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YI4RH9/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143CA21D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZgHo-0006ob-3O
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 15:18:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kZgGF-0005n4-6i
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 15:17:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kZgG2-0004uU-Tq
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 15:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604348208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V2u4Se/AePjUrzkMtOjhbgoG6aSzI/AkNBThGPNllkc=;
 b=YI4RH9/u/d/X7iEOIp2GPPQn3KqJ022w46yD8yWgDY0/Z5PLxsRDxSMsCDR/KRU9An2xWt
 TiDUna9kij8Di9ROsi86V3XLeF8CcqsoFXb5pOOleW9U68+cVZy0ycCk+J8bHBD045LXPl
 IoTpfn5kQ6HAWylNT0FkuD5D20d1y5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-5I9skXYbPMaHKjhqpnamBw-1; Mon, 02 Nov 2020 15:16:44 -0500
X-MC-Unique: 5I9skXYbPMaHKjhqpnamBw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CD0E9CC06;
 Mon,  2 Nov 2020 20:16:43 +0000 (UTC)
Received: from work-vm (ovpn-114-142.ams2.redhat.com [10.36.114.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 940EE62A14;
 Mon,  2 Nov 2020 20:16:41 +0000 (UTC)
Date: Mon, 2 Nov 2020 20:16:38 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: zhengchuan <zhengchuan@huawei.com>
Subject: Re: [Bug 1902470] Re: migration with TLS-MultiFD is stuck when the
 dst-libvirtd service restarts
Message-ID: <20201102201638.GD4845@work-vm>
References: <160428587851.31102.18083040677647005532.malonedeb@gac.canonical.com>
 <160428671322.29935.9362121267692908178.launchpad@gac.canonical.com>
 <0E8924944E28FD4A97A19E5A680D8A823F68F68C@DGGEML521-MBX.china.huawei.com>
MIME-Version: 1.0
In-Reply-To: <0E8924944E28FD4A97A19E5A680D8A823F68F68C@DGGEML521-MBX.china.huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: "Chenzhendong \(alex\)" <alex.chen@huawei.com>,
 Bug 1902470 <1902470@bugs.launchpad.net>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, jinyan <jinyan12@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* zhengchuan (zhengchuan@huawei.com) wrote:
> Anyone who could help this would be appreciated since we have stuck for three days:(
> 
> IIUC, the client (Src) has sent first hello message to sever(Dst), however due to something happened while restarted libvirtd,
> The messages is lost, and both of them are waiting which leading to hang forever, but I could find out how for now.

If you need to un-break things, I suggest killing the destination might
free it; but I'm not sure.

An interesting question is if we can make migration-cancel work in this
case.

Dave

> -----Original Message-----
> From: Qemu-devel [mailto:qemu-devel-bounces+zhengchuan=huawei.com@nongnu.org] On Behalf Of Yan Jin
> Sent: 2020年11月2日 11:12
> To: qemu-devel@nongnu.org
> Subject: [Bug 1902470] Re: migration with TLS-MultiFD is stuck when the dst-libvirtd service restarts
> 
> ** Description changed:
> 
>   hi,
>   
>   I found that the multi-channel TLS-handshake will be stuck when the dst-
>   libvirtd restarts, both the src and dst sockets are blocked in recvmsg.
>   In the meantime, live_migration thread is blocked in
>   multifd_send_sync_main, so migration cannot be cancelled though src-
>   libvirt has delivered the QMP command.
>   
>   Is there any way to exit migration when the multi-channel TLS-handshake
> - is stuck? Does setting TLS handshake timeout function take effect?
> + is stuck? Does setting TLS-handshake timeout function take effect?
>   
>   The stack trace are as follows:
>   
>   =====src qemu-system-aar stack=====:
>   #0  0x0000ffff87d6f28c in recvmsg () from target:/usr/lib64/libpthread.so.0
>   #1  0x0000aaaae3817424 in qio_channel_socket_readv (ioc=0xaaaae9e30a30, iov=0xffffdb58e8a8, niov=1, fds=0x0, nfds=0x0, errp=0x0) at ../io/channel-socket.c:502
>   #2  0x0000aaaae380f468 in qio_channel_readv_full (ioc=0xaaaae9e30a30, iov=0xffffdb58e8a8, niov=1, fds=0x0, nfds=0x0, errp=0x0) at ../io/channel.c:66
>   #3  0x0000aaaae380f9e8 in qio_channel_read (ioc=0xaaaae9e30a30, buf=0xaaaaea204e9b "\026\003\001\001L\001", buflen=5, errp=0x0) at ../io/channel.c:217
>   #4  0x0000aaaae380e7d4 in qio_channel_tls_read_handler (buf=0xaaaaea204e9b "\026\003\001\001L\001", len=5, opaque=0xfffd38001190) at ../io/channel-tls.c:53
>   #5  0x0000aaaae3801114 in qcrypto_tls_session_pull (opaque=0xaaaae99d5700, buf=0xaaaaea204e9b, len=5) at ../crypto/tlssession.c:89
>   #6  0x0000ffff8822ed30 in _gnutls_stream_read (ms=0xffffdb58eaac, pull_func=0xfffd38001870, size=5, bufel=<synthetic pointer>, session=0xaaaae983cd60) at buffers.c:346
>   #7  _gnutls_read (ms=0xffffdb58eaac, pull_func=0xfffd38001870, size=5, bufel=<synthetic pointer>, session=0xaaaae983cd60) at buffers.c:426
>   #8  _gnutls_io_read_buffered (session=session@entry=0xaaaae983cd60, total=5, recv_type=recv_type@entry=4294967295, ms=0xffffdb58eaac) at buffers.c:581
>   #9  0x0000ffff88224954 in recv_headers (ms=<optimized out>, record=0xffff883cd000 <gnutls_x509_ext_export_name_constraints@got.plt>, htype=65535, type=2284006288, record_params=0xaaaae9e22a60, session=0xaaaae983cd60) at record.c:1163
>   #10 _gnutls_recv_in_buffers (session=session@entry=0xaaaae983cd60, type=2284006288, type@entry=GNUTLS_HANDSHAKE, htype=65535, htype@entry=GNUTLS_HANDSHAKE_HELLO_RETRY_REQUEST, ms=<optimized out>, ms@entry=0) at record.c:1302
>   #11 0x0000ffff88230568 in _gnutls_handshake_io_recv_int (session=session@entry=0xaaaae983cd60, htype=htype@entry=GNUTLS_HANDSHAKE_HELLO_RETRY_REQUEST, hsk=hsk@entry=0xffffdb58ec38, optional=optional@entry=1) at buffers.c:1445
>   #12 0x0000ffff88232b90 in _gnutls_recv_handshake (session=session@entry=0xaaaae983cd60, type=type@entry=GNUTLS_HANDSHAKE_HELLO_RETRY_REQUEST, optional=optional@entry=1, buf=buf@entry=0x0) at handshake.c:1534
>   #13 0x0000ffff88235b40 in handshake_client (session=session@entry=0xaaaae983cd60) at handshake.c:2925
>   #14 0x0000ffff88237824 in gnutls_handshake (session=0xaaaae983cd60) at handshake.c:2739
>   #15 0x0000aaaae380213c in qcrypto_tls_session_handshake (session=0xaaaae99d5700, errp=0xffffdb58ee58) at ../crypto/tlssession.c:493
>   #16 0x0000aaaae380ea40 in qio_channel_tls_handshake_task (ioc=0xfffd38001190, task=0xaaaaea61d4e0, context=0x0) at ../io/channel-tls.c:161
>   #17 0x0000aaaae380ec60 in qio_channel_tls_handshake (ioc=0xfffd38001190, func=0xaaaae3394d20 <multifd_tls_outgoing_handshake>, opaque=0xaaaaea189c30, destroy=0x0, context=0x0) at ../io/channel-tls.c:239
>   #18 0x0000aaaae3394e78 in multifd_tls_channel_connect (p=0xaaaaea189c30, ioc=0xaaaae9e30a30, errp=0xffffdb58ef28) at ../migration/multifd.c:782
>   #19 0x0000aaaae3394f30 in multifd_channel_connect (p=0xaaaaea189c30, ioc=0xaaaae9e30a30, error=0x0) at ../migration/multifd.c:804
>   #20 0x0000aaaae33950b8 in multifd_new_send_channel_async (task=0xaaaaea6855a0, opaque=0xaaaaea189c30) at ../migration/multifd.c:858
>   #21 0x0000aaaae3810cf8 in qio_task_complete (task=0xaaaaea6855a0) at ../io/task.c:197
>   #22 0x0000aaaae381096c in qio_task_thread_result (opaque=0xaaaaea6855a0) at ../io/task.c:112
>   #23 0x0000ffff88701df8 in ?? () from target:/usr/lib64/libglib-2.0.so.0
>   #24 0x0000ffff88705a7c in g_main_context_dispatch () from target:/usr/lib64/libglib-2.0.so.0
>   #25 0x0000aaaae3a5a29c in glib_pollfds_poll () at ../util/main-loop.c:221
>   #26 0x0000aaaae3a5a324 in os_host_main_loop_wait (timeout=0) at ../util/main-loop.c:244
>   #27 0x0000aaaae3a5a444 in main_loop_wait (nonblocking=0) at ../util/main-loop.c:520
>   #28 0x0000aaaae3696b20 in qemu_main_loop () at ../softmmu/vl.c:1677
>   #29 0x0000aaaae30949e4 in main (argc=81, argv=0xffffdb58f2c8, envp=0xffffdb58f558) at ../softmmu/main.c:50
>   
>   =====src live_migration stack=====:
>   #0  0x0000ffff87d6a5d8 in pthread_cond_wait () from target:/usr/lib64/libpthread.so.0
>   #1  0x0000aaaae3a5f3ec in qemu_sem_wait (sem=0xaaaaea189d40) at ../util/qemu-thread-posix.c:328
>   #2  0x0000aaaae3394838 in multifd_send_sync_main (f=0xaaaae983f0e0) at ../migration/multifd.c:638
>   #3  0x0000aaaae37de310 in ram_save_setup (f=0xaaaae983f0e0, opaque=0xaaaae4198708 <ram_state>) at ../migration/ram.c:2588
>   #4  0x0000aaaae31cf7ac in qemu_savevm_state_setup (f=0xaaaae983f0e0) at ../migration/savevm.c:1176
>   #5  0x0000aaaae3248360 in migration_thread (opaque=0xaaaae9829f20) at ../migration/migration.c:3521
>   #6  0x0000aaaae3a5f8fc in qemu_thread_start (args=0xaaaaea513ee0) at ../util/qemu-thread-posix.c:521
>   #7  0x0000ffff87d647ac in ?? () from target:/usr/lib64/libpthread.so.0
>   #8  0x0000ffff87cba6ec in ?? () from target:/usr/lib64/libc.so.6
>   
>   =====dst qemu-system-aar stack=====:
>   #0  0x0000ffff7f17d28c in recvmsg () from target:/usr/lib64/libpthread.so.0
>   #1  0x0000aaaae263a424 in qio_channel_socket_readv (ioc=0xaaaaf998a800, iov=0xfffff5d22f78, niov=1, fds=0x0, nfds=0x0, errp=0x0) at ../io/channel-socket.c:502
>   #2  0x0000aaaae2632468 in qio_channel_readv_full (ioc=0xaaaaf998a800, iov=0xfffff5d22f78, niov=1, fds=0x0, nfds=0x0, errp=0x0) at ../io/channel.c:66
>   #3  0x0000aaaae26329e8 in qio_channel_read (ioc=0xaaaaf998a800, buf=0xaaaafa926dbb "q\024\335\365ȣ'\221,\\\357\246w\253\242ѠصI\247(N(K=\256\316DH\227QNf\371\"\271\017\226^\223\026\373\245z\255\227\025R.\244\205\254\002\031T\033\312:h\226\aݔ\204Ԫ\324\351K\341\365\247\032\354+\277\005O'*l\301cXx\340~?\346\b\324k\225\223D\276\252\376\257_0\036\223\022\006\212D|7h\257\226\300&n','\005zL\203M͆\023\213\237(o\272\025_\305s\372\362\351\002\367Ph\016\347\371E\n\030Y\340\002\r\362^&`\021\203}\353\324A\340ҳ(\207]\300l}h\026\037H\372\n=\"C\024\t\200\325\334&=\333>\212ƏE\214]_\372\264]"..., buflen=5, errp=0x0) at ../io/channel.c:217
>   #4  0x0000aaaae26317d4 in qio_channel_tls_read_handler (buf=0xaaaafa926dbb "q\024\335\365ȣ'\221,\\\357\246w\253\242ѠصI\247(N(K=\256\316DH\227QNf\371\"\271\017\226^\223\026\373\245z\255\227\025R.\244\205\254\002\031T\033\312:h\226\aݔ\204Ԫ\324\351K\341\365\247\032\354+\277\005O'*l\301cXx\340~?\346\b\324k\225\223D\276\252\376\257_0\036\223\022\006\212D|7h\257\226\300&n','\005zL\203M͆\023\213\237(o\272\025_\305s\372\362\351\002\367Ph\016\347\371E\n\030Y\340\002\r\362^&`\021\203}\353\324A\340ҳ(\207]\300l}h\026\037H\372\n=\"C\024\t\200\325\334&=\333>\212ƏE\214]_\372\264]"..., len=5, opaque=0xaaaaf9c4c400) at ../io/channel-tls.c:53
>   #5  0x0000aaaae2624114 in qcrypto_tls_session_pull (opaque=0xaaaafa4a3d90, buf=0xaaaafa926dbb, len=5) at ../crypto/tlssession.c:89
>   #6  0x0000ffff7f63cd30 in _gnutls_stream_read (ms=0xfffff5d2317c, pull_func=0xaaaafa81a380, size=5, bufel=<synthetic pointer>, session=0xaaaafa58b9d0) at buffers.c:346
>   #7  _gnutls_read (ms=0xfffff5d2317c, pull_func=0xaaaafa81a380, size=5, bufel=<synthetic pointer>, session=0xaaaafa58b9d0) at buffers.c:426
>   #8  _gnutls_io_read_buffered (session=session@entry=0xaaaafa58b9d0, total=5, recv_type=recv_type@entry=4294967295, ms=0xfffff5d2317c) at buffers.c:581
>   #9  0x0000ffff7f632954 in recv_headers (ms=<optimized out>, record=0x1ee2a9fa78, htype=65535, type=2137262992, record_params=0xaaaafa4b71a0, session=0xaaaafa58b9d0) at record.c:1163
>   #10 _gnutls_recv_in_buffers (session=session@entry=0xaaaafa58b9d0, type=2137262992, type@entry=GNUTLS_HANDSHAKE, htype=65535, htype@entry=GNUTLS_HANDSHAKE_CLIENT_HELLO, ms=<optimized out>, ms@entry=0) at record.c:1302
>   #11 0x0000ffff7f63e568 in _gnutls_handshake_io_recv_int (session=session@entry=0xaaaafa58b9d0, htype=htype@entry=GNUTLS_HANDSHAKE_CLIENT_HELLO, hsk=hsk@entry=0xfffff5d23308, optional=optional@entry=0) at buffers.c:1445
>   #12 0x0000ffff7f640b90 in _gnutls_recv_handshake (session=session@entry=0xaaaafa58b9d0, type=type@entry=GNUTLS_HANDSHAKE_CLIENT_HELLO, optional=optional@entry=0, buf=buf@entry=0x0) at handshake.c:1534
>   #13 0x0000ffff7f645f18 in handshake_server (session=<optimized out>) at handshake.c:3351
>   #14 gnutls_handshake (session=0xaaaafa58b9d0) at handshake.c:2742
>   #15 0x0000aaaae262513c in qcrypto_tls_session_handshake (session=0xaaaafa4a3d90, errp=0xfffff5d23478) at ../crypto/tlssession.c:493
>   #16 0x0000aaaae2631a40 in qio_channel_tls_handshake_task (ioc=0xaaaaf9c4c400, task=0xaaaafa70e600, context=0x0) at ../io/channel-tls.c:161
>   #17 0x0000aaaae2631c60 in qio_channel_tls_handshake (ioc=0xaaaaf9c4c400, func=0xaaaae20d4b58 <migration_tls_incoming_handshake>, opaque=0x0, destroy=0x0, context=0x0) at ../io/channel-tls.c:239
>   #18 0x0000aaaae20d4ca8 in migration_tls_channel_process_incoming (s=0xaaaaf9b2ef20, ioc=0xaaaaf998a800, errp=0xfffff5d23548) at ../migration/tls.c:103
>   #19 0x0000aaaae20f9f7c in migration_channel_process_incoming (ioc=0xaaaaf998a800) at ../migration/channel.c:42
>   #20 0x0000aaaae1f484a8 in socket_accept_incoming_migration (listener=0xffff64007a40, cioc=0xaaaaf998a800, opaque=0x0) at ../migration/socket.c:130
>   #21 0x0000aaaae2638570 in qio_net_listener_channel_func (ioc=0xaaaafa410600, condition=G_IO_IN, opaque=0xffff64007a40) at ../io/net-listener.c:54
>   #22 0x0000aaaae263ac4c in qio_channel_fd_source_dispatch (source=0xaaaafa81a380, callback=0xaaaae26384f8 <qio_net_listener_channel_func>, user_data=0xffff64007a40) at ../io/channel-watch.c:84
>   #23 0x0000ffff7fb13a7c in g_main_context_dispatch () from target:/usr/lib64/libglib-2.0.so.0
>   #24 0x0000aaaae287d29c in glib_pollfds_poll () at ../util/main-loop.c:221
>   #25 0x0000aaaae287d324 in os_host_main_loop_wait (timeout=571000000) at ../util/main-loop.c:244
>   #26 0x0000aaaae287d444 in main_loop_wait (nonblocking=0) at ../util/main-loop.c:520
>   #27 0x0000aaaae24b9b20 in qemu_main_loop () at ../softmmu/vl.c:1677
>   #28 0x0000aaaae1eb79e4 in main (argc=83, argv=0xfffff5d238c8, envp=0xfffff5d23b68) at ../softmmu/main.c:50
> 
> --
> You received this bug notification because you are a member of qemu- devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1902470
> 
> Title:
>   migration with TLS-MultiFD is stuck when the dst-libvirtd service
>   restarts
> 
> Status in QEMU:
>   New
> 
> Bug description:
>   hi,
> 
>   I found that the multi-channel TLS-handshake will be stuck when the
>   dst-libvirtd restarts, both the src and dst sockets are blocked in
>   recvmsg. In the meantime, live_migration thread is blocked in
>   multifd_send_sync_main, so migration cannot be cancelled though src-
>   libvirt has delivered the QMP command.
> 
>   Is there any way to exit migration when the multi-channel TLS-
>   handshake is stuck? Does setting TLS-handshake timeout function take
>   effect?
> 
>   The stack trace are as follows:
> 
>   =====src qemu-system-aar stack=====:
>   #0  0x0000ffff87d6f28c in recvmsg () from target:/usr/lib64/libpthread.so.0
>   #1  0x0000aaaae3817424 in qio_channel_socket_readv (ioc=0xaaaae9e30a30, iov=0xffffdb58e8a8, niov=1, fds=0x0, nfds=0x0, errp=0x0) at ../io/channel-socket.c:502
>   #2  0x0000aaaae380f468 in qio_channel_readv_full (ioc=0xaaaae9e30a30, iov=0xffffdb58e8a8, niov=1, fds=0x0, nfds=0x0, errp=0x0) at ../io/channel.c:66
>   #3  0x0000aaaae380f9e8 in qio_channel_read (ioc=0xaaaae9e30a30, buf=0xaaaaea204e9b "\026\003\001\001L\001", buflen=5, errp=0x0) at ../io/channel.c:217
>   #4  0x0000aaaae380e7d4 in qio_channel_tls_read_handler (buf=0xaaaaea204e9b "\026\003\001\001L\001", len=5, opaque=0xfffd38001190) at ../io/channel-tls.c:53
>   #5  0x0000aaaae3801114 in qcrypto_tls_session_pull (opaque=0xaaaae99d5700, buf=0xaaaaea204e9b, len=5) at ../crypto/tlssession.c:89
>   #6  0x0000ffff8822ed30 in _gnutls_stream_read (ms=0xffffdb58eaac, pull_func=0xfffd38001870, size=5, bufel=<synthetic pointer>, session=0xaaaae983cd60) at buffers.c:346
>   #7  _gnutls_read (ms=0xffffdb58eaac, pull_func=0xfffd38001870, size=5, bufel=<synthetic pointer>, session=0xaaaae983cd60) at buffers.c:426
>   #8  _gnutls_io_read_buffered (session=session@entry=0xaaaae983cd60, total=5, recv_type=recv_type@entry=4294967295, ms=0xffffdb58eaac) at buffers.c:581
>   #9  0x0000ffff88224954 in recv_headers (ms=<optimized out>, record=0xffff883cd000 <gnutls_x509_ext_export_name_constraints@got.plt>, htype=65535, type=2284006288, record_params=0xaaaae9e22a60, session=0xaaaae983cd60) at record.c:1163
>   #10 _gnutls_recv_in_buffers (session=session@entry=0xaaaae983cd60, type=2284006288, type@entry=GNUTLS_HANDSHAKE, htype=65535, htype@entry=GNUTLS_HANDSHAKE_HELLO_RETRY_REQUEST, ms=<optimized out>, ms@entry=0) at record.c:1302
>   #11 0x0000ffff88230568 in _gnutls_handshake_io_recv_int (session=session@entry=0xaaaae983cd60, htype=htype@entry=GNUTLS_HANDSHAKE_HELLO_RETRY_REQUEST, hsk=hsk@entry=0xffffdb58ec38, optional=optional@entry=1) at buffers.c:1445
>   #12 0x0000ffff88232b90 in _gnutls_recv_handshake (session=session@entry=0xaaaae983cd60, type=type@entry=GNUTLS_HANDSHAKE_HELLO_RETRY_REQUEST, optional=optional@entry=1, buf=buf@entry=0x0) at handshake.c:1534
>   #13 0x0000ffff88235b40 in handshake_client (session=session@entry=0xaaaae983cd60) at handshake.c:2925
>   #14 0x0000ffff88237824 in gnutls_handshake (session=0xaaaae983cd60) at handshake.c:2739
>   #15 0x0000aaaae380213c in qcrypto_tls_session_handshake (session=0xaaaae99d5700, errp=0xffffdb58ee58) at ../crypto/tlssession.c:493
>   #16 0x0000aaaae380ea40 in qio_channel_tls_handshake_task (ioc=0xfffd38001190, task=0xaaaaea61d4e0, context=0x0) at ../io/channel-tls.c:161
>   #17 0x0000aaaae380ec60 in qio_channel_tls_handshake (ioc=0xfffd38001190, func=0xaaaae3394d20 <multifd_tls_outgoing_handshake>, opaque=0xaaaaea189c30, destroy=0x0, context=0x0) at ../io/channel-tls.c:239
>   #18 0x0000aaaae3394e78 in multifd_tls_channel_connect (p=0xaaaaea189c30, ioc=0xaaaae9e30a30, errp=0xffffdb58ef28) at ../migration/multifd.c:782
>   #19 0x0000aaaae3394f30 in multifd_channel_connect (p=0xaaaaea189c30, ioc=0xaaaae9e30a30, error=0x0) at ../migration/multifd.c:804
>   #20 0x0000aaaae33950b8 in multifd_new_send_channel_async (task=0xaaaaea6855a0, opaque=0xaaaaea189c30) at ../migration/multifd.c:858
>   #21 0x0000aaaae3810cf8 in qio_task_complete (task=0xaaaaea6855a0) at ../io/task.c:197
>   #22 0x0000aaaae381096c in qio_task_thread_result (opaque=0xaaaaea6855a0) at ../io/task.c:112
>   #23 0x0000ffff88701df8 in ?? () from target:/usr/lib64/libglib-2.0.so.0
>   #24 0x0000ffff88705a7c in g_main_context_dispatch () from target:/usr/lib64/libglib-2.0.so.0
>   #25 0x0000aaaae3a5a29c in glib_pollfds_poll () at ../util/main-loop.c:221
>   #26 0x0000aaaae3a5a324 in os_host_main_loop_wait (timeout=0) at ../util/main-loop.c:244
>   #27 0x0000aaaae3a5a444 in main_loop_wait (nonblocking=0) at ../util/main-loop.c:520
>   #28 0x0000aaaae3696b20 in qemu_main_loop () at ../softmmu/vl.c:1677
>   #29 0x0000aaaae30949e4 in main (argc=81, argv=0xffffdb58f2c8, envp=0xffffdb58f558) at ../softmmu/main.c:50
> 
>   =====src live_migration stack=====:
>   #0  0x0000ffff87d6a5d8 in pthread_cond_wait () from target:/usr/lib64/libpthread.so.0
>   #1  0x0000aaaae3a5f3ec in qemu_sem_wait (sem=0xaaaaea189d40) at ../util/qemu-thread-posix.c:328
>   #2  0x0000aaaae3394838 in multifd_send_sync_main (f=0xaaaae983f0e0) at ../migration/multifd.c:638
>   #3  0x0000aaaae37de310 in ram_save_setup (f=0xaaaae983f0e0, opaque=0xaaaae4198708 <ram_state>) at ../migration/ram.c:2588
>   #4  0x0000aaaae31cf7ac in qemu_savevm_state_setup (f=0xaaaae983f0e0) at ../migration/savevm.c:1176
>   #5  0x0000aaaae3248360 in migration_thread (opaque=0xaaaae9829f20) at ../migration/migration.c:3521
>   #6  0x0000aaaae3a5f8fc in qemu_thread_start (args=0xaaaaea513ee0) at ../util/qemu-thread-posix.c:521
>   #7  0x0000ffff87d647ac in ?? () from target:/usr/lib64/libpthread.so.0
>   #8  0x0000ffff87cba6ec in ?? () from target:/usr/lib64/libc.so.6
> 
>   =====dst qemu-system-aar stack=====:
>   #0  0x0000ffff7f17d28c in recvmsg () from target:/usr/lib64/libpthread.so.0
>   #1  0x0000aaaae263a424 in qio_channel_socket_readv (ioc=0xaaaaf998a800, iov=0xfffff5d22f78, niov=1, fds=0x0, nfds=0x0, errp=0x0) at ../io/channel-socket.c:502
>   #2  0x0000aaaae2632468 in qio_channel_readv_full (ioc=0xaaaaf998a800, iov=0xfffff5d22f78, niov=1, fds=0x0, nfds=0x0, errp=0x0) at ../io/channel.c:66
>   #3  0x0000aaaae26329e8 in qio_channel_read (ioc=0xaaaaf998a800, buf=0xaaaafa926dbb "q\024\335\365ȣ'\221,\\\357\246w\253\242ѠصI\247(N(K=\256\316DH\227QNf\371\"\271\017\226^\223\026\373\245z\255\227\025R.\244\205\254\002\031T\033\312:h\226\aݔ\204Ԫ\324\351K\341\365\247\032\354+\277\005O'*l\301cXx\340~?\346\b\324k\225\223D\276\252\376\257_0\036\223\022\006\212D|7h\257\226\300&n','\005zL\203M͆\023\213\237(o\272\025_\305s\372\362\351\002\367Ph\016\347\371E\n\030Y\340\002\r\362^&`\021\203}\353\324A\340ҳ(\207]\300l}h\026\037H\372\n=\"C\024\t\200\325\334&=\333>\212ƏE\214]_\372\264]"..., buflen=5, errp=0x0) at ../io/channel.c:217
>   #4  0x0000aaaae26317d4 in qio_channel_tls_read_handler (buf=0xaaaafa926dbb "q\024\335\365ȣ'\221,\\\357\246w\253\242ѠصI\247(N(K=\256\316DH\227QNf\371\"\271\017\226^\223\026\373\245z\255\227\025R.\244\205\254\002\031T\033\312:h\226\aݔ\204Ԫ\324\351K\341\365\247\032\354+\277\005O'*l\301cXx\340~?\346\b\324k\225\223D\276\252\376\257_0\036\223\022\006\212D|7h\257\226\300&n','\005zL\203M͆\023\213\237(o\272\025_\305s\372\362\351\002\367Ph\016\347\371E\n\030Y\340\002\r\362^&`\021\203}\353\324A\340ҳ(\207]\300l}h\026\037H\372\n=\"C\024\t\200\325\334&=\333>\212ƏE\214]_\372\264]"..., len=5, opaque=0xaaaaf9c4c400) at ../io/channel-tls.c:53
>   #5  0x0000aaaae2624114 in qcrypto_tls_session_pull (opaque=0xaaaafa4a3d90, buf=0xaaaafa926dbb, len=5) at ../crypto/tlssession.c:89
>   #6  0x0000ffff7f63cd30 in _gnutls_stream_read (ms=0xfffff5d2317c, pull_func=0xaaaafa81a380, size=5, bufel=<synthetic pointer>, session=0xaaaafa58b9d0) at buffers.c:346
>   #7  _gnutls_read (ms=0xfffff5d2317c, pull_func=0xaaaafa81a380, size=5, bufel=<synthetic pointer>, session=0xaaaafa58b9d0) at buffers.c:426
>   #8  _gnutls_io_read_buffered (session=session@entry=0xaaaafa58b9d0, total=5, recv_type=recv_type@entry=4294967295, ms=0xfffff5d2317c) at buffers.c:581
>   #9  0x0000ffff7f632954 in recv_headers (ms=<optimized out>, record=0x1ee2a9fa78, htype=65535, type=2137262992, record_params=0xaaaafa4b71a0, session=0xaaaafa58b9d0) at record.c:1163
>   #10 _gnutls_recv_in_buffers (session=session@entry=0xaaaafa58b9d0, type=2137262992, type@entry=GNUTLS_HANDSHAKE, htype=65535, htype@entry=GNUTLS_HANDSHAKE_CLIENT_HELLO, ms=<optimized out>, ms@entry=0) at record.c:1302
>   #11 0x0000ffff7f63e568 in _gnutls_handshake_io_recv_int (session=session@entry=0xaaaafa58b9d0, htype=htype@entry=GNUTLS_HANDSHAKE_CLIENT_HELLO, hsk=hsk@entry=0xfffff5d23308, optional=optional@entry=0) at buffers.c:1445
>   #12 0x0000ffff7f640b90 in _gnutls_recv_handshake (session=session@entry=0xaaaafa58b9d0, type=type@entry=GNUTLS_HANDSHAKE_CLIENT_HELLO, optional=optional@entry=0, buf=buf@entry=0x0) at handshake.c:1534
>   #13 0x0000ffff7f645f18 in handshake_server (session=<optimized out>) at handshake.c:3351
>   #14 gnutls_handshake (session=0xaaaafa58b9d0) at handshake.c:2742
>   #15 0x0000aaaae262513c in qcrypto_tls_session_handshake (session=0xaaaafa4a3d90, errp=0xfffff5d23478) at ../crypto/tlssession.c:493
>   #16 0x0000aaaae2631a40 in qio_channel_tls_handshake_task (ioc=0xaaaaf9c4c400, task=0xaaaafa70e600, context=0x0) at ../io/channel-tls.c:161
>   #17 0x0000aaaae2631c60 in qio_channel_tls_handshake (ioc=0xaaaaf9c4c400, func=0xaaaae20d4b58 <migration_tls_incoming_handshake>, opaque=0x0, destroy=0x0, context=0x0) at ../io/channel-tls.c:239
>   #18 0x0000aaaae20d4ca8 in migration_tls_channel_process_incoming (s=0xaaaaf9b2ef20, ioc=0xaaaaf998a800, errp=0xfffff5d23548) at ../migration/tls.c:103
>   #19 0x0000aaaae20f9f7c in migration_channel_process_incoming (ioc=0xaaaaf998a800) at ../migration/channel.c:42
>   #20 0x0000aaaae1f484a8 in socket_accept_incoming_migration (listener=0xffff64007a40, cioc=0xaaaaf998a800, opaque=0x0) at ../migration/socket.c:130
>   #21 0x0000aaaae2638570 in qio_net_listener_channel_func (ioc=0xaaaafa410600, condition=G_IO_IN, opaque=0xffff64007a40) at ../io/net-listener.c:54
>   #22 0x0000aaaae263ac4c in qio_channel_fd_source_dispatch (source=0xaaaafa81a380, callback=0xaaaae26384f8 <qio_net_listener_channel_func>, user_data=0xffff64007a40) at ../io/channel-watch.c:84
>   #23 0x0000ffff7fb13a7c in g_main_context_dispatch () from target:/usr/lib64/libglib-2.0.so.0
>   #24 0x0000aaaae287d29c in glib_pollfds_poll () at ../util/main-loop.c:221
>   #25 0x0000aaaae287d324 in os_host_main_loop_wait (timeout=571000000) at ../util/main-loop.c:244
>   #26 0x0000aaaae287d444 in main_loop_wait (nonblocking=0) at ../util/main-loop.c:520
>   #27 0x0000aaaae24b9b20 in qemu_main_loop () at ../softmmu/vl.c:1677
>   #28 0x0000aaaae1eb79e4 in main (argc=83, argv=0xfffff5d238c8, envp=0xfffff5d23b68) at ../softmmu/main.c:50
> 
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1902470/+subscriptions
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


