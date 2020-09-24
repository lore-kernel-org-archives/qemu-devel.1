Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FC7C2D0E2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:28:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C93A221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkTr63b0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C93A221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLMcU-0000e8-RM
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 04:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLMb3-0008Ad-Ko
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:27:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLMb1-00071w-QL
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600936039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z88vOsNO8JpEqbF7SZL64dgpAleoCXwdn8J5CfOMl3Y=;
 b=UkTr63b0X7MqsQI7gMkEP3L7DXW4cem/ZMyfXsF4tmLLRDosuGS2njB8gSNvQMBGQzWi3O
 R3tZZU0cntz39JWXUDwoql8qvswf3BlAVGZnKfXTi6GwRduqoRvBwO6cP6p1fnDhglSjHw
 zpI8zp3lZ9Rz0NFqjQYv+xUVtuZPXPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-4-KSXlB2MhS1LXxm6rqYwg-1; Thu, 24 Sep 2020 04:27:15 -0400
X-MC-Unique: 4-KSXlB2MhS1LXxm6rqYwg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 458202FD02;
 Thu, 24 Sep 2020 08:27:13 +0000 (UTC)
Received: from localhost (ovpn-114-133.ams2.redhat.com [10.36.114.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F06455778;
 Thu, 24 Sep 2020 08:27:06 +0000 (UTC)
Date: Thu, 24 Sep 2020 09:27:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v9 15/20] multi-process: Synchronize remote memory
Message-ID: <20200924082705.GK62770@stefanha-x1.localdomain>
References: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
 <20200827181231.22778-16-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200827181231.22778-16-elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4wkndigzIeYF6Hbg"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
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

--4wkndigzIeYF6Hbg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2020 at 11:12:26AM -0700, elena.ufimtseva@oracle.com wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
>=20
> Add memory-listener object which is used to keep the view of the RAM
> in sync between QEMU and remote process.
> A MemoryListener is registered for system-memory AddressSpace. The
> listener sends SYNC_SYSMEM message to the remote process when memory
> listener commits the changes to memory, the remote process receives
> the message and processes it in the handler for SYNC_SYSMEM message.
>=20
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  MAINTAINERS                  |   2 +
>  hw/i386/remote-msg.c         |   4 +
>  hw/pci/memory-sync.c         | 210 +++++++++++++++++++++++++++++++++++
>  hw/pci/meson.build           |   2 +
>  hw/pci/proxy.c               |   6 +
>  include/hw/pci/memory-sync.h |  27 +++++
>  include/hw/pci/proxy.h       |   3 +
>  7 files changed, 254 insertions(+)
>  create mode 100644 hw/pci/memory-sync.c
>  create mode 100644 include/hw/pci/memory-sync.h

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4wkndigzIeYF6Hbg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9sWFkACgkQnKSrs4Gr
c8h/cQf+Iw54EkLkIRqSm5VRwHRxbh9l0VoVf1WyA25BImqOoyrcRPKZR2K10sFS
C5t5bC3CzVuc/HbImYkisIAD1CsQaMOh4BG3cEpijfCbh28zdxiwX+BfTh9Uxd2j
z0uTCbtO6VAvLDV6l0YQXDhTfC5bL6hrjsItsrdDU9FzR+HBJkEzlLZnZL+KAzHQ
QrffVxFRsBHAGeDOZLGu2epE813vlO9IdfSOreKHVxLRjKCYuOELCYcwKdL2JdSx
DwwUJmfvm6rJMlIjrs+fYD7h7MRLBsCYQhRFlSgKcZ9xqsy7VlGNDddhIHynDeVq
/6XywVU0BKvjS/kqn2SQaS9nMokNUA==
=iMxF
-----END PGP SIGNATURE-----

--4wkndigzIeYF6Hbg--


