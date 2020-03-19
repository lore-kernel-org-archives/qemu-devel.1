Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28875C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 13:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E709620663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 13:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3BX5iol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E709620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEvQW-0006oT-20
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 09:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jEvPu-0006Pv-Nt
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jEvPt-0006KD-EV
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:40:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44488)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jEvPt-0006Ic-B1
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584625256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UBGfrARPmXJQq+pcZtjeqOldz8uFZdj+nL19h5dZnSE=;
 b=E3BX5iol1o1MA1j10eG1Wy4fvIow+MNUT359+w2oPMSyBD/BzOWfXb4rAwsY/gRmwaRDSu
 JhT8H6sAP8AiKsUt0l58OD3IcuVegC5Z8HsCDDFELLSQo8SHnCuX4M3/YNipcqejxFV8XB
 wW68YVFQec5EDZ0Lv5US28Sesz5iFcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-O3OMOzT-NwSi2KDVKy70Cg-1; Thu, 19 Mar 2020 09:40:54 -0400
X-MC-Unique: O3OMOzT-NwSi2KDVKy70Cg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F3161005514;
 Thu, 19 Mar 2020 13:40:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C70EFBBBC8;
 Thu, 19 Mar 2020 13:40:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6BC533BD; Thu, 19 Mar 2020 14:40:46 +0100 (CET)
Date: Thu, 19 Mar 2020 14:40:46 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 00/13] microvm: add acpi support
Message-ID: <20200319134046.uh2qvyshwtj6ubox@sirius.home.kraxel.org>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <2ed586e7-d7a1-77b2-ecc6-01b6fb38d72e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2ed586e7-d7a1-77b2-ecc6-01b6fb38d72e@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> Also, can you confirm that it builds without CONFIG_I440FX and
> CONFIG_Q35?  You probably need to add "imply ACPI" and possibly some
> '#include "config-devices.h"' and '#ifdef CONFIG_ACPI' here and there.

Hmm, is there some way to do this without modifying
default-configs/i386-softmmu.mak in the source tree?  So I can have two
build trees with different confugurations?  Also to reduce the risk that
I commit default-config changes by mistake?

thanks,
  Gerd


