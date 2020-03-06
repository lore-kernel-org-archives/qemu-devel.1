Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859E6C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 15:22:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 507802073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 15:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RcETT0MM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507802073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAEoL-0003uw-5R
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 10:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jAEnd-0003O8-ID
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 10:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jAEnb-00045X-NK
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 10:22:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54498
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jAEnb-000437-HW
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 10:22:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583508122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M3W7qv0j/eoCvAaFdDDrXED6dNJGR9cDFQwpXqUHHuQ=;
 b=RcETT0MMQxDYgbY4QCyn8Ds2ZL/Unvu+OZO5F18pd3SDz8OkWI2eUHoFBL/Iuidz4mQv8q
 60LM0FP0P7ZC5T64VXPe2WqXQViXiAuJXG+RWyUqrWznLbjshZPu0C/VBnxlCARDtAx8eX
 1K111Vsp4JtEF4sXmltIcBCBJLpFgDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-DDz5roYpNAqFxwcKzusvlg-1; Fri, 06 Mar 2020 10:21:58 -0500
X-MC-Unique: DDz5roYpNAqFxwcKzusvlg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6895896EFD;
 Fri,  6 Mar 2020 15:21:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E8D1B5C21B;
 Fri,  6 Mar 2020 15:21:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7712711386A6; Fri,  6 Mar 2020 16:21:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v8 00/10] error: auto propagated local_err part I
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
Date: Fri, 06 Mar 2020 16:21:49 +0100
In-Reply-To: <20200306051536.27803-1-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 6 Mar 2020 08:15:26 +0300")
Message-ID: <87eeu51pbm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laszlo Ersek <lersek@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> File with errp-cleaning APIs dropped for two reasons:
>
> 1. I'm tired after a 3-days war with coccinelle, and don't want to add mo=
re
>    patches here.

Oww.  In my experience, Coccinelle is both awesome and terrible.  I hope
you didn't do all that work just to address minor complaints from me.  I
*try* to make it clear where on the spectrum from "I want you to improve
this" to "perhaps you'd like to try this idea" my review comments are,
but I'm certainly not perfect there.  Anyway, here we are, so let's look
at the patches.

> 2. Markus noted, that we forget two more functions which needs such wrapp=
ers
>    and corresponding conversion, so seems better to handle all these thin=
gs
>    in same manner for now.
>
> changes in v8:
>
> 01: - update comments
>     - fix bug in macro [Markus]
>     - use do {} while(0)
>
> 02: a lot of changes
>     - about error propagation: try to update only patterns where we propa=
gate
>       local_error to errp. So, patches 09 and 10 changed (wow!)
>     - Now clearing functions are not defined. Still, do the conversion, s=
o
>       that when script applied where these functions needed, compilation =
will
>       be broken.
>     - improve ordering of hunks, and comment everything
>
> 09,10: drop hunks, which are converted for nothing.

Quick eye-over: you no longer wrap nbd_co_receive_cmdread_reply(),
nbd_co_receive_blockstatus_reply(), and xen_bus_realize().  Clearly
better.

> v8 is available at
>  https://src.openvz.org/scm/~vsementsov/qemu.git #tag up-auto-local-err-p=
artI-v8
> v7 is available at
>  https://src.openvz.org/scm/~vsementsov/qemu.git #tag up-auto-local-err-p=
artI-v7
> =20
> In these series, there is no commit-per-subsystem script, each generated
> commit is generated in separate.
>
> Still, generating commands are very similar, and looks like
>
>     sed -n '/^<Subsystem name>$/,/^$/{s/^F: //p}' MAINTAINERS | \
>     xargs git ls-files | grep '\.[hc]$' | \
>     xargs spatch \
>         --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>         --macro-file scripts/cocci-macro-file.h \
>         --in-place --no-show-diff --max-width 80
>
> Note, that in each generated commit, generation command is the only
> text, indented by 8 spaces in 'git log -1' output, so, to regenerate all
> commits (for example, after rebase, or change in coccinelle script), you
> may use the following command:
>
> git rebase -x "sh -c \"git show --pretty=3D --name-only | xargs git check=
out HEAD^ -- ; git reset; git log -1 | grep '^        ' | sh\"" HEAD~7
>
> Which will start automated interactive rebase for generated patches,
> which will stop if generated patch changed
> (you may do git commit --amend to apply updated generated changes).
>
> Note:
>   git show --pretty=3D --name-only   - lists files, changed in HEAD
>   git log -1 | grep '^        ' | sh   - rerun generation command of HEAD
>
>
> Check for compilation of changed .c files
> git rebase -x "sh -c \"git show --pretty=3D --name-only | sed -n 's/\.c$/=
.o/p' | xargs make -j9\"" HEAD~7

Thanks for the write-up!


