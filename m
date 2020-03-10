Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6274EC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279DD2467D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPAa2GoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279DD2467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdiu-00053G-Di
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jBdi3-000465-2L
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jBdi1-00019q-8F
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:10:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53398
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jBdi1-00018z-4C
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583842204;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DTV8CrO4NDBNJ/5rYJxNdJ44EIwRDnmnJlGHvfWYC7c=;
 b=iPAa2GoFYozI17akOQ4Txju+TELnuIgtnKVLMlU+tMTNHbHQwIyTErz2k9B/Tbz8oNa5PS
 vb7WduJ/iX2Dkof5exoQBxl3djgV1aYC6fBnDkuImHz7hvlZl27Hv/fv/IM9YeldIEHjxn
 MFzAvBoRFj4HzHUm260GIIA9ISb1fyI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-42T0WftmMjejSJaLnXiVXg-1; Tue, 10 Mar 2020 08:09:58 -0400
X-MC-Unique: 42T0WftmMjejSJaLnXiVXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4EFA8E6D1;
 Tue, 10 Mar 2020 12:09:56 +0000 (UTC)
Received: from redhat.com (ovpn-112-62.ams2.redhat.com [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7FC960C87;
 Tue, 10 Mar 2020 12:09:54 +0000 (UTC)
Date: Tue, 10 Mar 2020 12:09:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] modules: load modules from versioned /var/run dir
Message-ID: <20200310120951.GF3234052@redhat.com>
References: <20200306132648.27577-1-christian.ehrhardt@canonical.com>
 <20200310093910.GB140737@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200310093910.GB140737@stefanha-x1.localdomain>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 pkg-qemu-devel@lists.alioth.debian.org, Cole Robinson <crobinso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Miroslav Rezanina <mrezanin@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 09:39:10AM +0000, Stefan Hajnoczi wrote:
> On Fri, Mar 06, 2020 at 02:26:48PM +0100, Christian Ehrhardt wrote:
> > On upgrades the old .so files usually are replaced. But on the other
> > hand since a qemu process represents a guest instance it is usually kep=
t
> > around.
> >=20
> > That makes late addition of dynamic features e.g. 'hot-attach of a ceph
> > disk' fail by trying to load a new version of e.f. block-rbd.so into an
> > old still running qemu binary.
> >=20
> > This adds a fallback to also load modules from a versioned directory in=
 the
> > temporary /var/run path. That way qemu is providing a way for packaging
> > to store modules of an upgraded qemu package as needed until the next r=
eboot.
> >=20
> > An example how that can then be used in packaging can be seen in:
> > https://git.launchpad.net/~paelzer/ubuntu/+source/qemu/log/?h=3Dbug-184=
7361-miss-old-so-on-upgrade-UBUNTU
> >=20
> > Fixes: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1847361
> > Signed-off-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> > ---
> >  util/module.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
>=20
> CCing Debian, Fedora, and Red Hat package maintainers in case they have
> comments.
>=20
> The use of /var/run makes me a little uneasy.  I guess it's related to
> wanting to uninstall the old package so the .so in their original
> location cannot be used (even if they had a versioned path)?
>=20
> I'm not a package maintainer though so I hope the others will make
> suggestions if there are other solutions :).

My first concern is that this only partially solves the quoted problem.

Consider the QEMU RBD module which is

   /usr/lib64/qemu/block-rbd.so

This links to

   /usr/lib64/librbd.so.1

On host OS upgrade, just before uninstalling old QEMU we copy RBD
module into:

   /var/run/qemu-$VER/block-rbd.so

....but the host OS upgrade also upgrades RBD itself to a new
major version which ships

   /usr/lib64/librbd.so.2

We've got /var/run/qemu-$VER/block-rbd.so saved, but we didn't
transitively save all the things that this linked to, so there's
no guarantee it will still be possible to load it.

IOW, this approach of saving QEMU block modules to a scratch dir
works, *provided* everything else that this QEMU block module needs
still exists in a compatible form.

Some distros may have a policy that no incompatible soname bumps
are permitted in updates, but that's not universal.

On the other hand this is not a big amount of new code, so is not
a huge maint problem even if only a few people ever use it. I would
be a bit more comfortable if this search path addition was perhaps
enabled by an opt-in configure argument, rather than being always
present.


I'm also uneasy about the idea of using a search path ordering for
doing this.  This means that an old running QEMU is always going
to first try to load the block-rbd.so from the new QEMU, expect
to see that fail, and only then fallback to load the block-rbd.so
that actually matches its build.

IIRC, we have an embedded build-id in the modules that should
guarantee that the first load attempt always fails, but I'm still
uneasy about that at a conceptual level.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


