Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A302C35240
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 09:23:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 661402067C
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 09:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxVFiQyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661402067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyBTA-0000K0-MA
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 04:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iyBSG-00088r-Mu
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 04:22:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iyBSF-0002eR-P4
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 04:22:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43186
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iyBSF-0002cA-KV
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 04:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580635331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iPXcy2HH/YfxBvKtTL9pk2cwA0lJ+Gku0dtYFsHGHIc=;
 b=IxVFiQyQewRztJOrTfKFALiyYfN5OaoL8XC+7ML04Knu09l0hxxdfAX+MfFR+H1K7Hmwpl
 xqwP94IUHHWnklMp2phyAoRICbFqH/4HIwaPSthzncpPu+NbpILBKc0h0pk9Ipr4qpuIWi
 HOxbUZ6hA6aLFwg/TjJacaUDYOeh+6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-zbad9qgXNUaJw10_GALIkQ-1; Sun, 02 Feb 2020 04:22:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 239C31005502;
 Sun,  2 Feb 2020 09:22:08 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-29.ams2.redhat.com
 [10.36.116.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7E3560BE1;
 Sun,  2 Feb 2020 09:21:54 +0000 (UTC)
Date: Sun, 2 Feb 2020 10:21:52 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200202092152.GA3456@localhost.localdomain>
References: <871rrp474i.fsf@dusky.pond.sub.org>
 <20200124102743.GB824327@redhat.com>
 <20200124143841.GG4732@dhcp-200-226.str.redhat.com>
 <87sgk3x2im.fsf@dusky.pond.sub.org>
 <20200127115606.GA5669@linux.fritz.box>
 <1c65b678-7bb4-a4cc-5fa6-03d6d27cf381@redhat.com>
 <20200128102855.GA6431@linux.fritz.box>
 <87mua7bvwf.fsf@dusky.pond.sub.org>
 <20200128125409.GF6431@linux.fritz.box>
 <4cf1864c-3527-b015-0691-1788a37f4f7e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4cf1864c-3527-b015-0691-1788a37f4f7e@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: zbad9qgXNUaJw10_GALIkQ-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 31.01.2020 um 13:27 hat Eric Blake geschrieben:
> On 1/28/20 6:54 AM, Kevin Wolf wrote:
>=20
> > >=20
> > > The arguments as dotted keys:
> > >=20
> > >      id=3Dbar,backend.type=3Dfile,backend.data.out=3D/tmp/bar.log
> > >=20
> > > Observe there's quite some of nesting.  While that's somewhat cumbers=
ome
> > > in JSON, it's a lot worse with dotted keys, because there nesting mea=
ns
> > > repeated key prefixes.  I could give much worse examples, actually.
> >=20
> > This is true, but even without the repeated keys (e.g. in a syntax that
> > would use brackets), it would still be unnecessarily verbose and
> > probably hard to remember:
> >=20
> >      id=3Dbar,backend=3D{type=3Dfile,data=3D{out=3D/tmp/bar.log}}
>=20
> With shells like bash, that would need quoting to avoid unintended brace
> expansions.  It is not the end of the world to require shell quoting (and
> passing JSON on the command line definitely needs it), but a syntax that
> avoids shell quoting is marginally easier to type and reason about.

My point was that even with such a simplified syntax (ignoring all the
implication of using it on the command line), the additional nesting
that simple unions give you would still be bad.

That said, I actually think that a syntax like this might make sense for
something like qmp-shell. It might even be more convenient on the
command line than dotted keys if you get a lot of repetition (despite
the required quoting), but it's strictly speaking incompatible because
you could use {} in strings today.

Kevin


