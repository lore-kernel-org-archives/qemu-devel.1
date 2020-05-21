Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9DAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D82F206F6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cniwJxnq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D82F206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnWz-00045X-Dh
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jbnVV-0002i2-UT
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:53:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56835
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jbnVU-0002je-9E
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590076392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lXoVBJMwC4KsISdnsK7rGMGb7OpYsdbJxQ5Ni5Ivmz4=;
 b=cniwJxnqxs5je1uZjxv9xnDa3Xk/68evz8I96HVzAQVhsVK48McJS+IleRD/unUSqhm1pT
 u6rK8hE+buca6nNxGkUAAtCEYyVYr12ExsJIRptysPuKAk5i7K98Ry1+ONJz4udlNgJ3k9
 ULYAckmNlisrL78bdL/4FzBE/IRoEK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-iIb33i8pMgmD2EKu0HetMA-1; Thu, 21 May 2020 11:53:11 -0400
X-MC-Unique: iIb33i8pMgmD2EKu0HetMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12A2F1855A02;
 Thu, 21 May 2020 15:53:10 +0000 (UTC)
Received: from localhost (unknown [10.40.208.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10CCC779D4;
 Thu, 21 May 2020 15:53:07 +0000 (UTC)
Date: Thu, 21 May 2020 17:53:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 5/8] cpus-common: ensure auto-assigned cpu_indexes
 don't clash
Message-ID: <20200521175303.74faabe2@redhat.com>
In-Reply-To: <87y2pucwhi.fsf@linaro.org>
References: <20200513173200.11830-1-alex.bennee@linaro.org>
 <20200513173200.11830-6-alex.bennee@linaro.org>
 <87y2pucwhi.fsf@linaro.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 06:06:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Nikolay Igotti <igotti@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 May 2020 17:27:53 +0100
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> a
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>=20
> > Basing the cpu_index on the number of currently allocated vCPUs fails
> > when vCPUs aren't removed in a LIFO manner. This is especially true
> > when we are allocating a cpu_index for each guest thread in
> > linux-user where there is no ordering constraint on their allocation
> > and de-allocation.
> >
> > [I've dropped the assert which is there to guard against out-of-order
> > removal as this should probably be caught higher up the stack. Maybe
> > we could just ifdef CONFIG_SOFTTMU it?]

for machines where we care about cross version migration (arm/virt,s390,x86=
,spapr),
we do manual cpu_index assignment on keep control on its stability
So orderining probably shouldn't matter for other softmmu boards,
but what I'd watch for is arrays within devices where cpu_index is used as =
index
(ex: would be apic emulation (but its not affected by this patch since x86 =
control
cpu_index assignment))


> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Cc: Nikolay Igotti <igotti@gmail.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Igor Mammedov <imammedo@redhat.com>
> > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  cpus-common.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/cpus-common.c b/cpus-common.c
> > index 55d5df89237..5a7d2f6132b 100644
> > --- a/cpus-common.c
> > +++ b/cpus-common.c
> > @@ -61,13 +61,14 @@ static bool cpu_index_auto_assigned;
> >  static int cpu_get_free_index(void)
> >  {
> >      CPUState *some_cpu;
> > -    int cpu_index =3D 0;
> > +    int max_cpu_index =3D 0;
> > =20
> >      cpu_index_auto_assigned =3D true;
> >      CPU_FOREACH(some_cpu) {
> > -        cpu_index++;
> > +        max_cpu_index =3D MAX(some_cpu->cpu_index, max_cpu_index);
> >      }
> > -    return cpu_index;
> > +    max_cpu_index++;
> > +    return max_cpu_index;
> >  } =20
>=20
> OK some ending up with cpu_index =3D 1 threw off devices that would do
> qemu_get_cpu(0) so I've tweaked the algorithm to:
>=20
>   static int cpu_get_free_index(void)
>   {
>       CPUState *some_cpu;
>       int max_cpu_index =3D 0;
>=20
>       cpu_index_auto_assigned =3D true;
>       CPU_FOREACH(some_cpu) {
>           if (some_cpu->cpu_index >=3D max_cpu_index) {
>               max_cpu_index =3D some_cpu->cpu_index + 1;
>           }
>       }
>       return max_cpu_index;
>   }
>=20
> > =20
> >  void cpu_list_add(CPUState *cpu)
> > @@ -90,8 +91,6 @@ void cpu_list_remove(CPUState *cpu)
> >          return;
> >      }
> > =20
> > -    assert(!(cpu_index_auto_assigned && cpu !=3D QTAILQ_LAST(&cpus)));
> > -
> >      QTAILQ_REMOVE_RCU(&cpus, cpu, node);
> >      cpu->cpu_index =3D UNASSIGNED_CPU_INDEX;
> >  } =20
>=20
>=20


