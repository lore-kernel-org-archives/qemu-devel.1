Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AC4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0DDE206F6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNO+UFQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DDE206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtK7F-00044r-8N
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 20:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtK6e-0003Zm-R4
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:08:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20543
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtK6d-0005yv-DX
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594253282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:openpgp:openpgp;
 bh=NFLZZgQSQWuDTZVFkQDcGuMXnwXPyj3SQfqrhOQ+LYk=;
 b=TNO+UFQxnScvaiKarxYrozfbzjdGVK/KtSzXS5a7iYqcu+0XmVx8S+cflrBqURwOjdAy4m
 EPn30Qqlh/U++Del6LErEIgwee7awLaW/8yJeTTT5HxJvjimARZXe/7R5nDU56UIg6U8hX
 EA8E2XG7olTyrHstjxtEHjcbVNeNfDw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-_YFdKKFCPFOfs5pDDBrWlw-1; Wed, 08 Jul 2020 04:03:52 -0400
X-MC-Unique: _YFdKKFCPFOfs5pDDBrWlw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F9DE107B265;
 Wed,  8 Jul 2020 08:03:51 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-90.ams2.redhat.com [10.36.114.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0ADBF5C1B2;
 Wed,  8 Jul 2020 08:03:49 +0000 (UTC)
To: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
From: Thomas Huth <thuth@redhat.com>
Subject: qemu-system-ppc64 abort()s with pcie bridges
Openpgp: preference=signencrypt
Message-ID: <211dfb13-64cc-850b-4936-0f20f0157d7c@redhat.com>
Date: Wed, 8 Jul 2020 10:03:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, David Gibson <dgibson@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


 Hi,

qemu-system-ppc64 currently abort()s when it is started with a pcie
bridge device:

$ qemu-system-ppc64 -M pseries-5.1 -device pcie-pci-bridge
Unexpected error in object_property_find() at qom/object.c:1240:
qemu-system-ppc64: -device pcie-pci-bridge: Property '.chassis_nr' not found
Aborted (core dumped)

or:

$ qemu-system-ppc64 -M pseries -device dec-21154-p2p-bridge
Unexpected error in object_property_find() at qom/object.c:1240:
qemu-system-ppc64: -device dec-21154-p2p-bridge: Property '.chassis_nr'
not found
Aborted (core dumped)

That's kind of ugly, and it shows up as error when running
scripts/device-crash-test. Is there an easy way to avoid the abort() and
fail more gracefully here?

 Thomas


