Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6833BC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34AB320708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aHjIm+Bm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AB320708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1YJA-0006QS-Du
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 11:22:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j1YHa-0004mY-U3
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j1YHY-0004jS-W6
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:21:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36895
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j1YHY-0004hp-P9
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581438064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oq8ywGPN9R6DPfdA+fD4opif7I8exgbPTy3twwyuABE=;
 b=aHjIm+BmWRgtU/UO7qYYqzjAJz3Cug6e9vbxnsGsxDqPAcZIYp4lwlWmTbCDtkv5K4s0AS
 /QEEM+2eLNhlmxXgr18sQXVpYKvDf8GyTqa3G/jdhhNHR0b9KdnKb4z8kv9z0aLWy3WrZQ
 btd7Ia/3AKJzPyPK9DV5RwnotDy/dfU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-2KsQ-kwyNy-dUQmTiGmb_Q-1; Tue, 11 Feb 2020 11:20:55 -0500
X-MC-Unique: 2KsQ-kwyNy-dUQmTiGmb_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE24D8010EB;
 Tue, 11 Feb 2020 16:20:54 +0000 (UTC)
Received: from localhost (unknown [10.36.118.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E69E8100EBAF;
 Tue, 11 Feb 2020 16:20:42 +0000 (UTC)
Date: Tue, 11 Feb 2020 16:20:41 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v2 2/4] virtio-scsi: default num_queues to -smp N
Message-ID: <20200211162041.GA432724@stefanha-x1.localdomain>
References: <20200124100159.736209-1-stefanha@redhat.com>
 <20200124100159.736209-3-stefanha@redhat.com>
 <20200127141031.6e108839.cohuck@redhat.com>
 <20200129154438.GC157595@stefanha-x1.localdomain>
 <bc9680fc-c382-301f-a1fe-21740c918570@redhat.com>
 <20200130105235.GC176651@stefanha-x1.localdomain>
 <20200203102529.3op54zggtquoguuo@dritchie>
 <20200203105744.GD1922177@redhat.com>
 <20200203113949.hnjuqzkrqqwst54e@dritchie>
MIME-Version: 1.0
In-Reply-To: <20200203113949.hnjuqzkrqqwst54e@dritchie>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2020 at 12:39:49PM +0100, Sergio Lopez wrote:
> On Mon, Feb 03, 2020 at 10:57:44AM +0000, Daniel P. Berrang=E9 wrote:
> > On Mon, Feb 03, 2020 at 11:25:29AM +0100, Sergio Lopez wrote:
> > > On Thu, Jan 30, 2020 at 10:52:35AM +0000, Stefan Hajnoczi wrote:
> > > > On Thu, Jan 30, 2020 at 01:29:16AM +0100, Paolo Bonzini wrote:
> > > > > On 29/01/20 16:44, Stefan Hajnoczi wrote:
> > > > > > On Mon, Jan 27, 2020 at 02:10:31PM +0100, Cornelia Huck wrote:
> > > > > >> On Fri, 24 Jan 2020 10:01:57 +0000
> > > > > >> Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > So I think we need to, at the very least, make a clear statement here
> > about what tuning approach should be applied vCPU count gets high,
> > and probably even apply that  as a default out of the box approach.
>=20
> In general, I would agree, but in this particular case the
> optimization has an impact on something outside's QEMU control (host's
> resources), so we lack the information needed to make a proper guess.
>=20
> My main concern here is users upgrading QEMU to hit some kind of crash
> or performance issue, without having touched their VM config. And

I don't think this is an issue since only newly created guests are
affected.  Existing machine types are unchanged.

> let's not forget that Stefan said in the cover that this amounts to a
> 1-4% improvement on 4k operations on an SSD, and I guess that's with
> iodepth=3D1. I suspect with a larger block size and/or higher iodepth
> the improvement will be barely noticeable, which means it'll only have
> a positive impact on users running DB/OLTP or similar workloads on
> dedicated, directly attached, low-latency storage.
>=20
> But don't get me wrong, this is a *good* optimization. It's just I
> think we should play safe here.

The NVMe card I've been testing has 64 queues.  Let's keep the virtio
limit roughly the same as real hardware.  That way, multi-queue block
layer support in QEMU will be able to fully exploit the hardware
(similar to how we size request queues to be larger than the common 64
/sys/block/FOO/queue/nr_requests).

The point of this change is to improve performance on SMP guests.
Setting the limit to 4-8 is too low, since it leaves guests that most
need this optimization with a sub-optimal configuration.

I will create a 32 vCPU guest with 100 virtio-blk devices and verify
that enabling multi-queue is successful.

Stefan

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5C1FgACgkQnKSrs4Gr
c8iWngf+IlLS1HVeqSSyQFgo6A0mekoEFAVcIwjiopOxDQfqZ3NgTrqjkeE6XlZG
a3cLDO3WD99ZhNwOVIRO84XsRXSsfQ9nvLk9EvY2agwnICoRGKNohNZSR6Jlm2eK
wxffRuY2YypJLh8AHEXQ2eNdxHM5nUfkHPrW2vTqkcGPkxOcqQ1goqdTtvUvwXvC
VMSMsmX/FwPnR8FyHLHkECOLnZX3rWDmHko7XM/XSAo1mWXvpqk1GmHvmuGb94je
8CAFIyLC42L9FjhWRb5bIE2wZHsvJ+xwiaZ4ZRRvaHZtVB7pKJLpPETE4ulp3BFl
lrj6VQEpUaRUsR7xrNw/J6Ukk16JJw==
=Rffe
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--


