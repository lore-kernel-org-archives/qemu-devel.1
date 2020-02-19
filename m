Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE71C34056
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 20:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D826024670
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 20:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzbUUuUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D826024670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4WOY-0007Td-42
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 15:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4WNl-00072P-NB
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 15:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4WNj-0002lr-T2
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 15:55:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40184
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4WNi-0002kq-6a
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 15:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582145740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I994SpKaCjoC96ld2lGlKHtd7TARRhoHzLLB3CPuL9Q=;
 b=EzbUUuUHQ/ms3/UzmVjRQ8wBdPaQe/O1EQjcAgmvCcz7a7sXtRjavFN4p4uFpugBQnakZj
 3AqlOs9kGeXEI/VOS83Un94LiI6FrvgJwMo1kU5HN5gzbdKUTg5Y5RFvkbdSJ8/o/1Cl5/
 eTa5LhpH7dgAMabIEkv5LqLvkXuECE8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-rExcnrSvPM2KAapImLxS2g-1; Wed, 19 Feb 2020 15:55:36 -0500
Received: by mail-qv1-f70.google.com with SMTP id l1so1079455qvu.13
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 12:55:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iUBo18VpAMTHP8ayngwQlf56D2f0RfICvmR/XlKHhOA=;
 b=LlIpPYulHfIYFzrTQgU0kZleX06NcjmEt1TV606PEi4vv9FGpxS1b+72Zqa+vfY+9Q
 rDQvdGsxCkHqw8IUMQQFg7sqcRfBcdq30EzGBCYHHdjWHKWSTagJfGJY1pWQGywQV5w3
 GC7Koe3jVJnW934ut3qBOxUVobVOlGG/PIPxfGa2JOtgtiAhgGcJnaNAN2ODE35KqPhh
 5qxsCdoTCQBSLwoWaCbxQmr0aJbgU1HKaLJ8gjy4W4EzWlaVCGa4f8VR5tTLQ/jxO6W0
 Vu6dxlGKiStfYnmlfDl5ST63R1Ikd6zk2FZPae+v+mDa6EPJpADJ2kv9FcUMn/SmQtEs
 T0ZQ==
X-Gm-Message-State: APjAAAUE6Fxv0RH0i6tOB+pIyn+/8jY5tQ+lit7k3F5zUosdZbZlTPse
 aXdDsDXFQeR8I0gkmjwFUpQaNQABYV4BAdJPQWndVNhdnY9eAYRS3/W+oWfGDAZGJYevDylOlGT
 N0Rup2FDCJJ4loqY=
X-Received: by 2002:ac8:138b:: with SMTP id h11mr23396366qtj.153.1582145735812; 
 Wed, 19 Feb 2020 12:55:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqzU2gYudfof/xgWlOWeQSjTI3O9ecbftFusl6rNzFan4NAUD26vtRPWxd2OP6ylWHHR/vjdkQ==
X-Received: by 2002:ac8:138b:: with SMTP id h11mr23396353qtj.153.1582145735566; 
 Wed, 19 Feb 2020 12:55:35 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id h13sm596928qtu.23.2020.02.19.12.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 12:55:34 -0800 (PST)
Date: Wed, 19 Feb 2020 15:55:33 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 07/13] migrate/ram: Get rid of "place_source" in
 ram_load_postcopy()
Message-ID: <20200219205533.GG37550@xz-x1>
References: <20200219161725.115218-1-david@redhat.com>
 <20200219161725.115218-8-david@redhat.com>
 <20200219204730.GB37550@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20200219204730.GB37550@xz-x1>
X-MC-Unique: rExcnrSvPM2KAapImLxS2g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 19, 2020 at 03:47:30PM -0500, Peter Xu wrote:
> On Wed, Feb 19, 2020 at 05:17:19PM +0100, David Hildenbrand wrote:
> > It's always the same value.
>=20
> I guess not, because...
>=20
> >=20
> > Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > Cc: Juan Quintela <quintela@redhat.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  migration/ram.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/migration/ram.c b/migration/ram.c
> > index cbd54947fb..75014717f6 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -3119,7 +3119,6 @@ static int ram_load_postcopy(QEMUFile *f)
> >          ram_addr_t addr;
> >          void *host =3D NULL;
> >          void *page_buffer =3D NULL;
> > -        void *place_source =3D NULL;
> >          RAMBlock *block =3D NULL;
> >          uint8_t ch;
> >          int len;
> > @@ -3188,7 +3187,6 @@ static int ram_load_postcopy(QEMUFile *f)
> >                  place_needed =3D true;
> >                  target_pages =3D 0;
> >              }
> > -            place_source =3D postcopy_host_page;
> >          }
> > =20
> >          switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
> > @@ -3220,7 +3218,7 @@ static int ram_load_postcopy(QEMUFile *f)
> >                   * buffer to make sure the buffer is valid when
> >                   * placing the page.
> >                   */
> > -                qemu_get_buffer_in_place(f, (uint8_t **)&place_source,
>=20
> ... it can be modified inside the call.
>=20
> I feel like this patch could even fail the QEMU unit test.  It would
> be good to mention what tests have been carried out in the cover
> letter or with RFC tag if no test is done yet.
>=20
> For a series like this, I'll try at least the unit tests and smoke on
> both precopy and postcopy.  The resizing test would be even better but
> seems untrivial, so maybe optional.

For resizing test, an easy way (I can think of) is to temporarily
remove the size check below in your test branch:

diff --git a/exec.c b/exec.c
index 8e9cc3b47c..17dc660281 100644
--- a/exec.c
+++ b/exec.c
@@ -2128,10 +2128,6 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t news=
ize, Error **errp)
=20
     newsize =3D HOST_PAGE_ALIGN(newsize);
=20
-    if (block->used_length =3D=3D newsize) {
-        return 0;
-    }
-
     if (!(block->flags & RAM_RESIZEABLE)) {
         error_setg_errno(errp, EINVAL,
                          "Length mismatch: %s: 0x" RAM_ADDR_FMT

Then reboot the guest during migration to see whether precopy can be
cancelled smoothly. And same to postcopy.  Thanks,

--=20
Peter Xu


