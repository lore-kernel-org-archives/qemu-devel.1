Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99C4C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28BB20757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvmA3hfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28BB20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7id-00018m-UZ
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jU7hh-0000UT-MA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jU7hg-0006Nu-L9
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:50:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58416
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jU7hg-0006LZ-7n
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588247407;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MQ0g5puttt7DGhlxsMpL0T/FhNk6CZ/jpe42ZARblig=;
 b=JvmA3hfZoO8EdSruzkzK3nXKisAR1efqyQPNozP4G/EsTjDuwvykn5wNU4rz0KtnVvsLXY
 rXI54bGhISqPx6+OA4loKm70s6mB0d5HKhHO4RCBku3BjM99vvscrHKXmMX8sbg7ZT6lmU
 knS7FWHp1cJrEWoTDUiTkxpWbxW5/to=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-_TKbUro9O12d4nsgd_UkXw-1; Thu, 30 Apr 2020 07:50:05 -0400
X-MC-Unique: _TKbUro9O12d4nsgd_UkXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89E62835B42;
 Thu, 30 Apr 2020 11:50:04 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D31815EDE5;
 Thu, 30 Apr 2020 11:50:02 +0000 (UTC)
Date: Thu, 30 Apr 2020 12:49:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: Error "cannot bind memory to host NUMA nodes: Operation not
 permitted" running inside docker
Message-ID: <20200430114958.GP2084570@redhat.com>
References: <76d8eb61-e89e-0465-974b-6901a5fb848e@physnet.uni-hamburg.de>
 <20200430085215.GD2084570@redhat.com>
 <20200430134558.20ef46a5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200430134558.20ef46a5@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:24:05
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Manuel Hohmann <mhohmann@physnet.uni-hamburg.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 30, 2020 at 01:45:58PM +0200, Igor Mammedov wrote:
> On Thu, 30 Apr 2020 09:52:15 +0100
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>=20
> > On Wed, Apr 29, 2020 at 11:40:32PM +0300, Manuel Hohmann wrote:
> > > Hi,
> > >=20
> > > I encountered the following error message on the QEMU 5.0.0 release, =
compiled and run inside a docker image:
> > >=20
> > > "cannot bind memory to host NUMA nodes: Operation not permitted" =20
> >=20
> > The error is reporting that mbind() failed.
> >=20
> > mbind() man page says it gives EPERM when
> >=20
> >   "The  flags argument included the MPOL_MF_MOVE_ALL flag and
> >    the caller does not have the CAP_SYS_NICE privilege."
> >=20
> > QEMU always uses the MPOL_MF_MOVE flag though.
> >=20
> > Looking at the kernel source,  mbind can also return EPERM if the
> > process is not permitted to access the requested nodes which seems
> > more plausible as a cause.
> >=20
> > I guess the container the bound to some sub-set of nodes and QEMU is
> > trying to place the VM on different nodes that the container isn't
> > allowed to accesss.
>=20
>=20
> mbind call in this case should be nop since it's 'reapplying' the same
> default policy the RAM was allocated with (modulo flags which are not
> issue in this default case).
>=20
> It looks like there is configuration issue with container (blacklisted mb=
ind) [2]
> Is it possible to try run container with '--security-opt seccomp=3Dunconf=
ined'
> to see if it's the issue.

Oh, yes, I forgot about seccomp - that is almost certainly the problem,
given that this is a public CI system with locked down container config.

>=20
> From QEMU side we may skip mbind if hostnodes bitmap is empty to workarou=
nd
> the issue.
> But I'm not sure if it should be done instead of whitelisting mbind in co=
ntainer,
> since usecases that are using host-nodes will still be broken due to blac=
klisted mbind.
> (looks like mysql has the same [1] problem (but it just warning for them,=
 so it's not so severe issue),
> and they were inclined towards fixing container config)

Telling users to reconfigure the container to allow mbind() is not a viable
approach. In a public cloud scenario the users will not have any direct
control over the container, and it is entirely unsurprising for mbind to
be blocked.


> > > The QEMU command line to reproduce this behavior (it happens also on =
-x86_64, -arm, -aarch64 with similar command line):
> > >=20
> > > qemu-system-i386 -m 64 -M pc -smp 1 -display none -monitor stdio -dri=
ve file=3Dmp-acpi/NOS.iso,media=3Dcdrom,id=3Dd -boot order=3Dd -d cpu_reset=
 =20
> >=20
> > There is no reference to host mem backend or NUMA binding, so I'm
> > puzzled why QEMU would be doing an mbind() at all. That seems bad.
>=20
> since 5.0 all guest RAM allocation was consolidated around hostmem.

Ok, so QEMU shouldn't be calling mbind() at all unless there's some config
on the CLI that requests us to change the default binding, which there
is not in this case.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


