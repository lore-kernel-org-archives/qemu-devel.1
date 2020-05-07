Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD625C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8427B20643
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6DHrV2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8427B20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWhqi-00036Q-MV
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 10:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jWhpy-0002I5-Qj
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:49:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51548
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jWhpy-000871-3f
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588862961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uHQndjzVFWDYsY8OzJ1ZpaOFAkMFhi/bqw0JPYzZmU8=;
 b=h6DHrV2Jwto8rvcdKl5tjJXe3DmTTbZ1bxVK/66bttAbU3sEDLT7vlLvYlh8bE5z0xnVBX
 +A9Ay6OqubNIbABg+FMr1S5A7Sl40CQa3UX9qBX0gy1im/SIu/WVdZl7Nuh7fbgyvpk4zK
 eB1JQM/mUXLUTsW+Hmxx9bfUkdYSUzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-V_DQ9JpjNrOPrYLDEXhT2g-1; Thu, 07 May 2020 10:49:18 -0400
X-MC-Unique: V_DQ9JpjNrOPrYLDEXhT2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02B981895943
 for <qemu-devel@nongnu.org>; Thu,  7 May 2020 14:49:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2784860BEC;
 Thu,  7 May 2020 14:49:15 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3B3AB17477; Thu,  7 May 2020 16:49:14 +0200 (CEST)
Date: Thu, 7 May 2020 16:49:14 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: libvir-list@redhat.com, qemu-devel@nongnu.org
Subject: device hotplug & file handles
Message-ID: <20200507144914.4zg3753uh3kytz6g@sirius.home.kraxel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 00:55:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

For usb device pass-through (aka -device usb-host) it would be very
useful to pass file handles from libvirt to qemu.  The workflow would
change from ...

  (1) libvirt enables access to /dev/usb/$bus/$dev
  (2) libvirt passes $bus + $dev (using hostbus + hostaddr properties)
      to qemu.
  (3) qemu opens /dev/usb/$bus/$dev

... to ...

  (1) libvirt opens /dev/usb/$bus/$dev
  (2) libvirt passes filehandle to qemu.

Question is how can we pass the file descriptor best?  My idea would be
to simply add an fd property to usb-host:

 * Coldplug would be "-device usb-host,fd=3D<nr>" (cmd line).
 * Hotplug would be "device_add usb-host,fd=3D<getfd-name>" (monitor).

Will that work from libvirt point of view?
Or does anyone have an better idea?

thanks,
  Gerd

PS: background: https://bugzilla.redhat.com/show_bug.cgi?id=3D1595525


