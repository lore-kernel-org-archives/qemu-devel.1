Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7181C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:46:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF692467D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3xGZfze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF692467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBbSn-0000nf-TJ
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jBbS0-0000L7-J5
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jBbRy-0006Wd-Qs
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:45:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34381
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jBbRy-0006VK-Mt
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583833522;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hvLrF2Oq+YMGExKE3Cs9Jj7uDIVNRUS+ooAv7RFUWTc=;
 b=C3xGZfzeLVXsK6s8MGxmzbXWKjnHnKSjmPBnzIT2OpWOr2T85EMc/mqaz472/ecr7k5gCe
 YXzrrPpeEOOD8po4YThe90yJ+GLaJKxPpentnMlGr7qBbvHtB8FPIe4ncVcjnDOkjOdkYV
 jcXqyX4A18E5stD6xfE7y5DyVIh6vns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-yWeerhgtOXq6y4xa98svnA-1; Tue, 10 Mar 2020 05:45:15 -0400
X-MC-Unique: yWeerhgtOXq6y4xa98svnA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 904F2107B7D4;
 Tue, 10 Mar 2020 09:45:14 +0000 (UTC)
Received: from redhat.com (ovpn-112-62.ams2.redhat.com [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44BD119C58;
 Tue, 10 Mar 2020 09:45:11 +0000 (UTC)
Date: Tue, 10 Mar 2020 09:45:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH v2] qom-qmp-cmds: fix two memleaks in qmp_object_add
Message-ID: <20200310094508.GC3234052@redhat.com>
References: <20200310064640.5059-1-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200310064640.5059-1-pannengyuan@huawei.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: pbonzini@redhat.com, zhang.zhanghailiang@huawei.com, euler.robot@huawei.com,
 ehabkost@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 02:46:40PM +0800, Pan Nengyuan wrote:
> 'type/id' forgot to free in qmp_object_add, this patch fix that.
>=20
> The leak stack:
> Direct leak of 84 byte(s) in 6 object(s) allocated from:
>     #0 0x7fe2a5ebf768 in __interceptor_malloc (/lib64/libasan.so.5+0xef76=
8)
>     #1 0x7fe2a5044445 in g_malloc (/lib64/libglib-2.0.so.0+0x52445)
>     #2 0x7fe2a505dd92 in g_strdup (/lib64/libglib-2.0.so.0+0x6bd92)
>     #3 0x56344954e692 in qmp_object_add /mnt/sdb/qemu-new/qemu_test/qemu/=
qom/qom-qmp-cmds.c:258
>     #4 0x563449960f5a in do_qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu=
/qapi/qmp-dispatch.c:132
>     #5 0x563449960f5a in qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/qa=
pi/qmp-dispatch.c:175
>     #6 0x563449498a30 in monitor_qmp_dispatch /mnt/sdb/qemu-new/qemu_test=
/qemu/monitor/qmp.c:145
>     #7 0x56344949a64f in monitor_qmp_bh_dispatcher /mnt/sdb/qemu-new/qemu=
_test/qemu/monitor/qmp.c:234
>     #8 0x563449a92a3a in aio_bh_call /mnt/sdb/qemu-new/qemu_test/qemu/uti=
l/async.c:136
>=20
> Direct leak of 54 byte(s) in 6 object(s) allocated from:
>     #0 0x7fe2a5ebf768 in __interceptor_malloc (/lib64/libasan.so.5+0xef76=
8)
>     #1 0x7fe2a5044445 in g_malloc (/lib64/libglib-2.0.so.0+0x52445)
>     #2 0x7fe2a505dd92 in g_strdup (/lib64/libglib-2.0.so.0+0x6bd92)
>     #3 0x56344954e6c4 in qmp_object_add /mnt/sdb/qemu-new/qemu_test/qemu/=
qom/qom-qmp-cmds.c:267
>     #4 0x563449960f5a in do_qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu=
/qapi/qmp-dispatch.c:132
>     #5 0x563449960f5a in qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/qa=
pi/qmp-dispatch.c:175
>     #6 0x563449498a30 in monitor_qmp_dispatch /mnt/sdb/qemu-new/qemu_test=
/qemu/monitor/qmp.c:145
>     #7 0x56344949a64f in monitor_qmp_bh_dispatcher /mnt/sdb/qemu-new/qemu=
_test/qemu/monitor/qmp.c:234
>     #8 0x563449a92a3a in aio_bh_call /mnt/sdb/qemu-new/qemu_test/qemu/uti=
l/async.c:136
>=20
> Fixes: 5f07c4d60d091320186e7b0edaf9ed2cc16b2d1e
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> v2->v1:
> - do not store both a const and non-const string in the same variable, ch=
ange it to a non-const string.
>   (Suggested by Daniel P. Berrang=C3=A9)
> ---
>  qom/qom-qmp-cmds.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


