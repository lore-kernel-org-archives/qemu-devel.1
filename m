Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4D7CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C017204EF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHrtNCQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C017204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYs39-0005ss-QS
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 10:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYs2O-0004b7-7o
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:07:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44487
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYs2M-0004XD-HK
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589378824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cWNnZZ+pJ3iXnWhZcXVUnPOA0wyg0BUkNnNSeveLbN8=;
 b=FHrtNCQ9hInuCM4/IduDK41NWUXV6V8t6rTrU/T5rTXRbLymcoGIh+wsOUuBhC1RVc4TBB
 AnxYd4D59waeVXmu6r+RTAmOIY0ZWbsqQDoblQy75hnYVhtfy5a2CdsnXxFdV7d8j43UFw
 ryWySnkAnTIG+pkP4Z1IGyrfw/b6OAM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-qMH-H5d_NtSm040c023zXA-1; Wed, 13 May 2020 10:07:03 -0400
X-MC-Unique: qMH-H5d_NtSm040c023zXA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C573A83DC0F;
 Wed, 13 May 2020 14:07:01 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-80.ams2.redhat.com [10.36.114.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 95F696A979;
 Wed, 13 May 2020 14:06:51 +0000 (UTC)
Date: Wed, 13 May 2020 16:06:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 0/5] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200513140650.GH6202@linux.fritz.box>
References: <20200511121714.GL1135885@redhat.com>
 <20200511154645.GI2811@work-vm> <20200512113206.62836e44@luklap>
 <20200512094337.GK1191162@redhat.com>
 <20200513103245.GD6202@linux.fritz.box>
 <20200513105359.GF3225@work-vm>
 <20200513111320.GE6202@linux.fritz.box>
 <20200513125624.GJ3225@work-vm>
 <20200513130849.GD1253949@redhat.com>
 <20200513134856.GK3225@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200513134856.GK3225@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Lukas Straub <lukasstraub2@web.de>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 13.05.2020 um 15:48 hat Dr. David Alan Gilbert geschrieben:
> * Daniel P. Berrangé (berrange@redhat.com) wrote:
> > On Wed, May 13, 2020 at 01:56:24PM +0100, Dr. David Alan Gilbert wrote:
> > > * Kevin Wolf (kwolf@redhat.com) wrote:
> > > > I guess it would be nice to have a single namespace for everything in
> > > > QEMU, but the reality is that we have a few separate ones. As long as we
> > > > consistently add a prefix that identifies the namespace in question, I
> > > > think that would work.
> > > 
> > > > This means that if we're using node-name to identify the NBD connection,
> > > > the namespace should be 'block' rather than 'nbd'.
> > > > 
> > > > One more thing to consider is, what if a single object has multiple
> > > > connections? In the case of node-names, we have a limited set of allowed
> > > > characters, so we can use one of the remaining characters as a separator
> > > > and then suffix a counter. In other places, the identifier isn't
> > > > restricted, so suffixing doesn't work. Maybe prefixing does, but it
> > > > would have to be there from the beginning then.
> > > 
> > > Yeh I worry about whether on nbd if you can have multiple nbd
> > > connections to one block device.
> > 
> > The kernel NBD driver now supports multiple parallel connections.
> > QEMU hasn't implemented this in its NBD code yet, but I certainly
> > see that being in scope for future.
> 
> It's not parallel for performance that worries me, it's more about
> separateq connections for separate uses - e.g. if we're serving the same
> read-only disk to multiple separate things.

That would be a concern for the NBD server. I'm not sure if anything in
QEMU ever waits for NBD servers (except for the client on the other side
of the connection, of course), so there might be no use case for yanking
their connections.

Anyway, here we were talking about the NBD client, which always accesses
one disk. If you access a second disk, you have a second NBD block node.

Kevin


