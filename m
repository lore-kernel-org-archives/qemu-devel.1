Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ADFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 11:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97DC12082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 11:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKDoixgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DC12082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k16vf-0008I4-Uo
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 07:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k16uw-0007kg-H5
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 07:40:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26288
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k16uu-0007QU-VB
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 07:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596109207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDtNAgLyjAJLRoPja4vKdF3rEIrIS7+dZ+qtmwLgec0=;
 b=OKDoixgy5jdM13ErvJIOnaN/eOxWLqCXlKbNCrjP2QRkQpqzmj4yiPbKSbVsqDwNYa8DI+
 88THLXLq2hmfrIcO2y5AD/SxTiMTjUylW6/IAf4SvTy1zEe+8dZ/MXUcO4nYf7cvTkvMdP
 AFjRLYQDLWc0F9YmM1NibwxFNddDhIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-mfSwmAYEPNaVUZyv-L1bQw-1; Thu, 30 Jul 2020 07:39:01 -0400
X-MC-Unique: mfSwmAYEPNaVUZyv-L1bQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 918A2102C889
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 11:38:56 +0000 (UTC)
Received: from localhost (unknown [10.40.208.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 538BA76628;
 Thu, 30 Jul 2020 11:38:55 +0000 (UTC)
Date: Thu, 30 Jul 2020 13:38:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 1/1] pci/pcie: refuse another hotplug/unplug event if
 attention button is pending
Message-ID: <20200730133853.048b64ce@redhat.com>
In-Reply-To: <1111d100381f431c1ffeabf1f2c7c74ba79a2af5.camel@redhat.com>
References: <20200722161722.51416-1-mlevitsk@redhat.com>
 <20200722161722.51416-2-mlevitsk@redhat.com>
 <3c4a37263eaceffec01fb00bc9b3549a3c9df90e.camel@redhat.com>
 <1111d100381f431c1ffeabf1f2c7c74ba79a2af5.camel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:41:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Jul 2020 08:09:37 +0300
Maxim Levitsky <mlevitsk@redhat.com> wrote:

> On Wed, 2020-07-22 at 19:19 +0300, Maxim Levitsky wrote:
> > On Wed, 2020-07-22 at 19:17 +0300, Maxim Levitsky wrote:  
> > > Curently it is possible to hotplug a device and then immediatly
> > > hotunplug it before the OS notices, and that will result
> > > in missed unplug event since we can only send one attention button event.
> > > 
> > > Moreover the device will stuck in unplugging state forever.
> > > 
> > > Error out in such cases and rely on the caller (e.g libvirt) to retry
> > > the unplug a bit later
> > > 
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > >  hw/pci/pcie.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > > index 5b48bae0f6..9e836cf2f4 100644
> > > --- a/hw/pci/pcie.c
> > > +++ b/hw/pci/pcie.c
> > > @@ -402,6 +402,17 @@ static void pcie_cap_slot_plug_common(PCIDevice *hotplug_dev, DeviceState *dev,
> > >           */
> > >          error_setg_errno(errp, EBUSY, "slot is electromechanically locked");
> > >      }
> > > +
> > > +    if (sltsta & PCI_EXP_SLTSTA_ABP) {
> > > +        /*
> > > +         * Attention button is pressed, thus we can't send another
> > > +         * hotpplug event  
> > Typo here, forgot to refresh the commit.  
> > > +         */
> > > +        error_setg_errno(errp, EBUSY,
> > > +                         "attention button is already pressed, can't "
> > > +                         "send another hotplug event");
> > > +    }
> > > +
> > >  }
> > >  
> > >  void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,  
> ping.

CCing Julia since she was looking into PCI hotplug/unplug code recently.

> 
> Best regards,
> 	Maxim Levitsky
> 
> 


