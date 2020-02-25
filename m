Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20F4C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA422064A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hc190EdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA422064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6bW2-0003vV-IE
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 09:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j6bVI-0003Sz-JY
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j6bVG-0004Jv-UV
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:48:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42689
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j6bVF-0004Iz-PA
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582642084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dt8sAbNbRoJwVElkyjF1TwUhGRgiM4ixeDE8DWOKqns=;
 b=Hc190EdTupnHA9ojHNWtf0o7NbFMLg0Efw4nl9wgQj28Bk3UK7fILdXw5e0YGWq+Lt8czd
 Mm5zgvyJoYruahIm7yNrXAc7kNz4naa4wFypPeljBN79o1OWVDVh9L16OMj8nk1sKMFySS
 SziywHcW2EkXr+b7w+K/ARGwA2dzR8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-Txe_mafxN5iMb6W0a-kGAg-1; Tue, 25 Feb 2020 09:48:00 -0500
X-MC-Unique: Txe_mafxN5iMb6W0a-kGAg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26A5B800D53;
 Tue, 25 Feb 2020 14:47:57 +0000 (UTC)
Received: from gondolin (dhcp-192-175.str.redhat.com [10.33.192.175])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B25498ED01;
 Tue, 25 Feb 2020 14:47:52 +0000 (UTC)
Date: Tue, 25 Feb 2020 15:47:50 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Viktor Mihajlovski <mihajlov@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/ipl: sync back loadparm
Message-ID: <20200225154750.6bee1c52.cohuck@redhat.com>
In-Reply-To: <853387e3-4425-731b-bb09-a7210ea6b299@linux.ibm.com>
References: <20200224150213.21253-1-pasic@linux.ibm.com>
 <05f7dcf7-a0c7-8811-6b88-df86d5fa0974@redhat.com>
 <20200225125641.72e8cc86.pasic@linux.ibm.com>
 <853387e3-4425-731b-bb09-a7210ea6b299@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Marc Hartmayer <mhartmay@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 15:35:47 +0100
Viktor Mihajlovski <mihajlov@linux.ibm.com> wrote:

> On 2/25/20 12:56 PM, Halil Pasic wrote:
> > On Tue, 25 Feb 2020 10:39:40 +0100
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> On 24.02.20 16:02, Halil Pasic wrote:  
> >>> We expose loadparm as a r/w machine property, but if loadparm is set by
> >>> the guest via DIAG 308, we don't update the property. Having a
> >>> disconnect between the guest view and the QEMU property is not nice in
> >>> itself, but things get even worse for SCSI, where under certain
> >>> circumstances (see 789b5a401b "s390: Ensure IPL from SCSI works as
> >>> expected" for details) we call s390_gen_initial_iplb() on resets
> >>> effectively overwriting the guest/user supplied loadparm with the stale
> >>> value.
> >>>
> >>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> >>> Fixes: 7104bae9de "hw/s390x: provide loadparm property for the machine"

Please use the format

Fixes: <hash> ("subject")

> >>> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> >>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> >>> Reviewed-by: Viktor Mihajlovski <mihajlov@linux.ibm.com>
> >>> Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> >>> ---
> >>>   hw/s390x/ipl.c | 21 +++++++++++++++++++++
> >>>   1 file changed, 21 insertions(+)
> >>>
> >>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c  
> [...]
> >>> +
> >>> +    /* Sync loadparm */
> >>> +    if (iplb->flags & DIAG308_FLAGS_LP_VALID) {
> >>> +        char ascii_loadparm[8];
> >>> +        uint8_t *ebcdic_loadparm = iplb->loadparm;
> >>> +        int i;
> >>> +
> >>> +        for (i = 0; i < 8 && ebcdic_loadparm[i]; i++) {
> >>> +            ascii_loadparm[i] = ebcdic2ascii[(uint8_t) ebcdic_loadparm[i]];
> >>> +        }
> >>> +        ascii_loadparm[i] = 0;
> >>> +        object_property_set_str(mo, ascii_loadparm, "loadparm", NULL);
> >>> +    } else {
> >>> +        object_property_set_str(mo, "", "loadparm", NULL);
> >>> +    }  
> >>
> >> &error_abort instead of NULL, we certainly want to know if this would
> >> ever surprisingly fail.  
> > 
> > IMHO this is a typical assert() situation where one would like to have
> > a fast and obvious failure when testing, but not in production.
> > 
> > AFAIU the guest can trigger this code at any time, and crashing the
> > whole (production) system seems a bit heavy handed to me. The setter
> > should only fail if something is buggy.
> > 
> > But if the majority says &error_abort I can certainly do. Other opinions?
> >   
> We might consider to return 0x0402 (invalid parameter) from the diag308 
> "set", which is less drastic and would allow the OS to do whatever it 
> finds appropriate to deal with the failure. Not that Linux would care 
> about that today :-).

I'm not sure if we could actually get there in any other way than via a
QEMU coding error... not sure if I would trust QEMU to inject a return
code if it already had a code logic fail right before that :)


