Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0EAC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 08:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCBAC2064A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 08:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K81QdZV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBAC2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j92V5-0003Aa-Sr
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 03:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j92UO-0002Oz-5j
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:01:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j92UN-0008BF-4d
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:01:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21587
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j92UN-0008Ay-1o
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583222474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wm90ol0NPjDNZg72Nx1LBEYsoakaot778J/Y84wn4t0=;
 b=K81QdZV0rGu6/QLpDN3Mc/vrBvfkub5voK3u9rYkbpXcKGykplV3wgYmY8b8hJbPgfdAdv
 lvSoNGq8NDqEMm/psghH85k/csiZhjQ33zqzOKayzC+n76qc0fFjo8JHN4CbPwBwsftdkf
 QvLB83HyB+vE9tzycJETQBR2WZuIiX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-KX6OMs31OxSAEYyIrd6HJw-1; Tue, 03 Mar 2020 03:01:13 -0500
X-MC-Unique: KX6OMs31OxSAEYyIrd6HJw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0C97800D53;
 Tue,  3 Mar 2020 08:01:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 16A7E92D01;
 Tue,  3 Mar 2020 08:01:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8F27B11386A6; Tue,  3 Mar 2020 09:01:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v7 00/11] error: auto propagated local_err part I
References: <20200131130118.1716-1-vsementsov@virtuozzo.com>
Date: Tue, 03 Mar 2020 09:01:03 +0100
In-Reply-To: <20200131130118.1716-1-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 31 Jan 2020 16:01:07 +0300")
Message-ID: <87y2shdg00.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, armbru@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Vladimir,

I've come to rather like your ERRP_AUTO_PROPAGATE() idea.  What I
wouldn't like is a protracted conversion.

Once we're happy with PATCH 1-3, it's a matter of running Coccinelle and
reviewing its output.  I'm confident we can converge on PATCH 1-3.

It's two weeks until soft freeze.  We need to decide whether to pursue a
partial conversion for 5.0 (basically this series plus the two patches
we identified in review of PATCH 1), or delay until 5.1.  In either
case, I want the conversion to be finished in 5.1.

Please do not feel pressured to make the 5.0 deadline.

I can queue up patches for 5.1 during the freeze.

How would you like to proceed?


