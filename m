Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E13C04E30
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 23:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B53A8206D3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 23:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOWKm1gc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53A8206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieSTb-0001wE-UC
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 18:30:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1ieSSy-0001SB-2C
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 18:29:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1ieSSw-0000Fb-Kb
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 18:29:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47914
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ieSSw-0000FH-Gs
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 18:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575934161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdAZ+VJPugiOcD5Z6OcB+20ESNeQZNJaDn+i5OXCLFY=;
 b=LOWKm1gcBFPXTgsRrOcfXRtgXNoXJKYG7rE6tpxdo8WwJV0HZNy5uq2VIoD+YXLIlds16P
 y9OleiLzAIt03KONhIfxELLpIg25InrhH3aCZWg1kxbWBcJeo66yaqnO5Zo5/AfFk0mYbw
 mEg+t+1Q94x6z3LEKXg1NUxvthb7XYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-rx3si2RrP9Km8-pt14nQMA-1; Mon, 09 Dec 2019 18:29:18 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B7A1107ACC4;
 Mon,  9 Dec 2019 23:29:17 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F5C663742;
 Mon,  9 Dec 2019 23:29:13 +0000 (UTC)
Date: Mon, 9 Dec 2019 20:29:12 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 2/2] s390x/cpumodel: Introduce dynamic feature groups
Message-ID: <20191209232912.GM498046@habkost.net>
References: <b062f580-d664-f68c-2364-1f65df6ee265@de.ibm.com>
 <C829F458-099D-4E95-B835-67F008E60B13@redhat.com>
 <b4f4546d-b620-0428-40bf-59f4584a80f3@de.ibm.com>
 <b4ee8526-b1e3-21ee-5e1e-b22520e29339@redhat.com>
 <20191129193317.GE14595@habkost.net>
 <a5ae30ef-e193-fd22-b3e2-a7626e82d9b1@redhat.com>
 <20191205143506.GG498046@habkost.net>
 <b0467d48-1fff-e2ae-4866-1c9dbe03fb6c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b0467d48-1fff-e2ae-4866-1c9dbe03fb6c@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: rx3si2RrP9Km8-pt14nQMA-1
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
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 05, 2019 at 03:48:47PM +0100, David Hildenbrand wrote:
> On 05.12.19 15:35, Eduardo Habkost wrote:
> > On Mon, Dec 02, 2019 at 10:15:12AM +0100, David Hildenbrand wrote:
> >>
> >>>> Say the user has the option to select a model (zEC12, z13, z14), upp=
er
> >>>> layers always want to have a model that includes all backported secu=
rity
> >>>> features. While the host model can do that, CPU definitions can't. Y=
ou
> >>>> can't change default models within a QEMU release, or for older rele=
ases
> >>>> (e.g., a z13).
> >>>>
> >>>
> >>> This is a good description of the main use case we're worried
> >>> about in x86 too, and the main reason we have added versioned CPU
> >>> models.
> >>>
> >>> I remember I was planning to use `query-cpu-model-expansion` for
> >>> "please give me the best configuration for this specific CPU
> >>> model" (which would be very similar to the approach used in this
> >>> series).  Now, I need to refresh my memory and try to remember
> >>> why I concluded this approach wouldn't work for x86.
> >>
> >> I would be interested in that - I don't really think exposing CPU
> >> versions to the user is necessary here.
> >>
> >> E.g., you can maintain the versions internally and enable the stored
> >> features of the fitting one with "recommended-features=3Don...".
> >=20
> > I was re-reading some code and threads, and now I remember: the
> > main obstacle for using query-cpu-model-expansion for CPU model
> > version resolution in x86 is the fact that the x86 CPU models
> > aren't static yet.  (type=3Dfull expansion isn't useful for CPU the
> > use case above; type=3Dstatic expansion requires static CPU models
> > to be useful)
>=20
>=20
> I think, you could if you would expand "best X" to something like
>=20
> -cpu X,all-features=3Doff,featX=3Don,featY=3Don ...
>=20
> The "all-features" part would need a better name as discussed. Such a
> model would always have a defined feature set (all listed features) =3D=
=3D
> static. The list could get a little longer, which is why s390x has these
> static "base" features. But that's not a road blocker.
>=20
> >=20
> > I was planning to make x86 CPU models static, then I noticed we
> > do have lots of feature flags that depend on the current
> > accelerator (set by kvm_default_props) or current machine (set
> > by compat_props).  This breaks the rules for static CPU models.
>=20
> The static models we have (e.g., z13-base) contain a minimum set of
> features we expect to be around in every environment (but doesn't have
> to). It's just a way to make the featX=3Don,featY=3Don ... list shorter.
>=20
> X would be expanded to e.g.,
>=20
> -cpu X-base,featX=3Don,featY=3Don ...
>=20
> But nothing speaks against having
>=20
> -cpu X-base,featX=3Doff,featY=3Don ...
>=20
> A very simplistic base model would be a model without any features.
> (like -cpu X,all-features=3Doff), but then it would be set in stone.

x86 has only one static CPU model, called "base", just to make
type=3Dstatic expansion work.  Having multiple "<model>-base" CPU
models would help make the extra feature list shorter, yes.

But we would still need to decide how to handle the
accel-specific code in x86_cpu_load_model(), including:
* kvm_default_props/tcg_default_props;
* x2apic special case for !kvm_irqchip_in_kernel();
* host vendor ID special case for KVM.

If we include that in static expansion, it would be a large
number of user-visible side effects for something that was
supposed to just add/remove a tiny set of CPU features to an
existing configuration.  If we don't, we are breaking the rules
of static expansion (aren't we?).

We can still try to address this and make
"query-cpu-model-expansion type=3Dstatic ...,recommended-features=3Don"
work on x86, and see it is usable by libvirt in x86.  I'm just
worried that the interface may become complex, easy to get wrong,
and hard to validate until full libvirt support is implemented.
query-cpu-model-expansion is very extensible and flexible, but
hard to explain and reason about.


>=20
> >=20
> > We can still try to provide useful static CPU models in x86 in
> > the future (I want to).  But I don't want to make this an
> > obstacle for providing a CPU model update mechanism that works
> > for x86 (which is more urgent).
> >=20
> >>
> >>>
> >>>
> >>>>>
> >>>>> Maybe its just the interface or the name. But I find this very non-=
intuitive
> >>>>
> >>>> I'm open for suggestions.
> >>>>
> >>>>>
> >>>>> e.g. you wrote
> >>>>>
> >>>>>     Get the maximum possible feature set (e.g., including deprecate=
d
> >>>>>     features) for a CPU definition in the configuration ("everythin=
g that
> >>>>>     could be enabled"):
> >>>>>         -cpu z14,all-features=3Doff,available-features=3Don
> >>>>>
> >>>>>     Get all valid features for a CPU definition:
> >>>>>         -cpu z14,all-features=3Don
> >>>>>
> >>>>> What is the point of this? It is either the same as the one before,=
 or it wont
> >>>>> be able to start.=20
> >>>>
> >>>> valid !=3D available, all !=3D available. Yes, the model won't run u=
nless
> >>>> you are on pretty good HW :)
> >>>>
> >>>> Maybe I should just have dropped the last example, as it seems to
> >>>> confuse people - it's mostly only relevant for introspection via CPU
> >>>> model expansion.
> >>>>
> >>>> I am open for better names. e.g. all-features -> valid-features.
> >>>
> >>> "all" is not a meaningful name to me.  It surely doesn't mean
> >>> "all features in the universe", so it means a more specific set
> >>> of features.  How is that set defined?
> >>>
> >>> "valid" seems clearer, but we still need a description of what
> >>> "valid" means exactly.
> >>>
> >>
> >> So, we have
> >>
> >> +static S390DynFeatGroupDef s390_dyn_feature_groups[] =3D {
> >> +    /* "all" corresponds to our "full" definitions */
> >> +    DYN_FEAT_GROUP_INIT("all-features", ALL, "Features valid for a CP=
U
> >> definition"),
> >> [...]
> >> +};
> >>
> >> it includes features that are not available - all features that could
> >> theoretically be enabled for that CPU definition.
> >>
> >> (e.g., "vx" was introduced with z13 and cannot be enabled for the z12.
> >> It's part of the full model of a z13, but not of a z12)
> >=20
> > Isn't this something already returned by device-list-properties?
> >=20
>=20
> We do register all feature properties for all models. So, yes, it would
> have been possible if we (I) would have implemented that differently. We
> could (and maybe should) still change that - only register the features
> that are part of the "full" model.

Understood.  When exactly would all-features=3Don be useful for
management software?

--=20
Eduardo


