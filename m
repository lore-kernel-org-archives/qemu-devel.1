Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DECC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 08:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0732B206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 08:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9mPWEWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0732B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc3Kk-0002ep-5M
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 04:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jc3Jw-0001r3-MJ
 for qemu-devel@nongnu.org; Fri, 22 May 2020 04:46:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59662
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jc3Jv-0005PZ-AR
 for qemu-devel@nongnu.org; Fri, 22 May 2020 04:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590137181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CGXnrVNBCoFMrQmmg6tmuxZlXBPSqj03oTy4t4te9HA=;
 b=h9mPWEWBJOWPkgZRrEJ/r5p15uFrgv85WOTjAW2h2S633EhE/yTw9b+GbXB9W+i46JYYMv
 O9EjIsoV1egx7gh1jhGn9BBQsVgechpelF19tZiX71pN1xIovyySWMpn5yaohsbqB2Kb5w
 aV5RXflXpfMc1p1rjlosp5xW6F6B/TE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-D7pbQHj8OaKik2pTx7nApA-1; Fri, 22 May 2020 04:46:19 -0400
X-MC-Unique: D7pbQHj8OaKik2pTx7nApA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBAB218FE864;
 Fri, 22 May 2020 08:46:17 +0000 (UTC)
Received: from nas.mammed.net (unknown [10.40.193.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 750CB10016E8;
 Fri, 22 May 2020 08:46:16 +0000 (UTC)
Date: Fri, 22 May 2020 10:46:13 +0200
From: Igor Mammedow <imammedo@redhat.com>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 5/8] cpus-common: ensure auto-assigned cpu_indexes
 don't clash
Message-ID: <20200522104613.779a4b68@nas.mammed.net>
In-Reply-To: <874ks9fc33.fsf@linaro.org>
References: <20200513173200.11830-1-alex.bennee@linaro.org>
 <20200513173200.11830-6-alex.bennee@linaro.org>
 <87y2pucwhi.fsf@linaro.org> <20200521175303.74faabe2@redhat.com>
 <874ks9fc33.fsf@linaro.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 04:25:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Nikolay Igotti <igotti@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 May 2020 18:10:40 +0100
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> Igor Mammedov <imammedo@redhat.com> writes:
>=20
> > On Thu, 14 May 2020 17:27:53 +0100
> > Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> > =20
> >> a
> >> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
> >>  =20
> >> > Basing the cpu_index on the number of currently allocated vCPUs
> >> > fails when vCPUs aren't removed in a LIFO manner. This is
> >> > especially true when we are allocating a cpu_index for each
> >> > guest thread in linux-user where there is no ordering constraint
> >> > on their allocation and de-allocation.
> >> >
> >> > [I've dropped the assert which is there to guard against
> >> > out-of-order removal as this should probably be caught higher up
> >> > the stack. Maybe we could just ifdef CONFIG_SOFTTMU it?] =20
> >
> > for machines where we care about cross version migration
> > (arm/virt,s390,x86,spapr), we do manual cpu_index assignment on
> > keep control on its stability So orderining probably shouldn't
> > matter for other softmmu boards, but what I'd watch for is arrays
> > within devices where cpu_index is used as index =20
>=20
> With the updated version for softmmu you should get the same indexes
> as before from startup. It only gets complicated if CPU hotplug is a
> thing which I think is only the case for machines that also support
> migration?
I'd think so, and those do not (should not) use cpu_get_free_index(), so

Acked-by: Igor Mammedow <imammedo@redhat.com>

>=20
> > (ex: would be apic emulation (but its not affected by this patch
> > since x86 control cpu_index assignment)) =20
>=20
> I've just noticed that the gdbstub uses the maximum cpu_index at
> startup to size it's array in CONFIG_USER which is obviously wrong
> but it was wrong before so I guess that's another bug to look into on
> my part :-/
>=20
> >
> > =20
> >> >
> >> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> > Cc: Nikolay Igotti <igotti@gmail.com>
> >> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> > Cc: Igor Mammedov <imammedo@redhat.com>
> >> > Cc: Eduardo Habkost <ehabkost@redhat.com>
> >> > ---
> >> >  cpus-common.c | 9 ++++-----
> >> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >> >
> >> > diff --git a/cpus-common.c b/cpus-common.c
> >> > index 55d5df89237..5a7d2f6132b 100644
> >> > --- a/cpus-common.c
> >> > +++ b/cpus-common.c
> >> > @@ -61,13 +61,14 @@ static bool cpu_index_auto_assigned;
> >> >  static int cpu_get_free_index(void)
> >> >  {
> >> >      CPUState *some_cpu;
> >> > -    int cpu_index =3D 0;
> >> > +    int max_cpu_index =3D 0;
> >> > =20
> >> >      cpu_index_auto_assigned =3D true;
> >> >      CPU_FOREACH(some_cpu) {
> >> > -        cpu_index++;
> >> > +        max_cpu_index =3D MAX(some_cpu->cpu_index, max_cpu_index);
> >> >      }
> >> > -    return cpu_index;
> >> > +    max_cpu_index++;
> >> > +    return max_cpu_index;
> >> >  }   =20
> >>=20
> >> OK some ending up with cpu_index =3D 1 threw off devices that would
> >> do qemu_get_cpu(0) so I've tweaked the algorithm to:
> >>=20
> >>   static int cpu_get_free_index(void)
> >>   {
> >>       CPUState *some_cpu;
> >>       int max_cpu_index =3D 0;
> >>=20
> >>       cpu_index_auto_assigned =3D true;
> >>       CPU_FOREACH(some_cpu) {
> >>           if (some_cpu->cpu_index >=3D max_cpu_index) {
> >>               max_cpu_index =3D some_cpu->cpu_index + 1;
> >>           }
> >>       }
> >>       return max_cpu_index;
> >>   }
> >>  =20
> >> > =20
> >> >  void cpu_list_add(CPUState *cpu)
> >> > @@ -90,8 +91,6 @@ void cpu_list_remove(CPUState *cpu)
> >> >          return;
> >> >      }
> >> > =20
> >> > -    assert(!(cpu_index_auto_assigned && cpu !=3D
> >> > QTAILQ_LAST(&cpus))); -
> >> >      QTAILQ_REMOVE_RCU(&cpus, cpu, node);
> >> >      cpu->cpu_index =3D UNASSIGNED_CPU_INDEX;
> >> >  }   =20
> >>=20
> >>  =20
>=20
>=20


