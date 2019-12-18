Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2567EC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 06:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24F620716
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 06:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Po5e/out"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24F620716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihSTJ-0005gW-Uf
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 01:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihSSW-0004rR-5C
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 01:05:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihSST-0005wv-E3
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 01:05:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56959
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihSST-0005uN-1O
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 01:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576649116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dxu7JekNHm3dJ9ZpgeBC7AVH7BJaW+wzgYxjoq4cflo=;
 b=Po5e/outreWza5/qjFb6It0moJfA4cJ2xiiP1aIaFuAHWVBSg/pjPdrduo8haaNYE8bagU
 ZZri6CqO8wmNM9Sg+BmnMKLM8TknvLPjD7W5qi/ZlDNaHe/Cop3B74qCgcmWbHmm1bhaUZ
 ScwiRozwC4azxCSO+IJP14R8lpH6o+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-G2M3ZjM2MKScFvK70WmcPg-1; Wed, 18 Dec 2019 01:05:14 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 100FC8017DF;
 Wed, 18 Dec 2019 06:05:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CAD660C18;
 Wed, 18 Dec 2019 06:05:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C037D11386A7; Wed, 18 Dec 2019 07:05:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Chubb\, Peter \(Data61\, Kensington NSW\)" <Peter.Chubb@data61.csiro.au>
Subject: Re: [PATCH 0/6] Fix more GCC9 -O3 warnings
References: <20191217173252.4672-1-philmd@redhat.com>
 <84fthiaahd.wl-Peter.Chubb@data61.csiro.au>
Date: Wed, 18 Dec 2019 07:05:03 +0100
In-Reply-To: <84fthiaahd.wl-Peter.Chubb@data61.csiro.au> (Peter Chubb's
 message of "Tue, 17 Dec 2019 21:49:35 +0000")
Message-ID: <87a77q9njk.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: G2M3ZjM2MKScFvK70WmcPg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Hannes Reinecke <hare@suse.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.au>
writes:

>>>>>> "Philippe" =3D=3D Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wr=
ites:
>
> Philippe> Fix some trivial warnings when building with -O3.
>
> For compatibility with lint and other older checkers, it'd be good to kee=
p
> this as /* FALLTHROUGH */ (which gcc should accept according to its
> manual).

We have hundreds of /* fall through */ comments already.

> Fixing the comments' placement is a different matter, and should be
> done.  Seems to me that until gcc started warning for this, noone had
> actually run a checker, and the comments were just for human info.
>
> Peter C


