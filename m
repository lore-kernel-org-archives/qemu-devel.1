Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F15EC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 02:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D910B20672
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 02:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="Veg/AX5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D910B20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXyc2-00069T-3O
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 21:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cminyard@mvista.com>) id 1iXyb4-0005Wd-EN
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 21:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1iXyb2-0002bx-J5
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 21:22:57 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39662)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1iXyb2-0002b0-EF
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 21:22:56 -0500
Received: by mail-ot1-x343.google.com with SMTP id w24so4884872otk.6
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 18:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=WeOskPEDqcAEkd/fWVw8oXCXdb95QAPsUQRpL7qQ6dc=;
 b=Veg/AX5tj9ll0xAQ7GLDHmL3jRlPuGeOSnO1SScZRIR9xHePXU67a1gLTeba8OEr62
 +T/uBIJGdUzV2/EdrLeUvKM+8hKMz27yy2LE7jf4nf+ydz6NC7jqUWm8AZI6fo9eH8nv
 HPETyWmWqJ2eJ+lSNuYIoG/zgtpOy4YNF9HnItG7UJToMtYjBTHX8/HcIOR9+GRUWjXM
 64RxWk8UfclGW1s2JZcSuVp5WIsqO9TfOS9f1IbYQ7ZRYkhAkPaizorELyBK7WAK8Z99
 85liLyEWhNalM1114AwskHXaTctcaxBh2750TMrlzz6rjS6oi84vivh4QSR2j7yRi+F8
 69zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=WeOskPEDqcAEkd/fWVw8oXCXdb95QAPsUQRpL7qQ6dc=;
 b=W+qw3MVR4SproIRg88WA2qq4GBDhLAW8NOw+mRyeir1iMPNnhkCqLxPcsrBzMMO5Xj
 LbLBuk9fMZqlzSDxolZ1YxikkdXpW1HY0mvvWWnlqYuOFsozJ0LOlCuiAW16QKNbtTVy
 xxkfKVW9NKMwqGteBpGrZk1Wl/Z4MNd1u7gOswbx7MSSuIegjl0pU8WlM58tgmP8qAy2
 2+LWfrGO0mSyQsru1uO4+EKF479tsvBu4tjUixEDV68vRCcTJr4woG3/MwdaDzO7RRrG
 IOehttTElKumuNQLA26G+adi2w2PGYyUA2AsQVjWIQZ8Mv0oaX3ht2h4KSiLxX/ARq0L
 DpSw==
X-Gm-Message-State: APjAAAXhcHILUadEI2Pv83NYKvjtEunb6xLFhJBsm1W7IqD9eih72alT
 pC4rPWDAvikENBZyLQbz794JhA==
X-Google-Smtp-Source: APXvYqxrBJkZm9DH8rYMn7hDMJ9jUS1Zh81ZqlOTt9gUOFLLnjHuflhOMz0MxdabScy5BHyBizLBZw==
X-Received: by 2002:a05:6830:1383:: with SMTP id
 d3mr8964630otq.306.1574389373304; 
 Thu, 21 Nov 2019 18:22:53 -0800 (PST)
Received: from minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id l12sm1671522oth.76.2019.11.21.18.22.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Nov 2019 18:22:52 -0800 (PST)
Date: Thu, 21 Nov 2019 20:22:50 -0600
From: Corey Minyard <cminyard@mvista.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 2/5] ipmi: Add support to customize OEM functions
Message-ID: <20191122022250.GP3556@minyard.net>
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
X-Received-From: 2607:f8b0:4864:20::343
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
> 
> Cc: Corey Minyard <cminyard@mvista.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

David,

Sorry, I wasn't thinking on this.  I should have realized what you
wanted.  So, this is:

Acked-by: Corey Minyard <cminyard@mvista.com>

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
> +
>  static const IPMICmdHandler *ipmi_get_handler(IPMIBmcSim *ibs,
>                                                unsigned int netfn,
>                                                unsigned int cmd)
> -- 
> 2.21.0
> 

