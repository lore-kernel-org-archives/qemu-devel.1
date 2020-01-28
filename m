Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5219C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 917F924681
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cn4KHSvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917F924681
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwPfR-000805-OI
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 07:08:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iwPet-0007Yz-9O
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:07:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iwPer-0005JH-2T
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:07:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26457
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iwPeq-0005GP-Qs
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580213271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l58ak9/3YgLrgjbsIBRj9jOWk9atJ0it68/oGjo4+QY=;
 b=cn4KHSvc/lQRKttfwCKD0FC2Ze+A/75a2YXTunhqgDqH5DN2YQ9MG6Jm0fnXBEeMvqJlNk
 kD8CufzNwiwe/zQH/F53sYu25WczWuKc/1fiQijh07xdzGwxOtCyzNG+ZivQIsnwIL8ewM
 bhMWYIzZQY4BOHjws+vsp2wuUtMRP5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-DDHr5hR4PT687sZeNr1n0g-1; Tue, 28 Jan 2020 07:07:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C88C31005516;
 Tue, 28 Jan 2020 12:07:48 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 100EF19C58;
 Tue, 28 Jan 2020 12:07:41 +0000 (UTC)
Date: Tue, 28 Jan 2020 13:07:40 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH REPOST v3 78/80] hostmem: fix strict bind policy
Message-ID: <20200128130740.2f075e04@redhat.com>
In-Reply-To: <20200127154145.42e5a197.pasic@linux.ibm.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-79-git-send-email-imammedo@redhat.com>
 <20200124201748.1882b620.pasic@linux.ibm.com>
 <20200127083925.225859bc@redhat.com>
 <20200127154145.42e5a197.pasic@linux.ibm.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: DDHr5hR4PT687sZeNr1n0g-1
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
Cc: ehabkost@redhat.com, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 gongsu@us.ibm.com, Stefan Hajnoczi <stefanha@redhat.com>,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jan 2020 15:41:45 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Mon, 27 Jan 2020 08:39:25 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Fri, 24 Jan 2020 20:17:48 +0100
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >   
> > > On Thu, 23 Jan 2020 12:38:43 +0100
> > > Igor Mammedov <imammedo@redhat.com> wrote:
> > >   
> > > > With main RAM now converted to hostmem backends, there is no
> > > > point in keeping global mem_prealloc around, so alias
> > > >  -mem-prealloc to "memory-backend.prealloc=on"
> > > > machine compat[*] property and make mem_prealloc a local
> > > > variable to only stir registration of compat property.
> > > > 
> > > > *) currently user accessible -global works only with DEVICE
> > > >    based objects and extra work is needed to make it work
> > > >    with hostmem backends. But that is convenience option
> > > >    and out of scope of this already huge refactoring.
> > > >    Hence machine compat properties were used.    
> > > 
> > > AFAIU because of this something like
> > > -global memory-backend-file.share=on
> > > (as proposed by
> > > https://lists.nongnu.org/archive/html/qemu-devel/2019-12/msg00531.html)
> > > can not be used to make the main RAM shared (e.g. for vhost on s390x).
> > > Or am I wrong? If not, is -global still the way we want to make this work
> > > for non-numa machines, or did I miss updates?  
> > 
> > one should be able to use memory-backend property to make it work
> > instead of -m convenience option in s390 case.  
> 
> Thank you very much for the quick response!
> 
> Honestly, I overlooked the memory-backed machine property, but regardless
> of that -machine,memory-backend=id *does not seem viable* at the
> moment.
> 
> My understanding is that one has to do something like:        
> -machine type=s390-ccw-virtio,memory-backend=mem \
> -object memory-backend-file,id=mem,size=2G,mem-path=/dev/shm/virtiofs.shm,share=on \
> 
> I get 
> qemu: : Device 'mem' not found
> because the 'memory-backend-*' objects are delayed,
> i.e. !object_create_initial(), and at the time when
> machine_set_property() tries to look the memory-backend up the
> memory-backend is not yet created.
> 
> For why delayed, object_create_initial()  has a comment:
> 
>     /* Memory allocation by backends needs to be done
>      * after configure_accelerator() (due to the tcg_enabled()
>      * checks at memory_region_init_*()).
>      *
>      * Also, allocation of large amounts of memory may delay
>      * chardev initialization for too long, and trigger timeouts
>      * on software that waits for a monitor socket to be created
>      * (e.g. libvirt).
>      */
>     if (g_str_has_prefix(type, "memory-backend-")) {
> 
> Or, am I using it wrong?

You right, 
I even had an alternative impl. earlier that used string property
instead of link, but later I forgot about this complication
and simplified it to link property which works fine but only
for -m case.

It's necessary to rewrite patches 2-4/80 to use string property
for memory-backend which will be used for delayed backend access
at machine_run_board_init() time.

I'll CC you on relevant patches for reviewing when I post v4.

> > 
> > As for -global for objects (or more limited variant for memory-backends),
> > it needs more work to support objects. (that's mostly policy decision)
> >   
> 
> I agree.
> 
> Regards,
> Halil
> 


