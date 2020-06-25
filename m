Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727A0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 08:18:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5AE207FC
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 08:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gctQRN14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5AE207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joN5d-00082D-IA
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 04:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joN4w-0007cc-Pn
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 04:17:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37589
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joN4u-0007CI-3t
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 04:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593073066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/BJpgUR5uOHl6YWW2BIcgerbWzm2SHupWy0xshE4oj4=;
 b=gctQRN14+BIc6djoNT8GWBYv6UeBrLSPMQ81BAsAC6PXNvHGYez+Zjbac4lbtTQ05NdYR0
 jMvOnRDS8HTZCWYdpumTxsCrTA4BIAJD5Mh8RAke3STehW+wcuU+wGLjaY1OQ8uMAyN4No
 UVJ0qfdUxEhGwwsGQzYjX1WB7GgGy8w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-7j8Nmg_7NTK38rW8i9WFrg-1; Thu, 25 Jun 2020 04:17:42 -0400
X-MC-Unique: 7j8Nmg_7NTK38rW8i9WFrg-1
Received: by mail-wm1-f71.google.com with SMTP id g187so6343204wme.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 01:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/BJpgUR5uOHl6YWW2BIcgerbWzm2SHupWy0xshE4oj4=;
 b=qaAnKGrX2CI+cFcsyQ5K/9JD6eGR4jghF0a/f4LCTsmcD04ZlnDt1kRZL9Z1wfiatm
 zlS6ceJO7+v24dcG2wvgvMOkTI27J2wPAONrsl0T7KcO24s4GJMzGMsKUlgUDqLa4KNw
 3M2L8wRgCs0WPC+jET0FhdK4vPfVwtxvVaWZppICCKvHaDJSnhxtawbZmV9XEJPimlj2
 efHb6JVHj3wa+CEaWF2zbNsw9L70AfmP+y3IeLknQ2CraLCpNrFYgAY0AC+MAFjEXN5M
 vWf+j+1XDR/uTr0L5tI8NVsgExbFhIGax/F6DWvNYMg2NSE6PW65yQSa05ulaCnM8cw1
 5Mgg==
X-Gm-Message-State: AOAM533dWNAIH877J35bEZSxkaMUzAqIcJuCJVh2FQajbXEWk5Q+A+C/
 7C8xw5bG5PBA5awjHNTq2dkOTvPoM5VE0q4xZSiK57LN7EgGInFadFaQJjs7dQW80MwJK0QcyJm
 evcEvUpcawgoki/4=
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr2080617wmy.79.1593073060989; 
 Thu, 25 Jun 2020 01:17:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzm34dFlcbPP123zHNp2bNBZjmqm2ptUl9C0QzFOF+J224j944alM0iDLlCBToc4nbd3VumNA==
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr2080585wmy.79.1593073060700; 
 Thu, 25 Jun 2020 01:17:40 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id t188sm11556250wmt.27.2020.06.25.01.17.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 01:17:39 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] usb/hcd-xhci: Move qemu-xhci device to
 hcd-xhci-pci.c
To: Markus Armbruster <armbru@redhat.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Thomas Huth <thuth@redhat.com>
References: <1593008176-9629-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1593008176-9629-3-git-send-email-sai.pavan.boddu@xilinx.com>
 <87zh8rzi0e.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <d8e247a3-5b50-0889-2522-37f2d486fdf9@redhat.com>
Date: Thu, 25 Jun 2020 10:17:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87zh8rzi0e.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 01:47:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ying Fang <fangying1@huawei.com>,
 =?UTF-8?Q?=27Marc-Andr=c3=a9_Lureau=27?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 10:06 AM, Markus Armbruster wrote:
> Sai Pavan Boddu <sai.pavan.boddu@xilinx.com> writes:
> 
>> Move pci specific devices to new file. This set the environment to move all
>> pci specific hooks in hcd-xhci.c to hcd-xhci-pci.c.
>>
>> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
>> ---
>>  hw/usb/hcd-xhci-pci.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  hw/usb/hcd-xhci.c     | 32 ++------------------------
>>  hw/usb/hcd-xhci.h     |  2 ++
>>  3 files changed, 68 insertions(+), 30 deletions(-)
>>  create mode 100644 hw/usb/hcd-xhci-pci.c
>>
>> diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
>> new file mode 100644
>> index 0000000..26af683
>> --- /dev/null
>> +++ b/hw/usb/hcd-xhci-pci.c
>> @@ -0,0 +1,64 @@
>> +/*
>> + * USB xHCI controller with PCI system bus emulation
> 
> Scratch "system".
> 
>> + *
>> + * Copyright (c) 2011 Securiforest
>> + * Date: 2011-05-11 ;  Author: Hector Martin <hector@marcansoft.com>
> 
> Let's use the opportunity to drop the "Date: " part, because we don't
> have it anywhere else.

Good opportunity to suggest the SPDX tags again :P

/*
 * SPDX-FileCopyrightText: 2011 Securiforest
 * SPDX-FileContributor: Hector Martin <hector@marcansoft.com>
 * SPDX-FileCopyrightText: 2020 Xilinx Inc.
 * SPDX-FileContributor: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

https://spdx.org/rdf/ontology/spdx-2-0-rc/dataproperties/fileContributor___-1635717172.html

> 
>> + * Based on usb-ohci.c, emulates Renesas NEC USB 3.0
>> + * Date: 2020-03-01; Author: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> 
> And no new "Date: " parts, please.
> 
>> + * Moved the pci specific content for hcd-xhci.c to hcd-xhci-pci.c
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2 of the License, or (at your option) any later version.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public
>> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>> + */
> [...]
> 


