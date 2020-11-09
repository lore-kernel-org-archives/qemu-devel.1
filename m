Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898B7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B85206D8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZ3nApSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B85206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcCMK-0003v9-OW
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 13:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kcCKq-000341-Et
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:56:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kcCKn-0003Vg-Ew
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604948168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CwSdeDhQdRo7mMXvly7khkZbg4WR7uGBxkV5IXD22cc=;
 b=FZ3nApSkJMZYfhN2kQhrC3G8hyOl2yNpfk2xrsJygRX+AlZM2MPlGXTbjKa47fNx46Oa8X
 e8JepWqOStDyo7CXpJoz67iwlOoRNwAmLpe3sO4XIa1VBowQeieplgKDibV+xuKoDmbupL
 rcVwv5jldlNCYM6EAOp7EPm+TENS32w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-UVHYMmWHOW26qANBUg6O5g-1; Mon, 09 Nov 2020 13:56:03 -0500
X-MC-Unique: UVHYMmWHOW26qANBUg6O5g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5BC6801FCC;
 Mon,  9 Nov 2020 18:56:02 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44B1C60BF1;
 Mon,  9 Nov 2020 18:55:59 +0000 (UTC)
Date: Mon, 9 Nov 2020 13:55:58 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 00/44] Make qdev static property API usable by any QOM
 type
Message-ID: <20201109185558.GB5733@habkost.net>
References: <20201106094511.GA23864@merkur.fritz.box>
 <20201106155013.GX5733@habkost.net>
 <20201106211034.GY5733@habkost.net>
 <ca99fc61-6cdd-117d-343e-8141e385522e@redhat.com>
 <20201109113404.GA24970@merkur.fritz.box>
 <3b711053-e67a-86fb-59e7-c06948dd8928@redhat.com>
 <20201109152125.GZ5733@habkost.net>
 <2300fd53-afa1-b957-b33b-cff2986fcb93@redhat.com>
 <20201109171618.GA5733@habkost.net>
 <098ca211-3ad5-b194-e9f5-678291fe641e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <098ca211-3ad5-b194-e9f5-678291fe641e@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

On Mon, Nov 09, 2020 at 06:33:04PM +0100, Paolo Bonzini wrote:
> On 09/11/20 18:16, Eduardo Habkost wrote:
> > On Mon, Nov 09, 2020 at 05:34:01PM +0100, Paolo Bonzini wrote:
> > > On 09/11/20 16:21, Eduardo Habkost wrote:
> > > > Nothing prevents us from describing those properties inside the
> > > > same property array.
> > > 
> > > Do you mean adding PropertyInfos for them?  Adding a once-only PropertyInfo
> > > is worse than writing a custom getter/setter pair, because:
> > > 
> > > - without (DEFINE_)PROP_* you lose the type safety.
> > > 
> > > - with (DEFINE_)PROP_* you have much more boilerplate to write
> > 
> > I mean extending the API to let custom setters and getters appear
> > on the Property array, not using the existing API.
> 
> That seems like conflicting goals.  The field property API is based on
> getters and setters hidden in PropertyInfo.  The "other" property API is
> based on getters and setters in plain sight in the declaration of the
> property.

There's nothing that prevents a
  void object_class_add_properties(oc, Property *props);
function from supporting both.

> 
> > > > > > I think having different ways for different things (class vs. object) is
> > > > > > better than having different ways for the same things (class in qdev vs.
> > > > > > class in non-qdev).
> > > > > 
> > > > > Right, but qdev's DEFINE_PROP_STRING would be easy to change to something
> > > > > like
> > > > > 
> > > > > - DEFINE_PROP_STRING("name", ...),
> > > > > + device_class_add_field_property(dc, "name", PROP_STRING(...));
> > > > 
> > > > I'm not worried about this direction of conversion (which is
> > > > easy).  I'm worried about the function call => QAPI schema
> > > > conversion.  Function calls are too flexible and requires parsing
> > > > and executing C code.
> > > 
> > > Converting DEFINE_PROP_STRING to a schema also requires parsing C code,
> > > since you can have handwritten Property literals (especially for custom
> > > PropertyInfo).  Converting DEFINE_PROP_STRING it also requires matching the
> > > array against calls to object_class_add_field_properties (which could be
> > > hidden behind helpers such as device_class_set_props).  (Plus matching
> > > class_init functions against TypeInfo).
> > 
> > Parsing an array containing a handful of macros (a tiny subset of
> > C) isn't even comparable to parsing and executing C code where
> > object*_property_add*() calls can be buried deep in many levels
> > of C function calls (which may or may not be conditional).
> 
> Finding the array would also require finding calls buried deep in C code,
> wouldn't they?

Yes, but I don't expect this to happen if the API doesn't
encourage that.

> 
> > (Also, I don't think we should allow handwritten Property literals.)
> 
> How would you do custom setters and getters then---without separate
> PropertyInfos, without Property literals, and without an exploding number of
> macros?

Property with struct field:

  /* We call this DEFINE_PROP_UINT32 today.  We can keep the
   * existing name just to reduce churn.
   */
  DEFINE_PROP_UINT32_FIELD("myproperty", MyState, my_field)


Prop with struct field but custom setter:

  DEFINE_PROP_UINT32_FIELD("myproperty", MyState, my_field,
                           .custom_setter = my_custom_setter)

Prop with no struct field, and custom setter/getter:

  DEFINE_PROP("myproperty", prop_type_uint32,
              .custom_getter = my_getter,
              .custom_setter = my_setter)


Definitions for above:

#define DEFINE_PROP(_name, _typeinfo, ...) \
    { .name = _name,
      .info = &_typeinfo,
      __VA_ARGS__
    }

#define DEFINE_FIELD_PROP(name, typeinfo, type, state, field, ...) \
    DEFINE_PROP(name, typeinfo,
                .offset = offsetof(state, field) +
                          type_check(typeof_field(state, field), type),
                __VA_ARGS__)

#define DEFINE_PROP_UINT32_FIELD(name, state, field, ...) \
    DEFINE_FIELD_PROP(name, prop_type_uint32, uint32_t, state, field, __VA_ARGS__)


Alternative DEFINE_FIELD_PROP definition if we implement some
macro magic to declare the expected type for each typeinfo
variable:

/* Will make ACTUAL_C_TYPE(prop_type_uint32) expand to uint32_t */
DECLARE_QOM_TYPE(prop_type_uint32, uint32_t)
/* Will make ACTUAL_C_TYPE(prop_type_uint64) expand to uint64_t) 
DECLARE_QOM_TYPE(prop_type_uint64, uint64_t)

#define DEFINE_FIELD_PROP(name, typeinfo, state, field, ...) \
    DEFINE_PROP(name, typeinfo,
                .offset = offsetof(state, field) +
                          type_check(typeof_field(state, field),
                                     ACTUAL_C_TYPE(typeinfo)),
                __VA_ARGS__)


> 
> > > So, you don't save any parsing by using arrays.  (In fact I would probably
> > > skip the parsing, and use your suggestion of *executing* C code: write the
> > > QAPI schema generator in C, link into QEMU and run it just once to generate
> > > the QOM schema).
> > 
> > If we do that with the existing code, we can't be sure the
> > generated schema doesn't depend on configure flags or run time
> > checks inside class_init.
> 
> We can use grep or Coccinelle or manual code review to identify problematic
> cases.

We can, but I believe it is better and simpler to have an API
that enforces (or at least encourages) this.

> 
> > Even locating the cases where this is
> > happening is being a challenge because the API is too flexible.
> > 
> > However, if we require the property list to be always evaluated
> > at compile time, we can be sure that this method will be
> > reliable.
> > 
> > > QOM has been using function calls for many years, are there any cases of
> > > misuse of that flexibility that you have in mind?  I can only think of two
> > > *uses*, in fact.  One is eepro100_register_types is the only case I can
> > > remember where types are registered dynamically.  The other is S390 CPU
> > > features.  [...]
> > 
> > The list of tricky dynamic properties is large and I don't think
> > we even found all cases yet.  John documented many of them here:
> > 
> > https://gitlab.com/jsnow/qemu/-/blob/cli_audit/docs/cli_audit.md
> > 
> > Look, for example, for the sections named "Features" for CPU
> > options.
> 
> Yes, I'm only considering object_class_property calls.  Those are the ones
> that I claim aren't being misused enough for this to be a problem.
> 

instance-level properties are where most of the complexity was
introduced because the class API didn't exist yet.  I don't think
we should ignore them, or we risk having the same issues when
converting them to class properties.


> Making instance-level properties appear in the schema is a completely
> different kind of conversion, because there is plenty of manual work (and
> unsolved problems for e.g. subobject property aliases).

I'd like us to convert instance-level properties to an API that
is easy to use and where the same problems won't happen again.

> 
> > You are also ignoring the complexity of the code path that leads
> > to the object*_property_add*() calls, which is the main problem
> > on most cases.
> 
> I would like an example of the complexity of those code paths.  I don't see
> much complexity, as long as the object exists at all, and I don't see how it
> would be simpler to find the code paths that lead to
> object_class_add_field_properties.

Possibly the most complex case is x86_cpu_register_bit_prop().
The qdev_property_add_static() calls at arm_cpu_post_init() are
tricky too.

If object*_property_add*() is hidden behind a function call or a
`if` statement, it's already too much complexity to me.  I don't
want us to need a second audit like the one John made when we
decide to represent QOM class properties in a QAPI schema.

-- 
Eduardo


