Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC58C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 07:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F162051A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 07:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FC/DlTHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F162051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSyIC-00035r-Pf
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 03:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jSyHB-0002Ek-4I
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 03:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jSyHA-0001vZ-1g
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 03:34:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37632
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jSyH9-0001vG-IF
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 03:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587972837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rYHyCagi8pZ4iAk2zsuPkz83ijMVB+7cbW2/eoOMclo=;
 b=FC/DlTHpIWSg8L/tzkmOANVV/0r89EhAfUVu146Fy7BYRwoKx62r23rcnjIicZ/7jgzt0N
 jtMmOUQ9uLHLx60g7pIM8ux2eOY6Ug6cE+0+PPVKSOsCW7nzwKhg7h/7dUGMq5ejcibxv2
 aBKRVl7yZBq+bUuTv6G3x5whLzsqQT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-hbQliZoCMP-O9KAAbUXUVg-1; Mon, 27 Apr 2020 03:33:53 -0400
X-MC-Unique: hbQliZoCMP-O9KAAbUXUVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A759A0BD7;
 Mon, 27 Apr 2020 07:33:52 +0000 (UTC)
Received: from gondolin (ovpn-112-184.ams2.redhat.com [10.36.112.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB3305C1D4;
 Mon, 27 Apr 2020 07:33:48 +0000 (UTC)
Date: Mon, 27 Apr 2020 09:33:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Yuri Benditovich
 <yuri.benditovich@daynix.com>
Subject: VIRTIO_NET_HDR_F_RSC_INFO in virtio-net vs headers update
Message-ID: <20200427093345.4111acd9.cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 02:05:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I'm currently trying to prepare a linux-headers update to 5.7-rc3,
which adds the definition of VIRTIO_NET_HDR_F_RSC_INFO.

Unfortunately, this breaks the build of virtio-net, because now
virtio_net_rsc_ext_num_{packets,dupacks} are undefined (they are
guarded by existence of VIRTIO_NET_HDR_F_RSC_INFO).

What is the right way to fix this? Remove the constants that are now
provided by the header and keep the definitions of
virtio_net_rsc_ext_num_{packets,dupacks}?

[I'd like to queue a headers update as soon as possible, as the whole
s390 protected virt stuff depends on it...]


