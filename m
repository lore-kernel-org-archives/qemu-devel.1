Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D99C38BE0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 19:35:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E75520836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 19:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfFSbr6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E75520836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6JVY-0004u1-Ht
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 14:35:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j6JUm-0004D7-Af
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 14:34:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j6JUk-0007dX-Kg
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 14:34:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21200
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j6JUk-0007ct-DC
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 14:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582572861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jb0c2F+YSikYIsMBUY30S9egOU3zx5kv3u542ujLNmc=;
 b=QfFSbr6QuDEkHwAxHvm9cNo9iIoE2AS1wZhn3P/olOYhIQY4IhI4qpt1eam0fCk+KIMIYH
 KpnIe3wxkka+xZpDVOTKoRr8bBvZXLQ8ccS5FPgMShQAMrpcN9qxGrI9a/eW3OBZ/wYAUE
 top+00EtV/R9rnKChvHcgP/3DXErmw4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-ZvO6vnqNPumzEd9A4jAPzg-1; Mon, 24 Feb 2020 14:34:19 -0500
X-MC-Unique: ZvO6vnqNPumzEd9A4jAPzg-1
Received: by mail-wm1-f70.google.com with SMTP id u11so171478wmb.4
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 11:34:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=vQMv5+37+7m/6PEUe9PB+C3Xdm5icRYZqfPv0GWSAPA=;
 b=TuMReh8N8aQtgnY6B9MpeP+gtBf2IrBgVaPFTixD2lTafSds3Bv6UP4neOsD2Ff6JR
 C3aF9mSuFm2qdoz3i/+labiFj9wPDBFdwuq3XbQYJI9XwJU5HaQZ3/lSPCWcViLBFtH5
 lpV45W4gxne8DJkNnxcTTC/QVnbPxbowCu8+ica1V8Z37G2y/j7p3ipL/EcQHNsjYAOD
 PO+2jDrPvBbXBSgEZTU1wyP8dyvV9Agw/Uv9hZ7xH6eewIrmN331fdySdBp/lM2eYC59
 I/8Fj6XG+tE1ckycMzTHNelclhkqZjpHFprsqFlWyTwpwiw9h2vjDRiGu2jjb5/l3cm7
 Y6TQ==
X-Gm-Message-State: APjAAAVd31Y08HBzxL8rdjgRsFHrsQ0J+7lMSQU9T70IGniFtTkX7iXr
 RoJvwLK6O+pI6DqxtI3mPG+Qv24nNbiCnp55c/htO2sMyRuYekeUDrWpg0QS1XB4z7GMDMo2anb
 9CoFDo2vWuHBZGwk=
X-Received: by 2002:adf:e683:: with SMTP id r3mr72144980wrm.38.1582572858668; 
 Mon, 24 Feb 2020 11:34:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5yKKvTl/2ciGjLuk73hTr9Cz5N2bQs7vL4oXQT0rAq9IDVHCDskdwyeYF4XElAjl/1ljYSA==
X-Received: by 2002:adf:e683:: with SMTP id r3mr72144936wrm.38.1582572858324; 
 Mon, 24 Feb 2020 11:34:18 -0800 (PST)
Received: from [192.168.3.122] (p5B0C6CE1.dip0.t-ipconnect.de. [91.12.108.225])
 by smtp.gmail.com with ESMTPSA id f11sm590990wml.3.2020.02.24.11.34.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 11:34:17 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 00/13] migrate/ram: Fix resizing RAM blocks while
 migrating
Date: Mon, 24 Feb 2020 20:34:16 +0100
Message-Id: <B6F48284-E18C-4FAF-B45D-7E8D142B18AA@redhat.com>
References: <20200224191856.GK37727@xz-x1>
In-Reply-To: <20200224191856.GK37727@xz-x1>
To: Peter Xu <peterx@redhat.com>
X-Mailer: iPhone Mail (17D50)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paul Durrant <paul@xen.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhao@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Am 24.02.2020 um 20:19 schrieb Peter Xu <peterx@redhat.com>:
>=20
> =EF=BB=BFOn Mon, Feb 24, 2020 at 07:59:10PM +0100, David Hildenbrand wrot=
e:
>>> On 24.02.20 19:44, David Hildenbrand wrote:
>>> On 24.02.20 18:45, Peter Xu wrote:
>>>> On Mon, Feb 24, 2020 at 10:09:19AM +0100, David Hildenbrand wrote:
>>>>> On 21.02.20 19:04, Peter Xu wrote:
>>>>>> On Fri, Feb 21, 2020 at 05:41:51PM +0100, David Hildenbrand wrote:
>>>>>>> I was now able to actually test resizing while migrating. I am usin=
g the
>>>>>>> prototype of virtio-mem to test (which also makes use of resizable
>>>>>>> allocations). Things I was able to reproduce:
>>>>>>=20
>>>>>> The test cases cover quite a lot.  Thanks for doing that.
>>>>>>=20
>>>>>>> - Resize while still running on the migration source. Migration is =
canceled
>>>>>>> -- Test case for "migraton/ram: Handle RAM block resizes during pre=
copy"
>>>>>>=20
>>>>>>> - Resize (grow+shrink) on the migration target during postcopy migr=
ation
>>>>>>>  (when syncing RAM blocks), while not yet running on the target
>>>>>>> -- Test case for "migration/ram: Discard new RAM when growing RAM b=
locks
>>>>>>>   and the VM is stopped", and overall RAM size synchronization. See=
ms to
>>>>>>>   work just fine.
>>>>>>=20
>>>>>> This won't be able to trigger without virtio-mem, right?
>>>>>=20
>>>>> AFAIK all cases can also be triggered without virtio-mem (not just th=
at
>>>>> easily :) ). This case would be "RAM block is bigger on source than o=
n
>>>>> destination.".
>>>>>=20
>>>>>>=20
>>>>>> And I'm also curious on how to test this even with virtio-mem.  Is
>>>>>> that a QMP command to extend/shrink virtio-mem?
>>>>>=20
>>>>> Currently, there is a single qom property that can be modifed via
>>>>> QMP/HMP - "requested-size". With resizable resizable memory backends,
>>>>> increasing the requested size will also implicitly grow the RAM block=
.
>>>>> Shrinking the requested size will currently result in shrinking the R=
AM
>>>>> block on the next reboot.
>>>>>=20
>>>>> So, to trigger growing of a RAM block (assuming requested-size was
>>>>> smaller before, e.g., 1000M)
>>>>>=20
>>>>> echo "qom-set vm1 requested-size 6000M" | sudo nc -U $MON
>>>>>=20
>>>>> To trigger shrinking (assuming requested-size was bigger before)
>>>>>=20
>>>>> echo "qom-set vm1 requested-size 100M" | sudo nc -U $MON
>>>>> echo 'system_reset' | sudo nc -U $MON
>>>>>=20
>>>>>=20
>>>>> Placing these at the right spots during a migration allows to test th=
is
>>>>> very reliably.
>>>>=20
>>>> I see, thanks for the context.  The question was majorly about when
>>>> you say "during postcopy migration (when syncing RAM blocks), while
>>>> not yet running on the target" - it's not easy to do so imho, because:
>>>=20
>>> This case is very easy to trigger, even with acpi. Simply have a ram
>>> block on the source be bigger than one on the target. The sync code
>>> (migration/ram.c:qemu_ram_resize()) will perform the resize during
>>> precopy. Postcopy misses to discard the additional memory.
>=20
> But when resizing happens during precopy, we should cancel this
> migration directly?  Hmm?...

?

We are talking about the migration target, not the source. Please have a lo=
ok at the RAM block size sync code I mentioned. That=E2=80=98s probably fas=
ter than me having to explain it (and obviously failing to do so :) ).


