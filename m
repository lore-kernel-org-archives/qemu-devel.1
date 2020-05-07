Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B29AC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 09:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488F320747
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 09:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEpPzIjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488F320747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWcqd-0001Mt-Ba
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 05:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jWcpn-0000b6-6A
 for qemu-devel@nongnu.org; Thu, 07 May 2020 05:28:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22592
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jWcpl-0004Eh-Ie
 for qemu-devel@nongnu.org; Thu, 07 May 2020 05:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588843728;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HoELYStxyeafMHo9fnmvpGME2wClXMuF3GxmNla8PQU=;
 b=gEpPzIjPJdN4VEjY5wu9NvQZK6RUZTJfDJ2RkVMYqHnHPj4XcN5QtqTdVbLbsvVuHBVjHF
 W6flNOI8yph6uleOj9Cj1vxODCXcK4M6tWt01xPFSHhoRf5wkBThwjpObJnG7h915ruiIr
 b8ZdxMeg9567q8Q9xcS+4VY0HeHY//U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-WCDHPYdVMQ-BlFGGV9Jxcw-1; Thu, 07 May 2020 05:28:41 -0400
X-MC-Unique: WCDHPYdVMQ-BlFGGV9Jxcw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D73BA1005510;
 Thu,  7 May 2020 09:28:40 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5800862AA2;
 Thu,  7 May 2020 09:28:36 +0000 (UTC)
Date: Thu, 7 May 2020 10:28:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] virtiofsd: Use clone() and not unshare(), support non-root
Message-ID: <20200507092832.GA1104082@redhat.com>
References: <348d4774-bd5f-4832-bd7e-a21491fdac8d@www.fastmail.com>
 <20200506191614.GR2743@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200506191614.GR2743@work-vm>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Walters <walters@verbum.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 06, 2020 at 08:16:14PM +0100, Dr. David Alan Gilbert wrote:
> * Colin Walters (walters@verbum.org) wrote:
> > I'd like to make use of virtiofs as part of our tooling in
> > https://github.com/coreos/coreos-assembler
> > Most of the code runs as non-root today; qemu also runs as non-root.
> > We use 9p right now.
> >=20
> > virtiofsd's builtin sandboxing effectively assumes it runs as
> > root.
> >=20
> > First, change the code to use `clone()` and not `unshare()+fork()`.
> >=20
> > Next, automatically use `CLONE_NEWUSER` if we're running as non root.
>=20
> Is it ever useful for root to run the code in a new user namespace?

Yes, user namespace is useful to both root and non-root alike. Roughly
speaking, for root, it offers security benefits, for non-root it offers
functionality benefits.

The longer answer...

With a new user namespaces, users inside the container get remapped
to different set of users outside the host, through defined UID & GID
mappings.  For any UID/GID which doesn't have a mapping, access will
get performed as (uid_t)-1 / (gid_t)-1.

eg consider you have a range of host IDs 100,000->165,536 available.
With user namespaces, you can now ssetuop a mapping of container
IDs 0 -> 65536.

Thus any time  UID 0 inside the container does something, from the
host POV they are acting as UID 100,000.  If UID 30,000 inside the
container does something, this is UID 130,000 in the host POV. If
UID 80,000 in the container does something, this is uid -1 from
the host POV.

If the person in the host launching virtiofsd is non-root, then
user namespaces mean they can offer the guest the full range of
POSIX APIs wrt access control & file ownership, since they're
no longer restricted to their single host UID when inside the
container.  They also get important things like CAP_DAC_OVERRIDE.
IOW, for non-root, user namespaces unlock the full functionality
of virtiofsd. Without it, we're limited to read-only access to
files not owned by the current non-root user.

If the person in the host launching virtiofsd is root, then user
namespaces mean we can reduce the effective privileges of virtiofsd.
Currently when inside the container, uid=3D=3D0 is still the same as
uid=3D=3D0 outside. So if there are any resources visible inside the
container (either accidentally or intentionally), then virtiofsd
shouldn't have write access to, we're lacking protection. By
adding usernamespace + a mapping, we strictly isolate virtiofsd
from any host resources.

The main pain point with user namespaces is that all the files
in the directory you are exporting need to be shifted to match
the UID/GID mapping user for the user namespaces. Traditionally
this has needed a recursive chown of the tree to remap the file
ownership. There has been talk of a filesystem overlay todo the
remapping transparently, but I've lost track of whether that's
a thing yet.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


