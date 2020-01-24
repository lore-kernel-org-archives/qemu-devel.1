Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B82C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 13:47:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D680F2075D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 13:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uw9U4ISS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D680F2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuzJL-0006zx-2y
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 08:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iuzII-00061g-46
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:46:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iuzIH-0005Si-3P
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:46:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56838
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iuzIH-0005SK-0D
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:46:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579873600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hm3o479UYkAMANigifiw3evQYlEHzMDnxJwVp76ifTE=;
 b=Uw9U4ISSqRhqC3QmhEXcKADlBvLi2S7ph8qxasxAFuAqZumpfzdeo20HEpsf54EnBX6cgh
 b7Y4vX+zvi2PYiwgYDbZegD7fkhvxWvJk+PAwVG+EX7ysbNh1pX6I36KIVyJcNjw8cRGd+
 jdyRtOLg4GE/FF4iyT4tqCNaCOCRJzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-bCfadPDsMxGrkW11kkT3_w-1; Fri, 24 Jan 2020 08:46:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3399800D4C
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 13:46:35 +0000 (UTC)
Received: from work-vm (ovpn-117-253.ams2.redhat.com [10.36.117.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CF3386457;
 Fri, 24 Jan 2020 13:46:33 +0000 (UTC)
Date: Fri, 24 Jan 2020 13:46:31 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 18/21] migration: Make no compression operations into
 its own structure
Message-ID: <20200124134631.GT2970@work-vm>
References: <20200123115831.36842-1-quintela@redhat.com>
 <20200123115831.36842-19-quintela@redhat.com>
 <20200124124729.GO2970@work-vm> <87eevp3rev.fsf@secure.laptop>
MIME-Version: 1.0
In-Reply-To: <87eevp3rev.fsf@secure.laptop>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: bCfadPDsMxGrkW11kkT3_w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > * Juan Quintela (quintela@redhat.com) wrote:
> >> It will be used later.
> >>=20
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >>=20
>=20
> >> +int migrate_multifd_method(void)
> >> +{
> >> +    MigrationState *s;
> >> +
> >> +    s =3D migrate_get_current();
> >> +
> >> +    return s->parameters.multifd_compress;
> >> +}
> >
> > Shouldn't that be a MultifdCompress enum returned?
>=20
> You are right here.
> >> =20
> >>  #define MULTIFD_FLAG_SYNC (1 << 0)
> >> +#define MULTIFD_FLAG_NOCOMP (1 << 1)
> >
> > I don't think this should be a set of individual flags; in later patche=
s
> > you define a flag for zlib and another for zstd etc etc - but you can't
> > combine them - you could never have FLAG_NOCOMP|FLAG_ZSTD|FLAG_ZLIB - s=
o
> > this should be a 3 or 4 bit field which contains a compression id (0
> > being none).  The ID can't exactly be the migrate_multifd_method() enum
> > value - because I don't think that's defined to be stable (?).
>=20
> The idea is to catch up if we got an incorrect packet with an incorrect
> flag.
>=20
> But yes, I agree that it could be the same expecting a value here.
> The problem is that I already have the flags field.
>=20
> Would it be ok for you if I reserve 3 bits for this?  (right now 2
> should be enough).

Yeh that's fine - I was going to suggest 4 bits, but 3 is OK;
just define something like:

  MULTIFD_FLAG_COMP_MASK (7 << 1)

Dave

> Thanks, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


