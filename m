Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8069CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 20:35:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC2620659
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 20:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZOwnKTLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC2620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNNMB-0001dt-2X
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 16:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iNNIS-0007oB-9N
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 16:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iNNIP-0007lr-Pa
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 16:31:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40970
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iNNIP-0007lj-Fa
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 16:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571862711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0ByoxOI47HUVV3oa3QKrU7w/LSshe0fJ+JKePZDklQ=;
 b=ZOwnKTLRWAgQxWmbdFQYRdwPdVlKBodMmUZWHoMQoO4RrcrbsfxevRT29ebDrBuencWro9
 BL+KpJAnu+TMioANlC6YJZOMsl2hZYMLcDnpscdURufHYSzmjHFYCKcY/DAXeshhcSaGcG
 QPdw8SEeXhQnivnoVgO2ntf7DVALo0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-rZ2kYfgjP62BNoUfG4N0mw-1; Wed, 23 Oct 2019 16:31:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E246B800D5A;
 Wed, 23 Oct 2019 20:31:46 +0000 (UTC)
Received: from localhost (ovpn-116-38.ams2.redhat.com [10.36.116.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D46A45DE5B;
 Wed, 23 Oct 2019 20:31:39 +0000 (UTC)
Date: Wed, 23 Oct 2019 22:31:37 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v5 02/11] pci: add option for net failover
Message-ID: <20191023203137.meh3edoudxulecys@jenstp.localdomain>
References: <20191023082711.16694-1-jfreimann@redhat.com>
 <20191023082711.16694-3-jfreimann@redhat.com>
 <20191023120648.57e50ae1@x1.home>
 <20191023193035.tlcumzmgjw242hgw@jenstp.localdomain>
 <20191023140211.4ada7ff3@x1.home>
MIME-Version: 1.0
In-Reply-To: <20191023140211.4ada7ff3@x1.home>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: rZ2kYfgjP62BNoUfG4N0mw-1
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
 mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 laine@redhat.com, ailan@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 23, 2019 at 02:02:11PM -0600, Alex Williamson wrote:
>On Wed, 23 Oct 2019 21:30:35 +0200
>Jens Freimann <jfreimann@redhat.com> wrote:
>
>> On Wed, Oct 23, 2019 at 12:06:48PM -0600, Alex Williamson wrote:
>> >On Wed, 23 Oct 2019 10:27:02 +0200
>> >Jens Freimann <jfreimann@redhat.com> wrote:
[...]
>> >Are there also multi-function considerations that
>> >should be prevented or documented?  For example, if a user tries to
>> >configure both the primary and failover NICs in the same slot, I assume
>> >bad things will happen.
>>
>>   I would have expected that this is already checked in pci code, but
>> it is not. I tried it and when I put both devices into the same slot
>> they are both unplugged from the guest during boot but nothing else
>> happens. I don't know what triggers that unplug of the devices.
>>
>> I'm not aware of any other problems regarding multi-function, which
>> doesn't mean there aren't any.
>
>Hmm, was the hidden device at function #0?  The guest won't find any
>functions if function #0 isn't present, but I don't know what would
>trigger the hotplug.  The angle I'm thinking is that we only have slot
>level granularity for hotplug, so any sort of automatic hotplug of a
>slot should probably think about bystander devices within the slot.

Yes that would be a problem, but isn't it the same in the non-failover case
where a user configures it wrong? The slot where the device is plugged is n=
ot
chosen automatically it's configured by the user, no? I might be mixing som=
ething
up here.  I have no idea yet how to check if a slot is already populated, b=
ut
I'll think about it.=20

Thanks!

regards,
Jens=20


