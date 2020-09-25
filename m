Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFB3C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBBF20702
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHNnVWjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBBF20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLrM0-0006lj-1z
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 13:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLrK7-0005gH-7h
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLrK5-0005gh-Pk
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:15:54 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601054153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wUqoDV9bvCzipjVIi4QisC0hr4k8mpQhyqJDsVGj9Co=;
 b=UHNnVWjZU3srvkc9EqnmtZQczy7NShRdZ0kU3Sp2NDc78xOj16cq162+dlVbeLfnRaJnZU
 SN/1YvewPtxiMpE2CW88LKyg71gZ7mKrLys3CgxHf1v8d0jN33erjX837+yRAcHD8UsFrL
 q70nws6bRuKaP02bcQzlQggMHhSdHuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-N-lCEoTsMq2fzDbBKVuSIw-1; Fri, 25 Sep 2020 13:15:48 -0400
X-MC-Unique: N-lCEoTsMq2fzDbBKVuSIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90D511017DED;
 Fri, 25 Sep 2020 17:15:47 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-83.ams2.redhat.com [10.36.114.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CBBD5C1C2;
 Fri, 25 Sep 2020 17:15:42 +0000 (UTC)
Date: Fri, 25 Sep 2020 19:15:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v7 00/13] monitor: Optionally run handlers in coroutines
Message-ID: <20200925171541.GK5731@linux.fritz.box>
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200910132439.GE45048@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200910132439.GE45048@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, armbru@redhat.com,
 qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 10.09.2020 um 15:24 hat Stefan Hajnoczi geschrieben:
> On Wed, Sep 09, 2020 at 05:11:36PM +0200, Kevin Wolf wrote:
> > Some QMP command handlers can block the main loop for a relatively long
> > time, for example because they perform some I/O. This is quite nasty.
> > Allowing such handlers to run in a coroutine where they can yield (and
> > therefore release the BQL) while waiting for an event such as I/O
> > completion solves the problem.
> >=20
> > This series adds the infrastructure to allow this and switches
> > block_resize to run in a coroutine as a first example.
> >=20
> > This is an alternative solution to Marc-Andr=E9's "monitor: add
> > asynchronous command type" series.
>=20
> Please clarify the following in the QAPI documentation:
>  * Is the QMP monitor suspended while the command is pending?

Suspended as in monitor_suspend()? No.

>  * Are QMP events reported while the command is pending?

Hm, I don't know to be honest. But I think so.

Does it matter, though? I don't think events have a defined order
compared to command results, and the client can't respond to the event
anyway until the current command has completed.

Kevin

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl9uJb0ACgkQfwmycsiP
L9addhAAohZySNCngXTPX02OcAOJWtwvlhiVmgkCRvcH7AZXJmIpD9AIKatxBbAv
oIWstCvU2aEz2Zj6FO15+uelT41B5wKmAtJZyt4zup6XhPxmFuHu4QuQG3eLQ6j6
oTxMKy6X+ZplGajqSyTOnJh1kNcTIiYDfRx5sYU8tj3Ps86eoMN0wy+C1gsH+yfw
TprGcCdkJLZagZ4mpyAWtlzeV/2DVyGBEeD0E2UiKgI1U+2okskkdALjxamq8hCI
bjSztGSlTSYPdPs6TkhH3soaQBdM1/jp50i7onupLLpa/uYv3+DKZwRwd0Dndbw8
RyvnqlkbgLXJg5XMpfWXB3sCBwfq+nNzUJ6l+/kiKON5ZXipDvKi/GGBJZpe2/q6
Wse6JJeZELZOESKoq9wOnstsKv+vrPcx1bbp3FzarWVb04OLREZnOtN5mRMTAMwR
RbaRjC65spNQoNgP8P42c0PGpGKxPeo2i6hU98oeD6RW1Hd4xrkfaOg0Gen9Y5ew
jlJfrR6b1LizeZJGZlYEeNyLsCRnoeG9UTrcIanUFbndRDxyipF0iw7Whq8EVHzr
eLbOE3tZm3Q2vKpP78HkRxfrnUgTmVYiFvYUlAarwHOu5u8s638w8dFbUemxoXmg
sQpz0zeqipcjWZctop7phfKvALKHI7t0M9AIeJV9t62K3AhDaN0=
=SXjt
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--


