Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E2FC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 200AA2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPb7TtgJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200AA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaf6d-0000yW-Aa
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 07:10:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iaeho-00083h-Gq
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iaehi-0001AI-Ep
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:44:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20871
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iaehi-0000oa-AV
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575027888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EO98kSPFX5ScSytrGF7qeyKiDGrEGMCrKQiLRoYh2lg=;
 b=UPb7TtgJEl8sw5UrjjL7lj634ZNhBaT7Tj/ZjyhRkSH8XWA7r5cG0qcopah8lV8O10k2vl
 CzhgCAaz2fY/L8avdXtRJN/RF8qCwYYBdRkz+6cCFYmSD92yGTodKfqw1oximVPB9qJQc4
 B0FohTnvKPqqShBTo1kKeQNDAzxOTzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-F1A7Uw9IPDqo_nZTd7AmfA-1; Fri, 29 Nov 2019 06:44:47 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4722107ACCC;
 Fri, 29 Nov 2019 11:44:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com
 [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E560819C4F;
 Fri, 29 Nov 2019 11:44:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 135E116E08; Fri, 29 Nov 2019 12:44:39 +0100 (CET)
Date: Fri, 29 Nov 2019 12:44:39 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
Message-ID: <20191129114439.kyky7jgboclrd56w@sirius.home.kraxel.org>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191129070253.5hwksjrapomk434x@sirius.home.kraxel.org>
 <CAMxuvawieN7JQZkRku19v5X-o6q664Wz1Rtx3+Wz3d33m-7Tug@mail.gmail.com>
 <20191129092713.GA2260471@redhat.com>
 <CAMxuvaw=o9xP4G1GD95xVUb2as9R_pUB_85muRUVP8p3pEeqxw@mail.gmail.com>
 <20191129094230.GE2260471@redhat.com>
 <CAMxuvayDmXcFSvjyBC+e=40tO6N15rbBETDsP_kYoHOU1xKrpg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMxuvayDmXcFSvjyBC+e=40tO6N15rbBETDsP_kYoHOU1xKrpg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: F1A7Uw9IPDqo_nZTd7AmfA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > Possibly, but if we're relying on shm_open choosing the path, then
> > its harder for users to know what files to clean up when QEMU crashes
> > or otherwise exits wthout a shm_unlink
>=20
> True, although I think you can call shm_unlink() right after
> shm_open() that should limit the risk of those forgotten files.

Yes, this is possible and pretty standard ...

cheers,
  Gerd


