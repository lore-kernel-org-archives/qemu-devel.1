Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AD0C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3545B22527
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9kE10j8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3545B22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvNhC-0007kf-FB
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvNgQ-0006mO-0g
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:21:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26565
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvNgO-0002A9-Bg
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594743687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H0kPA79x0wOMtZ3aeA5Itqsz0d6s2cVU+k0Xf3RqAEg=;
 b=N9kE10j8pyRKN8f80GJ2qlzK6LFZBdratWYQu81Bc2wZQkgvTo9ftVh7ZkTUlmIatXpPKL
 cC7MTS5u/D1K2q/EZUdz5+C+0mZXEzQCP935hnz72/wGqBSTe0bXLBjXPOOnZiTMeVh6qE
 +gySuik/LlV8+iqnRDHzRSRD8bodA0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-DPsIgitBNxu_AVJB4OADSg-1; Tue, 14 Jul 2020 12:21:23 -0400
X-MC-Unique: DPsIgitBNxu_AVJB4OADSg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 142381940920;
 Tue, 14 Jul 2020 16:21:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8DFE5C1B2;
 Tue, 14 Jul 2020 16:21:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 357BA105A45D; Tue, 14 Jul 2020 18:21:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v5 10/11] hw/arm: Wire up BMC boot flash for npcm750-evb
 and quanta-gsj
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-11-hskinnemoen@google.com>
 <109d52ed-65bf-0fcc-98f1-47b7a6671d0b@kaod.org>
 <CAFQmdRZcygskP3iwss01-Jz67yjAP_JENXjWM2Bp8U=DRzxR0Q@mail.gmail.com>
 <875zaq78xq.fsf@dusky.pond.sub.org>
 <19733456-a672-595d-e721-e0ef26d7f665@amsat.org>
Date: Tue, 14 Jul 2020 18:21:20 +0200
In-Reply-To: <19733456-a672-595d-e721-e0ef26d7f665@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 14 Jul 2020 13:29:02
 +0200")
Message-ID: <87v9iq2hkv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, Havard Skinnemoen <hskinnemoen@google.com>,
 QEMU Developers <qemu-devel@nongnu.org>, CS20 KFTing <kfting@nuvoton.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> + qemu-block experts.
>
> On 7/14/20 11:16 AM, Markus Armbruster wrote:
>> Havard Skinnemoen <hskinnemoen@google.com> writes:
>>=20
>>> On Mon, Jul 13, 2020 at 7:57 AM C=C3=A9dric Le Goater <clg@kaod.org> wr=
ote:
>>>>
>>>> On 7/9/20 2:36 AM, Havard Skinnemoen wrote:
>>>>> This allows these NPCM7xx-based boards to boot from a flash image, e.=
g.
>>>>> one built with OpenBMC. For example like this:
>>>>>
>>>>> IMAGE=3D${OPENBMC}/build/tmp/deploy/images/gsj/image-bmc
>>>>> qemu-system-arm -machine quanta-gsj -nographic \
>>>>>       -bios ~/qemu/bootrom/npcm7xx_bootrom.bin \
>>>>>       -drive file=3D${IMAGE},if=3Dmtd,bus=3D0,unit=3D0,format=3Draw,s=
napshot=3Don
>>>>>
>>>>> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
>>>>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
>>>>
>>>> May be we don't need to create the flash object if dinfo is NULL.
>>>
>>> It's soldered on the board, so you can't really boot the board without
>>> it. But if you think it's better to remove it altogether if we don't
>>> have an image to load into it, I can do that.
>>=20
>> If a device is a fixed part of the physical board, it should be a fixed
>> part of the virtual board, too.
>
> We agree so far but ... how to do it?
>
> I never used this API, does that makes sense?
>
>     if (!dinfo) {
>         QemuOpts *opts;
>
>         opts =3D qemu_opts_create(NULL, "spi-flash", 1, &error_abort);
>         qdict_put_str(opts, "format", "null-co");
>         qdict_put_int(opts, BLOCK_OPT_SIZE, 64 * MiB);
>         qdict_put_bool(opts, NULL_OPT_ZEROES, false); // XXX
>
>         dinfo =3D drive_new(opts, IF_MTD, &error_abort);
>         qemu_opts_del(opts);
>     }

I believe existing code special-cases "no backend" instead of making one
up.

Example: pflash_cfi0?.c

If ->blk is non-null, we read its contents into the memory buffer and
write updates back, else we leave it blank and don't write updates back.

Making one up could be more elegant.  To find out, you have to try.

We make up a few default drives (i.e. drives the user doesn't specify):
floppy, CD-ROM and SD card.  Ancient part of the user interface, uses
DriveInfo.  I doubt we should create more of them.

I believe block backends we make up for internal use should stay away
from DriveInfo.  Kevin, what do you think?  How would you make up a
null-co block backend for a device's internal use?

> We should probably add a public helper for that.

If we decide we want to make up backends, then yes, we should do that in
a helper, not in each device.

> 'XXX' because NOR flashes erase content is when hardware bit
> is set, so it would be more useful to return -1/0xff... rather
> than zeroes.


