Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDA7C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 15:39:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F3672220D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 15:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjXEvEVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3672220D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKkNz-0001Ta-38
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 11:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKkM6-0000nX-Jq
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 11:37:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKkM4-0000N8-AH
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 11:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600789037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o4y8hIkhcGEDTSMmYZ6xf9Tn5l5Eb/EotfI2zO2uSck=;
 b=EjXEvEVMnpy9pAwN8McEEohtuHPRpbxe5E627HFXMR9DtTeH7aqm3J9qGt93h5F3+8V8OV
 zhkB/ZVnnyTyQPtTNRJe/Crsnp24gIZAQ5vmguBG+edGEIa8SiNTJ6fTSAZqfSAkydDtQr
 Z+bl/5Z7Jt5LCMdE4nymp1EDNaT1uq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-d7TnPjO2PVGtRhOIKJVi9g-1; Tue, 22 Sep 2020 11:37:15 -0400
X-MC-Unique: d7TnPjO2PVGtRhOIKJVi9g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 695C41882FBB;
 Tue, 22 Sep 2020 15:37:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B187160C04;
 Tue, 22 Sep 2020 15:37:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 479D91132E9A; Tue, 22 Sep 2020 17:37:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <87mu1j8p7p.fsf@dusky.pond.sub.org>
 <CAMxuvay_mQjukGvinb6ur+8z-YyKxu=BdquuF=+yf+UrNmmd2A@mail.gmail.com>
Date: Tue, 22 Sep 2020 17:37:07 +0200
In-Reply-To: <CAMxuvay_mQjukGvinb6ur+8z-YyKxu=BdquuF=+yf+UrNmmd2A@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 21 Sep 2020
 14:11:05 +0400")
Message-ID: <87y2l1kel8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
 Sergio Lopez Pascual <slp@redhat.com>, "Hajnoczi, Stefan" <stefanha@gmail.com>,
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
[...]
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
>>
>> * Adding results
>>
>> * Adding values to an enumeration type, branches to a union or
>>   alternate
>>
>> * Reordering members of enumerations, structs, unions
>>
>> * Turning an argument type into an alternate with the old type as branch
>>
>> We've made use of this extensively.  See also
>> docs/devel/qapi-code-gen.txt section "Compatibility considerations."
>>
>> How do such changes affect clients of the proposed D-Bus interface?
>>
>
> It's not just about the D-Bus interface though.
>
> QMP being JSON, being lazily typed: everytime we make such changes, we
> inflict some pain to all the QMP bindings that want to have a
> statically checked & native version of the interface. Iow, we should
> think twice before doing any of this.

Having to think twice before doing something we need to do all the time
would slow us down.  I don't think this is going to fly.

QMP is designed to avoid tight coupling of server (i.e. QEMU) and
client.  In particular, we don't want "you have to upgrade both in
lockstep".

A well-behaved client works fine even when it's written for a somewhat
older or newer QMP than the server provides.  "Somewhat" because we
deprecate and eventually remove stuff.  Graceful degradation when the
gap gets too large.

There's a gap between the "lose" wire format, and a "tight" statically
typed internal interface.  The gap exists in QEMU, and we bridge it.
Clients can do the same.  Libvirt does: it provides a statically typed
version of the interface without undue coupling.

Replacing the "lose" wire format by something "tighter" like D-Bus
shrinks the gap.  Good.  It also tightens the coupling.  Bad.

[...]


