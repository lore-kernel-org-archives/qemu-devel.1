Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2F1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 09:48:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494C22073E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 09:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qmf/YFMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494C22073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsNjX-0002Fv-Gt
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 05:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jsNih-0001Sj-9i
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 05:47:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53746
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jsNif-0001HI-Lf
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 05:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594028843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NRcopKkxw2pRY4PStfaXgqsBggB13awGs55XyjAcKAE=;
 b=Qmf/YFMH64ZItNjvSV+KhXF9zwOJLnJVzJ8R/vVST+/EsCek890t+sk9fRGsfuFyvx4V4J
 iJmB+a/SGILyH3la9O8Lm1xDPQgdb1X/dvkeEIk/KZy5USs9l/3uF5oec0xGqbkkejjpSk
 i8vaP5ErLfdzrQJuN5OX/SD8IKxjBBw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-poDNrMZbP92zIt56J54bgg-1; Mon, 06 Jul 2020 05:47:22 -0400
X-MC-Unique: poDNrMZbP92zIt56J54bgg-1
Received: by mail-wm1-f69.google.com with SMTP id o138so44150889wme.4
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 02:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=NRcopKkxw2pRY4PStfaXgqsBggB13awGs55XyjAcKAE=;
 b=JjeuUY2j2wPt81UAlCoIyBAcgf89jchQ7UB+bgZ2Geq2B9ql5dNKsbjzxuhIy2RaaN
 sNF1MfgO+RNQXAOtbcPmdP4M0sp4S6knTXMyncJ6d5AVGY8iCKiX4ykM8oL9dOBommEG
 3n19hqdZ1C7fU4S/ywRiuwGA7nG5o0+DvEvdMw6gwmnsVdbazz7mCRUIyGsuXu3vGplC
 RervZtv+iI2NGDHsIZWlgZGGHK04f3HWULGfw/sZ32a1dw9PC+qd2Ath3ukNl60mstFM
 2wZ4m4QiD4+8kQm9fHFMAFA/mov7A/zV1h6KHwnBs2SfNY81ESjRcOo1MWhE+0tj4SGb
 ZaOQ==
X-Gm-Message-State: AOAM533vzleudesz5hXXTcsI8LCF41AT1OD9xX5EeEmD1V3p/xxKk9xE
 Oi11L0di1gyWJdE8ES/QtIO7irA4s6guYSgXESTYR/pV8EAMrf37KXplQhn/85H7hvyuiNPxcHd
 fUXWEyOk25T75fW8=
X-Received: by 2002:a7b:c218:: with SMTP id x24mr23112612wmi.109.1594028841604; 
 Mon, 06 Jul 2020 02:47:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJGi8s3TRZ5c/p6Qnk5vRDuVLykIP73jvLL2T/BtV0tY0HZ+r2MlNqwfDe3PENImGakqpyDg==
X-Received: by 2002:a7b:c218:: with SMTP id x24mr23112589wmi.109.1594028841389; 
 Mon, 06 Jul 2020 02:47:21 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 5sm2816466wmk.9.2020.07.06.02.47.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 02:47:20 -0700 (PDT)
Subject: Re: [PATCH v3 17/18] hw/block/nvme: provide the mandatory subnqn field
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-18-its@irrelevant.dk>
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
Message-ID: <4649501b-6062-56eb-bace-54e56eb7c386@redhat.com>
Date: Mon, 6 Jul 2020 11:47:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200706061303.246057-18-its@irrelevant.dk>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:52:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/6/20 8:13 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> The SUBNQN field is mandatory in NVM Express 1.3.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 07d58aa945f2..e3984157926b 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -2141,6 +2141,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>  {
>      NvmeIdCtrl *id = &n->id_ctrl;
>      uint8_t *pci_conf = pci_dev->config;
> +    char *subnqn;
>  
>      id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
>      id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
> @@ -2179,6 +2180,10 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>      id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP |
>                             NVME_ONCS_FEATURES);
>  
> +    subnqn = g_strdup_printf("nqn.2019-08.org.qemu:%s", n->params.serial);
> +    strpadcpy((char *)id->subnqn, sizeof(id->subnqn), subnqn, '\0');
> +    g_free(subnqn);
> +
>      id->psd[0].mp = cpu_to_le16(0x9c4);
>      id->psd[0].enlat = cpu_to_le32(0x10);
>      id->psd[0].exlat = cpu_to_le32(0x4);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


