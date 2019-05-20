Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B0CC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 13:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCF2320851
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 13:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF2320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35775 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSiJf-0000Wk-T0
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 09:26:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSiIN-00080I-Us
	for qemu-devel@nongnu.org; Mon, 20 May 2019 09:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSiIM-0000Oj-VA
	for qemu-devel@nongnu.org; Mon, 20 May 2019 09:25:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hSiIJ-0000MW-QB; Mon, 20 May 2019 09:25:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED880C065135;
	Mon, 20 May 2019 13:25:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-208.ams2.redhat.com
	[10.36.117.208])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 903F25D719;
	Mon, 20 May 2019 13:25:32 +0000 (UTC)
Date: Mon, 20 May 2019 15:25:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190520132530.GF5699@localhost.localdomain>
References: <20190515041541.12367-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190515041541.12367-1-mreitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 20 May 2019 13:25:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/2] block/file-posix: Fix unaligned
 O_DIRECT block status
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 15.05.2019 um 06:15 hat Max Reitz geschrieben:
> The user-visible problem:
> $ echo > foo
> $ qemu-img map --image-opts driver=3Dfile,filename=3Dfoo,cache.direct=3D=
on
> Offset          Length          Mapped to       File
> qemu-img: block/io.c:2093: bdrv_co_block_status: Assertion `*pnum &&
> QEMU_IS_ALIGNED(*pnum, align) && align > offset - aligned_offset'
> failed.
>=20
> The internal problem: file-posix truncates status requests to the EOF.
> If the EOF is not aligned at the request_alignment,
> bdrv_co_block_status() won't like that.
>=20
> See patch 1 for a deeper discussion (including two possible alternative=
s
> how we could address the problem).
> (As I note there, I=E2=80=99ve looked through all block drivers, and I =
didn=E2=80=99t
> find any other which could have the same problem.  gluster uses the sam=
e
> block-status code, but it doesn=E2=80=99t set a request_alignment.  NBD
> force-aligns the server response in nbd_parse_blockstatus_payload().
> qcow2... Should be fine as long as no crypto driver has a block limit
> exceeding the qcow2 cluster size.  And so on.)
>=20
> Patch 2 adds a test.  After writing that test, I noticed that we alread=
y
> had one: 109 fails with -c none before patch 1.  Er, well, at least the
> new test is more succinct and has the correct default cache mode, so it
> will actually do the test if you run ./check without enforcing any cach=
e
> on a filesystem that supports O_DIRECT.

Thanks, applied to the block branch.

Kevin

