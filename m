Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA54C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 08:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CBAC20781
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 08:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlVDyDOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CBAC20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaECI-000377-8r
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 03:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kaEB9-0002bu-Cj
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 03:30:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kaEB6-0003za-KM
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 03:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604478598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FTK4DVL+/BudT+tBksiB6zqLjeIMD0mY53n9LTO95oo=;
 b=SlVDyDOv2i3eaeRTwcu0mzDC7xIrnnRYptgTKlgeDG7s2vNTO/k6+XbmbPLX1kFStA12Yu
 IQisVA0qETRF3jGPZ0elVLd4isqS9kFKYZj2ubBfgNIG8wXBZLNKOSBepvpd6RJHEj7EiC
 yqcBbysCZwnhZNUbK9z/4XZ57UWxNMo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-T0e2US8qNkGPxFMqip5aHA-1; Wed, 04 Nov 2020 03:29:56 -0500
X-MC-Unique: T0e2US8qNkGPxFMqip5aHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AAB257202
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 08:29:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BECF173672;
 Wed,  4 Nov 2020 08:29:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0A0FC1132BD6; Wed,  4 Nov 2020 09:29:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] qapi, qemu-options: make all parsing visitors parse
 boolean options the same
References: <20201103161339.447118-1-pbonzini@redhat.com>
 <20201103162551.GQ205187@redhat.com>
 <e950af86-c45d-4165-a9f2-85ee6e845b01@redhat.com>
Date: Wed, 04 Nov 2020 09:29:54 +0100
In-Reply-To: <e950af86-c45d-4165-a9f2-85ee6e845b01@redhat.com> (Paolo
 Bonzini's message of "Tue, 3 Nov 2020 17:33:47 +0100")
Message-ID: <871rh91q4d.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 03/11/20 17:25, Daniel P. Berrang=C3=A9 wrote:
>>> OptsVisitor, StringInputVisitor and the keyval visitor have
>>> three different ideas of how a human could write the value of
>>> a boolean option.  Pay homage to the backwards-compatibility
>>> gods and make the new common helper accept all four sets (on/off,
>>> true/false, y/n and yes/no), and case-insensitive at that.
>>>
>>> Since OptsVisitor is supposed to match qemu-options, adjust
>>> it as well.
>> FWIW, libvirt does not appear to use true/false or y/n, nor
>> ever use uppercase / mixed case.
>>=20
>> IOW this level of back compat may well be overkill.
>>=20
>> I'd particular suggest deprecating case-insensitivity, as
>> Yes, YES, yEs feel unlikely to be important or widely used.
>
> True; at least it's type-safe code unlike the short-form boolean option.
>  It only hurts in the odd case of a boolean option becoming on/off/auto
> or on/off/split.

Another argument for deprecating values other than "on" and "off".

> I didn't want to introduce deprecation at this point, because

Not wanting to rush deprecation this close to the release is a valid
point.  So is not wanting to rush in additional sugar :)

> consistency is better anyway even if we plan to later deprecate
> something.  For example, since there is a common parser now, introducing
> deprecation would be much easier.  It also lets us switch parsers even
> during the deprecation period (which is how I got into this mess).

On the other hand, we'll have more to deprecate.  Status quo:


                      on/off  yes/no     y/n  true/false  case-sensitive?
qemu_opt_get_bool()     X                                 no
keyval visitor          X                                 no
string visitor          X        X                X       yes
opts visitor            X        X        X               no

For once, there is no way to blame QemuOpts ;)

qemu_opt_get_bool() is everywhere in CLI and HMP.

The keyval visitor is used for QAPIfied human-friendly interfaces: block
stuff, -display, -audio.

The string input visitor is used for -object, -global, HMP object_add,
qom-set, migrate_set_parameter.

The opts visitor is used for -mon and its sugared forms (new in 5.2!),
-net, -netdev, -acpitable, -numa.

I'd very much prefer to deprecate the odd ones in string and opts
visitor, and not copy them elsewhere.

We can still factor out a common parsing function if we like: pass a
flag that makes it recognize deprecated forms.  A single flag should
suffice; it lets odd ones spread from string to opts visitor and vice
versa, which I find tolerable.


