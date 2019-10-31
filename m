Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A773CA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 15:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7A0820873
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 15:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDs+iWhk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A0820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQCrQ-0007RV-6c
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 11:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1iQCfR-0006Cw-Gl
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:47:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1iQCfQ-0003QY-2O
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:47:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39377
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1iQCfP-0003OS-TJ
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572536837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/bN6qjkz7uGyQg2oZJKCbiSXw0CGxYGlLFfHV0Xaupk=;
 b=GDs+iWhk3tSX5bz6MltpHckNAaTU6xnc4dgHMckVkMvj/c4k4qLnKNQi7Xi6YiE0r5a/9l
 /divVFzkos9Mc3Z/UK6MM0raDzsrQ9UrjeCfQWjqqdc3fYt8wgIwtrkp0rEarz/uKZABRj
 mSn+GIHIHCpfDqyLgxJFCQ8r75OiM8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-BP3QQzgAMZma-0ZmYHCT1Q-1; Thu, 31 Oct 2019 11:47:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8A97800D49;
 Thu, 31 Oct 2019 15:47:13 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 092135C1C3;
 Thu, 31 Oct 2019 15:47:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 9429A2237B5; Thu, 31 Oct 2019 11:47:10 -0400 (EDT)
Date: Thu, 31 Oct 2019 11:47:10 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: Fix data corruption with O_APPEND
 wirte in writeback mode
Message-ID: <20191031154710.GB7308@redhat.com>
References: <20191023122523.1816-1-misono.tomohiro@jp.fujitsu.com>
 <20191023200752.GB6942@redhat.com>
 <20191024150225.GB6903@redhat.com>
 <OSBPR01MB3783EBE1BB481BD1B14B8D45E5650@OSBPR01MB3783.jpnprd01.prod.outlook.com>
 <OSBPR01MB37833C9325AD3D9190108FAEE5610@OSBPR01MB3783.jpnprd01.prod.outlook.com>
 <OSBPR01MB3783739E4F9545DABEF3E230E5630@OSBPR01MB3783.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB3783739E4F9545DABEF3E230E5630@OSBPR01MB3783.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: BP3QQzgAMZma-0ZmYHCT1Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: "'virtio-fs@redhat.com'" <virtio-fs@redhat.com>,
 "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 31, 2019 at 09:39:23AM +0000, misono.tomohiro@fujitsu.com wrote=
:
[..]
> > > > Hi Misono,
> > > >
> > > > Have you tried running pjdfstests. Looks like with the patch applie=
d
> > > > I see following tests failing which were passing without the patch.
> > > > Can you please have a look. I ran daemon with options "-o
> > > cache=3Dalways -o writeback"
> >=20
> > I see these errors in both with and without this patch but not always.
> > Do you always see the failure?
> >=20
> > I use:
> >   Kernel: Fuse's for-next branch
> >   Qemu: virtio-fs-dev branch
> >   backend: XFS (relatime)
> >=20
> > These tests fail because a/c/m time is not updated as expected.
> > So it seems this is related to the failure of xfstest generic/003.
> > I will look into the problem more.
> >=20
>=20
> Hi,
>=20
> So I fugured out the problem.=20
> The failure occurs when guest clock is earlier than host clock in writeba=
ck mode.
>=20
> The failure case checks:
>  1. get current c/time of file
>  2. sleep 1 second
>  3. modify file's metadata/data
>  4. check if c/mtime is updated
>=20
> And the tests fail because:
>  1. when file is opened, guest inode's time is initialized by host's inod=
e information
>  2. In writeback mode, guest clock is used for c/mtime update
>  3. if guest clock is earlier than host clock, c/mtime could be updated
>     earlier than current inode time.=20
>=20
> I can reproduce the problem reliably by deliberately setting guest clock =
earlier
> than host clock. I'm not sure if virtiofs is to be blmaed in this case, b=
ut should
> we not update c/mtime in guest if it is earlier then current c/mtime?
>=20
> Anyway, I believe this O_APPEND fix patch is irrelevant to the problem,
> could you please check it again?

Hi Misono,

Thanks for looking into it. I agree that a/c/m time updates with -o writeba=
ck
is probably a different issue and not related to your patch. So I am fine
with your patch.

Thanks
Vivek


