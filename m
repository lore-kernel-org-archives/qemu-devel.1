Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FFCC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 14:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE01207E8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 14:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHBsyejh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE01207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0nGq-0001qo-HI
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 10:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k0nG7-00013a-8T
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 10:40:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31629
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k0nG5-0003fH-Fs
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 10:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596033638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FeR1kacD3Qp9BbbFKsyvWfWfClXj3RQqICnEEKhgYhs=;
 b=bHBsyejhC90ld61hZddUE/zf/shRbXBopLcUqP6AyoHCYSt8X5SQ7njOlbC/tqeUbT+Oea
 KOqrQNTqd6IUl9MpXEAGHcnbyUpYaavup7roMDPxkbe9+tDE34sDLWoZfbcQjBsTv4/SuO
 WGYgmua3VZP7IpBl3O4qYE3KOJcQkJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-GJGVjWF9NESU_i-Z2eyiOw-1; Wed, 29 Jul 2020 10:40:34 -0400
X-MC-Unique: GJGVjWF9NESU_i-Z2eyiOw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED3CD59;
 Wed, 29 Jul 2020 14:40:32 +0000 (UTC)
Received: from localhost (ovpn-112-185.ams2.redhat.com [10.36.112.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6CBAF61100;
 Wed, 29 Jul 2020 14:40:28 +0000 (UTC)
Date: Wed, 29 Jul 2020 15:40:27 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Roman Mohr <rmohr@redhat.com>
Subject: Re: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print an
 error
Message-ID: <20200729144027.GF52286@stefanha-x1.localdomain>
References: <20200727190223.422280-1-stefanha@redhat.com>
 <20200727190223.422280-4-stefanha@redhat.com>
 <OSBPR01MB45826073E5A54CF869E56721E5730@OSBPR01MB4582.jpnprd01.prod.outlook.com>
 <CALDPj7syG0KPhtZEma5n403=YFZ2ptcD4MtP=GdrY9n1eUs5Eg@mail.gmail.com>
 <20200728131250.GB78409@redhat.com>
 <CALDPj7uvquu=YWX_Ve7ROdj=LZWjkgPOm+wvEAynGvjeF4Xivg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALDPj7uvquu=YWX_Ve7ROdj=LZWjkgPOm+wvEAynGvjeF4Xivg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="p8PhoBjPxaQXD0vg"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:18:45
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

--p8PhoBjPxaQXD0vg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2020 at 09:59:01AM +0200, Roman Mohr wrote:
> On Tue, Jul 28, 2020 at 3:13 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>=20
> > On Tue, Jul 28, 2020 at 12:00:20PM +0200, Roman Mohr wrote:
> > > On Tue, Jul 28, 2020 at 3:07 AM misono.tomohiro@fujitsu.com <
> > > misono.tomohiro@fujitsu.com> wrote:
> > >
> > > > > Subject: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and pr=
int
> > an
> > > > error
> Yes they can run as root. I can tell you what we plan to do with the
> containerized virtiofsd: We run it as part of the user-owned pod (a set o=
f
> containers).
> One of our main goals at the moment is to run VMs in a user-owned pod
> without additional privileges.
> So that in case the user (VM-creator/owner) enters the pod or something
> breaks out of the VM they are just in the unprivileged container sandbox.
> As part of that we try to get also rid of running containers in the
> user-context with the root user.
>=20
> One possible scenario which I could think of as being desirable from a
> kubevirt perspective:
> We would run the VM in one container and have an unprivileged
> virtiofsd container in parallel.
> This container already has its own mount namespace and it is not that
> critical if something manages to enter this sandbox.
>=20
> But we are not as far yet as getting completely rid of root right now in
> kubevirt, so if as a temporary step it needs root, the current proposed
> changes would still be very useful for us.

What is the issue with root in user namespaces?

I remember a few years ago it was seen as a major security issue but
don't remember if container runtimes were already using user namespaces
back then.

I guess the goal might be simply to minimize Linux capabilities as much
as possible?

virtiofsd could nominally run with an arbitrary uid/gid but it still
needs the Linux capabilities that allow it to change uid/gid and
override file system permission checks just like the root user. Not sure
if there is any advantage to running with uid 1000 when you still have
these Linux capabilities.

Stefan

--p8PhoBjPxaQXD0vg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8hilsACgkQnKSrs4Gr
c8gTAAgAg3n9zRW0ZMJOMe2UgsbMHF8o5QaHKAHCrYSIkZH8D/vuRm1ZTRLVleBq
ovB+lwmEFNZ6rfV69hJLuoU4v2qzUVHOa4i/K2O/EytfnIaGDn82dQiiXRaHXTiL
xKWp3eXhYYzHELEwc+9wgH3965MsOhUdopah1TpG/9W3LA8P9f4yOQJQmuq9RTsl
dTZFHzv1lnNUUUQKpJzZt14yz3tLRNpgopfPZnyEUnsuT/ZFwySdX0t/qyFQWaSu
aT6T+pDYjw9syKZmwEB6iI3iFmFhIWQABBV+8hizOjPkLHAjIwex+wcFEO3a2iup
S9otKVU5gLQMU+AUfWltexAKYVfgTA==
=v/Fl
-----END PGP SIGNATURE-----

--p8PhoBjPxaQXD0vg--


