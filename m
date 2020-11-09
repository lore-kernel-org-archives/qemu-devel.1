Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE5AC5517A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 20:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E1BD20665
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 20:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dj1EUKn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1BD20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcDnL-0001ve-6w
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 15:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kcDmm-0001Uh-AV
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 15:29:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kcDmj-00078V-8z
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 15:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604953743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hBFfoe5Vjgp/eyGfnXPVtkpIHWDvf18Br8XXTTJXitM=;
 b=Dj1EUKn5F0n4c3nadnggILBMhb+5jGU3asQBJ30PXj+jWRpiNBzqv86ZeJw7t/nlOAADDZ
 eQB9tqcdcGcEhohQ0Xm/UJv4lJynW7T0OcB7XbyzyFI+rt9BmjDdTETI+aeAHIJ9806Wa/
 y6ynZv/116P3KEI/hQ0q3n7hxsYKkcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-_YSo_JJ3Ooqpb8wE3FZoyg-1; Mon, 09 Nov 2020 15:29:01 -0500
X-MC-Unique: _YSo_JJ3Ooqpb8wE3FZoyg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29D5C10866A7;
 Mon,  9 Nov 2020 20:29:00 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CFD1E5B4A0;
 Mon,  9 Nov 2020 20:28:56 +0000 (UTC)
Date: Mon, 9 Nov 2020 15:28:55 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 00/44] Make qdev static property API usable by any QOM
 type
Message-ID: <20201109202855.GD5733@habkost.net>
References: <20201106211034.GY5733@habkost.net>
 <ca99fc61-6cdd-117d-343e-8141e385522e@redhat.com>
 <20201109113404.GA24970@merkur.fritz.box>
 <3b711053-e67a-86fb-59e7-c06948dd8928@redhat.com>
 <20201109152125.GZ5733@habkost.net>
 <2300fd53-afa1-b957-b33b-cff2986fcb93@redhat.com>
 <20201109171618.GA5733@habkost.net>
 <098ca211-3ad5-b194-e9f5-678291fe641e@redhat.com>
 <20201109185558.GB5733@habkost.net>
 <9659e726-7948-4e02-f303-abcbe4c96148@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9659e726-7948-4e02-f303-abcbe4c96148@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 09, 2020 at 08:27:21PM +0100, Paolo Bonzini wrote:
> On 09/11/20 19:55, Eduardo Habkost wrote:
> > On Mon, Nov 09, 2020 at 06:33:04PM +0100, Paolo Bonzini wrote:
> > > On 09/11/20 18:16, Eduardo Habkost wrote:
> > > > I mean extending the API to let custom setters and getters appear
> > > > on the Property array, not using the existing API.
> > > 
> > > That seems like conflicting goals.  The field property API is based on
> > > getters and setters hidden in PropertyInfo.  The "other" property API is
> > > based on getters and setters in plain sight in the declaration of the
> > > property.
> > 
> > There's nothing that prevents a
> >    void object_class_add_properties(oc, Property *props);
> > function from supporting both.
> 
> Sorry but I don't believe this until I see it.  The two APIs are just too
> different.  And at some point the complexity of DEFINE_PROP becomes:
> 
> 1) harder to document
> 
> 2) just as hard to parse and build a QAPI schema from
> 
> And in the final desired result where QAPI generators are what generates the
> list of properties, it's pointless to shoehorn both kinds of properties in
> the same array if different things can just generate calls to different
> functions.
> 
> > > > Parsing an array containing a handful of macros (a tiny subset of
> > > > C) isn't even comparable to parsing and executing C code where
> > > > object*_property_add*() calls can be buried deep in many levels
> > > > of C function calls (which may or may not be conditional).
> > > 
> > > Finding the array would also require finding calls buried deep in C code,
> > > wouldn't they?
> > 
> > Yes, but I don't expect this to happen if the API doesn't
> > encourage that.
> 
> Out of 700 calls to object_class_property_add*, there are maybe 5 that are
> dynamic.  So on one hand I understand why you want an API that makes those
> things harder, but on the other hand I don't see such a big risk of misuse,
> and it won't even matter at all if we later end up with properties described
> in a QAPI schema.
> 
> > > > (Also, I don't think we should allow handwritten Property literals.)
> > > 
> > > How would you do custom setters and getters then---without separate
> > > PropertyInfos, without Property literals, and without an exploding number of
> > > macros?
> > 
> > Prop with no struct field, and custom setter/getter:
> > 
> >    DEFINE_PROP("myproperty", prop_type_uint32,
> >                .custom_getter = my_getter,
> >                .custom_setter = my_setter)
> 
> It would have to use all the Visitor crap and would be even harder to use
> than object_class_property_add_str.  Thanks but no thanks. :)

Point taken, I dislike the visitor API too.

> 
> > > > we can't be sure the [set of QOM properties]
> > > > doesn't depend on configure flags or run time
> > > > checks inside class_init.
> > > 
> > > We can use grep or Coccinelle or manual code review to identify problematic
> > > cases.
> > 
> > We can, but I believe it is better and simpler to have an API
> > that enforces (or at least encourages) this.
> 
> I don't see how
> 
>     if (...) {
>         object_class_add_field_properties(oc, props);
>     }
> 
> is discouraged any more than
> 
>     if (...) {
>         object_class_add_field_property(oc, "prop1",
>                                         PROP_STRING(...));
>         object_class_add_field_property(oc, "prop2",
>                                         PROP_STRING(...));
>         object_class_add_field_property(oc, "prop3",
>                                         PROP_STRING(...));
>         object_class_add_field_property(oc, "prop4",
>                                         PROP_STRING(...));
>     }
> 
> (If anything, the former is more natural and less ugly than the latter).

On the former, "adding a new property" means adding an entry to a
const array.  On the latter, it means adding a new function call.

On the former, a conditional property would require defining a
new array.  A non-constant property name or type would require
making the array non-const and modifying it at runtime.

On the latter, adding a if statement on the front of that
function call or a non-constant expression as argument to the
function is trivial.

> 
> > I'd like us to convert instance-level properties to an API that
> > is easy to use and where the same problems won't happen again.
> 
> I agree.  I just don't think that arrays are enough to make sure the same
> problems won't happen again.
> 
> > > > You are also ignoring the complexity of the code path that leads
> > > > to the object*_property_add*() calls, which is the main problem
> > > > on most cases.
> > > 
> > > I would like an example of the complexity of those code paths.  I don't see
> > > much complexity, as long as the object exists at all, and I don't see how it
> > > would be simpler to find the code paths that lead to
> > > object_class_add_field_properties.
> > 
> > Possibly the most complex case is x86_cpu_register_bit_prop().
> > The qdev_property_add_static() calls at arm_cpu_post_init() are
> > tricky too.
> 
> The problem with those code paths is that there's a reason why they look
> like they do.  For x86_cpu_register_feature_bit_props, for example either
> you introduce duplication between QOM property definitions and feat_names
> array, or you resort to run-time logic like that.
> 
> If you want to make those properties introspectable (i.e. known at
> compilation time) you wouldn't anyway use DEFINE_PROP*, because it would
> cause duplication.  Instead, you could have a plug-in parser for qapi-gen,
> reading files akin to target/s390x/cpu_features_def.h.inc. The parser would
> generate both QAPI schema and calls to x86_cpu_register_bit_prop().
> 
> To sum up: for users where properties are heavily dependent on run-time
> logic, the solution doesn't come from providing a more limited API.  A
> crippled API will simply not solve the problem that prompted the usage of
> run-time logic, and therefore won't be used.

I don't know yet what's the best solution for the x86 feature
case.  Maybe duplicating the list of feature names would be a
small price to pay to get a static list of properties defined at
compilation time?  Maybe we can replace
FeatureWordInfo.feat_names[] with property introspection code
that will find the property name for a given struct field?

In either case, we need something that works for x86 and other
complex cases, or it won't be used.  Point taken.

> 
> (I don't know enough of the ARM case to say something meaningful about it).
> 
> > If object*_property_add*() is hidden behind a function call or a
> > `if` statement, it's already too much complexity to me.
> 
> You want to remove hiding behind a function call, but why is it any better
> to hide behind layers of macros?  Just the example you had in your email
> included DEFINE_PROP, DEFINE_FIELD_PROP, DEFINE_PROP_UINT32.  It's still
> impossible to figure out without either parsing or executing C code.

Because we can be absolutely sure the macros (and the property
array) will be constant expressions evaluated at compilation
time.

                             * * *

Anyway, If we are the only ones discussing this, I will just
defer to your suggestions as QOM maintainer.  I hope we hear from
others.

-- 
Eduardo


