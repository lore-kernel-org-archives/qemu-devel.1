Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F49C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E092076C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CNyA/3kS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E092076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFvMX-0007dX-NW
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 04:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kFvLU-00066z-AC
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:20:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21946
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kFvLR-0004BM-Sd
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599639644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ow03md1dmzJNtknAHHuWn8qCqgl0QtY+YMweXygRRAY=;
 b=CNyA/3kSknQxw7hoixYWUxjDU8csNC1O3xC8+39n610g7g+ceF5LacIK+FiskVVwNTb2Nw
 kzPWeqN3O5PlR9m3C6C5vk25txlcHUyDfbFSZgmpdCCCnv9w/AUKgBOM/9RI29Mi1+qDbF
 s1szhoYHLOzJZ3usWT5af6EfiNowOG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-bTWBYleBNYav420tElujIg-1; Wed, 09 Sep 2020 04:20:39 -0400
X-MC-Unique: bTWBYleBNYav420tElujIg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8E2818BA285;
 Wed,  9 Sep 2020 08:20:38 +0000 (UTC)
Received: from starship (unknown [10.35.206.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 917E75C230;
 Wed,  9 Sep 2020 08:20:25 +0000 (UTC)
Message-ID: <b28a5a2bf78fdc563aa3b20d4cd264238545ef04.camel@redhat.com>
Subject: Re: [PATCH v4 9/9] scsi/scsi_bus: fix races in REPORT LUNS
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 09 Sep 2020 11:20:24 +0300
In-Reply-To: <20200908152740.GF7154@stefanha-x1.localdomain>
References: <20200831150124.206267-1-mlevitsk@redhat.com>
 <20200831150124.206267-10-mlevitsk@redhat.com>
 <20200908152740.GF7154@stefanha-x1.localdomain>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 2020-09-08 at 16:27 +0100, Stefan Hajnoczi wrote:
> On Mon, Aug 31, 2020 at 06:01:24PM +0300, Maxim Levitsky wrote:
> > Currently scsi_target_emulate_report_luns iterates
> > over child devices list twice, and there is guarantee, that
> > it will not be changed meanwhile.
> > 
> > This reason for two loops is that it needs to know how much memory
> > to allocate.
> > 
> > Avoid this by iterating once, and allocating the memory for the output
> > dynamically with reserving enought memory so that in practice it won't
> > be reallocated often.
> > 
> > Bugzilla for reference: https://bugzilla.redhat.com/show_bug.cgi?id=1866707
> 
> "Buglink:" is the tag name documented in
> https://wiki.qemu.org/Contribute/SubmitAPatch#Write_a_meaningful_commit_message
Noted
> 
> >  static bool scsi_target_emulate_report_luns(SCSITargetReq *r)
> >  {
> >      BusChild *kid;
> > -    int i, len, n;
> >      int channel, id;
> > -    bool found_lun0;
> > +    uint8_t tmp[8] = {0};
> > +    int len = 0;
> > +
> > +    /* reserve space for 63 LUNs*/
> > +    GByteArray *buf = g_byte_array_sized_new(512);
> >  
> >      if (r->req.cmd.xfer < 16) {
> >          return false;
> 
> buf is leaked.
Oops, will fix
> 
> > @@ -460,46 +466,36 @@ static bool scsi_target_emulate_report_luns(SCSITargetReq *r)
> >      }
> >      channel = r->req.dev->channel;
> >      id = r->req.dev->id;
> > -    found_lun0 = false;
> > -    n = 0;
> >  
> > -    rcu_read_lock();
> >  
> > -    QTAILQ_FOREACH_RCU(kid, &r->req.bus->qbus.children, sibling) {
> > -        DeviceState *qdev = kid->child;
> > -        SCSIDevice *dev = SCSI_DEVICE(qdev);
> > +    /* add size (will be updated later to correct value */
> > +    g_byte_array_append(buf, tmp, 8);
> > +    len += 8;
> 
> Can g_byte_array_size() be used instead of keeping a len local variable?
Glib don't seem to have this function, I checked the docs.
Its seems that they want to convert it to GBytes which is basically immutible verion
of GByteArray and it does have g_bytes_get_size.
I decided that a local variable while ugly is still better that this.


I haven't wrote much code that uses Glib, so I might have missed something though.
I had read this reference:
https://developer.gnome.org/glib/stable/glib-Byte-Arrays.html


> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Best regards,
	Maxim Levitsky



