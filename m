Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD46C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B93206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeoqoTOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B93206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kArfJ-00051p-SV
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 05:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kAreg-0004Qj-FQ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:23:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48027
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kAree-0006QB-1G
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598433818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aPM7VHVxD3X25dtKQ5EJl25IdNfsoi8sIhjztJJ4JPo=;
 b=XeoqoTOvQhFT/4pN6MfXn48VyWdQfhxazTMhBWhzzkrinUqoa/+XykW0marnxTQAnNyA4h
 4x7jCjRvDkVMSvjeUMHNO//HVVqU+xzCKZEaIslYdw4iNBdeWk1doHRp/5edr3iFgt78qd
 97mn9nxfpLMqdQZsqgcg0Z7lAUEq/BM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-4YdGkAEgN6Cp_CZSSUhZ2g-1; Wed, 26 Aug 2020 05:23:36 -0400
X-MC-Unique: 4YdGkAEgN6Cp_CZSSUhZ2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7365618B9EB8;
 Wed, 26 Aug 2020 09:23:35 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A8846E70C;
 Wed, 26 Aug 2020 09:23:34 +0000 (UTC)
Date: Wed, 26 Aug 2020 11:23:32 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH v2 6/7] x68: acpi: trigger SMI before sending hotplug
 Notify event to OSPM
Message-ID: <20200826112332.51efd44f@redhat.com>
In-Reply-To: <382e54cc-1ac0-61e5-bf5d-0653480222a0@redhat.com>
References: <20200818122208.1243901-1-imammedo@redhat.com>
 <20200818122208.1243901-7-imammedo@redhat.com>
 <382e54cc-1ac0-61e5-bf5d-0653480222a0@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 01:10:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: boris.ostrovsky@oracle.com,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, aaron.young@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 19:25:48 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On 08/18/20 14:22, Igor Mammedov wrote:
> > In case firmware has negotiated CPU hotplug SMI feature, generate
> > AML to describe SMI IO port region and send SMI to firmware
> > on each CPU hotplug SCI in case new CPUs were hotplugged.
> >
> > Since new CPUs can be hotplugged while CPU_SCAN_METHOD is running
> > we can't send SMI before new CPUs are fetched from QEMU as it
> > could cause sending Notify to a CPU that firmware hasn't seen yet.
> > So fetch new CPUs into local cache first and then send SMI and
> > after that sends Notify events to cached CPUs. This should ensure
> > that Notify is sent only to CPUs which were processed by firmware
> > first.
> > Any CPUs that were hotplugged after caching will be processed
> > by the next CPU_SCAN_METHOD, when pending SCI is handled.
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > v2:
> >  - clear insert event after firmware has returned
> >    control from SMI. (Laszlo Ersek <lersek@redhat.com>)

Laszlo,
Thanks a lot for such detailed review
I'll respin series with your feed back incorporated.

[...]


