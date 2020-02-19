Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E83C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 09:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A666224658
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 09:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/4Le8X6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A666224658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4M95-0005lt-Fk
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 04:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j4M8W-0005Ku-3q
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 04:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j4M8U-0006fy-HS
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 04:59:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52353
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j4M8U-0006dI-Dt
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 04:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582106357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BeQi0hdwaiZs0hqvP2EVJunzNbkC0Dba70sspndOxAs=;
 b=f/4Le8X6hy3AjMJs0Yfz6sAIYbOmQskOU4ztcf4DE8ta/BIpGSPgUsdkOk2hse/nM8fg0w
 OM78Lq54U7y+tmx+zZcBITvGqGW4SAKz39bfEIhQpwFq3o47rRmG6vPee9o4aHUtiO6gov
 Tb4QEQUbDypoOTXG8tBXPWCTScJsQsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-bPhe_g7UNYy5eDmhOB4t4w-1; Wed, 19 Feb 2020 04:59:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A426107ACC5;
 Wed, 19 Feb 2020 09:59:12 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F167D196AE;
 Wed, 19 Feb 2020 09:59:10 +0000 (UTC)
Date: Wed, 19 Feb 2020 09:59:08 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: pannengyuan@huawei.com
Subject: Re: [PATCH] migration/savevm: release gslist after dump_vmstate_json
Message-ID: <20200219095908.GB3089@work-vm>
References: <20200219094705.8960-1-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200219094705.8960-1-pannengyuan@huawei.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: bPhe_g7UNYy5eDmhOB4t4w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: euler.robot@huawei.com, zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* pannengyuan@huawei.com (pannengyuan@huawei.com) wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
>=20
> 'list' forgot to free at the end of dump_vmstate_json_to_file(), although=
 it's called only once, but seems like a clean code.
>=20
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
>=20
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
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>

Good robot!

> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>  migration/savevm.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/migration/savevm.c b/migration/savevm.c
> index f19cb9ec7a..60e6ea8a8d 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -665,6 +665,7 @@ void dump_vmstate_json_to_file(FILE *out_file)
>      }
>      fprintf(out_file, "\n}\n");
>      fclose(out_file);
> +    g_slist_free(list);

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  }
> =20
>  static uint32_t calculate_new_instance_id(const char *idstr)
> --=20
> 2.18.2
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


