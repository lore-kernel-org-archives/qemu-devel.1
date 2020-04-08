Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51009C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A83A2074F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5+rhCiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A83A2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM6lj-0007zW-99
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 05:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jM6i2-0003qS-Rj
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jM6hy-0001GT-1X
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:09:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33451
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jM6hx-0001GC-U1
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586336956;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D9Lr9msyjubWAYM8VPHvJFpMuaTUCO39VsOExCkN4NY=;
 b=Z5+rhCiO00iUNkGq7BJlOmC6ECRmNh1yc/vyhJU/kzkIb1Pf1FBiGvTa1ZPOl4iXwRe7Vu
 ZepnHxkrgEI2sYPOjfabvRv2Ur8rHrKrD35Hx0dOUD3IR2nGbd0domQkCGi1XoRIp4jDed
 nokLFSBSQJDoKAftecM8G4s1N049cDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-TNjcdcyvOCKN4sp10FnpTA-1; Wed, 08 Apr 2020 05:08:59 -0400
X-MC-Unique: TNjcdcyvOCKN4sp10FnpTA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C01008017F3;
 Wed,  8 Apr 2020 09:08:57 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABA091001F43;
 Wed,  8 Apr 2020 09:08:55 +0000 (UTC)
Date: Wed, 8 Apr 2020 10:08:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH] Makefile: libfdt: build only the strict necessary
Message-ID: <20200408090852.GB1073390@redhat.com>
References: <158632959483.16886.907739858138361292@39012742ff91>
 <6b2eca03-8fd0-54de-1622-ba26d4f1a31e@suse.de>
MIME-Version: 1.0
In-Reply-To: <6b2eca03-8fd0-54de-1622-ba26d4f1a31e@suse.de>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, david@gibson.dropbear.id.au,
 alex.bennee@linaro.org, qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 08, 2020 at 09:49:56AM +0200, Claudio Fontana wrote:
> Hi,
>=20
> On 4/8/20 9:06 AM, no-reply@patchew.org wrote:
> > Patchew URL: https://patchew.org/QEMU/20200408070231.20265-1-cfontana@s=
use.de/
> >=20
> >=20
> >=20
> > Hi,
> >=20
> > This series failed the asan build test. Please find the testing command=
s and
> > their output below. If you have Docker installed, you can probably repr=
oduce it
> > locally.
>=20
> I can't reproduce this here running the commands (TEST SCRIPT) below..
>=20
> >=20
> > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > #!/bin/bash
> > export ARCH=3Dx86_64
> > make docker-image-fedora V=3D1 NETWORK=3D1
> > time make docker-test-debug@fedora TARGET_LIST=3Dx86_64-softmmu J=3D14 =
NETWORK=3D1
> > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> >=20
> > =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> > Makefile:532: dtc/libfdt/Makefile.libfdt: No such file or directory
>=20
> hmm this is the include directive
>=20
> include $(LIBFDT_srcdir)/Makefile.libfdt
>=20
> is this test not getting the dtc submodule for some reason?

Note that this test script did not even get as far as trying to
build QEMU itself.

Starting from a clean checkout *WITHOUT* having run configure,
it is trying todo

   make docker-image-fedora V=3D1 NETWORK=3D1

This should invoke the rules to launch docker, and then run
configure inside docker. Instead it is trying to build dtc.

So something in your changes has broken the ability to run
the docker make targets.

>=20
> > cc -nostdlib  -o dtc/libfdt/Makefile.libfdt.mo=20
>=20
> Hmm..
>=20
> > cc: fatal error: no input files
> > compilation terminated.
> > make: *** [dtc/libfdt/Makefile.libfdt.mo] Error 4
> > Makefile:532: dtc/libfdt/Makefile.libfdt: No such file or directory
> >   LD      dtc/libfdt/Makefile.libfdt.mo
> > cc: fatal error: no input files
> > compilation terminated.
> > make: *** [dtc/libfdt/Makefile.libfdt.mo] Error 4
> >=20
> > real    0m0.585s
> > user    0m0.384s
> >=20
> >=20
> > The full log is available at
> > http://patchew.org/logs/20200408070231.20265-1-cfontana@suse.de/testing=
.asan/?type=3Dmessage.
> > ---
> > Email generated automatically by Patchew [https://patchew.org/].
> > Please send your feedback to patchew-devel@redhat.com
> >=20
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


