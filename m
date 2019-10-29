Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCDBCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 12:15:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C384208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 12:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvNs5arY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C384208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPQOz-0005yq-G1
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 08:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iPQOF-0005WU-9r
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iPQOD-0005CT-V8
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:14:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32630
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iPQOD-0005BL-RZ
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572351260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+M+SoJVKzLiiU9CVyOPhKH2APlRYKHcXYrLPeb//G8M=;
 b=QvNs5arYLwaE+AEiorgVYIxxenFa8tL1besciLybNelYLoEm2BcQmNDBgvSQQS/2WqXBoA
 5bHdqZcMoUDrfbcZVpZMQ605+2EJpBINvW9cIV5uU19PYT94/iHWFH7PhHlWE7V77efdeq
 2E4tFxVU3qJr0GC6PTJGAoFbUNTLTpE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-JeL1sQEPMiOUbBJbzUFYCA-1; Tue, 29 Oct 2019 08:14:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B659107AD28;
 Tue, 29 Oct 2019 12:14:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E01486012C;
 Tue, 29 Oct 2019 12:14:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4F9DB11385C9; Tue, 29 Oct 2019 13:13:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v6 06/11] qapi: add failover negotiated event
References: <20191025121930.6855-1-jfreimann@redhat.com>
 <20191025121930.6855-7-jfreimann@redhat.com>
 <87wocsrkfp.fsf@dusky.pond.sub.org>
 <20191025173921.n6rk24uxnhuibgrc@jenstp.localdomain>
Date: Tue, 29 Oct 2019 13:13:58 +0100
In-Reply-To: <20191025173921.n6rk24uxnhuibgrc@jenstp.localdomain> (Jens
 Freimann's message of "Fri, 25 Oct 2019 19:39:21 +0200")
Message-ID: <87h83rsq9l.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: JeL1sQEPMiOUbBJbzUFYCA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, alex.williamson@redhat.com, laine@redhat.com,
 ailan@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jens Freimann <jfreimann@redhat.com> writes:

> On Fri, Oct 25, 2019 at 04:03:54PM +0200, Markus Armbruster wrote:
>>Bear with me, I know next to nothing about failover.
>>
>>Jens Freimann <jfreimann@redhat.com> writes:
>>
>>> This event is sent to let libvirt know that VIRTIO_NET_F_STANDBY featur=
e
>>> was enabled. The primary device this virtio-net device is associated
>>> with, will now be hotplugged via qdev_device_add().
>>
>>Passive voice deftly avoids telling the reader who will do the
>>hot-plugging.  Intentional?
>
> Not really, it's in the comment to the event. The hotplug will be
> done by the virtio-net device code that activates the feature, in
> virtio_net_set_features().

If you need to respin, I suggest to work this bit of information into
the commit message.

>>> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>>> Acked-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>  qapi/net.json | 19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>
>>> diff --git a/qapi/net.json b/qapi/net.json
>>> index 728990f4fb..ea6eeee4f7 100644
>>> --- a/qapi/net.json
>>> +++ b/qapi/net.json
>>> @@ -737,3 +737,22 @@
>>>  ##
>>>  { 'command': 'announce-self', 'boxed': true,
>>>    'data' : 'AnnounceParameters'}
>>> +
>>> +##
>>> +# @FAILOVER_NEGOTIATED:
>>> +#
>>> +# Emitted when VIRTIO_NET_F_STANDBY was enabled during feature negotia=
tion.
>>> +# Failover primary devices which were hidden (not hotplugged when requ=
ested)
>>> +# before will now be hotplugged by the virtio-net standby device.
>>> +#
>>> +# device-id: QEMU device id of the unplugged device
>>
>>@device-id is new since v5.
>>
>>A quick skim of
>>https://www.kernel.org/doc/html/latest/networking/net_failover.html
>>tells me there are three devices involved: master, primary slave,
>>standby slave.  Which one is @device-id?  Or am I confused?
>
> Yes, the device-id is new and it's the device-id of the standby (i.e.
> virtio-net) device.

Would working this into the doc comment make it clearer?


