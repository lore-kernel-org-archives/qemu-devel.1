Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772C7C282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 20:09:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44DF620848
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 20:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBiAx8kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DF620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iovAX-0007fz-D9
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 15:09:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iov9q-0007ER-Of
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 15:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iov9p-0008TU-2m
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 15:08:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20399
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iov9o-0008SE-S1
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 15:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578427731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y2ElaKXdDGGlXjc9uodQZjWUbMDPdPW0gdESi63ud/0=;
 b=gBiAx8kj6K8wCtNOpSpAULEy5137JGHCQ0XeElIq1FYW0CmJTizMWTw3EQYmoXPdCJ+Pby
 77TPB78pJtj85vh4NkWBdzH8LgvVlxVnAKu6AoaNIIe1FS/dtZKvkpuVMCJMkDfajDMugC
 VcNSef3S99W35qMANW5dG4wDJzOtjGM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-4if0RUnUP5-Mgfk8Xi13HQ-1; Tue, 07 Jan 2020 15:08:48 -0500
Received: by mail-qt1-f197.google.com with SMTP id r9so554131qtc.4
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 12:08:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MEPTq3gn4dEs7XVvVikR+9Dv4xrKnvFn2OYwnTVG0SA=;
 b=pHR6ccxV1QegTmTlC5W4foVFclQQsDypiidXhpJ1SLEUKO1jtw2LRF1M8AoEqPK59e
 I72kYzBLurOs0vjnsiIhbmWXSK+jxJF+XgNjNSm7sXp/Dalc2yDQzEeYmcIBiA9b0chO
 rKVOn5opqsOD4sgHs29B1wuaIhL/p+TcgkefZgQS0OiiOJXvTy8ezfIL0R5a7N1vcqoH
 GqKyc8MMNYz6iWBvF9EyLrSf+EwzRgtGzwPp7IlSkuzkntkV/GFTkKxYTMoEFpVpUPdO
 ZvN41X9wUR2j6JLeUJarwo1QH7v3UwzWPfr3xTCfu9ONr1aHe+lHBelnLWNGqCytHFr1
 o81A==
X-Gm-Message-State: APjAAAVumltmSymUyq12YHYrPAMyyWsd7UG1IIITetPD3hhEFH2r8rgr
 1zLdwcjxCgWYEqgoRdDlhi1/Gan7agLlztMJdIN8jNCmGmaPuJXByyz+abPfTNr3Zj9U18hKVM7
 tGK131c7PN5D80EY=
X-Received: by 2002:ad4:4949:: with SMTP id o9mr1028083qvy.189.1578427728300; 
 Tue, 07 Jan 2020 12:08:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqyk3g1CWoyhDOhKhmNsuxQizqdvXZtbjGlUnHNjL9uV1eMU7f905Ugscu5mLlxuybR/LMxkAw==
X-Received: by 2002:ad4:4949:: with SMTP id o9mr1028064qvy.189.1578427728119; 
 Tue, 07 Jan 2020 12:08:48 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id l184sm321442qkc.107.2020.01.07.12.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 12:08:47 -0800 (PST)
Date: Tue, 7 Jan 2020 15:08:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [RFC PATCH 0/1] Removing RAMBlocks during migration
Message-ID: <20200107150301-mutt-send-email-mst@kernel.org>
References: <20191209074102.5926-1-yury-kotov@yandex-team.ru>
 <20191211111655.GC3875@work-vm>
 <279541577091067@sas1-eb34c5849710.qloud-c.yandex.net>
 <20200103114427.GD3804@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200103114427.GD3804@work-vm>
X-MC-Unique: 4if0RUnUP5-Mgfk8Xi13HQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>, jusual@redhat.com,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 03, 2020 at 11:44:27AM +0000, Dr. David Alan Gilbert wrote:
> > 1) Guest: writes to slot's pci config
> > 2) QEMU: pcie_cap_slot_write_config -> pcie_unplug_device
> >=20
> > So, it's only guest driven action and qdev_unplug doesn't help here.
>=20
> Hmm we need to find a way to stop that; lets see if Michael Tsirkin has
> any ideas (cc'd) - I'm thinking if we could defer the unplug until the
> end of the migration we'd be OK; but it feels racy as to whether the
> destination is started with the device that the guest is unplugging.
>=20
> Dave

It's true - and same is possible with PCI, guest can remove device
at will.

Also, while libvirt learned not to start device del while migration
is active, it's annoying to have to wait for device del
to complete before migration can be started.

I guess we can make device invisible to guest - that concept
now exists because of failover, and can maybe be reused here.

Alternatively or additionally - for a while now I wanted to only remove
the device if guest powered it out and removal was requested.  Again it
might be easier now that we have a concept of an invisible device.



--=20
MST


