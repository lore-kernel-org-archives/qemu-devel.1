Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7497C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE6823718
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="BloabVd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE6823718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqFc-0003Qf-Br
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kLpup-00085I-VP; Fri, 25 Sep 2020 11:45:43 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17676)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kLpuk-0008Ln-T2; Fri, 25 Sep 2020 11:45:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601048713; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=o4f9nPP2cEfaHIqfnPj2LpFYtd13hecQTT7e5pkEoblCrjGI3tTY+gG7Ey6nLbworu0IcB1enM8aSP5XHGsp5FiK9XhS7deSA9vayIZo1TCx0CCbOaCYeZpo6UYVH87NEhpKyYsg9DGVL9cs+rG1xnKWLdganbEDNVg6V8X+hUY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1601048713;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=nOLlc46LeGvX3hMrdauzB7cLVPSOZZKUFDgSdUkJ3M4=; 
 b=q6KrbCYo+5ZeUb3lIR0hmNxbEBd2pGD8+q230Q2jfoSA1JeaHN5I/ZaOMxjV/BMxT5QkphaLJ8SFm0zKFCh8oVbr+KbtJFaAEMYnXGENpQl8tJC2tq1yUOTAZ5aP+189jfB3fC6EtY0z/GiIbVxiXz9hlEuxQ8vTIYB+u5al/LQ=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=euphon.net;
 spf=pass  smtp.mailfrom=fam@euphon.net;
 dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1601048713; 
 s=zoho; d=euphon.net; i=fam@euphon.net;
 h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:Mime-Version:Content-Transfer-Encoding;
 bh=nOLlc46LeGvX3hMrdauzB7cLVPSOZZKUFDgSdUkJ3M4=;
 b=BloabVd9FpKgXTtKiasJ0QzbczDv8ctDKsN9wRShVFhMWzuV6giuoOP29QwEI83a
 9fD3l/v5r1xxSiZ/joXGiq6KzwnhcqorqJPO12FAidRbJlShTduaoZuhDwZpChM8Zqf
 wNd2F953gh2k0yr4oC7EpxRK4lRjt8qTdr6Qp2y8=
Received: from u60bdefc337955a.ant.amazon.com (54.239.6.186 [54.239.6.186]) by
 mx.zoho.com.cn with SMTPS id 1601048710761943.7317003896499;
 Fri, 25 Sep 2020 23:45:10 +0800 (CST)
Message-ID: <6ed38e381e57237c1dc84cc07d54f48895ccd517.camel@euphon.net>
Subject: Re: [RFC 1/3] util/vfio-helpers: Collect IOVA reserved regions
From: Fam Zheng <fam@euphon.net>
To: Auger Eric <eric.auger@redhat.com>
Date: Fri, 25 Sep 2020 16:44:57 +0100
In-Reply-To: <c2a4750a-dd33-2170-d450-3879e98210b5@redhat.com>
References: <20200925134845.21053-1-eric.auger@redhat.com>
 <20200925134845.21053-2-eric.auger@redhat.com>
 <20200925144307.GA3809989@dev>
 <c2a4750a-dd33-2170-d450-3879e98210b5@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-ZohoCNMailClient: External
Received-SPF: pass client-ip=163.53.93.243; envelope-from=fam@euphon.net;
 helo=sender2-op-o12.zoho.com.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 10:43:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: lvivier@redhat.com, kwolf@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, stefanha@redhat.com, philmd@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2020-09-25 at 17:23 +0200, Auger Eric wrote:
> > > @@ -365,8 +430,12 @@ static int qemu_vfio_init_pci(QEMUVFIOState
> > > *s, const char *device,
> > >      if (ret) {
> > >          goto fail;
> > >      }
> > > +    g_free(iommu_info);
> > >      return 0;
> > >  fail:
> > > +    g_free(s->usable_iova_ranges);
> > 
> > Set s->usable_iova_ranges to NULL to avoid double free?
> 
> I think I did at the beginning of qemu_vfio_init_pci()

Yes, but I mean clearing the pointer will make calling
qemu_vfio_close() safe, there is also a g_free() on this one.

Fam

> 
> Thanks
> 
> Eric
> > 
> > > +    s->nb_iova_ranges = 0;
> > > +    g_free(iommu_info);
> > >      close(s->group);
> > >  fail_container:
> > >      close(s->container);
> > > @@ -716,6 +785,8 @@ void qemu_vfio_close(QEMUVFIOState *s)
> > >          qemu_vfio_undo_mapping(s, &s->mappings[i], NULL);
> > >      }
> > >      ram_block_notifier_remove(&s->ram_notifier);
> > > +    g_free(s->usable_iova_ranges);
> > > +    s->nb_iova_ranges = 0;
> > >      qemu_vfio_reset(s);
> > >      close(s->device);
> > >      close(s->group);
> > > -- 
> > > 2.21.3
> > > 
> > > 
> > 
> > Fam
> > 
> 
> 


