Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD25C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 08:13:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBEBA219FA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 08:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTsx5Prv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEBA219FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXL7R-0000vx-11
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 03:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iXL6I-0000Lk-VX
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iXL6F-0003aF-CT
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:12:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31783
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iXL6E-0003W0-39
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574237548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dai1y5p7nESBEGyahPu7cjZeXzizjnycXANk6URNQSM=;
 b=HTsx5Prv7q6ni8Mh/1S7SH1XFFNClIQLOrdkipRhOhQevY7qKU3G0i9cGFTFq2dB+icL/v
 xH/U/+F1+/hHJYagdrJKJynSZJ+ptqlvqGrZRVha8O4WxKVN8AjeHYhgHvJZHTGRrligfE
 9xNb1mAHsfKly/7NIQJdY8Sy9rCvBz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-nmpgWfWTM-yVGEqkphqMqg-1; Wed, 20 Nov 2019 03:12:24 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C612D80269E;
 Wed, 20 Nov 2019 08:12:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com
 [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 565D21FA;
 Wed, 20 Nov 2019 08:12:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5A93A16E08; Wed, 20 Nov 2019 09:12:22 +0100 (CET)
Date: Wed, 20 Nov 2019 09:12:22 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH] audio: fix audio recording
Message-ID: <20191120081222.tyvil4rhikzxn4yd@sirius.home.kraxel.org>
References: <2fc947cf-7b42-de68-3f11-cbcf1c096be9@t-online.de>
MIME-Version: 1.0
In-Reply-To: <2fc947cf-7b42-de68-3f11-cbcf1c096be9@t-online.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: nmpgWfWTM-yVGEqkphqMqg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 19, 2019 at 07:58:49AM +0100, Volker R=FCmelin wrote:
> With current code audio recording with all audio backends
> except PulseAudio and DirectSound is broken. The generic audio
> recording buffer management forgot to update the current read
> position after a read.
>=20
> Fixes: ff095e5231 "audio: api for mixeng code free backends"
>=20
> Signed-off-by: Volker R=FCmelin <vr_qemu@t-online.de>

Queued for 4.2

thanks,
  Gerd


