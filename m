Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1842CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 07:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D70BC20679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 07:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4/2Zq3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70BC20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgNWw-0002vj-3f
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 03:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgNVu-00027l-4Z
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 03:08:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57665
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgNVt-0004ol-AR
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 03:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591168116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wRBYsP3BvVEwOJQPWVUJQn5NSxkf2TVTnRZH9+ZYG4Q=;
 b=J4/2Zq3g0twcANF6aEMrZW68SntfjMUPDzRe9/txw+fnCOd+nbUgow2j+jysKnjswEFaJE
 ViIbcFe10tG9xV7m0vrVlBcqGvNIG8pTvxrI+RW/ymsuSXqOFzfi6OkwRp8aW0bDxhq/Rj
 twNKEKsx18tZQjjMEX6vzQXBn/pqqHo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-s3pvugzDMSm4eOWHBA8WAg-1; Wed, 03 Jun 2020 03:08:27 -0400
X-MC-Unique: s3pvugzDMSm4eOWHBA8WAg-1
Received: by mail-wm1-f71.google.com with SMTP id b63so1586267wme.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 00:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wRBYsP3BvVEwOJQPWVUJQn5NSxkf2TVTnRZH9+ZYG4Q=;
 b=hSyY/mrqq7G7WQA3au0F2zJNoH5WwGjIiu13uhHKwPm7EaG0gL9FA3NYCcdYDJvb44
 27VAzd0K4jOae/OezL9Wv87dmWxeakzyHHVmvfNW1P5Q7ypv/dNcgPkg5eNfUkfBxSaS
 m9lV0UCl/fbl9aHVIjCsa/bNet17yeAN/4ZWJgi5SpFrxY5K6T6H5jE41szRT2+X06LI
 uqFNaj1B5CHTdJe1KboT2wd4yxsBScBP1sKlT65vtS8EnsmWlmxRf21xKMGG8Nx+Wltb
 Q7pkPUkMxK28DtgW6GgyJ2yRcEaeo7ABFepEyrMxgx72fzz0F+SxYDYzlw7gfVHnWDTF
 0neg==
X-Gm-Message-State: AOAM530ATyZSf4caTZ8QVxtSlWRam+q0AlObXmxQxqcQQndFCMyDN7Ng
 2MiDWcmt73Z9t/WCR0CzWY6WiHo/wsvBubWekYwNwKjNvMLOPd6IZ+AmyExWE7baBzCcDafXOvj
 i+Bs4rHJgKMsQCS0=
X-Received: by 2002:adf:91c2:: with SMTP id 60mr31765256wri.41.1591168106164; 
 Wed, 03 Jun 2020 00:08:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyB9/1dUALQivDiIALvGQKmbqAqX4sg4bBwL5x72Vr7vapSSElqhWf9/W7ezanh6hqHQMR2VA==
X-Received: by 2002:adf:91c2:: with SMTP id 60mr31765232wri.41.1591168105924; 
 Wed, 03 Jun 2020 00:08:25 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t8sm1853647wro.56.2020.06.03.00.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 00:08:25 -0700 (PDT)
Subject: Re: [PATCH] ftgmac100: Implement variable descriptor size
To: Erik Smit <erik.lucas.smit@gmail.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <CA+MHfov0TVbwjy8g_cHVa6Y-bMowCbsGLdt8uUhmcns0v_eVLw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <902ebbb5-3e9d-6720-745f-8535a5cd25e8@redhat.com>
Date: Wed, 3 Jun 2020 09:08:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CA+MHfov0TVbwjy8g_cHVa6Y-bMowCbsGLdt8uUhmcns0v_eVLw@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 6:47 PM, Erik Smit wrote:
> The hardware supports variable descriptor sizes, configured with the DBLAC
> register.
> 
> Most drivers use the default 2*8, which is currently hardcoded in qemu, but
> the implementation of the driver in Supermicro BMC SMT_X11_158 uses 4*8.
> 
> --
> The implementation of the driver in Supermicro BMC SMT_X11_158 adds 4 extra
> 4-bytes entries:
> https://github.com/ya-mouse/openwrt-linux-aspeed/blob/master/drivers/net/ftgmac100_26.h#L387-L391
> 
> And sets DBLAC to 0x44f97:
> https://github.com/ya-mouse/openwrt-linux-aspeed/blob/master/drivers/net/ftgmac100_26.c#L449
> 
> There's not a lot of public documentation on this hardware, but the
> current linux driver shows the meaning of these registers:
> 
> https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/faraday/ftgmac100.c#L280-L281
> 
>         iowrite32(FTGMAC100_DBLAC_RXDES_SIZE(2) |   /* 2*8 bytes RX descs */
>                   FTGMAC100_DBLAC_TXDES_SIZE(2) |   /* 2*8 bytes TX descs */
> 
> Without this patch, networking in SMT_X11_158 does not pass data.

Does it really 'pass' *all* the data?

This patch seems incomplete...

IMO you should 1/ declare FTGMAC100Desc as:

typedef struct {
    uint32_t        des0;
    uint32_t        des1;
} FTGMAC100Desc;

2/ Replace the code using static '2' by dynamic use of
FTGMAC100_DBLAC_xXDES_SIZE(dblac):

  static int ftgmac100_read_bd(FTGMAC100Desc **bd, dma_addr_t addr)
  {
      unsigned bd_idx;

      if (dma_memory_read(&address_space_memory, addr, bd, sizeof(*bd))) {
          qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to read descriptor
@ 0x%"
                        HWADDR_PRIx "\n", __func__, addr);
          return -1;
      }
      for (bd_idx = 0; bd_idx< FTGMAC100_DBLAC_RXDES_SIZE(s->dblac);
bd_idx++) {
          bd[bd_idx]->des0 = le32_to_cpu(bd[bd_idx]->des0);
          bd[bd_idx]->des1 = le32_to_cpu(bd[bd_idx]->des1);
      }

      return 0;
  }

Etc...

Maybe worth introduce the bd_to_cpu()/cpu_to_bd() helpers too
(respectively calling le32_to_cpu & cpu_to_le32).

> 
> Signed-off-by: Erik Smit <erik.lucas.smit@gmail.com
> <mailto:erik.lucas.smit@gmail.com>>
> ---
>  hw/net/ftgmac100.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 25ebee7ec2..1640b24b23 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -79,6 +79,19 @@
>  #define FTGMAC100_APTC_TXPOLL_CNT(x)        (((x) >> 8) & 0xf)
>  #define FTGMAC100_APTC_TXPOLL_TIME_SEL      (1 << 12)
> 
> +/*
> + * DMA burst length and arbitration control register
> + */
> +#define FTGMAC100_DBLAC_RXFIFO_LTHR(x)      (((x) >> 0) & 0x7)
> +#define FTGMAC100_DBLAC_RXFIFO_HTHR(x)      (((x) >> 3) & 0x7)
> +#define FTGMAC100_DBLAC_RX_THR_EN           (1 << 6)
> +#define FTGMAC100_DBLAC_RXBURST_SIZE(x)     (((x) >> 8) & 0x3)
> +#define FTGMAC100_DBLAC_TXBURST_SIZE(x)     (((x) >> 10) & 0x3)
> +#define FTGMAC100_DBLAC_RXDES_SIZE(x)       (((x) >> 12) & 0xf)
> +#define FTGMAC100_DBLAC_TXDES_SIZE(x)       (((x) >> 16) & 0xf)
> +#define FTGMAC100_DBLAC_IFG_CNT(x)          (((x) >> 20) & 0x7)
> +#define FTGMAC100_DBLAC_IFG_INC             (1 << 23)
> +
>  /*
>   * PHY control register
>   */
> @@ -553,7 +566,7 @@ static void ftgmac100_do_tx(FTGMAC100State *s,
> uint32_t tx_ring,
>          if (bd.des0 & s->txdes0_edotr) {
>              addr = tx_ring;
>          } else {
> -            addr += sizeof(FTGMAC100Desc);
> +            addr += (FTGMAC100_DBLAC_TXDES_SIZE(s->dblac)) * 8;

Extra parenthesis not needed.

After doing 1/ you can now replace '8' by sizeof(FTGMAC100Desc).

>          }
>      }
> 
> @@ -982,7 +995,7 @@ static ssize_t ftgmac100_receive(NetClientState *nc,
> const uint8_t *buf,
>          if (bd.des0 & s->rxdes0_edorr) {
>              addr = s->rx_ring;
>          } else {
> -            addr += sizeof(FTGMAC100Desc);
> +            addr += (FTGMAC100_DBLAC_RXDES_SIZE(s->dblac)) * 8;
>          }
>      }
>      s->rx_descriptor = addr;
> --
> 2.25.1


