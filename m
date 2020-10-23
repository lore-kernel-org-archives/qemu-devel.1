Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DEDC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1949A20E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UprbPCEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1949A20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVwcQ-0007TT-SL
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kVwVx-0001xk-ST
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 08:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57279)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kVwVv-0005I9-Nb
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 08:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603457382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1EddXofB5atc90cqCT8Fqz27tAmaV8Qbum7txcz7I4=;
 b=UprbPCEztLPiAr89DAkZ4i0XUzhdCzmF1w+HFcKAB5Hd6QNTOgxBiqbZ0mxNrNoWnMZiEi
 a5rQISOaeQOqvool/BdttNbUu3iB303amjKPERGCPNK4qahzjeutHcK646YIOSEPMa2c0G
 fdfrzZZGsZBVvt59QUP/NeCA4Ni70vo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-loC-I-ThMNyH7op_5MIFqw-1; Fri, 23 Oct 2020 08:49:39 -0400
X-MC-Unique: loC-I-ThMNyH7op_5MIFqw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C69D5F9DA;
 Fri, 23 Oct 2020 12:49:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E93B05D9CC;
 Fri, 23 Oct 2020 12:49:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 738D8113865F; Fri, 23 Oct 2020 14:49:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 3/6] qapi: Remove wrapper struct for simple unions
References: <20201023101222.250147-1-kwolf@redhat.com>
 <20201023101222.250147-4-kwolf@redhat.com>
 <CAJ+F1CJAzbRwab5E7XQUEpTXX1e+DE_QkknoEgvYqmHAeqY2MQ@mail.gmail.com>
Date: Fri, 23 Oct 2020 14:49:36 +0200
In-Reply-To: <CAJ+F1CJAzbRwab5E7XQUEpTXX1e+DE_QkknoEgvYqmHAeqY2MQ@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 23 Oct 2020
 14:40:23 +0400")
Message-ID: <87h7qlp0nz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>, "open list:Block
 layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Fri, Oct 23, 2020 at 2:14 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
>> Variants of simple unions are always contained in a wrapper object
>> called 'data' that serves no real use. When mapping a QAPI object to the
>> command line, this becomes very visible to users because they have to
>> add one or more useless 'data.' to many option names.
>>
>> As a first step towards avoiding this painful CLI experience, this gets
>> rid of the 'data' indirection internally: The QAPI parser doesn't use a
>> wrapper object as the variant type any more, so the indirection is
>> removed from the generated C types. As a result, the C type looks the
>> same for flat and simple unions now. A large part of this patch is
>> mechanical conversion of C code to remove the 'data' indirection.
>>
>> Conceptually, the important change is that variants can now have flat
>> and wrapped representations. For a transitioning period, we'll allow
>> variants to support both representations in a later patch. Eventually,
>> the plan is to deprecate and remove wrapped representations entirely,
>> unifying simple and flat unions.
>>
>> The externally visible interfaces stay unchanged: Visitors still expect
>> the 'data' wrappers, and introspection still shows it.
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>
>
> breaks the build for me:
>
> ../chardev/spice.c: In function =E2=80=98qemu_chr_open_spice_vmc=E2=80=99=
:
> ../chardev/spice.c:261:56: error: =E2=80=98ChardevSpiceChannel=E2=80=99 h=
as no member named
> =E2=80=98data=E2=80=99
>   261 |     ChardevSpiceChannel *spicevmc =3D backend->u.spicevmc.data;
>       |                                                        ^
> ../chardev/spice.c: In function =E2=80=98qemu_chr_open_spice_port=E2=80=
=99:
> ../chardev/spice.c:297:55: error: =E2=80=98ChardevSpicePort=E2=80=99 has =
no member named
> =E2=80=98data=E2=80=99
>   297 |     ChardevSpicePort *spiceport =3D backend->u.spiceport.data;
>       |                                                       ^
> ../chardev/spice.c: In function =E2=80=98qemu_chr_parse_spice_vmc=E2=80=
=99:
> ../chardev/spice.c:331:35: error: =E2=80=98ChardevSpiceChannel=E2=80=99 h=
as no member named
> =E2=80=98data=E2=80=99
>   331 |     spicevmc =3D backend->u.spicevmc.data =3D
> g_new0(ChardevSpiceChannel, 1);
>       |                                   ^
> ../chardev/spice.c: In function =E2=80=98qemu_chr_parse_spice_port=E2=80=
=99:
> ../chardev/spice.c:347:37: error: =E2=80=98ChardevSpicePort=E2=80=99 has =
no member named
> =E2=80=98data=E2=80=99
>   347 |     spiceport =3D backend->u.spiceport.data =3D
> g_new0(ChardevSpicePort, 1);
>       |                                     ^
> ../ui/spice-app.c: In function =E2=80=98chr_spice_backend_new=E2=80=99:
> ../ui/spice-app.c:63:20: error: =E2=80=98ChardevSpicePort=E2=80=99 has no=
 member named
> =E2=80=98data=E2=80=99
>    63 |     be->u.spiceport.data =3D g_new0(ChardevSpicePort, 1);
>       |                    ^
> ../ui/spice-app.c: In function =E2=80=98vc_chr_open=E2=80=99:
> ../ui/spice-app.c:86:20: error: =E2=80=98ChardevSpicePort=E2=80=99 has no=
 member named
> =E2=80=98data=E2=80=99
>    86 |     be->u.spiceport.data->fqdn =3D fqdn ?
>       |                    ^
> ../ui/spice-app.c: In function =E2=80=98spice_app_display_init=E2=80=99:
> ../ui/spice-app.c:185:20: error: =E2=80=98ChardevSpicePort=E2=80=99 has n=
o member named
> =E2=80=98data=E2=80=99
>   185 |     be->u.spiceport.data->fqdn =3D g_strdup("org.qemu.monitor.qmp=
.0");
>       |                    ^

In addition to that, I get

    /usr/bin/sphinx-build-3 -Dversion=3D5.1.50 -Drelease=3D -Ddepfile=3Ddoc=
s/interop.d -Ddepfile_stamp=3Ddocs/interop.stamp -b html -d /work/armbru/qe=
mu/bld-x86/docs/interop.p /work/armbru/qemu/docs/interop /work/armbru/qemu/=
bld-x86/docs/interop
    Running Sphinx v2.2.2
    building [mo]: targets for 0 po files that are out of date
    building [html]: targets for 12 source files that are out of date
    updating environment: [new config] 12 added, 0 changed, 0 removed
    reading sources... [  8%] bitmaps
    reading sources... [ 16%] dbus
    reading sources... [ 25%] dbus-vmstate
    reading sources... [ 33%] index
    reading sources... [ 41%] live-block-operations
    reading sources... [ 50%] pr-helper
    reading sources... [ 58%] qemu-ga
    reading sources... [ 66%] qemu-ga-ref
    reading sources... [ 75%] qemu-qmp-ref

    Exception occurred:
      File "/work/armbru/qemu/docs/sphinx/qapidoc.py", line 187, in _nodes_=
for_members
        assert not v.type.base and not v.type.variants
    AttributeError: 'QAPISchemaBuiltinType' object has no attribute 'base'
    The full traceback has been saved in /tmp/sphinx-err-fq8tq1i7.log, if y=
ou want to report the issue to the developers.
    Please also report this if it was a user error, so that a better error =
message can be provided next time.
    A bug report can be filed in the tracker at <https://github.com/sphinx-=
doc/sphinx/issues>. Thanks!


