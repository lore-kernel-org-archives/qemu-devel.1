Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D592C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 16:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2881F2072E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 16:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESnq7K1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2881F2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgsrt-00020i-9u
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 12:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jgsrJ-0001a1-Te
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 12:36:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54870
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jgsrJ-0001Do-1U
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 12:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591288607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9727UxvqVmZxBE8Lz+WCTTNUT+mtnHrjU8BZCFTt+0o=;
 b=ESnq7K1dl6xiRqMAa+sW98OXhGNZHhdD3bDrQW5CaNMlcTg0SIVVJyUnszjysQow6QBLpX
 N4E900H+s0s22RH7tDC+hbVZy7Z0yjgdwNZl5llC6u4Q9Nu3fgDPjqJQTxsYoDnpwNZLfE
 SraboJvRdcNmAg82N4AkWnqQrcqho6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-18x4LPqpNeWbL6L-SGagpQ-1; Thu, 04 Jun 2020 12:36:43 -0400
X-MC-Unique: 18x4LPqpNeWbL6L-SGagpQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53D8D1005510;
 Thu,  4 Jun 2020 16:36:42 +0000 (UTC)
Received: from work-vm (ovpn-114-247.ams2.redhat.com [10.36.114.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D1902DE70;
 Thu,  4 Jun 2020 16:36:33 +0000 (UTC)
Date: Thu, 4 Jun 2020 17:36:31 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH] pci: assert configuration access is within bounds
Message-ID: <20200604163631.GB2890@work-vm>
References: <20200604113525.58898-1-ppandit@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200604113525.58898-1-ppandit@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 12:22:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* P J P (ppandit@redhat.com) wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While accessing PCI configuration bytes, assert that
> 'address + len' is within PCI configuration space.
> 
> Generally it is within bounds. This is more of a defensive
> assert, in case a buggy device was to send 'address' which
> may go out of bounds.

Can a guest trigger this assert?

Dave

> Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/pci/pci.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> Update v1: defensive assert as separate patch
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00957.html
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00960.html
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 70c66965f5..7bf2ae6d92 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1381,6 +1381,8 @@ uint32_t pci_default_read_config(PCIDevice *d,
>  {
>      uint32_t val = 0;
>  
> +    assert(address + len <= pci_config_size(d));
> +
>      if (pci_is_express_downstream_port(d) &&
>          ranges_overlap(address, len, d->exp.exp_cap + PCI_EXP_LNKSTA, 2)) {
>          pcie_sync_bridge_lnk(d);
> @@ -1394,6 +1396,8 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
>      int i, was_irq_disabled = pci_irq_disabled(d);
>      uint32_t val = val_in;
>  
> +    assert(addr + l <= pci_config_size(d));
> +
>      for (i = 0; i < l; val >>= 8, ++i) {
>          uint8_t wmask = d->wmask[addr + i];
>          uint8_t w1cmask = d->w1cmask[addr + i];
> -- 
> 2.26.2
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


