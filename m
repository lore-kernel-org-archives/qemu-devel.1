Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BD0CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E50742070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdxHxCP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50742070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO3aN-0003Kv-3v
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 13:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iO3Yp-0006JV-JF
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 13:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iO3Yn-0008A2-PJ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 13:39:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46943
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iO3Yn-00083G-LK
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 13:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572025174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8BTsgcn3L1ojTiHekqxVa/Ech3foHI4kj7ZLiwL85SI=;
 b=KdxHxCP7iuZeFMqVD7glw5PLN2cO/WTDR3gw3YMv45zlgRB8eIPqk/85KM3GGCCSI5T4Ry
 iWXAzSw8Jj1meclTNJpatSKIvrRdfQyob5mjVmAOTKAlqovHR6vk74YgidEJrPwHo/8Evn
 NFbeJXhgg/tuDFaLdElxH3Gtv+7xzKQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-CSch7uroM5myBCAjcsjItw-1; Fri, 25 Oct 2019 13:39:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94CF180183D;
 Fri, 25 Oct 2019 17:39:30 +0000 (UTC)
Received: from localhost (ovpn-117-235.ams2.redhat.com [10.36.117.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0923260852;
 Fri, 25 Oct 2019 17:39:22 +0000 (UTC)
Date: Fri, 25 Oct 2019 19:39:21 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 06/11] qapi: add failover negotiated event
Message-ID: <20191025173921.n6rk24uxnhuibgrc@jenstp.localdomain>
References: <20191025121930.6855-1-jfreimann@redhat.com>
 <20191025121930.6855-7-jfreimann@redhat.com>
 <87wocsrkfp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87wocsrkfp.fsf@dusky.pond.sub.org>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: CSch7uroM5myBCAjcsjItw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, alex.williamson@redhat.com, laine@redhat.com,
 ailan@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 25, 2019 at 04:03:54PM +0200, Markus Armbruster wrote:
>Bear with me, I know next to nothing about failover.
>
>Jens Freimann <jfreimann@redhat.com> writes:
>
>> This event is sent to let libvirt know that VIRTIO_NET_F_STANDBY feature
>> was enabled. The primary device this virtio-net device is associated
>> with, will now be hotplugged via qdev_device_add().
>
>Passive voice deftly avoids telling the reader who will do the
>hot-plugging.  Intentional?

Not really, it's in the comment to the event. The hotplug will be
 done by the virtio-net device code that activates the feature, in
virtio_net_set_features().

>
>> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>> Acked-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  qapi/net.json | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/qapi/net.json b/qapi/net.json
>> index 728990f4fb..ea6eeee4f7 100644
>> --- a/qapi/net.json
>> +++ b/qapi/net.json
>> @@ -737,3 +737,22 @@
>>  ##
>>  { 'command': 'announce-self', 'boxed': true,
>>    'data' : 'AnnounceParameters'}
>> +
>> +##
>> +# @FAILOVER_NEGOTIATED:
>> +#
>> +# Emitted when VIRTIO_NET_F_STANDBY was enabled during feature negotiat=
ion.
>> +# Failover primary devices which were hidden (not hotplugged when reque=
sted)
>> +# before will now be hotplugged by the virtio-net standby device.
>> +#
>> +# device-id: QEMU device id of the unplugged device
>
>@device-id is new since v5.
>
>A quick skim of
>https://www.kernel.org/doc/html/latest/networking/net_failover.html
>tells me there are three devices involved: master, primary slave,
>standby slave.  Which one is @device-id?  Or am I confused?

Yes, the device-id is new and it's the device-id of the standby (i.e.
virtio-net) device.

regards,
Jens=20


