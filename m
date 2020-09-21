Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE97C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D8E21D95
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FF8Y2wCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D8E21D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKMp5-00027U-7Y
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 10:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKMlQ-0007SJ-Gf
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:25:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31832
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKMlO-00038k-2T
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600698352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Q6aphZaY8bqX3O+QnV6q6VztqoEHQ3d6OEsoIMu97Mo=;
 b=FF8Y2wCHta+fiWje+tloXn0ZDDV5G3MbxHFKBvwB0+D8hecMr7D6Aw4QPFE2dsq71a9Xph
 TsFF9AdOcIPUaZcpOguZgkqop6ltHDd8I4Ny2Y7sxej/LTw93h3qkj5BIu4HHzoIe+s/4R
 LY/YFGSwOklobLxFK/Sz7WcRVvLnbgs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-V7WI-DonM_iXKgOFY8eHDg-1; Mon, 21 Sep 2020 10:25:50 -0400
X-MC-Unique: V7WI-DonM_iXKgOFY8eHDg-1
Received: by mail-wr1-f70.google.com with SMTP id y3so5929862wrl.21
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 07:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Q6aphZaY8bqX3O+QnV6q6VztqoEHQ3d6OEsoIMu97Mo=;
 b=dVwpqofwYB+0UaSZnfET4eh/XmExgVL2phy+Oe63OSDZXXTObNhlCcyLjxhjT5DgOS
 LIAedlDDrqcD1roFTONwfkFnY8nhDNR3gEuMH8tzbNtdOtbKL7R1ykd+9++gfNzwVXbo
 ULRjPzrajI+UAFNl9UxsPmx/fLOpStBByS1bDB4BoXW5Y31GbAy7ioXezDUS059ouTxj
 flhoPdmUCHNUC9+sOCY4CYs0fZaRLQrR9xew4CCQvkop6V0J/tkgrxMUrGGNuf/VNgfo
 f1mnkM19wdAKra6AObwtFfirkPra5vQber/TInK/+jF/Or55qDZBUrgQJWwbSEZL6/j/
 c5dA==
X-Gm-Message-State: AOAM533j46yUQ789fmnev3c3ooHxPoiwxBH5dFL9ICEJMw0sF1ky8UuH
 vliZ+89bg5VZXt7tOTzigp+vi0K2scZh+iNmQnZRem1kZU1Hy0yd4+F5N+P8WUMC2HdfCA22x2Y
 zfMwwaX1GtC9+p9o=
X-Received: by 2002:a1c:1b86:: with SMTP id b128mr130797wmb.5.1600698349839;
 Mon, 21 Sep 2020 07:25:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhprubOQqdG233yjSHtW2AI4m4J/P8LghFmtlbzgngtZhKhAMB2UVgBDo3QTWevvgWt7GkqQ==
X-Received: by 2002:a1c:1b86:: with SMTP id b128mr130769wmb.5.1600698349601;
 Mon, 21 Sep 2020 07:25:49 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id r15sm20156125wmn.24.2020.09.21.07.25.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2020 07:25:49 -0700 (PDT)
Subject: Re: [PATCH 2/2] libvhost-user: return on error in vu_log_queue_fill()
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200921113420.154378-1-stefanha@redhat.com>
 <20200921113420.154378-3-stefanha@redhat.com>
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
Message-ID: <920c5d11-78bb-86d3-d22d-d233784962c5@redhat.com>
Date: Mon, 21 Sep 2020 16:25:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921113420.154378-3-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 03:43:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/20 1:34 PM, Stefan Hajnoczi wrote:
> vu_panic() is not guaranteed to exit the program. Return early when
> errors are encountered.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index 27626e629a..1fc2cb12ce 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -2722,6 +2722,7 @@ vu_log_queue_fill(VuDev *dev, VuVirtq *vq,
>      if (desc[i].flags & VRING_DESC_F_INDIRECT) {
>          if (desc[i].len % sizeof(struct vring_desc)) {
>              vu_panic(dev, "Invalid size for indirect buffer table");
> +            return;
>          }
>  
>          /* loop over the indirect descriptor table */
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


