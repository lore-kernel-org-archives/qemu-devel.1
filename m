Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BE0CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B5821929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCXPGrTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B5821929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0xg-0004wI-SH
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iO0W4-0000jw-4D
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iO0W1-00031C-Lf
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:24:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54251
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iO0W1-0002uP-HN
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572013461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MFIL97jbsxIfKajN/TNpA8K5qOxgSVTUwVo0AcDbKIQ=;
 b=eCXPGrTyy+/GUgiVrvsx/4Z//3BualOv/Zy83KolNZvXFBYUoLO3F55NfbBPIwlFgne/jY
 SAhsnyf3JJb4vjDLfXMp8zqMQ2h4pgIyOQwDcHBbP/weMfVyie2JkmtEN3b4eQiCKj3pHB
 v3c9wfuR235zGetg58A2w76MkJ+9uXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-SdugoeULPCmJcyfJudgaXg-1; Fri, 25 Oct 2019 10:24:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 590A81005509;
 Fri, 25 Oct 2019 14:24:05 +0000 (UTC)
Received: from [10.36.116.227] (ovpn-116-227.ams2.redhat.com [10.36.116.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B454C194B6;
 Fri, 25 Oct 2019 14:24:00 +0000 (UTC)
Subject: Re: [PATCH 0/7] i386: Add `machine` parameter to query-cpu-definitions
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191025022553.25298-1-ehabkost@redhat.com>
 <dbf9e4c1-0acf-9469-84f9-f80c41e2cae0@redhat.com>
 <6e7d171e-18c4-6835-f89c-e9e66c093d62@de.ibm.com>
 <4cd530f9-54f3-80e7-1b66-c91f71160062@redhat.com>
 <20191025140310.GB3581@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <7a29438c-572d-5a26-a14f-717a177af4d1@redhat.com>
Date: Fri, 25 Oct 2019 16:23:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025140310.GB3581@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: SdugoeULPCmJcyfJudgaXg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>>> For example
>>> -machine s390-virtio-ccw-3.1 -cpu z14 will not have the multiple epoch =
facility
>>> and
>>> -machine s390-virtio-ccw-4.0 -cpu z14 will have the multiple epoch faci=
lity.
>>> As migration does always require the tuple of machine and cpu this is s=
ave. I fail
>>> to see what the benefit of an explicit z14-3.1 would be.
>>>
>>
>> AFAIKS the only real benefit of versioned CPU models is that you can add=
 new
>> CPU model versions without new QEMU version.
>=20
> This is very important for backporting CPU security fixes to existing QEM=
U
> releases.

I'd say it's not really relevant for backporting per se. It's relevant=20
for automatically enabling security fixes when not using the host model.=20
That part I understand. Less likely to make mistakes when explicitly=20
specifying CPU models.

I once was told that if a user actually specified an explicit CPU model=20
in the libvirt XML ("haswell-whatever"), you should not go ahead and=20
make any later changes to that model (guest ABI should not change when=20
you update/restart the guest ...). So this only applies when creating=20
new guests? Or will you change existing model definitions implicitly?

>=20
>>
>> Then you can specify "-cpu z13-vX" or "-cpu z13 -cpuv X" (no idea how
>> versioned CPU model were implemented) on any QEMU machine. Which is the =
same
>> as telling your customer "please use z13,featX=3Don" in case you have a =
good
>> reason to not use the host model (along with baselining) but use an expl=
icit
>> model.
>>
>> If you can change the default model of QEMU machines, you can automate t=
his
>> process. I am pretty sure this is a corner case, though (e.g., IBRS).
>> Usually you have a new QEMU machine and can simply enable the new featur=
e
>> from that point on.
>=20
> There are now 4 Haswell variants, only some of which are runnable
> on any given host, depending on what microcode the user has installed
> or what particular Haswell silicon SKU the user purchased. Given the
> frequency of new CPU flaws arrived since the first Meltdown/Spectre,
> this isn't a corner case, at least for the x86 world & Intel in
> particular. Other arches/vendors haven't been quite so badly affected
> in this way.

On s390x you can assume that such firmware/microcode updates will be on=20
any machine after some time. That is a big difference to x86-64 AFAIK.

>=20
> If we tied each new Haswell variant to a machine type, then users would
> be blocked from consuming a new machine type depending on runnability of
> the CPU model. This is not at all desirable, as mgmt apps now have comple=
x
> rules on what machine type they can use.

So you actually want different CPU variants, which you have already,=20
just in a different form. (e.g., "haswell" will be mapped to=20
"haswell-whatever", just differently via versions)

>=20
> When dealing with backporting patches for new CPU hardware flaws, the
> new CPU features are backported to many old QEMU versions. The new
> machine types are not backportable.

That part I understand.

>=20
> Both these called for making CPU versioning independant of machine
> type versioning.
>=20
> Essentially the goal with CPU versioning is that the user can request
> a bare "Haswell" and libvirt (or the mgmt app) will automatically
> expand this to the best Haswell version that the host is able to
> support with its CPUs / microcode / BIOS config combination.


So if I do a "-cpu haswell -M whatever-machine", as far as I understood=20
reading this,  I get the "default CPU model alias for that QEMU machine"=20
and *not* the "best Haswell version that the host is able to support".

Or does the default actually also depend on the current host?

--=20

Thanks,

David / dhildenb


