Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4573FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 14:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB6E207CB
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 14:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gt1IdJy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB6E207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdDuy-0007fI-5y
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 10:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jdDsP-0005RV-PM
 for qemu-devel@nongnu.org; Mon, 25 May 2020 10:14:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47410
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jdDsO-0005cD-Lf
 for qemu-devel@nongnu.org; Mon, 25 May 2020 10:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590416087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OiwJGvTN3HrhwqBiQ8DjJJ09hKLRdrRNUuALUzufES0=;
 b=gt1IdJy/wUrdy3Goll4H8pIiMxcw2RFNyTqjqcwIk16DlvsgcL/97o5iBME2fJ9qJP9+9z
 eTwA23VvnrXgNt41q9QAZ+hTQstVTjp8bgwWoaBIbwC2fm/gJ4Pitvl9L9ghEHfCEQxloX
 JXkfFEZod3OeJLuGuBPsr4jHPRvzxdU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-x_wiCoiQMOSLCZUiloB7zA-1; Mon, 25 May 2020 10:14:46 -0400
X-MC-Unique: x_wiCoiQMOSLCZUiloB7zA-1
Received: by mail-qk1-f200.google.com with SMTP id v6so18095872qkh.7
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 07:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OiwJGvTN3HrhwqBiQ8DjJJ09hKLRdrRNUuALUzufES0=;
 b=VRMEoiGuC/7fUaMtMTLtN5NjVMyMyUPodF56E3edpLufrD0ctFieOPjGdj7rovBec5
 4sp7gxFa7z8PB/JZk89dghiJSThrDfML2MdGbV43/eq5bQRqDKTrkntz7jDfwBMilr/l
 TaBVH95D8M8hOC7IXWqbmNMKvG8HwbITwFErgrUoOvUgZIx8U6+mwmBcXvKcU93h8FF/
 tTHpv3qQ5GiJGHM1C2Y5SGQ2Yx7TWg81YfVC2uWjoQX7vCCL8I7axUQq75XT1UWSYnnP
 7aSoSU9QTxNPxt6mL7nt/slMQf2PH6rNJPpmeWA+lhZwrP3FncfvZ81tp4qwT1GpVUJO
 en5w==
X-Gm-Message-State: AOAM533KhkfNiiTFVqVef8jEqmFfjBD6OJFGJ+2uznij6N7I9yFo4EQa
 fJ3zmyqFaM8YfViEettpN+y0TlAyJPclgn5mgE3wGuoCFctRrBZMsOn/TXkULbVutdy3IQmr/q0
 hAB7alJ4JZjGsx7A=
X-Received: by 2002:ae9:edd8:: with SMTP id
 c207mr27781379qkg.347.1590416085691; 
 Mon, 25 May 2020 07:14:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+E/pDkXg7rlCbmwraPtNWLh4hyEts+fbkCkrL7rVYgpZV806zFgC/ZsNUs3N+IUKKwkYjYA==
X-Received: by 2002:ae9:edd8:: with SMTP id
 c207mr27781355qkg.347.1590416085394; 
 Mon, 25 May 2020 07:14:45 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id h15sm13094434qkh.18.2020.05.25.07.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 07:14:44 -0700 (PDT)
Date: Mon, 25 May 2020 10:14:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] pci: Display PCI IRQ pin in "info pci"
Message-ID: <20200525141443.GB1058657@xz-x1>
References: <20200317195908.283800-1-peterx@redhat.com>
 <87a71wfmv6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87a71wfmv6.fsf@dusky.pond.sub.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 02:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Markus,

Thanks for commenting.  Please see below.

On Mon, May 25, 2020 at 10:19:09AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Sometimes it would be good to be able to read the pin number along
> > with the IRQ number allocated.  Since we'll dump the IRQ number, no
> > reason to not dump the pin information.  For example, the vfio-pci
> > device will overwrite the pin with the hardware pin number.  It would
> > be nice to know the pin number of one assigned device from QMP/HMP.
> >
> > CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > CC: Alex Williamson <alex.williamson@redhat.com>
> > CC: Michael S. Tsirkin <mst@redhat.com>
> > CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > CC: Julia Suvorova <jusual@redhat.com>
> > CC: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >
> > This helped me to debug an IRQ sharing issue, so may good to have it
> > in master too.
> > ---
> [...]
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index c18fe681fb..f8d33ddb4e 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -403,6 +403,8 @@
> >  #
> >  # @irq: if an IRQ is assigned to the device, the IRQ number
> >  #
> > +# @irq_pin: the IRQ pin, zero means no IRQ (since 5.1)
> > +#
> 
> For the IRQ number, we make the member optional, and use "member absent"
> for "no IRQ assigned".
> 
> For the IRQ pin, we make the member mandatory, and use zero value for
> "no IRQ assigned".
> 
> Any particular reason for the difference?

I have two reasons.

Spec-wise, "irq" (PCI_INTERRUPT_LINE) is optional which should depend on
"irq_pin" (PCI_INTERRUPT_PIN), while "irq_pin" itself is not optional according
to PCI local bus spec 3.0:

        Interrupt Pin

        The Interrupt Pin register tells which interrupt pin the device (or
        device function) uses. A value of 1 corresponds to INTA# . A value of 2
        corresponds to INTB# . A value of 3 corresponds to INTC# . A value of 4
        corresponds to INTD# . Devices (or device functions) that do not use an
        interrupt pin must put a 0 in this register. The values 05h through FFh
        are reserved. This register is read-only. Refer to Section 2.2.6 for
        further description of the usage of the INTx# pins.

So it should be a value between 0-4, inclusive.  It applies even if the device
does not support INTx.

Code-wise, we can also make "irq_pin" optional just like "irq" (which will
automatically create the has_irq_pin variable).  However, then it means we'll
have two booleans for the same purpose for intx in PciDeviceInfo, which seems
to be an unnecessary duplication.

So I chose the simple to make it mandatory.

Thanks,

-- 
Peter Xu


