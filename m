Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701E8CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3698B20640
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="ZAfkFZbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3698B20640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMYla-00040e-Qh
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 10:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cminyard@mvista.com>) id 1iMYhg-0001eV-Sw
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1iMYhV-0002HF-Q0
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:30:30 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43783)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1iMYhT-0002GA-NZ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:30:24 -0400
Received: by mail-oi1-x244.google.com with SMTP id t84so11169200oih.10
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 07:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=SXcw5AkU43kxne3gBCzCvfKZzN7bLa4GfXb2Duxs4fQ=;
 b=ZAfkFZbfUEZk4IUhlTOTTCnWce/rwJa+WLaHCfc0JT57O76seOGSH1juz2e1ZKva7N
 XjpREEsS/DJHWOWU11k/hDTLMuScdl9eEPzBcNUSlSC+2J0SDPwLRjcmesf3HQDAnUOV
 m6Yf5tX+YF/AmzBTOIJ8ZTa9xLuTK9XpoTxyAmb78g/Pd6kAZH5xVB5LfHa6lwTazSxj
 1f4f3r9ThMR5qA9HrOZEyTB2NU/pZH/8kHWS3xSG4juleyH6Nl6rNWGIfDnQn7GWEpWR
 B3iJrOHFlXJ3rN5zZv1IiYAWhcbjPFpVgmvM+7vRvlpLgk1kd4ContxFknjPb8RCDlGI
 FL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=SXcw5AkU43kxne3gBCzCvfKZzN7bLa4GfXb2Duxs4fQ=;
 b=DUQbllAQJW/iHDDzDEznbxORUTtCYnj3H4O4L3T421lbna7rtYqBsbIPJvC64ohjae
 4qL4AX3yym3wuNqFxG6d6kG+NuMnz8n1NTG6tOPjw0FfkddizpBnK2FPH3jLoNys0vWw
 WK8nbjHpfZzf44ihj91ZbbvRYUi2C7sm75PrNZXvt2VGVVVcDFV+Lcl+F7h4GkdlmtDm
 5SE/juQlzqh75t8nVbEWuwbXTEIN3tmIrNgFgpwZ2Dv1LX1hk+mfazOfD0D2c4jrd3Qj
 vH9MEPTCjRVJfBNqPm3LdnaGI8aRuD0Yb4GnGlwKSlYNU00gyTVMFeci/Epnlf3K/Kdj
 FXxw==
X-Gm-Message-State: APjAAAVcBrAOPEvJiR9u8rv9y3bzIGw1rCW2mMBTkO1gTN4eb1RK2LCU
 RebqZlAmaUGl1BQsbE+QEG7fDg==
X-Google-Smtp-Source: APXvYqyTWCFXLa7fWlkHv3KT0u3/B/SYtKglJPKqZKCfDSeHU0ffiPXEVoBYCyDCtXCcFfIDNLULFA==
X-Received: by 2002:aca:ea55:: with SMTP id i82mr19956833oih.125.1571668219576; 
 Mon, 21 Oct 2019 07:30:19 -0700 (PDT)
Received: from t560 ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id m14sm4135707otl.26.2019.10.21.07.30.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Oct 2019 07:30:18 -0700 (PDT)
Date: Mon, 21 Oct 2019 09:30:17 -0500
From: Corey Minyard <cminyard@mvista.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 2/5] ipmi: Add support to customize OEM functions
Message-ID: <20191021143017.GH25427@t560>
References: <20191021131215.3693-1-clg@kaod.org>
 <20191021131215.3693-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021131215.3693-3-clg@kaod.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Reply-To: cminyard@mvista.com
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Joel Stanley <joel@jms.id.au>, "Marty E . Plummer" <hanetzer@startmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 21, 2019 at 03:12:12PM +0200, Cédric Le Goater wrote:
> The routine ipmi_register_oem_netfn() lets external modules register
> command handlers for OEM functions. Required for the PowerNV machine.

Comments inline.

> 
> Cc: Corey Minyard <cminyard@mvista.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  include/hw/ipmi/ipmi.h | 36 ++++++++++++++++++++++++++++++++++++
>  hw/ipmi/ipmi_bmc_sim.c | 41 ++++++-----------------------------------
>  2 files changed, 42 insertions(+), 35 deletions(-)
> 
> diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
> index 6f2413b39b4a..cb7203b06767 100644
> --- a/include/hw/ipmi/ipmi.h
> +++ b/include/hw/ipmi/ipmi.h
> @@ -265,4 +265,40 @@ int ipmi_bmc_sdr_find(IPMIBmc *b, uint16_t recid,
>                        const struct ipmi_sdr_compact **sdr, uint16_t *nextrec);
>  void ipmi_bmc_gen_event(IPMIBmc *b, uint8_t *evt, bool log);
>  
> +typedef struct IPMIBmcSim IPMIBmcSim;

This type isn't very useful outside of the simulator, but changes for
that can come as they are needed.  I don't see an easy way to avoid
putting it here.

> +
> +typedef struct RspBuffer {
> +    uint8_t buffer[MAX_IPMI_MSG_SIZE];
> +    unsigned int len;
> +} RspBuffer;
> +
> +static inline void rsp_buffer_set_error(RspBuffer *rsp, uint8_t byte)
> +{
> +    rsp->buffer[2] = byte;
> +}
> +
> +/* Add a byte to the response. */
> +static inline void rsp_buffer_push(RspBuffer *rsp, uint8_t byte)
> +{
> +    if (rsp->len >= sizeof(rsp->buffer)) {
> +        rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_TRUNCATED);
> +        return;
> +    }
> +    rsp->buffer[rsp->len++] = byte;
> +}
> +
> +typedef struct IPMICmdHandler {
> +    void (*cmd_handler)(IPMIBmcSim *s,
> +                        uint8_t *cmd, unsigned int cmd_len,
> +                        RspBuffer *rsp);
> +    unsigned int cmd_len_min;
> +} IPMICmdHandler;
> +
> +typedef struct IPMINetfn {
> +    unsigned int cmd_nums;
> +    const IPMICmdHandler *cmd_handlers;
> +} IPMINetfn;
> +
> +int ipmi_register_oem_netfn(IPMIBmc *b, const IPMINetfn *netfnd);
> +
>  #endif
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index 71e56f3b13d1..770aace55b08 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -98,6 +98,7 @@
>  #define IPMI_CMD_GET_SEL_TIME             0x48
>  #define IPMI_CMD_SET_SEL_TIME             0x49
>  
> +#define IPMI_NETFN_OEM                    0x3a
>  
>  /* Same as a timespec struct. */
>  struct ipmi_time {
> @@ -167,23 +168,8 @@ typedef struct IPMISensor {
>  #define MAX_SENSORS 20
>  #define IPMI_WATCHDOG_SENSOR 0
>  
> -typedef struct IPMIBmcSim IPMIBmcSim;
> -typedef struct RspBuffer RspBuffer;
> -
>  #define MAX_NETFNS 64
>  
> -typedef struct IPMICmdHandler {
> -    void (*cmd_handler)(IPMIBmcSim *s,
> -                        uint8_t *cmd, unsigned int cmd_len,
> -                        RspBuffer *rsp);
> -    unsigned int cmd_len_min;
> -} IPMICmdHandler;
> -
> -typedef struct IPMINetfn {
> -    unsigned int cmd_nums;
> -    const IPMICmdHandler *cmd_handlers;
> -} IPMINetfn;
> -
>  typedef struct IPMIRcvBufEntry {
>      QTAILQ_ENTRY(IPMIRcvBufEntry) entry;
>      uint8_t len;
> @@ -279,28 +265,8 @@ struct IPMIBmcSim {
>  #define IPMI_BMC_WATCHDOG_ACTION_POWER_DOWN      2
>  #define IPMI_BMC_WATCHDOG_ACTION_POWER_CYCLE     3
>  
> -struct RspBuffer {
> -    uint8_t buffer[MAX_IPMI_MSG_SIZE];
> -    unsigned int len;
> -};
> -
>  #define RSP_BUFFER_INITIALIZER { }
>  
> -static inline void rsp_buffer_set_error(RspBuffer *rsp, uint8_t byte)
> -{
> -    rsp->buffer[2] = byte;
> -}
> -
> -/* Add a byte to the response. */
> -static inline void rsp_buffer_push(RspBuffer *rsp, uint8_t byte)
> -{
> -    if (rsp->len >= sizeof(rsp->buffer)) {
> -        rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_TRUNCATED);
> -        return;
> -    }
> -    rsp->buffer[rsp->len++] = byte;
> -}
> -
>  static inline void rsp_buffer_pushmore(RspBuffer *rsp, uint8_t *bytes,
>                                         unsigned int n)
>  {
> @@ -640,6 +606,11 @@ static int ipmi_register_netfn(IPMIBmcSim *s, unsigned int netfn,
>      return 0;
>  }
>  
> +int ipmi_register_oem_netfn(IPMIBmc *b, const IPMINetfn *netfnd)
> +{
> +    return ipmi_register_netfn(IPMI_BMC_SIMULATOR(b), IPMI_NETFN_OEM, netfnd);
> +}

I think I would prefer just exposing ipmi_register_netfn() and maybe
rename it ipmi_sim_register_netfn() or something like that.  There may
be other netfns needed in the future.

But with that change, this looks good to me:

Reviewed-by: Corey Minyard <cminyard@mvista.com>

> +
>  static const IPMICmdHandler *ipmi_get_handler(IPMIBmcSim *ibs,
>                                                unsigned int netfn,
>                                                unsigned int cmd)
> -- 
> 2.21.0
> 

