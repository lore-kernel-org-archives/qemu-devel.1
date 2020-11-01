Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7624CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 16:17:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC03922268
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 16:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GEMz9n2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC03922268
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZG2z-0006yr-Pb
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 11:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kZG1J-0005tV-7F
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 11:15:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kZG1D-0004Sz-4b
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 11:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604247342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wxDui5vLhkrEB0SMvc7xZ9F+UPVtAyMSnU2M6fkS+Mc=;
 b=GEMz9n2y4XKSPHlBzyUuzWoRowCRFb2tjhCQ/Ez42LjZz3Bq0VxIK4abIXB/EbD/T0+zeQ
 mWMrYMvQ9DS7dwdnB4Php/eBabqeXpiImQAT45fjbNBtf/I/+aI95Ua2TS7bm1M8YNeMV5
 64kVr1Oq12r/RPhfnNbGNXihxVejh6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-LzYQAqSCOwmev3Sxj0PYbQ-1; Sun, 01 Nov 2020 11:15:39 -0500
X-MC-Unique: LzYQAqSCOwmev3Sxj0PYbQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E4D11868402;
 Sun,  1 Nov 2020 16:15:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 825F55C1A3;
 Sun,  1 Nov 2020 16:15:34 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] Assorted fixes to tests that were broken by recent
 scsi changes
Date: Sun,  1 Nov 2020 18:15:30 +0200
Message-Id: <20201101161532.259609-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 11:15:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While most of the patches in V1 of this series are already merged upstream,=
=0D
the patch that fixes iotest 240 was broken on s390 and was not accepted.=0D
=0D
This is=09an updated version of this patch, based on Paulo's suggestion,=0D
that hopefully makes this iotest work on both x86 and s390.=0D
=0D
Best regards,=0D
=09Maxim Levitsky=0D
=0D
Maxim Levitsky (2):=0D
  iotests: add filter_qmp_virtio_scsi function=0D
  iotests: rewrite iotest 240 in python=0D
=0D
 tests/qemu-iotests/240        | 228 +++++++++++++++-------------------=0D
 tests/qemu-iotests/240.out    |  76 +++++++-----=0D
 tests/qemu-iotests/iotests.py |  10 ++=0D
 3 files changed, 153 insertions(+), 161 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


