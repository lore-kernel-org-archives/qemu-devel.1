Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61002C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 20:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2827B2075A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 20:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="mgxZYelu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2827B2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnTLp-0006zC-Ey
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 16:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1jnTKT-00061S-Cz
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 16:46:09 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1jnTKP-00010O-Vc
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 16:46:09 -0400
Received: by mail-ot1-x344.google.com with SMTP id 72so777318otc.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 13:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=xjlab+khnqG5kK8RlhsVJgH9kcSuAhCvWwUM+tLTgQA=;
 b=mgxZYelu1CM6JChzpoe7gj3jAgIyMnYiXq/LdxlUWT4uq0ZhopIF4Uuw+YmWlr6VS6
 UG68DD0ZR8RL0IQRRM0SJmWZuv22q8IjNWIv7bH9WGOSsHykHJbSRRtNXIYH/15VrbtA
 Uqcf6cfPm89etwlDb6ivUVthWKw5mgM63kcuMUq0fBupEtGZBclHhaDsgIDH4Dw1BOw4
 WP4+glG7+1Cg8WEuYRQcQSVAAygiunNOedsIzc4Q3xXoISc01z4ko5PWt8d5VRrysfqn
 4gUBr//1S1hFxPEg6qFXQeKgfNVcJlP9+vQ7kTwnVJIwTqQmCHKter7KGIGBJ2JF6iyq
 lo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=xjlab+khnqG5kK8RlhsVJgH9kcSuAhCvWwUM+tLTgQA=;
 b=LmvtcvwbbodP58AVa5QndYiB8OeRgJatwUk32fwC9xE9EHqHD3f2RxiT2o2a3eYTFW
 cT8XeNDgQQpEeElpn+e4EOwv70VylgF4R597Y2Sy7m8EGGpxo6QPl5HZW5sK9z3bYGEd
 I4qrRwIrT53wQnuY6amBGi+NDFLIQyGY0/PkzeD22yzb50/sOo+vTSBoVTkpJgfL/0FZ
 QZt1ZVUxU4pllVowV4zKu4547lG2ibSaJC95ZRqilbu6E8DENPKYM2WsdAKLsCkb0cbd
 lXL2tzvSXSNn1qiMqph5maKJtykx6uJxrG2xSFT/W6y2QDyxtdU5bwRCWXKpOOpxXfmL
 exsA==
X-Gm-Message-State: AOAM532y1hxl9XlUXknHhoT9QLfxylfUD6Imj52jXCuQCB+0BH3j98wx
 8krHJ9ZQaRIIusUEs4E8PaD/Ug==
X-Google-Smtp-Source: ABdhPJz5NOal0lbk46pFTaTK5I2m/aSlOg48gsuhMZm7v3Kj2IhSeHaj67+Gvms5Gb4e+0EW39Fleg==
X-Received: by 2002:a4a:3744:: with SMTP id r65mr3228265oor.82.1592858762985; 
 Mon, 22 Jun 2020 13:46:02 -0700 (PDT)
Received: from minyard.net ([2001:470:b8f6:1b:acca:171:3424:849f])
 by smtp.gmail.com with ESMTPSA id w10sm3677221oon.40.2020.06.22.13.46.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 22 Jun 2020 13:46:02 -0700 (PDT)
Date: Mon, 22 Jun 2020 15:46:01 -0500
From: Corey Minyard <cminyard@mvista.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v5 1/9] hw/i2c/core: Add i2c_try_create_slave() and
 i2c_realize_and_unref()
Message-ID: <20200622204601.GA3258@minyard.net>
References: <20200622183428.12255-1-f4bug@amsat.org>
 <20200622183428.12255-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200622183428.12255-2-f4bug@amsat.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: permerror client-ip=2607:f8b0:4864:20::344;
 envelope-from=cminyard@mvista.com; helo=mail-ot1-x344.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 08:34:20PM +0200, Philippe Mathieu-Daudé wrote:
> Extract i2c_try_create_slave() and i2c_realize_and_unref()
> from i2c_create_slave().
> We can now set properties on a I2CSlave before it is realized.
> 
> This is in line with the recent qdev/QOM changes merged
> in commit 6675a653d2e.

This seems consistent with outher things and looks proper.

Reviewed-by: Corey Minyard <cminyard@mvista.com>

> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Cc: Markus Armbruster <armbru@redhat.com>
> ---
>  include/hw/i2c/i2c.h |  2 ++
>  hw/i2c/core.c        | 18 ++++++++++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index 4117211565..d6e3d85faf 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -80,6 +80,8 @@ int i2c_send(I2CBus *bus, uint8_t data);
>  uint8_t i2c_recv(I2CBus *bus);
>  
>  DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr);
> +DeviceState *i2c_try_create_slave(const char *name, uint8_t addr);
> +bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp);
>  
>  /* lm832x.c */
>  void lm832x_key_event(DeviceState *dev, int key, int state);
> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> index 1aac457a2a..acf34a12d6 100644
> --- a/hw/i2c/core.c
> +++ b/hw/i2c/core.c
> @@ -267,13 +267,27 @@ const VMStateDescription vmstate_i2c_slave = {
>      }
>  };
>  
> -DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
> +DeviceState *i2c_try_create_slave(const char *name, uint8_t addr)
>  {
>      DeviceState *dev;
>  
>      dev = qdev_new(name);
>      qdev_prop_set_uint8(dev, "address", addr);
> -    qdev_realize_and_unref(dev, &bus->qbus, &error_fatal);
> +    return dev;
> +}
> +
> +bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp)
> +{
> +    return qdev_realize_and_unref(dev, &bus->qbus, errp);
> +}
> +
> +DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
> +{
> +    DeviceState *dev;
> +
> +    dev = i2c_try_create_slave(name, addr);
> +    i2c_realize_and_unref(dev, bus, &error_fatal);
> +
>      return dev;
>  }
>  
> -- 
> 2.21.3
> 

