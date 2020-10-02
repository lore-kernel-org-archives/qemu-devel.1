Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3D0C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 06:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4BA4206DD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 06:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJJtE86M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BA4206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOEzB-0002hX-Ma
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 02:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOEya-00025I-Lm
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 02:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOEyZ-0007RO-0g
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 02:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601621729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3VIn9U7JdE8+w7OYcWYkoviZMu91KGiodi8TfYJ2Aig=;
 b=jJJtE86MwfnRrCRnqavwTcO2FaNACp6dRddrF062l7iY3cKs6tEmU83wmjl4RB06VvhNt/
 kB574uULk4hM0FKdkSiYayEUHLTtpWVFzDP6RRZZjqlRBL2lBJQAVtb5N+K/L1USzQcG+I
 R+fyIvsjgVyZ16wiBT/bglVqbFMQSH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-b9uNPQVkMyukqo7atQAW7Q-1; Fri, 02 Oct 2020 02:55:25 -0400
X-MC-Unique: b9uNPQVkMyukqo7atQAW7Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 369A08015FD;
 Fri,  2 Oct 2020 06:55:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2DA35C1D0;
 Fri,  2 Oct 2020 06:55:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3F8911132784; Fri,  2 Oct 2020 08:55:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v4 3/3] target/i386: Restrict X86CPUFeatureWord to X86
 targets
References: <20201001144152.1555659-1-philmd@redhat.com>
 <20201001144152.1555659-4-philmd@redhat.com>
 <20201001152905.GC3717385@habkost.net>
Date: Fri, 02 Oct 2020 08:55:22 +0200
In-Reply-To: <20201001152905.GC3717385@habkost.net> (Eduardo Habkost's message
 of "Thu, 1 Oct 2020 11:29:05 -0400")
Message-ID: <87pn61ruat.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Thu, Oct 01, 2020 at 04:41:52PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Only qemu-system-FOO and qemu-storage-daemon provide QMP
>> monitors, therefore such declarations and definitions are
>> irrelevant for user-mode emulation.
>>=20
>> Restricting the x86-specific commands to machine-target.json
>> pulls less QAPI-generated code into user-mode.
>
> Is this still true without "qapi: Restrict code generated for
> user-mode"?
>
> Markus, Eric: what's the difference between machine.json and
> machine-target.json? commit 7f7b4e7abef4 ("qapi: Split
> machine-target.json off target.json and misc.json") explains what
> but not why.

My bad.

Short explanation: machine-target.json can use preprocessor symbols with
'if' that are only available in target-specific code: TARGET_S390X,
TARGET_I386, TARGET_ARM, ...  This requires compiling per target.
machine.json can't use these, because it's compiled just once.

Same for misc-target.json and misc.json.


Now the long explanation.

The clue is buried in the patch:

    diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
    index 01dced01aa..4e87bef6e1 100644
    --- a/qapi/Makefile.objs
    +++ b/qapi/Makefile.objs
    @@ -9,7 +9,7 @@ QAPI_COMMON_MODULES =3D audio authz block-core block ch=
ar common crypto
     QAPI_COMMON_MODULES +=3D introspect job machine migration misc net
     QAPI_COMMON_MODULES +=3D qdev qom rdma rocker run-state sockets tpm
     QAPI_COMMON_MODULES +=3D trace transaction ui
    -QAPI_TARGET_MODULES =3D target
    +QAPI_TARGET_MODULES =3D machine-target target
     QAPI_MODULES =3D $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)

     util-obj-y +=3D qapi-builtin-types.o

QAPI_TARGET_MODULES appears in commit 61eb9e80d5:

    qapi: New module target.json
   =20
    We can't add appropriate target-specific conditionals to misc.json,
    because that would make all of misc.json unusable in
    target-independent code.  To keep misc.json target-independent, we
    need to split off target-dependent target.json.
   =20
    This commit doesn't actually split off anything, it merely creates the
    empty module.  The next few patches will move stuff from misc.json
    there.
   =20
    Signed-off-by: Markus Armbruster <armbru@redhat.com>

Aha: it's about compiling per target, to make target-specific
conditionals available.

This part of qapi/Makefile.objs has since morphed into

    qapi_inputs =3D []
    qapi_specific_outputs =3D []
    foreach module : qapi_all_modules
      qapi_inputs +=3D [ files(module + '.json') ]
      qapi_module_outputs =3D [
      ...
      ]
      if module.endswith('-target')
        qapi_specific_outputs +=3D qapi_module_outputs
      else
        qapi_util_outputs +=3D qapi_module_outputs
      endif
    endforeach

in qapi/meson.build.  Further down:

    # Now go through all the outputs and add them to the right sourceset.
    # These loops must be synchronized with the output of the above custom =
target.

    i =3D 0
    foreach output : qapi_util_outputs
      if output.endswith('.h')
        genh +=3D qapi_files[i]
      endif
      util_ss.add(qapi_files[i])
      i =3D i + 1
    endforeach

    foreach output : qapi_specific_outputs + qapi_nonmodule_outputs
      if output.endswith('.h')
        genh +=3D qapi_files[i]
      endif
      specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: qapi_files[i])
      i =3D i + 1
    endforeach

The source files generated for the "common" modules are added to
sourceset util_ss, and the ones for the "target" modules are added to
sourceset specific_ss.

The former gets compiled just once, and the .o get linked into pretty
much everything.

The latter gets compiled per target, and the .o get linked into
target-specific executables.

Clear as mud?

[...]


