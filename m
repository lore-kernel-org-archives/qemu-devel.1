Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28720C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC6922202
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AL1f08Oh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC6922202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb420-0003TH-99
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 10:52:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kb40T-0002xl-2M
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 10:50:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38694)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kb40P-0000pS-JR
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 10:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604677822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ynUT4DFAzfwmjNY/qR5iqzqQv+jO2eldMg39BRjYuM=;
 b=AL1f08OhMw2iUjCgAk0VG2zb7FLIqkRKTWXsL4WIWiApFl+uyxLm9aLi/zVSxsH2FD1jZW
 v1F3TC+shbEbSQ3phkuizHnXQx6bs2gfHFK2KAjKB9Lsct0xUBAf7bfpOa0d2MZF19XzQj
 ZmrdMKkbg/xQhCFK8f+kToEslesWEbg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-DrXVrfOyMtOjSG8hw6JEwA-1; Fri, 06 Nov 2020 10:50:20 -0500
X-MC-Unique: DrXVrfOyMtOjSG8hw6JEwA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 823761891E83;
 Fri,  6 Nov 2020 15:50:19 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 504535D9CA;
 Fri,  6 Nov 2020 15:50:14 +0000 (UTC)
Date: Fri, 6 Nov 2020 10:50:13 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 00/44] Make qdev static property API usable by any QOM
 type
Message-ID: <20201106155013.GX5733@habkost.net>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
 <20201106094511.GA23864@merkur.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20201106094511.GA23864@merkur.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 07:11:31
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 06, 2020 at 10:45:11AM +0100, Kevin Wolf wrote:
> Am 04.11.2020 um 16:59 hat Eduardo Habkost geschrieben:
> > This series refactor the qdev property code so the static
> > property system can be used by any QOM type.  As an example, at
> > the end of the series some properties in TYPE_MACHINE are
> > converted to static properties to demonstrate the new API.
> > 
> > Changes v1 -> v2
> > ----------------
> > 
> > * Rename functions and source files to call the new feature
> >   "field property" instead of "static property"
> > 
> > * Change the API signature from an array-based interface similar
> >   to device_class_set_props() to a object_property_add()-like
> >   interface.
> > 
> >   This means instead of doing this:
> > 
> >     object_class_property_add_static_props(oc, my_array_of_props);
> > 
> >   properties are registered like this:
> > 
> >     object_class_property_add_field(oc, "property-name"
> >                                     PROP_XXX(MyState, my_field),
> >                                     prop_allow_set_always);
> > 
> >   where PROP_XXX is a PROP_* macro like PROP_STRING, PROP_BOOL,
> >   etc.
> 
> In comparison, I really like the resulting code from the array based
> interface in v1 better.
> 
> I think it's mostly for two reasons: First, the array is much more
> compact and easier to read. And maybe even more importantly, you know
> it's static data and only static data. The function based interface can
> be mixed with other code or the parameter list can contain calls to
> other functions with side effects, so there are a lot more opportunities
> for surprises.

This is a really good point, and I strongly agree with it.
Letting code do funny tricks at runtime is one of the reasons QOM
properties became hard to introspect.

> 
> What I didn't like about the v1 interface is that there is still a
> separate object_class_property_set_description() for each property, but
> I think that could have been fixed by moving the description to the
> definitions in the array, too.

This would be very easy to implement.

> 
> On Fri, Oct 30, 2020 at 06:10:34PM +0100, Paolo Bonzini wrote:
> > On 29/10/20 23:02, Eduardo Habkost wrote:
> > > +static Property machine_props[] = {
> > > +    DEFINE_PROP_STRING("kernel", MachineState, kernel_filename),
> > > +    DEFINE_PROP_STRING("initrd", MachineState, initrd_filename),
> > > +    DEFINE_PROP_STRING("append", MachineState, kernel_cmdline),
> > > +    DEFINE_PROP_STRING("dtb", MachineState, dtb),
> > > +    DEFINE_PROP_STRING("dumpdtb", MachineState, dumpdtb),
> > > +    DEFINE_PROP_STRING("dt-compatible", MachineState, dt_compatible),
> > > +    DEFINE_PROP_STRING("firmware", MachineState, firmware),
> > > +    DEFINE_PROP_STRING("memory-backend", MachineState, ram_memdev_id),
> > > +    DEFINE_PROP_END_OF_LIST(),
> > > +};
> > > +
> >
> > While I think generalizing the _code_ for static properties is obviously
> > a good idea, I am not sure about generalizing the interface for adding them.
> >
> > The reason is that we already have a place for adding properties in
> > class_init, and having a second makes things "less local", so to speak.
> 
> As long as you have the function call to apply the properites array in
> .class_init, it should be obvious enough what you're doing.
> 
> Of course, I think we should refrain from mixing both styles in a single
> object, but generally speaking the array feels so much better that I
> don't think we should reject it just because QOM only had a different
> interface so far (and the property array is preexisting in qdev, too, so
> we already have differences between objects - in fact, the majority of
> objects is probably qdev today).

This is also a strong argument.  The QEMU code base has ~500
matches for "object*_property_add*" calls, and ~2100 for
"DEFINE_PROP*".

Converting qdev arrays to object_class_property_add_*() calls
would be a huge effort with no gains.  The end result would be
two different APIs for registering class field properties
coexisting for a long time, and people still confused on what's
the preferred API.

-- 
Eduardo


