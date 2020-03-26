Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25824C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 02:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E20B52073E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 02:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwcFSGAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20B52073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHIS7-0001pQ-QH
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 22:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1jHIRR-0001OQ-2A
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 22:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1jHIRP-0002Om-8F
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 22:40:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35824)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1jHIRO-0002OG-TK
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 22:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585190418;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bL077o7+/uHDyyVfYOBzbqDuXIxuR+eMkutinacws10=;
 b=dwcFSGAWJnymmemlGzIeIiNME1sJ3t+v51gzZWP2Z470LIrxtwzLHWdi6+Txr8RwjTyuCU
 b8Jtew1ibua1qabz48pk/O6D0Anx+Himfo+plDIt7fZ6lcms1UcU1TsiyPBxfRe0ykpFy3
 gYfPnfzv3xExjTk2SGGcGg8neVX2RCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-73NWdO5pNGCrm5O7pmP-ig-1; Wed, 25 Mar 2020 22:40:16 -0400
X-MC-Unique: 73NWdO5pNGCrm5O7pmP-ig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DD5E800D54;
 Thu, 26 Mar 2020 02:40:15 +0000 (UTC)
Received: from redhat.com (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B555BBBDD;
 Thu, 26 Mar 2020 02:40:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH for-5.0 1/3] migration: fix cleanup_bh leak on resume
In-Reply-To: <20200325184723.2029630-2-marcandre.lureau@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 25 Mar 2020
 19:47:21 +0100")
References: <20200325184723.2029630-1-marcandre.lureau@redhat.com>
 <20200325184723.2029630-2-marcandre.lureau@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 26 Mar 2020 03:40:09 +0100
Message-ID: <874kub96uu.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Reply-To: quintela@redhat.com
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> Since commit 8c6b0356b53977bcfdea5299db07884915425b0c ("util/async:
> make bh_aio_poll() O(1)"), migration-test reveals a leak:
>
> QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
> tests/qtest/migration-test  -p /x86_64/migration/postcopy/recovery
> tests/qtest/libqtest.c:140: kill_qemu() tried to terminate QEMU
> process but encountered exit status 1 (expected 0)
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D2082571=3D=3DERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 40 byte(s) in 1 object(s) allocated from:
>     #0 0x7f25971dfc58 in __interceptor_malloc (/lib64/libasan.so.5+0x10dc=
58)
>     #1 0x7f2596d08358 in g_malloc (/lib64/libglib-2.0.so.0+0x57358)
>     #2 0x560970d006f8 in qemu_bh_new /home/elmarco/src/qemu/util/main-loo=
p.c:532
>     #3 0x5609704afa02 in migrate_fd_connect
> /home/elmarco/src/qemu/migration/migration.c:3407
>     #4 0x5609704b6b6f in migration_channel_connect
> /home/elmarco/src/qemu/migration/channel.c:92
>     #5 0x5609704b2bfb in socket_outgoing_migration
> /home/elmarco/src/qemu/migration/socket.c:108
>     #6 0x560970b9bd6c in qio_task_complete /home/elmarco/src/qemu/io/task=
.c:196
>     #7 0x560970b9aa97 in qio_task_thread_result
> /home/elmarco/src/qemu/io/task.c:111
>     #8 0x7f2596cfee3a  (/lib64/libglib-2.0.so.0+0x4de3a)
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


