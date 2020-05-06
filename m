Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4049EC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C35320675
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fncPNHZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C35320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWFej-0003Mq-5e
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 04:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWFdk-0002cL-7z
 for qemu-devel@nongnu.org; Wed, 06 May 2020 04:42:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39934
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWFdj-0000Vh-7X
 for qemu-devel@nongnu.org; Wed, 06 May 2020 04:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588754570;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FsPN8ZEiy3JBc16xREf11pLUgl21aJzWTAgoN0o8X5I=;
 b=fncPNHZYSM/C+2wf28k8XvfZu1HD996Ckuxihz7DoGon8KrIg58Loug/wq2FIiYVaR/8ya
 xKXu366Y3UVnINltWHNO1Lru0pg48f40xLwYrCe0wvzzfRoZc/pZM7+9XtRgy3vRB3PoPm
 T7CnLLvR9w0tXXEC4C+gqpJv+BVFNSY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-E24skOaxOV2hVgHo-fgOeQ-1; Wed, 06 May 2020 04:42:31 -0400
X-MC-Unique: E24skOaxOV2hVgHo-fgOeQ-1
Received: by mail-wr1-f70.google.com with SMTP id a12so959350wrv.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 01:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version;
 bh=fHK07n0wKI00LuA/8GwVgZM6XuCUx+jL6ZqEXCjmDBA=;
 b=glNg1dAb7WHqKQMVhe+kSC6ojY7RMdW+lF/p+lI9N7KZKSUAUFOsv4td+u7m3X3BD+
 hY16icHt2n66+5o9Dq+JlUngWG8gFAbM+f9+pPtl40UdN2wstzmGU2sYCR0w/dqcgDzx
 1Ph2YicsbCwUqnS+XVkX6DpybEImVdtU1PuNXMJwcT3FdqhzZUr1ax/SeaN74WWIkvbY
 aKLCxFA5Vbw0FqdRkbjBWnm5W9ZRz/Tee72xwRG+F8hMPEtujDYzPc5x5FamMJ7RKOYN
 qgZDkyMNiXHB4SiSEvUSankmcEFprd4NaMAd7n914D/w3IxfiNu265vZCHvNaQEYrnnd
 lo1A==
X-Gm-Message-State: AGi0PuYXEVMZFBLH9oJkTH/NeXo/QM8F3gqZM9OCEugR+7IXYiZoXhPW
 Nu+DHyVAc49+7/ufQ5EO0YtrG4GzWmyNe6qk486nJLxLOcIgvrSGijSNslgIrQHmBasvYCLkvus
 IT+gtQMvxao7ptXE=
X-Received: by 2002:a7b:ce0b:: with SMTP id m11mr3280237wmc.67.1588754549538; 
 Wed, 06 May 2020 01:42:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ2BujkSV2PfJ9mtle2M1wICjtn1Y2VTBIvaLyrD75jD1278nqlgfV8JK8KeEBDpQCtOs+Ntg==
X-Received: by 2002:a7b:ce0b:: with SMTP id m11mr3280212wmc.67.1588754549300; 
 Wed, 06 May 2020 01:42:29 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id s8sm1528287wrt.69.2020.05.06.01.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 01:42:28 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH 1/2] migration/multifd: fix memleaks in
 multifd_new_send_channel_async
In-Reply-To: <20200506095416.26099-2-pannengyuan@huawei.com> (Pan Nengyuan's
 message of "Wed, 6 May 2020 05:54:15 -0400")
References: <20200506095416.26099-1-pannengyuan@huawei.com>
 <20200506095416.26099-2-pannengyuan@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 06 May 2020 10:42:27 +0200
Message-ID: <874kstjvyk.fsf@secure.mitica>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=quintela@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 23:48:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: quintela@redhat.com
Cc: zhang.zhanghailiang@huawei.com, euler.robot@huawei.com, dgilbert@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pan Nengyuan <pannengyuan@huawei.com> wrote:
> When error happen in multifd_new_send_channel_async, 'sioc' will not be u=
sed
> to create the multifd_send_thread. Let's free it to avoid a memleak. And =
also
> do error_free after migrate_set_error() to avoid another leak in the same=
 place.
>
> The leak stack:
> Direct leak of 2880 byte(s) in 8 object(s) allocated from:
>     #0 0x7f20b5118ae8 in __interceptor_malloc (/lib64/libasan.so.5+0xefae=
8)
>     #1 0x7f20b44df1d5 in g_malloc (/lib64/libglib-2.0.so.0+0x531d5)
>     #2 0x564133bce18b in object_new_with_type /mnt/sdb/backup/qemu/qom/ob=
ject.c:683
>     #3 0x564133eea950 in qio_channel_socket_new /mnt/sdb/backup/qemu/io/c=
hannel-socket.c:56
>     #4 0x5641339cfe4f in socket_send_channel_create /mnt/sdb/backup/qemu/=
migration/socket.c:37
>     #5 0x564133a10328 in multifd_save_setup /mnt/sdb/backup/qemu/migratio=
n/multifd.c:772
>     #6 0x5641339cebed in migrate_fd_connect /mnt/sdb/backup/qemu/migratio=
n/migration.c:3530
>     #7 0x5641339d15e4 in migration_channel_connect /mnt/sdb/backup/qemu/m=
igration/channel.c:92
>     #8 0x5641339cf5b7 in socket_outgoing_migration /mnt/sdb/backup/qemu/m=
igration/socket.c:108
>
> Direct leak of 384 byte(s) in 8 object(s) allocated from:
>     #0 0x7f20b5118cf0 in calloc (/lib64/libasan.so.5+0xefcf0)
>     #1 0x7f20b44df22d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5322d)
>     #2 0x56413406fc17 in error_setv /mnt/sdb/backup/qemu/util/error.c:61
>     #3 0x564134070464 in error_setg_errno_internal /mnt/sdb/backup/qemu/u=
til/error.c:109
>     #4 0x5641340851be in inet_connect_addr /mnt/sdb/backup/qemu/util/qemu=
-sockets.c:379
>     #5 0x5641340851be in inet_connect_saddr /mnt/sdb/backup/qemu/util/qem=
u-sockets.c:458
>     #6 0x5641340870ab in socket_connect /mnt/sdb/backup/qemu/util/qemu-so=
ckets.c:1105
>     #7 0x564133eeaabf in qio_channel_socket_connect_sync /mnt/sdb/backup/=
qemu/io/channel-socket.c:145
>     #8 0x564133eeabf5 in qio_channel_socket_connect_worker /mnt/sdb/backu=
p/qemu/io/channel-socket.c:168
>
> Indirect leak of 360 byte(s) in 8 object(s) allocated from:
>     #0 0x7f20b5118ae8 in __interceptor_malloc (/lib64/libasan.so.5+0xefae=
8)
>     #1 0x7f20af901817 in __GI___vasprintf_chk (/lib64/libc.so.6+0x10d817)
>     #2 0x7f20b451fa6c in g_vasprintf (/lib64/libglib-2.0.so.0+0x93a6c)
>     #3 0x7f20b44f8cd0 in g_strdup_vprintf (/lib64/libglib-2.0.so.0+0x6ccd=
0)
>     #4 0x7f20b44f8d8c in g_strdup_printf (/lib64/libglib-2.0.so.0+0x6cd8c=
)
>     #5 0x56413406fc86 in error_setv /mnt/sdb/backup/qemu/util/error.c:65
>     #6 0x564134070464 in error_setg_errno_internal /mnt/sdb/backup/qemu/u=
til/error.c:109
>     #7 0x5641340851be in inet_connect_addr /mnt/sdb/backup/qemu/util/qemu=
-sockets.c:379
>     #8 0x5641340851be in inet_connect_saddr /mnt/sdb/backup/qemu/util/qem=
u-sockets.c:458
>     #9 0x5641340870ab in socket_connect /mnt/sdb/backup/qemu/util/qemu-so=
ckets.c:1105
>     #10 0x564133eeaabf in qio_channel_socket_connect_sync /mnt/sdb/backup=
/qemu/io/channel-socket.c:145
>     #11 0x564133eeabf5 in qio_channel_socket_connect_worker /mnt/sdb/back=
up/qemu/io/channel-socket.c:168
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

I am not sure that this are the only possible error cases, but they are
a step on the right direction.

Thanks, Juan.


