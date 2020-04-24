Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381C8C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 09:49:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0057B20728
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 09:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRsFsIOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0057B20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRuxN-0006c6-5c
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 05:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jRuvu-0005rj-C7
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jRuvh-0007V2-7Q
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:47:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31362
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jRuvf-0007Js-P6
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587721640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WbXO+WrIZmcaduygM4duLY7N8yR/xVq7u2IDbmFWwoY=;
 b=eRsFsIOUDyGJNtZ5dsAvQ0M+zPpSr3V04AAYGqY774kB+1gD/iW8trPV/oQv2D2mHG8W8w
 MSyyf5XbzZnuhOFmKVJOUhzoItBEiHOBweWQP34oBBaCFg9xuWt990auzpr3h7W8Jb9QiW
 JbPUhvjaeZrGZGQWGahB/DSSyQBJxXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-5A30o7qbPmSieeV1Yvx9kA-1; Fri, 24 Apr 2020 05:47:16 -0400
X-MC-Unique: 5A30o7qbPmSieeV1Yvx9kA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D587180F12F;
 Fri, 24 Apr 2020 09:47:01 +0000 (UTC)
Received: from work-vm (ovpn-113-179.ams2.redhat.com [10.36.113.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D45EB5D9CC;
 Fri, 24 Apr 2020 09:46:59 +0000 (UTC)
Date: Fri, 24 Apr 2020 10:46:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH] migration/rdma: fix a memleak on error path in
 rdma_start_incoming_migration
Message-ID: <20200424094657.GC3106@work-vm>
References: <20200420102727.17339-1-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200420102727.17339-1-pannengyuan@huawei.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:11:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, euler.robot@huawei.com,
 qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Pan Nengyuan (pannengyuan@huawei.com) wrote:
> 'rdma->host' is malloced in qemu_rdma_data_init, but forgot to free on th=
e error
> path in rdma_start_incoming_migration(), this patch fix that.
>=20
> The leak stack:
> Direct leak of 2 byte(s) in 1 object(s) allocated from:
>     #0 0x7fb7add18ae8 in __interceptor_malloc (/lib64/libasan.so.5+0xefae=
8)
>     #1 0x7fb7ad0df1d5 in g_malloc (/lib64/libglib-2.0.so.0+0x531d5)
>     #2 0x7fb7ad0f8b32 in g_strdup (/lib64/libglib-2.0.so.0+0x6cb32)
>     #3 0x55a0464a0f6f in qemu_rdma_data_init /mnt/sdb/qemu/migration/rdma=
.c:2647
>     #4 0x55a0464b0e76 in rdma_start_incoming_migration /mnt/sdb/qemu/migr=
ation/rdma.c:4020
>     #5 0x55a0463f898a in qemu_start_incoming_migration /mnt/sdb/qemu/migr=
ation/migration.c:365
>     #6 0x55a0458c75d3 in qemu_init /mnt/sdb/qemu/softmmu/vl.c:4438
>     #7 0x55a046a3d811 in main /mnt/sdb/qemu/softmmu/main.c:48
>     #8 0x7fb7a8417872 in __libc_start_main (/lib64/libc.so.6+0x23872)
>     #9 0x55a04536b26d in _start (/mnt/sdb/qemu/build/x86_64-softmmu/qemu-=
system-x86_64+0x286926d)
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Thanks,


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/rdma.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/migration/rdma.c b/migration/rdma.c
> index f61587891b..967fda5b0c 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -4056,6 +4056,7 @@ void rdma_start_incoming_migration(const char *host=
_port, Error **errp)
>      return;
>  err:
>      error_propagate(errp, local_err);
> +    g_free(rdma->host);
>      g_free(rdma);
>      g_free(rdma_return_path);
>  }
> --=20
> 2.18.2
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


