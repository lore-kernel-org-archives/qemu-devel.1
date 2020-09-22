Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEC1C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36EFE22206
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3k/OaJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EFE22206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKkt5-0002BH-TB
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 12:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKjvy-0005XW-Tg
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 11:10:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKjvw-00056p-45
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 11:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600787418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pr0dmzt+1CiBcbdrMHRQumCQ+FbBYktWWUxt2VotUVA=;
 b=d3k/OaJ/RrDMI/bJkdiqmj+qgjS35sgYKaNLaiRII7WAZwCnxWGWxMU61mPfxjEBbpezYK
 fjUxk+F7NjnB+GTNJTQgpx+SjR/9Sps2LCQsOF67p0CntjKNFaXm5CYnYXcMY1eFsNhPJj
 dvGPxeThqAUbXPTotoF8owLTCK9VMcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-gUu_9xrOPr2DmP9HvXYL1w-1; Tue, 22 Sep 2020 11:10:13 -0400
X-MC-Unique: gUu_9xrOPr2DmP9HvXYL1w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 869B1801AE3;
 Tue, 22 Sep 2020 15:10:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CF4A78805;
 Tue, 22 Sep 2020 15:09:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A61251132E9A; Tue, 22 Sep 2020 17:09:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <87mu1j8p7p.fsf@dusky.pond.sub.org>
 <CAMxuvayvRfjUMYDiB5fm5QBD76kfD8-G1wTEucQTBbZUtnwXrA@mail.gmail.com>
Date: Tue, 22 Sep 2020 17:09:56 +0200
In-Reply-To: <CAMxuvayvRfjUMYDiB5fm5QBD76kfD8-G1wTEucQTBbZUtnwXrA@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 21 Sep 2020
 14:04:31 +0400")
Message-ID: <874knpluez.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: "P. Berrange, Daniel" <berrange@redhat.com>,
 Sergio Lopez Pascual <slp@redhat.com>, "Hajnoczi, 
 Stefan" <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Mon, Sep 21, 2020 at 1:16 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> marcandre.lureau@redhat.com writes:
>>
>> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >
>> > Hi,
>> >
>> > Among the QEMU developers, there is a desire to use Rust. (see previou=
s
>> > thread from Stefan "Why QEMU should move from C to Rust", the rust-vmm
>> > related projects and other experiments).
>> >
>> > Thanks to our QAPI type system and the associate code generator, it is
>> > relatively straightforward to create Rust bindings for the generated C
>> > types (also called sys/ffi binding) and functions. (rust-bindgen could
>> > probably do a similar job, but it would probably bring other issues).
>> > This provides an important internal API already.
>> >
>> > Slightly more complicated is to expose a Rust API for those, and provi=
de
>> > convenient conversions C<->Rust. Taking inspiration from glib-rs
>> > binding, I implemented a simplified version of the FromGlib/ToGlib
>> > traits, with simpler ownership model, sufficient for QAPI needs.
>> >
>> > The usage is relatively simple:
>> >
>> > - from_qemu_none(ptr: *const sys::P) -> T
>> >   Return a Rust type T for a const ffi pointer P.
>> >
>> > - from_qemu_full(ptr: *mut sys::P) -> T
>> >   Return a Rust type T for a ffi pointer P, taking ownership.
>> >
>> > - T::to_qemu_none() -> Stash<P>
>> >   Returns a borrowed ffi pointer P (using a Stash to destroy "glue"
>> >   storage data, if any).
>> >
>> > - T::to_qemu_full() -> P
>> >   Returns a ffi pointer P. (P resources are leaked/passed to C/ffi)
>> >
>> > With those traits, it's relatively easy to implement the QMP callbacks=
.
>> > With enough interest, we could eventually start rewriting QGA in
>> > Rust, as it is a simple service. See qga/qmp.rs for some examples.
>> > We could also try to tackle qemu itself.
>>
>> Up to here, you're talking about *internal* interfaces.  Correct?
>>
>> Your motivation is enabling use of Rust in QEMU.  Correct?
>
> That's the first motivation, indeed.

Sounds useful.

>> > Finally, given that the QAPI types are easy to serialize, it was simpl=
e
>> > to use "serde" on them, and provide a D-Bus interface for QMP with zbu=
s.
>> > (a similar approach could probably be taken for other protocols, that
>> > could be dynamically loaded... anyone like protobuf better?)
>>
>> QMP is an *external* interface.
>>
>> It supports compatible evolution: we can make certain kinds of changes
>> without affecting clients.  These include:
>>
>> * Adding optional arguments
>
> This would change the signature of the function, and would need an
> interface version bump.
>
> Alternative: pass optional arguments as an extra dictionary. This is a
> common idiom in D-Bus (the "a{sv}" type that maps strings to generic
> values)
>
> Potentially, use gvariant serialization format, which has maybe type.
> But gvariant isn't implemented by most D-Bus libraries (that was the
> plan long time ago, but it didn't happen as people lost interest).
>
>> * Adding results
>
> Also change the signature of the function.
>
> However, since messages have boundaries, it is easy to ignore return valu=
es.

I'm not sure I understand this.

The compatible change I have in mind is adding members to the complex
type returned by a command.

>> * Adding values to an enumeration type, branches to a union or
>>   alternate
>>
>
> As long as the discriminant is represented as a string, it should be fine=
.
>
>> * Reordering members of enumerations, structs, unions
>
> Again, if the discriminant is a string, it should be the same as with jso=
n.
>
> For the members, the usage of dictionaries is required in this case
> (else the type signature would change).
>
>> * Turning an argument type into an alternate with the old type as branch
>
> That would also change the function signature.
>
> There isn't much solution I can think of, unless we have an implicit
> tagged enum for every argument, which would be quite nasty.
>
>>
>> We've made use of this extensively.  See also
>> docs/devel/qapi-code-gen.txt section "Compatibility considerations."
>>
>> How do such changes affect clients of the proposed D-Bus interface?
>
> The introspection XML will always reflect the expected signature. You
> should bump your interface version whenever you make incompatible
> changes.

How do "interface versions" work?  Client's and server's version need to
match, or else no go?

> If this happens too often, we could also introduce a D-Bus override
> mechanism to do manual translations from external interface to
> internal.

Greek to me :)


