Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DDCC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B9A214F1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Im7/gVgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B9A214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKHxR-0000gZ-Je
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 05:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKHvs-00086r-Ph
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:16:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44603
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKHvq-0008If-Sh
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600679781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q4DLeSX4c4qeoNRuPbh+Lob+ar95x/GhSFvR/Wl8UFQ=;
 b=Im7/gVgHZ7BIHXUz0Nta6bAe0H8OT02nXT24wI8aeTDdDuNLLFGwvO/K8nlLfF8NAmkl8z
 eY9iYNk2EGH3sohZ9uK64VMe6EuG0w7BFntJ8fFAnse6eFbf+oF1IAq4X9QnpthcbzzLFB
 7PGtMfTggtDAsc0fgTpkTzz+eSIf8x0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-qDWsSJ0cNe6Z0oalc0x0XA-1; Mon, 21 Sep 2020 05:16:19 -0400
X-MC-Unique: qDWsSJ0cNe6Z0oalc0x0XA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B167818C520D;
 Mon, 21 Sep 2020 09:16:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32CEB26359;
 Mon, 21 Sep 2020 09:16:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BBD5B1132E9A; Mon, 21 Sep 2020 11:16:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: marcandre.lureau@redhat.com
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
Date: Mon, 21 Sep 2020 11:16:10 +0200
In-Reply-To: <20200910174850.716104-1-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Thu, 10 Sep 2020 21:48:50 +0400")
Message-ID: <87mu1j8p7p.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 04:38:52
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
Cc: berrange@redhat.com, slp@redhat.com, stefanha@gmail.com,
 qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Hi,
>
> Among the QEMU developers, there is a desire to use Rust. (see previous
> thread from Stefan "Why QEMU should move from C to Rust", the rust-vmm
> related projects and other experiments).
>
> Thanks to our QAPI type system and the associate code generator, it is
> relatively straightforward to create Rust bindings for the generated C
> types (also called sys/ffi binding) and functions. (rust-bindgen could
> probably do a similar job, but it would probably bring other issues).
> This provides an important internal API already.
>
> Slightly more complicated is to expose a Rust API for those, and provide
> convenient conversions C<->Rust. Taking inspiration from glib-rs
> binding, I implemented a simplified version of the FromGlib/ToGlib
> traits, with simpler ownership model, sufficient for QAPI needs.
>
> The usage is relatively simple:
>
> - from_qemu_none(ptr: *const sys::P) -> T
>   Return a Rust type T for a const ffi pointer P.
>
> - from_qemu_full(ptr: *mut sys::P) -> T
>   Return a Rust type T for a ffi pointer P, taking ownership.
>
> - T::to_qemu_none() -> Stash<P>
>   Returns a borrowed ffi pointer P (using a Stash to destroy "glue"
>   storage data, if any).
>
> - T::to_qemu_full() -> P
>   Returns a ffi pointer P. (P resources are leaked/passed to C/ffi)
>
> With those traits, it's relatively easy to implement the QMP callbacks.
> With enough interest, we could eventually start rewriting QGA in
> Rust, as it is a simple service. See qga/qmp.rs for some examples.
> We could also try to tackle qemu itself.

Up to here, you're talking about *internal* interfaces.  Correct?

Your motivation is enabling use of Rust in QEMU.  Correct?

> Finally, given that the QAPI types are easy to serialize, it was simple
> to use "serde" on them, and provide a D-Bus interface for QMP with zbus.
> (a similar approach could probably be taken for other protocols, that
> could be dynamically loaded... anyone like protobuf better?)

QMP is an *external* interface.

It supports compatible evolution: we can make certain kinds of changes
without affecting clients.  These include:

* Adding optional arguments

* Adding results

* Adding values to an enumeration type, branches to a union or
  alternate

* Reordering members of enumerations, structs, unions

* Turning an argument type into an alternate with the old type as branch

We've made use of this extensively.  See also
docs/devel/qapi-code-gen.txt section "Compatibility considerations."

How do such changes affect clients of the proposed D-Bus interface?

> This PoC modifies qemu-ga to provide the interface on the session bus:
> $ qga/qemu-ga -m unix-listen -p /tmp/qga.sock -t /tmp -v
> $ busctl --user introspect org.qemu.qga /org/qemu/qga org.qemu.QgaQapi
> ...
> $ busctl --user call org.qemu.qga /org/qemu/qga org.qemu.QgaQapi
> GuestSetVcpus aa\{sv\} 1 2 logical-id x 0 online b 1
> ...
>
> Note: the generated code doesn't work with the qemu schema, there is a
> couple of fixme/todo left.
>
> Shameful pain point: meson & cargo don't play nicely together.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


