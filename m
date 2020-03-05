Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7728C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D2C52146E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNEV8E5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2C52146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9mDj-0008Pl-Q8
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 03:51:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j9mD7-0007yN-AL
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:50:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j9mD6-00086y-6l
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:50:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57486
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j9mD6-00086p-2x
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583398227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9EdbH3A/dWG6wz0oPqjD1bXRKXNuCD/SSy7vOM7ATQI=;
 b=KNEV8E5uM5Te6vuBFeM0hH5dEOid67NMXaGOgydT1z2Hes5pHuil6hYQ14SRLJU1a87aww
 5s3l8rF646dmPjsN+eSiTIitaC315HuzFUHHW8AN3CJmOwZUivRmH8ULUx0QgLfxhsyYhZ
 YedIQEQOVLu8ZRVrk9ceLi9/ni6q8LQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-nBC2vREWMpGnM2KVKCJpEQ-1; Thu, 05 Mar 2020 03:50:21 -0500
X-MC-Unique: nBC2vREWMpGnM2KVKCJpEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA25E1005512;
 Thu,  5 Mar 2020 08:50:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-150.ams2.redhat.com
 [10.36.116.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E0851CB;
 Thu,  5 Mar 2020 08:50:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BA08717449; Thu,  5 Mar 2020 09:50:19 +0100 (CET)
Date: Thu, 5 Mar 2020 09:50:19 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] audio: Add sndio backend
Message-ID: <20200305085019.hbmih2m43vmpdc5v@sirius.home.kraxel.org>
References: <20200304145003.GB15649@humpty.home.comstyle.com>
 <158333424649.21741.12510392429749383012@abdcc9e1aa82>
MIME-Version: 1.0
In-Reply-To: <158333424649.21741.12510392429749383012@abdcc9e1aa82>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: brad@comstyle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 04, 2020 at 07:04:07AM -0800, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200304145003.GB15649@humpty.home.=
comstyle.com/
>=20
>=20
>=20
> Hi,
>=20
> This series seems to have some coding style problems. See output below fo=
r
> more information:
>=20
> Subject: [PATCH] audio: Add sndio backend
> Message-id: 20200304145003.GB15649@humpty.home.comstyle.com
> Type: series
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> From https://github.com/patchew-project/qemu
>  * [new tag]         patchew/20200304145003.GB15649@humpty.home.comstyle.=
com -> patchew/20200304145003.GB15649@humpty.home.comstyle.com
> Switched to a new branch 'test'
> 421ab62 audio: Add sndio backend
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> ERROR: space prohibited before that close parenthesis ')'
> #41: FILE: audio/audio.c:1977:
> +        CASE(SNDIO, sndio, );

False positive I'd say.

> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

Adding an entry to the MAINTAINERS file is a good idea though.

> ERROR: g_free(NULL) is safe this check is probably not required
> #381: FILE: audio/sndioaudio.c:318:
> +    if (self->pfds) {
> +        g_free(self->pfds);

Reasonable too.

cheers,
  Gerd


