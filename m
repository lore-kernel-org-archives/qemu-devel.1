Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF83C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 05:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9FEE20747
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 05:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHwOHtaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FEE20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqVmc-0000YS-3u
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 01:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqVm3-0008Tu-5e
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 01:59:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24267
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqVm1-0006At-FO
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 01:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593583148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yp53qNv2a6t0Mz/ydfPlIxanTqAlC2QRvorB2eFQvzo=;
 b=BHwOHtaazQwMdYTaRU3S6EhcgApeznz8etcwEfgfpAe7z0Fswv3V+xXLf1ILwnn43aV+3Q
 QjqShxUlseq4fuUF7HgYbDPojQ0C0kM5jwKbM6Inns+aoVyYtyEl+rTGZhxQAidGWktI8B
 UDjlDH+09MggCL71cZoS0Qcnp9J27W4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-9GxAnRZcPomIJdFk8qov4Q-1; Wed, 01 Jul 2020 01:59:07 -0400
X-MC-Unique: 9GxAnRZcPomIJdFk8qov4Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2B96800C64;
 Wed,  1 Jul 2020 05:59:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E83F574191;
 Wed,  1 Jul 2020 05:59:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 954E011384A6; Wed,  1 Jul 2020 07:59:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
References: <20200624121841.17971-1-paul@xen.org>
 <20200624121841.17971-3-paul@xen.org>
 <33e594dd-dbfa-7c57-1cf5-0852e8fc8e1d@redhat.com>
 <000701d64ef5$6568f660$303ae320$@xen.org>
 <9e591254-d215-d5af-38d2-fd5b65f84a43@redhat.com>
Date: Wed, 01 Jul 2020 07:59:01 +0200
In-Reply-To: <9e591254-d215-d5af-38d2-fd5b65f84a43@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 30 Jun 2020 19:27:22
 +0200")
Message-ID: <877dvndbdm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: 'Eduardo Habkost' <ehabkost@redhat.com>,
 'Jason Andryuk' <jandryuk@gmail.com>, 'Paul Durrant' <pdurrant@amazon.com>,
 paul@xen.org, qemu-devel@nongnu.org, "'Michael S. Tsirkin'" <mst@redhat.com>,
 'Paolo Bonzini' <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 'Richard Henderson' <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 6/30/20 5:44 PM, Paul Durrant wrote:
>>> -----Original Message-----
>>> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> Sent: 30 June 2020 16:26
>>> To: Paul Durrant <paul@xen.org>; xen-devel@lists.xenproject.org; qemu-d=
evel@nongnu.org
>>> Cc: Eduardo Habkost <ehabkost@redhat.com>; Michael S. Tsirkin <mst@redh=
at.com>; Paul Durrant
>>> <pdurrant@amazon.com>; Jason Andryuk <jandryuk@gmail.com>; Paolo Bonzin=
i <pbonzini@redhat.com>;
>>> Richard Henderson <rth@twiddle.net>
>>> Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
>>>
>>> On 6/24/20 2:18 PM, Paul Durrant wrote:
>>>> From: Paul Durrant <pdurrant@amazon.com>
>>>>
>>>> The generic pc_machine_initfn() calls pc_system_flash_create() which c=
reates
>>>> 'system.flash0' and 'system.flash1' devices. These devices are then re=
alized
>>>> by pc_system_flash_map() which is called from pc_system_firmware_init(=
) which
>>>> itself is called via pc_memory_init(). The latter however is not calle=
d when
>>>> xen_enable() is true and hence the following assertion fails:
>>>>
>>>> qemu-system-i386: hw/core/qdev.c:439: qdev_assert_realized_properly:
>>>> Assertion `dev->realized' failed
>>>>
>>>> These flash devices are unneeded when using Xen so this patch avoids t=
he
>>>> assertion by simply removing them using pc_system_flash_cleanup_unused=
().
>>>>
>>>> Reported-by: Jason Andryuk <jandryuk@gmail.com>
>>>> Fixes: ebc29e1beab0 ("pc: Support firmware configuration with -blockde=
v")
>>>> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
>>>> Tested-by: Jason Andryuk <jandryuk@gmail.com>
>>>> ---
>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>> Cc: Richard Henderson <rth@twiddle.net>
>>>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>>> ---
>>>>  hw/i386/pc_piix.c    | 9 ++++++---
>>>>  hw/i386/pc_sysfw.c   | 2 +-
>>>>  include/hw/i386/pc.h | 1 +
>>>>  3 files changed, 8 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>>> index 1497d0e4ae..977d40afb8 100644
>>>> --- a/hw/i386/pc_piix.c
>>>> +++ b/hw/i386/pc_piix.c
>>>> @@ -186,9 +186,12 @@ static void pc_init1(MachineState *machine,
>>>>      if (!xen_enabled()) {
>>>>          pc_memory_init(pcms, system_memory,
>>>>                         rom_memory, &ram_memory);
>>>> -    } else if (machine->kernel_filename !=3D NULL) {
>>>> -        /* For xen HVM direct kernel boot, load linux here */
>>>> -        xen_load_linux(pcms);
>>>> +    } else {
>>>> +        pc_system_flash_cleanup_unused(pcms);
>>>
>>> TIL pc_system_flash_cleanup_unused().
>>>
>>> What about restricting at the source?
>>>
>>=20
>> And leave the devices in place? They are not relevant for Xen, so why no=
t clean up?
>
> No, I meant to not create them in the first place, instead of
> create+destroy.

Better.  Opinion, not demand :)

[...]


