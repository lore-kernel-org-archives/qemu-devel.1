Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A96C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7EC20787
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/x2dBhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7EC20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyAHi-0003Ay-5N
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 04:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jyAGi-0002Ke-8L
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:38:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58728
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jyAGg-0008Tw-Ek
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595407105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=zyk3qVGuJF4/jlswLWqY/l1Ic/WEDf28dfZwwjmMJcc=;
 b=K/x2dBhD9QEh5/Dc0E+mI8GybQqe1oN69UKo85PJGDGOSkk4LIb/X8fUtVyP9pllIxknnw
 qtw08NW8xmRMAcQBz76va4f2K01mdG3kAezq1uVEnhQdQ1WGPJZjYHvDxdkQKtRNJE33AP
 BjEMmTZuQEnvvRi5xLqx27hgPQRWqR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-jHR5rMIyMOG4RJCinBPSjA-1; Wed, 22 Jul 2020 04:38:21 -0400
X-MC-Unique: jHR5rMIyMOG4RJCinBPSjA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8A2A57;
 Wed, 22 Jul 2020 08:38:19 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-92.ams2.redhat.com [10.36.112.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BDB727854B;
 Wed, 22 Jul 2020 08:38:11 +0000 (UTC)
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
 <b3d4924f-5259-3f55-a52c-9693c532d40b@redhat.com>
 <BY5PR02MB6772EAC0125218AD9E09FC97CA790@BY5PR02MB6772.namprd02.prod.outlook.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <391efac2-8600-3011-6aba-d29f44b57174@redhat.com>
Date: Wed, 22 Jul 2020 10:38:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BY5PR02MB6772EAC0125218AD9E09FC97CA790@BY5PR02MB6772.namprd02.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 00:40:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

 Hi,

On 22/07/2020 09.49, Sai Pavan Boddu wrote:
[...]
>>>>>> + * This library is free software; you can redistribute it and/or
>>>>>> + * modify it under the terms of the GNU Lesser General Public
>>>>>> + * License as published by the Free Software Foundation; either
>>>>>> + * version 2 of the License, or (at your option) any later version.
>>
>> And while you're at it: There was never a "version 2" of the Lesser GPL.
>> In version 2.0, it was still called "Library" GPL. So it is quite likely that version
>> 2.1 is meant here instead.
> [Sai Pavan Boddu] I have less knowledge here. But indeed I don’t find LGPL 2.0 https://www.gnu.org/licenses/licenses.html#LicenseURLs

You can find version 2.0 here, for example:

 https://www.gnu.org/licenses/old-licenses/old-licenses.html#LGPL

... but as I said, v2.0 is called "Library" GPL instead of "Lesser" GPL.

> BTW, I still see our repository use combination of GPL and LGPL. Is there any general rule to follow at high level.

As long as the license is a standard license that is compatible with the
GPLv2 or any later version, you should be fine. See the LICENSE file in
the top directory of the sources for details.

As a general rule, I'd say either use "GPLv2 or later" (see the file
COPYING in the main directory) or "LGPLv2.1 or later" (see COPYING.LIB
in the main directory) for new code, unless you contribute to the tcg/
folder where MIT or BSD is preferred instead.

 Thomas


