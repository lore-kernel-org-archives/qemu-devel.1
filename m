Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A53CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4451720661
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flHzvxLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4451720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCzP-0004AX-FW
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:48:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ixCxY-0002pn-UL
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ixCxX-0006Xi-2U
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:46:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31685
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ixCxW-0006Wq-Uh
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580402786;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6lHZ6sr/y9rqZ3RLBtC7LXKmLkOQElaxv2JuYk3ZdOE=;
 b=flHzvxLmSa8sst+h3HWJ0kOqk3PdrPWTxXG0/Akj+DPv0PllSOH1437Nc2mg1TOSiZmSmi
 qblrSvROwWUp+h/+HDq8EtNU31RntGOzdtZte39HFAdWnL9itNBkXCQMT9+xX1KQFcwVLQ
 9MM6K+8ljIFXSIEKH03y/QY/cIcQANk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-P1zrVIw0N7qSjmUD4SrqSw-1; Thu, 30 Jan 2020 11:46:24 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31F9C8010F3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 16:46:23 +0000 (UTC)
Received: from redhat.com (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4713F5C54A;
 Thu, 30 Jan 2020 16:46:22 +0000 (UTC)
Date: Thu, 30 Jan 2020 16:46:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v2] git: Make submodule check only needed modules
Message-ID: <20200130164618.GS1891831@redhat.com>
References: <20200130162810.14503-1-quintela@redhat.com>
 <20200130163120.GR1891831@redhat.com>
 <87pnf0c2r8.fsf@secure.laptop>
MIME-Version: 1.0
In-Reply-To: <87pnf0c2r8.fsf@secure.laptop>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: P1zrVIw0N7qSjmUD4SrqSw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 30, 2020 at 05:44:59PM +0100, Juan Quintela wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > On Thu, Jan 30, 2020 at 05:28:10PM +0100, Juan Quintela wrote:
> >> If one is compiling more than one tree from the same source, it is
> >> possible that they need different submodules.  Change the check to see
> >> that all modules that we are interested in are updated, discarding the
> >> ones that we don't care about.
> >>=20
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >>=20
> >
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
> Should I send the pull request?

Sure, I'm was leaving this for the "Misc queue" maintainer but if yuou
want it sooner....

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


