Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799D7C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:40:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447DE21741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flAWmUo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447DE21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izhO8-0004kC-Ex
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:40:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izhMl-00034v-CK
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izhMk-0000G1-52
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:38:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25091
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izhMk-0000FJ-0Z
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580996325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=13Ih9BMAvPcaMNs79IxAeVXEIgdMhz/sFN8oJ8sjHnI=;
 b=flAWmUo8ryCFGlPDt5iEhTQyxw9qJqw3AZ9cL4flMNqSn+mGKuiCjsm48ig2zX+LRlD59f
 QHX4fkRW4sSUEClyzavHMK0oYs7fxVNo5FmPRBqi3ALYtuzbWSIC22Y38GG42asX9Q6xKj
 DPcCd/gFyf1z6gOOrPf9KQsF3gym/v0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-HvrLmWEVPuKuEK0jmhrj-Q-1; Thu, 06 Feb 2020 08:38:41 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36661DB61;
 Thu,  6 Feb 2020 13:38:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3F7B85F13;
 Thu,  6 Feb 2020 13:38:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 200409D7F; Thu,  6 Feb 2020 14:38:39 +0100 (CET)
Date: Thu, 6 Feb 2020 14:38:39 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH] coreaudio: fix coreaudio playback
Message-ID: <20200206133839.cz6237wmsptx7hp5@sirius.home.kraxel.org>
References: <30c8b9e6-484c-5785-b178-bef01628db49@t-online.de>
 <20200202140641.4737-1-vr_qemu@t-online.de>
MIME-Version: 1.0
In-Reply-To: <20200202140641.4737-1-vr_qemu@t-online.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: HvrLmWEVPuKuEK0jmhrj-Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Programmingkid <programmingkidx@gmail.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu Developers <qemu-devel@nongnu.org>,
 =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Feb 02, 2020 at 03:06:41PM +0100, Volker R=C3=BCmelin wrote:
> There are reports that since commit 2ceb8240fa "coreaudio: port
> to the new audio backend api" audio playback with CoreAudio is
> broken. This patch reverts some parts the commit.
>=20
> Because of changes in the audio subsystem the audio clip
> function in v4.1.0 of coreaudio.c had to be moved to mixeng.c
> and the generic buffer management code needed a hint about the
> size of the float type.
>=20
> This patch is based on a patch from Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3 fou=
nd at
> https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg02142.html.
>=20
> Fixes: 2ceb8240fa "coreaudio: port to the new audio backend api"
>=20
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>

Patch queued.

thanks,
  Gerd


