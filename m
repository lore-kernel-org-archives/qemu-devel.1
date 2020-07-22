Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0081AC433E6
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:09:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC9620771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="caxembnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC9620771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyDYn-0005Cj-WC
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 08:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jyDY8-0004NB-FS
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:08:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46383
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jyDY6-0006XX-Pi
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595419717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=OcDzYTCrFI8vItXVqJ/O67h/z3VbAj2Uxj8szeY7b6A=;
 b=caxembnwagT9y5/AtTw7CBCwi5rQ0f8MElPiJdhNjlP/HltfT7T1Vfke7Vr+7M53l5ff/4
 3j9MMpwQJT6wa5TVym5ICRYzOxV70opbzd5rkV+kaLxe154LlpDyU9tKnYaZl35+ijdDF4
 kLWG9aRP3kRMI5c1bLn3b8/siKn1fXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-SKJfoKkfOnqUEU-aCQjayQ-1; Wed, 22 Jul 2020 08:08:32 -0400
X-MC-Unique: SKJfoKkfOnqUEU-aCQjayQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88E57800465;
 Wed, 22 Jul 2020 12:08:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A14961176;
 Wed, 22 Jul 2020 12:08:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 85EDC9D9F; Wed, 22 Jul 2020 14:08:27 +0200 (CEST)
Date: Wed, 22 Jul 2020 14:08:27 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: ipxe-devel@lists.ipxe.org, qemu-devel@nongnu.org
Subject: https booting
Message-ID: <20200722120827.dq72uabrk26nllra@sirius.home.kraxel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 21:28:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>, crobinso@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

With the world moving to use https by default people start to ask for
https being enabled by default for the qemu boot roms.

We could simply flip the DOWNLOAD_PROTO_HTTPS switch in
src/config/qemu/general.h (ipxe git repo).  Note that this would only
affect booting in bios mode, for uefi qemu uses the efidrv builds which
implies https support is in the hands of the uefi firmware (edk2/ovmf).

After looking at https://ipxe.org/cfg/crosscert I'm not convinced this
is a good idea though.  This would likely put quite some load to
ca.ipxe.org.  Also that machine becomes a single point of failure for
worldwide ipxe https boot, and looking through the mailing list I've
seen we already had (at least) two outages this year.

What happens if you sent crosscert to the empty string?
Will ipxe fail or will it boot without cert verification?

What does it take to mirror http://ca.ipxe.org/auto/?
Just "wget -r" everything and serve it?

How does edk2 handle the root ca problem?
Other comments?

take care,
  Gerd


