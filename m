Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB85C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 17:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C82E215F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 17:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6HaT/QJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C82E215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaNjT-0001CG-86
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 12:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iaNZg-0005nt-K5
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iaNZU-0001Gx-4U
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:27:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60743
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iaNZT-000151-QQ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574962033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+R5PWYXJvVvQKKcR3qhd1xVJQaSdG9qK/VSPYGunzn0=;
 b=K6HaT/QJ0IDfnUymj0O1HyG6uERgmKYpOHcggvntrkk3+BNJuwXBId7kLqUuUu6zdQ4adm
 j22MiLi4jqkPOyjgVI8RD1+7fESWGWzD2Zv89qle9Qr6mstBm6Xy9jhr+99XR751zSCZQz
 RtWClbdeOcpS3cxOvHjU1SayYPcQb/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-8kFq9tAWNkmkr9IwKhPnTw-1; Thu, 28 Nov 2019 12:27:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2069210054E3;
 Thu, 28 Nov 2019 17:27:11 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D3C15D9E1;
 Thu, 28 Nov 2019 17:27:07 +0000 (UTC)
Date: Thu, 28 Nov 2019 18:27:05 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: qom device lifecycle interaction with hotplug/hotunplug ?
Message-ID: <20191128182705.0635d1d4@redhat.com>
In-Reply-To: <CAFEAcA9E-Z-RPwFsAiz9Pi3_MtBUFEU7enJFVrpOQ7UKW8e1DQ@mail.gmail.com>
References: <CAFEAcA9E-Z-RPwFsAiz9Pi3_MtBUFEU7enJFVrpOQ7UKW8e1DQ@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 8kFq9tAWNkmkr9IwKhPnTw-1
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
 Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 Nov 2019 16:00:06 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> Hi; this is a question which came up in Damien's reset series
> which I don't know the answer to:
> 
> What is the interaction of the QOM device lifecycle (instance_init/realize/
> unrealize/instance_finalize) with hotplug and hot-unplug ? I couldn't
> find any documentation of this but maybe I was looking in the wrong
> place...
> 
> Looking at device_set_realized() it seems like we treat "realize"
> as meaning "and also do the hot-plug if this is a device we're
> trying to hotplug". On the other hand hot-unplug is I think the
> other way around: when we get a hot-unplug event we assume that
> it should also imply an "unrealize" (but just unrealizing doesn't
> auto-hot-unplug) ?

Let me try to describe it.

device 'hotplug' interface is poorly named nowadays as it's
just 'plug' interface which checks/wires device into existing machine.
'hotplug' attribute is just informs plug controller that it might
wish to take additional actions to complete device initialization
and notify guest.

plug workflow is as follow:

  DeviceState::realize()
     hotplug_ctrl = qdev_get_hotplug_handler(dev);
     hotplug_handler_pre_plug(hotplug_ctrl, dev) // check / prepare / reserve resources, can fail
     // call concrete device realize_fn()
     hotplug_handler_plug(hotplug_ctrl, dev) // wire device up to board/bus/notify guest, shouldn't fail

 * now old bus based qdev hotplug are tied to _plug callback that
   controller (hotplug_ctrl) that owns bus sets during bus creation.
   (Ideally we should split that on _pre_plug and _plug parts)
 * also any other QOM object could be controller, to allow buss-less
   hotplug (ex: arm-virt machine or pc/q35 machines)

Unplug is a different beast, it could be originated from mgmt side
device_del() and/or from guest side.

device_del() can go 2 ways: qdev_unplug()
 * devices that support surprise removal (i.e. does not require guest cooperation)
   go directly to
       hotplug_handler_unplug() // tear down device from machine
       object_unparent(); -> unrealize() + finalize() // device gone
   essentially it's old qdev code behavior as is.
      
 * async removal a bit different, instead of removal it asks
   controller to process unplug request hotplug_handler_unplug_request()
   and does nothing else.
   After guest is prepared to device removal it notifies QEMU in some way
   to eject device. That calls the same sequence
     hotplug_handler_unplug()
     object_unparent()

> Once a device is hot-unplugged (and thus unrealized) is it valid
> for it to be re-hot-plugged, or is the assumption that it's then
> destroyed and a fresh device is created if the user wants to plug
> something in again later ? Put another way, is it valid for a qdev
> device to see state transitions realize -> unrealize -> realize ?

I don't think we do it currently (or maybe we do with failover but
I missed that train), but I don't see why it can't be done.

I theory it's upto the place where actual eject request is originated from,
it could do unrealize -> realize instead of unparent as far as it calls
hotplug_handler_unplug().

> 
> thanks
> -- PMM
> 


