Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BFEC2D0EE
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE50C20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e311T6e9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE50C20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIul-0007rO-Sc
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jJItB-0006kG-LO
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:33:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jJItA-0004uv-3j
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:33:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20256
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jJIt9-0004ud-Vo
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585668795;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2bT+PdBMeeFyChBlPBDZbdy+qfzRGo8MXZMs0GdfE8o=;
 b=e311T6e9hiP70YdfjqYQ2Cubl9n3smvviJ/SAl4Rm87LeMPa3P1iXWIZ+RnI/QmFCAoLAs
 dc2IwIiYd/b5TDhFbserOFgnWqgRfpWKtXf9dRw2C6PhIYaqCtqeL/r1yVUVbS9HrPn85z
 4JxmfrgkKDqjmP3tnhBdL60uVN0q65M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-tifJu5CTMmC4FiK80uSPwQ-1; Tue, 31 Mar 2020 11:33:13 -0400
X-MC-Unique: tifJu5CTMmC4FiK80uSPwQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E94218A6EC6;
 Tue, 31 Mar 2020 15:33:12 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 39C6219C58;
 Tue, 31 Mar 2020 15:33:09 +0000 (UTC)
Date: Tue, 31 Mar 2020 16:33:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 1/3] crypto: Add qcrypto_tls_shutdown()
Message-ID: <20200331153306.GM353752@redhat.com>
References: <20200327161936.2225989-1-eblake@redhat.com>
 <20200327161936.2225989-2-eblake@redhat.com>
 <87ftdp3ozl.fsf@dusky.pond.sub.org>
 <9491a050-e873-dcf0-8fa0-6f4316bcf06a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9491a050-e873-dcf0-8fa0-6f4316bcf06a@redhat.com>
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 31, 2020 at 10:17:49AM -0500, Eric Blake wrote:
> On 3/31/20 3:30 AM, Markus Armbruster wrote:
> > Eric Blake <eblake@redhat.com> writes:
> >=20
> > > Gnutls documents that applications that want to distinguish between a
> > > clean end-of-communication and a malicious client abruptly tearing th=
e
> > > underlying transport out of under our feet need to use gnutls_bye().
> > > Our channel code is already set up to allow shutdown requests, but we
> > > weren't forwarding those to gnutls.  To make that work, we first need
> > > a new entry point that can isolate the rest of our code from the
> > > gnutls interface.
> > >=20
>=20
> > > +int qcrypto_tls_session_shutdown(QCryptoTLSSession *session,
> > > +                                 QCryptoShutdownMode how)
>=20
> >=20
> > This is a thin wrapper around gnutls_bye().  I understand this is an
> > abstraction layer backed by GnuTLS.  Not sure abstracting from just one
> > concrete thing is a good idea, but that's way out of scope here.
>=20
> If we ever add an alternative TLS implementation to gnutls, then the
> abstraction is useful.  But I'm not sure how likely that is, so maybe Dan
> has more insight why he chose this design originally.

The abstraction serves several purposes.

First, it means that we don't need #ifdefs wrt GNUTLS in every piece of
QEMU code that involves TLS. They are isolated in the crypto/ code only.

Related to that, it means that anything that touches GNUTLS APIs directly
gets funnelled via the crypto maintainer for review.

It is easy to mis-use many of the GNUTLS APIs, and so the abstraction
serves to apply/enforce a more desirable usage policy on the rest of
the QEMU code, making it harder to screw up TLS.

Much of this is based on learning from libvirt code where the usage of
GNUTLS was not nearly so well encapsulated and increased burden.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


