Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC85AC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:39:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99EA221741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilLl7Im0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99EA221741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izhN3-0003IS-PJ
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izhMJ-0002Rq-1a
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:38:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izhMI-0007U6-5N
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:38:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24126
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izhMI-0007SZ-0f
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580996297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bVAQTC1MkQeu44UoDFmxX0x6RTuHmlkEAFh+mXbhzQA=;
 b=ilLl7Im0pECWK1XZ23oMLul5A1rv3nrIQ6Ih8EvgGgnufQMljP4fFnnuxhbHtZGqB6kahv
 zpvVn4pu0zUSTnKLqa4h2Bu8xNiiHmwScse4im2SWqgrge6jw766ewzQACZJpJBkKK66Ds
 XUHqFTyJB3tcQHfHdkYJvehw4CqDI6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-q_y44_i8P1KXw8_tB-btXA-1; Thu, 06 Feb 2020 08:38:14 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0313F8010E6;
 Thu,  6 Feb 2020 13:38:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BACB060BEC;
 Thu,  6 Feb 2020 13:38:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1F4259D7F; Thu,  6 Feb 2020 14:38:12 +0100 (CET)
Date: Thu, 6 Feb 2020 14:38:12 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Subject: Re: [PATCH] audio/dsound: fix invalid parameters error
Message-ID: <20200206133812.4ql2tkb5yzdssy2h@sirius.home.kraxel.org>
References: <fe9744216d9d421a2dbb09bcf5fa0dbd18f77ac5.1580684275.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <fe9744216d9d421a2dbb09bcf5fa0dbd18f77ac5.1580684275.git.DirtY.iCE.hu@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: q_y44_i8P1KXw8_tB-btXA-1
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
Cc: qemu-devel@nongnu.org, KJ Liew <liewkj@yahoo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 03, 2020 at 12:02:23AM +0100, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1=
n wrote:
> Windows (unlike wine) bails out when IDirectSoundBuffer8::Lock is called
> with zero length.  Also, hw->pos_emul handling was incorrect when
> calling this function for the first time.
>=20
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
> Reported-by: KJ Liew <liewkj@yahoo.com>

Patch queued.

thanks,
  Gerd


