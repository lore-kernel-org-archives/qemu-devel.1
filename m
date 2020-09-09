Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A710C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3B32087C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwHlT1B5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3B32087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFvI3-0000qD-Ns
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 04:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kFvH6-0008MT-IH
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:16:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kFvH3-0003e0-IL
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599639372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=so41U4MUkQRUx2iE/FsoqQ2ZpejBYVETpwxD+8aaCGk=;
 b=BwHlT1B54f6BViL5DfTy7T68fFBJUnDTaeJwH5sL46pMeO6gKoiBIl05gwPsveDU+hQZsN
 tEkZXDAF/GM8bRtVjO1RNK9L9LYaxVTeygzTIJW9CJB5ub6x3eGanpaEUCxsrPuFMvXos6
 JP39Y8qhBT/obINfrqdaUJDhHNgls04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-7pWXsEycNViAuuV_lp3ZJw-1; Wed, 09 Sep 2020 04:16:10 -0400
X-MC-Unique: 7pWXsEycNViAuuV_lp3ZJw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 472BD1007467;
 Wed,  9 Sep 2020 08:16:09 +0000 (UTC)
Received: from starship (unknown [10.35.206.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 741995C1C4;
 Wed,  9 Sep 2020 08:15:58 +0000 (UTC)
Message-ID: <c32cf4169a941f0dee057eda59ce96e71b4fa541.camel@redhat.com>
Subject: Re: [PATCH v4 6/9] scsi/scsi-bus: scsi_device_find: don't return
 unrealized devices
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 09 Sep 2020 11:15:57 +0300
In-Reply-To: <20200908150038.GE7154@stefanha-x1.localdomain>
References: <20200831150124.206267-1-mlevitsk@redhat.com>
 <20200831150124.206267-7-mlevitsk@redhat.com>
 <20200908150038.GE7154@stefanha-x1.localdomain>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:25:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-09-08 at 16:00 +0100, Stefan Hajnoczi wrote:
> On Mon, Aug 31, 2020 at 06:01:21PM +0300, Maxim Levitsky wrote:
> > The device core first places a device on the bus and then realizes it.
> > Make scsi_device_find avoid returing such devices to avoid
> > races in drivers that use an iothread (currently virtio-scsi)
> > 
> > Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1812399
> > 
> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  hw/scsi/scsi-bus.c | 88 ++++++++++++++++++++++++++++------------------
> >  1 file changed, 53 insertions(+), 35 deletions(-)
> > 
> > diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> > index 92d412b65c..7ceae2c92b 100644
> > --- a/hw/scsi/scsi-bus.c
> > +++ b/hw/scsi/scsi-bus.c
> > @@ -51,6 +51,56 @@ static const TypeInfo scsi_bus_info = {
> >  };
> >  static int next_scsi_bus;
> >  
> > +static SCSIDevice *_scsi_device_find(SCSIBus *bus, int channel, int id, int lun,
> > +                                     bool include_unrealized)
> 
> Declaring an identifier with a leading underscore with file scope is
> undefined behavior according to the C99 standard (7.1.3 Reserved
> identifiers). QEMU code usually avoids doing this by calling the
> function do_scsi_device_find() or similar.

I'll fix that, thanks!

Best regards,
	Maxim Levitsky
> 
> I'm not aware of any practical problem though, so don't worry about
> changing it unless you respin the series:
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>



