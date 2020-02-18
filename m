Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028A4C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33EB20801
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRN6TDhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33EB20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46Yu-0004Z6-W8
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:21:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laine@redhat.com>) id 1j46Vn-0008EJ-6X
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:18:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laine@redhat.com>) id 1j46Vl-0001f6-Ay
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:18:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52613
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laine@redhat.com>) id 1j46Vl-0001eq-5n
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:18:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582046296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vS6zX6QFeRHDf7QnUFmjJuu9E4n8ub1q4lR53KXcYp0=;
 b=DRN6TDhSokMWiGvsWLGD2e/O4SWG64Yob++vhArdAIUHMw9zZOh6z6tG6vwmRqbeYIKqq8
 zNV4PECr2+7OOIhy8LBmztS2uW3FP5+TbCzzcnvB2vh8xX8ZiOmMtncgyBKui+lpDMcGOV
 y4EjXTl7AvUOzT5gHkTQJJmAlpHxJhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-etrVfPSQNy2JsFoSbAoJqw-1; Tue, 18 Feb 2020 12:18:14 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF83E800D48
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 17:18:13 +0000 (UTC)
Received: from [10.10.125.146] (ovpn-125-146.rdu2.redhat.com [10.10.125.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A564590F71;
 Tue, 18 Feb 2020 17:18:04 +0000 (UTC)
Subject: Re: [PATCH] pcie_root_port: Add disable_hotplug option
To: qemu-devel@nongnu.org
References: <20200218161717.386723-1-jusual@redhat.com>
From: Laine Stump <laine@redhat.com>
Message-ID: <d872dcc7-9275-1354-ce6a-7dd52ac33929@redhat.com>
Date: Tue, 18 Feb 2020 12:18:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218161717.386723-1-jusual@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: etrVfPSQNy2JsFoSbAoJqw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Julia Suvorova <jusual@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/18/20 11:17 AM, Julia Suvorova wrote:
> Make hot-plug/hot-unplug on PCIe Root Ports optional to allow libvirt
> to manage it and restrict unplug for the entire machine. This is going
> to prevent user-initiated unplug in guests (Windows mostly).
> Usage:
>      -device pcie-root-port,disable-hotplug=true,...

Double negatives (e.g. "disable-hotplug=false") tend to confuse simple 
minds like mine. Would it be any more difficult to make the name of the 
option positive instead (e.g. "enable-hotplug") with the default set to 
"true"?


