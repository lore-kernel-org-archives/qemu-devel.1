Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27F4C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 16:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF1C206E2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 16:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feyoQGNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF1C206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGDy-00064y-NK
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 11:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jAGDJ-0005ag-FQ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jAGDH-0007Sl-Tb
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:52:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31718
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jAGDH-0007Mj-M4
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583513558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OX9oW55qz6ty0aA7vKNlmc8qYkUjZPUuJJK1iZmYRac=;
 b=feyoQGNIYWAdVa62iM1vShhgwer5nL/6zX1BSqrrc05mwyrHh4OPhSyPdL0U9NpyiYGnVk
 0Cm98reYsWABpQ6Qf/s8SndMWOun9sx5b7lrOD5mc1sH8i3oESUfd0QQZu0QyEgvLHL0K5
 yQlua1775T1Ykdjq2JHYp5u/JjYP3PI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-dJ7Aii3uNKarqCvRqMlSDg-1; Fri, 06 Mar 2020 11:52:37 -0500
X-MC-Unique: dJ7Aii3uNKarqCvRqMlSDg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA23D13F6;
 Fri,  6 Mar 2020 16:52:34 +0000 (UTC)
Received: from localhost (unknown [10.36.118.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0067B5DA7D;
 Fri,  6 Mar 2020 16:52:28 +0000 (UTC)
Date: Fri, 6 Mar 2020 16:52:27 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v5 32/50] multi-process: Use separate MMIO communication
 channel
Message-ID: <20200306165227.GD1438162@stefanha-x1.localdomain>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <d776913e1796fe9f929a665c0265eff3978fcc16.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <d776913e1796fe9f929a665c0265eff3978fcc16.1582576372.git.jag.raman@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This went unanswered in the last revision:

On Thu, Nov 21, 2019 at 12:31:42PM +0000, Stefan Hajnoczi wrote:
> On Wed, Nov 13, 2019 at 11:14:50AM -0500, Jag Raman wrote:
> > On 11/11/2019 11:21 AM, Stefan Hajnoczi wrote:
> > > On Thu, Oct 24, 2019 at 05:09:13AM -0400, Jagannathan Raman wrote:
> > > > Using a separate communication channel for MMIO helps
> > > > with improving Performance
> > >=20
> > > Why?
> >=20
> > Typical initiation of IO operations involves multiple MMIO accesses per
> > IO operation. In some legacy devices like LSI, the completion of the IO
> > operations is also accomplished by polling on MMIO registers. Therefore=
,
> > MMIO traffic can be hefty in some cases and contribute to Performance.
> >=20
> > Having a dedicated channel for MMIO ensures that it doesn't have to
> > compete with other messages to the remote process, especially when ther=
e
> > are multiple devices emulated by a single remote process.
>=20
> A vCPU doing a polling read on an MMIO register will cause a BAR_READ
> message to be sent to the remote process.  The vCPU thread waits for the
> response to this message.
>=20
> When there are multiple remote devices each has its own socket, so
> communication with different remote processes does not interfere.
>=20
> The only scenarios I can think of are:
> 1. Interference within a single device between vCPUs and/or the QEMU
>    monitor.
> 2. A single process serving multiple devices that is implemented in a
>    way such that different devices interfere with each other.
>=20
> It sounds like you are saying the problem is #2, but this is still
> unclear to me.  If the remote process can be implemented in a way such
> that there is no interference when each device has a special MMIO
> socket, then why can't it be implemented in a way such that there is no
> interference when each device's main socket is used (each device has
> it's own!).
>=20
> Maybe I've missed the point.  It would be good if you could explain in
> more detail.
>=20
> Stefan

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5if8sACgkQnKSrs4Gr
c8h5rgf9HHNzinZxU3gtQWEe+hugGVtE7G6SkgQff9+w9hNLx0fxQuTXwbtoeNUm
jppvs1d+18zpRsrKu6r69PV0eq6vK36sjI2LO+Z89rxh9YghKG4XH9/+akDNd/AY
0xO3ugEgNShkdVCkW6hZzjxfjD6VemhEzDWQogVSzvc4rjRthmQldtS/J9ghHKud
rw7Uq72WsnmlMIJEC2Y4nKg+m67FicG5GjmBZzBGyJmW7CSeTwXbuyFQQz4VcNm+
F87ovDDqzmAt1nuJNy2/dtvbHrqUa1IOaT/d4akgLygA97rTIjvzpRrwIwjOv0ok
4RqV+I+6mPRIpv9vpsGtsp3Rb+UeJQ==
=tlHN
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--


