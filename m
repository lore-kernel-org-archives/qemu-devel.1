Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11558C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:43:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D098E20869
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKWHxVkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D098E20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iafca-0006fF-RU
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 07:43:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iafaI-0005K7-7e
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:41:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iafaC-0001la-K1
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:41:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27124
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iafaC-0001fm-CU
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575031268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LefiRVZq6vvmGxdToinGL95lCi6FpxY8ErQNEKkjQns=;
 b=gKWHxVkmzsS3o3p84ec6jnZJZb1U2foiE5kjAA4kT0jcjJtOYRX4uECBo2uqL4koVGiwt0
 0Qm/xS0MakWpeF8j2E9JKsRnqLH5txK3hGH1WgkVWPYexR+hW6C7KfYBfWmkb4wWDTXE5G
 3ppa5IDvCPnLj0QjJ42p2DreHXhdUNQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-gXJDuNDpPy-Lo_n_NRNMkA-1; Fri, 29 Nov 2019 07:41:05 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70EF7100E378;
 Fri, 29 Nov 2019 12:41:04 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44528600CA;
 Fri, 29 Nov 2019 12:40:56 +0000 (UTC)
Date: Fri, 29 Nov 2019 13:40:55 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: qom device lifecycle interaction with hotplug/hotunplug ?
Message-ID: <20191129134055.08f27e7a@redhat.com>
In-Reply-To: <20191128163358.GC14595@habkost.net>
References: <CAFEAcA9E-Z-RPwFsAiz9Pi3_MtBUFEU7enJFVrpOQ7UKW8e1DQ@mail.gmail.com>
 <20191128163358.GC14595@habkost.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: gXJDuNDpPy-Lo_n_NRNMkA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 Nov 2019 13:33:58 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Thu, Nov 28, 2019 at 04:00:06PM +0000, Peter Maydell wrote:
> > Hi; this is a question which came up in Damien's reset series
> > which I don't know the answer to:
> > 
> > What is the interaction of the QOM device lifecycle (instance_init/realize/
> > unrealize/instance_finalize) with hotplug and hot-unplug ? I couldn't
> > find any documentation of this but maybe I was looking in the wrong
> > place...
> > 
> > Looking at device_set_realized() it seems like we treat "realize"
> > as meaning "and also do the hot-plug if this is a device we're
> > trying to hotplug". On the other hand hot-unplug is I think the
> > other way around: when we get a hot-unplug event we assume that
> > it should also imply an "unrealize" (but just unrealizing doesn't
> > auto-hot-unplug) ?  
> 
> Your description seems accurate, and I agree it is confusing.
> 
> It would be more consistent if realized=true didn't plug the
> device automatically, and qdev_device_add() asked the hotplug
> handler to plug the device instead.
agreed, it's confusing. But that would not allow to
  o = object_new()
  set props
  o.realize()
reuse the same plug handlers.

we potentially can convert it to device_add input arguments
and then call qdev_device_add() instead, which would then
handle plug handlers, not sure it's doable though.
Other than that I don't have any ideas how to make it less confusing.

> > Once a device is hot-unplugged (and thus unrealized) is it valid
> > for it to be re-hot-plugged, or is the assumption that it's then
> > destroyed and a fresh device is created if the user wants to plug
> > something in again later ? Put another way, is it valid for a qdev
> > device to see state transitions realize -> unrealize -> realize ?  
> 
> My interpretation is that this is valid in theory, but likely to
> crash a large portion of our devices if we tried it.
> 


