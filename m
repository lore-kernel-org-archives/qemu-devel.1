Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4015C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:31:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728FC21530
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728FC21530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38203 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hONbQ-00057G-Ov
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 10:31:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hONaZ-0004gT-CH
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hONaY-0003Ok-6W
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:30:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hONaV-0003Jv-SH; Wed, 08 May 2019 10:30:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2CF973003B44;
	Wed,  8 May 2019 14:30:27 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
	[10.33.200.226])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 26EDD600D4;
	Wed,  8 May 2019 14:30:24 +0000 (UTC)
Date: Wed, 8 May 2019 16:30:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190508143022.GG15525@dhcp-200-226.str.redhat.com>
References: <20190506194753.12464-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190506194753.12464-1-mreitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Wed, 08 May 2019 14:30:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/7] block: Ignore loosening perm
 restrictions failures
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 06.05.2019 um 21:47 hat Max Reitz geschrieben:
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
> The last patch adds two assertions: bdrv_replace_child() (for the old
> BDS) and bdrv_inactivate_recurse() assume they only ever drop
> assertions.  This is now substantiated by these new assertions.
> It turns out that this assumption was just plain wrong.  Patches 3 to 5
> make it right.

There are some places in this series that were a bit confusing (just
because the whole permission mechanism is rather confusing). I suggested
improvements for two patches, and deleted the half-written mails for the
rest. After all, it does look correct to me, so whether you want to
address my comments or not:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>

