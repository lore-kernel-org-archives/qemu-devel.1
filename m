Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA33C35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA74206EF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/RqTYRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA74206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Aba-0003bM-Kn
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 10:52:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j5AaZ-00039W-R2
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j5AaY-0007Ms-1c
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:51:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31010
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j5AaX-0007KA-Te
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582300297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M425/NvPxR7SuzQbKlRFUt1hl97UAVY8Ynvoe9wvVeU=;
 b=i/RqTYRJTV5ejLSw2UvZC2B5H1eMAEMKSeu9Nf4FEranZG6CZRji7Texz9Uhu5TOzCAXav
 NClB+E5yZpadSgLQ2+cLMAnV2silvP5IM/18quNiMwxAOj635ey+qYFeiBIbMP6nYbcIEK
 MJViGeR56hBN2WSiuRhCBXPCZtQtH9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-gVDs0QNrNcewnKbC_rhOpw-1; Fri, 21 Feb 2020 10:51:35 -0500
X-MC-Unique: gVDs0QNrNcewnKbC_rhOpw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71162106BC24;
 Fri, 21 Feb 2020 15:51:34 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D39287B08;
 Fri, 21 Feb 2020 15:51:16 +0000 (UTC)
Date: Fri, 21 Feb 2020 15:51:13 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 06/13] migrate/ram: Discard new RAM when growing RAM
 blocks and the VM is stopped
Message-ID: <20200221155113.GH2931@work-vm>
References: <20200219161725.115218-1-david@redhat.com>
 <20200219161725.115218-7-david@redhat.com>
 <85682e4d-956f-080d-7c22-bcb292e67adf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <85682e4d-956f-080d-7c22-bcb292e67adf@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
> On 19.02.20 17:17, David Hildenbrand wrote:
> > In case we grow our RAM after ram_postcopy_incoming_init() (e.g., when
> > synchronizing the RAM block state with the migration source), the resiz=
ed
> > part would not get discarded. Let's perform that when being notified
> > about a resize while postcopy has been advised and the guest is not
> > running yet.
> >=20
> > Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > Cc: Juan Quintela <quintela@redhat.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  migration/ram.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >=20
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 57f32011a3..cbd54947fb 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -3722,6 +3722,25 @@ static void ram_mig_ram_block_resized(RAMBlockNo=
tifier *n, void *host,
> >          return;
> >      }
> > =20
> > +    /*
> > +     * Especially at the start of precopy on the migration target, bef=
ore
> > +     * starting postcopy, we synchronize the RAM block sizes. Let's ma=
ke sure
> > +     * that any resizes before starting the guest are properly handled=
 by
> > +     * postcopy. Note: All other postcopy handling (e.g., registering =
handlers,
> > +     * disabling THP) happens after all resizes (e.g., during precopy)=
 were
> > +     * performed.
> > +     */
>=20
> I think it would be clearer to do a
>=20
> ps >=3D POSTCOPY_INCOMING_ADVISE && ps < POSTCOPY_INCOMING_RUNNING
>=20
> We really only want to do something when psotcopy has been advised but
> the guest is not running yet.
>=20
> Will look into that as I find ways to actually test this :)

Should that be < POSTCOPY_INCOMING_LISTENING - i.e. before the
userfaultfd has been enabled on the region?

Dave

>=20
> --=20
> Thanks,
>=20
> David / dhildenb
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


