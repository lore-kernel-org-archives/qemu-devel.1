Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377DAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15E320760
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJAS0Ha5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15E320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jigvu-0003Kv-2B
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jigsi-0000h3-74
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:13:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44615
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jigsf-0005lc-Di
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591719219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GPwOf/4bt1/9O35BGeywpEzk760Tv43YHQl3Y49qU5k=;
 b=NJAS0Ha5eK5FYYgRm8KbV9FRf9bWpPN8mw2jxaWT1cStTc9SJ5+DpAlxa5B9EhE2uWz2tu
 w8doqn6eCSdot8Bucq/25bDld4DmHdsnVbojtsKWWVSrqGKOclur1+2cBSycEe0g7ayQ27
 vNSVNv5CprS7Tp/opuFy+ucqyPTjjRo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-sTd9fg2jO_WCrmZ23-jHoA-1; Tue, 09 Jun 2020 12:13:37 -0400
X-MC-Unique: sTd9fg2jO_WCrmZ23-jHoA-1
Received: by mail-qv1-f69.google.com with SMTP id w3so17104464qvl.9
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=GPwOf/4bt1/9O35BGeywpEzk760Tv43YHQl3Y49qU5k=;
 b=W0qxGbImFIr36XY1cMJ7Gq49stjFjY5FmrcXieScKHvmEdoXigmQK32kHTuElMFzJz
 kq6glsOvx9TNJH0qhiMuMFhnKA2kmb33YbxAK1xgT6pvkvSBK8s/Jk6vtWMCYjN1f/2O
 52EWt1C2NEiUkJuhJyw3TpRYH6RLmChq/p8vYcORBbY/m5+PR3QN9Z/pzzybuVZibFts
 n9zo5O9qTzGcfqUiNRKfmyEmPZNtib2EX66vVFScUFLRBiaF8dqeaAz+uLJx0G4WbJkl
 MD7WiFle8Y6IVUodj2TPco3l1XTOzryVtOVt3VfZtsUG8BPmn9R1PkTiUQi9KakHm3NF
 Eu7w==
X-Gm-Message-State: AOAM532fAa/1E/t0hE85TQdh5t1oBSThYR7wBDT2XRkvqK3FLAawJ5Bl
 AKlMrvV/0bVdDdqYi1pdLYQjGP/9vXtPxT0gEfgOcl6Gsafz2JHOj0yMEzrTCHEiicG+wz2GrK3
 x0sOHXT8rpHhhqpo=
X-Received: by 2002:a05:620a:c0f:: with SMTP id
 l15mr27340830qki.175.1591719217033; 
 Tue, 09 Jun 2020 09:13:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAFgHXKG1gxl1ky2XfQ10wqeAa56tMgNJEb/4w6bkjtFNzbyaWKsuy6MQN7U3cgQLpmCGyrA==
X-Received: by 2002:a05:620a:c0f:: with SMTP id
 l15mr27340784qki.175.1591719216623; 
 Tue, 09 Jun 2020 09:13:36 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id 207sm9405944qki.134.2020.06.09.09.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 09:13:35 -0700 (PDT)
Date: Tue, 9 Jun 2020 12:13:28 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] pci: Display PCI IRQ pin in "info pci"
Message-ID: <20200609161328.GB3061@xz-x1>
References: <20200317195908.283800-1-peterx@redhat.com>
 <6beb4b5d-91c6-2536-64ab-18217be71134@redhat.com>
 <20200317201153.GB233068@xz-x1>
 <2847e5da-4cc3-8273-f51f-86b0995943de@redhat.com>
 <20200609114913-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200609114913-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 09, 2020 at 11:49:49AM -0400, Michael S. Tsirkin wrote:
> > > > > @@ -417,8 +419,8 @@
> > > > >    { 'struct': 'PciDeviceInfo',
> > > > >      'data': {'bus': 'int', 'slot': 'int', 'function': 'int',
> > > > >               'class_info': 'PciDeviceClass', 'id': 'PciDeviceId',
> > > > > -           '*irq': 'int', 'qdev_id': 'str', '*pci_bridge': 'PciBridgeInfo',
> > > > > -           'regions': ['PciMemoryRegion']} }
> > > > > +           '*irq': 'int', 'irq_pin': 'int', 'qdev_id': 'str',
> > > > > +           '*pci_bridge': 'PciBridgeInfo', 'regions': ['PciMemoryRegion'] }}
> > > > 
> > > > and the pre-existing pci_bridge is indeed the consistency issue.
> > > 
> > > Yeh, actually every key in this struct. :)
> > 
> > Using 'irq-pin':
> > Reviewed-by: Philippe Mathieu-DaudÃÂ© <philmd@redhat.com>
> 
> 
> Peter can you fix and repost pls?

I still think irq_pin is better because as I mentioned previously all the
existing keys are using underscores...  Phil?

Thanks,

-- 
Peter Xu


