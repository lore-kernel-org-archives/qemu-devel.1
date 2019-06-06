Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD7FC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 16:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5CE320693
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 16:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5CE320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34874 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYv9I-0001VZ-Fw
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 12:21:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1hYv8U-00011Q-22
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1hYv8H-0004Ad-9K
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:21:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1hYv84-0001ah-5t
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:20:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C2AFF3DE10;
	Thu,  6 Jun 2019 16:19:52 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-116-19.ams2.redhat.com [10.36.116.19])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DBE1116907;
	Thu,  6 Jun 2019 16:19:45 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
	id 08F133E0029; Thu,  6 Jun 2019 18:19:44 +0200 (CEST)
Date: Thu, 6 Jun 2019 18:19:43 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190606161943.GA9657@paraplu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Thu, 06 Jun 2019 16:19:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] PCI(e): Documentation "io-reserve" and related
 properties?
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi folks,

Today I learnt about some obscure PCIe-related properties, in context of
the adding PCIe root ports to a guest, namely:

    io-reserve
    mem-reserve
    bus-reserve
    pref32-reserve
    pref64-reserve

Unfortunately, the commit[*] that added them provided no documentation
whatsover.

In my scenario, I was specifically wondering about what does
"io-reserve" mean, in what context to use it, etc.  (But documentation
about other properties is also welcome.)

Anyone more well-versed in this area care to shed some light?


[*] 6755e618d0 (hw/pci: add PCI resource reserve capability to legacy
    PCI bridge, 2018-08-21)

-- 
/kashyap

