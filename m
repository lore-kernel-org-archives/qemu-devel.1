Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5F1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 17:18:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA9AB2075D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 17:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyZW9F/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9AB2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0pik-0006zX-2u
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 13:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k0pi2-0006Ws-RD
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 13:17:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48137
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k0pi0-00031R-OU
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 13:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596043059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yvY4v1UXxFxH4msWGqeU5QfEkZLsOOVM0r6pGE3/5cU=;
 b=YyZW9F/dKSepo5PcX3sOvndju0MdzvfuoFz3iw6040VFR8og5HEyO1UjHqbj8d82S6Vx8J
 JwL+qvpN8C+d8ynXdXrB2fYuEpEZObTMGI7bTx/pfsNZ2bB2HhV58IU8RNPBBv63P4NUyT
 o3iOpDUZ3eCAzQnQICwSP5Fa6XYbvPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-foL5Kip8P3qKC3OOtl-KTA-1; Wed, 29 Jul 2020 13:17:35 -0400
X-MC-Unique: foL5Kip8P3qKC3OOtl-KTA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F061E1005510;
 Wed, 29 Jul 2020 17:17:33 +0000 (UTC)
Received: from gondolin (ovpn-113-17.ams2.redhat.com [10.36.113.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CDFE712FF;
 Wed, 29 Jul 2020 17:17:31 +0000 (UTC)
Date: Wed, 29 Jul 2020 19:17:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Viktor Mihajlovski <mihajlov@linux.ibm.com>
Subject: Re: [PATCH for-5.2 0/6] Continue booting in case the first device
 is not bootable
Message-ID: <20200729191729.0e40d4a6.cohuck@redhat.com>
In-Reply-To: <5c860673-9c0c-79fe-2804-4864856257f5@linux.ibm.com>
References: <20200728183734.7838-1-thuth@redhat.com>
 <5c860673-9c0c-79fe-2804-4864856257f5@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 13:17:39
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[restored cc:s]

On Wed, 29 Jul 2020 13:42:05 +0200
Viktor Mihajlovski <mihajlov@linux.ibm.com> wrote:

> On 7/28/20 8:37 PM, Thomas Huth wrote:
> > If the user did not specify a "bootindex" property, the s390-ccw bios
> > tries to find a bootable device on its own. Unfortunately, it alwasy
> > stops at the very first device that it can find, no matter whether it's
> > bootable or not. That causes some weird behavior, for example while
> > 
> >   qemu-system-s390x -hda bootable.qcow2
> > 
> > boots perfectly fine, the bios refuses to work if you just specify
> > a virtio-scsi controller in front of it:
> > 
> >   qemu-system-s390x -device virtio-scsi -hda bootable.qcow2
> > 
> > Since this is quite uncomfortable and confusing for the users, and
> > all major firmwares on other architectures correctly boot in such
> > cases, too, let's also try to teach the s390-ccw bios how to boot
> > in such cases.
> > 
> > For this, we have to get rid of the various panic()s and IPL_assert()
> > statements at the "low-level" function and let the main code handle
> > the decision instead whether a boot from a device should fail or not,
> > so that the main code can continue searching in case it wants to.
> >   
> 
> Looking at it from an architectural perspective: If an IPL Information 
> Block specifying the boot device has been set and can be retrieved using 
> Diagnose 308 it has to be respected, even if the device doesn't contain 
> a bootable program. The boot has to fail in this case.
> 
> I had not the bandwidth to follow all code paths, but I gather that this 
> is still the case with the series. So one can argue that these changes 
> are taking care of an undefined situation (real hardware will always 
> have the IPIB set).
> 
> As long as the architecture is not violated, I can live with the 
> proposed changes. I however would like to point out that this only 
> covers a corner case (no -boot or -device ..,bootindex specified). A VM 
> defined and started with libvirt will always specify the boot device. 
> Please don't create the impression that this patches will lead to the 
> same behavior as on other platforms. It is still not possible to have an 
> order list of potential boot devices in an architecture compliant way.

Yes, libvirt will always add this parameter. Still, I've seen confusion
generated by this behaviour, so this change sounds like a good idea to
me.

(Is there any possibility to enhance the architecture to provide a list
of devices in the future?)


