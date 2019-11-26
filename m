Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87588C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 11:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BAF02080F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 11:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6vwgugY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BAF02080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZZGv-0004sk-Dq
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 06:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iZZFL-0003kt-Tz
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 06:43:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iZZFJ-0005Ov-84
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 06:43:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60357
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iZZFJ-0005OQ-3w
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 06:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574768584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MK3lpALK8xuusH+LWJ+FowMelC34Y0B86ffzmTs9Pa8=;
 b=O6vwgugY0woWWLKqnJHtduz5QC+ejX/PGTlphri5MZXJEeekRJYHotPBkv+9ThU+nGkC9X
 G8BFi4UyIzFYTauLcyJq0BlilKKN8O61uZ/cI6erzmDl75QUi/ugwygKBjwYvZJVD1dVPO
 Vw/Y3cjn/g/CwpRomZpEzGEpfWBa0pE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-476iRzCWNHK5m3qY9ilLEg-1; Tue, 26 Nov 2019 06:43:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22F9F80183D;
 Tue, 26 Nov 2019 11:43:00 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D4F0B600C6;
 Tue, 26 Nov 2019 11:42:55 +0000 (UTC)
Date: Tue, 26 Nov 2019 11:42:53 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: virtiofsd: Where should it live?
Message-ID: <20191126114253.GD2928@work-vm>
References: <20191125185021.GB3767@work-vm>
 <CAJ+F1C+6kgO5kX=fYQno3g-YoxxqOyph+zanpDmFaOnOqirKYQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+6kgO5kX=fYQno3g-YoxxqOyph+zanpDmFaOnOqirKYQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 476iRzCWNHK5m3qY9ilLEg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, mszeredi@redhat.com,
 "Daniel P. Berrange" <berrange@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> Hi David
>=20
> On Mon, Nov 25, 2019 at 10:50 PM Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > Hi,
> >   There's been quite a bit of discussion about where virtiofsd, our
> > implemenation of a virtiofs daemon, should live.  I'd like to get
> > this settled now, because I'd like to tidy it up for the next
> > qemu cycle.
> >
> > For reference it's based on qemu's livhost-user+chunks of libfuse.
> > It can't live in libfuse because we change enough of the library
> > to break their ABI.  It's C, and we've got ~100 patches - which
> > we can split into about 3 chunks.
> >
> > Some suggestions so far:
> >   a) In contrib
> >      This is my current working assumption; the main objection is it's
> >      a bit big and pulls in a chunk of libfuse
> >
> >   b) In a submodule
> >
> >   c) Just separate
> >
> > Your suggestions/ideas please.  My preference is (a).
> >
>=20
>=20
> It's more about code sharing and lifecycle.
>=20
> The project started in a separate repository, and the proposed patches
> for qemu aren't a clean series. Reviewing it is harder than it should
> be, as we have to review/accept the whole thing.
>=20
> As you said, it doesn't share much with qemu, but libvhost-user (which
> we could quite easily copy or make standalone/submodule).
>=20
> Then it dumps code from libfuse that is questionnable (showing age)
> and often redundant with facilities provided by either glib, qemu
> utils etc.

The libfuse code is pretty much upto date.

> Is vhost-user-fs (the qemu device) going to have a strong relation
> with virtiofsd?
> Are we going to support different version of qemu and virtiofsd
> combination? I suppose we have to, as vhost-user protocol should allow
> that, and it's nice to allow other to experiment and implement it in
> different ways.
> If not, then perhaps we should think about introducing some version
> checking between qemu and external processes (with config_stamp,
> similar to modules).

It should support mismatched versions.
We do have at least two extensions over the base we're working on
(DAX and notification for blocking locks); I'd expect
the sets of these to be posted close together but not be required
to go in at the same time.

> From what I understand, I think c) would be fine. However, for
> convenience/testing reasons, b) would be my preference.

Dave

> --=20
> Marc-Andr=E9 Lureau
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


