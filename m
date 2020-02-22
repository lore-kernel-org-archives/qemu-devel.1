Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F87C35671
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 13:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF51B20684
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 13:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3fjQcZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF51B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5UXU-0006lS-2A
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 08:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j5UWv-0006Be-Is
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 08:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j5UWu-0002Bf-20
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 08:09:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56121
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j5UWt-00029D-VU
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 08:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582376951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VG0dUxOondtSKszH83OJoKQcp1hil5Rn2AvW5pa5Htg=;
 b=W3fjQcZ5Dp6gGtcAFfRe52dA3RZnwhMvjA+Aqft/kMYuczVpXbsG4q2UnJIlyyHRwTWsV4
 xHF62LrjOrT4/XlwV9+fO6aJ45ho9/hQYl1isXW8CSM9f5TR2IgQUldR2dqx46rR0AsnE/
 AjEeG8/tF2EocQ0sP4dnTXBn5GZTtnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-qRCnLbdiNdWWr8jW8bGpHA-1; Sat, 22 Feb 2020 08:09:03 -0500
X-MC-Unique: qRCnLbdiNdWWr8jW8bGpHA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 335D6100550E;
 Sat, 22 Feb 2020 13:09:02 +0000 (UTC)
Received: from [10.3.116.90] (ovpn-116-90.phx2.redhat.com [10.3.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 408CB90F7F;
 Sat, 22 Feb 2020 13:09:01 +0000 (UTC)
Subject: Re: [PATCH v3 0/3] Dump QCOW2 metadata
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
References: <1578990137-308222-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <fb4eb1a7-25f7-86ce-4c27-06bca430e97a@redhat.com>
 <20200220122806.GC5932@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a8f04995-e90b-e7f1-ee39-04ffccc843ae@redhat.com>
Date: Sat, 22 Feb 2020 07:09:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220122806.GC5932@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: vsementsov@virtuozzo.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 armbru@redhat.com, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/20/20 6:28 AM, Kevin Wolf wrote:
> Am 20.02.2020 um 12:58 hat Max Reitz geschrieben:
>> On 14.01.20 09:22, Andrey Shinkevich wrote:
>>> The information about QCOW2 metadata allocations in an image ELF-file i=
s
>>> helpful for finding issues with the image data integrity.
>>
>> Sorry that I=E2=80=99m replying only so late =E2=80=93 but I don=E2=80=
=99t know why we need this
>> in qemu, and this cover letter doesn=E2=80=99t provide a justification. =
 I mean,
>> it isn=E2=80=99t too complex (from the diffstat), but wouldn=E2=80=99t i=
t be better to
>> just have a script for this?
>=20
> Specifically, we could extend tests/qemu-iotests/qcow2.py. This seems to
> be debugging output that would be in line with what the script is
> already used for.

I also just discovered GNU poke, http://jemarch.net/poke, which is an=20
arbitrary binary-format editor with a fairly good example of how it can=20
be used to inspect ELF files.  I'm wondering if it would be easier to=20
write a pickle describing the qcow2 format that would make it easier to=20
do interactive browsing/editing of a qcow2 file, at the expense of=20
having to depend on poke (which has not yet hit the 1.0 release and is=20
not yet bundled for Fedora).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


