Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9602FC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F12F20714
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVQcOQ81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F12F20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJJBv-000571-HA
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jJJAb-00045W-H7
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jJJAa-0001fg-2N
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:51:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39668
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jJJAZ-0001ek-Tv
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585669874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cQyxH7OBydXOHAjY2KIYa/CDKn3f1MCvQhIsWy/22w4=;
 b=HVQcOQ815yCghF20lKdnQE2hd1TiM63TSURC/PpGQ5HxS+wRdy4yU/OdJpUcOJZLCpwpge
 c4YYVCN9Tv8r/hYQ5tTCoJ9WOLIqtiC2H3naTgQ5R2mi4ObgJTQwf5/K+Ckkw6uT9dKdY2
 8h7ozpKrEO0/ZorBCmP3LAFiLlpdeNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-pO2dB95FNv6WcXe6-vO7Ow-1; Tue, 31 Mar 2020 11:51:13 -0400
X-MC-Unique: pO2dB95FNv6WcXe6-vO7Ow-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 721F4107ACCD;
 Tue, 31 Mar 2020 15:51:10 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-236.ams2.redhat.com [10.36.114.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7FFC60BE0;
 Tue, 31 Mar 2020 15:51:03 +0000 (UTC)
Date: Tue, 31 Mar 2020 17:51:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] configure: warn if not using a separate build directory
Message-ID: <20200331155102.GK7030@linux.fritz.box>
References: <20200331103758.370644-1-berrange@redhat.com>
 <042a22e2-5be5-ba57-1c35-8f210d9718fd@redhat.com>
 <20200331145609.GK353752@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200331145609.GK353752@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Liviu Ionescu <ilg@livius.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 31.03.2020 um 16:56 hat Daniel P. Berrang=E9 geschrieben:
> On Tue, Mar 31, 2020 at 09:44:37AM -0500, Eric Blake wrote:
> > On 3/31/20 5:37 AM, Daniel P. Berrang=E9 wrote:
> > > Running configure directly from the source directory is a build
> > > configuration that will go away in future. It is also not currently
> > > covered by any automated testing. Display a deprecation warning if
> > > the user attempts to use an in-srcdir build setup, so that they are
> > > aware that they're building QEMU in an undesirable manner.
> > >=20
> > > Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>

> > > @@ -6799,6 +6812,23 @@ if test "$supported_os" =3D "no"; then
> > >       echo "us upstream at qemu-devel@nongnu.org."
> > >   fi
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
> > > +    echo
> > > +    echo "  $ mkdir build"
> > > +    echo "  $ cd build"
> > > +    echo "  $ ../configure"
> > > +    echo "  $ make"
> > > +    echo
> > > +fi
> >=20
> > You know, it WOULD be possible to further enhance this to actually crea=
te
> > 'build' as well as a shim GNUmakefile that would auto-forward on to bui=
lding
> > directly in build, so that you maintain the illusion of an in-place bui=
ld
> > (other than all the build artifacts now living in a different location)=
, and
> > muscle memory for in-tree 'make' still works; I've posted elsewhere and=
 will
> > repeat here the contents of my GNUmakefile:
>=20
> I wanted to focus strictly on the part that we have agreement on, namely
> the deprecation. Any functional changes should be completely separate
> to avoid holding up the merge of the warning message patch.

We don't have agreement on the type of deprecation suggested by your
message, that is, that ./configure from the source directory will stop
working.

If we can agree on using Eric's approach, then the message should rather
tell users that the resulting binaries will move to a different place in
future versions.

Kevin


