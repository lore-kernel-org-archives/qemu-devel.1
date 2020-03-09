Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A9EC10F29
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:38:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 131D9208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZOjj4r/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131D9208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBLPr-0000b3-8o
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 12:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jBLP0-00087i-Fu
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jBLOz-0003WL-GW
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:37:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22953
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jBLOz-0003W2-CO
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583771832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mvjBMxUVEOtbEs9CFdXl72orXnBKwQ9Q4ke9ZDtmjB8=;
 b=ZOjj4r/OXb59UxddD6omjUJOVSA1WAlHFm7vwBEXAbsfrkFevf2E+lOeEN7fG4qUL98Ood
 5Bl+eCGqHt/A4hlwliDCt1b7wiMVV8s9IhHoV+ShBWk54WKIRo9vIwU5iwdjjox5gycnkR
 VVXwD6XQKtfKLmnSEMdi7bUXro9MFXc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-Yp94qDBCOCGrA0pQYOfIEg-1; Mon, 09 Mar 2020 12:37:10 -0400
X-MC-Unique: Yp94qDBCOCGrA0pQYOfIEg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E13E8024DD;
 Mon,  9 Mar 2020 16:37:09 +0000 (UTC)
Received: from localhost (unknown [10.36.118.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3F0C90A00;
 Mon,  9 Mar 2020 16:37:08 +0000 (UTC)
Date: Mon, 9 Mar 2020 16:37:07 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 7/7] aio-posix: remove idle poll handlers to improve
 scalability
Message-ID: <20200309163707.GC46227@stefanha-x1.localdomain>
References: <20200305170806.1313245-1-stefanha@redhat.com>
 <20200305170806.1313245-8-stefanha@redhat.com>
 <58ce9251-77ba-9db2-b1c1-fd97cd175e9a@redhat.com>
 <20200306135036.GP1335569@stefanha-x1.localdomain>
 <56306d86-cd1b-07b6-f538-7cfbcb6b5ab1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <56306d86-cd1b-07b6-f538-7cfbcb6b5ab1@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2020 at 03:17:40PM +0100, Paolo Bonzini wrote:
> On 06/03/20 14:50, Stefan Hajnoczi wrote:
> >> Not sure I understand the "almost" part.  If it's accessed only from
> >> aio_poll() it is protected via either AIO_WAIT_WHILE or the BQL, not b=
y
> >> ctx->list_lock; if it's protected by ctx->list_lock (using
> >> qemu_lockcnt_inc in readers), it is an RCU list.
> > aio_remove_fd_handler() removes nodes from the list during
> > aio_set_fd_handler(), but only while holding ctx->list_lock and the
> > count is zero (no readers).
> >=20
> > All other access is done from with ctx->list_lock incremented.  This
> > code needs to be reentrant in case of nested aio_poll() but nothing els=
e
> > will access the list at the same time.
>=20
> Oh, I see, adds are only done under ctx->list_lock and those are the
> part that need the write barriers in the RCU iterators.

I'll update the comment when merging this series.

Stefan

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5mcLMACgkQnKSrs4Gr
c8hJQQgAoF1g/XuS3re0q4P03VCE9cnGkQhH4PJKuD1smJ5aoO3F0WwSN9zUNHsY
DNEFy1gvait8JUx0WQNWd1lUYDltQVNKbFz5QQGoS8Zsm0RduI0RqllYNGS+6imu
b35nJT1YTHvEYY/NtP+Wj4vbW00QKl5Zaajh7lPwzmjmnbHJqgf/5+JD/OhnE6LM
1FG32l6ZbnYa3VP2syJKBpJZeMGdz4el/foQeK6QVXz9vAse/ZZ9sNZDhiF29RId
CkDTAGjodLvXu7pWqSkl5d9I3v2/OSCeFhEh2uVwYn5ATHy58VmSWqX6o3WMiOlb
N2wwIiaycjwBQ5IN+8v3JVWLkOufRg==
=55I2
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--


