Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C027C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1474E20CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNCPO0Z4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1474E20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSgz-0004lE-6q
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40500 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jQSg2-0004CW-Bk
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:25:18 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jQSg1-00039o-85
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:25:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34881
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jQSg0-00037b-MT
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587374715;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JrlOmzbNXPhWWKQxKIf0lYPtQ7X7s7L/yzJ7wOrgMKY=;
 b=XNCPO0Z4J0hVq03jdSiljFgeJRBnwR74VY9TCPfwEurMdE9eRAn7mhepzDPgOEtmsSbO9B
 OkNIaxCruT3W3uRyv6BUrlNEjjAnaJBKRpJtD2RpgwLoT8oc6GMszBC5MuC0fVuPVF4eEf
 yTVpNJTc3RsS/QaNDdwl5Qjn8Oyzenc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-j4zIN6E2OQGSWc_K2MxDpA-1; Mon, 20 Apr 2020 05:25:13 -0400
X-MC-Unique: j4zIN6E2OQGSWc_K2MxDpA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4FEA800D53;
 Mon, 20 Apr 2020 09:25:11 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1C7727BD9;
 Mon, 20 Apr 2020 09:25:02 +0000 (UTC)
Date: Mon, 20 Apr 2020 10:24:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Message-ID: <20200420092459.GF346737@redhat.com>
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
 <20200417112620-mutt-send-email-mst@kernel.org>
 <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
 <20200417120732-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200417120732-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 01:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Ani Sinha <ani.sinha@nutanix.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 17, 2020 at 12:09:00PM -0400, Michael S. Tsirkin wrote:
> On Fri, Apr 17, 2020 at 03:36:14PM +0000, Ani Sinha wrote:
> >=20
> >=20
> > > On Apr 17, 2020, at 8:57 PM, Michael S. Tsirkin <mst@redhat.com> wrot=
e:
> > >=20
> > > Is there a real reason to do this? Can't we just limit the
> > > hotplug control to pcie ports? At some point I'd like us to
> > > start leaving piix alone..
> >=20
> > Yes we really need this feature as want to be able to hot plug devices =
into the guest but prevent customers from hot unplugging them from say Wind=
ows system tray.
> >=20
> > ani
>=20
> Problem is, I think this is not something we can support with pcie or shp=
c.
> I'm reluctant to add features that only ACPI can support,
> we are trying to phase that out.

From the upstream POV, there's been no decision / agreement to phase
out PIIX, this is purely a RHEL downstream decision & plan. If other
distros / users have a different POV, and find the feature useful, we
should accept the patch if it meets the normal QEMU patch requirements.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


