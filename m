Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C88C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A67102072A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITy1N5M0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67102072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBFNk-0002mA-QN
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 06:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jBFKm-0007q5-6q
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:08:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jBFKl-0001Tu-Bn
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:08:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53667
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jBFKl-0001Tp-7z
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583748506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NTHpBV488e5aZnDPw7jU4Q8YTFTJdQkjmSE3RhUCd7Q=;
 b=ITy1N5M0cqSyVspeRUtbSPmyRq70kkOmPYEQLImWaZxZq9v4Dv1YozmZ/nR5JkXOfg/j08
 2c8x37G/XZ6V00AN90tgFvNfVZYEtdAllS+erhirA/+v73JXQ+siJ6bpXkJnFFU7di+05D
 jO5FgAFKudo2D9xwtB7cUliV/QZyTuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-0cR0bNcePi2uOTgfhmQ_RA-1; Mon, 09 Mar 2020 06:08:24 -0400
X-MC-Unique: 0cR0bNcePi2uOTgfhmQ_RA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1DD919251A6;
 Mon,  9 Mar 2020 10:08:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-117.ams2.redhat.com
 [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77FB95C545;
 Mon,  9 Mar 2020 10:08:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 849769D43; Mon,  9 Mar 2020 11:08:22 +0100 (CET)
Date: Mon, 9 Mar 2020 11:08:22 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Jason Andryuk <jandryuk@gmail.com>
Subject: Re: [PATCH] usb-serial: wakeup device on input
Message-ID: <20200309100822.kf3hftjdnkmbl5vx@sirius.home.kraxel.org>
References: <20200306140917.26726-1-jandryuk@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200306140917.26726-1-jandryuk@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 06, 2020 at 09:09:17AM -0500, Jason Andryuk wrote:
> Currently usb-serial devices are unable to send data into guests with
> the xhci controller.  Data is copied into the usb-serial's buffer, but
> it is not sent into the guest.  Data coming out of the guest works
> properly.  usb-serial devices work properly with ehci.
>=20
> Have usb-serial call usb_wakeup() when receiving data from the chardev.
> This seems to notify the xhci controller and fix inbound data flow.
>=20
> Also add USB_CFG_ATT_WAKEUP to the device's bmAttributes.  This matches
> a real FTDI serial adapter's bmAttributes.
>=20
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>

Added to usb patch queue.

thanks,
  Gerd


