Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9189C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 434EF20789
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJJyFkFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434EF20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcArl-0000Ku-AJ
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kcAmW-0004Ci-PF
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:16:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kcAmL-0001cG-CT
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:16:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604942187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=13PMHFUablDQUxTJtzyhQ2QgtAftLmN5nEFNPd4NdDM=;
 b=PJJyFkFNReSeE0CuqtE0dFMb9BDsqE+LYUMpZNB6sNkr9MTNdiIJ2uEmrVk7d0m+xe/o5h
 vHr7giuZzTERiyPcGBsCpbSb9sHy8noGqgTdozuQG21oXoiP0OlH8A4Y259XR4Ww7VJgod
 S3bH0CPTIyX9V7Ql6dQtVbsMtBkK2j4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-D4BwvVH8O_6O53T5mxPY1A-1; Mon, 09 Nov 2020 12:16:24 -0500
X-MC-Unique: D4BwvVH8O_6O53T5mxPY1A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 409CB101964B;
 Mon,  9 Nov 2020 17:16:23 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0CB25D9DD;
 Mon,  9 Nov 2020 17:16:19 +0000 (UTC)
Date: Mon, 9 Nov 2020 12:16:18 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 00/44] Make qdev static property API usable by any QOM
 type
Message-ID: <20201109171618.GA5733@habkost.net>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
 <20201106094511.GA23864@merkur.fritz.box>
 <20201106155013.GX5733@habkost.net>
 <20201106211034.GY5733@habkost.net>
 <ca99fc61-6cdd-117d-343e-8141e385522e@redhat.com>
 <20201109113404.GA24970@merkur.fritz.box>
 <3b711053-e67a-86fb-59e7-c06948dd8928@redhat.com>
 <20201109152125.GZ5733@habkost.net>
 <2300fd53-afa1-b957-b33b-cff2986fcb93@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2300fd53-afa1-b957-b33b-cff2986fcb93@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

On Mon, Nov 09, 2020 at 05:34:01PM +0100, Paolo Bonzini wrote:
> On 09/11/20 16:21, Eduardo Habkost wrote:
> > On Mon, Nov 09, 2020 at 03:15:26PM +0100, Paolo Bonzini wrote:
> > > On 09/11/20 12:34, Kevin Wolf wrote:
> > > > > If all properties were like this, it would be okay.  But the API in v2 is
> > > > > the one that is most consistent with QOM in general. Here is how this change
> > > > > would be a loss in term of consistency:
> > > > > 
> > > > > - you have the field properties split in two (with the property itself in
> > > > > one place and the allow-set function in a different place), and also you'd
> > > > > have some properties listed as array and some as function calls.
> > > > 
> > > > Why would you have properties defined as function calls for the same
> > > > object that uses the array?
> > > 
> > > Because some properties would not be field properties, for example.  For
> > > example, any non-scalar property would need to invoke visit_SomeQapiStruct
> > > manually and would not be a field property.
> > 
> > Nothing prevents us from describing those properties inside the
> > same property array.
> 
> Do you mean adding PropertyInfos for them?  Adding a once-only PropertyInfo
> is worse than writing a custom getter/setter pair, because:
> 
> - without (DEFINE_)PROP_* you lose the type safety.
> 
> - with (DEFINE_)PROP_* you have much more boilerplate to write

I mean extending the API to let custom setters and getters appear
on the Property array, not using the existing API.

> 
> > More precisely, it is
> >    device_class_set_props(dc, foo);
> > 
> > which is supposed to become a one-line wrapper to
> > object_class_add_field_properties().
> 
> You're right, I'm a few years late.  So that objection is withdrawn.
> 
> > (There's also the possibility we let the class provide a default
> > allow_set function, and both would become 100% the same)
> 
> That's a possibility too.  Though if we ever have a need for multiple
> allow_set functions it would be somewhat complicated to add it back.
> 
> Instead of class-wide allow_set, we might as well have a "bool constructed"
> field in Object and remove the function pointer altogether: just replace
> prop->allow_set(obj) with just "!obj->constructed".

That's a possibility, and maybe that could be the default
allow_set behavior.  It may be a bit tricky to convert the
existing backend objects to the new behavior in a gradual way,
though.

> 
> > > > I think having different ways for different things (class vs. object) is
> > > > better than having different ways for the same things (class in qdev vs.
> > > > class in non-qdev).
> > > 
> > > Right, but qdev's DEFINE_PROP_STRING would be easy to change to something
> > > like
> > > 
> > > - DEFINE_PROP_STRING("name", ...),
> > > + device_class_add_field_property(dc, "name", PROP_STRING(...));
> > 
> > I'm not worried about this direction of conversion (which is
> > easy).  I'm worried about the function call => QAPI schema
> > conversion.  Function calls are too flexible and requires parsing
> > and executing C code.
> 
> Converting DEFINE_PROP_STRING to a schema also requires parsing C code,
> since you can have handwritten Property literals (especially for custom
> PropertyInfo).  Converting DEFINE_PROP_STRING it also requires matching the
> array against calls to object_class_add_field_properties (which could be
> hidden behind helpers such as device_class_set_props).  (Plus matching
> class_init functions against TypeInfo).

Parsing an array containing a handful of macros (a tiny subset of
C) isn't even comparable to parsing and executing C code where
object*_property_add*() calls can be buried deep in many levels
of C function calls (which may or may not be conditional).

(Also, I don't think we should allow handwritten Property literals.)

> 
> So, you don't save any parsing by using arrays.  (In fact I would probably
> skip the parsing, and use your suggestion of *executing* C code: write the
> QAPI schema generator in C, link into QEMU and run it just once to generate
> the QOM schema).

If we do that with the existing code, we can't be sure the
generated schema doesn't depend on configure flags or run time
checks inside class_init.  Even locating the cases where this is
happening is being a challenge because the API is too flexible.

However, if we require the property list to be always evaluated
at compile time, we can be sure that this method will be
reliable.

> 
> QOM has been using function calls for many years, are there any cases of
> misuse of that flexibility that you have in mind?  I can only think of two
> *uses*, in fact.  One is eepro100_register_types is the only case I can
> remember where types are registered dynamically.  The other is S390 CPU
> features.  [...]

The list of tricky dynamic properties is large and I don't think
we even found all cases yet.  John documented many of them here:

https://gitlab.com/jsnow/qemu/-/blob/cli_audit/docs/cli_audit.md

Look, for example, for the sections named "Features" for CPU
options.


>     [...]  In fact,
> 
>   $ git grep \ object_class_property_add|grep -v '([a-z0-9_]*, \"'
> 
> shows some cases where property names are macros (an mst-ism :), but no
> other case where properties are being defined dynamically.

You are excluding instance-level object_property_add*() calls.
Most of them are supposed to be class properties but were never
converted.

You are also ignoring the complexity of the code path that leads
to the object*_property_add*() calls, which is the main problem
on most cases.

-- 
Eduardo


