Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51952C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 03:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A731207CD
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 03:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAoimtj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A731207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqqKY-0007M4-Ce
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 23:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqqJx-0006rh-HJ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 23:55:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26746
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqqJu-0003rF-PE
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 23:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593662128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kmn5R5crZf3r748cF/7g0FhkHnoY7WFTkWnSXgnl0xM=;
 b=FAoimtj7quNs+sPWtDyNioRkj9MgYyEcvM7oMPRRguRLdbvitPJXr90kVx/YHevDTg8BMD
 CUoh2AaHq+/qvFnR8Z6F3X0ocdOUwXaLdXGuS5XW2K1VFVwkd4VYHBRzU77Bg49bULSnPi
 oqGb3sYBLWCB1vy6L0Jqw/dG6p7Yqlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-vQ6EYvkyNXOqhjKkymAqsw-1; Wed, 01 Jul 2020 23:55:24 -0400
X-MC-Unique: vQ6EYvkyNXOqhjKkymAqsw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 995158015F7;
 Thu,  2 Jul 2020 03:55:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 35CC479243;
 Thu,  2 Jul 2020 03:55:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9937511384A6; Thu,  2 Jul 2020 05:55:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jason Andryuk <jandryuk@gmail.com>
Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
References: <20200624121841.17971-1-paul@xen.org>
 <20200624121841.17971-3-paul@xen.org>
 <33e594dd-dbfa-7c57-1cf5-0852e8fc8e1d@redhat.com>
 <000701d64ef5$6568f660$303ae320$@xen.org>
 <9e591254-d215-d5af-38d2-fd5b65f84a43@redhat.com>
 <000801d64f75$c604f570$520ee050$@xen.org>
 <CAKf6xpvNTVqK263pdSARyoWnzP8g9SRoSqvhnLLwyYadjR1ChQ@mail.gmail.com>
Date: Thu, 02 Jul 2020 05:55:17 +0200
In-Reply-To: <CAKf6xpvNTVqK263pdSARyoWnzP8g9SRoSqvhnLLwyYadjR1ChQ@mail.gmail.com>
 (Jason Andryuk's message of "Wed, 1 Jul 2020 08:25:40 -0400")
Message-ID: <87o8oy8tay.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 22:40:09
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <pdurrant@amazon.com>,
 Paul Durrant <paul@xen.org>, QEMU <qemu-devel@nongnu.org>,
 xen-devel <xen-devel@lists.xenproject.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jason Andryuk <jandryuk@gmail.com> writes:

> On Wed, Jul 1, 2020 at 3:03 AM Paul Durrant <xadimgnik@gmail.com> wrote:
>>
>> > -----Original Message-----
>> > From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> > Sent: 30 June 2020 18:27
>> > To: paul@xen.org; xen-devel@lists.xenproject.org; qemu-devel@nongnu.or=
g
>> > Cc: 'Eduardo Habkost' <ehabkost@redhat.com>; 'Michael S. Tsirkin' <mst=
@redhat.com>; 'Paul Durrant'
>> > <pdurrant@amazon.com>; 'Jason Andryuk' <jandryuk@gmail.com>; 'Paolo Bo=
nzini' <pbonzini@redhat.com>;
>> > 'Richard Henderson' <rth@twiddle.net>
>> > Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
>> >
>> > On 6/30/20 5:44 PM, Paul Durrant wrote:
>> > >> -----Original Message-----
>> > >> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> > >> Sent: 30 June 2020 16:26
>> > >> To: Paul Durrant <paul@xen.org>; xen-devel@lists.xenproject.org; qe=
mu-devel@nongnu.org
>> > >> Cc: Eduardo Habkost <ehabkost@redhat.com>; Michael S. Tsirkin <mst@=
redhat.com>; Paul Durrant
>> > >> <pdurrant@amazon.com>; Jason Andryuk <jandryuk@gmail.com>; Paolo Bo=
nzini <pbonzini@redhat.com>;
>> > >> Richard Henderson <rth@twiddle.net>
>> > >> Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
>> > >>
>> > >> On 6/24/20 2:18 PM, Paul Durrant wrote:
>> > >>> From: Paul Durrant <pdurrant@amazon.com>
>> > >>>
>> > >>> The generic pc_machine_initfn() calls pc_system_flash_create() whi=
ch creates
>> > >>> 'system.flash0' and 'system.flash1' devices. These devices are the=
n realized
>> > >>> by pc_system_flash_map() which is called from pc_system_firmware_i=
nit() which
>> > >>> itself is called via pc_memory_init(). The latter however is not c=
alled when
>> > >>> xen_enable() is true and hence the following assertion fails:
>> > >>>
>> > >>> qemu-system-i386: hw/core/qdev.c:439: qdev_assert_realized_properl=
y:
>> > >>> Assertion `dev->realized' failed
>> > >>>
>> > >>> These flash devices are unneeded when using Xen so this patch avoi=
ds the
>> > >>> assertion by simply removing them using pc_system_flash_cleanup_un=
used().
>> > >>>
>> > >>> Reported-by: Jason Andryuk <jandryuk@gmail.com>
>> > >>> Fixes: ebc29e1beab0 ("pc: Support firmware configuration with -blo=
ckdev")
>> > >>> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
>> > >>> Tested-by: Jason Andryuk <jandryuk@gmail.com>
>> > >>> ---
>> > >>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> > >>> Cc: Richard Henderson <rth@twiddle.net>
>> > >>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> > >>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> > >>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> > >>> ---
>> > >>>  hw/i386/pc_piix.c    | 9 ++++++---
>> > >>>  hw/i386/pc_sysfw.c   | 2 +-
>> > >>>  include/hw/i386/pc.h | 1 +
>> > >>>  3 files changed, 8 insertions(+), 4 deletions(-)
>> > >>>
>> > >>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> > >>> index 1497d0e4ae..977d40afb8 100644
>> > >>> --- a/hw/i386/pc_piix.c
>> > >>> +++ b/hw/i386/pc_piix.c
>> > >>> @@ -186,9 +186,12 @@ static void pc_init1(MachineState *machine,
>> > >>>      if (!xen_enabled()) {
>> > >>>          pc_memory_init(pcms, system_memory,
>> > >>>                         rom_memory, &ram_memory);
>> > >>> -    } else if (machine->kernel_filename !=3D NULL) {
>> > >>> -        /* For xen HVM direct kernel boot, load linux here */
>> > >>> -        xen_load_linux(pcms);
>> > >>> +    } else {
>> > >>> +        pc_system_flash_cleanup_unused(pcms);
>> > >>
>> > >> TIL pc_system_flash_cleanup_unused().
>> > >>
>> > >> What about restricting at the source?
>> > >>
>> > >
>> > > And leave the devices in place? They are not relevant for Xen, so wh=
y not clean up?
>> >
>> > No, I meant to not create them in the first place, instead of
>> > create+destroy.
>> >
>> > Anyway what you did works, so I don't have any problem.
>>
>> IIUC Jason originally tried restricting creation but encountered a probl=
em because xen_enabled() would always return false at that point, because m=
achine creation occurs before accelerators are initialized.
>
> Correct.  Quoting my previous email:
> """
> Removing the call to pc_system_flash_create() from pc_machine_initfn()
> lets QEMU startup and run a Xen HVM again.  xen_enabled() doesn't work
> there since accelerators have not been initialized yes, I guess?
> """
>
> If you want to remove the creation in the first place, then I have two
> questions.  Why does pc_system_flash_create()/pc_pflash_create() get
> called so early creating the pflash devices?  Why aren't they just
> created as needed in pc_system_flash_map()?

commit ebc29e1beab02646702c8cb9a1d29b68f72ad503

    pc: Support firmware configuration with -blockdev

    [...]

    Properties need to be created in .instance_init() methods.  For PC
    machines, that's pc_machine_initfn().  To make alias properties work,
    we need to create the onboard flash devices there, too.  [...]

For context, read the entire commit message.  If you have questions
then, don't hesitate to ask them here.


