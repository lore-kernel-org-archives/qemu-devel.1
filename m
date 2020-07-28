Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9114C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823442075D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMg8GWvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823442075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0L1h-0002DP-EO
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 04:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0Kyb-0007f7-2H
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:28:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25605
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0KyX-000146-Op
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595924921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gaJr8e9WETC/JPrw5OplSqXZ5AQhNL31V1HMx/YY8CI=;
 b=GMg8GWvUlC7l1StSww77g64FjGRv44p91i+Qn3w6Tf7gncDk8bOj92E2cIO4Ehw1WhqzMn
 boTFJdlMDAcJJ3VtFE+VBF/tmifxqREf/Y59SrUc57NvntpEUaDA0j5yH1I2dmzooOniEM
 jogYHze/939KPVu7/LLQrwSGVuW+n+Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-rwoH1hKvPwuakjR_89KevQ-1; Tue, 28 Jul 2020 04:28:37 -0400
X-MC-Unique: rwoH1hKvPwuakjR_89KevQ-1
Received: by mail-wm1-f72.google.com with SMTP id c124so6933371wme.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 01:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gaJr8e9WETC/JPrw5OplSqXZ5AQhNL31V1HMx/YY8CI=;
 b=f3Y1HAiFig+1M/YUiNU5/AQYZl0dzRKNqtRxM6x7APscLJJLS5BP9fFLi9irTJ294s
 qYPyY0zCHUOMy2Ea1nsjqbM5D6DYzz0dUsUHB63VINp0S/+ClIbgtDdFxvSykVbhmVs1
 Zv+noCVjMnRYKE2+N4fblrIoz3QsiE3iRfwwFOGqM7yz6BUZ9V9mBdMPJZ/Gr9aNeAAu
 0ndCP4CdbgHKeMeRsfaPkJ4csQ3tQxH/mGn9xaD3r1Pqq8jkntL6IHrJUfgMPUG7W0Bp
 fEpxX4Gvs19q4soR+8+Yb4F3VF0tXxvgIcANP8cAKMFfTywJVigyXRVwr65C/9ngDZCh
 h7pw==
X-Gm-Message-State: AOAM532VJXYkXqP3kzppj3jhayYCprTz5MyB4yJ0te9MrkPfT3l938hY
 cmCyV3SC0MB9RNUY/QdB90VejS0/RHaQR+CDJ9DqVyfL/nKOHEWYynOcSF5qiHyLH9mJPikTYTu
 FCJJnhXUYi4pCh18=
X-Received: by 2002:adf:b7cd:: with SMTP id t13mr22997579wre.424.1595924915262; 
 Tue, 28 Jul 2020 01:28:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx25cX3CC6dBRNl5l9cKtVkgY/ACcCqrKZCwOyNPG7DK61L0S8jZgkgwCw37mfU1LCRtfWXEw==
X-Received: by 2002:adf:b7cd:: with SMTP id t13mr22997499wre.424.1595924914023; 
 Tue, 28 Jul 2020 01:28:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4502:3ee3:2bae:c612?
 ([2001:b07:6468:f312:4502:3ee3:2bae:c612])
 by smtp.gmail.com with ESMTPSA id p8sm17364808wrq.9.2020.07.28.01.28.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 01:28:33 -0700 (PDT)
Subject: Re: [RFC PATCH 1/2] hw/riscv: sifive_u: Add file-backed OTP.
 softmmu/vl: add otp-file to boot option
To: Green Wan <green.wan@sifive.com>, Bin Meng <bmeng.cn@gmail.com>
References: <20200724095112.2615-1-green.wan@sifive.com>
 <20200724095112.2615-2-green.wan@sifive.com>
 <CAEUhbmVgqNEe9k9p7Fto08_Rsu0W3d7UfzSK0HcprTk3cSzgaQ@mail.gmail.com>
 <CAJivOr7qLJvryjQXUE7Oro2aSzWv1Sj6AR0gO9TO6+FL9HwkGw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <74c8704f-cda2-ecb7-6cf6-e3ebd7bd9ba3@redhat.com>
Date: Tue, 28 Jul 2020 10:28:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAJivOr7qLJvryjQXUE7Oro2aSzWv1Sj6AR0gO9TO6+FL9HwkGw@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 00:06:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/07/20 04:02, Green Wan wrote:
> Hi Bin,
> 
> Thanks for the reply.
> 
> I think we can add property to sifive_u_otp_properties[] (something like
> below) and remove generic code dependency. What do you think of it?
> 
> @@ -243,6 +245,7 @@ static const MemoryRegionOps sifive_u_otp_ops = {
>  
>  static Property sifive_u_otp_properties[] = {
>      DEFINE_PROP_UINT32("serial", SiFiveUOTPState, serial, 0),
> +    DEFINE_PROP_STRING("otp_file", SiFiveUOTPState, otp_file),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> 
>  typedef struct SiFiveUOTPState {
>      /*< private >*/
>      SysBusDevice parent_obj;
> @@ -77,6 +75,7 @@ typedef struct SiFiveUOTPState {
>      uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];
>      /* config */
>      uint32_t serial;
> +    char *otp_file;
>      uint32_t fuse_wo[SIFIVE_U_OTP_NUM_FUSES];
>  } SiFiveUOTPState;

Yes, I agree.  (Also, dashes are preferred to underscores these days).

You can also add an alias to the machine so that you can access this
with "-machine otp-file=...".

Paolo

> Regards,
> Green
> 
> 
> On Fri, Jul 24, 2020 at 10:20 PM Bin Meng <bmeng.cn@gmail.com
> <mailto:bmeng.cn@gmail.com>> wrote:
> 
>     Hi Green,
> 
>     On Fri, Jul 24, 2020 at 5:51 PM Green Wan <green.wan@sifive.com
>     <mailto:green.wan@sifive.com>> wrote:
>     >
>     > Add a file-backed implementation for OTP of sifive_u machine. Use
>     > '-boot otp-file=xxx' to enable it. Do file open, mmap and close
>     > for every OTP read/write in case keep the update-to-date snapshot
>     > of OTP.
>     >
>     > Signed-off-by: Green Wan <green.wan@sifive.com
>     <mailto:green.wan@sifive.com>>
>     > ---
>     >  hw/riscv/sifive_u_otp.c         | 88
>     ++++++++++++++++++++++++++++++++-
>     >  include/hw/riscv/sifive_u_otp.h |  2 +
>     >  qemu-options.hx                 |  3 +-
>     >  softmmu/vl.c                    |  6 ++-
>     >  4 files changed, 96 insertions(+), 3 deletions(-)
>     >
>     > diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
>     > index f6ecbaa2ca..26e1965821 100644
>     > --- a/hw/riscv/sifive_u_otp.c
>     > +++ b/hw/riscv/sifive_u_otp.c
>     > @@ -24,6 +24,72 @@
>     >  #include "qemu/log.h"
>     >  #include "qemu/module.h"
>     >  #include "hw/riscv/sifive_u_otp.h"
>     > +#include <stdio.h>
>     > +#include <stdlib.h>
>     > +#include <sys/types.h>
>     > +#include <sys/stat.h>
>     > +#include <unistd.h>
>     > +#include <fcntl.h>
>     > +#include <sys/mman.h>
>     > +#include <string.h>
>     > +
>     > +#define TRACE_PREFIX            "FU540_OTP: "
>     > +#define SIFIVE_FU540_OTP_SIZE   (SIFIVE_U_OTP_NUM_FUSES * 4)
>     > +
>     > +static int otp_backed_fd;
>     > +static unsigned int *otp_mmap;
>     > +
>     > +static void sifive_u_otp_backed_load(const char *filename);
>     > +static uint64_t sifive_u_otp_backed_read(uint32_t fuseidx);
>     > +static void sifive_u_otp_backed_write(uint32_t fuseidx,
>     > +                                      uint32_t paio,
>     > +                                      uint32_t pdin);
>     > +static void sifive_u_otp_backed_unload(void);
>     > +
>     > +void sifive_u_otp_backed_load(const char *filename)
>     > +{
>     > +    if (otp_backed_fd < 0) {
>     > +
>     > +        otp_backed_fd = open(filename, O_RDWR);
>     > +
>     > +        if (otp_backed_fd < 0)
>     > +            qemu_log_mask(LOG_TRACE,
>     > +                          TRACE_PREFIX "Warning: can't open otp
>     file\n");
>     > +        else {
>     > +
>     > +            otp_mmap = (unsigned int *)mmap(0,
>     > +                                            SIFIVE_FU540_OTP_SIZE,
>     > +                                            PROT_READ |
>     PROT_WRITE | PROT_EXEC,
>     > +                                            MAP_FILE | MAP_SHARED,
>     > +                                            otp_backed_fd,
>     > +                                            0);
>     > +
>     > +            if (otp_mmap == MAP_FAILED)
>     > +                qemu_log_mask(LOG_TRACE,
>     > +                              TRACE_PREFIX "Warning: can't mmap
>     otp file\n");
>     > +        }
>     > +    }
>     > +
>     > +}
>     > +
>     > +uint64_t sifive_u_otp_backed_read(uint32_t fuseidx)
>     > +{
>     > +    return (uint64_t)(otp_mmap[fuseidx]);
>     > +}
>     > +
>     > +void sifive_u_otp_backed_write(uint32_t fuseidx, uint32_t paio,
>     uint32_t pdin)
>     > +{
>     > +    otp_mmap[fuseidx] &= ~(pdin << paio);
>     > +    otp_mmap[fuseidx] |= (pdin << paio);
>     > +}
>     > +
>     > +
>     > +void sifive_u_otp_backed_unload(void)
>     > +{
>     > +    munmap(otp_mmap, SIFIVE_FU540_OTP_SIZE);
>     > +    close(otp_backed_fd);
>     > +    otp_backed_fd = -1;
>     > +}
>     >
>     >  static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr,
>     unsigned int size)
>     >  {
>     > @@ -46,7 +112,17 @@ static uint64_t sifive_u_otp_read(void
>     *opaque, hwaddr addr, unsigned int size)
>     >          if ((s->pce & SIFIVE_U_OTP_PCE_EN) &&
>     >              (s->pdstb & SIFIVE_U_OTP_PDSTB_EN) &&
>     >              (s->ptrim & SIFIVE_U_OTP_PTRIM_EN)) {
>     > -            return s->fuse[s->pa & SIFIVE_U_OTP_PA_MASK];
>     > +
>     > +            if (otp_file) {
>     > +                uint64_t val;
>     > +
>     > +                sifive_u_otp_backed_load(otp_file);
>     > +                val = sifive_u_otp_backed_read(s->pa);
>     > +                sifive_u_otp_backed_unload();
>     > +
>     > +                return val;
>     > +            } else
>     > +                return s->fuse[s->pa & SIFIVE_U_OTP_PA_MASK];
>     >          } else {
>     >              return 0xff;
>     >          }
>     > @@ -123,6 +199,12 @@ static void sifive_u_otp_write(void *opaque,
>     hwaddr addr,
>     >          s->ptrim = val32;
>     >          break;
>     >      case SIFIVE_U_OTP_PWE:
>     > +        if (otp_file) {
>     > +            sifive_u_otp_backed_load(otp_file);
>     > +            sifive_u_otp_backed_write(s->pa, s->paio, s->pdin);
>     > +            sifive_u_otp_backed_unload();
>     > +        }
>     > +
>     >          s->pwe = val32;
>     >          break;
>     >      default:
>     > @@ -165,6 +247,10 @@ static void sifive_u_otp_reset(DeviceState *dev)
>     >      /* Make a valid content of serial number */
>     >      s->fuse[SIFIVE_U_OTP_SERIAL_ADDR] = s->serial;
>     >      s->fuse[SIFIVE_U_OTP_SERIAL_ADDR + 1] = ~(s->serial);
>     > +
>     > +    /* Initialize file mmap and descriptor. */
>     > +    otp_mmap = NULL;
>     > +    otp_backed_fd = -1;
>     >  }
>     >
>     >  static void sifive_u_otp_class_init(ObjectClass *klass, void *data)
>     > diff --git a/include/hw/riscv/sifive_u_otp.h
>     b/include/hw/riscv/sifive_u_otp.h
>     > index 639297564a..1342bd7342 100644
>     > --- a/include/hw/riscv/sifive_u_otp.h
>     > +++ b/include/hw/riscv/sifive_u_otp.h
>     > @@ -52,6 +52,8 @@
>     >  #define SIFIVE_U_OTP(obj) \
>     >      OBJECT_CHECK(SiFiveUOTPState, (obj), TYPE_SIFIVE_U_OTP)
>     >
>     > +extern const char *otp_file;
>     > +
>     >  typedef struct SiFiveUOTPState {
>     >      /*< private >*/
>     >      SysBusDevice parent_obj;
>     > diff --git a/qemu-options.hx b/qemu-options.hx
>     > index 708583b4ce..eb9a54f4ed 100644
>     > --- a/qemu-options.hx
>     > +++ b/qemu-options.hx
>     > @@ -415,10 +415,11 @@ ERST
>     >
>     >  DEF("boot", HAS_ARG, QEMU_OPTION_boot,
>     >      "-boot [order=drives][,once=drives][,menu=on|off]\n"
>     > -    "     
>     [,splash=sp_name][,splash-time=sp_time][,reboot-timeout=rb_time][,strict=on|off]\n"
>     > +    "     
>     [,splash=sp_name][,splash-time=sp_time][,reboot-timeout=rb_time][,strict=on|off][,otp-file=otp_file]\n"
>     >      "                'drives': floppy (a), hard disk (c), CD-ROM
>     (d), network (n)\n"
>     >      "                'sp_name': the file's name that would be
>     passed to bios as logo picture, if menu=on\n"
>     >      "                'sp_time': the period that splash picture
>     last if menu=on, unit is ms\n"
>     > +    "                'otp_file': the file name backed OTP\n"
>     >      "                'rb_timeout': the timeout before guest
>     reboot when boot failed, unit is ms\n",
> 
>     Instead of touching generic codes, could we add such property at the
>     board level?
> 
>     >      QEMU_ARCH_ALL)
>     >  SRST
> 
>     Regards,
>     Bin
> 


