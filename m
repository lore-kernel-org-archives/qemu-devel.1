Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F38CA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 10:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F240D20862
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 10:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idNvUNSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F240D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPkvT-0001z7-5C
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 06:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iPkuq-0001ZS-TB
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 06:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iPkuo-0004oD-BF
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 06:09:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26107
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iPkun-0004lp-8m
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 06:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572430160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j0NSK6q9NKcx+QdBfau6X0CtvNLSki+zl80xrUSqZ8A=;
 b=idNvUNSHJ/0JhZeGx92coSzoDHu7CnoDUNmy/WrNJRREi5hNenMvJazZ6mHUSRG3DoxYhY
 srOTnya3w4NFnPgLfiJrrzGLMswyWlgCe/qhv/FmOJzCzOVirWEltQ1ScAZphqpnkqCdY1
 Do7+OFaoPdwp27gOJogigCwiuPr61Z4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-S49wYXrdPem2vYF3l9kjfw-1; Wed, 30 Oct 2019 06:09:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F9B82A0;
 Wed, 30 Oct 2019 10:09:15 +0000 (UTC)
Received: from localhost (unknown [10.36.118.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE57560C4B;
 Wed, 30 Oct 2019 10:09:07 +0000 (UTC)
Date: Wed, 30 Oct 2019 11:09:05 +0100
From: Jens Freimann <jfreimann@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 06/11] qapi: add failover negotiated event
Message-ID: <20191030100905.bqt4lblr2gg7zbjr@jenstp.localdomain>
References: <20191025121930.6855-1-jfreimann@redhat.com>
 <20191025121930.6855-7-jfreimann@redhat.com>
 <87wocsrkfp.fsf@dusky.pond.sub.org>
 <20191025173921.n6rk24uxnhuibgrc@jenstp.localdomain>
 <20191029184036-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191029184036-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: S49wYXrdPem2vYF3l9kjfw-1
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 aadam@redhat.com, jasowang@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, alex.williamson@redhat.com, laine@redhat.com,
 ailan@redhat.com, dgilbert@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 29, 2019 at 06:41:58PM -0400, Michael S. Tsirkin wrote:
>On Fri, Oct 25, 2019 at 07:39:21PM +0200, Jens Freimann wrote:
>> On Fri, Oct 25, 2019 at 04:03:54PM +0200, Markus Armbruster wrote:
>> > Bear with me, I know next to nothing about failover.
>> >
>> > Jens Freimann <jfreimann@redhat.com> writes:
>> >
>> > > This event is sent to let libvirt know that VIRTIO_NET_F_STANDBY fea=
ture
>> > > was enabled. The primary device this virtio-net device is associated
>> > > with, will now be hotplugged via qdev_device_add().
>> >
>> > Passive voice deftly avoids telling the reader who will do the
>> > hot-plugging.  Intentional?
>>
>> Not really, it's in the comment to the event. The hotplug will be
>> done by the virtio-net device code that activates the feature, in
>> virtio_net_set_features().
>>
>> >
>> > > Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>> > > Acked-by: Cornelia Huck <cohuck@redhat.com>
>> > > ---
>> > >  qapi/net.json | 19 +++++++++++++++++++
>> > >  1 file changed, 19 insertions(+)
>> > >
>> > > diff --git a/qapi/net.json b/qapi/net.json
>> > > index 728990f4fb..ea6eeee4f7 100644
>> > > --- a/qapi/net.json
>> > > +++ b/qapi/net.json
>> > > @@ -737,3 +737,22 @@
>> > >  ##
>> > >  { 'command': 'announce-self', 'boxed': true,
>> > >    'data' : 'AnnounceParameters'}
>> > > +
>> > > +##
>> > > +# @FAILOVER_NEGOTIATED:
>> > > +#
>> > > +# Emitted when VIRTIO_NET_F_STANDBY was enabled during feature nego=
tiation.
>> > > +# Failover primary devices which were hidden (not hotplugged when r=
equested)
>> > > +# before will now be hotplugged by the virtio-net standby device.
>> > > +#
>> > > +# device-id: QEMU device id of the unplugged device
>> >
>> > @device-id is new since v5.
>> >
>> > A quick skim of
>> > https://www.kernel.org/doc/html/latest/networking/net_failover.html
>> > tells me there are three devices involved: master, primary slave,
>> > standby slave.  Which one is @device-id?  Or am I confused?
>>
>> Yes, the device-id is new and it's the device-id of the standby (i.e.
>> virtio-net) device.
>>
>> regards,
>> Jens
>
>And now I am confused.
>How is standby "the unplugged device"?
>Why not just say "the standby device"?

Yes, that's better. Do you want a patch on top?

diff --git a/qapi/net.json b/qapi/net.json
index ea6eeee4f7..0f225cb900 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -745,7 +745,7 @@
 # Failover primary devices which were hidden (not hotplugged when requeste=
d)
 # before will now be hotplugged by the virtio-net standby device.
 #
-# device-id: QEMU device id of the unplugged device
+# device-id: QEMU device id of the standby device
 # Since: 4.2
 #
 # Example:


Signed-off-by: Jens Freimann <jfreimann@redhat.com>

regards,
Jens=20

>
>--=20
>MST


