Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2A0C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 22:14:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C63A42071B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 22:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3zakYwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63A42071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHxEy-0005eO-1L
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 18:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jHxE9-0005ES-3G
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:13:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jHxE5-0008MF-LJ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:13:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jHxE5-0008Jw-GE
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585347196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=86AMx1mwNCI3p4Bp2R5vT6i9zSj1Ss9GTCIBFnglsZg=;
 b=X3zakYwcKtcCvkLMQcm1Aq4TzDEGITe3y/pjUxShwUEegiPDBZrW48BhLLQdn6p1tszUFy
 bFhXM7JFD5VohUqqUlqffDAxf9esjyblXvYy7exIgsQ0dClzcpzMuUCDq105FyZr+hIO6H
 l+KOx1Kle3QPkC4ZvgePS6b3wbBrAtE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-vhLXCADbOtSwLI2qt2gnbg-1; Fri, 27 Mar 2020 18:13:12 -0400
X-MC-Unique: vhLXCADbOtSwLI2qt2gnbg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A83B91084420;
 Fri, 27 Mar 2020 22:13:11 +0000 (UTC)
Received: from localhost (unknown [10.40.208.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0C4C60BF3;
 Fri, 27 Mar 2020 22:13:05 +0000 (UTC)
Date: Fri, 27 Mar 2020 23:13:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1] s390x: Reject unaligned RAM sizes
Message-ID: <20200327231303.30d76ddf@redhat.com>
In-Reply-To: <4c5e56fd-a5e2-efe0-9a1a-99acb91aaf71@redhat.com>
References: <20200327152930.66636-1-david@redhat.com>
 <64cefab8-f1e0-fbc7-27d3-4f28758c595a@de.ibm.com>
 <d8fb50c1-639a-826c-0dce-e2ddc26ae5e1@redhat.com>
 <24681aa0-9053-238f-89da-8ce08d34241d@de.ibm.com>
 <20200327174620.06b9c324@redhat.com>
 <4c5e56fd-a5e2-efe0-9a1a-99acb91aaf71@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: =?UTF-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr . David Alan
 Gilbert" <dgilbert@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Mar 2020 17:53:39 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 27.03.20 17:46, Igor Mammedov wrote:
> > On Fri, 27 Mar 2020 17:05:34 +0100
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> On 27.03.20 17:01, David Hildenbrand wrote:  
> >>> On 27.03.20 16:34, Christian Borntraeger wrote:    
> >>>>
> >>>>
> >>>> On 27.03.20 16:29, David Hildenbrand wrote:    
> >>>>> Historically, we fixed up the RAM size (rounded it down), to fit into
> >>>>> storage increments. Since commit 3a12fc61af5c ("390x/s390-virtio-ccw: use
> >>>>> memdev for RAM"), we no longer consider the fixed-up size when
> >>>>> allcoating the RAM block - which will break migration.
> >>>>>
> >>>>> Let's simply drop that manual fixup code and let the user supply sane
> >>>>> RAM sizes. This will bail out early when trying to migrate (and make
> >>>>> an existing guest with e.g., 12345 MB non-migratable), but maybe we
> >>>>> should have rejected such RAM sizes right from the beginning.
> >>>>>
> >>>>> As we no longer fixup maxram_size as well, make other users use ram_size
> >>>>> instead. Keep using maxram_size when setting the maximum ram size in KVM,
> >>>>> as that will come in handy in the future when supporting memory hotplug
> >>>>> (in contrast, storage keys and storage attributes for hotplugged memory
> >>>>>  will have to be migrated per RAM block in the future).
> >>>>>
> >>>>> This fixes (or rather rejects early):
> >>>>>
> >>>>> 1. Migrating older QEMU to upstream QEMU (e.g., with "-m 1235M"), as the
> >>>>>    RAM block size changed.    
> >>>>
> >>>> Not sure I like this variant. Instead of breaking migration (that was 
> >>>> accidentially done by Igors changes) we now reject migration from older
> >>>> QEMUs to 5.0. This is not going to help those that still have such guests
> >>>> running and want to migrate.     
> >>>
> >>> As Igor mentioned on another channel, you most probably can migrate an
> >>> older guest by starting it on the target with a fixed-up size.
> >>>
> >>> E.g., migrate an old QEMU "-m 1235M" to a new QEMU "-m 1234M"    
> >>
> >> Yes, that should probably work.  
> > I'm in process of testing it.

it works

> >   
> >>> Not sure how many such weird-size VMs we actually do have in practice.    
> >>
> >> I am worried about some automated deployments where tooling has created
> >> these sizes for dozens or hundreds of containers in VMS and so.  
> 
> IIRC, e.g., Kata usually uses 2048MB. Not sure about others, but I'd be
> surprised if it's not multiples of, say, 128MB.
> 
> > Yep, it's possible but then that tooling/configs should be fixed to work with
> > new QEMU that validates user's input.
> >   
> 
> Yeah, and mention it in the cover letter, +eventually a "fixup" table
> (e.g., old_size < X, has to be aligned to Y).
> 
> One alternative is to have an early fixup hack in QEMU, that fixes up
> the sizes as we did before (and eventually warns the user). Not sure if
> we really want/need that.
That would require at least a callback at machine level, 
also practice shows warnings are of no use.

If someone insist on using wrong size with new QEMU, one can write a wrapper
script to workaround the issue (if they don't wish to fix configs/tooling).
I don't like keeping hacks to fix user mistakes in QEMU and on top of that
adding infrastructure for that (QEMU is already too much complicated).
Since in this case it break migration only partially, it's sufficient
to print error message that suggest correct size to use (like it's been done
for other boards, s390 is the last remaining that is doing ram_size fixups).
That way user could fix config and restart migration.


