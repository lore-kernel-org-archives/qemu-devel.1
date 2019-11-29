Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C376C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 19:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06DA216F4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 19:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQZUPcQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06DA216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iamAO-0002Sf-5p
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 14:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iam1G-0006wH-4K
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:33:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iam1B-0004iv-7p
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:33:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45099
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iam1A-0004bn-MQ
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575056007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QkXV3D+DA5MpXFbhmJwyqaew9poY86ocjGREEzPuPbA=;
 b=HQZUPcQ4Th6RMa6PDbXgZ3vMXzQyPmw5Wz6zBtSAyriWMJYnxXOXD9TyRrT+YOBfcv1uY0
 4lP5DS+2iznZl1R0NmW/f93SoA8Pzj2EtsCtLv85E3Cr/BO3IXsX+T15nGUGzQRrM7hgFj
 wTGeRbPTT8zEf029w5fklh7usxFdxFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-I0Qm5lcyPjSpLAa3e7b_iA-1; Fri, 29 Nov 2019 14:33:23 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99CA980183D;
 Fri, 29 Nov 2019 19:33:22 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD94A600C4;
 Fri, 29 Nov 2019 19:33:19 +0000 (UTC)
Date: Fri, 29 Nov 2019 16:33:17 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 2/2] s390x/cpumodel: Introduce dynamic feature groups
Message-ID: <20191129193317.GE14595@habkost.net>
References: <b062f580-d664-f68c-2364-1f65df6ee265@de.ibm.com>
 <C829F458-099D-4E95-B835-67F008E60B13@redhat.com>
 <b4f4546d-b620-0428-40bf-59f4584a80f3@de.ibm.com>
 <b4ee8526-b1e3-21ee-5e1e-b22520e29339@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b4ee8526-b1e3-21ee-5e1e-b22520e29339@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: I0Qm5lcyPjSpLAa3e7b_iA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: Thomas Huth <thuth@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 26, 2019 at 03:07:32PM +0100, David Hildenbrand wrote:
> On 26.11.19 13:59, Christian Borntraeger wrote:
> > re-adding ccs from the cover-letter
> >=20
> >>>> On 25.11.19 18:20, David Hildenbrand wrote:
> >>>>
> >>>> As soon as dynamic feature groups are used, the CPU model becomes
> >>>> migration-unsafe. Upper layers can expand these models to migration-=
safe
> >>>> and static variants, allowing them to be migrated.
> >>>
> >>> I really dislike that. I am trying to get rid of the unsafe variants =
(e.g. now
> >>> defaulting to host-model instead of host-passthrough). I do not want =
to give
> >>> users new ways of hurting themselves.
> >>>
> >>
> >> Please note that this is just on the bare command line. Libvirt and fr=
iends will expand the model and have proper migration in place. What exactl=
y is your concern in that regard?
> >=20
> > What is then the value? libvirt can also use host-model or  baselining =
if necessary.
> > And for the command line this will just add more opportunity to shot yo=
urself in the
> > foot, no?
>=20
> I don't think so. It's in no way more dangerous than "-cpu host" or
> "-cpu max". And it is in no way more dangerous than the discussed CPU
> versions, where even a "-cpu z13" would no longer be migration-safe.
>=20
> You could - in theory - baseline(z13, host), but it could suddenly
> fallback to a, say, zEC12 - and that's not what you asked for. And you
> should not simply mask of deprecated features when baselining. Sure, we
> could eventually add config knobs for that , but ...
>=20
> ... I really do like the part where you can specify on the command line
> to have specific CPU definition, but including all available/recommended
> features (e.g., nested virtualization).
>=20
> >=20
> > Let me put it this way, I might have misunderstood what you are trying =
to do here,
> > but if I do not get, then others (e.g. users) will also not get it.
>=20
> I remember you participated in the relevant discussions. That's where we
> also agreed that versioned CPU models on s390x don't make any sense. But
> I can refine what's included in this patch description
>=20
> "There is the demand from higher levels in the stack to "have the
> best CPU model possible on a given accelerator, firmware and HW"" - the
> best CPU model for a specific *CPU definition*.
>=20
> Say the user has the option to select a model (zEC12, z13, z14), upper
> layers always want to have a model that includes all backported security
> features. While the host model can do that, CPU definitions can't. You
> can't change default models within a QEMU release, or for older releases
> (e.g., a z13).
>=20

This is a good description of the main use case we're worried
about in x86 too, and the main reason we have added versioned CPU
models.

I remember I was planning to use `query-cpu-model-expansion` for
"please give me the best configuration for this specific CPU
model" (which would be very similar to the approach used in this
series).  Now, I need to refresh my memory and try to remember
why I concluded this approach wouldn't work for x86.


> >=20
> > Maybe its just the interface or the name. But I find this very non-intu=
itive
>=20
> I'm open for suggestions.
>=20
> >=20
> > e.g. you wrote
> >=20
> >     Get the maximum possible feature set (e.g., including deprecated
> >     features) for a CPU definition in the configuration ("everything th=
at
> >     could be enabled"):
> >         -cpu z14,all-features=3Doff,available-features=3Don
> >=20
> >     Get all valid features for a CPU definition:
> >         -cpu z14,all-features=3Don
> >=20
> > What is the point of this? It is either the same as the one before, or =
it wont
> > be able to start.=20
>=20
> valid !=3D available, all !=3D available. Yes, the model won't run unless
> you are on pretty good HW :)
>=20
> Maybe I should just have dropped the last example, as it seems to
> confuse people - it's mostly only relevant for introspection via CPU
> model expansion.
>=20
> I am open for better names. e.g. all-features -> valid-features.

"all" is not a meaningful name to me.  It surely doesn't mean
"all features in the universe", so it means a more specific set
of features.  How is that set defined?

"valid" seems clearer, but we still need a description of what
"valid" means exactly.

--=20
Eduardo


