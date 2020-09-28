Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E226C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87821207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFTbPOMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87821207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMoou-0005FX-GH
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 04:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kMona-0003xE-Gm
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 04:46:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kMonX-0007Ft-6Y
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 04:46:18 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601282774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5pUPnPPHY0f4Xpne8qRtp9TmvHORxcrmhWFETEYoHqM=;
 b=OFTbPOMNYnx2PLz1uOqjZR1/FytlCJT/5mDcJdYi9857QMbo6Pj/v+oC3VLqpeOY/xrmzi
 CQ1uMcN/S8mLrkDocOJYMvar8S+VoKn1zlxE0eyUG216CyQ8bbnGpZuREuhzsbGRpFauoy
 khyuu4ayO+o4ObmT1rHytcGZcYvZdaw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-4Bj18WYTMAK2LJ1Yb_YeYA-1; Mon, 28 Sep 2020 04:46:11 -0400
X-MC-Unique: 4Bj18WYTMAK2LJ1Yb_YeYA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78F7359;
 Mon, 28 Sep 2020 08:46:10 +0000 (UTC)
Received: from localhost (ovpn-114-195.ams2.redhat.com [10.36.114.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D6005C1A3;
 Mon, 28 Sep 2020 08:46:09 +0000 (UTC)
Date: Mon, 28 Sep 2020 09:46:09 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 00/13] monitor: Optionally run handlers in coroutines
Message-ID: <20200928084609.GC43571@stefanha-x1.localdomain>
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200910132439.GE45048@stefanha-x1.localdomain>
 <20200925171541.GK5731@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200925171541.GK5731@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, armbru@redhat.com,
 qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2020 at 07:15:41PM +0200, Kevin Wolf wrote:
> Am 10.09.2020 um 15:24 hat Stefan Hajnoczi geschrieben:
> > On Wed, Sep 09, 2020 at 05:11:36PM +0200, Kevin Wolf wrote:
> > > Some QMP command handlers can block the main loop for a relatively lo=
ng
> > > time, for example because they perform some I/O. This is quite nasty.
> > > Allowing such handlers to run in a coroutine where they can yield (an=
d
> > > therefore release the BQL) while waiting for an event such as I/O
> > > completion solves the problem.
> > >=20
> > > This series adds the infrastructure to allow this and switches
> > > block_resize to run in a coroutine as a first example.
> > >=20
> > > This is an alternative solution to Marc-Andr=E9's "monitor: add
> > > asynchronous command type" series.
> >=20
> > Please clarify the following in the QAPI documentation:
> >  * Is the QMP monitor suspended while the command is pending?
>=20
> Suspended as in monitor_suspend()? No.
>=20
> >  * Are QMP events reported while the command is pending?
>=20
> Hm, I don't know to be honest. But I think so.
>=20
> Does it matter, though? I don't think events have a defined order
> compared to command results, and the client can't respond to the event
> anyway until the current command has completed.

You're right, I don't think it matters because the client must expect
QMP events at any time.

I was trying to understand the semantics of coroutine monitor commands
from two perspectives:

1. The QMP client - do coroutine commands behave differently from
   non-coroutine commands? I think the answer is no. The monitor will
   not process more commands until the coroutine finishes?

2. The command implementation - which thread does the coroutine run in?
   I guess it runs in the main loop thread with the BQL and the
   AioContext acquired?

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9xotEACgkQnKSrs4Gr
c8iB0Af+O+TXfoIRz+TJxzcKJQO2vAyN/nFiP9+4DNwft0930rsibtgPotzcxc3u
gpjFItg7Ux/kw7UAv9XBgD+5ZjSG61ttWdGEXyf80UyCoGOGE2ArCa0gUHsVJJx9
SbR7ATdTxwV9/J91I+VD8KpfVtY0hfWzMcAhetL3FRmte43vmu0OFHNiaSqyFcKY
3n7A5cwIpE9XR5Hgde+lO6DuGgS/0P7GYCyNOmkQzfJHO25M0lExtWK5vdHIk3Ww
eDY8ZHrXWeMFYoAbVWqf08TOthvnCWqumQmJc87zJZMM3LXFNF6AYQEisvBBuHuL
YF2dqFWeOu60oIdE8PulKNDP7CWJfQ==
=1ZMN
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--


