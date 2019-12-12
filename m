Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C67DC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F01B920663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f27ow7Ff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01B920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifNv4-0007cZ-0E
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 07:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ifNtj-0006AJ-UT
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:48:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ifNtg-0005gy-8k
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:48:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59643
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ifNtg-0005fi-4E
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576154927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/imIckN8U8d+XSCxCo69jxbdWcrk2oCuRa8Rl/JSOPA=;
 b=f27ow7FfXZs7pB9zN/4Wkm8pnIC5nskzvDeFsdbd5+O+TNq2gNokMCrvjzYw4WYogtP8HM
 qynQsR7z7hh5lmX2OqZAAqNQWgPkQ920KNWVtW9HU2ZDcALR8tFObj+N1hJJGB6FVYZIEu
 HnUDn9haNWxbCCVY7MvYN6e/YaC3XSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-5tOesFIrNb2fozsqYWUsmg-1; Thu, 12 Dec 2019 07:48:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B632B1800D42;
 Thu, 12 Dec 2019 12:48:44 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B21DE10013A1;
 Thu, 12 Dec 2019 12:48:43 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] numa: stop abusing numa_mem_supported
Date: Thu, 12 Dec 2019 13:48:54 +0100
Message-Id: <1576154936-178362-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 5tOesFIrNb2fozsqYWUsmg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Tao Xu <tao3.xu@intel.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A fix  and cleanup for a mistakes that slipped by me in
  aa57020774 (numa: move numa global variable nb_numa_nodes into MachineSta=
te)


CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
CC: Tao Xu <tao3.xu@intel.com>

Igor Mammedov (2):
  numa: remove not needed check
  numa: properly check if numa is supported

 hw/arm/sbsa-ref.c | 1 -
 hw/core/machine.c | 4 ++--
 hw/core/numa.c    | 7 +------
 3 files changed, 3 insertions(+), 9 deletions(-)

--=20
2.7.4


