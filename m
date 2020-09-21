Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108E8C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 10:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7938120EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 10:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZqTfNXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7938120EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKIjL-0008NM-H7
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 06:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kKIgn-0005SF-9O
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 06:04:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22981
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kKIgk-0006TR-Qs
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 06:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600682688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pAV7uh4FV14AYPx+0FZmDI7iXzhZjCJ0zQQpqYuwiSQ=;
 b=QZqTfNXmp2F4TKcq11eupoXXfISYAu6o1rXXV774M3gg8r9YXGn0oG8FaxnwC9PTZlVuvn
 xM0quHjBXRI3G/m1hJexiW2EtEdmXkB6U+LixQOf8Lf0IReFoyOcX3xNCKjQnAS8oohsrE
 ZMhRU9MdU/t4s/I3XAdyUyu2mixE7hk=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-GJFGo3b0Pzu-HtjuCdFeeA-1; Mon, 21 Sep 2020 06:04:43 -0400
X-MC-Unique: GJFGo3b0Pzu-HtjuCdFeeA-1
Received: by mail-io1-f70.google.com with SMTP id t187so9465596iof.22
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 03:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pAV7uh4FV14AYPx+0FZmDI7iXzhZjCJ0zQQpqYuwiSQ=;
 b=skQ+fupzeHEu4BSVpyKt0PLDGTBlLfGuOrj3eJexvNJFEc6+awCSQPTIa5I8iTlbfI
 8g8rr8lmGmyB2SWfht4v8I9BtF/5tnJvAznRFM3y4exB1bpReI06afjXeoWNf3D4ctCn
 +4za3y6oKTShPJZw+mnCbmYBaUFyY2YMah6/bz66EmAyDpMTZFyGdq+gBrMZYgsSaiaT
 9+Nf5+fJfQRCYIqMaRYL0tlQ3v4KrAG40O3GLUto5XlG+NKn+qz7hzN1/8icTLBdwPZW
 H5FVC5NifgWU3gv+ew6ib97hc5CEpFnuLgVbvb7I88P9hxHXP95VGedI/bEDgQy1ohkd
 5/RQ==
X-Gm-Message-State: AOAM532r3ZRhAfCCMsmkt300C9fUf4icoj9Uk9ZuD5EcPAe4O32Xw1AG
 X0gROj+XR9Ti0BXl3zXTXta3Zt1iOeAcTcFkRMycyOYt3faQFxS/xEFVribIgGkOr3zD9HhbyyF
 e3aXFC86A8RTaS48tRuL05rq7HIwqLeI=
X-Received: by 2002:a92:4183:: with SMTP id o125mr12737145ila.82.1600682682684; 
 Mon, 21 Sep 2020 03:04:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4rYzn/pZ/kEe7n0ir7SXTPcJ9LnE4NgcU7HwOZKm2M54Gymv1+LEaom0n8EjQvez6ox7tWs4lysU0pgtHkws=
X-Received: by 2002:a92:4183:: with SMTP id o125mr12737121ila.82.1600682682413; 
 Mon, 21 Sep 2020 03:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <87mu1j8p7p.fsf@dusky.pond.sub.org>
In-Reply-To: <87mu1j8p7p.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 21 Sep 2020 14:04:31 +0400
Message-ID: <CAMxuvayvRfjUMYDiB5fm5QBD76kfD8-G1wTEucQTBbZUtnwXrA@mail.gmail.com>
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: Markus Armbruster <armbru@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 03:43:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Sergio Lopez Pascual <slp@redhat.com>, "Hajnoczi, Stefan" <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Sep 21, 2020 at 1:16 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> marcandre.lureau@redhat.com writes:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Hi,
> >
> > Among the QEMU developers, there is a desire to use Rust. (see previous
> > thread from Stefan "Why QEMU should move from C to Rust", the rust-vmm
> > related projects and other experiments).
> >
> > Thanks to our QAPI type system and the associate code generator, it is
> > relatively straightforward to create Rust bindings for the generated C
> > types (also called sys/ffi binding) and functions. (rust-bindgen could
> > probably do a similar job, but it would probably bring other issues).
> > This provides an important internal API already.
> >
> > Slightly more complicated is to expose a Rust API for those, and provid=
e
> > convenient conversions C<->Rust. Taking inspiration from glib-rs
> > binding, I implemented a simplified version of the FromGlib/ToGlib
> > traits, with simpler ownership model, sufficient for QAPI needs.
> >
> > The usage is relatively simple:
> >
> > - from_qemu_none(ptr: *const sys::P) -> T
> >   Return a Rust type T for a const ffi pointer P.
> >
> > - from_qemu_full(ptr: *mut sys::P) -> T
> >   Return a Rust type T for a ffi pointer P, taking ownership.
> >
> > - T::to_qemu_none() -> Stash<P>
> >   Returns a borrowed ffi pointer P (using a Stash to destroy "glue"
> >   storage data, if any).
> >
> > - T::to_qemu_full() -> P
> >   Returns a ffi pointer P. (P resources are leaked/passed to C/ffi)
> >
> > With those traits, it's relatively easy to implement the QMP callbacks.
> > With enough interest, we could eventually start rewriting QGA in
> > Rust, as it is a simple service. See qga/qmp.rs for some examples.
> > We could also try to tackle qemu itself.
>
> Up to here, you're talking about *internal* interfaces.  Correct?
>
> Your motivation is enabling use of Rust in QEMU.  Correct?

That's the first motivation, indeed.


>
> > Finally, given that the QAPI types are easy to serialize, it was simple
> > to use "serde" on them, and provide a D-Bus interface for QMP with zbus=
.
> > (a similar approach could probably be taken for other protocols, that
> > could be dynamically loaded... anyone like protobuf better?)
>
> QMP is an *external* interface.
>
> It supports compatible evolution: we can make certain kinds of changes
> without affecting clients.  These include:
>
> * Adding optional arguments

This would change the signature of the function, and would need an
interface version bump.

Alternative: pass optional arguments as an extra dictionary. This is a
common idiom in D-Bus (the "a{sv}" type that maps strings to generic
values)

Potentially, use gvariant serialization format, which has maybe type.
But gvariant isn't implemented by most D-Bus libraries (that was the
plan long time ago, but it didn't happen as people lost interest).

> * Adding results

Also change the signature of the function.

However, since messages have boundaries, it is easy to ignore return values=
.

>
> * Adding values to an enumeration type, branches to a union or
>   alternate
>

As long as the discriminant is represented as a string, it should be fine.

> * Reordering members of enumerations, structs, unions

Again, if the discriminant is a string, it should be the same as with json.

For the members, the usage of dictionaries is required in this case
(else the type signature would change).

> * Turning an argument type into an alternate with the old type as branch

That would also change the function signature.

There isn't much solution I can think of, unless we have an implicit
tagged enum for every argument, which would be quite nasty.

>
> We've made use of this extensively.  See also
> docs/devel/qapi-code-gen.txt section "Compatibility considerations."
>
> How do such changes affect clients of the proposed D-Bus interface?

The introspection XML will always reflect the expected signature. You
should bump your interface version whenever you make incompatible
changes.

If this happens too often, we could also introduce a D-Bus override
mechanism to do manual translations from external interface to
internal.

>
> > This PoC modifies qemu-ga to provide the interface on the session bus:
> > $ qga/qemu-ga -m unix-listen -p /tmp/qga.sock -t /tmp -v
> > $ busctl --user introspect org.qemu.qga /org/qemu/qga org.qemu.QgaQapi
> > ...
> > $ busctl --user call org.qemu.qga /org/qemu/qga org.qemu.QgaQapi
> > GuestSetVcpus aa\{sv\} 1 2 logical-id x 0 online b 1
> > ...
> >
> > Note: the generated code doesn't work with the qemu schema, there is a
> > couple of fixme/todo left.
> >
> > Shameful pain point: meson & cargo don't play nicely together.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>


