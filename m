Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EE6CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:00:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 896D321929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTOMigiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896D321929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO151-0001U0-Ow
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 11:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iO0gq-00007e-Ta
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iO0gn-0007jO-4P
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:35:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26917
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iO0gl-0007hG-79
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572014138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=//S7heuOXrs/TWIiLY96qJFa281s81WtZdXKcTvxLZE=;
 b=LTOMigiNqoM8qBWRA4eR/6NkT8XBzEKy0jRtfbtIV4tOfmmLnc0dzzCH9J16P2JyhbPZS+
 d+PgD/JTjXvjQpKdEl9+dg2SyzjN9fsc5fsk4Hq+YvyvlGiuXO9pI6kRzQD9UNuHZbR5Bb
 nGwSAU7xLIMn0jnWFQmm9SVk8Ec1TkY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-tX1HUx_9Of6_INhIp1TPvw-1; Fri, 25 Oct 2019 10:35:25 -0400
X-MC-Unique: tX1HUx_9Of6_INhIp1TPvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CC751800E01;
 Fri, 25 Oct 2019 14:35:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-223.ams2.redhat.com
 [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65F5110013A1;
 Fri, 25 Oct 2019 14:35:20 +0000 (UTC)
Date: Fri, 25 Oct 2019 16:35:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
Message-ID: <20191025143518.GH7275@localhost.localdomain>
References: <20191025095849.25283-1-mreitz@redhat.com>
 <02291bca-67d2-ed30-ac34-17641afbe397@virtuozzo.com>
 <d1b43c24-a443-dd19-6814-11eec43e943a@virtuozzo.com>
 <0f75cbcf-e6c7-c74c-972b-22e7760a8b5c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0f75cbcf-e6c7-c74c-972b-22e7760a8b5c@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 25.10.2019 um 16:19 hat Max Reitz geschrieben:
> On 25.10.19 15:56, Vladimir Sementsov-Ogievskiy wrote:
> > 25.10.2019 16:40, Vladimir Sementsov-Ogievskiy wrote:
> >> 25.10.2019 12:58, Max Reitz wrote:
> >>> Hi,
> >>>
> >>> It seems to me that there is a bug in Linux=E2=80=99s XFS kernel driv=
er, as
> >>> I=E2=80=99ve explained here:
> >>>
> >>> https://lists.nongnu.org/archive/html/qemu-block/2019-10/msg01429.htm=
l
> >>>
> >>> In combination with our commit c8bb23cbdbe32f, this may lead to guest
> >>> data corruption when using qcow2 images on XFS with aio=3Dnative.
> >>>
> >>> We can=E2=80=99t wait until the XFS kernel driver is fixed, we should=
 work
> >>> around the problem ourselves.
> >>>
> >>> This is an RFC for two reasons:
> >>> (1) I don=E2=80=99t know whether this is the right way to address the=
 issue,
> >>> (2) Ideally, we should detect whether the XFS kernel driver is fixed =
and
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 if so stop applying the workaround.
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 I don=E2=80=99t know how we would go about t=
his, so this series doesn=E2=80=99t do
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 it.=C2=A0 (Hence it=E2=80=99s an RFC.)
> >>> (3) Perhaps it=E2=80=99s a bit of a layering violation to let the fil=
e-posix
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 driver access and modify a BdrvTrackedReques=
t object.
> >>>
> >>> As for how we can address the issue, I see three ways:
> >>> (1) The one presented in this series: On XFS with aio=3Dnative, we ex=
tend
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 tracked requests for post-EOF fallocate() ca=
lls (i.e., write-zero
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 operations) to reach until infinity (INT64_M=
AX in practice), mark
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 them serializing and wait for other conflict=
ing requests.
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 Advantages:
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 + Limits the impact to very specific cases
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (And that means it wouldn=E2=80=
=99t hurt too much to keep this workaround
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 even when the XFS driver has bee=
n fixed)
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 + Works around the bug where it happens, nam=
ely in file-posix
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 Disadvantages:
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 - A bit complex
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 - A bit of a layering violation (should file=
-posix have access to
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracked requests?)
> >>>
> >>> (2) Always skip qcow2=E2=80=99s handle_alloc_space() on XFS.=C2=A0 Th=
e XFS bug only
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 becomes visible due to that function: I don=
=E2=80=99t think qcow2 writes
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 zeroes in any other I/O path, and raw images=
 are fixed in size so
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 post-EOF writes won=E2=80=99t happen.
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 Advantages:
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 + Maybe simpler, depending on how difficult =
it is to handle the
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 layering violation
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 + Also fixes the performance problem of hand=
le_alloc_space() being
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 slow on ppc64+XFS.
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 Disadvantages:
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 - Huge layering violation because qcow2 woul=
d need to know whether
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the image is stored on XFS or no=
t.
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 - We=E2=80=99d definitely want to skip this =
workaround when the XFS driver
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 has been fixed, so we need some =
method to find out whether it has
> >>>
> >>> (3) Drop handle_alloc_space(), i.e. revert c8bb23cbdbe32f.
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 To my knowledge I=E2=80=99m the only one who=
 has provided any benchmarks for
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 this commit, and even then I was a bit skept=
ical because it performs
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 well in some cases and bad in others.=C2=A0 =
I concluded that it=E2=80=99s
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 probably worth it because the =E2=80=9Csome =
cases=E2=80=9D are more likely to occur.
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 Now we have this problem of corruption here =
(granted due to a bug in
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 the XFS driver), and another report of massi=
vely degraded
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 performance on ppc64
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 (https://bugzilla.redhat.com/show_bug.cgi?id=
=3D1745823 =E2=80=93 sorry, a
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 private BZ; I hate that :-/=C2=A0 The report=
 is about 40 % worse
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 performance for an in-guest fio write benchm=
ark.)
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 So I have to ask the question about what the=
 justification for
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 keeping c8bb23cbdbe32f is.=C2=A0 How much do=
es performance increase with
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 it actually?=C2=A0 (On non-(ppc64+XFS) machi=
nes, obviously)
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 Advantages:
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 + Trivial
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 + No layering violations
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 + We wouldn=E2=80=99t need to keep track of =
whether the kernel bug has been
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fixed or not
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 + Fixes the ppc64+XFS performance problem
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 Disadvantages:
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 - Reverts cluster allocation performance to =
pre-c8bb23cbdbe32f
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 levels, whatever that means
> >>>
> >>> So this is the main reason this is an RFC: What should we do?=C2=A0 I=
s (1)
> >>> really the best choice?
> >>>
> >>>
> >>> In any case, I=E2=80=99ve ran the test case I showed in
> >>> https://lists.nongnu.org/archive/html/qemu-block/2019-10/msg01282.htm=
l
> >>> more than ten times with this series applied and the installation
> >>> succeeded every time.=C2=A0 (Without this series, it fails like every=
 other
> >>> time.)
> >>>
> >>>
> >>
> >> Hi!
> >>
> >> First, great thanks for your investigation!
> >>
> >> We need c8bb23cbdbe3 patch, because we use 1M clusters, and zeroing 1M=
 is significant
> >> in time.
> >>
> >> I've tested a bit:
> >>
> >> test:
> >> for img in /ssd/test.img /test.img; do for cl in 64K 1M; do for step i=
n 4K 64K 1M; do ./qemu-img create -f qcow2 -o cluster_size=3D$cl $img 15G >=
 /dev/null; printf '%-15s%-7s%-10s : ' $img cl=3D$cl step=3D$step; ./qemu-i=
mg bench -c $((15 * 1024)) -n -s 4K -S $step -t none -w $img | tail -1 | aw=
k '{print $4}'; done; done; done
> >>
> >> on master:
> >>
> >> /ssd/test.img=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=A0=C2=A0 : 0.291
> >> /ssd/test.img=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=A0 : 0.813
> >> /ssd/test.img=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=A0=C2=A0 : 2.799
> >> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=C2=A0=C2=A0 : 0.217
> >> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=A0=C2=A0 : 0.332
> >> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=C2=A0=C2=A0 : 0.685
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=A0=
=C2=A0 : 1.751
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=
=A0 : 14.811
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=A0=
=C2=A0 : 18.321
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=
=C2=A0=C2=A0 : 0.759
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=A0=
=C2=A0 : 13.574
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=
=C2=A0=C2=A0 : 28.970
> >>
> >> rerun on master:
> >>
> >> /ssd/test.img=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=A0=C2=A0 : 0.295
> >> /ssd/test.img=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=A0 : 0.803
> >> /ssd/test.img=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=A0=C2=A0 : 2.921
> >> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=C2=A0=C2=A0 : 0.233
> >> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=A0=C2=A0 : 0.321
> >> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=C2=A0=C2=A0 : 0.762
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=A0=
=C2=A0 : 1.873
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=
=A0 : 15.621
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=A0=
=C2=A0 : 18.428
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=
=C2=A0=C2=A0 : 0.883
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=A0=
=C2=A0 : 13.484
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=
=C2=A0=C2=A0 : 26.244
> >>
> >>
> >> on master + revert c8bb23cbdbe32f5c326
> >>
> >> /ssd/test.img=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=A0=C2=A0 : 0.395
> >> /ssd/test.img=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=A0 : 4.231
> >> /ssd/test.img=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=A0=C2=A0 : 5.598
> >> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=C2=A0=C2=A0 : 0.352
> >> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=A0=C2=A0 : 2.519
> >> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=C2=A0=C2=A0 : 38.919
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=A0=
=C2=A0 : 1.758
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=
=A0 : 9.838
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=A0=
=C2=A0 : 13.384
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=
=C2=A0=C2=A0 : 1.849
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=A0=
=C2=A0 : 19.405
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=
=C2=A0=C2=A0 : 157.090
> >>
> >> rerun:
> >>
> >> /ssd/test.img=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=A0=C2=A0 : 0.407
> >> /ssd/test.img=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=A0 : 3.325
> >> /ssd/test.img=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=A0=C2=A0 : 5.641
> >> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=C2=A0=C2=A0 : 0.346
> >> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=A0=C2=A0 : 2.583
> >> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=C2=A0=C2=A0 : 39.692
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=A0=
=C2=A0 : 1.727
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=
=A0 : 10.058
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=A0=
=C2=A0 : 13.441
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=
=C2=A0=C2=A0 : 1.926
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=A0=
=C2=A0 : 19.738
> >> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=
=C2=A0=C2=A0 : 158.268
> >>
> >>
> >> So, it's obvious that c8bb23cbdbe32f5c326 is significant for 1M cluste=
r-size, even on rotational
> >> disk, which means that previous assumption about calling handle_alloc_=
space() only for ssd is
> >> wrong, we need smarter heuristics..
> >>
> >> So, I'd prefer (1) or (2).
>=20
> OK.  I wonder whether that problem would go away with Berto=E2=80=99s sub=
cluster
> series, though.
>=20
> > About degradation in some cases: I think the problem is that one (a bit=
 larger)
> > write may be faster than fast-write-zeroes + small write, as the latter=
 means
> > additional write to metadata. And it's expected for small clusters in
> > conjunction with rotational disk. But the actual limit is dependent on =
specific
> > disk. So, I think possible solution is just sometimes try work with
> > handle_alloc_space and sometimes without, remember time and length of r=
equest
> > and make dynamic limit...
>=20
> Maybe make a decision based both on the ratio of data size to COW area
> length (only invoke handle_alloc_space() under a certain threshold), and
> the absolute COW area length (always invoke it above a certain
> threshold, unless the ratio doesn=E2=80=99t allow it)?

I'm not sure that I would like this level of complexity in this code
path...

Kevin

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdswgmAAoJEH8JsnLIjy/WI68P/jKKfTbn9jcjJyEp938B5kbG
Xs+pjc2+dAP0LOwMSK2fbVd2A9bticUXIUmecWopo7u7shRFF/PHEakXVjgvvDZP
8KNUUHVdKUe6Sevr/Fzw7z2B1iBjpUO0EkG4cBHhcCQ0XgG/OG6mMye4ZOXKMtqZ
QjjQBck1ZF/zksGLdJn1+OsS930RW4NyKIXrcCoV1Ls5K1VIvb10Z08J4VaB9PaS
Bj7r6nFaOb6DRmB2KX2OZL8PvBYJC2zDP87UIJ4p0eslNRXJuRZtiBow3sveof9j
9NgO4uqw2h4xSn1a5OTMCtlm8ZqQ+lLkHNDU+Ze7BUfrxkSZIqB1Wc4D54p+ndRM
GFqNgtPC/smkLgo+NX8Gqf6h2B4sjBNPCeYNbH8wRde5mcqtMtHOIkDgcCG1EaFs
vLHfK2U3IF4sS1a1Xt82eJOAHnozcIdzHOvmCsbLEMN3mt+6YIjX0NeoiSZeXEKL
E3sqO0zCMn5pj4uxcdJV51hK1FtT46UGdnzvAVA3a4qTHrPjP6vbVGr4uskHDHir
bfQOXiWCvUTpkr4SEihHzxtv6SBnGndzGtZT8d2/tWG9OBC2Cdz9fw9g8B7zl9oC
dAH+klI0ha1tMtjpdJOp/98CcLBiKvYa1fzYcMSzbDuFuFLcJAzFDuJh9N46mSkz
dNS2PBIqI+YGv/0UE/9z
=+Gkc
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--


