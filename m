Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50672C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21DCA206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vdd3TT/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DCA206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtTl6-0006wi-D4
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 06:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jtTjo-0005sy-Kk
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:25:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31418
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jtTjm-0007YU-B5
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594290305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VYjJpbLmDRg8oBOiPHHX0aZz4NC0y0Ul0MEpxaJ8L4E=;
 b=Vdd3TT/selbZaIcroE1hl0MCmixa1Y3WqzthqCU6mcdVtWKylHeUmnNzzge+HL5yLj8NUH
 9nyvE6fm8+wSyHJKOBUiII5QxKAs6PW9+XW34uqyz0C20YI0J5Pfh6OksAMqimc4026ale
 zvKFWXpjVVmfRw58OTvATF9BG35TznE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-Sm_zLCILOiqE8dZQ5O25MA-1; Thu, 09 Jul 2020 06:25:01 -0400
X-MC-Unique: Sm_zLCILOiqE8dZQ5O25MA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B94EF19253C5;
 Thu,  9 Jul 2020 10:25:00 +0000 (UTC)
Received: from starship (unknown [10.35.206.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 144225C1C3;
 Thu,  9 Jul 2020 10:24:55 +0000 (UTC)
Message-ID: <a1cde9f7784e2463d214c7cf8435fa8ae44e65e2.camel@redhat.com>
Subject: Re: [PATCH v2 4/7] device-core: use atomic_set on .realized property
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 09 Jul 2020 13:24:54 +0300
In-Reply-To: <20200527150053.GJ29137@stefanha-x1.localdomain>
References: <20200511160951.8733-1-mlevitsk@redhat.com>
 <20200511160951.8733-5-mlevitsk@redhat.com>
 <20200527150053.GJ29137@stefanha-x1.localdomain>
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:20:09
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
Cc: Fam Zheng <fam@euphon.net>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-05-27 at 16:00 +0100, Stefan Hajnoczi wrote:
> On Mon, May 11, 2020 at 07:09:48PM +0300, Maxim Levitsky wrote:
> > Some code might race with placement of new devices on a bus.
> > We currently first place a (unrealized) device on the bus
> > and then realize it.
> > 
> > As a workaround, users that scan the child device list, can
> > check the realized property to see if it is safe to access such a device.
> > Use an atomic write here too to aid with this.
> > 
> > A separate discussion is what to do with devices that are unrealized:
> > It looks like for this case we only call the hotplug handler's unplug
> > callback and its up to it to unrealize the device.
> > An atomic operation doesn't cause harm for this code path though.
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  hw/core/qdev.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> Please add a comment to struct DeviceState saying the realized field
> must be accessed with atomic_load_acquire() when used outside the QEMU
> global mutex.
> 
> > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > index 732789e2b7..d530c5922f 100644
> > --- a/hw/core/qdev.c
> > +++ b/hw/core/qdev.c
> > @@ -964,7 +964,20 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
> >              }
> >         }
> >  
> > +       atomic_store_release(&dev->realized, value);
> > +
> >      } else if (!value && dev->realized) {
> > +
> > +        /*
> > +         * Change the value so that any concurrent users are aware
> > +         * that the device is going to be unrealized
> > +         *
> > +         * TODO: change .realized property to enum that states
> > +         * each phase of the device realization/unrealization
> > +         */
> > +
> > +        atomic_store_release(&dev->realized, value);
> 
> I'm not sure if atomic_store_release() is strong enough in the true ->
> false case:
> 
>   Operations coming after ``atomic_store_release()`` can still be
>   reordered before it.
> 
> A reader may already seen changes made to unrealize the DeviceState even
> though realized still appears to be true. A full write memory barrier
> seems safer here.
Done.

Best regards,
	Maxim Levitsky


