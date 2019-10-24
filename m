Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B31ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 20:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A4C20684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 20:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXJxtrMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A4C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNjLk-0006bt-7z
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 16:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iNjKJ-0003b2-2T
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 16:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iNjKI-00044O-24
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 16:03:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40038
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iNjKH-000441-UU
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 16:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571947397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVnPR+WbSfdpPNCpI2DxSLApEx6zDXS+JspLqhmLKzE=;
 b=GXJxtrMAvTuddiAKf1MhyoVzj5GB6SO/s9ygJSOGv9jwFTcmaZOLVIm3vKHc7g7l+tjdic
 O4nHEkyfMVpHh2kK3N0sJ5JGmqVpe5X0oKeORuiC4W8L3jIDLmbEMWMxFu/aJ+tkvbvHUp
 Dg1VUSRutjKlzEHZq9axuzpOQHBs6AA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-5JSbG5rCONW0JXSPXuYSoQ-1; Thu, 24 Oct 2019 16:03:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFF001800DC7;
 Thu, 24 Oct 2019 20:03:12 +0000 (UTC)
Received: from localhost (ovpn-116-48.ams2.redhat.com [10.36.116.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70DC95D713;
 Thu, 24 Oct 2019 20:03:05 +0000 (UTC)
Date: Thu, 24 Oct 2019 22:03:03 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v5 06/11] qapi: add failover negotiated event
Message-ID: <20191024200303.b6tmvpgyq2wbnmxx@jenstp.localdomain>
References: <20191023082711.16694-1-jfreimann@redhat.com>
 <20191023082711.16694-7-jfreimann@redhat.com>
 <20191024173245.GP2877@work-vm>
MIME-Version: 1.0
In-Reply-To: <20191024173245.GP2877@work-vm>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 5JSbG5rCONW0JXSPXuYSoQ-1
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
 mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 06:32:45PM +0100, Dr. David Alan Gilbert wrote:
>* Jens Freimann (jfreimann@redhat.com) wrote:
>> This event is sent to let libvirt know that VIRTIO_NET_F_STANDBY
>> feature was not negotiated during virtio feature negotiation. If this
>> event is received it means any primary devices hotplugged before
>> this were were never really added to QEMU devices.
>>
>> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>
>Can I just understand a bit more about what the meaning of this is.
>
>Say my VM boots:
>   a) BIOS
>   b) Boot loader
>   c) Linux
>   d) Reboots
>      (possibly a',b', different c')
>
>When would I get that event?
>When can libvirt know it can use it?

The event is sent every time we do feature negotiation for the virtio-net
device, so you'll get it during Linux boot and reboots.

In v6, I add a data field 'id' to the event to pass the device id.=20

regards,
Jens=20


