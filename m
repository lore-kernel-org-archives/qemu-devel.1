Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ECFC742A5
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 07:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17682084B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 07:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6xOpnR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17682084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlqLq-0004xH-Uc
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 03:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43336)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hlqLg-0004YM-T7
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 03:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hlqLf-0007Ep-Op
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 03:52:08 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1hlqLf-0007DT-Hm
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 03:52:07 -0400
Received: by mail-wm1-x341.google.com with SMTP id h19so8629096wme.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 00:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=kBPNkVAE+1dn8d38g2pq7SDBCNJopOCbX6igWvvzJ+8=;
 b=I6xOpnR+FDB5c08wqVfY4jHAjW2WX8QyANgq4a1oyDcwVF/NQlJ2EDn7Cv97wyX9Wz
 1hLDZ8svabXvHZDE05PBzyK6BCiMvYnJQ03PWNYJ9npXJdt+K5G5mhkdThb5UE7SZpyH
 HrJUFxbFmovnpqj0gVrJ4BSd37xmO8HNHlLYAM7c7tgJJzODIBhR0y/d1N3J2M1cDxjE
 vqCumIrtXA1dDj4Y47fk+WiJ8mJIJrDqLP/JcMQ44TClmTQGyYGvy3skytba1+yZDBFE
 Dso/ih2KmR2LE6gbkUORlg42xs5z4zzsQ0BprtIPFhSbY5xuh8IdWxTUOb8gWz8bjMJw
 F3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=kBPNkVAE+1dn8d38g2pq7SDBCNJopOCbX6igWvvzJ+8=;
 b=Gbyu0sxj6PwedDvBkp75TPhJkbRJSAOU7b2P2SZq/6+Wu4aEy6yxzgLIgTRug8Rz19
 ThN0BvQzBza1FLz+rJrvOrv4xtPrvgO3/yoGyBx1jM/R4hoVeOL7SWvOkv6jmB/DvmNr
 91jSpZEYBzqtwdvz0UDvoyPPJyawzCrwGOsGFEEFPH5HWeBd+kE1eIHxU7uo/icNpvna
 5pRlRYCsXVVnBsMfbd3LuhT48oGvpN2t9fTxpzalgWSjfufNcLD1Ae5jqg8qyAaiiMT0
 97c4nR8EO6Yj44DW9lXnxKh6CMNunY6WWOg2e0JkjFSV3wYAhPBMp9QbOasFTI1JKo/n
 jwwA==
X-Gm-Message-State: APjAAAXQoRXbBlV8btoS+oXRnwnqQ2DBdDcm54anORIcDl3MUWycnwTd
 7iJ37gOV75o5IDApi18g5LU=
X-Google-Smtp-Source: APXvYqzsgJweM8sCHn5THBtS+k6C0JRZ7eDTsUe/zV4Cxbivy6TCkMHrmB6ALftxqaZ4/M44JjEuJw==
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr8165429wmh.100.1562917925889; 
 Fri, 12 Jul 2019 00:52:05 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id f7sm8234118wrv.38.2019.07.12.00.52.04
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 00:52:05 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20190711202819.3500-1-mst@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <7d68bc97-c5c1-84a0-882e-9059c70df6fe@gmail.com>
Date: Fri, 12 Jul 2019 10:52:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190711202819.3500-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2] pcie: consistent names for function args
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/11/19 11:28 PM, Michael S. Tsirkin wrote:
> The function declarations for pci_cap_slot_get and
> pci_cap_slot_write_config call the argument "slot_ctl", but the function
> definitions and all the call sites drop the 'o' and call it "slt_ctl".
> Let's be consistent.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> Fix pcie_cap_slot_write_config too.
>
>   include/hw/pci/pcie.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index 34f277735c..8cf3361fc4 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -107,9 +107,9 @@ void pcie_cap_lnkctl_reset(PCIDevice *dev);
>   
>   void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot);
>   void pcie_cap_slot_reset(PCIDevice *dev);
> -void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slot_ctl, uint16_t *slt_sta);
> +void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slt_ctl, uint16_t *slt_sta);
>   void pcie_cap_slot_write_config(PCIDevice *dev,
> -                                uint16_t old_slot_ctl, uint16_t old_slt_sta,
> +                                uint16_t old_slt_ctl, uint16_t old_slt_sta,
>                                   uint32_t addr, uint32_t val, int len);
>   int pcie_cap_slot_post_load(void *opaque, int version_id);
>   void pcie_cap_slot_push_attention_button(PCIDevice *dev);

Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks,
Marcel


