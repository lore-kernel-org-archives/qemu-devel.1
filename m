Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB700C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 16:31:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5DAD206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 16:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="WR+Z9TqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DAD206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnlpb-0005YD-SW
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 12:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1jnlom-0004n8-Tm
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 12:30:41 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1jnloj-0005qM-I8
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 12:30:40 -0400
Received: by mail-ot1-x343.google.com with SMTP id s13so17232630otd.7
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 09:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=4MdvmBlCOD1q+E+aQO45jyj+IdzVQKgYnKAanEBNUMc=;
 b=WR+Z9TqKD6autEJYzBkeOsxy0p9LoOWALngfxl/pfSeLYX1fz8GfOKcOSOv0MVf0Uy
 o5OCV4h0jwXkev+1CMNeZ5Cv/lq8EgdbDtrJks+0cNNb0SNJfZDc9pxZihTPKgX/RDCW
 DBCNhlzkHlQuF5Z0Oo4vWVwbCbhMlxMDZ1cG92kzRLbPiWMAoZIy0Jl0mOOprd2vL77D
 TT/Aa53vuHeUrVxSEkce4q0FRoYPOo4kdyjMy9t3gGQiOYrRGBrmOmGALePVrLcLfy80
 NBuZFhP+6MGa8hdsoKqmV7qKYTuu8okCLb2ijsfI3mZFKJrQO+gndpRKQ91TpL5SwlnE
 87xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=4MdvmBlCOD1q+E+aQO45jyj+IdzVQKgYnKAanEBNUMc=;
 b=muQWLDjcn911HRcED+oC6WO2ej1y1BPdNDfhl2tZ2gTazW7xecw32e322gFiWA+QhQ
 yJblJHSMl+H07/kQPWmVUw2RxsqNt6eWA8/gfutXyyxokyOFtK+BDOIXAY7jIJuy8FRu
 0shSzncmweqtl1C1cfp3ujoBjNUNaPlhqwVUvGnaajHOQvNQNZ1nf9mHFScYCt9SdTy1
 LTgEdOQD4uQmlDcaGnk3Pn/8+FXKt4qmG3aDN7yEdmM2CnWGlvOFN9/oyKFBcjXkh2Lr
 t7I2kdhhmbFlyqGH2xOfbX6ftlZNupQZvZHtQ7MdH5hogVVdFGFFv05gn1xCgx3GZm32
 xiTA==
X-Gm-Message-State: AOAM533ds20gM9hBGjSxpDHNoWquyPH6i0lBCr5bOhLYA2g46+Oxpin2
 vRHGapowSM6Kb1rH8rvT0/9mdA==
X-Google-Smtp-Source: ABdhPJxfODWpV5sVo0Q6JkgxGUm8FOqMLiMVvSkDDgfYQbB+5ICLSxtrAcSkqNT9tix5kXYbPjQoRA==
X-Received: by 2002:a9d:1b6a:: with SMTP id l97mr17240814otl.325.1592929835108; 
 Tue, 23 Jun 2020 09:30:35 -0700 (PDT)
Received: from minyard.net ([2001:470:b8f6:1b:6d79:306:b4b0:35c1])
 by smtp.gmail.com with ESMTPSA id z7sm4144236oto.2.2020.06.23.09.30.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 23 Jun 2020 09:30:34 -0700 (PDT)
Date: Tue, 23 Jun 2020 11:30:32 -0500
From: Corey Minyard <cminyard@mvista.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v6 7/9] hw/arm/aspeed: Describe each PCA9552 device
Message-ID: <20200623163032.GE3258@minyard.net>
References: <20200623072723.6324-1-f4bug@amsat.org>
 <20200623072723.6324-8-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200623072723.6324-8-f4bug@amsat.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: permerror client-ip=2607:f8b0:4864:20::343;
 envelope-from=cminyard@mvista.com; helo=mail-ot1-x343.google.com
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

On Tue, Jun 23, 2020 at 09:27:21AM +0200, Philippe Mathieu-Daudé wrote:
> We have 2 distinct PCA9552 devices. Set their description
> to distinguish them when looking at the trace events.
> 
> Description name taken from:
> https://github.com/open-power/witherspoon-xml/blob/master/witherspoon.xml

I forgot to respond to this earlier.

Reviewed-by: Corey Minyard <cminyard@mvista.com>

> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Corey Minyard <cminyard@mvista.com>
> ---
>  hw/arm/aspeed.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index ccf127b328..307dba5065 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -508,12 +508,15 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>  {
>      AspeedSoCState *soc = &bmc->soc;
>      uint8_t *eeprom_buf = g_malloc0(8 * 1024);
> +    DeviceState *dev;
>  
>      /* Bus 3: TODO bmp280@77 */
>      /* Bus 3: TODO max31785@52 */
>      /* Bus 3: TODO dps310@76 */
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), TYPE_PCA9552,
> -                     0x60);
> +    dev = i2c_try_create_slave(TYPE_PCA9552, 0x60);
> +    qdev_prop_set_string(dev, "description", "pca1");
> +    i2c_realize_and_unref(dev, aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3),
> +                          &error_fatal);
>  
>      i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "tmp423", 0x4c);
>      i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 5), "tmp423", 0x4c);
> @@ -528,8 +531,10 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>  
>      smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), 0x51,
>                            eeprom_buf);
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), TYPE_PCA9552,
> -                     0x60);
> +    dev = i2c_try_create_slave(TYPE_PCA9552, 0x60);
> +    qdev_prop_set_string(dev, "description", "pca0");
> +    i2c_realize_and_unref(dev, aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11),
> +                          &error_fatal);
>      /* Bus 11: TODO ucd90160@64 */
>  }
>  
> -- 
> 2.21.3
> 

