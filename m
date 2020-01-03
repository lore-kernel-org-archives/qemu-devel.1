Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1826C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 17:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C41920866
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 17:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDflE1nr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C41920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inQW2-0004zv-KK
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 12:13:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1inQVE-00049f-UL
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 12:12:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1inQVC-0003vX-DH
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 12:12:47 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56262
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1inQVB-0003i3-4f
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 12:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578071563;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QEffvvo7Es4RjlDoTyTJ2GskHTOHygG8naX2MvCvuB8=;
 b=FDflE1nrwNXK7HN2aLS0bnRsfIkM8tIUKeyXdDGRyGw+OmwlJdOr0OmLB1e7TsPDUmdu0K
 3NmW6dFEiTLGUS0g+E7URsrJQgZrTylbsc/QFs7CFjI1YhTyOVo4wT9umlJyB1flmI2t4n
 Z2UzPPcNawO4E+SDKIeeYPz4oAFCFXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-dRqCcxrlNmm3ooUT2jpCXw-1; Fri, 03 Jan 2020 12:12:40 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5D48800EB6
 for <qemu-devel@nongnu.org>; Fri,  3 Jan 2020 17:12:38 +0000 (UTC)
Received: from redhat.com (ovpn-112-41.ams2.redhat.com [10.36.112.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACF92387;
 Fri,  3 Jan 2020 17:12:36 +0000 (UTC)
Date: Fri, 3 Jan 2020 17:12:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 01/10] migration: Increase default number of multifd
 channels to 16
Message-ID: <20200103171233.GV2753983@redhat.com>
References: <20191218020119.3776-1-quintela@redhat.com>
 <20191218020119.3776-2-quintela@redhat.com>
 <20200103165832.GU2753983@redhat.com>
 <20200103170114.GO3804@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200103170114.GO3804@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: dRqCcxrlNmm3ooUT2jpCXw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 03, 2020 at 05:01:14PM +0000, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > On Wed, Dec 18, 2019 at 03:01:10AM +0100, Juan Quintela wrote:
> > > We can scale much better with 16, so we can scale to higher numbers.
> >=20
> > What was the test scenario showing such scaling ?
> >=20
> > In the real world I'm sceptical that virt hosts will have
> > 16 otherwise idle CPU cores available that are permissible
> > to use for migration, or indeed whether they'll have network
> > bandwidth available to allow 16 cores to saturate the link.
>=20
> With TLS or compression, the network bandwidth could easily be there.

Yes, but this constant is setting a default that applies regardless of
whether TLS / compression is enabled and/or whether CPU cores are idle.
IOW, there can be cases where using 16 threads will be a perf win, I'm
just questioning the suitability as a global default out of the box.

I feel like what's really lacking with migration is documentation
around the usefulness of the very many parameters, and the various
interesting combinations & tradeoffs around enabling them. So instead
of changing the default threads, can we focusing on improving
documentation so that mgmt apps have good information on which to
make the decision about whether & when to use 2 or 16 or $NNN migration
threads.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


