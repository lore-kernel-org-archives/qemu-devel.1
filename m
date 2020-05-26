Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C334C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDA62071A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1a71CKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDA62071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUxn-0000Tp-8r
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 04:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdUwC-0006Oi-0q
 for qemu-devel@nongnu.org; Tue, 26 May 2020 04:27:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53270
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdUwB-00005N-1q
 for qemu-devel@nongnu.org; Tue, 26 May 2020 04:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590481670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gmkbyNP5oHuo9ed9gZhRLAsCQ1kaQdXN6hJx2hdhNwU=;
 b=X1a71CKondtsSZmKqjC5py/rP7W8uE5bMWxwlGrlBY51V5DxkLFec8j2VpFu1WM6NRoz6P
 krDwEnepiAliou9J3LgB3M9SeKbyyUhyq/1IrZENwCyDnkO7xLIWmaWKS1a/njAGuZuuSz
 yuWQVBrPJ55HNqTrwBmoF8eOFQnkXVk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-McGhl24uOxWKcIRhKT5vYQ-1; Tue, 26 May 2020 04:27:48 -0400
X-MC-Unique: McGhl24uOxWKcIRhKT5vYQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90904100CCC0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 08:27:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BC951BCBE;
 Tue, 26 May 2020 08:27:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B1EB3113864A; Tue, 26 May 2020 10:27:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] pci: Display PCI IRQ pin in "info pci"
References: <20200317195908.283800-1-peterx@redhat.com>
 <87a71wfmv6.fsf@dusky.pond.sub.org> <20200525141443.GB1058657@xz-x1>
Date: Tue, 26 May 2020 10:27:34 +0200
In-Reply-To: <20200525141443.GB1058657@xz-x1> (Peter Xu's message of "Mon, 25
 May 2020 10:14:43 -0400")
Message-ID: <87blmb6qyx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 00:48:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 "Michael S . Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Xu <peterx@redhat.com> writes:

> Hi, Markus,
>
> Thanks for commenting.  Please see below.
>
> On Mon, May 25, 2020 at 10:19:09AM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > Sometimes it would be good to be able to read the pin number along
>> > with the IRQ number allocated.  Since we'll dump the IRQ number, no
>> > reason to not dump the pin information.  For example, the vfio-pci
>> > device will overwrite the pin with the hardware pin number.  It would
>> > be nice to know the pin number of one assigned device from QMP/HMP.
>> >
>> > CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> > CC: Alex Williamson <alex.williamson@redhat.com>
>> > CC: Michael S. Tsirkin <mst@redhat.com>
>> > CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> > CC: Julia Suvorova <jusual@redhat.com>
>> > CC: Markus Armbruster <armbru@redhat.com>
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >
>> > This helped me to debug an IRQ sharing issue, so may good to have it
>> > in master too.
>> > ---
>> [...]
>> > diff --git a/qapi/misc.json b/qapi/misc.json
>> > index c18fe681fb..f8d33ddb4e 100644
>> > --- a/qapi/misc.json
>> > +++ b/qapi/misc.json
>> > @@ -403,6 +403,8 @@
>> >  #
>> >  # @irq: if an IRQ is assigned to the device, the IRQ number
>> >  #
>> > +# @irq_pin: the IRQ pin, zero means no IRQ (since 5.1)
>> > +#
>> 
>> For the IRQ number, we make the member optional, and use "member absent"
>> for "no IRQ assigned".
>> 
>> For the IRQ pin, we make the member mandatory, and use zero value for
>> "no IRQ assigned".
>> 
>> Any particular reason for the difference?
>
> I have two reasons.
>
> Spec-wise, "irq" (PCI_INTERRUPT_LINE) is optional which should depend on
> "irq_pin" (PCI_INTERRUPT_PIN), while "irq_pin" itself is not optional according
> to PCI local bus spec 3.0:
>
>         Interrupt Pin
>
>         The Interrupt Pin register tells which interrupt pin the device (or
>         device function) uses. A value of 1 corresponds to INTA# . A value of 2
>         corresponds to INTB# . A value of 3 corresponds to INTC# . A value of 4
>         corresponds to INTD# . Devices (or device functions) that do not use an
>         interrupt pin must put a 0 in this register. The values 05h through FFh
>         are reserved. This register is read-only. Refer to Section 2.2.6 for
>         further description of the usage of the INTx# pins.
>
> So it should be a value between 0-4, inclusive.  It applies even if the device
> does not support INTx.
>
> Code-wise, we can also make "irq_pin" optional just like "irq" (which will
> automatically create the has_irq_pin variable).  However, then it means we'll
> have two booleans for the same purpose for intx in PciDeviceInfo, which seems
> to be an unnecessary duplication.

I agree encoding "uses an interrupt pin" in multiple seemingly
independent ways is somewhat ugly.  But making @irq_pin mandatory merely
hides it better: if (has_irq_pin) becomes if (irq_pin).  Same redundancy
with if (has_irq).

> So I chose the simple to make it mandatory.

No big deal either way, thus
Acked-by: Markus Armbruster <armbru@redhat.com>

I'm *not* passing judgement on whether exposing the pin register via QMP
makes sense.  That's for the PCI maintainers to decide.


