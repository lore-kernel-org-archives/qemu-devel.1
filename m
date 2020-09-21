Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE0DC43468
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:58:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3BCD2223E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1WmXa9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BCD2223E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKP95-0001ku-U3
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 12:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKP8L-0000nZ-2V
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:57:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51068
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKP8J-0003Ja-3D
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600707462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5MfEfNq8YGkcJm5IHfh7cX++MIhO0mz/McrVOcdHVVk=;
 b=J1WmXa9IwA/H3ZrpDkalJZQkHn2JY5cfCG/1Tng476wYei+8hbjhALUSAVSDUiVFs0dUYh
 l1YpkR/NStXYlsSMfNnsLGraL4MqVYZnL20ZitplsFYGo7bUnj6iqIQbY/iLLTmz0/s30v
 TBeREyM/MATCiAc8sGR8Y+Lufj/FkvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-bOeVppUjMaCY7qqkV2QkPA-1; Mon, 21 Sep 2020 12:57:39 -0400
X-MC-Unique: bOeVppUjMaCY7qqkV2QkPA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEC77107465E
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 16:57:37 +0000 (UTC)
Received: from localhost (ovpn-112-39.ams2.redhat.com [10.36.112.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 863EE1A800;
 Mon, 21 Sep 2020 16:57:34 +0000 (UTC)
Date: Mon, 21 Sep 2020 17:57:33 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: tools/virtiofs: Multi threading seems to hurt performance
Message-ID: <20200921165733.GA189810@stefanha-x1.localdomain>
References: <20200918213436.GA3520@redhat.com>
 <20200921083923.GA71121@stefanha-x1.localdomain>
 <20200921133944.GB13362@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200921133944.GB13362@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 11:10:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2020 at 09:39:44AM -0400, Vivek Goyal wrote:
> On Mon, Sep 21, 2020 at 09:39:23AM +0100, Stefan Hajnoczi wrote:
> > On Fri, Sep 18, 2020 at 05:34:36PM -0400, Vivek Goyal wrote:
> > > And here are the comparision results. To me it seems that by default
> > > we should switch to 1 thread (Till we can figure out how to make
> > > multi thread performance better even when single process is doing
> > > I/O in client).
> >=20
> > Let's understand the reason before making changes.
> >=20
> > Questions:
> >  * Is "1-thread" --thread-pool-size=3D1?
>=20
> Yes.

Okay, I wanted to make sure 1-thread is still going through the glib
thread pool. So it's the same code path regardless of the
--thread-pool-size=3D value. This suggests the performance issue is
related to timing side-effects like lock contention, thread scheduling,
etc.

> >  * How do the kvm_stat vmexit counters compare?
>=20
> This should be same, isn't it. Changing number of threads serving should
> not change number of vmexits?

There is batching at the virtio and eventfd levels. I'm not sure if it's
coming into play here but you would see it by comparing vmexits and
eventfd reads. Having more threads can increase the number of
notifications and completion interrupt, which can make overall
performance worse in some cases.

> >  * How does host mpstat -P ALL compare?
>=20
> Never used mpstat. Will try running it and see if I can get something
> meaningful.

Tools like top, vmstat, etc can give similar information. I'm wondering
what the host CPU utilization (guest/sys/user) looks like.

> But I suepct it has to do with thread pool implementation and possibly
> extra cacheline bouncing.

I think perf can record cacheline bounces if you want to check.

Stefan

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9o230ACgkQnKSrs4Gr
c8gVwgf+OJBcIY86ciAhejGlGT0sFDeY62sC2thZr4KeUmDaCRDZb8C/46Gm3LNA
9Qlmh9ALdEbpK/INXV06JPKSkC5HYmiSpTcChzvltJ3B4RvhkgCsEEC+P3eKsqCd
pYgE96xH6uCWxGMQx3OifYoumjYdtCrN3kVOxKEEa7HYTkVYSk2zbKemLt3ASkpn
kG9XPO9WBthP/Zr1tuI5PnqkqBHcTcHe5/Fe36YGeKBODz6pOytsFt5O1mys/1xy
e4OYdKgdlI4jDKNUP2/02bCVsc0T5+V0EhavV+fyMAWEHFXftGOlcArjTQpww/uN
xB2QbKZxajPwg/KKNRfGhIMD0c+V2A==
=q61H
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--


