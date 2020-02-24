Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F31AC38BE0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 359DC21556
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuC0P6Du"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359DC21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6KlY-0005Aj-B3
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 15:55:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j6Kkj-0004FT-F8
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j6Kkh-0001u6-V7
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:54:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37958
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j6Kkh-0001tR-NH
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582577694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6K1JtV4gFatNx6fclJhan2IxP0U1IT1OUFL1keLDKw0=;
 b=EuC0P6Du2nSgVm0BrxW87OF+0ghE+FwBVBqhm5Kd4u11kjJ/zf+v6fECmrFHU1zPVt0+r+
 UuUt+LDNqw4eudy14rQHKb8hFtzRu8iGtOttOhyRJzX75DXuNIbGKewP/BEQ13fS+ZuZjh
 O13HkhKk3pc/QF14yLUtd2NfqAP3oZ4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-XpoKj48JN5uaAv3tW0Bp-Q-1; Mon, 24 Feb 2020 15:54:52 -0500
X-MC-Unique: XpoKj48JN5uaAv3tW0Bp-Q-1
Received: by mail-wm1-f72.google.com with SMTP id t17so239163wmi.7
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 12:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=RUbfglZGBDQ5VYlapAdq0sdboJ7KkM4XZ+LALa9Op2Q=;
 b=feDW7IOHLALR7yLp34RbxJ920qmxGTmKoebwdjIcPwOr01nUhgzsQ2QTbPqJiDgc6j
 nPw44AzYn0er1PrZRHRRy1pkCqlI/Pr8ohaFJoLzpIeufMrQMZZne5SC4Ev5aDKlf77G
 zUVwRDwRGpY0zRnUxs2nJOcXNj9vdyqQJjVD4fP59rrXF71TD1qobActwAyGNCPiHIMi
 Vfnf1xrvUA5JBjaNnY3CwvFQIIuQyarHpNqsSv/zQ2g5kd7Tambl8EosPgrNn1T65Sre
 POIo5BsA18IbZ5g4h9yzEaI49NueOdBQkwNZ0V9TxYmYfZwyxkfTiHzu0BFJ5jIqrzly
 Demw==
X-Gm-Message-State: APjAAAUNaoZtSkgy3DMVEVaWGImrnWN6Ep9ESL5CzTpE6LFx1gBkHRHB
 5c07MhOVpc23qWH4y4IZQzPzHCQquzW2rBiaJ9klu2QvM/XvR1ZziiflUviC7uTQHcUBxwMZtU3
 XmAQNofs1sMk9RLs=
X-Received: by 2002:adf:db84:: with SMTP id u4mr69615028wri.317.1582577691705; 
 Mon, 24 Feb 2020 12:54:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqwJCttnSpxBeic0hXYOK6IABuTTOahjg3WPr6TXrvvyYSw4uYJ4va1xzkJjQe9PqB6WLFbZtA==
X-Received: by 2002:adf:db84:: with SMTP id u4mr69615002wri.317.1582577691465; 
 Mon, 24 Feb 2020 12:54:51 -0800 (PST)
Received: from [192.168.3.122] (p5B0C6CE1.dip0.t-ipconnect.de. [91.12.108.225])
 by smtp.gmail.com with ESMTPSA id e22sm822263wme.45.2020.02.24.12.54.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 12:54:50 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 00/13] migrate/ram: Fix resizing RAM blocks while
 migrating
Date: Mon, 24 Feb 2020 21:54:50 +0100
Message-Id: <57BD35A8-67F2-4218-A05C-ACDFB752E6E3@redhat.com>
References: <20200224200428.GM37727@xz-x1>
In-Reply-To: <20200224200428.GM37727@xz-x1>
To: Peter Xu <peterx@redhat.com>
X-Mailer: iPhone Mail (17D50)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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



> Am 24.02.2020 um 21:04 schrieb Peter Xu <peterx@redhat.com>:
>=20
> =EF=BB=BFOn Mon, Feb 24, 2020 at 08:34:16PM +0100, David Hildenbrand wrot=
e:
>>=20
>>=20
>>>> Am 24.02.2020 um 20:19 schrieb Peter Xu <peterx@redhat.com>:
>>>=20
>>> =EF=BB=BFOn Mon, Feb 24, 2020 at 07:59:10PM +0100, David Hildenbrand wr=
ote:
>>>>> On 24.02.20 19:44, David Hildenbrand wrote:
>>>>> On 24.02.20 18:45, Peter Xu wrote:
>>>>>> On Mon, Feb 24, 2020 at 10:09:19AM +0100, David Hildenbrand wrote:
>>>>>>> On 21.02.20 19:04, Peter Xu wrote:
>>>>>>>> On Fri, Feb 21, 2020 at 05:41:51PM +0100, David Hildenbrand wrote:
>>>>>>>>> I was now able to actually test resizing while migrating. I am us=
ing the
>>>>>>>>> prototype of virtio-mem to test (which also makes use of resizabl=
e
>>>>>>>>> allocations). Things I was able to reproduce:
>>>>>>>>=20
>>>>>>>> The test cases cover quite a lot.  Thanks for doing that.
>>>>>>>>=20
>>>>>>>>> - Resize while still running on the migration source. Migration i=
s canceled
>>>>>>>>> -- Test case for "migraton/ram: Handle RAM block resizes during p=
recopy"
>>>>>>>>=20
>>>>>>>>> - Resize (grow+shrink) on the migration target during postcopy mi=
gration
>=20
> [2]
>=20
>>>>>>>>> (when syncing RAM blocks), while not yet running on the target
>>>>>>>>> -- Test case for "migration/ram: Discard new RAM when growing RAM=
 blocks
>>>>>>>>>  and the VM is stopped", and overall RAM size synchronization. Se=
ems to
>>>>>>>>>  work just fine.
>>>>>>>>=20
>>>>>>>> This won't be able to trigger without virtio-mem, right?
>>>>>>>=20
>>>>>>> AFAIK all cases can also be triggered without virtio-mem (not just =
that
>>>>>>> easily :) ). This case would be "RAM block is bigger on source than=
 on
>>>>>>> destination.".
>>>>>>>=20
>>>>>>>>=20
>>>>>>>> And I'm also curious on how to test this even with virtio-mem.  Is
>>>>>>>> that a QMP command to extend/shrink virtio-mem?
>>>>>>>=20
>>>>>>> Currently, there is a single qom property that can be modifed via
>>>>>>> QMP/HMP - "requested-size". With resizable resizable memory backend=
s,
>>>>>>> increasing the requested size will also implicitly grow the RAM blo=
ck.
>>>>>>> Shrinking the requested size will currently result in shrinking the=
 RAM
>>>>>>> block on the next reboot.
>>>>>>>=20
>>>>>>> So, to trigger growing of a RAM block (assuming requested-size was
>>>>>>> smaller before, e.g., 1000M)
>>>>>>>=20
>>>>>>> echo "qom-set vm1 requested-size 6000M" | sudo nc -U $MON
>>>>>>>=20
>>>>>>> To trigger shrinking (assuming requested-size was bigger before)
>>>>>>>=20
>>>>>>> echo "qom-set vm1 requested-size 100M" | sudo nc -U $MON
>>>>>>> echo 'system_reset' | sudo nc -U $MON
>>>>>>>=20
>>>>>>>=20
>>>>>>> Placing these at the right spots during a migration allows to test =
this
>>>>>>> very reliably.
>>>>>>=20
>>>>>> I see, thanks for the context.  The question was majorly about when
>>>>>> you say "during postcopy migration (when syncing RAM blocks), while
>>>>>> not yet running on the target" - it's not easy to do so imho, becaus=
e:
>>>>>=20
>>>>> This case is very easy to trigger, even with acpi. Simply have a ram
>>>>> block on the source be bigger than one on the target. The sync code
>>>>> (migration/ram.c:qemu_ram_resize()) will perform the resize during
>=20
> [1]
>=20
>>>>> precopy. Postcopy misses to discard the additional memory.
>>>=20
>>> But when resizing happens during precopy, we should cancel this
>>> migration directly?  Hmm?...
>>=20
>> ?
>>=20
>> We are talking about the migration target, not the source. Please have a=
 look at the RAM block size sync code I mentioned. That=E2=80=98s probably =
faster than me having to explain it (and obviously failing to do so :) ).
>=20
> OK finally I noticed you meant migration/ram.c:ram_load_precopy() [1]
> not qemu_ram_resize().

Right, the single invocation of qemu_ram_resize() in that file/function.

> And at [2] I think you meant during precopy
> migration, not postcopy.

The precopy stage when postcopy was advised. Yes, it=E2=80=98s confusing :)

> Those are probably the things that made me
> confused.  And yes we need to consider this case.  Thanks,

Thanks for having a look!

>=20
> --=20
> Peter Xu
>=20


