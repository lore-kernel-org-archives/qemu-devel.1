Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0C3C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E778214DB
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyEk6A1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E778214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8p9L-0001h7-Oh
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 12:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j8p8h-00014T-4A
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j8p8f-0002qA-Pi
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:45:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59570
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j8p8f-0002nz-Ll
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583171156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nr7nuAl31PMIsroQ+gCPuBVXXnxaiJSGvWvB9ftKfxY=;
 b=OyEk6A1hKdoPy/h4+/YAtPgR2EdhhkrftMF7guppXcy1z7fK5J8Rm/xM170gsno6QYRxcZ
 3UyGj9Gp/64EBLTroWj/v1lFUUOWR23YG4KXm8/z0sAOqEk76FPcNJ5kpBLAigwtmgGpQu
 R21BTPDfDvnSgirkB00TCJplv3ZlsJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-eYYJG-JHNL60820hFNHnNg-1; Mon, 02 Mar 2020 12:45:54 -0500
X-MC-Unique: eYYJG-JHNL60820hFNHnNg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6138813E5;
 Mon,  2 Mar 2020 17:45:53 +0000 (UTC)
Received: from localhost (ovpn-126-231.rdu2.redhat.com [10.10.126.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2FFE9CA3;
 Mon,  2 Mar 2020 17:45:52 +0000 (UTC)
Date: Mon, 2 Mar 2020 12:45:51 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: CPU reset vs DeviceState reset
Message-ID: <20200302174551.GK4440@habkost.net>
References: <CAFEAcA9rQ4_o53zfsdcGZWse3eYWksYJdYHLeUFhq6TcBX3_zw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9rQ4_o53zfsdcGZWse3eYWksYJdYHLeUFhq6TcBX3_zw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

My impression is that this is just historical legacy, but I'm not
sure how much work a conversion to the new system would require.
I see lots of cpu_reset() calls scattered around the code.

To make it worse, TYPE_CPU do have a DeviceClass::reset method
implemented, but cpu_reset() won't call it because it bypasses
the Device reset system completely.  I will do some git
archaeology work to try to find out why the code is this way.


On Mon, Mar 02, 2020 at 05:20:33PM +0000, Peter Maydell wrote:
> Hi; I've just noticed that although TYPE_CPU is a subclass of
> TYPE_DEVICE, it seems to implement its own reset method
> ('reset' field in CPUClass struct) rather than just using the
> DeviceClass's 'reset'.
>=20
> Is there a reason for doing this, or is it just historical legacy
> from TYPE_CPU originally not being a subclass of TYPE_DEVICE?
>=20
> I ask because I'd like to be able to use 3-phase reset in the Arm
> CPU, and I'm wondering whether it would be better to make TYPE_CPU
> just use Device's reset system, or to treat TYPE_CPU as its own
> base class and implement Resettable there. The former seems more
> straightforward, unless I'm missing something that means we
> really do need to have the reset method be different.
>=20
> thanks
> -- PMM
>=20

--=20
Eduardo


