Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5AAC433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C75CE20724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGN5HTcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75CE20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95RB-0003ks-13
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k94uR-0007XY-JU
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 07:08:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49754
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k94uO-000700-FR
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 07:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598008109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4O593/mzvE44sEhoRNNc49tSzHX6pNghZrkdBHLdPQg=;
 b=gGN5HTcqct/BGDxdHzc+EGXmKwbRmakYxuWF8XZYFCJigkA6FMv8oZwP8dvzt+4tyik4Ga
 5MkUvi6YUIAdzxXW8qL+FkzJTJpccI/rKI4B2UTi8CFcX0nxIOaTCckdfuGFQRIktVJd/Q
 Nh5O6mbdNl57Oy1e6P4a/7u9FFpd7zc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-p3LFaeAvO_KibLtYIUHVQA-1; Fri, 21 Aug 2020 07:08:28 -0400
X-MC-Unique: p3LFaeAvO_KibLtYIUHVQA-1
Received: by mail-wm1-f72.google.com with SMTP id p184so823072wmp.7
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 04:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4O593/mzvE44sEhoRNNc49tSzHX6pNghZrkdBHLdPQg=;
 b=BQ1nvNfyAGTrCGHIdQYVeiJzSJgBqSpFT3nb6LFk5hTuPmC7U04nw+7EJnF442hdoJ
 NELsI2oSHoz9VAE6wv2QIUyFQo05NH1oEQpPBtX0phBQ6d/rXt2ie/zAszVZY/gbDlfL
 YWk6Ek2t66blLoFyoPRurjlS67K8Dz5T+NT/TzDtDc61gQjZoZKgHuRdLiaZWfxXjYLo
 dCO1RaqPW1+L5YEN6WmmIfgYm441ymN5ss4FReTICzqUy4C+7H+7CnD8ptsiufIgK5V8
 Za09jrQPr5ACo4pd8SiQSw+Xi1Rsuxi6BC+09jTF7ADI89/+P35YyJglI6/fG7+9OEfG
 QEFw==
X-Gm-Message-State: AOAM533dfxBbMvqMIEL3pMvMAijyTvmMgtkeixwyhUyfgdNJiWmhjYIG
 G7UUYcHpvHs9IalI001ISdtE2V8x998JbESGj7Sr+Uav0BeTlvsA+ucciBXdtdxQfge5wq7csbi
 yht2cKV1grfSAbwc=
X-Received: by 2002:a5d:54c8:: with SMTP id x8mr2181378wrv.405.1598008106644; 
 Fri, 21 Aug 2020 04:08:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf97sw+1DjfsKFMJXPegFmkC2IGOGYoYdJgfEbJLNpQVWtf9T5Io66bqufI0shk8XBYImfuA==
X-Received: by 2002:a5d:54c8:: with SMTP id x8mr2181354wrv.405.1598008106326; 
 Fri, 21 Aug 2020 04:08:26 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id q7sm3511306wra.56.2020.08.21.04.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 04:08:25 -0700 (PDT)
Subject: Re: [PATCH 1/1] spapr_vscsi: do not allow device hotplug
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20200820190635.379657-1-danielhb413@gmail.com>
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
Message-ID: <7f6ab4e6-42b1-3de4-5893-2ef09fc9dd26@redhat.com>
Date: Fri, 21 Aug 2020 13:08:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820190635.379657-1-danielhb413@gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Markus

On 8/20/20 9:06 PM, Daniel Henrique Barboza wrote:
> We do not implement hotplug in the vscsi bus, but we forgot to
> tell qdev about it. The result is that users are able to hotplug
> devices in the vscsi bus, the devices appear in qdev, but they
> aren't usable by the guest OS unless the user reboots it first.
> 
> Setting qbus hotplug_handler to NULL will tell qdev-monitor, via
> qbus_is_hotpluggable(), that we do not support hotplug operations
> in spapr_vscsi.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1862059
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hw/scsi/spapr_vscsi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> index d17dc03c73..57f0a1336f 100644
> --- a/hw/scsi/spapr_vscsi.c
> +++ b/hw/scsi/spapr_vscsi.c
> @@ -1219,6 +1219,9 @@ static void spapr_vscsi_realize(SpaprVioDevice *dev, Error **errp)
>  
>      scsi_bus_new(&s->bus, sizeof(s->bus), DEVICE(dev),
>                   &vscsi_scsi_info, NULL);
> +
> +    /* ibmvscsi SCSI bus does not allow hotplug. */
> +    qbus_set_hotplug_handler(BUS(&s->bus), NULL);

Can't this be a problem later in DeviceClass::unrealize()?

I was expecting something like, overwriting the parent bus type:

-- >8 --
@@ -1271,6 +1271,7 @@ static void spapr_vscsi_class_init(ObjectClass
*klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     SpaprVioDeviceClass *k = VIO_SPAPR_DEVICE_CLASS(klass);

+    k->bus_type = NULL; /* ibmvscsi SCSI bus does not allow hotplug. */
     k->realize = spapr_vscsi_realize;
     k->reset = spapr_vscsi_reset;
     k->devnode = spapr_vscsi_devnode;
---

>  }
>  
>  void spapr_vscsi_create(SpaprVioBus *bus)
> 


