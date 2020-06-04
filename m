Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C298FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9217F206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3W6BktZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9217F206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgmLf-0001Wy-Rf
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgmKw-0000fo-Qo
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:38:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24133
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgmKv-0003eJ-Vf
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591263537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xvucdxr05dHRAw2Flk7rqxCAREkZPDYMgibW94nP7O4=;
 b=P3W6BktZF3j+PTWBycbPxpb5XJntmT4g99CE1BwwNEuTr9i2mL2RBTVUaOippyBz1IoMIT
 ZMX1S49DEjqp8kFy1ZN670WHVrzirp2Vz9ynukQrLgxniCajY60AbYm/fUveIA2RImcSAm
 p+hiNmh2CIA3OsbfjftREr5OdQV3oYw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-6CP6fZw6Nx61mBp5DNw8HA-1; Thu, 04 Jun 2020 05:38:54 -0400
X-MC-Unique: 6CP6fZw6Nx61mBp5DNw8HA-1
Received: by mail-wr1-f69.google.com with SMTP id l18so2208309wrm.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 02:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Q/tLaN15jyencNrAgAGEtAQPnV79J4tJ/bWSuCF9u28=;
 b=BK6K2Eve+367Zx8MvtntpCxCqA2UwYRH60jX+gHW/oqACqrrI0sa9H/1vyUOip0GFo
 Pv3JeVAATu88wcTq3X1uwcZxc2ZDMYwI8JtgqS9GpcGHLnRYMgp64ILt7BI6FoAGoxwE
 mkW1rdx8fjWN10qsd12NxS9qszr/N5kXrOjs3jwnxTBWGDxEIP4ZXVDb/8n9ACrP12u7
 YHFk8ROFNwsGhmoQhbGdL5nLRMluFHpqrp3uvBfPaZorY5n4KOnXUTnuVzQNoZoFNX27
 2CYQNyik0iWT1ys29Jz/9/h3lt7JLJlzd7AWDyhKXR23JpT7lVDMYm4mJidbbzhpAGE2
 Vssg==
X-Gm-Message-State: AOAM532eQGWaS94f8p0YDcFe5cV2lSaJvlwDz50bFnvm9Lt7BAiPmQAq
 ykCZjy0Jm2sgqJaqSn3Giq26fiprPXP+JssoxSzwvmCFSLevn+hvpyfphzI1X+B2+/yQbCPg1Fi
 DBu/rXWTFAF3fmxk=
X-Received: by 2002:a5d:630f:: with SMTP id i15mr3467219wru.309.1591263532835; 
 Thu, 04 Jun 2020 02:38:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1C0aISBp7IdQ3gi8KjC3QbkYp121ZkwAb83VzFrqcj5KkBAcEVF9XtwMBybHzKGX4bVNVWw==
X-Received: by 2002:a5d:630f:: with SMTP id i15mr3467205wru.309.1591263532618; 
 Thu, 04 Jun 2020 02:38:52 -0700 (PDT)
Received: from redhat.com ([2a00:a040:185:f65:9a3b:8fff:fed3:ad8d])
 by smtp.gmail.com with ESMTPSA id o15sm7439062wrv.48.2020.06.04.02.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 02:38:52 -0700 (PDT)
Date: Thu, 4 Jun 2020 05:38:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH v2 2/2] pci: ensure configuration access is within bounds
Message-ID: <20200604053733-mutt-send-email-mst@kernel.org>
References: <20200603202251.1199170-1-ppandit@redhat.com>
 <20200603202251.1199170-3-ppandit@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200603202251.1199170-3-ppandit@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:14:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Ren Ding <rding@gatech.edu>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 01:52:51AM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While reading PCI configuration bytes, a guest may send an
> address towards the end of the configuration space. It may lead
> to an OOB access issue. Assert that 'address + len' is within
> PCI configuration space.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

My understanding is that this can't really happen normally,
this is more an assert in case some pci host devices are buggy,
as is the case of alt-vga.
Right?
Pls clarify commit log so it's obvious this is defence in depth.

> ---
>  hw/pci/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> Update v2: assert PCI configuration access is within bounds
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00711.html
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 70c66965f5..173bec4fd5 100644
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
> -- 
> 2.26.2


