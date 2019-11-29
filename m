Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10196C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C13D2217BA
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCU2svb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13D2217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iahg7-0008PG-VP
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 09:55:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iahBt-0000Zx-9j
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:24:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iahBo-0007rk-TZ
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:24:10 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22546
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iahBo-0007mm-Bp
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575037444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xj3Z40l1uTlyL8bMnQZnzQJr3wwyQ7EG32Qn5NAJ+qM=;
 b=gCU2svb2LLn2++le01whkH2Sr3qm0rj1zAiF1mhR4Wcn5BxXbimOEMMIDZzmxMYRpvtAkS
 vunzJGpGY9ksgG1t0r0rut805Yg/F8wF+hrW0TBcP+NfCDiWBazi/dZHrZRMLrs81ATt87
 nWlCyCz6zwQb4hwEe4hG7FWB5N2F4wQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-8AaOpvTUMgy3cJJiFyLebA-1; Fri, 29 Nov 2019 09:24:03 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36077184CAA1;
 Fri, 29 Nov 2019 14:24:02 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D02019C58;
 Fri, 29 Nov 2019 14:23:56 +0000 (UTC)
Date: Fri, 29 Nov 2019 15:23:54 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Subject: Re: qom device lifecycle interaction with hotplug/hotunplug ?
Message-ID: <20191129152354.6bcac646@redhat.com>
In-Reply-To: <119190aa-a9f6-ae5c-b51c-98568287036c@greensocs.com>
References: <CAFEAcA9E-Z-RPwFsAiz9Pi3_MtBUFEU7enJFVrpOQ7UKW8e1DQ@mail.gmail.com>
 <20191128182705.0635d1d4@redhat.com>
 <CAFEAcA-qA6n49KdHsGLqt422L_b_9xPfSaJB3tATQvRdfKt-xw@mail.gmail.com>
 <20191129132641.4c7da6c5@redhat.com>
 <CAFEAcA_gcxqu+N5iV0L5WLyWmm5yxTFNMtmqQryBgVd4CCCT8A@mail.gmail.com>
 <119190aa-a9f6-ae5c-b51c-98568287036c@greensocs.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 8AaOpvTUMgy3cJJiFyLebA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 14:05:23 +0100
Damien Hedde <damien.hedde@greensocs.com> wrote:

> On 11/29/19 1:45 PM, Peter Maydell wrote:
> > On Fri, 29 Nov 2019 at 12:26, Igor Mammedov <imammedo@redhat.com> wrote:  
> >> But from the my very limited understanding, on real hardware,
> >> once device is uplugged it's gone (finalized) from machine
> >> perspective, so it's unclear to my why someone would use
> >> realize->unrealize->realize hotplug scenario.  
> > 
> > Well, on real hardware 'unplug' is different from 'unrealize'.
> > So I think for QEMU if we wanted to allow this sort of 'unplug
> > and replug the same device' we should do it by:
> > 
> >  instance_init -> realize -> plug -> unplug -> plug -> unplug ->
> >    unrealize -> finalize
> > 
> > So unrealize/finalize is when the device is actually destroyed,
> > and if you're going to replug the device you don't destroy it
> > on unplug.
> >   
> 
> Hello everybody,
> 
> What I was initially wondering (or afraid of) when this question/problem
> comes to me is;
> Are there some cases where QEMU does the following (in the context of an
> hotplugged device):
> 
> instance_init -> realize (and plug) -> unrealize -> change some
> properties -> realize
> with no unplug / plug in between

not that I know of (at least not with device_add/del)

> because I have the impression, the realize was here to allow setting
> properties.

in theory it should be
 instance_init -> set properties -> realize
and ping pong realize <-> unrealize, should work as far the device
in question takes that in consideration.

In practice for generic arbitrary device it probably won't work
out of the box since people tended to put too much in realize
and didn't care about proper cleanup since device in question
typically is destroyed right after unrealize.

So it's probably implementable for some internal device
if it doesn't use device_add/del, otherwise millage might vary.

> But it may be pure nonsense as I do not know well the
> underlying mechanisms there.
> 
> Regards,
> --
> Damien
> 


