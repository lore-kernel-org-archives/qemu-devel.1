Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1205C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 21:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89167208A1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 21:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djnHHZd7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89167208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXXL3-0004mG-Nv
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 16:16:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iXXK3-00047a-I0
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 16:15:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iXXK0-0004UC-40
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 16:15:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50431
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iXXJz-0004TX-VN
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 16:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574284530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sCHylDoTOCDh2/74EP4GlrAAibOkWr9Em0viVdsUg2M=;
 b=djnHHZd7pMwwC3F+TA2ceo3kn9dCDrsazSLOpQefNyS+5CpKfj4nkRnGvb8oZk9D+kKOrx
 PsAqB224oE57PaAknKbUe7jCGA/rGLSHg5x8n905HMl8dEqvtaWoLSMlUloUgK+CMGbvDv
 RyYyHflbsNExT7BW+XPcF2InTcRD2Sk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-dA8tHQCBM8eZvzeNEp6rFA-1; Wed, 20 Nov 2019 16:15:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FDFB10509F7
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 21:15:28 +0000 (UTC)
Received: from localhost (ovpn-116-6.gru2.redhat.com [10.97.116.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C0CA85F761;
 Wed, 20 Nov 2019 21:15:27 +0000 (UTC)
Date: Wed, 20 Nov 2019 18:15:26 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] target/i386: add VMX features to named CPU models
Message-ID: <20191120211526.GW3812@habkost.net>
References: <20191120173753.8894-1-pbonzini@redhat.com>
 <20191120184533.GT3812@habkost.net>
 <a86d16e7-c738-9b4b-e29a-518d94f174e0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a86d16e7-c738-9b4b-e29a-518d94f174e0@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: dA8tHQCBM8eZvzeNEp6rFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Jiri Denemark <jdenemar@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 09:49:35PM +0100, Paolo Bonzini wrote:
> On 20/11/19 19:45, Eduardo Habkost wrote:
> > On Wed, Nov 20, 2019 at 06:37:53PM +0100, Paolo Bonzini wrote:
> >> This allows using "-cpu Haswell,+vmx", which we did not really want to
> >> support in QEMU but was produced by Libvirt when using the "host-model=
"
> >> CPU model.
> >=20
> > I understand guest ABI compatibility is not a concern, but I
> > don't remember how we guarantee it won't break by accident if
> > somebody tries to live migrate a VM.
>=20
> I'm not sure I understand the question, but I can answer the second part:
>=20
> > What is supposed to happen today if trying to live migrate a VM
> > using "-cpu Haswell,+vmx"?
>=20
> Before 4.2: same guest ABI compatibility as "-cpu host".

Oh, I forgot that FEAT_KVM_* is recent and is not in QEMU 4.1.
If host-independent guest ABI was never guaranteed before, we're
not making it worse.

For how long was this broken?  Jiri, was libvirt including +vmx
in mode=3Dhost-model for a long time, or is this something recent?


>=20
> 4.2+: ABI compatibility is preserved, because each named CPU model can
> be given a precise set of features that are matched against the host
> (and are subject to check/enforce).

Good.

>=20
> 4.1->4.2: the ABI *should* be preserved if you're running "-cpu
> SandyBridge,+vmx" on an actual Sandy Bridge, but some VMX features will
> disappear after live migration if e.g. you're running "-cpu
> SandyBridge,+vmx" on a Haswell.  Host-model should be fine though.

That was the case I was worried about.

So, host-model should be fine in theory, because the CPU model
chosen by libvirt is supposed to match the host CPU.  Good.

All the other cases already had an unpredictable host-dependent
guest ABI, and can't be fixed.  Bad, but I don't think we can do
anything about it.

So:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>


It would be nice if we at least printed a warning when using +vmx
with pc-*-4.1 and older, so people know their configuration is
likely to be broken.

--=20
Eduardo


