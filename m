Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6684BC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 19:01:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E5B2076F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 19:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHjexZuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E5B2076F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGonT-0004cM-74
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 15:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jGomV-00041x-Er
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jGomU-0000Ld-6r
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:00:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:50083)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jGomU-0000LK-16
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585076405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tJ13Rwd9X4lovMwvDdoTXYBJ8H25eDYm551Mp+4LLGU=;
 b=MHjexZuRRmgCG7gDfucP6HjXH37mWlm5pPtL4oe1uKHlQjc2CH0Gsw2Qp5Y2SNrGFKNEOf
 3KDHZDANwPnyFEAYJZWy4rYS63OyGeT0vmzJvge92zq2qdzI0Xhn7OydQDAvw1TKkUTKE3
 SNz6GHnsfzr24U7xhDAsDugEzlhawTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-8kTvVdYbO6WdqqoEDK_pAw-1; Tue, 24 Mar 2020 15:00:04 -0400
X-MC-Unique: 8kTvVdYbO6WdqqoEDK_pAw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1402B189D6C3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 19:00:03 +0000 (UTC)
Received: from work-vm (ovpn-114-253.ams2.redhat.com [10.36.114.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 283365DA7C;
 Tue, 24 Mar 2020 18:59:58 +0000 (UTC)
Date: Tue, 24 Mar 2020 18:59:56 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH for-5.0] vl.c: fix migration failure for 3.1 and older
 machine types
Message-ID: <20200324185956.GF17043@work-vm>
References: <20200304172748.15338-1-imammedo@redhat.com>
 <20200317175213.217c3969@office.mammed.net>
MIME-Version: 1.0
In-Reply-To: <20200317175213.217c3969@office.mammed.net>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: ldoktor@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Igor Mammedov (imammedo@redhat.com) wrote:
> On Wed,  4 Mar 2020 12:27:48 -0500
> Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> > Migration from QEMU(v4.0) fails when using 3.1 or older machine
> > type. For example if one attempts to migrate
> > QEMU-2.12 started as
> >   qemu-system-ppc64 -nodefaults -M pseries-2.12 -m 4096 -mem-path /tmp/
> > to current master, it will fail with
> >   qemu-system-ppc64: Unknown ramblock "ppc_spapr.ram", cannot accept mi=
gration
> >   qemu-system-ppc64: error while loading state for instance 0x0 of devi=
ce 'ram'
> >   qemu-system-ppc64: load of migration failed: Invalid argument
> >=20
> > Caused by 900c0ba373 commit which switches main RAM allocation to
> > memory backends and the fact in 3.1 and older QEMU, backends used
> > full[***] QOM path as memory region name instead of backend's name.
> > That was changed after 3.1 to use prefix-less names by default
> > (fa0cb34d22) for new machine types.
> > *** effectively makes main RAM memory region names defined by
> > MachineClass::default_ram_id being altered with '/objects/' prefix
> > and therefore migration fails as old QEMU sends prefix-less
> > name while new QEMU expects name with prefix when using 3.1 and
> > older machine types.
> >=20
> > Fix it by forcing implicit[1] memory backend to always use
> > prefix-less names for its memory region by setting
> >   'x-use-canonical-path-for-ramblock-id'
> > property to false.
> >=20
> > 1) i.e. memory backend created by compat glue which maps
> > -m/-mem-path/-mem-prealloc/default RAM size into
> > appropriate backend type/options to match old CLI format.
> >=20
> > Fixes: 900c0ba373
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
>=20
>=20
> ping,
>=20
> so we don't forget to merge it

I'm queueing this.

> > ---
> > CC: ldoktor@redhat.com
> > CC: marcandre.lureau@redhat.com
> > CC: dgilbert@redhat.com
> > ---
> >  softmmu/vl.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/softmmu/vl.c b/softmmu/vl.c
> > index 5549f4b619..1101b1cb41 100644
> > --- a/softmmu/vl.c
> > +++ b/softmmu/vl.c
> > @@ -2800,6 +2800,9 @@ static void create_default_memdev(MachineState *m=
s, const char *path)
> >      object_property_set_int(obj, ms->ram_size, "size", &error_fatal);
> >      object_property_add_child(object_get_objects_root(), mc->default_r=
am_id,
> >                                obj, &error_fatal);
> > +    /* Ensure backend's memory region name is equal to mc->default_ram=
_id */
> > +    object_property_set_bool(obj, false, "x-use-canonical-path-for-ram=
block-id",
> > +                             &error_fatal);
> >      user_creatable_complete(USER_CREATABLE(obj), &error_fatal);
> >      object_unref(obj);
> >      object_property_set_str(OBJECT(ms), mc->default_ram_id, "memory-ba=
ckend",
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


