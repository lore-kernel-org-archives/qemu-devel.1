Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B32C56202
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:35:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E18B206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2/EVvCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E18B206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc5S4-0008Py-77
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 06:35:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kc5RF-0007yi-M2
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:34:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23469)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kc5RD-0007WJ-4o
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604921654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YCPsvHC1ztV73Pk95lRZ+9FUvWDHlwsJO5WEI1OICXw=;
 b=C2/EVvCjpZT6o5D0RqqYu0GMMLdtVnNHhCqq3Lcq8bZkshpOeAYpO8emAyWl6DCIKV+Sfy
 68tRQ4EExkyNjBl38d6Vsbi6CFh7ZIl6gkJF/q/wc6OcKs2VMUCAmCf5ADRS+5284EFkow
 apGYTDYZMhhdcZ3kXY75L+ZlFfVSLaM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-OVq2te5eNa253vK7cu1rkQ-1; Mon, 09 Nov 2020 06:34:12 -0500
X-MC-Unique: OVq2te5eNa253vK7cu1rkQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 872CC5F9C0;
 Mon,  9 Nov 2020 11:34:11 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-115-46.ams2.redhat.com [10.36.115.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0395A55766;
 Mon,  9 Nov 2020 11:34:05 +0000 (UTC)
Date: Mon, 9 Nov 2020 12:34:04 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 00/44] Make qdev static property API usable by any QOM
 type
Message-ID: <20201109113404.GA24970@merkur.fritz.box>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
 <20201106094511.GA23864@merkur.fritz.box>
 <20201106155013.GX5733@habkost.net>
 <20201106211034.GY5733@habkost.net>
 <ca99fc61-6cdd-117d-343e-8141e385522e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ca99fc61-6cdd-117d-343e-8141e385522e@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Eduardo Habkost <ehabkost@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 08.11.2020 um 15:05 hat Paolo Bonzini geschrieben:
> On 06/11/20 22:10, Eduardo Habkost wrote:
> > This was implemented at:
> > https://gitlab.com/ehabkost/qemu/-/commits/work/qdev-make-generic
> > 
> > This is the interface I'd like to submit as v3:
> > 
> > static Property machine_props[] = {
> >      DEFINE_PROP_STRING("kernel", MachineState, kernel_filename,
> >                         .description = "Linux kernel image file"),
> >      DEFINE_PROP_STRING("initrd", MachineState, initrd_filename,
> >                         .description = "Linux initial ramdisk file"),
> >      DEFINE_PROP_STRING("append", MachineState, kernel_cmdline,
> >                         .description = "Linux kernel command line"),
> >      DEFINE_PROP_STRING("dtb", MachineState, dtb,
> >                         .description = "Linux kernel device tree file"),
> >      DEFINE_PROP_STRING("dumpdtb", MachineState, dumpdtb,
> >                         .description = "Dump current dtb to a file and quit"),
> >      DEFINE_PROP_STRING("dt-compatible", MachineState, dt_compatible,
> >                         .description = "Overrides the \"compatible\" "
> >                                        "property of the dt root node"),
> >      DEFINE_PROP_STRING("firmware", MachineState, firmware,
> >                         .description = "Firmware image"),
> >      DEFINE_PROP_STRING("memory-backend", MachineState, ram_memdev_id,
> >                         .description = "ID of memory backend object"),
> >      DEFINE_PROP_BOOL("dump-guest-core", MachineState, dump_guest_core, true,
> >                       .description = "Include guest memory in a core dump"),
> >      DEFINE_PROP_BOOL("mem-merge", MachineState, mem_merge, true,
> >                       .description = "Enable/disable memory merge support"),
> >      DEFINE_PROP_BOOL("graphics", MachineState, enable_graphics, true,
> >                       .description = "Set on/off to enable/disable graphics emulation"),
> >      DEFINE_PROP_BOOL("suppress-vmdesc", MachineState, suppress_vmdesc, false,
> >                       .description = "Set on to disable self-describing migration"),
> >      DEFINE_PROP_UINT32("phandle-start", MachineState, phandle_start, 0,
> >                         .description = "The first phandle ID we may generate dynamically"),
> >      DEFINE_PROP_END_OF_LIST(),
> > };
> > 
> > static void machine_class_init(ObjectClass *oc, void *data)
> > {
> >      ...
> >      object_class_add_field_properties(oc, machine_props, prop_allow_set_always);
> >      ...
> > }
> 
> If all properties were like this, it would be okay.  But the API in v2 is
> the one that is most consistent with QOM in general. Here is how this change
> would be a loss in term of consistency:
> 
> - you have the field properties split in two (with the property itself in
> one place and the allow-set function in a different place), and also you'd
> have some properties listed as array and some as function calls.

Why would you have properties defined as function calls for the same
object that uses the array?

I'm not entirely sure what you mean with allow-set. The only things I
can find are related to link properties, specifically the check()
callback of object_class_property_add_link(). If it's this, what would
be the problem with just adding it to DEFINE_PROP_LINK instead of
using a separate function call to define link properties?

> - we would have different ways to handle device field properties (with
> dc->props) compared to object properties.

You mean dynamic per-object properties, i.e. not class properties?

I think having different ways for different things (class vs. object) is
better than having different ways for the same things (class in qdev vs.
class in non-qdev).

> - while it's true that the QEMU code base has ~500 matches for
> "object*_property_add*" calls, and ~2100 for "DEFINE_PROP*", the new field
> properties would pretty much be used only in places that use
> object_class_property_add*.  (And converting DEFINE_PROP* to PROP* would be
> relatively easy to script, unlike having an array-based definition for all
> uses of object_class_property*).
> 
> The choice to describe class properties as function calls was made in 2016
> (commit 16bf7f522a, "qom: Allow properties to be registered against
> classes", 2016-01-18); so far I don't see that it has been misused.

This was the obvious incremental step forward at the time because you
just had to replace one function call with another function call. The
commit message doesn't explain that not using data was a conscious
decision. I think it would probably have been out of scope then.

> Also, I don't think it's any easier to write an introspection code generator
> with DEFINE_PROP_*.  You would still have to parse the class init function
> to find the reference to the array (and likewise the TypeInfo struct to find
> the class init function).

I don't think we should parse any C code. In my opinion, both
introspection and the array should eventually be generated by the QAPI
generator from the schema.

Kevin


