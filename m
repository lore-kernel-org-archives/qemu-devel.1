Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C392C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D0A20771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tb3U5v63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D0A20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyHSy-0005nU-7R
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 12:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jyHR1-0003hz-2s
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:17:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26419
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jyHQy-00044T-IO
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595434650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6MLqu9HsFjL05pldt1yhj0jp24i4tPcl9tEGZ0+OWiM=;
 b=Tb3U5v63ghX4Fp6SArc+zRQ6N0EMxpzD6gjzagJgZTh2RfLzlMQ1e4w46jZ2AxY+USVAp5
 Y+eL0iBvp9LQ35VF3u2e04aJfZyK7rHOAbiLI0jSTOqQ4wITbbIuoPxIkanUt53wilQj3U
 Hx59rBk61T7CD5098PL9bmXqoK+gYtc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-caDdXhmdPLOLJOATltBzaA-1; Wed, 22 Jul 2020 12:17:28 -0400
X-MC-Unique: caDdXhmdPLOLJOATltBzaA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CDFB8005B0;
 Wed, 22 Jul 2020 16:17:27 +0000 (UTC)
Received: from starship.redhat.com (unknown [10.35.206.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57BD474F58;
 Wed, 22 Jul 2020 16:17:23 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/1] RFC: pcie: parital fix for missing unplug events
Date: Wed, 22 Jul 2020 19:17:21 +0300
Message-Id: <20200722161722.51416-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:34:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Maxim Levitsky <mlevitsk@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As described in bugzilla #1854264 it is possible to plug=0D
a pcie device and then unplug it before the guest notices=0D
(has time to process the attention button press)=0D
=0D
To partially fix this issue, detect and refuse the hotunplug event.=0D
=0D
There are other ways to fix this, which is why I am sending this as RFC:=0D
=0D
1. Queue/remember the unplug event and fire it (press the attention button =
again),=0D
when the guest clears its pending status.=0D
According to the spec this should cancel the hotplug event in the guest=0D
if done within 5 seconds (and I think that guest actually should wait 5 sec=
onds=0D
after attention button is pressed before plugging in the device too to be s=
trictly=0D
up to the spec)=0D
=0D
2. Detect that device isn't yet powered on by the guest (for example=0D
checking the bus master bit) or check that attention button is still=0D
pressed and in this case just unplug the device immediately.=0D
=0D
Best regards,=0D
=09Maxim Levitsky=0D
=0D
Maxim Levitsky (1):=0D
  pci/pcie: refuse another hotplug/unplug event if attention button is=0D
    pending=0D
=0D
 hw/pci/pcie.c | 11 +++++++++++=0D
 1 file changed, 11 insertions(+)=0D
=0D
--=20=0D
2.26.2=0D
=0D


