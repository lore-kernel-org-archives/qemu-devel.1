Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B001C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59055206FB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fho3pWYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59055206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSH8Q-00035n-1P
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 06:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kSH6u-0002YX-Dl
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:00:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kSH6r-0007X7-LV
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602583244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YbwdHqlrRRYH7MNJtjs9dhnRF2oQrR7TupglR3DJQOw=;
 b=Fho3pWYL8XS/HzZpbt2TY+98kb3eXrJHJ/TMTkR+yS2F09HibB/ZuALWDp86LnsaqTgM0p
 hcu/Q4YkE7z2dKGUCV/R9q5aY/hsoVvbAg80yKktgSqdfY0OGSWj9L/Vb4bWn6ywHQzyz5
 zNTdzzAIE4k1H4n7btkkQUG1igdtbNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-glvfoewAMRWQXlO2EwMbEA-1; Tue, 13 Oct 2020 06:00:42 -0400
X-MC-Unique: glvfoewAMRWQXlO2EwMbEA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94F92879511;
 Tue, 13 Oct 2020 10:00:40 +0000 (UTC)
Received: from localhost (ovpn-114-249.ams2.redhat.com [10.36.114.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBAD819C71;
 Tue, 13 Oct 2020 10:00:39 +0000 (UTC)
Date: Tue, 13 Oct 2020 11:00:33 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [PATCH v1 0/2] Add timeout mechanism to qmp actions
Message-ID: <20201013100033.GB164611@stefanha-x1.localdomain>
References: <20200810153811.GF14538@linux.fritz.box>
 <c6d75e49-3e36-6a76-fdc8-cdf09e7c3393@huawei.com>
 <20200914132738.GL579094@stefanha-x1.localdomain>
 <7ad220bd-7ee5-1f66-b2e5-7dc57d72eb2e@huawei.com>
 <20200917154415.GB839531@stefanha-x1.localdomain>
 <20200917160054.GA2453251@dev>
 <5a5822ec-f3bc-a247-2b5a-f764b941c820@huawei.com>
 <20200918140628.GA2509473@dev>
 <1ba06b0d-3fcf-3676-f9e0-52875851ff19@huawei.com>
 <20200921111435.GA2524022@dev>
MIME-Version: 1.0
In-Reply-To: <20200921111435.GA2524022@dev>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: fam@euphon.net, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, armbru@redhat.com,
 pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2020 at 11:14:35AM +0000, Fam Zheng wrote:
> On 2020-09-19 10:22, Zhenyu Ye wrote:
> > On 2020/9/18 22:06, Fam Zheng wrote:
> > >=20
> > > I can see how blocking in a slow io_submit can cause trouble for main
> > > thread. I think one way to fix it (until it's made truly async in new
> > > kernels) is moving the io_submit call to thread pool, and wrapped in =
a
> > > coroutine, perhaps.
> > >
> >=20
> > I'm not sure if any other operation will block the main thread, other
> > than io_submit().
>=20
> Then that's a problem with io_submit which should be fixed. Or more
> precisely, that is a long held lock that we should avoid in QEMU's event
> loops.
>=20
> >=20
> > > I'm not sure qmp timeout is a complete solution because we would stil=
l
> > > suffer from a blocked state for a period, in this exact situation bef=
ore
> > > the timeout.
> >=20
> > Anyway, the qmp timeout may be the last measure to prevent the VM
> > soft lockup.=20
>=20
> Maybe, but I don't think baking such a workaround into the QMP API is a
> good idea. No QMP command should be synchronously long running, so
> having a timeout parameter is just a wrong design.

Sorry, I lost track of this on-going email thread.

Thanks for the backtrace. It shows the io_submit call is done while the
AioContext lock is held. The monitor thread is waiting for the
IOThread's AioContext lock. vcpus threads can get stuck waiting on the
big QEMU lock (BQL) that is held by the monitor in the meantime.

Please collect the kernel backtrace for io_submit so we can understand
why multi-second io_submit latencies happen.

I also suggest trying aio=3Dio_uring to check if Linux io_uring avoids the
latency problem.

Stefan

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+FesEACgkQnKSrs4Gr
c8i3pAf/ezXLphSNBwped4Dm56Gzi/vmLqRAUuv7KZCjyEjjeu9+GMxpq+TvKDJ6
NTw5WYCUP1EEbjB/JPPkDSDfMH0c1Z+zESY20fHMfQj72eIMtHfwZM4Tfq7JBgQ5
70e8kTWTq5WjJCRp1q6RGBMPPSGdQkj3Y5vYOTRrG5PxAM/cKNvvaUiJkGwggKws
cTpkHoa4MStm+SYq0BSq3xGZ4AslAQRLlY3eZTOKjOKo8HzY+P/FwUff+uRMyAeW
4w+iFAWlOO/hWZodYSF8gg9cZZPxixASPatgybbrWC7yL9F5+u/94jkQMpgWWNR3
oxBpHIz/6OfWntlJTTNV90qjKcxMaQ==
=J1st
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--


