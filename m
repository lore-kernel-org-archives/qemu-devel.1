Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E80C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4289720738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MiUrCMFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4289720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv16J-0002TF-BV
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 12:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jv15X-00022I-SA
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 12:13:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36820
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jv15V-0001pe-QB
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 12:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594656833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xK7xO62aVLhEUjBnQAV0nOy790uANdTaqPs7msW2hAo=;
 b=MiUrCMFkao7NIxkPR3vCYnmhKzrXRbMwBb05hObbZW86rXUZqqbIrgnwwjXdj+QQ9JRv0R
 Dpzc5ifMNuONAzkEdmpvO8gEOLr3O/Bj/H96DB91/0ob0+XkWJi/Q2is+dZhqd68diHkN8
 w+gkrBldHyngpi+NbMOwGk10CGb5xgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-BThBusI8NUSD8hEYTCnrzA-1; Mon, 13 Jul 2020 12:13:50 -0400
X-MC-Unique: BThBusI8NUSD8hEYTCnrzA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 641CD18FF67C;
 Mon, 13 Jul 2020 16:13:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1015E1001281;
 Mon, 13 Jul 2020 16:13:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 696BC11384A6; Mon, 13 Jul 2020 18:13:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: David Gibson <dgibson@redhat.com>
Subject: Re: Slow down with: 'Make "info qom-tree" show children sorted'
References: <20200527084754.7531-1-armbru@redhat.com>
 <20200527084754.7531-3-armbru@redhat.com>
 <49bea110-0a3d-5a40-6647-67b116fb41b5@redhat.com>
 <5e967e5f-8ae5-01cc-0dfe-f22e0f03b6b3@redhat.com>
 <87y2nvanya.fsf@dusky.pond.sub.org>
 <794f6901-5fe3-f7a1-45e7-f277f687cb6b@redhat.com>
 <87v9iz7cxl.fsf@dusky.pond.sub.org>
 <20200713111344.23c1b313@umbus.fritz.box>
Date: Mon, 13 Jul 2020 18:13:42 +0200
In-Reply-To: <20200713111344.23c1b313@umbus.fritz.box> (David Gibson's message
 of "Mon, 13 Jul 2020 11:13:44 +1000")
Message-ID: <874kqbbdft.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, ehabkost@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>,
 =?utf-8?Q?C=C3=A9dr?= =?utf-8?Q?ic?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Gibson <dgibson@redhat.com> writes:

> On Tue, 07 Jul 2020 14:00:06 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>=20
>> > On 07/07/20 07:33, Markus Armbruster wrote: =20
>> >> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>> >>  =20
>> >>> On 7/7/20 6:45 AM, Thomas Huth wrote: =20
>> >>>> On 27/05/2020 10.47, Markus Armbruster wrote: =20
>> >>>>> "info qom-tree" prints children in unstable order.  This is a pain
>> >>>>> when diffing output for different versions to find change.  Print =
it
>> >>>>> sorted.
>> >>>>>
>> >>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> >>>>> ---
>> >>>>>  qom/qom-hmp-cmds.c | 24 ++++++++++++++++--------
>> >>>>>  1 file changed, 16 insertions(+), 8 deletions(-) =20
>> >>>>
>> >>>>  Hi Markus,
>> >>>>
>> >>>> this patch causes a slow down of the qtests which becomes quite mas=
sive
>> >>>> when e.g. using the ppc64 and thourough testing. When I'm running
>> >>>>
>> >>>> QTEST_QEMU_BINARY=3D"ppc64-softmmu/qemu-system-ppc64" time \
>> >>>> ./tests/qtest/device-introspect-test -m slow | tail -n 10
>> >>>>
>> >>>> the test runs for ca. 6m40s here before the patch got applied, and =
for
>> >>>> mor than 20 minutes after the patch got applied! =20
>> >>=20
>> >> That's surprising. =20
>> >
>> > It's a bit surprising indeed, but on the other hand using
>> > g_queue_insert_sorted results in a quadratic loop. =20
>>=20
>> The surprising part is that n turns out to be large enough for n^2 to
>> matter *that* much.
>
> Is this another consequence of the ludicrous number of QOM objects we
> create for LMB DRCs (one for every 256MiB of guest RAM)?  Avoiding that
> is on my list.

You're talking about machine pseries, I presume.  With
print_qom_composition() patched to print the number of children, I get

    $ echo -e 'info qom-tree\nq' | ../qemu/bld/ppc64-softmmu/qemu-system-pp=
c64 -S -display none -M pseries -accel qtest -monitor stdio | grep '###' | =
sort | uniq -c | sort -k 3n
        360 ### 0 children
          5 ### 1 children
          5 ### 2 children
          2 ### 3 children
          1 ### 4 children
          1 ### 15 children
          1 ### 16 children
          1 ### 18 children
          1 ### 37 children
          1 ### 266 children

The outlier is

        /device[5] (spapr-pci-host-bridge)

due to its 256 spapr-drc-pci children.

I found quite a few machines with similar outliers.  ARM machines nuri
and smdkc210 together take the cake: they each have a node with 513
children.

My stupid n^2 sort is unnoticable in normal, human usage even for n=3D513.

>                 Though avoiding a n^2 behaviour here is probably a good
> idea anyway.

Agreed.


