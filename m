Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B319CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0269B20679
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRxh4D8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0269B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXNS-0007LL-MA
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iMXJ2-0003gQ-F8
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iMXJ1-0007ma-6C
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:01:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59505
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iMXJ1-0007m5-1l
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571662861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OI8ZZ0RhNg5mrMbc/fW+cCd4/Dv10mMQxZsA6h+0Vf8=;
 b=PRxh4D8N9/JlBjol28mNxXDQ4M19ozn2ylOoUOY4yTP180TuEH7oYQcinNw2ioicrmHJhj
 dDSkN9GE9KH+EwoC9dmxqk/tdp0bRqb7Obo1iTPneJwiyWmPwLAZ4v5S81crUvtQu83mR4
 +gc5+EhrSqbLK3yU/cX6mXwNluE/SAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-YmBom_QkOEmk9VboiNXlNQ-1; Mon, 21 Oct 2019 09:00:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93DDE800D41;
 Mon, 21 Oct 2019 13:00:58 +0000 (UTC)
Received: from localhost (dhcp-192-217.str.redhat.com [10.33.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A35595D9E5;
 Mon, 21 Oct 2019 13:00:34 +0000 (UTC)
Date: Mon, 21 Oct 2019 15:00:33 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 01/11] qdev/qbus: add hidden device support
Message-ID: <20191021130033.qx5jy53ir4dllefb@jenstp.localdomain>
References: <20191018202040.30349-1-jfreimann@redhat.com>
 <20191018202040.30349-2-jfreimann@redhat.com>
 <CAFEAcA-wE1vt_dWsa-k+VK8T0YyRKiPhXUYNYdYVk98nekg=zw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-wE1vt_dWsa-k+VK8T0YyRKiPhXUYNYdYVk98nekg=zw@mail.gmail.com>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: YmBom_QkOEmk9VboiNXlNQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Krempa <pkrempa@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 aadam@redhat.com, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Laine Stump <laine@redhat.com>,
 Amnon Ilan <ailan@redhat.com>, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 21, 2019 at 01:53:58PM +0100, Peter Maydell wrote:
>On Fri, 18 Oct 2019 at 21:22, Jens Freimann <jfreimann@redhat.com> wrote:
>>
>> This adds support for hiding a device to the qbus and qdev APIs.  The
>> first user of this will be the virtio-net failover feature but the API
>> introduced with this patch could be used to implement other features as
>> well, for example hiding pci devices when a pci bus is powered off.
>
>In what sense is a hidden device hidden? Is it hidden from
>the guest (in what way) ? Is it hidden from the QMP/HMP monitor
>commands? Is it hidden from QEMU functions that iterate through
>the qbus, or that walk the QOM tree ? What does a hidden device
>have to do to be successfully hidden ? Is it completely disconnected
>from the rest of the simulation, or does it itself have to avoid
>doing things like asserting IRQ lines ?
>
>Expanding the DeviceClass doc comment might be a good place to answer
>questions like the above and generally describe the 'hidden device'
>mechanism.

ok, I will add to the DeviceClass comment.=20

>
>>  };
>>
>> @@ -451,4 +457,6 @@ static inline bool qbus_is_hotpluggable(BusState *bu=
s)
>>  void device_listener_register(DeviceListener *listener);
>>  void device_listener_unregister(DeviceListener *listener);
>>
>> +bool qdev_should_hide_device(QemuOpts *opts);
>
>New globally visible functions should always have doc-comment
>format documentation comments, please.

Will add this too. Thanks for the review!

regards,
Jens=20


