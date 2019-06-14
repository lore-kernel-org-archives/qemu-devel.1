Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8370DC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:20:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 570C921721
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570C921721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51962 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbn3l-0001dC-IW
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 10:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53662)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hbmnA-0003O9-F7
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hbmn9-0007FL-AP
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:02:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4820)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hbmn6-0007Cc-IR; Fri, 14 Jun 2019 10:02:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3FCE4308124D;
 Fri, 14 Jun 2019 14:02:51 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BD4A67290;
 Fri, 14 Jun 2019 14:02:50 +0000 (UTC)
Date: Fri, 14 Jun 2019 16:02:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190614140249.GH6042@dhcp-200-226.str.redhat.com>
References: <20190522170352.12020-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190522170352.12020-1-mreitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 14 Jun 2019 14:02:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 0/8] block: Ignore loosening perm
 restrictions failures
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 22.05.2019 um 19:03 hat Max Reitz geschrieben:
> Hi,
>=20
> This series is mainly a fix for
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1703793.  The problem
> described there is that mirroring to a gluster volume, then switching
> off the volume makes qemu crash.  There are two problems here:
>=20
> (1) file-posix reopens the FD all the time because it thinks the FD it
>     has is RDONLY.  It actually isn=E2=80=99t after the first reopen, w=
e just
>     forgot to change the internal flags.  That=E2=80=99s what patch 1 i=
s for.
>=20
> (2) Even then, when mirror completes, it drops its write permission on
>     the FD.  This requires a reopen, which will fail if the volume is
>     down.  Mirror doesn=E2=80=99t expect that.  Nobody ever expects tha=
t
>     dropping permissions can fail, and rightfully so because that=E2=80=
=99s what
>     I think we have generally agreed on.
>     Therefore, the block layer should hide this error.  This is what th=
e
>     last two patches are for.
>=20
> The penultimate patch adds two assertions: bdrv_replace_child() (for th=
e
> old BDS) and bdrv_inactivate_recurse() assume they only ever drop
> assertions.  This is now substantiated by these new assertions.
> It turns out that this assumption was just plain wrong.  Patches 3 to 5
> make it right.

Thanks, applied to the block branch.

Kevin

