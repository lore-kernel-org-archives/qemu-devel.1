Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D28C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC9421D7D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtMP2Vsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC9421D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQYSc-0002H8-ON
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 12:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQYNO-0004OK-50
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:02:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30826)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQYNL-0004F0-MQ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602172958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MN9b4ZpgQqbHIhxZg7TRZegP4/rGDXod1gG7DW9Tx6s=;
 b=BtMP2Vsugzzm4uSIWrSDt07hViu01Z+wBbj4+pMXPCpF1ooMmw1/X7N0uA4G4RFSI6hBa6
 2+zoZyPi0l3Msgni/VXAulEJOufBSWSx6zPcxtGfx9HCkBVMeGAbDk3pmTk50FHDE2tJ5w
 SiARrfgOqU1nf2IJ2VgTcO9ju4Xz5o8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-AkgJOiOWM1SG67Dhe3p13w-1; Thu, 08 Oct 2020 12:02:34 -0400
X-MC-Unique: AkgJOiOWM1SG67Dhe3p13w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C742804019;
 Thu,  8 Oct 2020 16:02:32 +0000 (UTC)
Received: from localhost (ovpn-113-63.ams2.redhat.com [10.36.113.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E48CA6EF48;
 Thu,  8 Oct 2020 16:02:31 +0000 (UTC)
Date: Thu, 8 Oct 2020 17:02:30 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 11/13] block/export: convert vhost-user-blk server to
 block export API
Message-ID: <20201008160230.GA32633@stefanha-x1.localdomain>
References: <20200924151549.913737-1-stefanha@redhat.com>
 <20200924151549.913737-12-stefanha@redhat.com>
 <87imbvj0it.fsf@dusky.pond.sub.org>
 <20200930094508.GE201070@stefanha-x1.localdomain>
 <87eemj72s1.fsf@dusky.pond.sub.org>
 <20201001152515.GD559957@stefanha-x1.localdomain>
 <877ds9td8v.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <877ds9td8v.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Coiby Xu <coiby.xu@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2020 at 07:20:48AM +0200, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
> > On Wed, Sep 30, 2020 at 04:33:18PM +0200, Markus Armbruster wrote:
> >> Stefan Hajnoczi <stefanha@redhat.com> writes:
> >> > On Wed, Sep 30, 2020 at 07:28:58AM +0200, Markus Armbruster wrote:
> >> >> Stefan Hajnoczi <stefanha@redhat.com> writes:
> >> Hence my question: is it possible that address families other than uni=
x
> >> become available here?
> >>=20
> >> When that happens, we have an introspection problem of the sort we
> >> common solve with a feature flag.
> >>=20
> >> > Accepting any SocketAddr seems reasonable to me since vhost-user
> >> > requires an address family that has file descriptor passing. Very fe=
w
> >> > address families support this feature and we don't expect to add new
> >> > ones often.
> >>=20
> >> Your answer appears to be "yes in theory, quite unlikely in practice".
> >> Correct?
>=20
> Keeping introspection "tight" would be nice, but since a real need for
> "tight" here seems quite unlikely, it doesn't seem to be worth the
> trouble.
>=20
> Perhaps this argument could be worked into the commit message.  Up to
> you.
>=20
> Acked-by: Markus Armbruster <armbru@redhat.com>

Thanks, I will update the commit message when merging.

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9/OBYACgkQnKSrs4Gr
c8jv3QgAsK+R2gD93s5GweEaoL3fMLXK5doWCiaqU0+83MXGioIcOck9pkWjRQzu
IyVegY/I661oocCwd9vgBpMM2gU59BrRgtgOj0cQYe3Mm4w/sCBT4uyebcfXS87s
WARkXJ5E/Q+S+iG9rN2KbVWZbiYfX3kwfnxfjD6LLLinuqiZxJ82uoKxWPAGvVU0
lDQulOHs4I1YXRvwQFBO5biWV2bWb9dJ4GX+0//yx0R6XRvMt9vfiJHw1R3grZd2
TXoVq7ErFBvCcjLnAV5qZvkMseGCJXZYe/6Yp4Wj/snwMxBdXqB1IEcMFF9eD217
fXvnFoh2fXzTKvqo9e0rFdd/72HByQ==
=ZePy
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--


