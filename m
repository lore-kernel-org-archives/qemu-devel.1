Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D106DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9653420EDD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMtNk1qV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9653420EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvHQx-00051r-RR
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 05:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvHQF-0004Vj-9a
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:40:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28766
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvHQC-0002Ft-Iu
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594719618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HivWotUNsJ4PkywbSV1y6SdcjkzdLOHRFK0fE39HbRo=;
 b=UMtNk1qVtHAb4HUnGgoIug9hlXes37yA4PI85/6Oe3yjOupdlpolbhnlyzxQiD5xdwhDkz
 erIXzmq+J3l78oYUNv2j9pSazlXFSjBKn2urIUrSyrkTOCL29DhldB840oNqlQ3G7n5YBo
 DCldhXN1b9j5S0PZAI0biYMR44OKvic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-IwwpXNu4NXee9Q2y5B8tNg-1; Tue, 14 Jul 2020 05:40:14 -0400
X-MC-Unique: IwwpXNu4NXee9Q2y5B8tNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA8F71081;
 Tue, 14 Jul 2020 09:40:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 86BA3797E8;
 Tue, 14 Jul 2020 09:40:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0882F105A45D; Tue, 14 Jul 2020 11:40:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 7/9] hw/sd/sdcard: Do not allow invalid SD card sizes
References: <20200713183209.26308-1-f4bug@amsat.org>
 <20200713183209.26308-8-f4bug@amsat.org>
 <CAFEAcA-kJQSZ-pudOrgutf24BG3UxA6F2ErocArs=f4sfndvTQ@mail.gmail.com>
Date: Tue, 14 Jul 2020 11:40:07 +0200
In-Reply-To: <CAFEAcA-kJQSZ-pudOrgutf24BG3UxA6F2ErocArs=f4sfndvTQ@mail.gmail.com>
 (Peter Maydell's message of "Mon, 13 Jul 2020 21:41:48 +0100")
Message-ID: <87sgdu5tag.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:06:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Qemu-block <qemu-block@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Bulekov <alxndr@bu.edu>, Niek Linnenbank <nieklinnenbank@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 13 Jul 2020 at 19:32, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>>
>> QEMU allows to create SD card with unrealistic sizes. This could
>> work, but some guests (at least Linux) consider sizes that are not
>> a power of 2 as a firmware bug and fix the card size to the next
>> power of 2.
>>
>
>> +            error_setg(errp, "Invalid SD card size: %s", blk_size_str);
>> +            g_free(blk_size_str);
>> +
>> +            blk_size_str =3D size_to_str(blk_size_aligned);
>> +            error_append_hint(errp,
>> +                              "SD card size has to be a power of 2, e.g=
. %s.\n"
>> +                              "You can resize disk images with "
>> +                              "'qemu-img resize <imagefile> <new-size>'=
\n"
>> +                              "(note that this will lose data if you ma=
ke the "
>> +                              "image smaller than it currently is).\n",
>> +                              blk_size_str);
>> +            g_free(blk_size_str);
>
> Some places that create multi-line hints with error_append_hint()
> do it by calling it once per line, eg in target/arm/cpu64.c:
>                 error_setg(errp, "cannot disable sve128");
>                 error_append_hint(errp, "Disabling sve128 results in all =
"
>                                   "vector lengths being disabled.\n");
>                 error_append_hint(errp, "With SVE enabled, at least one "
>                                   "vector length must be enabled.\n");
>
> Some places don't, eg in block/vhdx-log.c:
>             error_append_hint(errp,  "To replay the log, run:\n"
>                               "qemu-img check -r all '%s'\n",
>                               bs->filename);

Both fine.

> Most places terminate with a '\n', but some places don't, eg
> crypto/block-luks.c:
>        error_append_hint(errp, "Failed to write to keyslot %i", keyslot);
>        return -1;

This is a bug.

> The documentation says
>  * May be called multiple times.  The resulting hint should end with a
>  * newline.
>
> which isn't very clear -- you can call it multiple times, but
> must you, if it's multiline?

If that was required, my doc comment would demand it.

> I assume that "should end with a newline" means "must end
> with a newline", and places like block-luks.c are bugs.

If you construct a hint with multiple calls, individual calls need not
terminate with a newline, but the resulting hint still should.

I readily admit that my doc comments sometimes require a "lawyerly"
reading :)

> Markus, do you know what the intended API here is?
>
> It looks like the implementation just tacks the hint
> string onto the end of any existing hint string, in
> which case multiple-line strings are fine and the same
> behaviour as calling the function multiple times.

That's the intended behavior.

> (I had assumed we might be accumulating an array of strings,
> or requiring multiline strings to be multiple calls so we
> could have the argument not need to be \n-terminated,
> to match error_setg(), but both those assumptions
> are obviously wrong.)

Would also be workable, if slightly less flexible.

Yes, error_setg() and error_append_hint() differ on newlines.

error_setg() constructs an error message.  These get reported in a rigid
format that does not afford line breaks in the middle.

error_append_hint() builds up a hint.  Hints are free-form text.
Embedded line breaks are fine.

In both cases, I decided not to treat newline at the end any different
from newlines anywhere else.  Thus, no newlines at all with
error_setg(), and newlines after every line including the last one with
error_append_hint().

> Anyway, I guess this multiline-message usage is something
> we do already and it will DTRT, so

Correct.

Hope this helps!

> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
>
> thanks
> -- PMM


