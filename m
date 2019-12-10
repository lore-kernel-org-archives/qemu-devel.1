Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F76C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C142077B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4SlvSTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C142077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iefI1-0002Uv-8Z
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 08:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iefH8-0001iw-AP
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 08:10:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iefH5-0000Iq-0A
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 08:10:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23512
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iefH4-0000Hb-RU
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 08:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575983397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sbO+xwlnU6MH3LHC2x3Sepu2MEndRiozHunXbyQHWeg=;
 b=C4SlvSTY/eQjuSDwFUpYJTbdjZo8I3nUl6Q48UneHCi8Ctvj/ybj1fgpyYjiwdUgwIs1oU
 Sp/h4kmPV6f7E90ygV/MP91bm4KRiQhcMVXK7NDMQ+3eMFa3vsqZp+2CRF5vgzGmcg8oX2
 aTsnswNVMa4jaFQRwnqJTGddfVe32h0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-tgQg54HoPMWJUmbzbSbYVg-1; Tue, 10 Dec 2019 08:09:56 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CF75800D4C;
 Tue, 10 Dec 2019 13:09:55 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A7FC10016DA;
 Tue, 10 Dec 2019 13:09:50 +0000 (UTC)
Date: Tue, 10 Dec 2019 14:09:49 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 2/2] Add -mem-shared option
Message-ID: <20191210140949.4a1c3ff2@redhat.com>
In-Reply-To: <87tv6831vr.fsf@dusky.pond.sub.org>
References: <20191128172807.788e6aeb@redhat.com>
 <CAJ+F1CLZxhMf-bOAB4sVfuB1yaUMqiO70-ogpKVS3CqfC7y5KA@mail.gmail.com>
 <20191129110703.2b15c541@redhat.com>
 <04dadf85-cd35-fd37-9642-8087cba625bd@redhat.com>
 <20191129131652.6683b769@redhat.com>
 <528bb183-3d44-e541-8765-9c0e01f23157@redhat.com>
 <20191202083948.3e8bb134@redhat.com>
 <20191202210057.GQ14595@habkost.net>
 <1ff4cc6a-0ec8-96ff-1e39-e682429852e4@redhat.com>
 <20191203154303.035c33b3@redhat.com>
 <20191209205840.GJ498046@habkost.net>
 <87tv6831vr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: tgQg54HoPMWJUmbzbSbYVg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 libvir-list@redhat.com, QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1B?= =?UTF-8?B?bmRyw6k=?= Lureau <marcandre.lureau@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Dec 2019 11:34:32 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > +Markus
> >
> > On Tue, Dec 03, 2019 at 03:43:03PM +0100, Igor Mammedov wrote:  
> >> On Tue, 3 Dec 2019 09:56:15 +0100
> >> Thomas Huth <thuth@redhat.com> wrote:
> >>   
> >> > On 02/12/2019 22.00, Eduardo Habkost wrote:  
> >> > > On Mon, Dec 02, 2019 at 08:39:48AM +0100, Igor Mammedov wrote:    
> >> > >> On Fri, 29 Nov 2019 18:46:12 +0100
> >> > >> Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> > >>    
> >> > >>> On 29/11/19 13:16, Igor Mammedov wrote:    
> >> > >>>> As for "-m", I'd make it just an alias that translates
> >> > >>>>  -m/mem-path/mem-prealloc      
> >> > >>>
> >> > >>> I think we should just deprecate -mem-path/-mem-prealloc in 5.0.  CCing
> >> > >>> Thomas as mister deprecation. :)    
> >> > >>
> >> > >> I'll add that to my series    
> >> > > 
> >> > > Considering that the plan is to eventually reimplement those
> >> > > options as syntactic sugar for memory backend options (hopefully
> >> > > in less than 2 QEMU releases), what's the point of deprecating
> >> > > them?    
> >> > 
> >> > Well, it depends on the "classification" [1] of the parameter...
> >> > 
> >> > Let's ask: What's the main purpose of the option?
> >> > 
> >> > Is it easier to use than the "full" option, and thus likely to be used
> >> > by a lot of people who run QEMU directly from the CLI? In that case it
> >> > should stay as "convenience option" and not be deprecated.
> >> > 
> >> > Or is the option merely there to give the upper layers like libvirt or
> >> > some few users and their scripts some more grace period to adapt their
> >> > code, but we all agree that the options are rather ugly and should
> >> > finally go away? Then it's rather a "legacy option" and the deprecation
> >> > process is the right way to go. Our QEMU interface is still way 
> >> > overcrowded, we should try to keep it as clean as possible.  
> >> 
> >> After switching to memdev for main RAM, users could use relatively
> >> short global options
> >>  -global memory-backend.prealloc|share=on
> >> and
> >>  -global memory-backend-file.mem-path=X|prealloc|share=on
> >> 
> >> instead of us adding and maintaining slightly shorter
> >>  -mem-shared/-mem-path/-mem-prealloc  
> >
> > Global properties are a convenient way to expose knobs through
> > the command line with little effort, but we have no documentation
> > on which QOM properties are really supposed to be touched by
> > users using -global.
> >
> > Unless we fix the lack of documentation, I'd prefer to have
> > syntactic sugar translated to -global instead of recommending
> > direct usage of -global.  
> 
> Fair point.
> 
> I'd take QOM property documentation over still more sugar.
> 
> Sometimes, the practical way to make simple things simple is sugar.  I
> can accept that.  This doesn't look like such a case, though.
I can document concrete globals as replacement at the place
-mem-path/-mem-prealloc are documented during deprecation and
then in 2 releases we will just drop legacy syntax and keep only
globals over there.
(eventually it will spread various globals
over man page, which I don't like but we probably should start
somwhere and consolidate later if globals in man page become
normal practice.)


