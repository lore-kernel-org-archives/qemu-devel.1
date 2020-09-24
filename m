Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95DCC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 17:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC39C2396E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 17:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="bhaEJLZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC39C2396E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLVEF-0007EM-T2
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 13:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kLVD7-0006l4-TL
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 13:39:13 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:43707)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kLVD5-0000jJ-SF
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 13:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=bkjBGLHMsldmGnS67ltXOKpPM1buiqmkYfBnw+1PesQ=; b=bhaEJLZbsUt4kDENrkHc59qAak
 NwErI8+6VXy1QExkn+SOupdLXJw3MFDpQKXlYZEJKrpp+Yl0AY/zw9n0x0JPboxTb++VJLWNCfNe3
 LyAEWrDIS316d+7LHlh3PG4f3n7Q9F5f6N4BzerYLZO2ll3RD4J1leEHLEdom+bzLsmwtx+86FRqD
 Am9vPYp2k9zNPjlJW+vPn8ANNv6fcw38bAkLmizGMfJKyNdKysrq52LYrayJdtLhaSOIIPybIJ5wj
 1ATPJJyGR6msPr7Qsooli8FuaTFcIjUwfeZgPko6YtTzD6sNC/e2kK3yK7JMnH1GQjDIdyIPnBdfr
 y8wRHn6A==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Subject: Re: qtest with multiple driver instances
Date: Thu, 24 Sep 2020 19:39:07 +0200
Message-ID: <3016343.G3L0rNCyDI@silver>
In-Reply-To: <b6dcb4c7-65d7-f97a-09c1-b6526380331d@redhat.com>
References: <4696583.mNQJtTt8NE@silver>
 <7ae8f0cc-021e-d982-4d1d-a46afc37bf28@redhat.com>
 <b6dcb4c7-65d7-f97a-09c1-b6526380331d@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 13:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 24. September 2020 16:27:53 CEST Paolo Bonzini wrote:
> On 24/09/20 15:50, Thomas Huth wrote:
> >> Is there any workaround or something that I didn't see? Like letting
> >> qtests
> >> reference a driver instance by PCI address or something?
> 
> The simplest way around this limitation is to move the -fsdev option
> from the .before_cmd_line of the virtio-9p-*'s nodes to the .before
> function of the test.  You can see an example in qtest/virtio-net-test.c.

Hmm, I keep that in mind. I first try though whether I can make a workaround 
by assigning a custom name to .edge_name (QOSGraphEdgeOptions) for each device 
instance. I have a feeling this might be simpler.

Thanks Paolo!

Best regards,
Christian Schoenebeck



