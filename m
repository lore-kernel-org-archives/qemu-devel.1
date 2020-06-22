Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFDBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 21:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51C420716
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 21:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="q945bKmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51C420716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnU5D-0005z7-QN
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 17:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1jnU3b-0004CF-E0
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 17:32:47 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39640)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1jnU3W-000640-Me
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 17:32:46 -0400
Received: by mail-oi1-x243.google.com with SMTP id d67so16978889oig.6
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 14:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=a1lkXyQ9aSVkgk0mGXS9UNgX64K5VdRMoBWw1iXHdaw=;
 b=q945bKmjtdBzXdK9vxfQYEoBcHZaZHBHuQrhXNMOsd7lZ3WMJSn5KirlPoZMCBdJKP
 Rxrsm0pvZuwPtf+TJ4C94Nd+smFkLhtl+UbrR8d1oZgs9rzqsWmLAPU0nDcNL/xkJ4TI
 +LdU2Xi5yZ17BcheEdgAa/stkH/DsDb59R7ZqZudL+hEC9jCD/cShlyWQFqYTptGMQZ4
 Rzd8ZzOGBGl20RwrV0N5itGtU9pwIxfyiUC12goYo0u6D4ncas+sH8NtN04DFL899NtK
 3PRzEZfzoWMpPdXyFSRVbY6z8nqUGhVS6bKvtjSxsdq30mPL++Th4co/tkZpzLj1xwe+
 s1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=a1lkXyQ9aSVkgk0mGXS9UNgX64K5VdRMoBWw1iXHdaw=;
 b=oQocCez5MpOwPpoyBqlygc1A6mXGTnz9917Gbyog4+ldhAKJmrTyBltFr3N/5/deXV
 gXS7oxKaCEN9JTTjoS4F+9DVDBnO9WVXiP2rI+BnHJ/kcZUm2d+tPZZF+RYHh20A1acD
 npE2BPcauQnCDMSqfFCHSkcyDVAGjQF6/KH+hwgYe53ZoP7Jj+47zGVrdAz5/Y/QZuvW
 DB51fHgvE6PR/rD9Uv6shWKloNxuSQ1awX+QOWHBmgBoD3m1Mr8Mlsyc384C0Wo/oNuG
 YOF42AmjK7IMdflTMxpnNYkLvJBTEkwNQrwBL8Q6svopP+dB3pviGy/JKVXProtjE01Z
 wixg==
X-Gm-Message-State: AOAM531Q7O2vvO1uKyXm0joh/wpTP0PnYiZrmmbyYGkmUOIMUrVWszsx
 TQQN9ORBre3wG/1hDtkb0e3kaA==
X-Google-Smtp-Source: ABdhPJyZGqPr6GJa21asZITlwkTlYoMY9xfBPvqK/QY86/A9rFYDCPFGmXurjL7CwSIJhOTZ9KOg5A==
X-Received: by 2002:aca:554c:: with SMTP id j73mr14628599oib.172.1592861560253; 
 Mon, 22 Jun 2020 14:32:40 -0700 (PDT)
Received: from minyard.net ([2001:470:b8f6:1b:acca:171:3424:849f])
 by smtp.gmail.com with ESMTPSA id z5sm3568876otp.28.2020.06.22.14.32.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 22 Jun 2020 14:32:39 -0700 (PDT)
Date: Mon, 22 Jun 2020 16:32:37 -0500
From: Corey Minyard <cminyard@mvista.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH] i2c: Match parameters of i2c_start_transfer and
 i2c_send_recv
Message-ID: <20200622213237.GB3258@minyard.net>
References: <20200621145235.9E241745712@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621145235.9E241745712@zero.eik.bme.hu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: permerror client-ip=2607:f8b0:4864:20::243;
 envelope-from=cminyard@mvista.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Reply-To: cminyard@mvista.com
Cc: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jun 21, 2020 at 04:43:38PM +0200, BALATON Zoltan wrote:
> These functions have a parameter that decides the direction of
> transfer but totally confusingly they don't match but inverted sense.
> To avoid frequent mistakes when using these functions change
> i2c_send_recv to match i2c_start_transfer. Also use bool in
> i2c_start_transfer instead of int to match i2c_send_recv.

Hmm, I have to admit that this is a little better.  Indeed the
hw/misc/auxbus.c looks suspicious.  I can't imagine that code has ever
been tested.

I don't know the policy on changing an API like this with silent
semantic changes.  You've gotten all the internal ones; I'm wondering if
we worry about silently breaking out of tree things.

I'll pull this into my tree, but hopefully others will comment on this.

-corey

> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> Looks like hw/misc/auxbus.c already got this wrong and calls both
> i2c_start_transfer and i2c_send_recv with same is_write parameter.
> Although the name of the is_write variable suggest this may need to be
> inverted I'm not sure what that value actially means and which usage
> was correct so I did not touch it. Someone knowing this device might
> want to review and fix it.
> 
>  hw/display/sm501.c   |  2 +-
>  hw/i2c/core.c        | 34 +++++++++++++++++-----------------
>  hw/i2c/ppc4xx_i2c.c  |  2 +-
>  include/hw/i2c/i2c.h |  4 ++--
>  4 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 2db347dcbc..ccd0a6e376 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -1034,7 +1034,7 @@ static void sm501_i2c_write(void *opaque, hwaddr addr, uint64_t value,
>                      int i;
>                      for (i = 0; i <= s->i2c_byte_count; i++) {
>                          res = i2c_send_recv(s->i2c_bus, &s->i2c_data[i],
> -                                            !(s->i2c_addr & 1));
> +                                            s->i2c_addr & 1);
>                          if (res) {
>                              s->i2c_status |= SM501_I2C_STATUS_ERROR;
>                              return;
> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> index 1aac457a2a..c9d01df427 100644
> --- a/hw/i2c/core.c
> +++ b/hw/i2c/core.c
> @@ -91,7 +91,7 @@ int i2c_bus_busy(I2CBus *bus)
>   * without releasing the bus.  If that fails, the bus is still
>   * in a transaction.
>   */
> -int i2c_start_transfer(I2CBus *bus, uint8_t address, int recv)
> +int i2c_start_transfer(I2CBus *bus, uint8_t address, bool recv)
>  {
>      BusChild *kid;
>      I2CSlaveClass *sc;
> @@ -175,26 +175,14 @@ void i2c_end_transfer(I2CBus *bus)
>      bus->broadcast = false;
>  }
>  
> -int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send)
> +int i2c_send_recv(I2CBus *bus, uint8_t *data, bool recv)
>  {
>      I2CSlaveClass *sc;
>      I2CSlave *s;
>      I2CNode *node;
>      int ret = 0;
>  
> -    if (send) {
> -        QLIST_FOREACH(node, &bus->current_devs, next) {
> -            s = node->elt;
> -            sc = I2C_SLAVE_GET_CLASS(s);
> -            if (sc->send) {
> -                trace_i2c_send(s->address, *data);
> -                ret = ret || sc->send(s, *data);
> -            } else {
> -                ret = -1;
> -            }
> -        }
> -        return ret ? -1 : 0;
> -    } else {
> +    if (recv) {
>          ret = 0xff;
>          if (!QLIST_EMPTY(&bus->current_devs) && !bus->broadcast) {
>              sc = I2C_SLAVE_GET_CLASS(QLIST_FIRST(&bus->current_devs)->elt);
> @@ -206,19 +194,31 @@ int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send)
>          }
>          *data = ret;
>          return 0;
> +    } else {
> +        QLIST_FOREACH(node, &bus->current_devs, next) {
> +            s = node->elt;
> +            sc = I2C_SLAVE_GET_CLASS(s);
> +            if (sc->send) {
> +                trace_i2c_send(s->address, *data);
> +                ret = ret || sc->send(s, *data);
> +            } else {
> +                ret = -1;
> +            }
> +        }
> +        return ret ? -1 : 0;
>      }
>  }
>  
>  int i2c_send(I2CBus *bus, uint8_t data)
>  {
> -    return i2c_send_recv(bus, &data, true);
> +    return i2c_send_recv(bus, &data, false);
>  }
>  
>  uint8_t i2c_recv(I2CBus *bus)
>  {
>      uint8_t data = 0xff;
>  
> -    i2c_send_recv(bus, &data, false);
> +    i2c_send_recv(bus, &data, true);
>      return data;
>  }
>  
> diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
> index c0a8e04567..d3899203a4 100644
> --- a/hw/i2c/ppc4xx_i2c.c
> +++ b/hw/i2c/ppc4xx_i2c.c
> @@ -239,7 +239,7 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
>                      }
>                  }
>                  if (!(i2c->sts & IIC_STS_ERR) &&
> -                    i2c_send_recv(i2c->bus, &i2c->mdata[i], !recv)) {
> +                    i2c_send_recv(i2c->bus, &i2c->mdata[i], recv)) {
>                      i2c->sts |= IIC_STS_ERR;
>                      i2c->extsts |= IIC_EXTSTS_XFRA;
>                      break;
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index 4117211565..a09ab9230b 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -72,10 +72,10 @@ struct I2CBus {
>  I2CBus *i2c_init_bus(DeviceState *parent, const char *name);
>  void i2c_set_slave_address(I2CSlave *dev, uint8_t address);
>  int i2c_bus_busy(I2CBus *bus);
> -int i2c_start_transfer(I2CBus *bus, uint8_t address, int recv);
> +int i2c_start_transfer(I2CBus *bus, uint8_t address, bool recv);
>  void i2c_end_transfer(I2CBus *bus);
>  void i2c_nack(I2CBus *bus);
> -int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send);
> +int i2c_send_recv(I2CBus *bus, uint8_t *data, bool recv);
>  int i2c_send(I2CBus *bus, uint8_t data);
>  uint8_t i2c_recv(I2CBus *bus);
>  
> -- 
> 2.21.3
> 

