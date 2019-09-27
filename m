Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF0CC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E69220872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E69220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDuRL-0008QL-9A
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 13:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iDtTa-000830-4i
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 12:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iDtTW-0002pf-6O
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 12:52:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54022)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1iDtTO-0001uC-3s; Fri, 27 Sep 2019 12:52:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7C9B9300BEAB;
 Fri, 27 Sep 2019 16:51:58 +0000 (UTC)
Received: from redhat.com (ovpn-112-55.ams2.redhat.com [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 134BF5D6A7;
 Fri, 27 Sep 2019 16:51:56 +0000 (UTC)
Date: Fri, 27 Sep 2019 17:51:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] tests: fix I/O test for hosts defaulting to LUKSv2
Message-ID: <20190927165153.GO20911@redhat.com>
References: <20190927101155.25896-1-berrange@redhat.com>
 <666c1338-e5c4-3cba-cb89-651755baa065@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <666c1338-e5c4-3cba-cb89-651755baa065@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 27 Sep 2019 16:51:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 27, 2019 at 10:26:27AM -0500, Eric Blake wrote:
> On 9/27/19 5:11 AM, Daniel P. Berrang=C3=A9 wrote:
> > Some distros are now defaulting to LUKS version 2 which QEMU cannot
> > process. For our I/O test that validates interoperability between the
> > kernel/cryptsetup and QEMU, we need to explicitly ask for version 1
> > of the LUKS format.
> >=20
>=20
> Ultimately, it would be nice to get LUKS 2 support in qemu too, but tha=
t's a
> much bigger job.  This is fine for now.
>=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >   tests/qemu-iotests/149     |  2 +-
> >   tests/qemu-iotests/149.out | 44 +++++++++++++++++++----------------=
---
> >   2 files changed, 23 insertions(+), 23 deletions(-)
>=20
> >=20
> > diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
> > index 4f363f295f..8ab42e94c6 100755
> > --- a/tests/qemu-iotests/149
> > +++ b/tests/qemu-iotests/149
> > @@ -153,7 +153,7 @@ def cryptsetup_format(config):
> >       (password, slot) =3D config.first_password()
> > -    args =3D ["luksFormat"]
> > +    args =3D ["luksFormat", "--type", "luks1"]
>=20
> On Fedora 29, 'cryptsetup --help | grep -A1 type' shows:
>   -M, --type=3DSTRING               Type of device metadata: luks, plai=
n,
>                                   loopaes, tcrypt
>=20
> but that is just 'luks', not 'luks1'.
>=20
> On CentOS 6 (yeah, I know, not relevenant to qemu any more), --type is
> unsupported.  But I didn't check our other range of supported systems. =
My
> point, however, is whether this patch needs to be conditionalized based=
 on
> what cryptsetup actually supports.

I tested RHEL-7 and it supported "luks1" despit the docs not
reflecting it. The docs fix seems to be quite recent.

That said, I noticed that RHEL-7 (surprisingly) has support
for LUKSv2, so might not have been a good test platform.

I'll check what Debian/Ubuntu support in this respect.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

