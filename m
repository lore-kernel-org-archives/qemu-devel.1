Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E32C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5112074B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LeG4R8WG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5112074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgmOU-0005Wd-75
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgmNY-0004Ma-3m
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:41:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55546
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgmNX-0004A7-5h
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591263698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SCcypcdayu8y6GiUQu9Q88hnNXz4gimlizJGccwFwfw=;
 b=LeG4R8WGSRdNoaca/umsjE5zDezj89oV0qKH+ap7P1Bt5M2ydVPyFI0ZhiVkoe6f3vhCsB
 DYgLL1lO60TDOZMUN/YnChlE3t8uYhXpm6WLVfyP4cRz62VNgug0fzDLumZvc5pqZSry0L
 I4+VUJ8BbPaC9UyPrvNaSd9rlNgHFWY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-wAW__3F5N7mkhumJSgbwDQ-1; Thu, 04 Jun 2020 05:41:36 -0400
X-MC-Unique: wAW__3F5N7mkhumJSgbwDQ-1
Received: by mail-wr1-f70.google.com with SMTP id d6so2194689wrn.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 02:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=0F5j6BISG6PHcUYdrwdpr4kljGYW9B+88jhvH9HPjNo=;
 b=V1vUxlOeV0v7xmRF5tGvPGElNBkfgLJIbRV9V+xifKvVC3gCJC9+4gpIYC8aYcEEG9
 oYP+tcYkx3K/CzE770W3K/z+tQYIIT+d168T0Fzl9vHmMloIAHaOWhS1K0ItwS3iZSM4
 aexPlnTHZ9RqCTGkyEV6LHmcmSTd/9IrPQPWgXEGFzRHQj/uN4C8wmOXhc/tSl9uH+0G
 +mkgE7vmrV1WA+HoEWYHAMGC91q1jUR5WnHVZn9f8fcHETzrxE541247Ney73IAQqOGs
 rRGiin9iegZk97VSf9zqCpQHqv001kc56xqfJOSa0pIKYnsoljMcigTUpXHWdVbgUCrt
 nZyw==
X-Gm-Message-State: AOAM533By44yFyPjLLm/CtLWNApJ0ruRAfeggGZBtLdOxe06UEbvYFtL
 wqK+X0MtR8gFjizgh+qz66ybctOUZIUKdJ0FgcSBsqgqtjgphlqvUzfG6mVX2wxhr9NbCm+6rqK
 R7WKOUmZiRB5C2mQ=
X-Received: by 2002:adf:f5d0:: with SMTP id k16mr3782745wrp.288.1591263695776; 
 Thu, 04 Jun 2020 02:41:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz56ie6srJqVF5j27azlPqt911x5PpsMr1K0nxV/jqHNxS+MkYOHHZ/RjUAnYBgXzL9wl53oQ==
X-Received: by 2002:adf:f5d0:: with SMTP id k16mr3782724wrp.288.1591263695520; 
 Thu, 04 Jun 2020 02:41:35 -0700 (PDT)
Received: from redhat.com ([2a00:a040:185:f65:9a3b:8fff:fed3:ad8d])
 by smtp.gmail.com with ESMTPSA id b8sm6956824wrm.35.2020.06.04.02.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 02:41:34 -0700 (PDT)
Date: Thu, 4 Jun 2020 05:41:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 2/2] pci: ensure configuration access is within bounds
Message-ID: <20200604054043-mutt-send-email-mst@kernel.org>
References: <20200603202251.1199170-1-ppandit@redhat.com>
 <20200603202251.1199170-3-ppandit@redhat.com>
 <alpine.BSF.2.22.395.2006040006520.56892@zero.eik.bme.hu>
 <e1ccdf71-5069-fa95-3c90-de4f875b2706@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e1ccdf71-5069-fa95-3c90-de4f875b2706@redhat.com>
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
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ren Ding <rding@gatech.edu>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 08:07:52AM +0200, Philippe Mathieu-Daudé wrote:
> On 6/4/20 12:13 AM, BALATON Zoltan wrote:
> > On Thu, 4 Jun 2020, P J P wrote:
> >> From: Prasad J Pandit <pjp@fedoraproject.org>
> >>
> >> While reading PCI configuration bytes, a guest may send an
> >> address towards the end of the configuration space. It may lead
> >> to an OOB access issue. Assert that 'address + len' is within
> >> PCI configuration space.
> >>
> >> Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> >> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> >> ---
> >> hw/pci/pci.c | 2 ++
> >> 1 file changed, 2 insertions(+)
> >>
> >> Update v2: assert PCI configuration access is within bounds
> >>  -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00711.html
> >>
> >> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >> index 70c66965f5..173bec4fd5 100644
> >> --- a/hw/pci/pci.c
> >> +++ b/hw/pci/pci.c
> >> @@ -1381,6 +1381,8 @@ uint32_t pci_default_read_config(PCIDevice *d,
> >> {
> >>     uint32_t val = 0;
> >>
> >> +    assert(address + len <= pci_config_size(d));
> > 
> > Does this allow guest now to crash QEMU? I think it was suggested that
> > assert should only be used for cases that can only arise from a
> > programming error and not from values set by the guest. If this is
> > considered to be an error now to call this function with wrong
> > parameters did you check other callers? I've found a few such as:
> > 
> > hw/scsi/esp-pci.c
> > hw/watchdog/wdt_i6300esb.c
> > hw/ide/cmd646.c
> > hw/vfio/pci.c
> > 
> > and maybe others. Would it be better to not crash just log invalid
> > access and either fix up parameters or return some garbage like 0?
> 
> Yes, maybe I was not clear while reviewing v1, we need to audit the
> callers and fix them first, then we can safely add the assert here.

We can add assert here regardless of auditing callers. Doing that
will also make fuzzying easier. But the assert is unrelated to CVE imho.

> > 
> > Regards,
> > BALATON Zoltan
> > 
> >> +
> >>     if (pci_is_express_downstream_port(d) &&
> >>         ranges_overlap(address, len, d->exp.exp_cap + PCI_EXP_LNKSTA,
> >> 2)) {
> >>         pcie_sync_bridge_lnk(d);
> >>


