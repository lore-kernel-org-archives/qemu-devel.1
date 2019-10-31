Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A03CA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 15:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3DC2087F
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 15:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Scd5hrUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3DC2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQCqP-0004m0-Fr
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 11:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iQCkD-00067d-7P
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iQCkB-0008Oo-HK
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:52:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31172
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iQCkB-0008Lk-A6
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572537134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/5SVsKScJzxtB1/7M2yHvL15ehF1kCrtK9L+g/fHU74=;
 b=Scd5hrUF6YkRCIwCeBiDJbfvpVZC8eTURmT18NFvzaGzGi6OBAHVL/1ko5JweFKNOd2dEW
 fTqU5pH6gmmOXaDPiBhtV1C7rEFcaD5sf2lQXvXwrcS1Y7fa8+adzc12hl7cBBTEXe7A78
 AeM8Ii/db0EwnP9jcwty23JGQlceKQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-jbuahQc9Nua-Rwa_QgSjDw-1; Thu, 31 Oct 2019 11:52:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DCAC1800D56;
 Thu, 31 Oct 2019 15:52:08 +0000 (UTC)
Received: from work-vm (ovpn-116-247.ams2.redhat.com [10.36.116.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 264EE19C7F;
 Thu, 31 Oct 2019 15:52:06 +0000 (UTC)
Date: Thu, 31 Oct 2019 15:52:04 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: geoff@hostfission.com
Subject: Re: RFC: New device for zero-copy VM memory access
Message-ID: <20191031155204.GD3128@work-vm>
References: <c83fe0e7157562c3c17598917977eb4d@hostfission.com>
 <20191030185248.GC3114@work-vm>
 <88f1c3701740665b0ebe2f24c8ce7ade@hostfission.com>
 <20191031132443.GB3128@work-vm>
 <b36330ecd38ce872982df4d41d3d4695@hostfission.com>
 <CAFEAcA8uWCQY8GwtH4oHU8ybXsvmYaB4Qa5hnxyd+344WFjJ_Q@mail.gmail.com>
 <b87d5b2fb84ac0a3c98a62dcc0c19077@hostfission.com>
MIME-Version: 1.0
In-Reply-To: <b87d5b2fb84ac0a3c98a62dcc0c19077@hostfission.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: jbuahQc9Nua-Rwa_QgSjDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* geoff@hostfission.com (geoff@hostfission.com) wrote:
>=20
>=20
> On 2019-11-01 01:52, Peter Maydell wrote:
> > On Thu, 31 Oct 2019 at 14:26, <geoff@hostfission.com> wrote:
> > > As the author of Looking Glass, I also have to consider the
> > > maintenance
> > > and the complexity of implementing the vhost protocol into the
> > > project.
> > > At this time a complete Porthole client can be implemented in 150
> > > lines
> > > of C without external dependencies, and most of that is boilerplate
> > > socket code. This IMO is a major factor in deciding to avoid
> > > vhost-user.
> >=20
> > This is essentially a proposal that we should make our project and
> > code more complicated so that your project and code can be simpler.
> > I hope you can see why this isn't necessarily an argument that will hol=
d
> > very much weight for us :-)
>=20
> Certainly, I do which is why I am still going to see about using vhost,
> however, a device that uses vhost is likely more complex then the device
> as it stands right now and as such more maintenance would be involved on
> your end also. Or have I missed something in that vhost-user can be used
> directly as a device?

The basic vhost-user stuff isn't actually that hard;  if you aren't
actually shuffling commands over the queues you should find it pretty
simple - so I think your assumption about it being simpler if you avoid
it might be wrong.  It might be easier if you use it!

Dave

> >=20
> > thanks
> > -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


