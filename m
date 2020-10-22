Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8C8C388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:09:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389072080A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rjb+q0hE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389072080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVSqn-0001aw-5e
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 01:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kVSp8-000185-Rh
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:07:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40390)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kVSp4-0002Il-Dl
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603343227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C3d9SNuAUvEZ91yVu207WTEjZpb5bbWcomKfbm9Qoo4=;
 b=Rjb+q0hEjy9U4dIElGk0vTRJuadFyjt5/DsGiTEsRS9/b+G9Kyt19rKO89xqdfakhTMr3m
 Dy8giiWJdSCXRfzOSlGIgwLFVZsEpkXV+cnWG906N32u60WwLn4az8kBF9eJ108S+9+0oY
 Ab8z1h672njcULadzhN8/MsaMv4Fj4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-qcXynh06N16naCGV5RykLg-1; Thu, 22 Oct 2020 01:07:04 -0400
X-MC-Unique: qcXynh06N16naCGV5RykLg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04F98100D928
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 05:07:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83C9D5577D;
 Thu, 22 Oct 2020 05:07:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E71641132A08; Thu, 22 Oct 2020 07:06:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 03/12] qom: Make object_class_property_add_uint*_ptr()
 get offset
References: <20201009160122.1662082-1-ehabkost@redhat.com>
 <20201009160122.1662082-4-ehabkost@redhat.com>
 <20201021142408.72d2b92f@redhat.com>
 <20201021133041.GT5733@habkost.net>
Date: Thu, 22 Oct 2020 07:06:58 +0200
In-Reply-To: <20201021133041.GT5733@habkost.net> (Eduardo Habkost's message of
 "Wed, 21 Oct 2020 09:30:41 -0400")
Message-ID: <87a6we3l3h.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 23:30:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Wed, Oct 21, 2020 at 02:24:08PM +0200, Igor Mammedov wrote:
>> On Fri,  9 Oct 2020 12:01:13 -0400
>> Eduardo Habkost <ehabkost@redhat.com> wrote:
>> 
>> > The existing object_class_property_add_uint*_ptr() functions are
>> > not very useful, because they need a pointer to the property
>> > value, which can't really be provided before the object is
>> > created.
>> > 
>> > Replace the pointer parameter in those functions with a
>> > `ptrdiff_t offset` parameter.
>> > 
>> > Include a uint8 class property in check-qom-proplist unit tests,
>> > to ensure the feature is working.
>> 
>> 
>> Not sure I like approach, it's reinventing qdev pointer properties in QOM form.
>
> Yes, and that's on purpose.  If we want to eventually merge the
> two competing APIs into a single one, we need to make them
> converge.
>
>> I had an impression that Paolo wanted qdev pointer properties be gone
>> and replaced by something like link properties.
>
> This is completely unrelated to qdev pointer properties and link
> properties.  The properties that use object_property_add_uint*_ptr()
> today are not qdev pointer properties and will never be link
> properties.  They are just integer properties.
>
>> 
>> object_property_add_uintXX_ptr() were introduced as a quick hack,
>> when ACPI code generation was moved from Seabios, to avoid more
>> code shuffling in device models and adding more boiler plate in
>> form of custom setters/getters (the later didn't seem to bother
>> us everywhere else where we use object_[class_]property_add() ).
>> Then it spread little bit to another places.
>> 
>> I'd rather get rid of object_property_add_uintXX_ptr() API altogether
>> in favor of object_[class_]property_add() like it is used in other places
>> to handle intXX properties.
>> Adding helpers similar to object_property_add_bool() for intXX
>> could reduce boiler plate need for converting current instances of
>> _ptr(), and such helpers would also help with reducing boilerplate
>> for the rest of instances where object_[class_]property_add()
>> currently is used for dealing with integers.
>
> I find object_property_add_bool() terrible.  It requires too much
> boilerplate.  I actually have plans to introduce
> object*_property_add_bool_ptr() to simplify existing
> object_property_add_bool() callers.
>
> I don't love object*_property_add_*_ptr() either.  I consider the
> qdev property API better.  But we need a reasonable alternative,
> because the qdev API can't be used by non-device objects yet.

Emphasis on *yet*: we should be able to lift it up into QOM, shouldn't
we?

> I don't think object*_property_add() and
> object*_property_add_bool() are reasonable alternatives.


