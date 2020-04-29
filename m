Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2530C83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 15:01:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0CD721973
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 15:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXpPFJz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0CD721973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jToDk-0004kX-P6
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 11:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1jToCa-0003xc-8V
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1jToCZ-0007nZ-Nn
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:00:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34518
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jToCZ-0007nM-7G
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588172442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=42TLEmELADjRzI+YQyXR9xFhRd/QTbNfPJ8tpwApic0=;
 b=DXpPFJz/vlZGaNapecacavJJ7MuXXELyMnQ9Tmrz2LIiylsv7JHjRRnAxg6fyJaREcw8PU
 XPE2sg3yQ0a+AHZizmA8dJBIMsb/15v3LLTkvrzHrM5SUCIS5wDGSVonvvHqZRBKW3rhhU
 d8KlqeoucF4AYdjVReEU/tM3Uo+aCGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-LnmFgy8jPBGgnKBktbJ5Xg-1; Wed, 29 Apr 2020 11:00:39 -0400
X-MC-Unique: LnmFgy8jPBGgnKBktbJ5Xg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B0A418764E0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 15:00:39 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-168.rdu2.redhat.com [10.10.114.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D386710013BD;
 Wed, 29 Apr 2020 15:00:38 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 509B7222EB9; Wed, 29 Apr 2020 11:00:38 -0400 (EDT)
Date: Wed, 29 Apr 2020 11:00:38 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: jail lo->proc_self_fd
Message-ID: <20200429150038.GF231284@redhat.com>
References: <20200429124733.22488-1-mszeredi@redhat.com>
 <20200429143600.GE231284@redhat.com>
 <CAOssrKcOgP7eLo+uQdv==HssuqU3qpBKibvYAXypU88QXvypKw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOssrKcOgP7eLo+uQdv==HssuqU3qpBKibvYAXypU88QXvypKw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 29, 2020 at 04:47:19PM +0200, Miklos Szeredi wrote:
> On Wed, Apr 29, 2020 at 4:36 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Wed, Apr 29, 2020 at 02:47:33PM +0200, Miklos Szeredi wrote:
> > > While it's not possible to escape the proc filesystem through
> > > lo->proc_self_fd, it is possible to escape to the root of the proc
> > > filesystem itself through "../..".
> >
> > Hi Miklos,
> >
> > So this attack will work with some form of *at(lo->proc_self_fd, "../..=
")
> > call?
>=20
> Right.
>=20
> >
> > >
> > > Use a temporary mount for opening lo->proc_self_fd, that has it's roo=
t at
> > > /proc/self/fd/, preventing access to the ancestor directories.
> >
> > Does this mean that now similar attack can happen using "../.." on tmpd=
ir
> > fd instead and be able to look at peers of tmpdir. Or it is blocked
> > due to mount point or something else.
>=20
> No, because tmpdir is detached, the root of that tree will be the
> directory pointed to by the fd.  ".." will just lead to the same
> directory.

Aha.. got it. Thanks.

One more question. We seem to be using PID namespaces. Can't we mount
fresh instance of proc so that we don't see other processes apart from
virtiofd. May be we are already doing it. I have not checked it yet. If
yes, that should mitigate this concern?

Also noticed private proc patches upstream which should allow mounting
private instance of proc even without the need of separate PID namespace.

Thanks
Vivek


