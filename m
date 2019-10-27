Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C451ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 14:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DFE8214AF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 14:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcQCaUPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFE8214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOjrt-0007xT-Fe
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 10:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iOjmM-0001m7-BX
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 10:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iOjmI-0002em-VN
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 10:44:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58440
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iOjmI-0002d4-Ji
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 10:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572187461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PKwNLhpM4G6KmdLszZN5ByskgzNxx4kR8thGkw7ZPZw=;
 b=ZcQCaUPNkk7v40X4EhkfBC3X1FftUcx0i8bFdSVMWsSuWjRaOq3FkNST4bEe856BwBx41m
 9AzgqU7gDG04ZFK5BkUm+YdwpaqyZo7xSFbw83CBMv4wvzxJJ/JaW+AlhE7jgv6BRTfkVA
 HrBdOCfrZSXR1KkXZMqVFattOYODdFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-5AzcuMRlNpWj9W1ebZgFIw-1; Sun, 27 Oct 2019 10:44:16 -0400
X-MC-Unique: 5AzcuMRlNpWj9W1ebZgFIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B58FB107AD28;
 Sun, 27 Oct 2019 14:44:15 +0000 (UTC)
Received: from localhost (ovpn-116-99.ams2.redhat.com [10.36.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3228194B2;
 Sun, 27 Oct 2019 14:44:14 +0000 (UTC)
Date: Sun, 27 Oct 2019 13:21:09 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
Message-ID: <20191027122109.GM4472@stefanha-x1.localdomain>
References: <20191025095849.25283-1-mreitz@redhat.com>
 <02291bca-67d2-ed30-ac34-17641afbe397@virtuozzo.com>
 <d1b43c24-a443-dd19-6814-11eec43e943a@virtuozzo.com>
 <0f75cbcf-e6c7-c74c-972b-22e7760a8b5c@redhat.com>
 <b7d38bf4-19f0-8d3c-8ecf-19527459eb50@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <b7d38bf4-19f0-8d3c-8ecf-19527459eb50@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="n1iI6MeELQa9IOaF"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--n1iI6MeELQa9IOaF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2019 at 02:36:49PM +0000, Vladimir Sementsov-Ogievskiy wrot=
e:
> 25.10.2019 17:19, Max Reitz wrote:
> > On 25.10.19 15:56, Vladimir Sementsov-Ogievskiy wrote:
> >> 25.10.2019 16:40, Vladimir Sementsov-Ogievskiy wrote:
> >>> 25.10.2019 12:58, Max Reitz wrote:
> >>>> Hi,
> >>>>
> >>>> It seems to me that there is a bug in Linux=E2=80=99s XFS kernel dri=
ver, as
> >>>> I=E2=80=99ve explained here:
> >>>>
> >>>> https://lists.nongnu.org/archive/html/qemu-block/2019-10/msg01429.ht=
ml
> >>>>
> >>>> In combination with our commit c8bb23cbdbe32f, this may lead to gues=
t
> >>>> data corruption when using qcow2 images on XFS with aio=3Dnative.
> >>>>
> >>>> We can=E2=80=99t wait until the XFS kernel driver is fixed, we shoul=
d work
> >>>> around the problem ourselves.
> >>>>
> >>>> This is an RFC for two reasons:
> >>>> (1) I don=E2=80=99t know whether this is the right way to address th=
e issue,
> >>>> (2) Ideally, we should detect whether the XFS kernel driver is fixed=
 and
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 if so stop applying the workaround.
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 I don=E2=80=99t know how we would go about=
 this, so this series doesn=E2=80=99t do
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 it.=C2=A0 (Hence it=E2=80=99s an RFC.)
> >>>> (3) Perhaps it=E2=80=99s a bit of a layering violation to let the fi=
le-posix
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 driver access and modify a BdrvTrackedRequ=
est object.
> >>>>
> >>>> As for how we can address the issue, I see three ways:
> >>>> (1) The one presented in this series: On XFS with aio=3Dnative, we e=
xtend
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 tracked requests for post-EOF fallocate() =
calls (i.e., write-zero
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 operations) to reach until infinity (INT64=
_MAX in practice), mark
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 them serializing and wait for other confli=
cting requests.
> >>>>
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Advantages:
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 + Limits the impact to very specific cases
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (And that means it wouldn=E2=
=80=99t hurt too much to keep this workaround
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 even when the XFS driver has b=
een fixed)
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 + Works around the bug where it happens, n=
amely in file-posix
> >>>>
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Disadvantages:
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 - A bit complex
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 - A bit of a layering violation (should fi=
le-posix have access to
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracked requests?)
> >>>>
> >>>> (2) Always skip qcow2=E2=80=99s handle_alloc_space() on XFS.=C2=A0 T=
he XFS bug only
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 becomes visible due to that function: I do=
n=E2=80=99t think qcow2 writes
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 zeroes in any other I/O path, and raw imag=
es are fixed in size so
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 post-EOF writes won=E2=80=99t happen.
> >>>>
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Advantages:
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 + Maybe simpler, depending on how difficul=
t it is to handle the
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 layering violation
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 + Also fixes the performance problem of ha=
ndle_alloc_space() being
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 slow on ppc64+XFS.
> >>>>
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Disadvantages:
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 - Huge layering violation because qcow2 wo=
uld need to know whether
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the image is stored on XFS or =
not.
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 - We=E2=80=99d definitely want to skip thi=
s workaround when the XFS driver
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 has been fixed, so we need som=
e method to find out whether it has
> >>>>
> >>>> (3) Drop handle_alloc_space(), i.e. revert c8bb23cbdbe32f.
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 To my knowledge I=E2=80=99m the only one w=
ho has provided any benchmarks for
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 this commit, and even then I was a bit ske=
ptical because it performs
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 well in some cases and bad in others.=C2=
=A0 I concluded that it=E2=80=99s
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 probably worth it because the =E2=80=9Csom=
e cases=E2=80=9D are more likely to occur.
> >>>>
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Now we have this problem of corruption her=
e (granted due to a bug in
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 the XFS driver), and another report of mas=
sively degraded
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 performance on ppc64
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 (https://bugzilla.redhat.com/show_bug.cgi?=
id=3D1745823 =E2=80=93 sorry, a
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 private BZ; I hate that :-/=C2=A0 The repo=
rt is about 40 % worse
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 performance for an in-guest fio write benc=
hmark.)
> >>>>
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 So I have to ask the question about what t=
he justification for
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 keeping c8bb23cbdbe32f is.=C2=A0 How much =
does performance increase with
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 it actually?=C2=A0 (On non-(ppc64+XFS) mac=
hines, obviously)
> >>>>
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Advantages:
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 + Trivial
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 + No layering violations
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 + We wouldn=E2=80=99t need to keep track o=
f whether the kernel bug has been
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fixed or not
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 + Fixes the ppc64+XFS performance problem
> >>>>
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Disadvantages:
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 - Reverts cluster allocation performance t=
o pre-c8bb23cbdbe32f
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 levels, whatever that means
> >>>>
> >>>> So this is the main reason this is an RFC: What should we do?=C2=A0 =
Is (1)
> >>>> really the best choice?
> >>>>
> >>>>
> >>>> In any case, I=E2=80=99ve ran the test case I showed in
> >>>> https://lists.nongnu.org/archive/html/qemu-block/2019-10/msg01282.ht=
ml
> >>>> more than ten times with this series applied and the installation
> >>>> succeeded every time.=C2=A0 (Without this series, it fails like ever=
y other
> >>>> time.)
> >>>>
> >>>>
> >>>
> >>> Hi!
> >>>
> >>> First, great thanks for your investigation!
> >>>
> >>> We need c8bb23cbdbe3 patch, because we use 1M clusters, and zeroing 1=
M is significant
> >>> in time.
> >>>
> >>> I've tested a bit:
> >>>
> >>> test:
> >>> for img in /ssd/test.img /test.img; do for cl in 64K 1M; do for step =
in 4K 64K 1M; do ./qemu-img create -f qcow2 -o cluster_size=3D$cl $img 15G =
> /dev/null; printf '%-15s%-7s%-10s : ' $img cl=3D$cl step=3D$step; ./qemu-=
img bench -c $((15 * 1024)) -n -s 4K -S $step -t none -w $img | tail -1 | a=
wk '{print $4}'; done; done; done
> >>>
> >>> on master:
> >>>
> >>> /ssd/test.img=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=A0=C2=A0 : 0.291
> >>> /ssd/test.img=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=A0 : 0.813
> >>> /ssd/test.img=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=A0=C2=A0 : 2.799
> >>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=C2=A0=C2=A0 : 0.217
> >>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=A0=C2=A0 : 0.332
> >>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=C2=A0=C2=A0 : 0.685
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=
=A0=C2=A0 : 1.751
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=
=A0 : 14.811
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=
=A0=C2=A0 : 18.321
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=
=C2=A0=C2=A0 : 0.759
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=
=A0=C2=A0 : 13.574
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=
=C2=A0=C2=A0 : 28.970
> >>>
> >>> rerun on master:
> >>>
> >>> /ssd/test.img=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=A0=C2=A0 : 0.295
> >>> /ssd/test.img=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=A0 : 0.803
> >>> /ssd/test.img=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=A0=C2=A0 : 2.921
> >>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=C2=A0=C2=A0 : 0.233
> >>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=A0=C2=A0 : 0.321
> >>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=C2=A0=C2=A0 : 0.762
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=
=A0=C2=A0 : 1.873
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=
=A0 : 15.621
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=
=A0=C2=A0 : 18.428
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=
=C2=A0=C2=A0 : 0.883
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=
=A0=C2=A0 : 13.484
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=
=C2=A0=C2=A0 : 26.244
> >>>
> >>>
> >>> on master + revert c8bb23cbdbe32f5c326
> >>>
> >>> /ssd/test.img=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=A0=C2=A0 : 0.395
> >>> /ssd/test.img=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=A0 : 4.231
> >>> /ssd/test.img=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=A0=C2=A0 : 5.598
> >>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=C2=A0=C2=A0 : 0.352
> >>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=A0=C2=A0 : 2.519
> >>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=C2=A0=C2=A0 : 38.91=
9
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=
=A0=C2=A0 : 1.758
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=
=A0 : 9.838
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=
=A0=C2=A0 : 13.384
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=
=C2=A0=C2=A0 : 1.849
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=
=A0=C2=A0 : 19.405
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=
=C2=A0=C2=A0 : 157.090
> >>>
> >>> rerun:
> >>>
> >>> /ssd/test.img=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=A0=C2=A0 : 0.407
> >>> /ssd/test.img=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=A0 : 3.325
> >>> /ssd/test.img=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=A0=C2=A0 : 5.641
> >>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=C2=A0=C2=A0 : 0.346
> >>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=A0=C2=A0 : 2.583
> >>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=C2=A0=C2=A0 : 39.69=
2
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=
=A0=C2=A0 : 1.727
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=
=A0 : 10.058
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=
=A0=C2=A0 : 13.441
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=
=C2=A0=C2=A0 : 1.926
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=
=A0=C2=A0 : 19.738
> >>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=
=C2=A0=C2=A0 : 158.268
> >>>
> >>>
> >>> So, it's obvious that c8bb23cbdbe32f5c326 is significant for 1M clust=
er-size, even on rotational
> >>> disk, which means that previous assumption about calling handle_alloc=
_space() only for ssd is
> >>> wrong, we need smarter heuristics..
> >>>
> >>> So, I'd prefer (1) or (2).
> >=20
> > OK.  I wonder whether that problem would go away with Berto=E2=80=99s s=
ubcluster
> > series, though.
>=20
> Very possible, I thought about it too.
>=20
> >=20
> >> About degradation in some cases: I think the problem is that one (a bi=
t larger)
> >> write may be faster than fast-write-zeroes + small write, as the latte=
r means
> >> additional write to metadata. And it's expected for small clusters in
> >> conjunction with rotational disk. But the actual limit is dependent on=
 specific
> >> disk. So, I think possible solution is just sometimes try work with
> >> handle_alloc_space and sometimes without, remember time and length of =
request
> >> and make dynamic limit...
> >=20
> > Maybe make a decision based both on the ratio of data size to COW area
> > length (only invoke handle_alloc_space() under a certain threshold), an=
d
> > the absolute COW area length (always invoke it above a certain
> > threshold, unless the ratio doesn=E2=80=99t allow it)?
> >=20
>=20
> Yes, something like this..
>=20
> without handle_alloc_space, time =3D time(write aligned up to cluster)
> with handle_alloc_space, time =3D time(fast zero write) + time(original w=
rite)
>=20
> If we have some statistics on normal-write vs zero-write timing, we can j=
ust
> calculate both variants and choose faster.
>=20
> if (predict_zero_write_time(aligned up request) + predict_write_time(requ=
est) < predict_write_time(aligned up request)) {
>     use handle_alloc_space()
> }

Self-tuning based on request latency works great on a quiet host.  If
there are other processes submitting I/O to the disk then measured
latencies may be bogus.

Stefan

--n1iI6MeELQa9IOaF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl21i7UACgkQnKSrs4Gr
c8iUVAf/Z5yZg04UkgnJW47uTLvEuni/fSTB+NLcXRqLGiOyy/YQY5cj4XV32MXa
guce6yB3Aa0aXF2QrINf/rE6+d0FhDc477CR4xIY9MFYqkxrrdrkQfrAFqC7TAJo
FofZcVagUTHXmKUt/PWAkFLkfx0E/2T19UP23eZTtfXpSbKv1J8S7H7QaKXfm8ZD
QArDfPPpby5a4qFMcraY9Qbuq1gpELcKDJ5RtU6Qdy+LjHAQjjGSRBFtguDWsJEh
IrjspW/y0LQH8qzLH31zLC5I4qBRD9AD4pB3Ob8dT1orfNudmHjRujwDb/1Xt7kT
AOtQCGVU0yCizF2SPKyAdockyN82Xg==
=KCV8
-----END PGP SIGNATURE-----

--n1iI6MeELQa9IOaF--


