Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B92C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 22:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED34206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 22:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dD2tTa2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED34206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUILU-0007FH-PS
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 17:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iUIKr-0006jU-WC
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 17:39:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iUIKp-0000w8-8k
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 17:39:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39620
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iUIKo-0000vt-V1
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 17:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573511938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3NYzVK7dflsuS8bHAcuoNzpRmPARonfgI4PHiyyO0z4=;
 b=dD2tTa2+ty4A4NQ44mrChsD6447AdbZ4s7no9ojGloLk7AmFML4nkZtp2XrRZ6V1FT0jUg
 caffM+OZtXZSkWNulc064zbhBVsFx11yJ3sI/AfXdVuUYsxU241Hw/yWGLvt2bjFhm4wS/
 XXpVrEcwjiAlS2HoQLQRb5Ok2WAeYJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-UFUe_aiDP72gZU3InbBdHA-1; Mon, 11 Nov 2019 17:38:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE430801E51;
 Mon, 11 Nov 2019 22:38:53 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A4495D9E1;
 Mon, 11 Nov 2019 22:38:46 +0000 (UTC)
Date: Mon, 11 Nov 2019 17:38:44 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH v7 5/8] Acceptance tests: keep a stable reference to the
 QEMU build dir
Message-ID: <20191111223844.GE19559@localhost.localdomain>
References: <20191104151323.9883-1-crosa@redhat.com>
 <20191104151323.9883-6-crosa@redhat.com>
 <5a8c7d1a-a7b7-2b7c-2ac6-fe79d7dcd1e8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5a8c7d1a-a7b7-2b7c-2ac6-fe79d7dcd1e8@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: UFUe_aiDP72gZU3InbBdHA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Willian Rampazzo <wrampazz@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 07, 2019 at 05:22:24PM -0200, Wainer dos Santos Moschetta wrote=
:
>=20
> On 11/4/19 1:13 PM, Cleber Rosa wrote:
> > This is related to the the differences in in-tree and out-of-tree
> > builds in QEMU.  For simplification, <BLD> means my build directory.
> >=20
> > Currently, by running a `make check-acceptance` one gets (in
> > tests/acceptance/avocado_qemu/__init__.py):
> >=20
> >     SRC_ROOT_DIR: <BLD>/tests/acceptance/avocado_qemu/../../..
> >=20
> > This in itself is problematic, because after the parent directories
> > are applied, one may be left not with a pointer to the build directory
> > as intended, but with the location of the source tree (assuming they
> > differ). Built binaries, such as qemu-img, are of course not there and
> > can't be found.
> >=20
> > Given that a Python '__file__' will contain the absolute path to the
> > file backing the module, say:
> >=20
> >     __file__: <BLD>/tests/acceptance/avocado_qemu/__init__.py
> >=20
> >                    |  4  |     3    |      2     |     1     |
> >=20
> > A solution is to not "evaluate" the third parent dir (marked as 4
> > here) because that ends up following the "tests" directory symlink to
> > the source tree.  In fact, there's no need to keep or evaluate any of
> > the parent directories, we can just drop the rightmost 4 components,
> > and we'll keep a stable reference to the build directory (with no
> > symlink being followed).  This works for either a dedicated build
> > directory or also a combined source and build tree.
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >   tests/acceptance/avocado_qemu/__init__.py | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptan=
ce/avocado_qemu/__init__.py
> > index 6618ea67c1..17ce583c87 100644
> > --- a/tests/acceptance/avocado_qemu/__init__.py
> > +++ b/tests/acceptance/avocado_qemu/__init__.py
> > @@ -16,7 +16,7 @@ import tempfile
> >   import avocado
> > -SRC_ROOT_DIR =3D os.path.join(os.path.dirname(__file__), '..', '..', '=
..')
> > +SRC_ROOT_DIR =3D os.path.dirname(os.path.dirname(os.path.dirname(os.pa=
th.dirname(__file__))))
>=20
> In this case, wouldn't make sense to rename the constant from SRC_ROOT_DI=
R
> to BUILD_ROOT_DIR?
>

True.  I remember thinking about doing that as a separate change and
ended up forgetting.  Maybe it's better to just do it here.

> This patch looks good to me besides that.
>=20
> - Wainer
>

Thanks!
- Cleber.


