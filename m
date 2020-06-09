Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD8CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 843CA20734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Adu3+VH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843CA20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jifK5-0006cR-Nt
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 10:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jifFu-00015S-TZ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 10:29:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20629
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jifFu-0002FL-10
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 10:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591712972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uVeprVEMa7K6trnr6W3yRjhjoGokXnTT0tdSCYklKz4=;
 b=Adu3+VH7FcZR7KWCRO2BUrEgtM5cGcp75aiTsGkjDHCAb1RmtU95sfuEhg38ejoH78UzRQ
 h2SUCGXPxC42Rg2p1oKgqKoLYDftY8mpE5C5EDTtGCva74K4aR8oaAiYVZsn+8tD0GHlh1
 13z7Qy2OV/G0AHClbZx+pKtiZLamDgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-0_tqHkheMZKd4ycDeKfQbQ-1; Tue, 09 Jun 2020 10:29:28 -0400
X-MC-Unique: 0_tqHkheMZKd4ycDeKfQbQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BC808014D9;
 Tue,  9 Jun 2020 14:29:26 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08CF65D9E5;
 Tue,  9 Jun 2020 14:29:24 +0000 (UTC)
Subject: Re: [RFC PATCH 2/5] hw/misc/led: Add LED_STATUS_CHANGED QAPI event
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200609123425.6921-1-f4bug@amsat.org>
 <20200609123425.6921-3-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8e5154ba-0d80-d6f3-0da0-c20072173d9a@redhat.com>
Date: Tue, 9 Jun 2020 09:29:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609123425.6921-3-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/9/20 7:34 AM, Philippe Mathieu-Daudé wrote:
> Allow LED devices to emit STATUS_CHANGED events on a QMP chardev.
> 
> QMP event examples:
> 
> {
>      "timestamp": {
>          "seconds": 1591704274,
>          "microseconds": 520850
>      },
>      "event": "LED_STATUS_CHANGED",
>      "data": {
>          "name": "Green LED #0",
>          "status": "on"
>      }
> }
> {
>      "timestamp": {
>          "seconds": 1591704275,
>          "microseconds": 530912
>      },
>      "event": "LED_STATUS_CHANGED",
>      "data": {
>          "name": "Green LED #0",
>          "status": "off"
>      }
> }
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---

The QAPI addition looks reasonable, however,

> +++ b/hw/misc/led.c
> @@ -7,6 +7,7 @@
>    */
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> +#include "qapi/qapi-events-led.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/misc/led.h"
>   #include "hw/irq.h"
> @@ -19,6 +20,9 @@ static void led_set(void *opaque, int line, int new_state)
>   
>       trace_led_set(s->name, s->current_state, new_state);
>   
> +    /* FIXME QMP rate limite? */

s/limite/limit/

Yes, this is under guest control, so you MUST rate limit to avoid the 
guest being able to DoS qemu by changing the LED so frequently as to 
overwhelm the QMP connection with events.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


