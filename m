Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6B9C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 14:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8C3206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 14:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxwXdvr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8C3206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLSuE-0003a3-8O
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 10:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jLStH-0002lb-FN
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 10:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jLStG-0008Bs-42
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 10:38:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48250
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jLStF-0008Be-S8
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 10:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586183897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oy39NN0utVzravPInMFONwgETsJK5vB0fRw1ogt181M=;
 b=WxwXdvr9fIYnNz7HZ645G+b4BpWPkeH8hr49Fv8bl/y/Z34p6RqRh5fTiJlSokikgePs6p
 yR66E7LlLT+G+uR12cp69sd+8WvParMu/2KI4/Zo46/4SrsK0xxXRB9Es/m54BnuhhIib+
 lnJ8JKEUuaZjxnIkY7oqR1BclWTgn9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-GgnNLSlaNge5vssuq6i68Q-1; Mon, 06 Apr 2020 10:38:14 -0400
X-MC-Unique: GgnNLSlaNge5vssuq6i68Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB3B813F7;
 Mon,  6 Apr 2020 14:38:13 +0000 (UTC)
Received: from localhost (ovpn-116-201.gru2.redhat.com [10.97.116.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED7C160BE0;
 Mon,  6 Apr 2020 14:38:12 +0000 (UTC)
Date: Mon, 6 Apr 2020 11:38:10 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Questionable aspects of QEMU Error's design
Message-ID: <20200406143810.GF299832@habkost.net>
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <87blo7heag.fsf@dusky.pond.sub.org>
 <87sghjfre8.fsf@dusky.pond.sub.org>
 <20200406140531.GE299832@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20200406140531.GE299832@habkost.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 06, 2020 at 11:05:36AM -0300, Eduardo Habkost wrote:
> On Sat, Apr 04, 2020 at 12:59:27PM +0200, Markus Armbruster wrote:
[...]
> > Paolo, Daniel, Eduardo,
> >=20
> > Please pick one for QOM:
>=20
> Replying this without reading the whole discussion and context:
>=20
> >=20
> > * Do nothing.  Looks like
> >=20
> >      object_property_set_bool(..., &err);
> >      if (err) {
> >          error_propagate(errp, err);
> >          return;
> >      }
> >=20
> > * Return true on success, false on error.  Looks like
> >=20
>=20
> I prefer this one.

My weird quoting choice was probably confusing, so for the sake
of clarity: I prefer the "Return true on success, false on error"
option.

>=20
> >      if (!object_property_set_bool(..., errp)) {
> >          return;
> >      }
> >=20
> > * Return 0 on success, -1 on error.  Looks like
> >=20
> >      if (object_property_set_bool(..., errp) < 0) {
> >          return;
> >      }
> >=20
> >   This is slightly more likely to require line wrapping than the
> >   previous one.
>=20
> --=20
> Eduardo

--=20
Eduardo


