Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A42CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB0BA20663
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIytaALy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0BA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNz97-0002h7-MB
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 08:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNz5y-0006VU-Bs
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNz5x-0003TR-BC
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:53:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29539
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNz5x-0003Rj-6S
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572008012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xpys+Pkw2yAs38/5luF0w6QdEnN7gxG09z4JvhgOX+Y=;
 b=NIytaALyhs357dbtnG/SsHwXdWPT6EbrqNR1K89jLZDUTbRWmsfF9TH0Mw/S9Xskgephnw
 kI00kXXNbZb56NBgLf3PLCGy9c94Ce7Y69tJn8rBLNHOpzmAw91uAyNUO5JhKhIJcUP+Tx
 wreDgNg3TwWIU+e1lmINIxgISZ8iF1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-UbLxIxu_PIylzXdJh4pZJA-1; Fri, 25 Oct 2019 08:53:29 -0400
X-MC-Unique: UbLxIxu_PIylzXdJh4pZJA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFF0D1005509
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 12:53:28 +0000 (UTC)
Received: from localhost (ovpn-117-215.ams2.redhat.com [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A4A660852;
 Fri, 25 Oct 2019 12:53:24 +0000 (UTC)
Date: Fri, 25 Oct 2019 14:53:23 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 2/2] virtiofsd: move to a new pid namespace
Message-ID: <20191025125323.GD13314@stefanha-x1.localdomain>
References: <20191016160157.12414-1-stefanha@redhat.com>
 <20191016160157.12414-3-stefanha@redhat.com>
 <20191024102611.GF3700@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191024102611.GF3700@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 11:26:11AM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Oct 16, 2019 at 05:01:57PM +0100, Stefan Hajnoczi wrote:
> It might be useful to call prctl(PR_SET_PDEATHSIG) here, so that
> if the parent process exits for any reason, the child will be killed
> off too.
[...]
> I feel like this is making things a bit misleading.
>=20
>  setup_pid_namespace()
>=20
> is now creating the mount namespace and pid namespace, and doing
> some mount point config
>=20
>  setup_mount_namespace()
>=20
> is not creating the mount namespace, but is doing some more mount
> point config.
>=20
> And then there's setup_net_namespace() too.
>=20
> I think there could be a  single
>=20
>   setup_namespaces()
>=20
> method that does the unshare(CLONE_NEWNS|CLONE_NEWNET|CLONE_NEWPID)
> and forking the child.
>=20
> And a setup_mounts()
>=20
> method that does all the mount() calls.

Thanks for your suggestions.  I'll implement both of them as follow-up
patches since this has already been included in the virtiofsd code.

Stefan

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2y8EMACgkQnKSrs4Gr
c8jRvQf/WTMG6gI+jzx5Ytr7ApU7nlx516Kmq/BtgD0DPng+qO/+VRLEH5uvCXAv
jfVP2dHA9LMwlH1YyyVXdvpkfb7JF/LMY6ZR85D43fRV43LRcgrsuVfXLbw8E56d
kKS6t7EziGQH9Qdp3rNKa1tvDliRa9Iwgqbxk83xGJEDeONo3AFry+L5jQroLXH5
3kCiXAHlPeFfQGmDo1CW7U1h7sIKtJ6SQLHyIB4+gMjDjKzN3aO00EahWg65Daqn
pPCW7Wdmt0kSJE7oxMLri2NphsLanaFpOgD8+Qag8olxg62JU5hmnRdiG3G19xzZ
+UmiuS7fXAPTDECy6mvMm/7uLCnkLA==
=TwjB
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--


