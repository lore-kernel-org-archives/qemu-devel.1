Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF9AC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 15:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5FB8222D0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 15:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fb4umIFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FB8222D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUubp-0000Jc-Mc
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 10:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iUub4-0008E8-By
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iUub2-0003S6-1k
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:30:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35675
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iUub1-0003Re-TE
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573659014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d2pwvEcjQ8rpUv0vSemqBseZmqO3YkEmmjAK9P5nESY=;
 b=fb4umIFCYfaBCdwfZgdAb9hX7vq64sWEFSvM9BUwa8H08uOx04WevbZpuD59LE4BZr+E8z
 1PNKbI8OH8s6PCSkRGNfDleDLhvKHO3BZCBVUcJbZg6ZwcoUCiaqLcm9wYwpcwTqxKGQEB
 MYVNiBWN5H5QUyU1Su9WUBZQGmJ1vjM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-l2V1BVagN2mg4_oSkdBKIg-1; Wed, 13 Nov 2019 10:30:13 -0500
X-MC-Unique: l2V1BVagN2mg4_oSkdBKIg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6C99803CE0;
 Wed, 13 Nov 2019 15:30:11 +0000 (UTC)
Received: from localhost (ovpn-117-166.ams2.redhat.com [10.36.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B8C46293B;
 Wed, 13 Nov 2019 15:30:07 +0000 (UTC)
Date: Wed, 13 Nov 2019 15:30:06 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 02/49] multi-process: util: Add
 qemu_thread_cancel() to cancel running thread
Message-ID: <20191113153006.GA563983@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <e821aa9bccb49bf68c94e3d49b105c420dde9981.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <e821aa9bccb49bf68c94e3d49b105c420dde9981.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, thuth@redhat.com,
 john.g.johnson@oracle.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 quintela@redhat.com, berrange@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, ross.lagerwall@citrix.com,
 kanth.ghatraju@oracle.com, kraxel@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, liran.alon@oracle.com, marcandre.lureau@gmail.com,
 mreitz@redhat.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 05:08:43AM -0400, Jagannathan Raman wrote:
> qemu_thread_cancel() added to destroy a given running thread.
> This will be needed in the following patches.
>=20
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  include/qemu/thread.h    |  1 +
>  util/qemu-thread-posix.c | 10 ++++++++++
>  2 files changed, 11 insertions(+)

Is this still needed?  I thought previous discussion concluded that
thread cancellation is hard to get right and it's not actually used by
this series?

Stefan

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3MIX4ACgkQnKSrs4Gr
c8gYFAgAn+JuUbBhCvAha0GL8dpCMJv5c5NqEjKNQKrmxH9MRywtJG0EuYVDl4zz
NYOdqV0kZZA9OQ3btXZAX9f44U51Dd+1cSvA5kNyKEDKtjSXDcpEpJ0bNRKT0jOo
owiEiV1/E0EvLhR464MK3apnWKpmZNts+UYcKmqZNK26XVxnLQLohkNdiQIK7BC3
UI+CjHg39Z24leG6cxxHvy8DeVuntzYsGMBMTSrPS8jlE/pxXLlR6KfPZUjtfsSw
ktFbOH4qUoVKPR5MaiHTJknJQ9y85xXsLkgljbV04FxvojKB2av7UXnXBMSUyZDa
a3vOXOjs6qWBShTNoo8S+xUtwYaexg==
=jBc1
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--


