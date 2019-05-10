Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C877EC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 09:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AEFB20989
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 09:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEFB20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39724 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP22J-0007YX-9d
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 05:41:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hP21V-00078D-TN
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hP21P-0008G2-Lm
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:41:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hP21L-0008Bc-Dl; Fri, 10 May 2019 05:40:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F05AA3B722;
	Fri, 10 May 2019 09:40:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-183.ams2.redhat.com
	[10.36.116.183])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B888C1001E65;
	Fri, 10 May 2019 09:40:47 +0000 (UTC)
Date: Fri, 10 May 2019 11:40:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190510094046.GA5887@localhost.localdomain>
References: <20190509175237.19363-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509175237.19363-1-mreitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Fri, 10 May 2019 09:40:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 0/3] qemu-img: Allow rebase with no
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

Am 09.05.2019 um 19:52 hat Max Reitz geschrieben:
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
>=20
> And patch 3 adds the usual test.
>=20
>=20
> v3:
> - Patch 3: Move test to own file so it doesn=E2=80=99t run for qed or q=
cow2 v2
>   (because it can=E2=80=99t, it requires zero clusters)

Thanks, updated in the block branch.

Kevin

