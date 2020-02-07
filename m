Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1377C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 21:55:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C51F22314
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 21:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOeXA570"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C51F22314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0BbM-0004uV-JF
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 16:55:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j0Baj-0004Se-U7
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 16:55:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j0Bai-00041s-Iq
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 16:55:13 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58653
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j0Bai-000409-Ez
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 16:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581112512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xh+z907CDf7g01QdNBywOHsWlT/svOmeToaR79Ka+mI=;
 b=cOeXA570hEprmxWjbW/1y/I4aT66UHfJLohuqbgyNFmuT8Fwf9JyHcqO9gQWuKfZxLCa9F
 +PVkW+091kKU+u9xn92wpbL7L82q/1w6DW56RLrVIlhc9VPgh3aCVZNWIu7Bb29yrFptkD
 cOr/9hQ5ODETjSfFKQmFcf97By16YFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-x7P7ymZlN9eiRTampcoy2w-1; Fri, 07 Feb 2020 16:55:06 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3BDD800E21;
 Fri,  7 Feb 2020 21:55:04 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8FBEB790D7;
 Fri,  7 Feb 2020 21:54:59 +0000 (UTC)
Date: Fri, 7 Feb 2020 16:54:59 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] qapi: Fix code generation with Python 3.5
Message-ID: <20200207215459.GJ412524@habkost.net>
References: <20200116202558.31473-1-armbru@redhat.com>
 <3fb3e411-c5de-fbc1-684b-c7fb1ce2ea7d@redhat.com>
 <875zhapnlt.fsf@dusky.pond.sub.org>
 <a6ea59a5-0877-fdeb-5b37-9ec3f31074a4@redhat.com>
 <87lfq5s19h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87lfq5s19h.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: x7P7ymZlN9eiRTampcoy2w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Peter Maydell <peter.maydell@linaro.org>, thuth@redhat.com,
 Cleber Rosa <cleber@redhat.com>, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jan 18, 2020 at 07:54:18AM +0100, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> > On 1/17/20 2:07 AM, Markus Armbruster wrote:
> >> John Snow <jsnow@redhat.com> writes:
[...]
> >>> This problem has bitten me *many* times. I'm wondering if there's a
> >>> prescription that isn't just "Wait until we can stipulate 3.6+".
> >>=20
> >> No clue.
> >>=20
> >> 3.5 EOL is scheduled for 2020-09-13.
> >> https://devguide.python.org/#status-of-python-branches
> >>=20
> >> We support 3.5 because we support Debian 9.
> >>=20
> >> We'd normally drop support for Debian 9 two years after Debian 10,
> >> i.e. July 2021.  Assuming Debian supports it that far.  Whether they c=
an
> >> truly support Python 3.5 after uptstream EOL seems doubtful.
> >>=20
> >
> > We should decide whether we consider Debian LTS to be adequately
> > supported, yes-or-no.
> >
> > We should use a rule of "two years after successor, or End-of-Support,
> > whichever comes first."
>=20
> Yes.
>=20
> > For Debian, is end of support three years after it comes out, or is it
> > when the LTS is EOL?
>=20
> We need to define end-of-support for Debian: is it Debian proper or is
> it Debian LTS?
>=20
> <https://wiki.debian.org/DebianOldStable>:
>=20
>     Q) How long will security updates be provided?
>=20
>     The security team tries to support a stable distribution for about
>     one year after the next stable distribution has been released,
>     except when another stable distribution is released within this
>     year.  It is not possible to support three distributions; supporting
>     two simultaneously is already difficult enough.
>=20
> <https://wiki.debian.org/LTS>:
>=20
>     Debian Long Term Support (LTS) is a project to extend the lifetime
>     of all Debian stable releases to (at least) 5 years.  Debian LTS is
>     not handled by the Debian security team, but by a separate group of
>     volunteers and companies interested in making it a success.
>=20
>     Thus the Debian LTS team takes over security maintenance of the
>     various releases once the Debian Security team stops its work.

As Debian LTS is maintained by a separate group, I interpret
"Debian EOL" as not including LTS.

Supporting Debian 9 in 2020 is already being a burden.
Supporting it until mid-2021 seems pointless.


>=20
> Debian 10 "Buster" was released in July 2019.  Debian 9 "Stretch" will
> receive security updates from Debian until mid 2020, i.e. just about
> when Python 3.5 reaches EOL.  LTS will attempt to support it until June
> 2022.
>=20
> I think we should give ourselves a bit more flexibility than the
> categorical "Support for the previous major version will be dropped 2
> years after the new major version is released."  At some point, the cost
> of supporting old hosts exceeds the utility.  We should face this
> tradeoff.

Agreed.

--=20
Eduardo


