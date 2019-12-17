Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F09C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E9321582
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imznI1Nh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E9321582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihFnf-0002SX-EP
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 11:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ihFmv-0001y5-Mm
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:33:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ihFmt-0004Em-Ke
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:33:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36803
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ihFmt-0004Ec-FE
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576600410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NTKZc0e5cu6vabRymIEVDwJ2xegd9Ud8oYA9ieSqfSQ=;
 b=imznI1NhdFqB27F6FNnM9pmRtttdyY6XaTRQBSXXPeqd1RLpI7j5p9dfDgs/qno/oRJyqA
 S5y59XFPPAWPD0nacp9NCT+itvdeaOfEtj7xUUyhEA3X41bTuqfT9Du0V4mT588t4uu7n8
 tMxMBOEBSFWYzWHBqlCMLa4WFI0KMcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-U3xYZ1BqP-yQ8k7d1ZpOqw-1; Tue, 17 Dec 2019 11:33:25 -0500
X-MC-Unique: U3xYZ1BqP-yQ8k7d1ZpOqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21945DBA7;
 Tue, 17 Dec 2019 16:33:23 +0000 (UTC)
Received: from localhost (ovpn-117-244.ams2.redhat.com [10.36.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB8AF1001B00;
 Tue, 17 Dec 2019 16:33:17 +0000 (UTC)
Date: Tue, 17 Dec 2019 16:33:16 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Felipe Franciosi <felipe@nutanix.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Message-ID: <20191217163316.GB1333385@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <20191210064716.GA6401@flaka>
 <20191213104116.GB1180977@stefanha-x1.localdomain>
 <20191216194655.GA5922@flaka>
 <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2019 at 07:57:32PM +0000, Felipe Franciosi wrote:
> > On 16 Dec 2019, at 20:47, Elena Ufimtseva <elena.ufimtseva@oracle.com> =
wrote:
> > =EF=BB=BFOn Fri, Dec 13, 2019 at 10:41:16AM +0000, Stefan Hajnoczi wrot=
e:
> >> Is there a work-in-progress muser patch series you can post to start t=
he
> >> discussion early?  That way we can avoid reviewers like myself asking
> >> you to make changes after you have invested a lot of time.
> >>=20
> >=20
> > Absolutely, that is our plan. At the moment we do not have the patches
> > ready for the review. We have setup internally a milestone and will be
> > sending that early version as a tarball after we have it completed.
> > Would be also a meeting something that could help us to stay on the sam=
e
> > page?
>=20
> Please loop us in if you so set up a meeting.

There is a bi-weekly KVM Community Call that we can use for phone
discussions:

  https://calendar.google.com/calendar/embed?src=3DdG9iMXRqcXAzN3Y4ZXZwNzRo=
MHE4a3BqcXNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ

Or we can schedule a one-off call at any time :).

Questions I've seen when discussing muser with people have been:

1. Can unprivileged containers create muser devices?  If not, this is a
   blocker for use cases that want to avoid root privileges entirely.

2. Does muser need to be in the kernel (e.g. slower to develop/ship,
   security reasons)?  A similar library could be implemented in
   userspace along the lines of the vhost-user protocol.  Although VMMs
   would then need to use a new libmuser-client library instead of
   reusing their VFIO code to access the device.

3. Should this feature be Linux-only?  vhost-user can be implemented on
   non-Linux OSes...

Stefan

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl35A0wACgkQnKSrs4Gr
c8gNIAf+MxldTZ4hf1Yd5gMxB4GP7IMlW9whqjV5utrNbUJbIxWvnqpCtURV2iEw
P/5p4Mbxemab7hbpHXNiX7fnhkR6A4AZaubkHKb2ejRJP9nuwTk9xJpszwAVrq6o
aZAHTD1X/zcSFrDpdf6vA0JAdK3P/CbZRJlhLlfesgFO0yZHqvVURqPF+6ZJbUwb
jWUUflo++YgY8qG5y5yJoC+riteqiqookwSkDJkbivUQ7paAlLh8v3FS3HWLzfum
wlAsIXG/8QqvFZwNZ3Luugw0txWV4ixLD/sCwiilnKwKwjS8/vD7EdhvammgMKsR
cO0hh1+Mdb0v7vCvTabSDz4uEAERCg==
=NZjk
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--


