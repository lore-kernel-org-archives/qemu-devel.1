Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B38C32767
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 18:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E439222C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 18:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRIo+/Pj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E439222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inReB-0003BE-8O
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 13:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1inRdO-0002d9-UO
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 13:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1inRdN-0006qW-9R
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 13:25:18 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59559
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1inRdN-0006jM-3e
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 13:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578075915;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Io05Il7tShveRA1C28MAX44M/J/nguwT9QqCFEw2Pgk=;
 b=VRIo+/PjQ9XE1QWoYvD/BdMw0Pl0vqzE5thl+BISUb0NP2rhfQScTs6psHfjRzJ3Frb+Gh
 tqDZH4t4R1+QJgDXMKZw9fSajImeQPR055hwnwhY1qlBFQhg1m4P4cabZjFIBfg0pllAFY
 llplMpodjsrZbS19VySTzxOONMKkydQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-5vwxHz6aMUSjxsqjucMT4A-1; Fri, 03 Jan 2020 13:25:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04735113784E
 for <qemu-devel@nongnu.org>; Fri,  3 Jan 2020 18:25:13 +0000 (UTC)
Received: from redhat.com (ovpn-116-61.ams2.redhat.com [10.36.116.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A69A5C548;
 Fri,  3 Jan 2020 18:25:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 01/10] migration: Increase default number of multifd
 channels to 16
In-Reply-To: <20200103165832.GU2753983@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Fri, 3 Jan 2020 16:58:32 +0000")
References: <20191218020119.3776-1-quintela@redhat.com>
 <20191218020119.3776-2-quintela@redhat.com>
 <20200103165832.GU2753983@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 03 Jan 2020 19:25:08 +0100
Message-ID: <87mub4xurf.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 5vwxHz6aMUSjxsqjucMT4A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Wed, Dec 18, 2019 at 03:01:10AM +0100, Juan Quintela wrote:
>> We can scale much better with 16, so we can scale to higher numbers.
>
> What was the test scenario showing such scaling ?

On my test hardware, with 2 channels we can saturate around 8Gigabit max,
more than that, and the migration thread is not fast enough to fill the
network bandwidth.

With 8 that is enough to fill whatever we can find.
We used to have a bug where we were getting trouble with more channels
than cores.  That was the initial reason why the default was so low.

So, pros/cons are:
- have low value (2).  We are backwards compatible, but we are not using
  all  bandwith.  Notice that we will dectect the error before 5.0 is
  out and print a good error message.

- have high value (I tested 8 and 16).  Found no performance loss when
  moving to lower bandwidth limits, and clearly we were able to saturate
  the higher speeds (I tested on localhost, so I had big enough bandwidth)


> In the real world I'm sceptical that virt hosts will have
> 16 otherwise idle CPU cores available that are permissible
> to use for migration, or indeed whether they'll have network
> bandwidth available to allow 16 cores to saturate the link.

The problem here is that if you have such a host, and you want to have
high speed migration, you need to configure it.  My measumermets are
that high number of channels don't affect performance with low
bandwidth, but low number of channels affect performance with high
bandwidth speed.

So, if we want to have something that works "automatically" everywhere,
we need to put it to at least 8.  Or we can trust that management app
will do the right thing.

If you are using a low value of bandwidth, the only difference with 16
channels is that you are using a bit more memory (just the space for the
stacks) and that you are having less contention for the locks (but with
low bandwidth you are not having contention anyways).

So,  I think that the question is:
- What does libvirt prefferes
- What does ovirt/openstack preffer
- Do we really want that the user "have" to configure that value

I don't really care one way or another.

Thanks, Juan.

PD.  On next patch submission I will make it be 2 for old machine types,
     it is not difficult and makes the backward compatibility problem go
     away.


