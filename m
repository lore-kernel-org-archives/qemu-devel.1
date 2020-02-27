Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8431FC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 18:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 551602468E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 18:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOEHPBNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551602468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7NYo-0008Vl-I6
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 13:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j7NXu-0007dp-C7
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:06:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j7NXs-0001nz-Sa
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:06:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33912
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j7NXs-0001nh-O0
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582826760;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EAYepgTceBIuWs266g+Gdi1OUUS9u1TgaCdk8OVCjLU=;
 b=bOEHPBNNkNBAzl8DWLlHFJXbBxH3I/9WVEb2/WMO+n8Z9LtFkERF2nbtfIBwwollZfW7Ff
 5VW1iWBOLalZ1Wan6C870H7YzI3cEJJ4lZMyojWb2LuLiMtpIs4ZHizRttztZsLKgHcefI
 39cyHx/Fac+i4hYpPil+Br1TSIQ3FRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-0qXQk-msPZ2NlfMIIzp_Fg-1; Thu, 27 Feb 2020 13:05:58 -0500
X-MC-Unique: 0qXQk-msPZ2NlfMIIzp_Fg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 411F41005514;
 Thu, 27 Feb 2020 18:05:57 +0000 (UTC)
Received: from redhat.com (ovpn-116-72.ams2.redhat.com [10.36.116.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC9CE60C18;
 Thu, 27 Feb 2020 18:05:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: <pannengyuan@huawei.com>
Subject: Re: [PATCH] migration/savevm: release gslist after dump_vmstate_json
In-Reply-To: <20200219094705.8960-1-pannengyuan@huawei.com>
 (pannengyuan@huawei.com's message of "Wed, 19 Feb 2020 17:47:05
 +0800")
References: <20200219094705.8960-1-pannengyuan@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 27 Feb 2020 19:05:54 +0100
Message-ID: <87ftevdhx9.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Reply-To: quintela@redhat.com
Cc: euler.robot@huawei.com, zhanghailiang@huawei.com, dgilbert@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

<pannengyuan@huawei.com> wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
>
> 'list' forgot to free at the end of dump_vmstate_json_to_file(), although=
 it's called only once, but seems like a clean code.
>
> Fix the leak as follow:
> Direct leak of 16 byte(s) in 1 object(s) allocated from:
>     #0 0x7fb946abd768 in __interceptor_malloc (/lib64/libasan.so.5+0xef76=
8)
>     #1 0x7fb945eca445 in g_malloc (/lib64/libglib-2.0.so.0+0x52445)
>     #2 0x7fb945ee2066 in g_slice_alloc (/lib64/libglib-2.0.so.0+0x6a066)
>     #3 0x7fb945ee3139 in g_slist_prepend (/lib64/libglib-2.0.so.0+0x6b139=
)
>     #4 0x5585db591581 in object_class_get_list_tramp /mnt/sdb/qemu-new/qe=
mu/qom/object.c:1084
>     #5 0x5585db590f66 in object_class_foreach_tramp /mnt/sdb/qemu-new/qem=
u/qom/object.c:1028
>     #6 0x7fb945eb35f7 in g_hash_table_foreach (/lib64/libglib-2.0.so.0+0x=
3b5f7)
>     #7 0x5585db59110c in object_class_foreach /mnt/sdb/qemu-new/qemu/qom/=
object.c:1038
>     #8 0x5585db5916b6 in object_class_get_list /mnt/sdb/qemu-new/qemu/qom=
/object.c:1092
>     #9 0x5585db335ca0 in dump_vmstate_json_to_file /mnt/sdb/qemu-new/qemu=
/migration/savevm.c:638
>     #10 0x5585daa5bcbf in main /mnt/sdb/qemu-new/qemu/vl.c:4420
>     #11 0x7fb941204812 in __libc_start_main ../csu/libc-start.c:308
>     #12 0x5585da29420d in _start (/mnt/sdb/qemu-new/qemu/build/x86_64-sof=
tmmu/qemu-system-x86_64+0x27f020d)
>
> Indirect leak of 7472 byte(s) in 467 object(s) allocated from:
>     #0 0x7fb946abd768 in __interceptor_malloc (/lib64/libasan.so.5+0xef76=
8)
>     #1 0x7fb945eca445 in g_malloc (/lib64/libglib-2.0.so.0+0x52445)
>     #2 0x7fb945ee2066 in g_slice_alloc (/lib64/libglib-2.0.so.0+0x6a066)
>     #3 0x7fb945ee3139 in g_slist_prepend (/lib64/libglib-2.0.so.0+0x6b139=
)
>     #4 0x5585db591581 in object_class_get_list_tramp /mnt/sdb/qemu-new/qe=
mu/qom/object.c:1084
>     #5 0x5585db590f66 in object_class_foreach_tramp /mnt/sdb/qemu-new/qem=
u/qom/object.c:1028
>     #6 0x7fb945eb35f7 in g_hash_table_foreach (/lib64/libglib-2.0.so.0+0x=
3b5f7)
>     #7 0x5585db59110c in object_class_foreach /mnt/sdb/qemu-new/qemu/qom/=
object.c:1038
>     #8 0x5585db5916b6 in object_class_get_list /mnt/sdb/qemu-new/qemu/qom=
/object.c:1092
>     #9 0x5585db335ca0 in dump_vmstate_json_to_file /mnt/sdb/qemu-new/qemu=
/migration/savevm.c:638
>     #10 0x5585daa5bcbf in main /mnt/sdb/qemu-new/qemu/vl.c:4420
>     #11 0x7fb941204812 in __libc_start_main ../csu/libc-start.c:308
>     #12 0x5585da29420d in _start (/mnt/sdb/qemu-new/qemu/build/x86_64-sof=
tmmu/qemu-system-x86_64+0x27f020d)
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


