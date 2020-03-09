Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA2BC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56B6F2072A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeY/iWkk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B6F2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBFT7-0005Gb-H5
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 06:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jBFRz-0004q1-Cc
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jBFRy-0004gX-0q
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:15:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26732
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jBFRx-0004g6-Sh
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583748953;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VwM62ZNkZUuKsMH8tUnz51QpiITo7rU3pCiBBFbr7VM=;
 b=UeY/iWkkuHyLB/gWPAdtsAISwmxIIoJzk8jxYjVW4hRkHIJ6r5CgUlUSPaNggFQznMYM4e
 +5dsKTZ2rLLHwCIFrhS+wh+bNMcWRd9CmkQcGs3qKYcYLa7S2CgJU6vrkAQ95z9sYVLiYz
 guHzUWtQatFuifyyR1tDA827Sd+iQeE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-KUy32jwzPNS-KCXRqDvlOA-1; Mon, 09 Mar 2020 06:15:51 -0400
X-MC-Unique: KUy32jwzPNS-KCXRqDvlOA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28F31107ACC4;
 Mon,  9 Mar 2020 10:15:50 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 43F5D87B08;
 Mon,  9 Mar 2020 10:15:47 +0000 (UTC)
Date: Mon, 9 Mar 2020 10:15:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] qom-qmp-cmds: fix two memleaks in qmp_object_add
Message-ID: <20200309101545.GC3033513@redhat.com>
References: <20200309092212.3249-1-pannengyuan@huawei.com>
 <20200309105145.2f3f6a81@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200309105145.2f3f6a81@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: zhang.zhanghailiang@huawei.com, Pan Nengyuan <pannengyuan@huawei.com>,
 qemu-devel@nongnu.org, euler.robot@huawei.com, pbonzini@redhat.com,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 09, 2020 at 10:51:45AM +0100, Igor Mammedov wrote:
> On Mon, 9 Mar 2020 17:22:12 +0800
> Pan Nengyuan <pannengyuan@huawei.com> wrote:
>=20
> > 'type/id' forgot to free in qmp_object_add, this patch fix that.
> >=20
> > The leak stack:
> > Direct leak of 84 byte(s) in 6 object(s) allocated from:
> >     #0 0x7fe2a5ebf768 in __interceptor_malloc (/lib64/libasan.so.5+0xef=
768)
> >     #1 0x7fe2a5044445 in g_malloc (/lib64/libglib-2.0.so.0+0x52445)
> >     #2 0x7fe2a505dd92 in g_strdup (/lib64/libglib-2.0.so.0+0x6bd92)
> >     #3 0x56344954e692 in qmp_object_add /mnt/sdb/qemu-new/qemu_test/qem=
u/qom/qom-qmp-cmds.c:258
> >     #4 0x563449960f5a in do_qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qe=
mu/qapi/qmp-dispatch.c:132
> >     #5 0x563449960f5a in qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/=
qapi/qmp-dispatch.c:175
> >     #6 0x563449498a30 in monitor_qmp_dispatch /mnt/sdb/qemu-new/qemu_te=
st/qemu/monitor/qmp.c:145
> >     #7 0x56344949a64f in monitor_qmp_bh_dispatcher /mnt/sdb/qemu-new/qe=
mu_test/qemu/monitor/qmp.c:234
> >     #8 0x563449a92a3a in aio_bh_call /mnt/sdb/qemu-new/qemu_test/qemu/u=
til/async.c:136
> >=20
> > Direct leak of 54 byte(s) in 6 object(s) allocated from:
> >     #0 0x7fe2a5ebf768 in __interceptor_malloc (/lib64/libasan.so.5+0xef=
768)
> >     #1 0x7fe2a5044445 in g_malloc (/lib64/libglib-2.0.so.0+0x52445)
> >     #2 0x7fe2a505dd92 in g_strdup (/lib64/libglib-2.0.so.0+0x6bd92)
> >     #3 0x56344954e6c4 in qmp_object_add /mnt/sdb/qemu-new/qemu_test/qem=
u/qom/qom-qmp-cmds.c:267
> >     #4 0x563449960f5a in do_qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qe=
mu/qapi/qmp-dispatch.c:132
> >     #5 0x563449960f5a in qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/=
qapi/qmp-dispatch.c:175
> >     #6 0x563449498a30 in monitor_qmp_dispatch /mnt/sdb/qemu-new/qemu_te=
st/qemu/monitor/qmp.c:145
> >     #7 0x56344949a64f in monitor_qmp_bh_dispatcher /mnt/sdb/qemu-new/qe=
mu_test/qemu/monitor/qmp.c:234
> >     #8 0x563449a92a3a in aio_bh_call /mnt/sdb/qemu-new/qemu_test/qemu/u=
til/async.c:136
> >=20
> > Fixes: 5f07c4d60d091320186e7b0edaf9ed2cc16b2d1e
> > Reported-by: Euler Robot <euler.robot@huawei.com>
> > Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> > ---
> >  qom/qom-qmp-cmds.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> > index 49db926fcc..ac59ba1aa8 100644
> > --- a/qom/qom-qmp-cmds.c
> > +++ b/qom/qom-qmp-cmds.c
> > @@ -247,8 +247,8 @@ void qmp_object_add(QDict *qdict, QObject **ret_dat=
a, Error **errp)
> >      QDict *pdict;
> >      Visitor *v;
> >      Object *obj;
> > -    const char *type;
> > -    const char *id;
> > +    g_autofree const char *type =3D NULL;
> > +    g_autofree const char *id =3D NULL;
>=20
> not sure that's it's correct
>=20
> qdict_get_try_str() returns the reference to a string within
> the QDict, so caller who provided qdict should take care of
> freeing it.

This is correct, but two lines later we have  "type =3D g_strdup(type)".

IOW, the code is storing both a const and non-const string in the
same variable which is gross.

So there's definitely a leak, but this is also not the right way
to fix it.

To fix it, notice that g_strdup says

   "Duplicates a string. If str is NULL it returns NULL. The=20
    returned string should be freed with g_free() when no longer
    needed."

IOW, instead of

    const char *type;

    type =3D qdict_get_try_str(qdict, "qom-type");
    if (!type) {
        error_setg(errp, QERR_MISSING_PARAMETER, "qom-type");
        return;
    } else {
        type =3D g_strdup(type);
        qdict_del(qdict, "qom-type");
    }

we want

    g_autofree char *type =3D NULL;

    type =3D g_strdup(qdict_get_try_str(qdict, "qom-type"));
    if (!type) {
        error_setg(errp, QERR_MISSING_PARAMETER, "qom-type");
        return;
    }

    qdict_del(qdict, "qom-type");

> >      type =3D qdict_get_try_str(qdict, "qom-type");
> >      if (!type) {




Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


