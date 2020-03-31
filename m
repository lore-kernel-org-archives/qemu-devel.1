Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3221BC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F19CB20786
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYwzGDO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19CB20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJJe4-0006aM-5F
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 12:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jJJb6-0001Qs-IZ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jJJb5-00088X-7X
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:18:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45209
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jJJb5-000886-3f
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585671518;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yjWUOhRaBpBEaADBdCQeQ7hYrUtNVqtsS5VsnLowqXY=;
 b=KYwzGDO7Eusq3uDQWoqsPVmzvH/ZiuB5v2ETJunU4yrBOq40sZoJEaklFFgBkk6X3udV66
 S8aMNbGB/Uh7EoKRkFZCLw9ncTJLU5T8YS0eTaesdPl2mOIfdUOyftoWbj0n+IXsM1yUf4
 hBD0hS+98SKvDAtknfYrAw2cDsgqCEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-V5HxnVWaMRu5IpsBGiX-Qg-1; Tue, 31 Mar 2020 12:18:22 -0400
X-MC-Unique: V5HxnVWaMRu5IpsBGiX-Qg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7AA3107ACC9;
 Tue, 31 Mar 2020 16:18:20 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DFD7DA0EA;
 Tue, 31 Mar 2020 16:18:17 +0000 (UTC)
Date: Tue, 31 Mar 2020 17:18:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] configure: warn if not using a separate build directory
Message-ID: <20200331161814.GP353752@redhat.com>
References: <20200331155158.381585-1-berrange@redhat.com>
 <1450d802-4df8-117b-e58d-da8bf2334010@redhat.com>
 <CAFEAcA-MNMK3O-iyP-wR4YGpTYua+vKHv=jAtmcC6U=_Gz4Fag@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-MNMK3O-iyP-wR4YGpTYua+vKHv=jAtmcC6U=_Gz4Fag@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Liviu Ionescu <ilg@livius.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 31, 2020 at 05:12:35PM +0100, Peter Maydell wrote:
> On Tue, 31 Mar 2020 at 17:05, Eric Blake <eblake@redhat.com> wrote:
> >
> > On 3/31/20 10:51 AM, Daniel P. Berrang=C3=A9 wrote:
> > > +if test "$in_srcdir" =3D "yes"; then
> > > +    echo
> > > +    echo "WARNING: SUPPORT FOR IN SOURCE DIR BUILDS IS DEPRECATED"
> > > +    echo
> > > +    echo "Support for running the 'configure' script directly from t=
he"
> > > +    echo "source directory is deprecated and will go away in a futur=
e"
> > > +    echo "release. In source dir builds are not covered by automated=
"
> > > +    echo "testing and are liable to break without warning. Users are=
"
> > > +    echo "strongly recommended to switch to a separate build directo=
ry:"
> >
> > Per Kevin's response, we may want to tweak this wording slightly; maybe=
:
> >
> > Support for running the 'configure' script directly from the source
> > directory is deprecated.  In-tree builds are not covered by automated
> > testing and are liable to break without warning.  Future releases may
> > change the default location of built executables for an in-tree build,
> > or drop in-tree build support altogether.  Users are strongly
> > recommended to switch to a separate build directory:
>=20
> I now feel that, given that we've had various people say they
> want to retain at least the basic in-tree build commands and are
> willing to put in a wrapper to make it keep working, that this
> deprecation wording is a bit strong. I don't think that it
> much serves our users to say "this will go away" and then
> implement the compatibility wrapper -- we've caused them
> to unnecessarily change what they're doing, and then reduced
> the value of the compat-wrapper work we do. A more gently
> phrased note that we recommend use of out-of-tree builds
> would be sufficient I think.

Ok, i'll resend with a simpler warning message which tries to avoid
fortelling the future and just focuses on today.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


