Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B762CC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D1132070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXe5FaaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1132070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwke5-0000eb-NV
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 05:32:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iwkd7-0008PF-6R
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:31:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iwkd6-0006qy-8H
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:31:29 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24241
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iwkd6-0006qI-4s
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580293887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:openpgp:openpgp;
 bh=6EjAySESYCEpbNa5YhezTrn5PKK8LCPQTZpErwB1j7Y=;
 b=FXe5FaaUEIBsKciWJGyKglTBuRoMRw5RcSsWpvdcYGQsjHjuj3DoeWrpU/DSU4YJ4y943/
 Oq5tC6+py7kKGVwK5g8QR6Ph44edZD2yTy1ouwb76dZZGbznVEzrVDEibOM7dQ9Ije6D4b
 H/QrU95eExZGIUTg0vH+KZvdAvmpPLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-jigTN7pLPaSoKLa8LNqm6g-1; Wed, 29 Jan 2020 05:31:24 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDE7F1005510;
 Wed, 29 Jan 2020 10:31:22 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-210.ams2.redhat.com [10.36.116.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8467438A;
 Wed, 29 Jan 2020 10:31:21 +0000 (UTC)
To: QEMU Developers <qemu-devel@nongnu.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
From: Thomas Huth <thuth@redhat.com>
Subject: Assertion triggers with power8e_v2.1-powernv-cpu-core
Openpgp: preference=signencrypt
Message-ID: <5937c35c-e290-5b7a-18f4-05a5149b58c5@redhat.com>
Date: Wed, 29 Jan 2020 11:31:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: jigTN7pLPaSoKLa8LNqm6g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

FYI, scripts/device-crash-test reported an assertion, triggerable like this=
:

$ qemu-system-ppc64 -machine ppce500 -device power8e_v2.1-powernv-cpu-core
qemu-system-ppc64: hw/ppc/pnv_core.c:221: pnv_core_realize: Assertion
`pc->chip' failed.
Aborted (core dumped)

Of course using that CPU is not possible on ppce500, but there should be
a proper error message instead of that assertion.

Does anybody have an idea what's the best place to fix this issue?

 Thomas


