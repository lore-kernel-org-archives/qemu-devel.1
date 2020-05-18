Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ABAC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34B9207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLuRPyQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34B9207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaihV-0006F2-0s
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jaigk-00059Y-6g
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:32:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27430
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jaigi-0003Bu-Km
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589819543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=TKigu/n/XX8dGKp6U47xnSwPqbvbxEbAxUwQshK34q4=;
 b=iLuRPyQRvbivO7uAsP1DewvE6V3dmNSDlx2Zylu+ZKSu9BDIy1iBcvjhsr/4bBGmcLbeYu
 XyI41J4LvkHNH0dteixXMXA97eXo6446h9h/7H9AwPxJxPwW/YI4SJ6lGDKJwan8SXFE2z
 IpKnRsel/HCL40G4kt66UwHueY8V3eQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-8rVh-c9JNm6sEQvfPtQsSw-1; Mon, 18 May 2020 12:32:21 -0400
X-MC-Unique: 8rVh-c9JNm6sEQvfPtQsSw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A44F80058A;
 Mon, 18 May 2020 16:32:20 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-242.ams2.redhat.com [10.36.112.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E7CAE19634;
 Mon, 18 May 2020 16:32:18 +0000 (UTC)
Subject: Re: [PATCH] hw/m68k/mcf52xx: Replace hw_error() by qemu_log_mask()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200518094904.24226-1-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6a1d8e73-9417-2e52-a2a9-e5d1c00a0a2a@redhat.com>
Date: Mon, 18 May 2020 18:32:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200518094904.24226-1-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <huth@tuxfamily.org>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/05/2020 11.49, Philippe Mathieu-Daudé wrote:
> hw_error() calls exit(). This a bit overkill when we can log
> the accesses as unimplemented or guest error.

Good idea. hw_error() is also mainly for CPU errors, it really should
not be used for non-CPU devices.

> When fuzzing the devices, we don't want the whole process to
> exit. Replace some hw_error() calls by qemu_log_mask().
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/m68k/mcf5206.c  |  7 +++++--
>  hw/m68k/mcf5208.c  | 14 +++++++++-----
>  hw/m68k/mcf_intc.c |  4 +++-
>  hw/net/mcf_fec.c   |  8 +++++---
>  4 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
> index b155dd8170..34a863a588 100644
> --- a/hw/m68k/mcf5206.c
> +++ b/hw/m68k/mcf5206.c
> @@ -8,6 +8,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "qemu/log.h"
>  #include "cpu.h"
>  #include "hw/hw.h"
>  #include "hw/irq.h"
> @@ -306,7 +307,8 @@ static uint64_t m5206_mbar_read(m5206_mbar_state *s,
>      case 0x170: return s->uivr[0];
>      case 0x1b0: return s->uivr[1];
>      }
> -    hw_error("Bad MBAR read offset 0x%x", (int)offset);
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad MBAR offset 0x%" HWADDR_PRIX "\n",

offset seems to be uint64_t in this function, so I think this should
rather use PRIx64 instead of HWADDR_PRIX ? Or maybe check whether we can
change the offset to uint32_t ?

> +                  __func__, offset);
>      return 0;
>  }
>  
> @@ -360,7 +362,8 @@ static void m5206_mbar_write(m5206_mbar_state *s, uint32_t offset,
>          s->uivr[1] = value;
>          break;
>      default:
> -        hw_error("Bad MBAR write offset 0x%x", (int)offset);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad MBAR offset 0x%x\n",
> +                      __func__, offset);

Here offset seems to be uint32_t ... so I guess it should be fine for
the _read function, too.

>          break;
>      }
>  }
> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
> index b84c152ce3..cd8a32e0c6 100644
> --- a/hw/m68k/mcf5208.c
> +++ b/hw/m68k/mcf5208.c
> @@ -9,10 +9,10 @@
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
>  #include "qemu/error-report.h"
> +#include "qemu/log.h"
>  #include "qapi/error.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
> -#include "hw/hw.h"
>  #include "hw/irq.h"
>  #include "hw/m68k/mcf.h"
>  #include "hw/m68k/mcf_fec.h"
> @@ -111,7 +111,8 @@ static void m5208_timer_write(void *opaque, hwaddr offset,
>      case 4:
>          break;
>      default:
> -        hw_error("m5208_timer_write: Bad offset 0x%x\n", (int)offset);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
> +                      __func__, offset);
>          break;

Should the "break" be replaced by a "return" now?

>      }
>      m5208_timer_update(s);
> @@ -136,7 +137,8 @@ static uint64_t m5208_timer_read(void *opaque, hwaddr addr,
>      case 4:
>          return ptimer_get_count(s->timer);
>      default:
> -        hw_error("m5208_timer_read: Bad offset 0x%x\n", (int)addr);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
> +                      __func__, addr);
>          return 0;
>      }
>  }
> @@ -164,7 +166,8 @@ static uint64_t m5208_sys_read(void *opaque, hwaddr addr,
>          return 0;
>  
>      default:
> -        hw_error("m5208_sys_read: Bad offset 0x%x\n", (int)addr);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
> +                      __func__, addr);
>          return 0;
>      }
>  }
> @@ -172,7 +175,8 @@ static uint64_t m5208_sys_read(void *opaque, hwaddr addr,
>  static void m5208_sys_write(void *opaque, hwaddr addr,
>                              uint64_t value, unsigned size)
>  {
> -    hw_error("m5208_sys_write: Bad offset 0x%x\n", (int)addr);
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
> +                  __func__, addr);
>  }
>  
>  static const MemoryRegionOps m5208_sys_ops = {
> diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
> index d9e03a06ab..7dddf17d33 100644
> --- a/hw/m68k/mcf_intc.c
> +++ b/hw/m68k/mcf_intc.c
> @@ -8,6 +8,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/module.h"
> +#include "qemu/log.h"
>  #include "cpu.h"
>  #include "hw/hw.h"
>  #include "hw/irq.h"
> @@ -127,7 +128,8 @@ static void mcf_intc_write(void *opaque, hwaddr addr,
>          }
>          break;
>      default:
> -        hw_error("mcf_intc_write: Bad write offset %d\n", offset);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%02x\n",
> +                      __func__, offset);
>          break;

"return" instead of "break" ?

>      }
>      mcf_intc_update(s);
> diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
> index 9327ac8a30..b3a92c0114 100644
> --- a/hw/net/mcf_fec.c
> +++ b/hw/net/mcf_fec.c
> @@ -7,7 +7,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "hw/hw.h"
> +#include "qemu/log.h"
>  #include "hw/irq.h"
>  #include "net/net.h"
>  #include "qemu/module.h"
> @@ -392,7 +392,8 @@ static uint64_t mcf_fec_read(void *opaque, hwaddr addr,
>      case 0x188: return s->emrbr;
>      case 0x200 ... 0x2e0: return s->mib[(addr & 0x1ff) / 4];
>      default:
> -        hw_error("mcf_fec_read: Bad address 0x%x\n", (int)addr);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address 0x%" HWADDR_PRIX "\n",
> +                      __func__, addr);
>          return 0;
>      }
>  }
> @@ -492,7 +493,8 @@ static void mcf_fec_write(void *opaque, hwaddr addr,
>          s->mib[(addr & 0x1ff) / 4] = value;
>          break;
>      default:
> -        hw_error("mcf_fec_write Bad address 0x%x\n", (int)addr);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address 0x%" HWADDR_PRIX "\n",
> +                      __func__, addr);

return here?

>      }
>      mcf_fec_update(s);
>  }
> 

 Thomas


