Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6B8C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 08:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28716208E4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 08:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyFpcqdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28716208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJvVw-0001aV-5A
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 04:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jJvVA-0000rm-O0
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jJvV9-0005EQ-I3
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:47:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53520
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jJvV9-0005Da-DC
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585817222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fzgta2RbzHFri8u6QWgqC99rK5tDlTydYIsFMOMuVWo=;
 b=UyFpcqdoVSX5DyvXiEexZj1xugE8JRffYh2lxJb6plXhiktCe/RMW7gvEZ7wru+/5BG+Lb
 si8XuGZwLVndeP6VROQHNyaoLem6yVqPNCwsIkzKp38L5znwrRooVm8Gu+Td1m2VAezq/3
 TFm3wV75lu0fUB5oqH7BF52GCzYu9Io=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-VNJIcMrTPVKbGjPkbOiNcQ-1; Thu, 02 Apr 2020 04:47:01 -0400
X-MC-Unique: VNJIcMrTPVKbGjPkbOiNcQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10D3A8017F3;
 Thu,  2 Apr 2020 08:47:00 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3C51100EBAF;
 Thu,  2 Apr 2020 08:46:58 +0000 (UTC)
Message-ID: <ffa77fc719232b8dc0e6e78bd3781fd77c5adcf8.camel@redhat.com>
Subject: Re: Question about scsi device hotplug (e.g scsi-hd)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 02 Apr 2020 11:46:57 +0300
In-Reply-To: <4bc42bf2-939f-f6c4-ea45-0d08eb42fc2b@redhat.com>
References: <7302c0b9f2327b9b61b4adb465f166e339e46ac1.camel@redhat.com>
 <20200401150944.GA4500@stefanha-x1.localdomain>
 <4bc42bf2-939f-f6c4-ea45-0d08eb42fc2b@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-04-01 at 18:36 +0200, Paolo Bonzini wrote:
> On 01/04/20 17:09, Stefan Hajnoczi wrote:
> > > What do you think about it?
> > 
> > Maybe aio_disable_external() is needed to postpone device emulation
> > until after realize has finished?

Isn't that virtio specific? In theory this issue can touch any driver that
behaves similar to scsi.

Also due to racing, the request might already be in virtqueue and the virtio-scsi iothread might have already
fetched it when we place the device on the bus.

In fact I don't see any locking in bus_add_child / scsi_device_find so in fact if the timing is right
and iothread calls the scsi_device_find while main thread adds the device on the bus that will cause
the whole thing go south.

IMHO the right solution for this is first to realize the device and then place it
on the bus, and even that I am not sure that will fix the race completely.

IMHO the correct solution here is to stop querying the bus children on the guest controlled IO path 
(scsi_device_find) but rather use the hotplug handlers to
store the active luns of the scsi device in parallel (and with proper locking).


Best regards,
	Maxim Levitsky


> > 
> > Virtqueue kick ioeventfds are marked "external" and won't be processed
> > while external events are disabled.  See also
> > virtio_queue_aio_set_host_notifier_handler() ->
> > aio_set_event_notifier().
> 
> Yes, I think Stefan is right.
> 
> Paolo
> 



