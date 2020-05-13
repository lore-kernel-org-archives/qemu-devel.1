Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7982CCA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 08:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D9620740
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 08:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eq3ikkI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D9620740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYmxT-0006i0-Dv
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 04:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYmwj-0005rA-9j
 for qemu-devel@nongnu.org; Wed, 13 May 2020 04:40:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57828
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYmwi-00046b-BD
 for qemu-devel@nongnu.org; Wed, 13 May 2020 04:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589359255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IC8Ct49FIj6Hz19+FUw+E8tzmkb1jtO5sBnO6hnhFWI=;
 b=Eq3ikkI+zRTNn/bcAQTJlFOLllniYkzqBEEEykNJK84P4kaVG6TcIH8C1ENS1LDNFBKZqK
 P++2ukSBwHH/9IjGsS1Fcr6Q6dXIVIURuql/bPyxVS0kFIdp3SAIUf4ghvzu3Rih16OLlc
 OKTwQrqXZXx/9fe/bsEdhOa0muBT0a4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-BhFFAd1rOKSoDvGGOJFnHg-1; Wed, 13 May 2020 04:40:51 -0400
X-MC-Unique: BhFFAd1rOKSoDvGGOJFnHg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE1821005510;
 Wed, 13 May 2020 08:40:49 +0000 (UTC)
Received: from localhost (ovpn-114-64.ams2.redhat.com [10.36.114.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9009B6E6FA;
 Wed, 13 May 2020 08:40:43 +0000 (UTC)
Date: Wed, 13 May 2020 09:40:42 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel Berrange <berrange@redhat.com>
Subject: Re: [PATCH RESEND v6 01/36] memory: alloc RAM from file at offset
Message-ID: <20200513084042.GA317907@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <cb792b8d6f93d00c10790de8698c468b6ff4ab69.1587614626.git.elena.ufimtseva@oracle.com>
 <20200512084855.GC1191162@redhat.com>
 <B4DB4B9E-E7E3-4F1F-917C-898F9B150EFB@oracle.com>
MIME-Version: 1.0
In-Reply-To: <B4DB4B9E-E7E3-4F1F-917C-898F9B150EFB@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:17:42
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 swapnil.ingle@nutanix.com, john.g.johnson@oracle.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, Jag Raman <jag.raman@oracle.com>, quintela@redhat.com,
 mst@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2020 at 07:56:33AM -0400, Jag Raman wrote:
>=20
>=20
> > On May 12, 2020, at 4:48 AM, Daniel P. Berrang=E9 <berrange@redhat.com>=
 wrote:
> >=20
> > On Wed, Apr 22, 2020 at 09:13:36PM -0700, elena.ufimtseva@oracle.com wr=
ote:
> >> From: Jagannathan Raman <jag.raman@oracle.com>
> >>=20
> >> Allow RAM MemoryRegion to be created from an offset in a file, instead
> >> of allocating at offset of 0 by default. This is needed to synchronize
> >> RAM between QEMU & remote process.
> >=20
> > Can you elaborate on why remote processes require the RAM to be offset
> > from zero ?
>=20
> Hi Daniel,
>=20
> As it turns out, the RAM is scattered across the physical address space
> (system_memory) of QEMU. Therefore, the system memory is composed
> of multiple sections of RAM, and some sections start at a non-zero RAM
> offset.
>=20
> As a result, the remote process needs the ability to map these RAM
> sections into system_memory.

To explain a bit more, my understanding is that the offset is
specifically for mmap(2). As Jag alluded to, multiple sections can use a
single backing RAM file. These sections have different offsets in the
file.

Jag, maybe you can include a concrete explanation like the following in
the commit description:

Launch QEMU like this:

  qemu-system-x86_64 -mem-path /dev/shm -m 8G

There is only one RAM file descriptor:

  $ cat /proc/$(pidof qemu)/fd
  ...
  lrwx------. 1 stefanha stefanha 64 May 13 09:34 19 -> '/dev/shm/qemu_back=
_mem.pc.ram.7YAlqn (deleted)'

But the memory tree shows that single file is split into multiple ranges
of guest physical address space:

  (qemu) info mtree
  memory-region: system
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    0000000000000000-00000000bfffffff (prio 0, i/o): alias ram-below-4g @pc=
.ram 0000000000000000-00000000bfffffff
    ...
    0000000100000000-000000023fffffff (prio 0, i/o): alias ram-above-4g @pc=
.ram 00000000c0000000-00000001ffffffff

This means QEMU needs to send two regions to the remote device process.
They both mmap the same file but from different starting file offsets.

Stefan

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl67sokACgkQnKSrs4Gr
c8iKCgf9GCkvdbkRQV8Whl6BQbt2+9cQUGIPgqpIg74Q7V7OESbkQtMhraSYTqre
VOZrD7DL9UJNi4pjjgFXkSrnioc/3Icq4Nbyt/4p95mLCKiKca8qMfqu4A11sPcw
TsLaffFCaFLQwBF4jj+yZak+ul57GSQBZikZUKqyFhFMMv6Lcat/eXz28d5LjCRB
vbEARzs3/muMkLWufG25xFDQtd1GKhlu72fZ8VnGRFHEY9RtPMnIDQgwVRWlnrkD
BffdwYX+7KDVkEu9CFMw9l37v3dcwWt45SWOpKVosZYBRBhKSul9LiXdgLHk3VI0
2lJIxeg1blzgCTIBqluzufFpis7+sQ==
=0xLt
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--


