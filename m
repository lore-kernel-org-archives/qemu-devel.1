Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF463C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504A420658
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HY/wqhHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504A420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL6Ky-0000VL-Dt
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 11:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL6JU-0007rr-1o
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:04:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20589)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL6JM-0001FA-Bf
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600873439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y8WYguwW5ImU2n/BOA5r6kCt3Qkw3FN+Ey1pXZQKUeI=;
 b=HY/wqhHVZyE6k0/d5cik+ILQDNZsSXPhUB7Z3zqiRMGmIb+mog60YhyhAf26aEu/orrAkh
 OaRdvfVLybTCvHcRdHa8JSo/Sij0dKdh1uhHXDvqU9Yidap7nmgaCgX7rok3s7EaBRCqf/
 oEM0szLRx805H3J85EAXJlWkQjM7MDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-BS8lagVQPfW6BAbDtUNC5A-1; Wed, 23 Sep 2020 11:03:54 -0400
X-MC-Unique: BS8lagVQPfW6BAbDtUNC5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D282E1007472;
 Wed, 23 Sep 2020 15:03:52 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D20497368F;
 Wed, 23 Sep 2020 15:03:46 +0000 (UTC)
Date: Wed, 23 Sep 2020 16:03:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v9 10/20] multi-process: setup memory manager for remote
 device
Message-ID: <20200923150345.GE62770@stefanha-x1.localdomain>
References: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
 <20200827181231.22778-11-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200827181231.22778-11-elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2020 at 11:12:21AM -0700, elena.ufimtseva@oracle.com wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
>=20
> SyncSysMemMsg message format is defined. It is used to send
> file descriptors of the RAM regions to remote device.
> RAM on the remote device is configured with a set of file descriptors.
> Old RAM regions are deleted and new regions, each with an fd, is
> added to the RAM.
>=20
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  MAINTAINERS                     |  2 ++
>  hw/i386/meson.build             |  1 +
>  hw/i386/remote-memory.c         | 58 +++++++++++++++++++++++++++++++++
>  include/hw/i386/remote-memory.h | 19 +++++++++++
>  include/io/mpqemu-link.h        | 13 ++++++++
>  io/mpqemu-link.c                | 11 +++++++
>  6 files changed, 104 insertions(+)
>  create mode 100644 hw/i386/remote-memory.c
>  create mode 100644 include/hw/i386/remote-memory.h

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9rY9EACgkQnKSrs4Gr
c8j6Rgf+NZ8iheIIxngbIjIq55zSHxq+KnuLs/2MsVqf0zCFGwrSSCCSKpe9J0je
or+K0xaDgQ83H150Tet/TEQy5FXxzUu1Nrh8AHeOa2fmnDvspZj0r9voataOqjVO
zd6YlRmdCNlPwHMrLK5UJjMCCPimyofdzoyQ8AYOb3QwTzP0PiyvtmN8Ll9537jQ
0febiB8N0zBMG/x1mr4SeneqJ4DvjKT9KndgjQWAGwmkOWKxQZ507ZTzqqp458+5
XgdcaSj5hTw/4PZLHAHI3iNE3txYTZVi3UwN8GdNTIfYrb9vEGd0wnCiS9KpJgn8
Mq99Uvu8Tnv/ID91+JOeQXrHC1roXA==
=Q7mA
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--


