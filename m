Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D560C3F2CF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 06:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB16222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 06:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwYzbgnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB16222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ZaF-00062N-0X
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 01:57:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j7ZZZ-0005ZT-Bl
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 01:56:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j7ZZX-0005DA-3b
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 01:56:32 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39932
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j7ZZW-0005Cn-Px
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 01:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582872989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pVA+QQCIg7tKYuY9WqFlXZMTL1JO2oGyEGO77mCT/ZE=;
 b=TwYzbgnZu4RNZngGQIkktDXR24NZBfoTjpv4euDM5c01MdJ8kW2Q2fboFOAg7pYR8hSYcJ
 nkbd47esFvvyURp89g8RJFj+KhXbZbFvraM6bxSW4IW0uXkt14BrPd0IMpB3EOo+OSqo0W
 U1fHMTx+x1mprTmtxDa547ToHpHjsWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-Z9DCZ7e8NG-stU1xuMzSXA-1; Fri, 28 Feb 2020 01:56:22 -0500
X-MC-Unique: Z9DCZ7e8NG-stU1xuMzSXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 377B518AB2C0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 06:56:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D236B39E;
 Fri, 28 Feb 2020 06:56:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B2F411386A6; Fri, 28 Feb 2020 07:56:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] qapi/machine: Place the 'Notes' tag after the 'Since'
 tag
References: <20200227134019.6218-1-philmd@redhat.com>
 <87tv3cozfw.fsf@dusky.pond.sub.org>
 <c27cdab5-23a9-78f4-994a-49aaf96eb487@redhat.com>
 <49248832-6ce3-a545-0ee3-8bd3ce664725@redhat.com>
Date: Fri, 28 Feb 2020 07:56:19 +0100
In-Reply-To: <49248832-6ce3-a545-0ee3-8bd3ce664725@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 27 Feb 2020 16:21:56
 +0100")
Message-ID: <87tv3bmc8c.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 2/27/20 3:55 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 2/27/20 3:52 PM, Markus Armbruster wrote:
>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>>
>>>> This fixes when adding a 'Since' tag:
>>>>
>>>> =C2=A0=C2=A0 In file included from qapi/qapi-schema.json:105:
>>>> =C2=A0=C2=A0 qapi/machine.json:25:1: '@arch:' can't follow 'Notes' sec=
tion
>>>
>>> I'm confused.=C2=A0 This error is detected in scripts/qapi/parser.py, a=
nd it
>>> is fatal.=C2=A0 Is the build broken for you?=C2=A0 It isn't for me.=C2=
=A0 Moreover,
>>> where is @arch?=C2=A0 I can't see it anywhere close to the two spots th=
e
>>> patch patches.
>>
>> I get the error after trying to fix what Eric commented here:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg682344.html
>
> Using:
> ---
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 6c11e3cf3a..40a36d6276 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -20,13 +20,15 @@
>  #        prefix to produce the corresponding QEMU executable name. This
>  #        is true even for "qemu-system-x86_64".
>  #
> +# @rx: since 5.0
> +#
>  # Since: 3.0
>  ##
>  { 'enum' : 'SysEmuTarget',
>    'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
>               'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>               'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
> -             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
> +             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
>               'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>               'x86_64', 'xtensa', 'xtensaeb' ] }
> ---
>
> or
>
> ---
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 6c11e3cf3a..4b59e87b6f 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -21,12 +21,14 @@
>  #        is true even for "qemu-system-x86_64".
>  #
>  # Since: 3.0
> +#
> +# @rx: since 5.0
>  ##
>  { 'enum' : 'SysEmuTarget',
>    'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
>               'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>               'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
> -             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
> +             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
>               'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>               'x86_64', 'xtensa', 'xtensaeb' ] }
> ---
>
> I get:
>
>   GEN     qapi-gen
>   GEN     rx-softmmu/config-devices.mak
> In file included from qapi/qapi-schema.json:105:
> qapi/machine.json:23:1: '@rx:' can't follow 'Notes' section
> make: *** [Makefile:645: qapi-gen-timestamp] Error 1
>
> This works however:
>
> ---
>  ##
>  # @SysEmuTarget:
>  #
>  # The comprehensive enumeration of QEMU system emulation ("softmmu")
>  # targets. Run "./configure --help" in the project root directory, and
>  # look for the *-softmmu targets near the "--target-list" option. The
>  # individual target constants are not documented here, for the time
>  # being.
>  #
> +# @rx: since 5.0
> +#
>  # Notes: The resulting QMP strings can be appended to the "qemu-system-"
>  #        prefix to produce the corresponding QEMU executable name. This
>  #        is true even for "qemu-system-x86_64".
>  #
>  # Since: 3.0
>  ##
>  { 'enum' : 'SysEmuTarget',
>    'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
>               'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>               'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
> -             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
> +             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
>               'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>               'x86_64', 'xtensa', 'xtensaeb' ] }
> ---

This one adds it to the correct spot.

qapi-code-gen.txt:

    Definition documentation starts with a line naming the definition,
    followed by an optional overview, a description of each argument (for
    commands and events), member (for structs and unions), branch (for
    alternates), or value (for enums), and finally optional tagged
    sections.

Let's apply this to SysEmuTarget's doc comment:

    ##
    # @SysEmuTarget:

Line naming the definition

    #
    # The comprehensive enumeration of QEMU system emulation ("softmmu")
    # targets. Run "./configure --help" in the project root directory, and
    # look for the *-softmmu targets near the "--target-list" option. The
    # individual target constants are not documented here, for the time
    # being.

Optional overview.

Missing here: a description of each value.  We should enforce such
descriptions.  We don't, mostly because we have a number of exceptions
where documentation would be bothersome, such as enum QKeyCode.

    #
    # Notes: The resulting QMP strings can be appended to the "qemu-system-=
"
    #        prefix to produce the corresponding QEMU executable name. This
    #        is true even for "qemu-system-x86_64".

A tagged section.

    #
    # Since: 3.0

Another tagged section.

    ##

Note that qapi-code-gen.txt prescribes no order for the tagged
sections.  They actually occur in pretty much any order:

    $ awk '/^##/ { if (on) { if (length(t) > 1) print t; t=3D"" } on=3D!on =
} on && /^# (Returns|Since|Notes?|Examples?|TODO):/ { t=3Dt substr($2, 1, 1=
) }' qapi/*json | sort | uniq -c
          1 ENS
          2 ES
          1 NES
          1 NETS
          1 NNSE
          1 NRS
          2 NRSE
         14 NS
         11 NSE
          1 RE
          6 RES
          4 RNS
          6 RNSE
         23 RS
         78 RSE
          1 RSEEEE
          3 RSEN
         12 RSNE
         55 SE
          4 SN
          2 SNE
          2 SRNE
          1 TRSE
          1 TS
          1 TSRE

If you think tightening their order would improve the documentation, we
should talk.


