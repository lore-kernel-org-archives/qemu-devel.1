Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFDEC2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA6520663
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sL1QkVfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA6520663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO7Ih-0006Pj-8R
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 18:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO7HY-0005MV-1t
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO7HX-00045p-33
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:10:20 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO7HW-00045U-TT
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:10:19 -0400
Received: by mail-wm1-x342.google.com with SMTP id y24so11720334wma.4
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 15:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b4HPrLWdYQkSwtpKAYu7RyctuItnpt/9pcQ9NVcYeYs=;
 b=sL1QkVfEo0gyC5s1mufXuuiak4XScCn+N/qxhUdmYaUX/hdEtZqU2HJMuRy8Lf/EpW
 3YUcZ4GqnslwiA/WgG7u6Z6bwAeVonHRO0iwAond1df5seP0Fo8IfUwLitR1MDdtYhY+
 WoxJg4ORJTgW61zFXuvOjmxx29iszzSoY7pZNeNwVle2QaZYE+SbWF3DGPYtBjI5PMBa
 CZ/XeDHMJ8IzsT1nWflxMS0FGP/0chmP/SZ/gk3P4XEqLkyNDDbeERyZeqVG3g4qTmgp
 mVzYY5yYZGprIpURk7cXOxbMelcGV628WuovJHOOgoOIzW+LrfbFtK4ZHO3141Y9VKGS
 k7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=b4HPrLWdYQkSwtpKAYu7RyctuItnpt/9pcQ9NVcYeYs=;
 b=CKRvjBQ/zkZtdSXAg0MamslMamZQgT6+DA2qH3wShJ0+tOsjgVz/nmmEzPycvpf7//
 cBlCnp2OXBbooxmxS0R0YmKM7aCrn8FCsyCgm22igukVjW5y+YbBH8GQCwgUVbZ+6WZl
 rD8gpTJXsnRtAYTxuUq+YQcvlzI/9Y193firCVHbLVtODoolLDVck2rNdu4Oe/OXYOu2
 8pZ38+uPuj9qn1+DVmCphs1w7v3LNENknQKqqasH63hXKTyKQLePHIhuZCTb2eeoKA1m
 4Kp+tco/wxquHgCsssxK5TO/bchf7OG/03yZfr72/gmPZPGGytY2vyHf19lmfhB4Nk6C
 eYPA==
X-Gm-Message-State: AGi0PubZzk37KTxlMu72cvOeiaVXqucLUaKdozGulqCcEotvAk9+R/u8
 ekBY9oVwVNky85b4he4Qr+o=
X-Google-Smtp-Source: APiQypKmsT7o2gyrVIgzKAWYBinXWujmOSiaoqUMwL1l1+322DqLLQu2oGEFo8zHrWFam7RevUMhlA==
X-Received: by 2002:a7b:c104:: with SMTP id w4mr15921958wmi.8.1586815817581;
 Mon, 13 Apr 2020 15:10:17 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id o11sm16119235wme.13.2020.04.13.15.10.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2020 15:10:16 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Add myself as vhost-user-blk maintainer
To: Raphael Norwitz <raphael.norwitz@nutanix.com>, mst@redhat.com,
 qemu-devel@nongnu.org
References: <20200410002800.GA7689@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <74dbcf2f-79d2-ffcd-01eb-6c997bb26c1f@amsat.org>
Date: Tue, 14 Apr 2020 00:10:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200410002800.GA7689@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: raphael.s.norwitz@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/10/20 2:28 AM, Raphael Norwitz wrote:
> Ping

FYI this patch has been recently merged as commit
b372d79b236a4e07eaa3ce65ee0543569b712326.

> 
> On Thu, Mar 26, 2020 at 04:47:35AM -0400, Raphael Norwitz wrote:
>> As suggested by Michael, let's add me as a maintainer of
>> vhost-user-blk and vhost-user-scsi.
>>
>> CC: Michael S. Tsirkin <mst@redhat.com>
>> CC Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
>> ---
>>  MAINTAINERS | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e580276..239ecc1 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1845,6 +1845,18 @@ F: hw/display/virtio-gpu*
>>  F: hw/display/virtio-vga.*
>>  F: include/hw/virtio/virtio-gpu.h
>>  
>> +vhost-user-blk
>> +M: Raphael Norwitz <raphael.norwitz@nutanix.com>
>> +S: Maintained
>> +F: contrib/vhost-user-blk/
>> +F: contrib/vhost-user-scsi/
>> +F: hw/block/vhost-user-blk.c
>> +F: hw/scsi/vhost-user-scsi.c
>> +F: hw/virtio/vhost-user-blk-pci.c
>> +F: hw/virtio/vhost-user-scsi-pci.c
>> +F: include/hw/virtio/vhost-user-blk.h
>> +F: include/hw/virtio/vhost-user-scsi.h
>> +
>>  vhost-user-gpu
>>  M: Marc-André Lureau <marcandre.lureau@redhat.com>
>>  M: Gerd Hoffmann <kraxel@redhat.com>
>> -- 
>> 1.8.3.1
> 

