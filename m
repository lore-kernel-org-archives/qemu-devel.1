Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2E9C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:30:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31BD2217BA
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KB8VJ2CC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BD2217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iafQ8-0007UI-Bq
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 07:30:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iafMS-0005Mz-5t
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:27:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iafML-0005hA-Ss
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:26:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30574
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iafML-0005aH-HE
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575030411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iniRgVAt9ojvJOKaENNx/GEPVOinDp8PLKBjD4TY9AA=;
 b=KB8VJ2CCwz9I3OLMeE25mm2jvCars7WQXcIc4d0zLzaTyoS5ruxMXBSMScUWN5GsVLsHSm
 mbHdQXcJMjYx7Ir6x1OXmLeLWGqSNi4od9KY6szE3edPmOvGc+eLGytj7MtsI1XSMgnICz
 vX6PRSPKIGw5hFwHji3dUGC160tdy5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-NcoP7l2QM-ihbAJhQMJ_6A-1; Fri, 29 Nov 2019 07:26:48 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 700BE100551C;
 Fri, 29 Nov 2019 12:26:47 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60FE019C4F;
 Fri, 29 Nov 2019 12:26:43 +0000 (UTC)
Date: Fri, 29 Nov 2019 13:26:41 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: qom device lifecycle interaction with hotplug/hotunplug ?
Message-ID: <20191129132641.4c7da6c5@redhat.com>
In-Reply-To: <CAFEAcA-qA6n49KdHsGLqt422L_b_9xPfSaJB3tATQvRdfKt-xw@mail.gmail.com>
References: <CAFEAcA9E-Z-RPwFsAiz9Pi3_MtBUFEU7enJFVrpOQ7UKW8e1DQ@mail.gmail.com>
 <20191128182705.0635d1d4@redhat.com>
 <CAFEAcA-qA6n49KdHsGLqt422L_b_9xPfSaJB3tATQvRdfKt-xw@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: NcoP7l2QM-ihbAJhQMJ_6A-1
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 Nov 2019 17:57:56 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 28 Nov 2019 at 17:27, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Thu, 28 Nov 2019 16:00:06 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:  
> > > Once a device is hot-unplugged (and thus unrealized) is it valid
> > > for it to be re-hot-plugged, or is the assumption that it's then
> > > destroyed and a fresh device is created if the user wants to plug
> > > something in again later ? Put another way, is it valid for a qdev
> > > device to see state transitions realize -> unrealize -> realize ?  
> >
> > I don't think we do it currently (or maybe we do with failover but
> > I missed that train), but I don't see why it can't be done.  
> 
> Well, as Eduardo says, if we don't currently do it then
> we probably have a lot of subtly buggy code. Requiring it to work
> imposes a requirement on the 'unrealize' function that it
> doesn't just do required cleanup/resource releasing actions,
> but also returns the device back to exactly the state it was in
> after instance_init, so that 'realize' will work correctly.
> That's quite a lot of code auditing/effort if we don't actually
> have a current or future use for making this work, rather than
> just requiring that an unrealized device object is immediately
> finalized without possibility of resurrection.
> 
> If we do have a plausible usecase then I think we should document
> that unrealize needs to handle this, and also have a basic
> smoke test of the realize->unrealize->realize.
yep, if we talk about generic approach, it's a problem.
But if a concrete combo of device/hotplug controller is considered
where such flow were necessary, it should be possible.

But from the my very limited understanding, on real hardware,
once device is uplugged it's gone (finalized) from machine
perspective, so it's unclear to my why someone would use
realize->unrealize->realize hotplug scenario.

> 
> thanks
> -- PMM
> 


