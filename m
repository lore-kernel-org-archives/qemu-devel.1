Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A4BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 07:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908BF20768
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 07:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUmfbPOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908BF20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo08w-0001jc-Tg
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 03:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jo08I-00016z-AV
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 03:47:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47654
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jo08G-0003SZ-2A
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 03:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592984862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5bwAvA3Lx7II3hLnDMr27ARHMJ8EVo4UY6pvp+QaTvQ=;
 b=hUmfbPOi65LyoJM1MGpLl/QWIX7sBQesUEnXFeSFY5gD/kNQIPB6RzTf1XMLcitD1nC1uF
 NErX3JxwyZbt/JZz/dE4cW6gU0sSolhK+fWvPG6N8crbv2KkH317BHzQa++4Fum/m5O7lz
 w6pOC/rMqEFk29xOiqjhhgS0DiyRUNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-m-53LQzjO2iGxex9eKsHCw-1; Wed, 24 Jun 2020 03:47:39 -0400
X-MC-Unique: m-53LQzjO2iGxex9eKsHCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DF821940920
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 07:47:38 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-132.ams2.redhat.com [10.36.112.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6882B1C4;
 Wed, 24 Jun 2020 07:47:31 +0000 (UTC)
Subject: Re: [PATCH] libqos: usb-hcd-ehci: use 32-bit write for config register
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200623161852.19477-2-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9d1c30ab-9944-712a-16e7-c2d3240f23e1@redhat.com>
Date: Wed, 24 Jun 2020 09:47:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200623161852.19477-2-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kraxel@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/06/2020 18.18, Paolo Bonzini wrote:
> The memory region ops have min_access_size == 4 so obey it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/qtest/usb-hcd-ehci-test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/usb-hcd-ehci-test.c b/tests/qtest/usb-hcd-ehci-test.c
> index 5251d539e9..c51e8bb223 100644
> --- a/tests/qtest/usb-hcd-ehci-test.c
> +++ b/tests/qtest/usb-hcd-ehci-test.c
> @@ -96,7 +96,7 @@ static void pci_ehci_port_1(void)
>   static void pci_ehci_config(void)
>   {
>       /* hands over all ports from companion uhci to ehci */
> -    qpci_io_writew(ehci1.dev, ehci1.bar, 0x60, 1);
> +    qpci_io_writel(ehci1.dev, ehci1.bar, 0x60, 1);
>   }
>   
>   static void pci_uhci_port_2(void)

Passes "make check-qtest-x86_64" on a s390x host, too:

Tested-by: Thomas Huth <thuth@redhat.com>


