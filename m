Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783B3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 08:27:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 462AA2072A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 08:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKSr4VY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462AA2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1QO6-00020S-Gu
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 04:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k1QNS-0001L1-RX
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 04:26:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60203
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k1QNP-0004w4-1N
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 04:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596184009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gz6V5/Q+OfMA/BJSQDXGukdbueurXqLwt6KM0qV2uuc=;
 b=KKSr4VY4p32BUcLCqrNGTrJDveUH3mVwFfj3slV2hZ+dwBPRwomEwksnw7eZD2RbGcACo0
 yuG7AZdaMvdIDer3SdlSV0h9YDHhMljE9LVxHdmksHIU6u/yGuOKX39EiZ+WxFNE3y1EIT
 o6W9TY6OU6cfoUc4hh1j9iWsKNUeQic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-rmKb4L5nOl6zwSB6aO8whw-1; Fri, 31 Jul 2020 04:26:44 -0400
X-MC-Unique: rmKb4L5nOl6zwSB6aO8whw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C1E1800597;
 Fri, 31 Jul 2020 08:26:43 +0000 (UTC)
Received: from localhost (ovpn-114-6.ams2.redhat.com [10.36.114.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 792135DAA9;
 Fri, 31 Jul 2020 08:26:39 +0000 (UTC)
Date: Fri, 31 Jul 2020 09:26:38 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Roman Mohr <rmohr@redhat.com>
Subject: Re: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print an
 error
Message-ID: <20200731082638.GA173083@stefanha-x1.localdomain>
References: <20200727190223.422280-1-stefanha@redhat.com>
 <20200727190223.422280-4-stefanha@redhat.com>
 <OSBPR01MB45826073E5A54CF869E56721E5730@OSBPR01MB4582.jpnprd01.prod.outlook.com>
 <CALDPj7syG0KPhtZEma5n403=YFZ2ptcD4MtP=GdrY9n1eUs5Eg@mail.gmail.com>
 <20200728131250.GB78409@redhat.com>
 <CALDPj7uvquu=YWX_Ve7ROdj=LZWjkgPOm+wvEAynGvjeF4Xivg@mail.gmail.com>
 <20200729144027.GF52286@stefanha-x1.localdomain>
 <ad75a25c-0343-5c57-1933-e3c88f76df1c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ad75a25c-0343-5c57-1933-e3c88f76df1c@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 02:46:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: "vromanso@redhat.com" <vromanso@redhat.com>,
 Daniel Walsh <dwalsh@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>,
 "mpatel@redhat.com" <mpatel@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2020 at 06:21:34PM -0400, Daniel Walsh wrote:
> On 7/29/20 10:40, Stefan Hajnoczi wrote:
> > On Wed, Jul 29, 2020 at 09:59:01AM +0200, Roman Mohr wrote:
> >> On Tue, Jul 28, 2020 at 3:13 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >>
> >>> On Tue, Jul 28, 2020 at 12:00:20PM +0200, Roman Mohr wrote:
> >>>> On Tue, Jul 28, 2020 at 3:07 AM misono.tomohiro@fujitsu.com <
> >>>> misono.tomohiro@fujitsu.com> wrote:
> >>>>
> >>>>>> Subject: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and pri=
nt
> >>> an
> >>>>> error
> >> Yes they can run as root. I can tell you what we plan to do with the
> >> containerized virtiofsd: We run it as part of the user-owned pod (a se=
t of
> >> containers).
> >> One of our main goals at the moment is to run VMs in a user-owned pod
> >> without additional privileges.
> >> So that in case the user (VM-creator/owner) enters the pod or somethin=
g
> >> breaks out of the VM they are just in the unprivileged container sandb=
ox.
> >> As part of that we try to get also rid of running containers in the
> >> user-context with the root user.
> >>
> >> One possible scenario which I could think of as being desirable from a
> >> kubevirt perspective:
> >> We would run the VM in one container and have an unprivileged
> >> virtiofsd container in parallel.
> >> This container already has its own mount namespace and it is not that
> >> critical if something manages to enter this sandbox.
> >>
> >> But we are not as far yet as getting completely rid of root right now =
in
> >> kubevirt, so if as a temporary step it needs root, the current propose=
d
> >> changes would still be very useful for us.
> > What is the issue with root in user namespaces?
> >
> > I remember a few years ago it was seen as a major security issue but
> > don't remember if container runtimes were already using user namespaces
> > back then.
> >
> > I guess the goal might be simply to minimize Linux capabilities as much
> > as possible?
> >
> > virtiofsd could nominally run with an arbitrary uid/gid but it still
> > needs the Linux capabilities that allow it to change uid/gid and
> > override file system permission checks just like the root user. Not sur=
e
> > if there is any advantage to running with uid 1000 when you still have
> > these Linux capabilities.
> >
> > Stefan
>=20
> When you run in a user namespace, virtiofsd would only have
> setuid/setgid over the range of UIDs mapped into the user namespace.=A0 S=
o
> if UID=3D0 on the host is not mapped, then the container can not create
> real UID=3D0 files on disk.
>=20
> Similarly you can protect the user directories and any content by
> running the containers in a really high UID Mapping.

Roman, do user namespaces address your concerns about uid 0 in
containers?

Stefan

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8j1b4ACgkQnKSrs4Gr
c8j0gQf/XOWE89ORV2Kmnot5KdoBuTN+VNcLxQllhA0bwIJbCrX7wXJhfpVkgzvU
Lsg+tp8lRMjE0EWSAelF7UbNqEF97JXQgSA1BT3Aqf0w+FR9he09sjL6m3VMc6xt
OgFc0yx3UxAbuQpryCXBYI7gMmliO/eRmiOCx69CPnaWsbjhbldHpwSg2oyWne3k
uJ3biwV73x0ig66XkBWHQ9qwR9iYTZAvx/OK+DBFvtaQXUpZjfyjqbInKi3yTF0Z
Arg+nJ25yHctaPMjjXYoR19AiUeZREKIODuw9agM8qCJgfnkBln9XmYUgDupTVV7
vPXTOYF3kwmz5aPfc+2O1f0el/VRTw==
=0WtM
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--


