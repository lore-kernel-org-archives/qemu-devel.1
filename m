Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04281C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 10:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E80218AC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 10:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqgPORe0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E80218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKIng-0001CT-7y
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 06:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kKIn4-0000ls-OR
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 06:11:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kKIn2-00084X-6T
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 06:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600683078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3tYn0M9ZbVFUwstVraHWYbsz+Jyg/XGk8p/IOViGnk=;
 b=NqgPORe0Ml7lnkGr8W3p/o2nGN6seB+qs/JppqI+2plx4WBxwPTu2qwCMeen//jAUcOIa/
 3OSYja9AmAM48HHpxb7r0LCVtQHTocQIwwZptdFCljEURxBr3nb/OKB0xlUMR32Mm88eLN
 yYbG3ho8RlnAeeStQk/DK6Wnd7BFf88=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-HdP4Ld0lP828ZTwdGf4q0A-1; Mon, 21 Sep 2020 06:11:17 -0400
X-MC-Unique: HdP4Ld0lP828ZTwdGf4q0A-1
Received: by mail-il1-f200.google.com with SMTP id d16so10502923ila.23
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 03:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=X3tYn0M9ZbVFUwstVraHWYbsz+Jyg/XGk8p/IOViGnk=;
 b=SeKmMmxayH2DRd0q4c7P4bmB3X23MQx06qQEg4FFMLS2XJzkr521R35D6aq6ttn8gH
 CJcJblFqo7IpKw9TvL1/Y7wjjimL8VlDBAU4kEjADl/uX+1Nzz/HTzygulSXhID8jWaf
 jnGtZZiSbAb1qCz9n6J4UdPw+bjpadK3X2YJrudLvfHEvlMuYvuZeJ9RSke+yGWe1F4c
 gEDnifY1txyUdrkVt8L9NSY8KIHn3zViIYuNfDqQAATIscJBEVrRVBgkDLCr3KaRw4MS
 z2P0mn0lJCovAKtezm05iTE6PPu+tOkwPqyVwqnjVWRBj0XVYqPOTp3xETEeh5rENIrw
 zYPw==
X-Gm-Message-State: AOAM533WIBeHK9hdgqaUIae5EqRCEYWxFLog2CVW6cfBwZSZa0q/3w0T
 TerG4O39LR1YOt4X2PEFjqwLvXQI3VCg+aHoIznksk3lQ/WMoT4CELqK8aldDgOZDtbEU2GWDV2
 mYCsRIJy951bvnNgj6QzN8dodVw1k01g=
X-Received: by 2002:a02:2b2f:: with SMTP id h47mr10280267jaa.79.1600683076393; 
 Mon, 21 Sep 2020 03:11:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnmmv75ZWMkhe4ddSAeGm0q1mjHfeRUvgSDeTrXvecVgfIWt4qh84wF/SonhDJxbDoNszV0PnHdZk7JrhQUAE=
X-Received: by 2002:a02:2b2f:: with SMTP id h47mr10280255jaa.79.1600683076132; 
 Mon, 21 Sep 2020 03:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <87mu1j8p7p.fsf@dusky.pond.sub.org>
In-Reply-To: <87mu1j8p7p.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 21 Sep 2020 14:11:05 +0400
Message-ID: <CAMxuvay_mQjukGvinb6ur+8z-YyKxu=BdquuF=+yf+UrNmmd2A@mail.gmail.com>
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: Markus Armbruster <armbru@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
>
> * Adding results
>
> * Adding values to an enumeration type, branches to a union or
>   alternate
>
> * Reordering members of enumerations, structs, unions
>
> * Turning an argument type into an alternate with the old type as branch
>
> We've made use of this extensively.  See also
> docs/devel/qapi-code-gen.txt section "Compatibility considerations."
>
> How do such changes affect clients of the proposed D-Bus interface?
>

It's not just about the D-Bus interface though.

QMP being JSON, being lazily typed: everytime we make such changes, we
inflict some pain to all the QMP bindings that want to have a
statically checked & native version of the interface. Iow, we should
think twice before doing any of this.

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


