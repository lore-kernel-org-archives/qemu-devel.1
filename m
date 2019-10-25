Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD6DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112E221872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRcqjpYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112E221872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO6b2-0007cZ-0J
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 16:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iO6Ys-0001YA-0Y
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iO6Yo-0000tV-Dx
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:51:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20005
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iO6Yn-0000rt-Ck
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572036707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0zdJM+j/S0pkEGKaC7KAZkX9S1Is+6y3InNUmPexgOY=;
 b=gRcqjpYd1sS6PPQjJSErl7BLAHe+ZaaFkmJCqx+hnQ8P13kDmwSwMGUAMakERomW4v3riR
 H4l4Zdj/+3hoPD21h6DvPoXt0op3lPCH59x7WrXEtL976+O1RJvtu0EGmS919bAioNrOAE
 VV5BKw2TFMjuzNz9cJG23TmxUdIzk5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-MK4hVMBuMWy9Vb50zpYWQw-1; Fri, 25 Oct 2019 16:51:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E2AC800D41;
 Fri, 25 Oct 2019 20:51:43 +0000 (UTC)
Received: from localhost (ovpn-116-62.gru2.redhat.com [10.97.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 792795D9C9;
 Fri, 25 Oct 2019 20:51:42 +0000 (UTC)
Date: Fri, 25 Oct 2019 17:51:41 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v13 06/12] numa: Extend CLI to provide memory latency and
 bandwidth information
Message-ID: <20191025205141.GF6744@habkost.net>
References: <20191020111125.27659-1-tao3.xu@intel.com>
 <20191020111125.27659-7-tao3.xu@intel.com>
 <20191023172854.42c495d5@redhat.com>
 <9e30d8fe-7274-4ee8-3c4b-64c370141358@intel.com>
 <20191025152720.4068bfae@redhat.com>
 <87wocsobil.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87wocsobil.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: MK4hVMBuMWy9Vb50zpYWQw-1
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
Cc: "Liu, Jingqi" <jingqi.liu@intel.com>, Tao Xu <tao3.xu@intel.com>, "Du,
 Fan" <fan.du@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 25, 2019 at 09:44:50PM +0200, Markus Armbruster wrote:
> Igor Mammedov <imammedo@redhat.com> writes:
>=20
> > On Fri, 25 Oct 2019 14:33:53 +0800
> > Tao Xu <tao3.xu@intel.com> wrote:
> >
> >> On 10/23/2019 11:28 PM, Igor Mammedov wrote:
> >> > On Sun, 20 Oct 2019 19:11:19 +0800
> >> > Tao Xu <tao3.xu@intel.com> wrote: =20
> >> [...]
> >> >> +#
> >> >> +# @access-bandwidth: access bandwidth (MB/s)
> >> >> +#
> >> >> +# @read-bandwidth: read bandwidth (MB/s)
> >> >> +#
> >> >> +# @write-bandwidth: write bandwidth (MB/s) =20
> >> > I think units here are not appropriate, values stored in fields are
> >> > minimal base units only and nothing else (i.e. ps and B/s)
> >> >  =20
> >> Eric suggest me to drop picoseconds. So here I can use ns. For=20
> >> bandwidth, if we use B/s here, does it let user or developer to=20
> >> misunderstand that the smallest unit is B/s ?
> >
> > It's not nanoseconds or MB/s stored in theses fields, isn't it?
> > I'd specify units in which value is stored or drop units altogether.
> >
> > Maybe Eric and Markus can suggest a better way to describe fields.
>=20
> This isn't review (yet), just an attempt to advise more quickly on
> general QAPI/QMP conventions.
>=20
> Unit prefixes like Mebi- are nice for humans, because 1MiB is clearer
> than 1048576B.
>=20
> QMP is for machines.  We eschew unit prefixes and unit symbols there.
> The unit is implied.  Unit prefixes only complicate things.  Machines
> can deal with 1048576 easily.  Also dealing 1024Ki and 1Mi is additional
> work.  We therefore use JSON numbers for byte counts, not strings with
> units.
>=20
> The general rule is "always use the plainest implied unit that would
> do."  There are exceptions, mostly due to review failure.
>=20
> Byte rates should be in bytes per second.
>=20
> For time, we've made a godawful mess.  The plainest unit is clearly the
> second.  We commonly need sub-second granularity, though.
> Floating-point seconds are unpopular for some reason :)  Instead we use
> milli-, micro-, and nanoseconds, and even (seconds, microseconds) pairs.
>=20
> QAPI schema documentation describes both the generated C and the QMP
> wire protocol.  It must be written with the implied unit.  If you send a
> byte rate in bytes per second via QMP, that's what you document.  Even
> if a human interface lets you specify the byte rate in MiB/s.
>=20
> Does this make sense?

This makes sense for the bandwidth fields.  We still need to
decide how to represent the latency field, though.

Seconds would be the obvious choice, if only it didn't risk
silently losing precision when converting numbers to floats.

--=20
Eduardo


