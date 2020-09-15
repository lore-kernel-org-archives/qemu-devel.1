Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CF1C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 08:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BFC521974
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 08:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="tXZq/epo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFC521974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI6cP-00062y-5n
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 04:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yulei.sh@bytedance.com>)
 id 1kI49N-0002fm-Na
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 02:09:09 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:42014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yulei.sh@bytedance.com>)
 id 1kI49I-0003GB-8A
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 02:09:06 -0400
Received: by mail-lj1-x242.google.com with SMTP id k25so1699459ljg.9
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 23:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=u1jpagQfpleTGdW5M/dLKxO7y7DXzN6vnrhIe+MPrLs=;
 b=tXZq/epokL5HgFp5JoJN86LVB/6zCZcI2h5u7XSbg8WAz55OrPH+CuR5mky66tx3iC
 6Xc64tvNGWNOXlx6289BPeR1QiUr1Bq25P4dLiN1y3sCYU8U1DhRjLvYa8bAZMieSGTL
 rsBRfTxOKZgI2C0NF7G7e8ezM/ped/H4WWD5QjVHNkJod7Gs9Y9u+4RFlNuMS7xow9Ag
 ABXBtQrr4cJTQ8Xd0cyX4i2H5bbv6v4BfTR5txRyF5wlYzsSW+syGw6uXsgbfa0MEgHk
 XVcK/LlGW0ABk7ZjozcwLPFmMgTOI3Enbpm8dB1mzS+7ylqHRwCBnSA9ZnFtW0MX7jHY
 WD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=u1jpagQfpleTGdW5M/dLKxO7y7DXzN6vnrhIe+MPrLs=;
 b=LUOTQGighkZu4MiweXvRdj1O74Q7UTBky0tP6XV5ITLmbiU5qM1r4FMK3s4XJYikbo
 59ONAT9LUTig4i+YnecatuSqVYSf7HjQd1eNPBtHqEQ1MT/XJgW/LXMo5vnWHw+6jpU7
 592kIuDQyF3FdlslV5vzBYXzQWznjOob0Av29+om/oz6imBtCaQqx77jnxRL+HRWrjWF
 cpvnnvRahUt7NXuVwBBmjJno+0DcifljJPugI+9R/N/gajjEhSEy/Zr3PHzeF5+JaFKi
 fHL3BY7SgL0dijzP03rpXisAppFmyYXxQyo6pdthk54nj38BeCPLihQOWUQyrMcU/W10
 XGWg==
X-Gm-Message-State: AOAM532cem0MYSFxHItAQ41TsP9QBaEzPVYUVx6T6f6PmJuo4hn2ZQ42
 ulnb1PcpJfG+rI4R65bnji9LdyuDfTC8qBwHtZKkgw==
X-Google-Smtp-Source: ABdhPJzG6gOwl6iWsiXqTrE4dFAnAdjwev1Y9RscttYQjWWLmvE+yVzEN2inM0avAr+UqM3pSFeYLqLMhvVE+D0B1Tw=
X-Received: by 2002:a2e:b5d0:: with SMTP id g16mr6014984ljn.402.1600150141149; 
 Mon, 14 Sep 2020 23:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200915054859.2338477-1-clg@kaod.org>
In-Reply-To: <20200915054859.2338477-1-clg@kaod.org>
From: Lei Yu <yulei.sh@bytedance.com>
Date: Tue, 15 Sep 2020 14:08:50 +0800
Message-ID: <CAGm54UGArJ9XQFvc9JXOhP339M58qK37y=nSz-WSFPhamyWfuw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm/aspeed: Add machine properties to define the
 flash models
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=yulei.sh@bytedance.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 15 Sep 2020 04:42:30 -0400
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tested-by: Lei YU <yulei.sh@bytedance.com>

Tested on ast2500-evb with 64MiB flash on fmc and it works as expected.

On Tue, Sep 15, 2020 at 1:49 PM C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Some machines don't have much differences a part from the flash model
> being used. Introduce new machine properties to change them from the
> command line.
>
> For instance, to start the ast2500-evb machine with a different FMC
> chip and a 64M SPI chip, use :
>
>   -M ast2500-evb,fmc-model=3Dmx25l25635e,spi-model=3Dmx66u51235f
>
> Cc: =E9=83=81=E9=9B=B7 <yulei.sh@bytedance.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Message-Id: <20200910200715.1920318-1-clg@kaod.org>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  docs/system/arm/aspeed.rst | 18 +++++++++++++++
>  hw/arm/aspeed.c            | 45 ++++++++++++++++++++++++++++++++++++--
>  2 files changed, 61 insertions(+), 2 deletions(-)
>
> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> index 45f891eb3cad..2d33d023453e 100644
> --- a/docs/system/arm/aspeed.rst
> +++ b/docs/system/arm/aspeed.rst
> @@ -83,3 +83,21 @@ The image should be attached as an MTD drive. Run :
>
>    $ qemu-system-arm -M romulus-bmc -nic user \
>         -drive file=3Dflash-romulus,format=3Draw,if=3Dmtd -nographic
> +
> +Options specific to Aspeed machines are :
> +
> + * ``execute-in-place`` which emulates the boot from the CE0 flash
> +   device by using the FMC controller to load the instructions, and
> +   not simply from RAM. This takes a little longer.
> +
> + * ``fmc-model`` to change the FMC Flash model. FW needs support for
> +   the chip model to boot.
> +
> + * ``spi-model`` to change the SPI Flash model.
> +
> +For instance, to start the ``ast2500-evb`` machine with a different
> +FMC chip and a bigger (64M) SPI chip, use :
> +
> +.. code-block:: bash
> +
> +  -M ast2500-evb,fmc-model=3Dmx25l25635e,spi-model=3Dmx66u51235f
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 8bfb1c79ddc5..bdb981d2f878 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -41,6 +41,8 @@ struct AspeedMachineState {
>      MemoryRegion ram_container;
>      MemoryRegion max_ram;
>      bool mmio_exec;
> +    char *fmc_model;
> +    char *spi_model;
>  };
>
>  /* Palmetto hardware value: 0x120CE416 */
> @@ -332,8 +334,10 @@ static void aspeed_machine_init(MachineState *machin=
e)
>                            "max_ram", max_ram_size  - ram_size);
>      memory_region_add_subregion(&bmc->ram_container, ram_size, &bmc->max=
_ram);
>
> -    aspeed_board_init_flashes(&bmc->soc.fmc, amc->fmc_model);
> -    aspeed_board_init_flashes(&bmc->soc.spi[0], amc->spi_model);
> +    aspeed_board_init_flashes(&bmc->soc.fmc, bmc->fmc_model ?
> +                              bmc->fmc_model : amc->fmc_model);
> +    aspeed_board_init_flashes(&bmc->soc.spi[0], bmc->spi_model ?
> +                              bmc->spi_model : amc->spi_model);
>
>      /* Install first FMC flash content as a boot rom. */
>      if (drive0) {
> @@ -570,6 +574,34 @@ static void aspeed_machine_instance_init(Object *obj=
)
>      ASPEED_MACHINE(obj)->mmio_exec =3D false;
>  }
>
> +static char *aspeed_get_fmc_model(Object *obj, Error **errp)
> +{
> +    AspeedMachineState *bmc =3D ASPEED_MACHINE(obj);
> +    return g_strdup(bmc->fmc_model);
> +}
> +
> +static void aspeed_set_fmc_model(Object *obj, const char *value, Error *=
*errp)
> +{
> +    AspeedMachineState *bmc =3D ASPEED_MACHINE(obj);
> +
> +    g_free(bmc->fmc_model);
> +    bmc->fmc_model =3D g_strdup(value);
> +}
> +
> +static char *aspeed_get_spi_model(Object *obj, Error **errp)
> +{
> +    AspeedMachineState *bmc =3D ASPEED_MACHINE(obj);
> +    return g_strdup(bmc->spi_model);
> +}
> +
> +static void aspeed_set_spi_model(Object *obj, const char *value, Error *=
*errp)
> +{
> +    AspeedMachineState *bmc =3D ASPEED_MACHINE(obj);
> +
> +    g_free(bmc->spi_model);
> +    bmc->spi_model =3D g_strdup(value);
> +}
> +
>  static void aspeed_machine_class_props_init(ObjectClass *oc)
>  {
>      object_class_property_add_bool(oc, "execute-in-place",
> @@ -577,6 +609,15 @@ static void aspeed_machine_class_props_init(ObjectCl=
ass *oc)
>                                     aspeed_set_mmio_exec);
>      object_class_property_set_description(oc, "execute-in-place",
>                             "boot directly from CE0 flash device");
> +
> +    object_class_property_add_str(oc, "fmc-model", aspeed_get_fmc_model,
> +                                   aspeed_set_fmc_model);
> +    object_class_property_set_description(oc, "fmc-model",
> +                                          "Change the FMC Flash model");
> +    object_class_property_add_str(oc, "spi-model", aspeed_get_spi_model,
> +                                   aspeed_set_spi_model);
> +    object_class_property_set_description(oc, "spi-model",
> +                                          "Change the SPI Flash model");
>  }
>
>  static int aspeed_soc_num_cpus(const char *soc_name)
> --
> 2.25.4
>


--=20
BRs,
Lei YU

