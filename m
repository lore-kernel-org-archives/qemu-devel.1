Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EEEC5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EBF8218AE
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQQ4EYxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBF8218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSduR-0006jB-Ej
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 04:16:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iSdrv-0005Sg-4J
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iSdrr-0006mm-R6
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:14:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36545
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iSdrr-0006iQ-Lw
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573118055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1f26My9x+IY4dvhGRFviTHsILdG511FzibDW2upUm0U=;
 b=gQQ4EYxf2o3xKis+P56eLTK9mePNGP/jjRI78Ew183n/tv8PStq79zIxeHTt78MVtzbf0A
 RBFkm6eBHscPbRdAWqhxY0Q/0NBbQ1sTUrqcgu0l3XIfn+EoeVuWpwVGVM+wB61eBUDCwv
 HGwRlbTVSH07gjKtcTVdbmmjq4SY62k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-xFAcQc8aPF-QJqajojE4kg-1; Thu, 07 Nov 2019 04:14:11 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E1CB1005500;
 Thu,  7 Nov 2019 09:14:11 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 919276315E;
 Thu,  7 Nov 2019 09:14:07 +0000 (UTC)
Date: Thu, 7 Nov 2019 09:14:05 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 5/6] migration/postcopy: enable random order target page
 arrival
Message-ID: <20191107091405.GA2816@work-vm>
References: <20191018004850.9888-1-richardw.yang@linux.intel.com>
 <20191018004850.9888-6-richardw.yang@linux.intel.com>
 <20191106200828.GL2802@work-vm> <20191107060010.GA13394@richard>
MIME-Version: 1.0
In-Reply-To: <20191107060010.GA13394@richard>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: xFAcQc8aPF-QJqajojE4kg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> On Wed, Nov 06, 2019 at 08:08:28PM +0000, Dr. David Alan Gilbert wrote:
> >* Wei Yang (richardw.yang@linux.intel.com) wrote:
> >> After using number of target page received to track one host page, we
> >> could have the capability to handle random order target page arrival i=
n
> >> one host page.
> >>=20
> >> This is a preparation for enabling compress during postcopy.
> >>=20
> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> ---
> >>  migration/ram.c | 16 +++-------------
> >>  1 file changed, 3 insertions(+), 13 deletions(-)
> >>=20
> >> diff --git a/migration/ram.c b/migration/ram.c
> >> index b5759793a9..da0596411c 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -4015,7 +4015,6 @@ static int ram_load_postcopy(QEMUFile *f)
> >>      MigrationIncomingState *mis =3D migration_incoming_get_current();
> >>      /* Temporary page that is later 'placed' */
> >>      void *postcopy_host_page =3D mis->postcopy_tmp_page;
> >> -    void *last_host =3D NULL;
> >>      bool all_zero =3D false;
> >>      int target_pages =3D 0;
> >> =20
> >> @@ -4062,24 +4061,15 @@ static int ram_load_postcopy(QEMUFile *f)
> >>               * that's moved into place later.
> >>               * The migration protocol uses,  possibly smaller, target=
-pages
> >>               * however the source ensures it always sends all the com=
ponents
> >> -             * of a host page in order.
> >> +             * of a host page in one chunk.
> >>               */
> >>              page_buffer =3D postcopy_host_page +
> >>                            ((uintptr_t)host & (block->page_size - 1));
> >>              /* If all TP are zero then we can optimise the place */
> >>              if (target_pages =3D=3D 1) {
> >>                  all_zero =3D true;
> >> -            } else {
> >> -                /* not the 1st TP within the HP */
> >> -                if (host !=3D (last_host + TARGET_PAGE_SIZE)) {
> >> -                    error_report("Non-sequential target page %p/%p",
> >> -                                  host, last_host);
> >> -                    ret =3D -EINVAL;
> >> -                    break;
> >> -                }
> >
> >I think this is losing more protection than needed.
> >I think you can still protect against a page from a different host-page
> >arriving until we've placed the current host-page.
> >So something like:
> >
> >    if (((uintptr_t)host & ~(block->page_size - 1)) !=3D
> >        last_host)
> >
>=20
> OK, looks reasonable.
>=20
> >and then set last_host to the start of the host page.
> >
>=20
> I think it is not necessary to update the last_host on each target page. =
We
> can just set it at the first target page.

Yes, that would be fine.

Dave

> >Then you'll check if that flush is really working.
> >
> >Dave
> >
> >>              }
> >> =20
> >> -
> >>              /*
> >>               * If it's the last part of a host page then we place the=
 host
> >>               * page
> >> @@ -4090,7 +4080,6 @@ static int ram_load_postcopy(QEMUFile *f)
> >>              }
> >>              place_source =3D postcopy_host_page;
> >>          }
> >> -        last_host =3D host;
> >> =20
> >>          switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
> >>          case RAM_SAVE_FLAG_ZERO:
> >> @@ -4143,7 +4132,8 @@ static int ram_load_postcopy(QEMUFile *f)
> >> =20
> >>          if (!ret && place_needed) {
> >>              /* This gets called at the last target page in the host p=
age */
> >> -            void *place_dest =3D host + TARGET_PAGE_SIZE - block->pag=
e_size;
> >> +            void *place_dest =3D (void *)QEMU_ALIGN_DOWN((unsigned lo=
ng)host,
> >> +                                                       block->page_si=
ze);
> >> =20
> >>              if (all_zero) {
> >>                  ret =3D postcopy_place_page_zero(mis, place_dest,
> >> --=20
> >> 2.17.1
> >>=20
> >--
> >Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
> --=20
> Wei Yang
> Help you, Help me
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


