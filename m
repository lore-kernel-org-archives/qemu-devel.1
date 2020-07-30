Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB829C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 09:46:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E8C22075F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 09:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCzLHfBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8C22075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k159H-00073G-BQ
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 05:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k158U-0006ME-5C
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 05:46:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20916
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k158R-0008F0-4v
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 05:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596102357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xynJH410Zp5n/uQ+6+57XOtSHVdM21IMUCM7yAo3biE=;
 b=dCzLHfBDTniC2UKwMPpb6/Gi2El+NIY/AShjwi+WO5lr8zAJdlpwLIUK5nksHqq1pxznpo
 DjwoemueXf5Y39LhyDowjN3uOCWmMj+kTYQ/UjcjZU+4eLTmnWnZZIp+vEIDM0yi/VDnW0
 Xatuq8xS0ngD0oUiObSVWIzPqD5HgdE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-DvLsdWkUOn-DTSX3n1AG1A-1; Thu, 30 Jul 2020 05:45:55 -0400
X-MC-Unique: DvLsdWkUOn-DTSX3n1AG1A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3802C1B2C980;
 Thu, 30 Jul 2020 09:45:52 +0000 (UTC)
Received: from gondolin (ovpn-112-203.ams2.redhat.com [10.36.112.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC8785DA76;
 Thu, 30 Jul 2020 09:45:43 +0000 (UTC)
Date: Thu, 30 Jul 2020 11:45:41 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC PATCH v3 8/8] target/s390x: Use start-powered-off CPUState
 property
Message-ID: <20200730114541.4dbdd15e.cohuck@redhat.com>
In-Reply-To: <87a6zjuoru.fsf@morokweng.localdomain>
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <20200723025657.644724-9-bauerman@linux.ibm.com>
 <20200727144350.47abd7e7.cohuck@redhat.com>
 <87a6zjuoru.fsf@morokweng.localdomain>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 21:51:33 -0300
Thiago Jung Bauermann <bauerman@linux.ibm.com> wrote:

> Hi,
> 
> Cornelia Huck <cohuck@redhat.com> writes:
> 
> > On Wed, 22 Jul 2020 23:56:57 -0300
> > Thiago Jung Bauermann <bauerman@linux.ibm.com> wrote:
> >  
> >> Instead of setting CPUState::halted to 1 in s390_cpu_initfn(), use the
> >> start-powered-off property which makes cpu_common_reset() initialize it
> >> to 1 in common code.
> >> 
> >> Note that this changes behavior by setting cs->halted to 1 on reset, which
> >> didn't happen before.  
> >
> > I think that should be fine, as we change the cpu state to STOPPED in
> > the reset function, which sets halted to 1.  
> 
> Nice, thanks for checking.
> 
> >> 
> >> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> >> ---
> >>  target/s390x/cpu.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> NB: I was only able to test that this patch builds. I wasn't able to
> >> run it.  
> >
> > No noticeable difference under kvm, but running under tcg seems a bit
> > more sluggish than usual, and I saw some pausing on reboot (after the
> > bios handover to the kernel). Not sure if it were just flukes on my
> > laptop, would appreciate if someone else could give it a go.  

Experimented a bit with it again. There's a pause when switching from
the bios to the kernel (after the load reset normal has been done, I
guess), which is always there, but seems to get more noticeable with
this patch (varying wildly, but seems longer on average.) Hard to pin
down, and I don't really see a reason why that should happen, as we
should end up with halted == 1 in any case. Might still be a fluke,
even though I see it both on my laptop and on an LPAR (when running
under tcg; not seen under kvm, which is much faster anyway.)

> 
> I tried today setting up a TCG guest, but didn't have success yet.
> Will try some more tomorrow.
> 

I'm also looking a bit at the other s390 folks :)


