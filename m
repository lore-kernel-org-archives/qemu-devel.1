Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28823C11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 19:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED08F2467A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 19:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7t0zvv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED08F2467A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4r3T-0006cl-4X
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 14:00:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j4r2o-0005s4-0z
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 13:59:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j4r2m-0002O6-My
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 13:59:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36814
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j4r2m-0002Nn-In
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 13:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582225168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ObHJuCnXM6kiOAPAFICQRBS8Kmm/lIzLPfJKFvSmLwU=;
 b=W7t0zvv0ukF3oGiZMljMSljwC8vZ0ULEVROYmv6XJ1zQA4gBk6R6jfLBsvgeQ17PglILCe
 EMc+EvN+aKAUuICmLK80gyFeg25sgO4eSNouE+zBLQqOrfuHn4MJpL+0YrEt858Pklv2WO
 Id9m2CNJdgaoGV+ZH9FBZ1d7iokEWlw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-OLWWdSBgNQSp2h2-jvuBYg-1; Thu, 20 Feb 2020 13:58:44 -0500
X-MC-Unique: OLWWdSBgNQSp2h2-jvuBYg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52613A1F4B;
 Thu, 20 Feb 2020 18:58:43 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 021D55C1D8;
 Thu, 20 Feb 2020 18:58:29 +0000 (UTC)
Date: Thu, 20 Feb 2020 18:58:27 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 07/13] migrate/ram: Get rid of "place_source" in
 ram_load_postcopy()
Message-ID: <20200220185827.GH2836@work-vm>
References: <20200219204730.GB37550@xz-x1>
 <5DD859C1-9FF5-4488-8928-43B83D8AD677@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5DD859C1-9FF5-4488-8928-43B83D8AD677@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
>=20
>=20
> > Am 19.02.2020 um 21:47 schrieb Peter Xu <peterx@redhat.com>:
> >=20
> > =EF=BB=BFOn Wed, Feb 19, 2020 at 05:17:19PM +0100, David Hildenbrand wr=
ote:
> >> It's always the same value.
> >=20
> > I guess not, because...
> >=20
> >>=20
> >> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >> Cc: Juan Quintela <quintela@redhat.com>
> >> Cc: Peter Xu <peterx@redhat.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >> migration/ram.c | 8 +++-----
> >> 1 file changed, 3 insertions(+), 5 deletions(-)
> >>=20
> >> diff --git a/migration/ram.c b/migration/ram.c
> >> index cbd54947fb..75014717f6 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -3119,7 +3119,6 @@ static int ram_load_postcopy(QEMUFile *f)
> >>         ram_addr_t addr;
> >>         void *host =3D NULL;
> >>         void *page_buffer =3D NULL;
> >> -        void *place_source =3D NULL;
> >>         RAMBlock *block =3D NULL;
> >>         uint8_t ch;
> >>         int len;
> >> @@ -3188,7 +3187,6 @@ static int ram_load_postcopy(QEMUFile *f)
> >>                 place_needed =3D true;
> >>                 target_pages =3D 0;
> >>             }
> >> -            place_source =3D postcopy_host_page;
> >>         }
> >>=20
> >>         switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
> >> @@ -3220,7 +3218,7 @@ static int ram_load_postcopy(QEMUFile *f)
> >>                  * buffer to make sure the buffer is valid when
> >>                  * placing the page.
> >>                  */
> >> -                qemu_get_buffer_in_place(f, (uint8_t **)&place_source=
,
> >=20
> > ... it can be modified inside the call.
>=20
> Very right, will drop this patch! Thanks!
>=20
> >=20
> > I feel like this patch could even fail the QEMU unit test.  It would
> > be good to mention what tests have been carried out in the cover
> > letter or with RFC tag if no test is done yet.
>=20
> I test all code I share. This survives =E2=80=9Emake check=E2=80=9C. I as=
sume all tests send small pages where =E2=80=9Ematches_target_page_size=3D=
=3Dtrue=E2=80=9C, so the tests did not catch this.
>=20
> I even spent the last day getting avocado-vt to work and ran multiple (ob=
viously not all) migration tests, including postcopy, so your suggestions h=
ave already been considered ...

A test on Power or aarch might catch this one; where they normally
have larger pages.

Dave

> Could have mentioned that in the cover letter, yes.
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


