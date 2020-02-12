Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B1CC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C28E20675
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PL8Jshtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C28E20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1r3o-0001hM-Eh
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 07:24:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j1r3E-0001II-QF
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j1r3D-0001oH-1W
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:23:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56643
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j1r3C-0001mM-RY
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581510210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Avj9lhcSG6I9fpe09+qYZ01I5ZWz/PBXGFcFEC/MI98=;
 b=PL8JshtmnUt6t7H5KG8PQm3g/OqeVXDMJvI4FMRFTHHuxXer8d3E9MediYlWcQkriyDZ4l
 TzGJxg2JkykNavFsqxcbIrbYmYSoGh1zeTWAvmEULIoWRrVo5dMKVMPGRY35iv2/wcsX2A
 QprI2vGTgwOaVLK4GEG2qL3Q5pksLWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-GPNKCF-rO4Gvwb2B1lN__Q-1; Wed, 12 Feb 2020 07:23:22 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DB131005513;
 Wed, 12 Feb 2020 12:23:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com
 [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB0E35C1B2;
 Wed, 12 Feb 2020 12:23:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id ECAEB9D6B; Wed, 12 Feb 2020 13:23:19 +0100 (CET)
Date: Wed, 12 Feb 2020 13:23:19 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 0/2] ui/gtk: Fix gd_refresh_rate_millihz() when widget
 window is not realized
Message-ID: <20200212122319.hovv4e3jkkcvpxtl@sirius.home.kraxel.org>
References: <20200208161048.11311-1-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200208161048.11311-1-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: GPNKCF-rO4Gvwb2B1lN__Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Jan Kiszka <jan.kiszka@web.de>, qemu-devel@nongnu.org,
 Nikola Pavlica <pavlica.nikola@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Feb 08, 2020 at 05:10:46PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Fix bug report from Jan Kiszka:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg678130.html
> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg02260.html

Added to UI queue.

thanks,
  Gerd


