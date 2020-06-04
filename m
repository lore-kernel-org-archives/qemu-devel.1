Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A43C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2592075B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1vsaxXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2592075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgoFm-0002HZ-KK
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 07:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgoEn-0001jK-Qb
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:40:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28503
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgoEm-0004M2-S3
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591270844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QWP4ga0oUMrsMa55YbnhZ68E7nusmapYErLVTONA2Po=;
 b=H1vsaxXXjK3+DpwOG+Gufr0w/pYt0nVfSgjvTU09zeuuLDY3SHPW1lAlT+7GgWMFm89nTs
 Qm02y84a2LexGFjhj0BcEn9lyTBgFMbzUffY8s8DBLL30dI3p5oVHYPbB8YwDQxeCl7vNh
 ogobShI/CuBKF9L9Pryw03JXGIs6N/8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-Fp0mRluyN6yOLIeddzlSjg-1; Thu, 04 Jun 2020 07:40:40 -0400
X-MC-Unique: Fp0mRluyN6yOLIeddzlSjg-1
Received: by mail-wr1-f69.google.com with SMTP id d6so2325407wrn.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 04:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=5cdH2W2acvZhz8BaiDE1Y4jD8LtBxJ/FFqXYWszPEfM=;
 b=HJfIgNo9h8kYSO2DBTblYUvQk2WRs0VSS9Vn4+ZCeZ1tVNGp9z/yf1McOyMvmHliLS
 qQik8+JLKWsY7f1UAxliLrmbE6dzcvbQ4tL4ZQLFntrOCkF7tK4Lk4oeC/Wveoa2CDKw
 xM79ZrteaO2F3gEcGLk7xOpoD32iIX52P7RdKBZEFlJjjkTCVd7/SdTJFXDLG1XW3oQP
 CI0RdYVjfjYQYXiWgS1FkdEW006DIAKOuF0ayoojwMImmHQz0DrRuZcrLxAx7/BJ7Rrd
 bJv4CcQuOBq2O2jN4cK2hri9s71kOD1yKF7Y3DE3rdreEphalw6vFSIj+F4SSSAG2h5H
 E7aA==
X-Gm-Message-State: AOAM532v8q5TAE+/gb3VFf0sn5lzOjOXesJNpmvv2M37Y8TgNFfDGgl4
 d3Gdes1R1QFJGno1e0yZ7PCNt37lnptGhmwU6F5i+Loqy42uG2tADksWR8IK5TmDfjrZKx7H8Ts
 Pbkm52OB6pz9z1kw=
X-Received: by 2002:adf:a507:: with SMTP id i7mr4487769wrb.0.1591270839583;
 Thu, 04 Jun 2020 04:40:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx43LVYR2s/l9j1221TKH0QL+MdqFepsrE2SDDOmyGL1KkPz0I+shqa39+/xZ4qZvsPjCDAwg==
X-Received: by 2002:adf:a507:: with SMTP id i7mr4487731wrb.0.1591270838987;
 Thu, 04 Jun 2020 04:40:38 -0700 (PDT)
Received: from redhat.com ([2a00:a040:185:f65:9a3b:8fff:fed3:ad8d])
 by smtp.gmail.com with ESMTPSA id a81sm7662355wmd.25.2020.06.04.04.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 04:40:38 -0700 (PDT)
Date: Thu, 4 Jun 2020 07:40:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH v2 2/2] pci: ensure configuration access is within bounds
Message-ID: <20200604073753-mutt-send-email-mst@kernel.org>
References: <20200603202251.1199170-1-ppandit@redhat.com>
 <20200603202251.1199170-3-ppandit@redhat.com>
 <alpine.BSF.2.22.395.2006040006520.56892@zero.eik.bme.hu>
 <e1ccdf71-5069-fa95-3c90-de4f875b2706@redhat.com>
 <20200604054043-mutt-send-email-mst@kernel.org>
 <alpine.BSF.2.22.395.2006041335250.54170@zero.eik.bme.hu>
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2006041335250.54170@zero.eik.bme.hu>
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
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 01:37:13PM +0200, BALATON Zoltan wrote:
> On Thu, 4 Jun 2020, Michael S. Tsirkin wrote:
> > On Thu, Jun 04, 2020 at 08:07:52AM +0200, Philippe Mathieu-DaudÃ© wrote:
> > > On 6/4/20 12:13 AM, BALATON Zoltan wrote:
> > > > On Thu, 4 Jun 2020, P J P wrote:
> > > > > From: Prasad J Pandit <pjp@fedoraproject.org>
> > > > > 
> > > > > While reading PCI configuration bytes, a guest may send an
> > > > > address towards the end of the configuration space. It may lead
> > > > > to an OOB access issue. Assert that 'address + len' is within
> > > > > PCI configuration space.
> > > > > 
> > > > > Suggested-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
> > > > > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> > > > > ---
> > > > > hw/pci/pci.c | 2 ++
> > > > > 1 file changed, 2 insertions(+)
> > > > > 
> > > > > Update v2: assert PCI configuration access is within bounds
> > > > > Â -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00711.html
> > > > > 
> > > > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > > > index 70c66965f5..173bec4fd5 100644
> > > > > --- a/hw/pci/pci.c
> > > > > +++ b/hw/pci/pci.c
> > > > > @@ -1381,6 +1381,8 @@ uint32_t pci_default_read_config(PCIDevice *d,
> > > > > {
> > > > > Â Â Â  uint32_t val = 0;
> > > > > 
> > > > > +Â Â Â  assert(address + len <= pci_config_size(d));
> > > > 
> > > > Does this allow guest now to crash QEMU? I think it was suggested that
> > > > assert should only be used for cases that can only arise from a
> > > > programming error and not from values set by the guest. If this is
> > > > considered to be an error now to call this function with wrong
> > > > parameters did you check other callers? I've found a few such as:
> > > > 
> > > > hw/scsi/esp-pci.c
> > > > hw/watchdog/wdt_i6300esb.c
> > > > hw/ide/cmd646.c
> > > > hw/vfio/pci.c
> > > > 
> > > > and maybe others. Would it be better to not crash just log invalid
> > > > access and either fix up parameters or return some garbage like 0?
> > > 
> > > Yes, maybe I was not clear while reviewing v1, we need to audit the
> > > callers and fix them first, then we can safely add the assert here.
> > 
> > We can add assert here regardless of auditing callers. Doing that
> > will also make fuzzying easier. But the assert is unrelated to CVE imho.
> 
> I wonder why isn't the check added to pci_default_read_config() right away?
> If we have an assert there the overhead is the same and adding the check
> there would make it unnecessary to patch all callers so it's just one patch
> instead of a whole series.
> 
> Regards,
> BALATON Zoltan

We need to return something, and we can't be sure that callers will
handle returning random stuff correctly. Callers know what
to do on errors, we don't.

-- 
MST


