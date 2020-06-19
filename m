Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A62C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:18:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B60F720809
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpriG532"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60F720809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmAM6-0006lz-VF
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 02:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jmALG-0005hO-HE
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:17:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37759
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jmALE-0007sU-4f
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592547450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kil0GuNJGgVUF7Q+wrTmWzmuvw88BIRlxtq9UNyMBsc=;
 b=YpriG532H/HBNnhPyaEpr6luWosGkGqepCaghnt+VSURpIkpGPeYO8CnvSPzBNqZ169wCl
 GuLID7zNmWnJnmbayYW2aYwntKZiW27DDflIp15Fpt0Mx2BDPPbckrZuIXshJkUouaFhsA
 UNgNVQM6zCrZuYWUVmOETBdGZHSWrPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-pPWltBTkN1WpXyjiOr3wEQ-1; Fri, 19 Jun 2020 02:17:28 -0400
X-MC-Unique: pPWltBTkN1WpXyjiOr3wEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76C788015CB;
 Fri, 19 Jun 2020 06:17:27 +0000 (UTC)
Received: from gondolin (ovpn-112-224.ams2.redhat.com [10.36.112.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39D00709D7;
 Fri, 19 Jun 2020 06:17:26 +0000 (UTC)
Date: Fri, 19 Jun 2020 08:17:23 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [Bug 1883560] [NEW] mips linux-user builds occasionly crash
 randomly only to be fixed by a full clean re-build
Message-ID: <20200619081723.10594336.cohuck@redhat.com>
In-Reply-To: <CAHiYmc5eJDN-FmBZOtRCM9446mxLZW_JtWdZw7TmSYMsk8iz8Q@mail.gmail.com>
References: <159223432851.7281.13140123017230519248.malonedeb@gac.canonical.com>
 <20200618135331.7ec861e9.cohuck@redhat.com>
 <CAHiYmc5eJDN-FmBZOtRCM9446mxLZW_JtWdZw7TmSYMsk8iz8Q@mail.gmail.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:50:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <1883560@bugs.launchpad.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 18 Jun 2020 19:00:34 +0200
Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> wrote:

> =D1=87=D0=B5=D1=82=D0=B2=D1=80=D1=82=D0=B0=D0=BA, 18. =D1=98=D1=83=D0=BD =
2020., Cornelia Huck <cohuck@redhat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>=20
> > On Mon, 15 Jun 2020 15:18:48 -0000
> > Alex Benn=C3=A9e <1883560@bugs.launchpad.net> wrote:
> > =20
> > > Public bug reported:
> > > =20
> > > >From time to time I find check-tcg crashes with a one of the MIPS =
=20
> > > binaries. The last time it crashed was running the test:
> > >
> > >   ./mips64el-linux-user/qemu-mips64el ./tests/tcg/mips64el-linux-
> > > user/threadcount
> > >
> > > Inevitably after some time noodling around wondering what could be
> > > causing this weird behaviour I wonder if it is a build issue. I wipe =
all
> > > the mips* build directories, re-run configure and re-build and voila
> > > problem goes away.
> > >
> > > It seems there must be some sort of build artefact which isn't being
> > > properly re-generated on a build update which causes weird problems.
> > > Additional data point if I:
> > >
> > >   rm -rf mips64el-linux-user
> > >   ../../configure
> > >   make
> > >
> > > then I see failures in mip32 builds - eg:
> > >
> > >     GEN     mipsn32el-linux-user/config-target.h
> > >   In file included from /home/alex/lsrc/qemu.git/ =20
> > linux-user/syscall_defs.h:10, =20
> > >                    from /home/alex/lsrc/qemu.git/linux-user/qemu.h:16=
,
> > >                    from /home/alex/lsrc/qemu.git/ =20
> > linux-user/linuxload.c:5: =20
> > >   /home/alex/lsrc/qemu.git/linux-user/mips64/syscall_nr.h:1: error: =
=20
> > unterminated #ifndef =20
> > >    #ifndef LINUX_USER_MIPS64_SYSCALL_NR_H
> > >
> > >   make[1]: *** [/home/alex/lsrc/qemu.git/rules.mak:69: =20
> > linux-user/linuxload.o] Error 1 =20
> > >   make[1]: *** Waiting for unfinished jobs....
> > >
> > > which implies there is a cross dependency between different targets
> > > somewhere. If I executed:
> > >
> > >   rm -rf mips*
> > >
> > > before re-configuring and re-building then everything works again.
> > >
> > > ** Affects: qemu
> > >      Importance: Undecided
> > >          Status: New
> > >
> > >
> > > ** Tags: build linux-user mips
> > > =20
> >
> > FWIW, this does not seem to be a mips-only issue: I'm seeing the
> > threadcount test fail with s390x-linux-user as well, and it also goes
> > away (only) if I purge the build directory, re-configure, and re-build.
> >
> >
> > =20
> Alex, Cornelia,
>=20
> Do you perhaps recall how did you obtain the original binaries (those wit=
h
> the problem)? What would be your typical workflow? Perhaps "git-pull +
> make" on existing, but not latest source tree?

Just a bog-standard "pull some stuff, do make, create a branch and put
some patches on it, do make, switch to another branch, do make, etc". No
advanced fiddling with git history, doing make on a subtree, etc.


