Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CBCC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 16:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1BB6222C4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 16:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZOdla1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BB6222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8oMj-0004JS-Qb
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 11:56:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j8oLa-0002xD-Jv
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:55:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j8oLY-0001jt-LM
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:55:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59867
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j8oLY-0001fr-Br
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583168109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0X1R4XXc/FyQlZhDrVPbRHRihqCB0ZyeyRx4twR5fvE=;
 b=IZOdla1atu46Egb5X2CcHhZCaE6At9b/yFVyBKUZgrMoWUGi14ZyYKiPD6SJK9H8esDexC
 OBT2IFV9dQAjKIJn6ZYXvz6A3kKgzXcotbhf/wrQqesxE/qaPTEQmlccw9gp0AAFvyDJc7
 mL7m69ObR+9MC2tOBfbmXiI2Q7fd9no=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-veGzq5YdPTSHFDTWnJdhzQ-1; Mon, 02 Mar 2020 11:55:07 -0500
X-MC-Unique: veGzq5YdPTSHFDTWnJdhzQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 086CA18AB2C0;
 Mon,  2 Mar 2020 16:55:06 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05A7A1001B2D;
 Mon,  2 Mar 2020 16:55:04 +0000 (UTC)
Date: Mon, 2 Mar 2020 17:55:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 012/136] arm/cubieboard: use memdev for RAM
Message-ID: <20200302175503.65e404d0@redhat.com>
In-Reply-To: <CAFEAcA_0y0NsHfkK2V4-PTYe0fiOHE6x00i9z7am5+Kvg86PNg@mail.gmail.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
 <1582631466-13880-12-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_0y0NsHfkK2V4-PTYe0fiOHE6x00i9z7am5+Kvg86PNg@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Mar 2020 15:41:13 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Tue, 25 Feb 2020 at 11:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > From: Igor Mammedov <imammedo@redhat.com>
> >
> > memory_region_allocate_system_memory() API is going away, so
> > replace it with memdev allocated MemoryRegion. The later is
> > initialized by generic code, so board only needs to opt in
> > to memdev scheme by providing
> >   MachineClass::default_ram_id
> > and using MachineState::ram instead of manually initializing
> > RAM memory region.
> >
> > PS:
> > While at it, get rid of no longer needed CubieBoardState wrapper.
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Andrew Jones <drjones@redhat.com>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Message-Id: <20200219160953.13771-13-imammedo@redhat.com>
> > ---
> >  hw/arm/cubieboard.c | 25 ++++++++-----------------
> >  1 file changed, 8 insertions(+), 17 deletions(-)
> >
> > diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
> > index 6dc2f1d..089f9a3 100644
> > --- a/hw/arm/cubieboard.c
> > +++ b/hw/arm/cubieboard.c
> > @@ -28,52 +28,42 @@ static struct arm_boot_info cubieboard_binfo = {
> >      .board_id = 0x1008,
> >  };
> >
> > -typedef struct CubieBoardState {
> > -    AwA10State *a10;
> > -    MemoryRegion sdram;
> > -} CubieBoardState;
> > -
> >  static void cubieboard_init(MachineState *machine)
> >  {
> > -    CubieBoardState *s = g_new(CubieBoardState, 1);
> > +    AwA10State *a10 = AW_A10(object_new(TYPE_AW_A10));
> >      Error *err = NULL;
> >
> > -    s->a10 = AW_A10(object_new(TYPE_AW_A10));  
> 
> Hi Igor, I just noticed this, and I don't think it's the
> right thing. The board model should have its own state
> structure which contains any objects it creates. Just
> because there happens currently to be only a single
> object in this case doesn't mean we want to lose the
> structure. In particular, we now just leak the
> pointer to the TYPE_AW_A10 object, rather than having
> it be tracked by being pointed to from the MachineState.
> Being able to avoid just leaking pointers to objects like
> that is one of the reasons I like having a MachineState now.
The reason why this structure was removed was that it wasn't
MachineState object but a random structure which was a common
pattern in pre-QOM qemu.

Code was allocating 's', assigning pointer to s->a10 member and
then happily loosing both pointers in the end.

Since rewriting such "states" to objects derived from
MachineState was out of scope of memory-backend refactoring
I've opted to in favor of simplified cleanup, which removes
at least 1 lost pointer. This way however touches that code
again to store some additional board state or actually fix
pre-existing a10 object_new leak, could be asked to use
MachineState derived object for that.

So patch isn't changing anything in terms of lost pointers
or proper board modeling.

> Could you send a patch that reverts this bit, please
> (and any of the other boards where you did this in
> the course of this refactoring)?

I can convert it to MachineState derived board as
an example to follow.

But it would be best if target/board maintainers would
take care of other boards to MachineState objects
across respective targets, to get rid of legacy examples
so it won't be copied later on.

In some cases it's trivial (like with this board) but in
other cases it's a bit more complicated (Like Philippe
did with RPi boards).

> thanks
> -- PMM
> 


