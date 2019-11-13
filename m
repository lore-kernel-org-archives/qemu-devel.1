Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12905C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:57:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17F3222C9
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlQXYg8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17F3222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUu5E-0002WW-1m
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 09:57:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jdenemar@redhat.com>) id 1iUttI-00052g-Dh
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:45:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jdenemar@redhat.com>) id 1iUttG-0000ng-9U
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:45:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57969
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jdenemar@redhat.com>) id 1iUttG-0000nI-4A
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:45:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573656301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iXZqSVes3VY3F7HqcZAog3ZOF4SOqtJvJDfz1zq/XJY=;
 b=hlQXYg8w32Jn3J0n6EJwBVNxgGBzUCjb8t7e/I9+6mxFLld0C6DXtlV8u6Dt+ya85j6MMg
 4oQf9rL+3VOex7TFOcAxqkijPhPTvPp4XkwGCVE0kEJLoxRiahlUU7fUFsG0zSpLft29cu
 b9RAoPjwAFzth6gFQRX47ZmbkMAiidQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-IzETOaiYNXmxGtdaUyQsIQ-1; Wed, 13 Nov 2019 09:43:50 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C5661005502;
 Wed, 13 Nov 2019 14:43:49 +0000 (UTC)
Received: from virval.usersys.redhat.com (unknown [10.43.2.188])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6806360317;
 Wed, 13 Nov 2019 14:43:46 +0000 (UTC)
Received: by virval.usersys.redhat.com (Postfix, from userid 500)
 id 8938810ADD2; Wed, 13 Nov 2019 15:43:44 +0100 (CET)
Date: Wed, 13 Nov 2019 15:43:44 +0100
From: Jiri Denemark <jdenemar@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] spapr/kvm: Set default cpu model for all machine classes
Message-ID: <20191113144344.GA4204@orkuz.int.mamuti.net>
References: <20191030163243.10644-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
In-Reply-To: <20191030163243.10644-1-david@gibson.dropbear.id.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: IzETOaiYNXmxGtdaUyQsIQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: david@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David.

On Wed, Oct 30, 2019 at 17:32:43 +0100, David Gibson wrote:
> We have to set the default model of all machine classes, not just for the
> active one. Otherwise, "query-machines" will indicate the wrong CPU model
> ("qemu-s390x-cpu" instead of "host-s390x-cpu") as "default-cpu-type".
>=20
> s390x already fixed this in de60a92e "s390x/kvm: Set default cpu model fo=
r
> all machine classes".  This patch applies a similar fix for the pseries-*
> machine types on ppc64.
>=20
> Doing a
>     {"execute":"query-machines"}
> under KVM now results in
>     {
>       "hotpluggable-cpus": true,
>       "name": "pseries-4.2",
>       "numa-mem-supported": true,
>       "default-cpu-type": "host-powerpc64-cpu",
>       "is-default": true,
>       "cpu-max": 1024,
>       "deprecated": false,
>       "alias": "pseries"
>     },
>     {
>       "hotpluggable-cpus": true,
>       "name": "pseries-4.1",
>       "numa-mem-supported": true,
>       "default-cpu-type": "host-powerpc64-cpu",
>       "cpu-max": 1024,
>       "deprecated": false
>     },
>     ...
>=20
> Libvirt probes all machines via "-machine none,accel=3Dkvm:tcg" and will
> currently see the wrong CPU model under KVM.

Will this patch make it into 4.2.0?

Jirka


