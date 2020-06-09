Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74672C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D94A2078C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcIq8+F6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D94A2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jigEW-0006F9-Gj
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 11:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jigDN-0005Id-Ob
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:31:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54962
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jigDM-0005lZ-4m
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591716659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L2U8tsUo9DvkTz2ikGKY/1dbmv2s5QXPclmsWehfe4A=;
 b=TcIq8+F6C3Mh0EoUPgWSohK5hmhdsOyLGN6Q3SO31JRcSRZTIH55kol5cWwf6PRA9zZV0F
 +Si/BYoDmwPqRXnAolGilkTbLcxbyM7tWAhYRuFUpGxnGQepjy2551Txm2Yk/GDKEcnmuI
 GxfKeiTqALaxPIEUvc/BoxUhNTXx1Ps=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-D3hbLWJCPoazCGrkdRlb2g-1; Tue, 09 Jun 2020 11:30:41 -0400
X-MC-Unique: D3hbLWJCPoazCGrkdRlb2g-1
Received: by mail-wr1-f69.google.com with SMTP id h6so8816314wrx.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 08:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=jO5e0nZm6nM52iur1pkWwX1f/kBxpwzIG+7PFyA3Pew=;
 b=ntzPoVsNQTBGbEuWjHZTcQyBQpJphkeA0EZ6Fk3zy/2l4k53JuQ875xp2eoGcDyDeR
 i/Cx4RK++O8mqCxU8PBYJVIt1YnpHx3F/4Dty+YWFLWNKlSrYPwLz/oU4mNwhjwKSaVg
 rvPQRuTce8F9GAOGxCoIfnVpUg2MJ69Ikz5e5vwiDWP/f+68r2s2W1ll4mRQOlBOJxtU
 De1GVcRJzglhNQ+ATDra5u+LFCTnVgF4NOAX7gbZkFmCFnUifL+6IsQb8/bCsAeLKXQv
 0Zb2ewXXlFDS/X1jm8LwsEiMzPnbqHpLTcDlxk5IdWe3f3CaMi0UW66Km2qSMXzCvHLv
 +t3A==
X-Gm-Message-State: AOAM530LGUuplXYilh3Kii/8skCNAg//hr9b58G5dIB7CWLvjDPL80B1
 7dAV1b8/oBrW3Z0FKpEPJMA8UpvjHIlVMeIewiAgN0lXYy8vYpRlX9p1R7TMALOT9jTiKv99stJ
 w7reNl39AZSWXRzg=
X-Received: by 2002:a5d:4042:: with SMTP id w2mr5326910wrp.423.1591716639732; 
 Tue, 09 Jun 2020 08:30:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoFxaRd1++v9SOzGQHeEC9tGVHUJeFkMy52qWuHNhQLMefp8IzkBIg6qJJG69dtAZxPKrGug==
X-Received: by 2002:a5d:4042:: with SMTP id w2mr5326883wrp.423.1591716639516; 
 Tue, 09 Jun 2020 08:30:39 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id a3sm3623724wrp.91.2020.06.09.08.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 08:30:38 -0700 (PDT)
Date: Tue, 9 Jun 2020 11:30:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] pci: assert configuration access is within bounds
Message-ID: <20200609113019-mutt-send-email-mst@kernel.org>
References: <20200604113525.58898-1-ppandit@redhat.com>
 <20200604163631.GB2890@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200604163631.GB2890@work-vm>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 05:36:31PM +0100, Dr. David Alan Gilbert wrote:
> * P J P (ppandit@redhat.com) wrote:
> > From: Prasad J Pandit <pjp@fedoraproject.org>
> > 
> > While accessing PCI configuration bytes, assert that
> > 'address + len' is within PCI configuration space.
> > 
> > Generally it is within bounds. This is more of a defensive
> > assert, in case a buggy device was to send 'address' which
> > may go out of bounds.
> 
> Can a guest trigger this assert?
> 
> Dave

Shouldn't be able to, no.

> > Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> > ---
> >  hw/pci/pci.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > Update v1: defensive assert as separate patch
> >   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00957.html
> >   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00960.html
> > 
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 70c66965f5..7bf2ae6d92 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -1381,6 +1381,8 @@ uint32_t pci_default_read_config(PCIDevice *d,
> >  {
> >      uint32_t val = 0;
> >  
> > +    assert(address + len <= pci_config_size(d));
> > +
> >      if (pci_is_express_downstream_port(d) &&
> >          ranges_overlap(address, len, d->exp.exp_cap + PCI_EXP_LNKSTA, 2)) {
> >          pcie_sync_bridge_lnk(d);
> > @@ -1394,6 +1396,8 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
> >      int i, was_irq_disabled = pci_irq_disabled(d);
> >      uint32_t val = val_in;
> >  
> > +    assert(addr + l <= pci_config_size(d));
> > +
> >      for (i = 0; i < l; val >>= 8, ++i) {
> >          uint8_t wmask = d->wmask[addr + i];
> >          uint8_t w1cmask = d->w1cmask[addr + i];
> > -- 
> > 2.26.2
> > 
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


