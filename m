Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326C5C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A4420738
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDeUdWsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A4420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNXqD-0008Q3-J9
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 04:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNXpY-0007le-0H
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 04:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNXpU-0008WQ-2q
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 04:51:19 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601455873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mp7fs9oAy6Ck9gI1Qok/rrZaqKRiEibvlxbXgWowHdo=;
 b=WDeUdWsAdy+JZMHiLmLcYKR5jx4DCeLJzMzzGLu2GYVhkWoDckc4pH0PIicl5W/jCQFdiZ
 0tTW3YSoUJfetUMiHQeOlprOUrdnhmBO7LFqMVQXgB+oWRxkSJrrdxWxJ45HjBtB/k8E/j
 qpwX66s3lcwk3d8D4EubAamHt7t+ODM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-0hWsxgXfNwiflzBtzPW0AA-1; Wed, 30 Sep 2020 04:51:10 -0400
X-MC-Unique: 0hWsxgXfNwiflzBtzPW0AA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7EBF186DD21;
 Wed, 30 Sep 2020 08:51:09 +0000 (UTC)
Received: from localhost (ovpn-114-33.ams2.redhat.com [10.36.114.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 539C15C1C4;
 Wed, 30 Sep 2020 08:51:09 +0000 (UTC)
Date: Wed, 30 Sep 2020 09:51:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 3/4] block: move block exports to libblockdev
Message-ID: <20200930085108.GA201070@stefanha-x1.localdomain>
References: <20200929125516.186715-1-stefanha@redhat.com>
 <20200929125516.186715-4-stefanha@redhat.com>
 <846a3c67-33eb-f694-d9ed-9c4318e10eab@redhat.com>
MIME-Version: 1.0
In-Reply-To: <846a3c67-33eb-f694-d9ed-9c4318e10eab@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Coiby Xu <Coiby.Xu@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2020 at 12:36:10PM -0500, Eric Blake wrote:
> On 9/29/20 7:55 AM, Stefan Hajnoczi wrote:
> > Block exports are used by softmmu, qemu-storage-daemon, and qemu-nbd.
> > They are not used by other programs and are not otherwise needed in
> > libblock.
> >=20
> > Undo the recent move of blockdev-nbd.c from blockdev_ss into block_ss.
> > Since bdrv_close_all() (libblock) calls blk_exp_close_all()
> > (libblockdev) a stub function is required..
> >=20
> > Make qemu-ndb.c use signal handling utility functions instead of
> > duplicating the code. This helps because os-posix.c is in libblockdev
> > and it depends on a qemu_system_killed() symbol that qemu-nbd.c lacks.
> > Once we use the signal handling utility functions we also end up
> > providing the necessary symbol.
>=20
> Hmm. I just stumbled on a long-standing bug in qemu-nbd - it installs a
> SIGTERM handler, but not a SIGINT or SIGHUP handler.  This matters in
> the following sequence:
>=20
> qemu-nbd -f qcow2 -B bitmap image   # Ctrl-C
> qemu-nbd -f qcow2 -B bitmap image
>=20
> because the first instance dies with SIGINT but there is no handler
> installed, qemu-nbd does not release the bitmap from being marked
> in-use, and the second instance then fails with:
>=20
> qemu-nbd: Bitmap 'b0' is inconsistent and cannot be used
>=20
> And to my surprise, while I was trying to find the root cause to fixing
> the bug I just found, I noticed that your patch happens to fix that...
>=20
> > +++ b/qemu-nbd.c
>=20
> > @@ -581,20 +586,12 @@ int main(int argc, char **argv)
> >      const char *pid_file_name =3D NULL;
> >      BlockExportOptions *export_opts;
> > =20
> > +    os_setup_early_signal_handling();
> > +
> >  #if HAVE_NBD_DEVICE
> > -    /* The client thread uses SIGTERM to interrupt the server.  A sign=
al
> > -     * handler ensures that "qemu-nbd -v -c" exits with a nice status =
code.
> > -     */
> > -    struct sigaction sa_sigterm;
> > -    memset(&sa_sigterm, 0, sizeof(sa_sigterm));
> > -    sa_sigterm.sa_handler =3D termsig_handler;
> > -    sigaction(SIGTERM, &sa_sigterm, NULL);
> > +    os_setup_signal_handling();
>=20
> ...by installing a SIGINT handler.
>=20
> Is HAVE_NBD_DEVICE really the best gate for this code, or is it really
> whether we are compiling for mingw?  At any rate, you may want to add a
> link to https://bugzilla.redhat.com/show_bug.cgi?id=3D1883608 in the
> commit message, and/or separate the bug fix out into a separate commit.

Thanks for letting me know about the bug report. The link can be
added to the commit description when merging (or if I resend).

Stefan

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl90RvwACgkQnKSrs4Gr
c8gwwQgAvydVqR6IyZIpylh+1QMEKxKpi6yKHuY7u7sYgIvUvEyOnQBAqI51zqF1
KvRLtU9TcqydUl61+8iNU9xH6OnwidSv8xnW/vzsgGGGH7GdPC6DPneYDLxAmvnX
UayMhHHyyEGe45vlAPyqQt+J4MtYK4K1L4AIgC5UPY/qOmSqMTjBhpf+/YVHPycq
Gj2kcsjrs0ohHTeP22jlh7hBSr5uRfGiY/+H+bk98nzNvXXZH4d1+REW9Si6NnRr
xsueyQ8gGx1j64CVfocCHZNRT4zajTiD1KqVkC4PFK+Uhv5YsoIM7HXcJoCPPeBb
UGi8+OeG44uacaCj2GnXNyAjwt5yNg==
=zyVs
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--


