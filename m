Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1224EC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 08:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D16CC20709
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 08:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrGU9+O+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16CC20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxQqP-00022W-56
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 04:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxQpq-0001cy-O8
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 04:07:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60841
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxQpn-00084W-Rd
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 04:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595232458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=AfaGzlHv6BrX/J/vKrbuz501xkfx6B4n+jA7jPX02jE=;
 b=XrGU9+O+/HsAtTIXh6NyLuSDXLhs//rvq6bTMFxEvp+y0HWUoO58n1d6HWQNWRlf2bxoy5
 0ovW1qhuA0k8P+5uP7RnslP0QLVi3H3x+VdXTCfyrsY/ZJXPRtGNW9Xd+zLANo6Ix8JK9x
 0KnvMtWyPoehJtsD6BhPO0jRWwE9zg0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-yoNJVzDfNiawsoZVHPY-Qw-1; Mon, 20 Jul 2020 04:07:32 -0400
X-MC-Unique: yoNJVzDfNiawsoZVHPY-Qw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCC7510CE785;
 Mon, 20 Jul 2020 08:07:30 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-34.ams2.redhat.com [10.36.112.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CDB9A60E3E;
 Mon, 20 Jul 2020 08:07:21 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] usb/hcd-xhci: Move qemu-xhci device to
 hcd-xhci-pci.c
To: Sai Pavan Boddu <saipava@xilinx.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <1593008176-9629-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1593008176-9629-3-git-send-email-sai.pavan.boddu@xilinx.com>
 <87zh8rzi0e.fsf@dusky.pond.sub.org>
 <d8e247a3-5b50-0889-2522-37f2d486fdf9@redhat.com>
 <BY5PR02MB677295286C4193236973EC0ECA7B0@BY5PR02MB6772.namprd02.prod.outlook.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b3d4924f-5259-3f55-a52c-9693c532d40b@redhat.com>
Date: Mon, 20 Jul 2020 10:07:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BY5PR02MB677295286C4193236973EC0ECA7B0@BY5PR02MB6772.namprd02.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 03:17:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ying Fang <fangying1@huawei.com>,
 =?UTF-8?Q?=27Marc-Andr=c3=a9_Lureau=27?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/07/2020 10.00, Sai Pavan Boddu wrote:
> HI Philippe,
> 
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Sent: Thursday, June 25, 2020 1:48 PM
>> To: Markus Armbruster <armbru@redhat.com>; Sai Pavan Boddu
>> <saipava@xilinx.com>; Thomas Huth <thuth@redhat.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Eduardo Habkost <ehabkost@redhat.com>;
>> qemu-devel@nongnu.org; Alistair Francis <alistair.francis@wdc.com>;
>> 'Marc-André Lureau' <marcandre.lureau@redhat.com>; Ying Fang
>> <fangying1@huawei.com>; Paolo Bonzini <pbonzini@redhat.com>
>> Subject: Re: [PATCH v2 2/3] usb/hcd-xhci: Move qemu-xhci device to hcd-
>> xhci-pci.c
>>
>> On 6/25/20 10:06 AM, Markus Armbruster wrote:
>>> Sai Pavan Boddu <sai.pavan.boddu@xilinx.com> writes:
>>>
>>>> Move pci specific devices to new file. This set the environment to
>>>> move all pci specific hooks in hcd-xhci.c to hcd-xhci-pci.c.
>>>>
>>>> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
>>>> ---
>>>>  hw/usb/hcd-xhci-pci.c | 64
>> +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  hw/usb/hcd-xhci.c     | 32 ++------------------------
>>>>  hw/usb/hcd-xhci.h     |  2 ++
>>>>  3 files changed, 68 insertions(+), 30 deletions(-)  create mode
>>>> 100644 hw/usb/hcd-xhci-pci.c
>>>>
>>>> diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c new file
>>>> mode 100644 index 0000000..26af683
>>>> --- /dev/null
>>>> +++ b/hw/usb/hcd-xhci-pci.c
>>>> @@ -0,0 +1,64 @@
>>>> +/*
>>>> + * USB xHCI controller with PCI system bus emulation
>>>
>>> Scratch "system".
>>>
>>>> + *
>>>> + * Copyright (c) 2011 Securiforest
>>>> + * Date: 2011-05-11 ;  Author: Hector Martin <hector@marcansoft.com>
>>>
>>> Let's use the opportunity to drop the "Date: " part, because we don't
>>> have it anywhere else.
>>
>> Good opportunity to suggest the SPDX tags again :P
>>
>> /*
>>  * SPDX-FileCopyrightText: 2011 Securiforest
>>  * SPDX-FileContributor: Hector Martin <hector@marcansoft.com>
>>  * SPDX-FileCopyrightText: 2020 Xilinx Inc.
>>  * SPDX-FileContributor: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
>>  * SPDX-License-Identifier: GPL-2.0-or-later  */	
> [Sai Pavan Boddu] I would include this in V4, Forgot them in V3.
> 
> Thanks,
> Sai Pavan
>>
>> https://spdx.org/rdf/ontology/spdx-2-0-
>> rc/dataproperties/fileContributor___-1635717172.html
>>
>>>
>>>> + * Based on usb-ohci.c, emulates Renesas NEC USB 3.0
>>>> + * Date: 2020-03-01; Author: Sai Pavan Boddu
>>>> + <sai.pavan.boddu@xilinx.com>
>>>
>>> And no new "Date: " parts, please.
>>>
>>>> + * Moved the pci specific content for hcd-xhci.c to hcd-xhci-pci.c
>>>> + *
>>>> + * This library is free software; you can redistribute it and/or
>>>> + * modify it under the terms of the GNU Lesser General Public
>>>> + * License as published by the Free Software Foundation; either
>>>> + * version 2 of the License, or (at your option) any later version.

And while you're at it: There was never a "version 2" of the Lesser GPL.
In version 2.0, it was still called "Library" GPL. So it is quite likely
that version 2.1 is meant here instead.

 Thomas


