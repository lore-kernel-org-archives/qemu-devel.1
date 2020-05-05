Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B84C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C433E20757
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKCmdIgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C433E20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVzRk-000800-Tg
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 11:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jVzQX-0006fH-1A
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:24:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21070
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jVzQV-0002z5-3C
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588692246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hPn4MP5HmKbDf7sMVTKc6HbXiUeKBL+QQYJ1TxKaZu8=;
 b=fKCmdIgcc2Bos3KWyjvjbrU8saiSO+LQZwpfnCkH1+VvcpasBaPZXanG9tyqKW7Z1cZHVB
 f2H9MxQNWJ/aLmbKgqj4GSgHHv3HpKDveF99TYklg0PpyE2Zn5U9iOZFAqp15h+iSjI2M5
 NgrCWN1FXtJz4XjVSXW4ac3MBKfZ3w0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-wgDZ1r9RNYW1Q_kgSr2Kgg-1; Tue, 05 May 2020 11:24:02 -0400
X-MC-Unique: wgDZ1r9RNYW1Q_kgSr2Kgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19D5B19057A0;
 Tue,  5 May 2020 15:24:01 +0000 (UTC)
Received: from localhost (ovpn-113-143.ams2.redhat.com [10.36.113.143])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F7F299E1;
 Tue,  5 May 2020 15:24:00 +0000 (UTC)
Date: Tue, 5 May 2020 16:23:59 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH] virtiofsd: Use clone() and not unshare(), support non-root
Message-ID: <20200505152359.GG381978@stefanha-x1.localdomain>
References: <348d4774-bd5f-4832-bd7e-a21491fdac8d@www.fastmail.com>
 <CAJ+F1CJsBRp+9yf=kGZt18APXskO8NWyQ1YEqauLYhiNmcW39Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJsBRp+9yf=kGZt18APXskO8NWyQ1YEqauLYhiNmcW39Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zGQnqpIoxlsbsOfg"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: QEMU <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Colin Walters <walters@verbum.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--zGQnqpIoxlsbsOfg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2020 at 04:07:22PM +0200, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Fri, May 1, 2020 at 8:29 PM Colin Walters <walters@verbum.org> wrote:
> >
> > I'd like to make use of virtiofs as part of our tooling in
> > https://github.com/coreos/coreos-assembler
> > Most of the code runs as non-root today; qemu also runs as non-root.
> > We use 9p right now.
> >
> > virtiofsd's builtin sandboxing effectively assumes it runs as
> > root.
> >
> > First, change the code to use `clone()` and not `unshare()+fork()`.
> >
> > Next, automatically use `CLONE_NEWUSER` if we're running as non root.
> >
> > This is similar logic to that in https://github.com/containers/bubblewr=
ap
> > (Which...BTW, it could make sense for virtiofs to depend on bubblewrap
> >  and re-exec itself rather than re-implementing the containerization
> >  itself)
> >
>=20
> Now that systemd-nspawn works without privileges, isn't that also a
> solution? One that would fit both system and session level
> permissions, and integration with other services?

Does systemd-nspawn work inside containers?

I think virtiofsd will need to run inside containers in the future and
remember systemd being difficult to use in containers.

Stefan

--zGQnqpIoxlsbsOfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6xhQ4ACgkQnKSrs4Gr
c8j4Bwf/cguAhRepyDWOHZBjwEPLOSZaPoR6hLT2Mf4kXFnl8k3lcJfaGvgyH4Uq
ufImOPzxgxC3bYXE7soV3ir+JJSQ8wXHFHU1jmw9X8wxwBDlaEEzn4EL9Ide5hGS
jJS43apJnX6hEVn7Vz8NXf00WnIjPdBPEAVL7SeME6sRdE/6LBEgwLIOeaVVaEhI
hjgcpxSbH/RuhlqcY8gdIawkvXhP0HGy5SWJ1Xmx2WTT2ku7d8PkX+KDMCZxoIXf
d400Iqw1kyzwsZlVdbg8kcrtaYUBkOl8wxmDEPc7vN0S2X53ITALIZlMHujJ6e5y
SbLYwy5vM6ajyBRXFviU3u1fZyj0gQ==
=ujxy
-----END PGP SIGNATURE-----

--zGQnqpIoxlsbsOfg--


