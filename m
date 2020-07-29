Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B038C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 14:15:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 140CB2070B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 14:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrRgm4tx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140CB2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0mrO-000518-BK
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 10:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k0mqR-000497-Gv
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 10:14:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26908
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k0mqP-0007v3-M3
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 10:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596032048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OgV7sTNQVXQDE4XGoL2ZdJL5SrGpdQR/5rkPojTYH1A=;
 b=OrRgm4txx8dUioshfO/az/z3SnQ3GDC8tUHw4LD++diIYjFk2k6cbA89/2wo6l5toic5AP
 XhJBzX9plaid0Xgd69teaZPsNCUr7YwS3qSiooBRJM/BFDGyGIRh1ytZajzBysBk+yB3ya
 JnZw8nHHL29/oKnqbbqHYS1jz4vnb5k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-gUu8IOW-Mv6PplwIpEo1nw-1; Wed, 29 Jul 2020 10:14:03 -0400
X-MC-Unique: gUu8IOW-Mv6PplwIpEo1nw-1
Received: by mail-wm1-f69.google.com with SMTP id z74so636233wmc.4
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 07:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=OgV7sTNQVXQDE4XGoL2ZdJL5SrGpdQR/5rkPojTYH1A=;
 b=BM9LKYcFOTjBYjtez/v9FoULPVhultW/POdqPjzEgCD8eYxB4oJCA7u+Jxb8Z67riT
 6DIR6HjAEzgsAY4N2oap0VE/BelwunA1oXWzaR2LMX1H6ZtA0TU4eitzkyDX8hRr1X/h
 6x5hKONEa9sR7BJhxFFMOJ6KTv9amFePRyAeUk8Dsh4ZtGdKy3z6uLC3pypxDB2y+Ci5
 xbe9Imam9tcsnjg9IVdoapSbP+ZgldM1uUAYOa4tefB9eoJrn6YTezrjidATgdeN7Bdv
 QQbUGYDumdes4O+BZpPAeyibYXTMPbtimxsrVaDIz7mZpap8ahUTmTFA/gQ2vKc58zly
 4SyQ==
X-Gm-Message-State: AOAM530ALhh/ijSLHBiYm6aoWixv39bMgr5d43D8iXaDGOnFTutJUBlc
 IMUzW6nvS8J5rZX5bRfH6Wz2pztgWJwHOG5w3yfLEFSm+kRJAvdkfm3OfAPNXrL57tJtyLHOKUe
 q5mXgOxAnKLby7Pw=
X-Received: by 2002:adf:dbce:: with SMTP id e14mr29400314wrj.244.1596032042073; 
 Wed, 29 Jul 2020 07:14:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzS1V/q72qEKEKg+VsF6sNFGNz4lguZMJ5Ep3B5kiEmomirVnmdTTKGhlnY59rkdgI6kwxydQ==
X-Received: by 2002:adf:dbce:: with SMTP id e14mr29400299wrj.244.1596032041833; 
 Wed, 29 Jul 2020 07:14:01 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id r16sm7351918wrr.13.2020.07.29.07.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 07:14:00 -0700 (PDT)
Date: Wed, 29 Jul 2020 10:13:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [RFC v2 2/3] libvhost-user: handle endianness as mandated by the
 spec
Message-ID: <20200729101304-mutt-send-email-mst@kernel.org>
References: <20200717092929.19453-1-mhartmay@linux.ibm.com>
 <20200717092929.19453-3-mhartmay@linux.ibm.com>
 <20200721093942-mutt-send-email-mst@kernel.org>
 <20200721184456.1305ca0b.pasic@linux.ibm.com>
 <87lfj39ajo.fsf@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <87lfj39ajo.fsf@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:18:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 28, 2020 at 12:52:11PM +0200, Marc Hartmayer wrote:
> On Tue, Jul 21, 2020 at 06:44 PM +0200, Halil Pasic <pasic@linux.ibm.com> wrote:
> > On Tue, 21 Jul 2020 09:40:10 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >
> >> On Fri, Jul 17, 2020 at 11:29:28AM +0200, Marc Hartmayer wrote:
> >> > Since virtio existed even before it got standardized, the virtio
> >> > standard defines the following types of virtio devices:
> >> > 
> >> >  + legacy device (pre-virtio 1.0)
> >> >  + non-legacy or VIRTIO 1.0 device
> >> >  + transitional device (which can act both as legacy and non-legacy)
> >> > 
> >> > Virtio 1.0 defines the fields of the virtqueues as little endian,
> >> > while legacy uses guest's native endian [1]. Currently libvhost-user
> >> > does not handle virtio endianness at all, i.e. it works only if the
> >> > native endianness matches with whatever is actually needed. That means
> >> > things break spectacularly on big-endian targets. Let us handle virtio
> >> > endianness for non-legacy as required by the virtio specification
> >> > [1]. We will fence non-legacy virtio devices with the upcoming patch.
> >> > 
> >> > [1] https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-210003
> >> > 
> >> > Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> >> > 
> >> > ---
> >> > Note: As we don't support legacy virtio devices  
> >> 
> >> Who's "we" in this sentence? vhost user supports legacy generally ...
> >
> > In that sentence "we" is the library "libvhost-user". I would like
> > to avoid s390x being an oddball regarding this. Marc's previous
> > version made an attempt at correct endianness handling for legacy
> > and non-legacy. That spawned a discussion on how we don't want
> > legacy devices in this context. This series makes what seemed to be the
> > consensus reached in that discussion explicit: namely that libvhost-user
> > does not support legacy-virtio.
> 
> Hi Michael,
> 
> Polite ping - what’s your opinion? Thanks in advance.
> 
> […snip]

It's a reasonable limitation, but I also don't see anything
that verifies that device is modern only.
E.g. fail setting features if VIRTIO_F_VERSION_1 is not there?


> -- 
> Kind regards / Beste Grüße
>    Marc Hartmayer
> 
> IBM Deutschland Research & Development GmbH
> Vorsitzender des Aufsichtsrats: Gregor Pillen 
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen
> Registergericht: Amtsgericht Stuttgart, HRB 243294


