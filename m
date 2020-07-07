Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF54C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 05:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB68320772
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 05:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrT6mMbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB68320772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsgFq-0006wG-3k
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 01:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsgEy-00069f-Lc
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 01:34:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28348
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsgEw-0006V5-TJ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 01:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594100037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KuMKDqtWd2NJ4rYtAvFF/mv5CXNgliZcbrJ0DkWkIDM=;
 b=MrT6mMbf6pkSVWjKI27SNbxqTxLL80H0P4IBnV0Mf7vCp1ktsKLHS/0zCgtBvP5rHnLK4f
 iHAJeURA4UTvcUag3Rw6JuOdCdv7c4MSX0aZJGnOAEgcgFYjsqzBtjNd6N4lh+2MPhgIQ7
 a0pJcQjUIrJWAJRFrrcf8H8h8domwsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-S4Iuw8wOPlWvmDAsWeGNYw-1; Tue, 07 Jul 2020 01:33:53 -0400
X-MC-Unique: S4Iuw8wOPlWvmDAsWeGNYw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57DCF18A8220;
 Tue,  7 Jul 2020 05:33:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E614E1002397;
 Tue,  7 Jul 2020 05:33:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AD5341132FD2; Tue,  7 Jul 2020 07:33:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: Slow down with: 'Make "info qom-tree" show children sorted'
References: <20200527084754.7531-1-armbru@redhat.com>
 <20200527084754.7531-3-armbru@redhat.com>
 <49bea110-0a3d-5a40-6647-67b116fb41b5@redhat.com>
 <5e967e5f-8ae5-01cc-0dfe-f22e0f03b6b3@redhat.com>
Date: Tue, 07 Jul 2020 07:33:49 +0200
In-Reply-To: <5e967e5f-8ae5-01cc-0dfe-f22e0f03b6b3@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 7 Jul 2020 06:58:56
 +0200")
Message-ID: <87y2nvanya.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 23:10:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 berrange@redhat.com, ehabkost@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 =?utf-8?Q?C?= =?utf-8?Q?=C3=A9dric?= Le Goater <clg@kaod.org>,
 pbonzini@redhat.com, David Gibson <dgibson@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 7/7/20 6:45 AM, Thomas Huth wrote:
>> On 27/05/2020 10.47, Markus Armbruster wrote:
>>> "info qom-tree" prints children in unstable order.  This is a pain
>>> when diffing output for different versions to find change.  Print it
>>> sorted.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  qom/qom-hmp-cmds.c | 24 ++++++++++++++++--------
>>>  1 file changed, 16 insertions(+), 8 deletions(-)
>>=20
>>  Hi Markus,
>>=20
>> this patch causes a slow down of the qtests which becomes quite massive
>> when e.g. using the ppc64 and thourough testing. When I'm running
>>=20
>> QTEST_QEMU_BINARY=3D"ppc64-softmmu/qemu-system-ppc64" time \
>> ./tests/qtest/device-introspect-test -m slow | tail -n 10
>>=20
>> the test runs for ca. 6m40s here before the patch got applied, and for
>> mor than 20 minutes after the patch got applied!

That's surprising.

> Argh, yesterday I reviewed again all the range except this patch... not
> sure why as looking at it now it is obvious.
>
>> This causes our gitlab CI to constantly fail since the patch got merged,
>> since the testing time now exceeds the 1h time limit:
>>=20
>>  https://gitlab.com/qemu-project/qemu/-/pipelines/156767175
>>=20
>> Sure, we can work around that problem in the CI (Alex has already a
>> patch queued), but still, is there something you could do about this
>> massive slowdown?
>
> Suggestion: add a '-u' option for unsorted mode, to use in qtests.
>
> Humans want the new behavior (default: sorted).

Last resort. =20

I'll look into speeding up the sort first.

Work-around: drop -m slow until we get this sorted (pardon the pun).


