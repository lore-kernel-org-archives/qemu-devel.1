Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3D6C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 08:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 648E020675
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 08:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdV9P+qA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648E020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icPkn-0003HO-Fa
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 03:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1icPKR-00068k-Up
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 02:44:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1icPK5-0003FR-6N
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 02:43:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39222
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1icPK3-0003Dd-7u
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 02:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575445422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKPYiD7DgGynXkla9ItP1Z4FXvM9dnVZ68x3Hhz4Y/Y=;
 b=NdV9P+qARnYDC+BeeyXBkekKJo3U7qxPkrqymS6S61lLBjR1Jcdnau4ynP4cHNsBX4sKpU
 Icl4C/CeQotf8h8cDeQGHERq1rg8N4uffbVIrK/OkKYv3acia3jSnYDXkvUyKzgquMlo4S
 cCtPQmzVoI5Xm75BY4te0vXL50X5fgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-lAXbBeSWPnmyZpJ8aM_fWQ-1; Wed, 04 Dec 2019 02:43:41 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8D63800D4C;
 Wed,  4 Dec 2019 07:43:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E0926100194E;
 Wed,  4 Dec 2019 07:43:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 74B471138606; Wed,  4 Dec 2019 08:43:29 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: virtiofsd: Where should it live?
References: <20191125185021.GB3767@work-vm>
 <20191126102600.GG556568@redhat.com> <20191126121416.GE2928@work-vm>
 <CAFEAcA9Ln2uwg4f4s8oS6VeQk83W3BErmH9cHeyDJy7v-4gNxw@mail.gmail.com>
 <87k17ekhs9.fsf@dusky.pond.sub.org>
 <fef0eaaf-149a-f8a8-02c5-821d2d42becd@redhat.com>
 <20191203105341.GB3078@work-vm>
 <CAFEAcA8bjGAs7JSTNYYYwCH1yF06i0v0r9wjKXqZGZg_Sqy0VA@mail.gmail.com>
 <20191203111949.GB267814@redhat.com>
Date: Wed, 04 Dec 2019 08:43:29 +0100
In-Reply-To: <20191203111949.GB267814@redhat.com> ("Daniel P. =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9=22's?=
 message of "Tue, 3 Dec 2019 11:19:49 +0000")
Message-ID: <87o8wofsda.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: lAXbBeSWPnmyZpJ8aM_fWQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, mszeredi@redhat.com,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Dec 03, 2019 at 11:06:44AM +0000, Peter Maydell wrote:
>> On Tue, 3 Dec 2019 at 10:53, Dr. David Alan Gilbert <dgilbert@redhat.com=
> wrote:
>> >
>> > We seem to be coming to the conclusion something that:
>> >
>> >   a) It should live in the qemu tree
>> >   b) It shouldn't live under contrib
>> >   c) We'll create a new top level, i.e. 'daemons'
>> >   d) virtiofsd will be daemons/virtiofsd
>> >
>> > Now, somethings I'm less clear on:
>> >   e) What else would move into daemons?  It was suggested
>> >     that if we've got virtiofsd in there, then we should move
>> >     libvhost-user - which I understand, but then it's not a
>> >     'daemons'.
>> >     Are there any otehr daemons that should move?
>>=20
>> I like the idea of a new top level directory, but I think
>> 'daemons' is a bit too specific -- for instance it seems to
>> me that qemu-img would be sensible to move out of the root,
>> and that's not a daemon.
>
> Do we really need an extra directory level ?

+1

> IIUC, the main point against having $GIT_ROOT/virtiofsd is that
> the root of our repo is quite cluttered already.
>
> Rather than trying to create a multi-level hierarchy which adds
> a debate around naming, why not address the clutter by moving
> *ALL* the .c/.h files out of the root so that we have a flatter
> tree:
>
>   $GITROOT
>     +- qemu-system
>     |   +- vl.c
>     |   +- ...most other files...

Sounds good to me.

>     +- qemu-img
>     |   +- qemu-img.c

Perhaps this one can all go into existing block/, similar to how
pr-manager-helper.c is in scsi/, and virtfs-proxy-helper.c is in fsdev/.
Up to the block maintainers, of course.

>     +- qemu-nbd
>     |   +- qemu-nbd.c

block/ or nbd/?

>     +- qemu-io
>     |   +- qemu-io.c
>     |   +- qemu-io-cmds.c

block/?

>     +- qemu-bridge-helper

net/?

>     |   ...
>     +- qemu-edid

Has its own MAINTAINERS section, together with hw/display/edit* and
include/hw/display/edid.h.  I'm not sure moving it hw/display/ is a good
idea.  Gerd?

>     +- qemu-keymap

Not covered by MAINTAINERS.  scripts/get_maintainer.pl --git-blame
points to Gerd.

>     +- qga  (already exists)

Yes.

> Then we can add virtiofsd and other programs at the root with no big
> issue.

We don't *have* to put each program into its own directory.  Simple ones
could also share one.  We just need a directory name.


