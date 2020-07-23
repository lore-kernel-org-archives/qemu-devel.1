Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDA0C433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 09:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D15D22BEF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 09:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ML/qw77Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D15D22BEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyXGF-000718-Lw
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 05:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyXFg-0006cK-7W
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 05:10:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23506
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyXFd-0008Lm-PS
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 05:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595495451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ImYj/pnF5oNlY0FJk+Bf+QVAng1qbaoZaE99VBcJzL4=;
 b=ML/qw77ZDra6pe8J3AtEzqtqTyib7GnNCaJaPY3jDv/GCNSe9ZkapaOHT+K6ZCWMoGuTzQ
 4ArPeWbJUMpOQASniVrPpfNulGei+JCR0WoK/sEUf0lB303e7LEwnDcEmEItYjYzH12FM0
 XNLKrZ0wHS0JkXnnQZ/R7SV+PPmiDLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-xZiGRGZ-Me6tD5DGNWRL3A-1; Thu, 23 Jul 2020 05:10:47 -0400
X-MC-Unique: xZiGRGZ-Me6tD5DGNWRL3A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73F7D10120DB;
 Thu, 23 Jul 2020 09:10:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34A005D9D3;
 Thu, 23 Jul 2020 09:10:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C4C8D111CA26; Thu, 23 Jul 2020 11:10:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: What is TYPE_TPM_TIS_ISA? (Not an ISA Device)
References: <8f5a171a-59db-f5d1-477c-1ddf7af45da7@redhat.com>
 <CAFEAcA8b3N+oxAAW3JEKGTtsZezXTOFdnu9Hm1MYK=yURTfVsQ@mail.gmail.com>
 <87pn8o14cj.fsf@dusky.pond.sub.org>
 <e4ad751f-8418-bdd4-6c81-600e68f5c92e@linux.ibm.com>
Date: Thu, 23 Jul 2020 11:10:29 +0200
In-Reply-To: <e4ad751f-8418-bdd4-6c81-600e68f5c92e@linux.ibm.com> (Stefan
 Berger's message of "Wed, 22 Jul 2020 18:07:58 -0400")
Message-ID: <87tuxyoauy.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Berger <stefanb@linux.ibm.com> writes:

> On 7/22/20 1:55 AM, Markus Armbruster wrote:
>> pm socket --tpmstate dir=3Dtpm --ctrl type=3Dunixio,path=3Dtpm/swtpm-soc
>> running in another terminal.
>>
>>>> 3/ no machine plug it using isa_register_ioport()
>>>>     (it is not registered to the ISA memory space)
>>> There's no requirement for an ISA device to have IO ports...
>>>
>>> thanks
>>> -- PMM
>> Thread hijack!  Since I didn't have swtpm installed, I tried to take a
>> shortcut:
>>
>>      $ qemu-system-x86_64 -nodefaults -S -display none -monitor stdio -c=
hardev null,id=3Dtpm0 -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm -device t=
pm-tis,tpmdev=3Dtpm0
>>      qemu-system-x86_64: -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm: tp=
m-emulator: tpm chardev 'chrtpm' not found.
>>      qemu-system-x86_64: -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm: tp=
m-emulator: Could not cleanly shutdown the TPM: No such file or directory
>>      QEMU 5.0.90 monitor - type 'help' for more information
>>      (qemu) qemu-system-x86_64: -device tpm-tis,tpmdev=3Dtpm0: Property =
'tpm-tis.tpmdev' can't find value 'tpm0'
>>      $ echo $?
>>      1
>>
>> That a null chardev doesn't work is fine.  But the error handling looks
>> broken: QEMU diagnoses and reports the problem, then continues.  The
>> final error message indicates that it continued without creating the
>> backend "tpm0".  That's wrong.
>
>
> This issue can be solve via the following change that then displays
> this error:
>
> $ x86_64-softmmu/qemu-system-x86_64 -nodefaults -S -display none
> -monitor stdio -chardev null,id=3Dtpm0 -tpmdev
> emulator,id=3Dtpm0,chardev=3Dchrtpm -device tpm-tis,tpmdev=3Dtpm0
> qemu-system-x86_64: -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm:
> tpm-emulator: tpm chardev 'chrtpm' not found.
> qemu-system-x86_64: -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm:
> tpm-emulator: Could not cleanly shutdown the TPM: No such file or
> directory
>
>
> diff --git a/tpm.c b/tpm.c
> index 358566cb10..857a861e69 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -170,8 +170,10 @@ void tpm_cleanup(void)
> =C2=A0 */
> =C2=A0void tpm_init(void)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 qemu_opts_foreach(qemu_find_opts("tpmdev"),
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_init_tpmdev, NUL=
L, &error_fatal);
> +=C2=A0=C2=A0=C2=A0 if (qemu_opts_foreach(qemu_find_opts("tpmdev"),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 tpm_init_tpmdev, NULL, &error_fatal)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
> +=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
>
> =C2=A0/*

Interesting.

> We had something like this before this patch here was applied:
> https://github.com/qemu/qemu/commit/d10e05f15d5c3dd5e5cc59c5dfff460d89d48=
580#diff-0ec5df49c6751cb2dc9fa18ed5cf9f0e
>
>
> Do we now want to partially revert this patch or call the exit(1) as
> shown here?

Let's have a closer look.

qemu_opts_foreach()'s contract:

 * For each member of @list, call @func(@opaque, member, @errp).
 * Call it with the current location temporarily set to the member's.
 * @func() may store an Error through @errp, but must return non-zero then.
 * When @func() returns non-zero, break the loop and return that value.
 * Return zero when the loop completes.

When qemu_opts_foreach(list, func, opaque, &error_fatal) returns, then
func() did not set an error (If it did, we'd have died due to
&error_fatal).

Therefore, func() must have returned non-zero without setting an error.
That's wrong.  Let's look for this in tpm_init_tpmdev():

    static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
    {
        [...]
        drv =3D be->create(opts);
        if (!drv) {
            return 1;

Bingo!

When I did commit d10e05f15d5, I missed this error path.

        }

        drv->id =3D g_strdup(id);
        QLIST_INSERT_HEAD(&tpm_backends, drv, list);

        return 0;
    }

Two possible fixes:

1. Revert d10e05f15d5, live with the "error_report() in a function that
takes an Error ** argument" code smell.  Bearable, because it's confined
to tpm.c.  I'd recommend a comment explaining the non-use of @errp in
tpm_init_tpmdev().

2. Convert the ->create() to Error: tpm_passthrough_create(),
tpm_emulator_create(), and their helpers.  I think this would leave us
in a better state, but I'm not sure the improvement is worth the effort
right now.

Spotted while writing this: ->tpm_startup() methods can fail.  They
appear to run in DeviceClass method reset(), which can't fail.
Awkward.  Could some failures be moved to realize() somehow?


