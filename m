Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9179DC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 08:16:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D47207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 08:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iiMv3iTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D47207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8fkV-00078y-In
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 04:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k8fjs-0006iF-PB
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 04:16:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50941
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k8fjp-0003AV-Nk
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 04:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597911355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G8PB+9csdp8bUyj/XuhwvNJ0bqm5mrt8Vx2zxSxS7+E=;
 b=iiMv3iToEp0a3IIpPF++eFy6Go0LS/Fr3dld9MVW6KwFMiMPPpm0nZzaPfoBD5WA+H9E4y
 H1dVOfHLIqKHKk0XMOpB9MDEUGIvQUdyNhcJVhjaTOjS2JYmHQOQRwPXdOvA7GdqY9nXww
 +222AYr5pRWD9IGoUkJqor6sW0MHojQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-74NLpNsrPxazZdNsqjuuvA-1; Thu, 20 Aug 2020 04:15:54 -0400
X-MC-Unique: 74NLpNsrPxazZdNsqjuuvA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 044DF8030C6;
 Thu, 20 Aug 2020 08:15:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97493600DD;
 Thu, 20 Aug 2020 08:15:52 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4EEE817447; Thu, 20 Aug 2020 10:15:51 +0200 (CEST)
Date: Thu, 20 Aug 2020 10:15:51 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: Difficulty making usb-serial device visible within the guest
Message-ID: <20200820081551.cqq66tekukeuw5kt@sirius.home.kraxel.org>
References: <94bb73bd-646d-9717-93b4-5a2993dd1cae@ilande.co.uk>
MIME-Version: 1.0
In-Reply-To: <94bb73bd-646d-9717-93b4-5a2993dd1cae@ilande.co.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> With auto-attach disabled this effectively prevents the device from
> attaching to the USB unless the chardev is opened which feels odd.

Why?  It's not needed to connect at boot btw, the device will be
hotplugged if the chardev is opened.

> I would expect that if I add a device to QEMU using -device then it is
> immediately visible in the guest, and if the chardev isn't connected
> then the device should report its status as disconnected as you would
> expect with a real USB to RS232 adapter.

Huh?  How would that work?  You can do some guesswork using modem line
status etc, but as far I know _reliable_ connected/disconnected
reporting simply doesn't exist in the world of serial lines ...

I'm open to add a device property to turn off the hotplug behavior.
Patches are welcome.

take care,
  Gerd


