Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395B5CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 19:23:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E2820873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 19:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZYyQ3Fg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E2820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMdHS-0003iD-Vr
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 15:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iMdAx-0005ZY-Jw
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 15:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iMdAu-0005yy-4F
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 15:17:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60367
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iMdAq-0005w8-6w
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 15:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571685418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aX6ZPFoNaRLKITOC+REMrKx5rivFbXNml+IsX4XN8U8=;
 b=QZYyQ3FgjqU2LyqQcfsBCDCK3YNy5Ckb/NqoexhfEZ+lXbOpycgzTCIvWoW+P9DfWAJffs
 LawehN4KBPQZkICyq+oZQRfblfY/+eM+30q7A/wDWv2HmlG2Sta2UJ6e4+QAfEWvQ8djUL
 Il3NW/CeySMmSp1hjGVI5mVWNnnlxL8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-zWjXGDjhPvC2hmvLgnkOYQ-1; Mon, 21 Oct 2019 15:16:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDB8E107AD31;
 Mon, 21 Oct 2019 19:16:53 +0000 (UTC)
Received: from localhost (ovpn-116-91.ams2.redhat.com [10.36.116.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF81160126;
 Mon, 21 Oct 2019 19:16:45 +0000 (UTC)
Date: Mon, 21 Oct 2019 21:16:43 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 11/11] vfio: unplug failover primary device before
 migration
Message-ID: <20191021191643.4stait5u76wijwca@jenstp.localdomain>
References: <20191018202040.30349-1-jfreimann@redhat.com>
 <20191018202040.30349-12-jfreimann@redhat.com>
 <20191021091920.308e7454@x1.home>
MIME-Version: 1.0
In-Reply-To: <20191021091920.308e7454@x1.home>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: zWjXGDjhPvC2hmvLgnkOYQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: pkrempa@redhat.com, berrange@redhat.com, parav@mellanox.com, mst@redhat.com,
 aadam@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, laine@redhat.com,
 ailan@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 21, 2019 at 09:19:20AM -0600, Alex Williamson wrote:
>On Fri, 18 Oct 2019 22:20:40 +0200
>Jens Freimann <jfreimann@redhat.com> wrote:
[...]
>> +    if (!pdev->net_failover_pair_id) {
>> +        error_setg(&vdev->migration_blocker,
>> +                "VFIO device doesn't support migration");
>> +        ret =3D migrate_add_blocker(vdev->migration_blocker, &err);
>> +        if (err) {
>> +            error_propagate(errp, err);
>> +            goto error;
>> +        }
>> +    } else {
>> +            pdev->qdev.allow_unplug_during_migration =3D true;
>
>Why is this unique to vfio-pci, shouldn't any device set as the primary
>for a failover allow unplug during migration, and therefore should it
>be done in the core code rather than device driver?  With the
>net_failover_pair_id set in PCIDevice, I should be able to test with an
>e1000e NIC as primary, but this suggests they wouldn't be handled
>identically elsewhere.  Thanks,

I assume you're talking about pci core code not qdev core. Failover is
pci specific at this time (only the part to hide devices is more
generic and is in qdev code). I can set the flag to allow migration in
pci_qdev_realize().

regards,
Jens=20


