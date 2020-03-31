Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874CBC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:25:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF3420838
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwS+rkZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF3420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJFxO-0004uC-Ep
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 08:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jJFwc-0003rs-LJ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jJFwa-0002If-Gv
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:24:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36473
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jJFwZ-0002Fz-6T
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585657473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qns4HGR/d6XW4WCB/3wHbPhCk7MBnRIK91j3WGKWE+I=;
 b=MwS+rkZoTS5QUGbfRH3yERcirqdNhzGyUkZdNIDKURdmUwA8f50dI+UFFIObS/IgbeQkmt
 6K40daFxCa79uS8QKUTBMP+y+UmuxSRVr2I56wtPyrAD3nGvuVSykmqEYtlgtWHZEWlMBE
 GqXsvvzeaFWRzniXafQeLNe8uI1R4/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-bH-I0RoWPGycuSBhyk-gUA-1; Tue, 31 Mar 2020 08:24:31 -0400
X-MC-Unique: bH-I0RoWPGycuSBhyk-gUA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF7438010C8;
 Tue, 31 Mar 2020 12:24:30 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-236.ams2.redhat.com [10.36.114.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C91C5D9CA;
 Tue, 31 Mar 2020 12:24:29 +0000 (UTC)
Date: Tue, 31 Mar 2020 14:24:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: deprecation of in-tree builds
Message-ID: <20200331122428.GD7030@linux.fritz.box>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
 <20200330134212.GO236854@redhat.com>
 <20200330143759.GD6139@linux.fritz.box>
 <c0a1dc94-c3f2-696e-743f-aa15ef995094@redhat.com>
 <20200331120220.GA7030@linux.fritz.box>
 <CAFEAcA_p1T4--Re5=-x=q=cCX-8YDAk_keS72NURe3T23j89sA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_p1T4--Re5=-x=q=cCX-8YDAk_keS72NURe3T23j89sA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 31.03.2020 um 14:05 hat Peter Maydell geschrieben:
> On Tue, 31 Mar 2020 at 13:02, Kevin Wolf <kwolf@redhat.com> wrote:
> > Mainly because it allows me to start everything (most importantly: my
> > editor, git and make) from the same directory.
>=20
> You can use 'make -C build/whatever' to avoid having to change directory.

Which is about five times as long as 'make'.

I'm not sure what the problem would be with a Makefile in the source
tree that just calls make in the build directory? It's convenient and
doesn't hurt anyone who prefers to work directly in the build directory.

> The odd one out here is configure, where you have to say
>  (cd build/whatever && ../../configure ...)
> I have occasionally wondered if we should add an equivalent to
> make's -C option to configure, but AFAIX autoconf-configures don't
> have it, so it would be an odd non-standardism.

Well, not allowing in-tree builds is an odd non-standardism, too, so I
think some more non-standardisms to make it more bearable wouldn't be
too bad.

Kevin


