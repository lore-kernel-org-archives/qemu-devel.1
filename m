Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16EDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 19:12:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C3842086A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 19:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbwhsOCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3842086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k47nD-0007O3-ML
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 15:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k47mc-0006wT-6n
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 15:12:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27537
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k47mZ-0003Ti-5b
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 15:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596827517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTBunuZz6mwpX7IQ3N5LOUOcpl+BRnsKFkoQjQzRQS4=;
 b=GbwhsOCubjzWaLHlC0Ba6R77cVty0/ZthKUiNmLavHVy2nqTljkMrk6G1pKXsj/oJH0vO3
 X8CsSbpD8qwQZatDD8WwgGtYOO3JFa/Bmdh8QOkwV+sdmaa9Nc21X2RkJh39XIrGwuKezU
 afQHOXsmHCajuI4zlpnfG0i13yv3V2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-Ank_sGyWMs2oO8RqwCSX8Q-1; Fri, 07 Aug 2020 15:11:56 -0400
X-MC-Unique: Ank_sGyWMs2oO8RqwCSX8Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5BC419067ED;
 Fri,  7 Aug 2020 19:11:54 +0000 (UTC)
Received: from localhost (unknown [10.40.208.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADD278AC16;
 Fri,  7 Aug 2020 19:11:49 +0000 (UTC)
Date: Fri, 7 Aug 2020 21:11:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH v3 2/3] hw/i386: Add a new check to configure smp dies
 for EPYC
Message-ID: <20200807211148.77749e6c@redhat.com>
In-Reply-To: <20200807165222.GB120942@redhat.com>
References: <159681772267.9679.1334429994189974662.stgit@naples-babu.amd.com>
 <159681797161.9679.5653247810916709875.stgit@naples-babu.amd.com>
 <20200807165222.GB120942@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:00:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Babu Moger <babu.moger@amd.com>, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Aug 2020 17:52:22 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Fri, Aug 07, 2020 at 11:32:51AM -0500, Babu Moger wrote:
> > Adding a new check to warn the users to configure 'dies' when
> > topology is numa configured. It makes it easy to build the
> > topology for EPYC models. =20
>=20
> This says you're adding a warning....
>=20
> >=20
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  hw/i386/x86.c |    7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> > index 67bee1bcb8..2a6ce56ef1 100644
> > --- a/hw/i386/x86.c
> > +++ b/hw/i386/x86.c
> > @@ -138,6 +138,13 @@ void x86_cpus_init(X86MachineState *x86ms, int def=
ault_cpu_version)
> > =20
> >      /* Check for apicid encoding */
> >      if (cpu_x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
> > +        if ((ms->numa_state->num_nodes > 0) &&
> > +            ms->numa_state->num_nodes !=3D (ms->smp.sockets * x86ms->s=
mp_dies)) {
> > +            error_setg(&error_fatal, "Numa configuration requires smp =
'dies' "
> > +                       "parameter. Configure the cpu topology properly=
 with "
> > +                       "max_cpus =3D sockets * dies * cores * threads"=
); =20
>=20
> ...but you're actually making this a fatal error, not a warning.
>=20
> I'm not sure this is really OK. Wouldn't this mean that existing VMs
> deployed today, risk triggering this fatal error next time they
> are booted, or live migrated.  If it is possible someone is using
> such a config today, I don't think we can break it.

to begin with, users shouldn't have used 'dies' with initial impl. at all.
(it was Intel introduced option and EPYC's added very similar internal node=
_id
(removed by the next patch)).
Now we are trying to consolidate this mess and reuse dies for EPYC.

EPYC was out in the since with 5.0 (though broken), users could start a VM =
with
such config but that would not be correct EPYC from apicid and cpuid point =
of view.
Guest OS might run if it doesn't know about EPYCs or behave wierdly (sub op=
timal|crash|whatever)
on seeing unexpected values.

If we are hell bound on keeping bugs of initial impl, then we should keep i=
t to 5.1<=3D
machine version and do the right thing for newer ones.
Though I'm not sure we should keep broken variant around (all we would get =
from it is
bug reports*/complains from users with end result of their config anyways).
I'd rather error out with clear error message so user could fix their broke=
n config.

*) there is at least one thread/bz on qemu-devel where users are trying to =
run
with EPYC and pick up options combination so it would produce sensible topo=
logy.


> Regards,
> Daniel


