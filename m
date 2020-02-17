Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521B5C7619B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBBCE2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCg11yOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBBCE2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3bfr-0005xd-VP
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 03:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j3bex-0005NA-HD
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:21:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j3bev-0000Rx-Cv
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:21:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25892
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j3beu-0000Qo-R4
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581927700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9/VqvK4kbIv0VTgQPYgMvTJKYJGg99gLpbhRvjeVa4Q=;
 b=FCg11yOv/Pt+7/i5q1RQadjWdWdDOP/xZWpHF1E4zpGX24e/wBXfbWZpWVc7f4CMcZl0kC
 H0lxsQWzDEo79kpD8r+Cy5GoCxypb2tYV+JTIOKgZHY4gLls5ayJbOv12vq6nS9QYkusS9
 fpartaxHEEuWxO72tDbB/7ZnPh1+3y4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-p0V941mRNciP_3H6GZbJxw-1; Mon, 17 Feb 2020 03:21:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDD0F100550E;
 Mon, 17 Feb 2020 08:21:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com
 [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A86917DC8;
 Mon, 17 Feb 2020 08:21:32 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9085216E1A; Mon, 17 Feb 2020 09:21:31 +0100 (CET)
Date: Mon, 17 Feb 2020 09:21:31 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 0/3] arm: allwinner: Wire up USB ports
Message-ID: <20200217082131.t4fllrufcxipipdp@sirius.home.kraxel.org>
References: <20200215001248.2642-1-linux@roeck-us.net>
MIME-Version: 1.0
In-Reply-To: <20200215001248.2642-1-linux@roeck-us.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: p0V941mRNciP_3H6GZbJxw-1
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 14, 2020 at 04:12:45PM -0800, Guenter Roeck wrote:
> Instantiate EHCI and OHCI controllers on Allwinner A10.
>=20
> The first patch in the series moves the declaration of EHCISysBusState
> from hcd-ohci.c to hcd-ohci.h. This lets us add the structure to
> AwA10State. Similar, TYPE_SYSBUS_OHCI is moved to be able to use it
> outside its driver.
>=20
> The second patch introduces the ehci-sysbus property "companion-enable".
> This lets us use object_property_set_bool() to enable companion mode.
>=20
> The third patch instantiates EHCI and OHCI ports for Allwinner-A10
> and marks the OHCI ports as companions of the respective EHCI ports.
>=20
> Tested by attaching various high speed and full speed devices, and by
> booting from USB drive.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

(assuming this is will be merged via arm queue)

cheers,
  Gerd


