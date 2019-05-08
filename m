Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C0DC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098DD205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098DD205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38512 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hONw5-0000Tj-CL
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 10:52:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hONrj-0005k8-Fp
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hONri-0004Py-Gg
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:48:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hONrg-0004OU-E7; Wed, 08 May 2019 10:48:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B84C430024DB;
	Wed,  8 May 2019 14:48:11 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
	[10.33.200.226])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A73E25D9D1;
	Wed,  8 May 2019 14:48:10 +0000 (UTC)
Date: Wed, 8 May 2019 16:48:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190508144809.GI15525@dhcp-200-226.str.redhat.com>
References: <20190508140139.32722-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190508140139.32722-1-mreitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Wed, 08 May 2019 14:48:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/3] qemu-img: Allow rebase with no
 input base
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 08.05.2019 um 16:01 hat Max Reitz geschrieben:
> This series allows using qemu-img rebase (without -u) on images that do
> not have a backing file.  Right now, this fails with the rather cryptic
> error message:
>=20
> $ qemu-img rebase -b base.qcow2 foo.qcow2
> qemu-img: Could not open old backing file '': The 'file' block driver r=
equires a file name
>=20
> Yeah, well, OK.
>=20
> With how rebase currently works, this would lead to the overlay being
> filled with zeroes, however.  This is where patch 2 comes in and instea=
d
> makes rebase use blk_pwrite_zeroes() whenever it handles an area past
> the input=E2=80=99s backing file=E2=80=99s EOF.
>=20
> (Note that additionally we could try to punch holes in the overlay
> whenever it matches the new backing file, but that=E2=80=99s something =
I=E2=80=99ll put
> off for later.  (We don=E2=80=99t even have a reliable method for punch=
ing holes
> into an overlay yet, although I would like to have such because it coul=
d
> make active commit more efficient.))
>=20
> And patch 3 adds the usual test.

Thanks, applied to the block branch.

Kevin

