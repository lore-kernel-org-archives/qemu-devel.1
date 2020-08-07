Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404E0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B06820748
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKJq0h8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B06820748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3zEG-0005xZ-8S
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3zDP-0004i1-6K
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:03:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48046)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3zDN-0006VY-CI
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596794584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j82icMJ2OvRFDTnmz4MsqW37bH9aOeXXyGXwpc+6dJE=;
 b=dKJq0h8Z2YH+DvnDDHi+DJgER1NPXgdFmJiWXcdoXLrzT1Lg8z2TTgNYMXwa4b9kx7syAR
 Oe4/2k2Hy/5UmTeNnNJyhYtiky2i+FQHYThXG46CjHAHvljUYymkUyg0JuIkibsHitwA93
 c+CFG3pNG7ek4Jh1lHoQOEE7Rino0WE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-16t5tn7NPFKkc0GgWyFnfg-1; Fri, 07 Aug 2020 06:03:02 -0400
X-MC-Unique: 16t5tn7NPFKkc0GgWyFnfg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 669AE1005504;
 Fri,  7 Aug 2020 10:03:01 +0000 (UTC)
Received: from localhost (ovpn-114-16.ams2.redhat.com [10.36.114.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB7EB108AA;
 Fri,  7 Aug 2020 10:02:57 +0000 (UTC)
Date: Fri, 7 Aug 2020 11:02:56 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.2] exec: Remove MemoryRegion::global_locking field
Message-ID: <20200807100256.GC600298@stefanha-x1.localdomain>
References: <20200806150726.962-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200806150726.962-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 05:20:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2020 at 05:07:26PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Last uses of memory_region_clear_global_locking() have been
> removed in commit 7070e085d4 ("acpi: mark PMTIMER as unlocked")
> and commit 08565552f7 ("cputlb: Move NOTDIRTY handling from I/O
> path to TLB path").
> Remove memory_region_clear_global_locking() and the now unused
> 'global_locking' field in MemoryRegion.
>=20
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  include/exec/memory.h | 14 --------------
>  accel/tcg/cputlb.c    |  4 ++--
>  exec.c                |  2 +-
>  softmmu/memory.c      |  6 ------
>  4 files changed, 3 insertions(+), 23 deletions(-)

It can be added back in later, if necessary. For now let's drop the dead
code.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8tJtAACgkQnKSrs4Gr
c8g9OAgAqqNaIXh48FbFo8ns2CsE36Up9Hxa+21BVjTw5DC8FKU942NCb+/8aaMS
ZEBzDcD83miVLG0mzym1EjWeQwJtse/kIJ2x1KzRoRFnyOYoxd5AALBLUyXieBvl
FaHUx0F6AeFdeaTwdz5frfoiEiEIT55TbpXtw10Q+NrDfP/A13sev2gSBp+8JObM
qWW933PprUvKJ53kJACH52m+q1muvqzf8y1/hhW4daCgi6H2oXJSL8UV1y5pMeHc
+9OJRwQuDfAhWkghp2zf6OGjmbTzCdypF3/uPeIwMidIAyXYKX/ouTi/9J7EK6bt
o1KNxt0hiiLXj5vZqE7sUTDsw6OctQ==
=xTXE
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--


