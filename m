Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447F0C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:38:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 147652253D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ru20guE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147652253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itug2-0005Ja-Js
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ituQI-00025a-MD
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:22:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ituQC-0006jB-VX
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:22:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24302
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ituQC-0006iv-Rl
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579616544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UfMhshM0mcPxouUCDsPD4cOne8kBy6qJlgZycgFRx2w=;
 b=Ru20guE2yL9NVYPuo5Z5EjMUM9yyWw2JfpSA+rbwXBaIDSYreXX2fGwCw2JFogF54HiuFY
 w+wwougS21b9d6GBVo2U0UkH/RaVffDWlp/xEp49Gspv6N0yaTwO6Ci3JyzCkTN83Mz8ZF
 P30VCn+D1e+MopEv8vKoyXNIkZh7dOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-LB_AN02zMw-KR23v4dn-Kg-1; Tue, 21 Jan 2020 09:22:22 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCB3D100550E
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 14:22:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA69C1001901;
 Tue, 21 Jan 2020 14:22:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 709F51138600; Tue, 21 Jan 2020 15:22:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] qapi: Incorrect attempt to fix building with
 MC146818RTC=n
References: <20191231184916.10235-1-philmd@redhat.com>
 <875zhfzc9l.fsf@dusky.pond.sub.org>
 <a06fd97c-b149-2f24-1180-4e4efa8ff79d@redhat.com>
 <87wo9ll5on.fsf@dusky.pond.sub.org>
 <b0559940-7b97-901b-5729-587d8649eede@redhat.com>
Date: Tue, 21 Jan 2020 15:22:17 +0100
In-Reply-To: <b0559940-7b97-901b-5729-587d8649eede@redhat.com> (Paolo
 Bonzini's message of "Tue, 21 Jan 2020 09:16:56 +0100")
Message-ID: <87lfq0c2jq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: LB_AN02zMw-KR23v4dn-Kg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 21/01/20 06:49, Markus Armbruster wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>=20
>>> On 13/01/20 15:01, Markus Armbruster wrote:
>>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>>>
>>>>> When configured with --without-default-devices and setting
>>>>> MC146818RTC=3Dn, the build fails:
>>>>>
>>>>>     LINK    x86_64-softmmu/qemu-system-x86_64
>>>>>   /usr/bin/ld: qapi/qapi-commands-misc-target.o: in function `qmp_mar=
shal_rtc_reset_reinjection':
>>>>>   qapi/qapi-commands-misc-target.c:46: undefined reference to `qmp_rt=
c_reset_reinjection'
>>>>>   /usr/bin/ld: qapi/qapi-commands-misc-target.c:46: undefined referen=
ce to `qmp_rtc_reset_reinjection'
>>>>>   collect2: error: ld returned 1 exit status
>>>>>   make[1]: *** [Makefile:206: qemu-system-x86_64] Error 1
>>>>>   make: *** [Makefile:483: x86_64-softmmu/all] Error 2
>>>>>
>>>>> This patch tries to fix this, but this is incorrect because QAPI
>>>>> scripts only provide TARGET definitions, so with MC146818RTC=3Dy we
>>>>> get:
>>>>>
>>>>>   hw/rtc/mc146818rtc.c:113:6: error: no previous prototype for =E2=80=
=98qmp_rtc_reset_reinjection=E2=80=99 [-Werror=3Dmissing-prototypes]
>>>>>     113 | void qmp_rtc_reset_reinjection(Error **errp)
>>>>>         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>   cc1: all warnings being treated as errors
>>>>>   make[1]: *** [rules.mak:69: hw/rtc/mc146818rtc.o] Error 1
>>>>>
>>>>> Any idea? :)
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>>> ---
>>>>>  qapi/misc-target.json | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>>>>> index a00fd821eb..8e49c113d1 100644
>>>>> --- a/qapi/misc-target.json
>>>>> +++ b/qapi/misc-target.json
>>>>> @@ -41,7 +41,7 @@
>>>>>  #
>>>>>  ##
>>>>>  { 'command': 'rtc-reset-reinjection',
>>>>> -  'if': 'defined(TARGET_I386)' }
>>>>> +  'if': 'defined(TARGET_I386) && defined(CONFIG_MC146818RTC)' }
>>>>> =20
>>>>> =20
>>>>>  ##
>>>>
>>>> The generated qapi-commands-misc-target.h duly has
>>>>
>>>>     #if defined(TARGET_I386) && defined(CONFIG_MC146818RTC)
>>>>     void qmp_rtc_reset_reinjection(Error **errp);
>>>>     void qmp_marshal_rtc_reset_reinjection(QDict *args, QObject **ret,=
 Error **errp);
>>>>     #endif /* defined(TARGET_I386) && defined(CONFIG_MC146818RTC) */
>>>>
>>>> mc146818rtc.c includes it.  But since it doesn't include
>>>> config-devices.h, CONFIG_MC146818RTC remains undefined, and the
>>>> prototype gets suppressed.
>>>>
>>>> Crude fix: make mc146818rtc.c #include "config-devices.h".
>>>
>>> Can we modify the code generator to leave out the #if from the header,
>>> and only include it in the .c file?  An extra prototype is harmless.
>>=20
>> Is *everything* we generate into headers just as harmless?
>
> It should be, since it's just the C version of some JSON.  The only
> problematic thing could be different definitions of the same command for
> multiple targets, and I think we want to avoid that anyway.
>
> To see it a different way, these are the "C bindings" to QMP, just that
> the implementation is an in-process call rather than RPC.  If the QAPI
> code generator was also able to generate Python bindings and the like,
> they would have to be the same for all QEMU binaries, wouldn't they?

Ommitting the kind of #if we've been discussing is relatively harmless:

    #if defined(TARGET_I386)
    void qmp_rtc_reset_reinjection(Error **errp);
    void qmp_marshal_rtc_reset_reinjection(QDict *args, QObject **ret, Erro=
r **errp);
    #endif /* defined(TARGET_I386) */

But what about this one, in qapi-types-block-core.h:

    typedef enum BlockdevDriver {
        BLOCKDEV_DRIVER_BLKDEBUG,
        [...]
    #if defined(CONFIG_REPLICATION)
        BLOCKDEV_DRIVER_REPLICATION,
    #endif /* defined(CONFIG_REPLICATION) */
        [...]
        BLOCKDEV_DRIVER__MAX,
    } BlockdevDriver;

If I omit it in the header, I then have to omit it in
qapi-types-block-core.c's

    const QEnumLookup BlockdevDriver_lookup =3D {
        .array =3D (const char *const[]) {
            [BLOCKDEV_DRIVER_BLKDEBUG] =3D "blkdebug",
            [...]
    #if defined(CONFIG_REPLICATION)
            [BLOCKDEV_DRIVER_REPLICATION] =3D "replication",
    #endif /* defined(CONFIG_REPLICATION) */
            [...]
        },
        .size =3D BLOCKDEV_DRIVER__MAX
    };

and God knows what else.  But I must not omit it in qapi-introspect.c's

        QLIT_QDICT(((QLitDictEntry[]) {
            { "meta-type", QLIT_QSTR("enum"), },
            { "name", QLIT_QSTR("245"), },
            { "values", QLIT_QLIST(((QLitObject[]) {
                QLIT_QSTR("blkdebug"),
                [...]
    #if defined(CONFIG_REPLICATION)
                QLIT_QSTR("replication"),
    #endif /* defined(CONFIG_REPLICATION) */
                [...]
                {}
            })), },
            {}
        })),

because that would defeat introspection.

I smell a swamp.

I'd rather not complicate the generator to support not including a
header I feel we *should* include.  #ifdef CONFIG_FOO can occur not just
in QAPI-generated code, and neglecting to include the relevant header
can cause *nasty* problems not just in QAPI-generated code.  Like
inconsistent struct definitions in separate compilation units.  Been
there, debugged that, wasn't fun, do not want to go there again.


