Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E81C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 19:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9322077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 19:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+9gG8WI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9322077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifUTt-0001eG-6v
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 14:50:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifUT3-0001BB-Q1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 14:49:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifUT1-0008T9-CE
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 14:49:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57426
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifUT0-0008QP-Tt
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 14:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576180181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J+igDZpZo3oGb7s51gniocQDN0+eNVW1CTVHPpvjbXc=;
 b=H+9gG8WIuhUfbEmZP6GfogXUJGD9X8snhE+I+vhJbFpnTx3LOeyHRBF+x14+QfmCYFObqs
 vUZyyEMPe1J2ksdaKUf8tODRX3aimZBqfBCYnSrTsETOnq6ijlQI/G5NR+HLOa6wCseprG
 FNPhtzzz7jn2klFcsyGku3tDULIEaT0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-Zrkzy6S1MRqnBmUiCSUphQ-1; Thu, 12 Dec 2019 14:49:39 -0500
Received: by mail-wr1-f71.google.com with SMTP id k18so1433649wrw.9
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 11:49:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=llnroTvFFDmz8+5y4uMgGGIvzVLQ41Ivm9eqif6Dn4M=;
 b=TlyGcH7dD/RLbWjtfwvGWxfQqVyHtRBOqueV7DOTBTj+WUinw6D0SGqC6hm5/aMSMj
 zl552clKb1DvaeiNdqUzNQKJVUx0HfBTMWZlHQFt8tS686KCmkhCAMi23CH1mtCbSy4H
 5YKsgbLdLZVDZt12QwPJpm/As/Ffc7L/wXUarrY5lrDLSE6+pAj9ons4BGp6XJDeH1o1
 GukKqnNVMJd5JISxZk4U6aQo4/BXkSmPDSRw13nQwH6iOTWImugpR6LLEe49lXkJM34v
 Ox26xoriVOCraIBaiORiBJR4WFTux2Kt+UeAuhu2SqsMGCMtWOiIH4f1IAnKP5oIKRcf
 92NQ==
X-Gm-Message-State: APjAAAU9cfWKIx1yqoatZGMmoYHCrNibysAAWD0NQfH35yMt36aBaDoG
 mNLJwDoqO0+KzvF+7yG7aE5M/o5KIT9AlQgpj8anfIocmXT2Ve9jts+f30EwdABUtyzsnfOyFvr
 Ya/ptlnqdxs6zpoE=
X-Received: by 2002:a1c:1941:: with SMTP id 62mr5076575wmz.111.1576180178777; 
 Thu, 12 Dec 2019 11:49:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqzZFm4LvoTWnm8ubXhPO6WF1iWPbXI2w5celQiEED5a30/T1puPzOPAx6ogNzf/xCbzAb4IOA==
X-Received: by 2002:a1c:1941:: with SMTP id 62mr5076559wmz.111.1576180178576; 
 Thu, 12 Dec 2019 11:49:38 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id l15sm6962327wrv.39.2019.12.12.11.49.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2019 11:49:37 -0800 (PST)
Subject: Re: [PATCH v2 4/8] pci-stub: add more MSI functions
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
 <1576171754-45138-5-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <24791146-c86c-ad98-94ba-30bfb6141c74@redhat.com>
Date: Thu, 12 Dec 2019 20:49:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576171754-45138-5-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: Zrkzy6S1MRqnBmUiCSUphQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: slp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 6:29 PM, Paolo Bonzini wrote:
> On x86, KVM needs some function from the PCI subsystem in order to set
> up interrupt routes.  Provide some stubs to support x86 machines that
> lack PCI.
>=20
> Reviewed-by: Sergio Lopez <slp@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   hw/pci/pci-stub.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>=20
> diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
> index c04a5df..cc2a2e1 100644
> --- a/hw/pci/pci-stub.c
> +++ b/hw/pci/pci-stub.c
> @@ -26,6 +26,7 @@
>   #include "qapi/qmp/qerror.h"
>   #include "hw/pci/pci.h"
>   #include "hw/pci/msi.h"
> +#include "hw/pci/msix.h"
>  =20
>   bool msi_nonbroken;
>   bool pci_available;
> @@ -64,3 +65,29 @@ void msi_notify(PCIDevice *dev, unsigned int vector)
>   {
>       g_assert_not_reached();
>   }
> +
> +/* Required by target/i386/kvm.c */
> +bool msi_is_masked(const PCIDevice *dev, unsigned vector)
> +{
> +    g_assert_not_reached();
> +}
> +
> +MSIMessage msi_get_message(PCIDevice *dev, unsigned int vector)
> +{
> +    g_assert_not_reached();
> +}
> +
> +int msix_enabled(PCIDevice *dev)
> +{
> +    return false;
> +}
> +
> +bool msix_is_masked(PCIDevice *dev, unsigned vector)
> +{
> +    g_assert_not_reached();
> +}
> +
> +MSIMessage msix_get_message(PCIDevice *dev, unsigned int vector)
> +{
> +    g_assert_not_reached();
> +}
>=20


