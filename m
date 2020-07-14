Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F95C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:00:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54746221FF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXm2nxMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54746221FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvHk0-0008N0-LS
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 06:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jvHhP-0004al-Vh
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:58:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51892
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jvHhN-0004dT-Pk
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594720685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BUGgsh2sMA3YonFpT6YFljc15nPqhgEoyHPlZ/MQJMQ=;
 b=VXm2nxMkiXazsrbSIlNDCY2F4O/uhauSxegkRC5q3KE1JLB6AGOB0gke4ZmKp6StXhhTu2
 tzrXCta5qxrQVE6o/+18uRo3Di/HSYv6rbIzKhQFipeNhCHpUHmH6qX4KGhaLBWD8xeo5X
 KFXlQkS6VBWkjufCWz2eWbG7iAr8cUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-hgFPLRjuMse7qCiWWW7NoQ-1; Tue, 14 Jul 2020 05:58:03 -0400
X-MC-Unique: hgFPLRjuMse7qCiWWW7NoQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D8EE801E6A;
 Tue, 14 Jul 2020 09:58:02 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-110.ams2.redhat.com
 [10.36.114.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BB8D710AE;
 Tue, 14 Jul 2020 09:58:01 +0000 (UTC)
Subject: Re: [RFC 0/3] x86: fix cpu hotplug with secure boot
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200710161704.309824-1-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <b0a2e023-9669-027e-7234-2e9ca53b8a1f@redhat.com>
Date: Tue, 14 Jul 2020 11:58:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200710161704.309824-1-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: boris.ostrovsky@oracle.com, liran.alon@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/10/20 18:17, Igor Mammedov wrote:
> CPU hotplug with Secure Boot was not really supported and firmware wasn't aware
> of hotplugged CPUs (which might lead to guest crashes). During 4.2 we introduced
> locked SMI handler RAM arrea to make sure that guest OS wasn't able to inject
> its own SMI handler and OVMF added initial CPU hotplug support.
> 
> This series is QEMU part of that support [1] which lets QMVF tell QEMU that
> CPU hotplug with SMI broadcast enabled is supported so that QEMU would be able
> to prevent hotplug in case it's not supported and trigger SMI on hotplug when
> it's necessary. 
> 
> 1) CPU hotplug negotiation part was introduced later so it might not be
> in upstream OVMF yet or I might have missed the patch on edk2-devel
> (Laszlo will point out to it/post formal patch)

I'll post it later, after testing it with this patch series.

Thanks!
Laszlo

> 
> Igor Mammedov (3):
>   x86: lpc9: let firmware negotiate CPU hotplug SMI feature
>   x86: cphp: prevent guest crash on CPU hotplug when broadcast SMI is in
>     use
>   x68: acpi: trigger SMI before scanning for hotplugged CPUs
> 
>  include/hw/acpi/cpu.h  |  1 +
>  include/hw/i386/ich9.h |  1 +
>  hw/acpi/cpu.c          |  6 ++++++
>  hw/acpi/ich9.c         | 12 +++++++++++-
>  hw/i386/acpi-build.c   | 33 ++++++++++++++++++++++++++++++++-
>  hw/i386/pc.c           | 15 ++++++++++++++-
>  hw/isa/lpc_ich9.c      | 10 ++++++++++
>  7 files changed, 75 insertions(+), 3 deletions(-)
> 


