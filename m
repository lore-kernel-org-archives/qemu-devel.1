Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88316C38BE0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A8220838
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6OLAb0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A8220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Jyi-0006t3-F1
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 15:05:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j6Jy1-0006OM-F1
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:04:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j6Jxy-0008Fp-Ty
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:04:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21095
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j6Jxy-0008FR-NN
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582574673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oTdOL5bgllTwtF06tLBhxpDSqKX6/uChcgSwC4KG/BU=;
 b=a6OLAb0zkx0J+sl9jXZ8YSOXZg94RjzjqtQZbYBng0sou+6vHIP9dAYsFrdHAf56UYsOdf
 sttEhr4cz1JETlLIn3i3cLRyLuykmhGnRHWhNtag8cxmfDyGUMZNSXrTw9trnmjk1XjWa6
 Wcd5YrbFuvZTbviNMZlnO+0yuq8RFOQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-Iv3S4MD9OC-EgFEEt2mTXQ-1; Mon, 24 Feb 2020 15:04:31 -0500
X-MC-Unique: Iv3S4MD9OC-EgFEEt2mTXQ-1
Received: by mail-qv1-f72.google.com with SMTP id e10so10098164qvq.18
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 12:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=bATS0uQ6Urz/BSZPzhtCzQU9l1hU+aEjebZ9jUXPKZQ=;
 b=EhD+Hh7G7rzCpEzzfcBGi3ff5fxhFGLkGji0otkeN7/N6Md6+fh4oNP/lq71wm3vcL
 3+h9IA2z8ppebXrUMEwCElslRq60lvd0vrMZOfwmsbJEJDOnKifW6rp1hGkza2HuPwuh
 sBl8WwFk3E3rejq45fSfN0KzQshQ/CKIKllyfKhBYKjkgFFAxk5a5gNFJ5Iby5OiRqAf
 8QP8RRg3jIREBtHnXr9sSL2ItEFFN792NoCVC8shDW6X77xrXdi0BQoArZQ+Vj2h0+FL
 bO9FENDblY4HV+lgN1GY0u1NpTNOy4xPZmUpOets1FcdH3JoO+uQzwA/HYOfV6pcIHgu
 MzRw==
X-Gm-Message-State: APjAAAWC6RS8Y2VhLQuPSRfGki26Ih+uu8lnb7zHI0lJoekju9vIUq/U
 TqqRDBLyL63inBXSnNRUQK33MBCqLD8Zlk6BuDJdliY3Xl5CSCIsLtdFw8dL91wReVmo2R3uX3U
 FCNuxrBx4hSdVHso=
X-Received: by 2002:a37:64d5:: with SMTP id y204mr4791261qkb.443.1582574671447; 
 Mon, 24 Feb 2020 12:04:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqx9zUJiD/edzcEdegd8vWVB9tsEPqhnQeu066NnGL49vqXfCmeTO8j2g2DN17wWpyAXEinLrw==
X-Received: by 2002:a37:64d5:: with SMTP id y204mr4791222qkb.443.1582574671168; 
 Mon, 24 Feb 2020 12:04:31 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id m6sm3054311qki.24.2020.02.24.12.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 12:04:30 -0800 (PST)
Date: Mon, 24 Feb 2020 15:04:28 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 00/13] migrate/ram: Fix resizing RAM blocks while
 migrating
Message-ID: <20200224200428.GM37727@xz-x1>
References: <20200224191856.GK37727@xz-x1>
 <B6F48284-E18C-4FAF-B45D-7E8D142B18AA@redhat.com>
MIME-Version: 1.0
In-Reply-To: <B6F48284-E18C-4FAF-B45D-7E8D142B18AA@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paul Durrant <paul@xen.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Shannon Zhao <shannon.zhao@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 24, 2020 at 08:34:16PM +0100, David Hildenbrand wrote:
>=20
>=20
> > Am 24.02.2020 um 20:19 schrieb Peter Xu <peterx@redhat.com>:
> >=20
> > =EF=BB=BFOn Mon, Feb 24, 2020 at 07:59:10PM +0100, David Hildenbrand wr=
ote:
> >>> On 24.02.20 19:44, David Hildenbrand wrote:
> >>> On 24.02.20 18:45, Peter Xu wrote:
> >>>> On Mon, Feb 24, 2020 at 10:09:19AM +0100, David Hildenbrand wrote:
> >>>>> On 21.02.20 19:04, Peter Xu wrote:
> >>>>>> On Fri, Feb 21, 2020 at 05:41:51PM +0100, David Hildenbrand wrote:
> >>>>>>> I was now able to actually test resizing while migrating. I am us=
ing the
> >>>>>>> prototype of virtio-mem to test (which also makes use of resizabl=
e
> >>>>>>> allocations). Things I was able to reproduce:
> >>>>>>=20
> >>>>>> The test cases cover quite a lot.  Thanks for doing that.
> >>>>>>=20
> >>>>>>> - Resize while still running on the migration source. Migration i=
s canceled
> >>>>>>> -- Test case for "migraton/ram: Handle RAM block resizes during p=
recopy"
> >>>>>>=20
> >>>>>>> - Resize (grow+shrink) on the migration target during postcopy mi=
gration

[2]

> >>>>>>>  (when syncing RAM blocks), while not yet running on the target
> >>>>>>> -- Test case for "migration/ram: Discard new RAM when growing RAM=
 blocks
> >>>>>>>   and the VM is stopped", and overall RAM size synchronization. S=
eems to
> >>>>>>>   work just fine.
> >>>>>>=20
> >>>>>> This won't be able to trigger without virtio-mem, right?
> >>>>>=20
> >>>>> AFAIK all cases can also be triggered without virtio-mem (not just =
that
> >>>>> easily :) ). This case would be "RAM block is bigger on source than=
 on
> >>>>> destination.".
> >>>>>=20
> >>>>>>=20
> >>>>>> And I'm also curious on how to test this even with virtio-mem.  Is
> >>>>>> that a QMP command to extend/shrink virtio-mem?
> >>>>>=20
> >>>>> Currently, there is a single qom property that can be modifed via
> >>>>> QMP/HMP - "requested-size". With resizable resizable memory backend=
s,
> >>>>> increasing the requested size will also implicitly grow the RAM blo=
ck.
> >>>>> Shrinking the requested size will currently result in shrinking the=
 RAM
> >>>>> block on the next reboot.
> >>>>>=20
> >>>>> So, to trigger growing of a RAM block (assuming requested-size was
> >>>>> smaller before, e.g., 1000M)
> >>>>>=20
> >>>>> echo "qom-set vm1 requested-size 6000M" | sudo nc -U $MON
> >>>>>=20
> >>>>> To trigger shrinking (assuming requested-size was bigger before)
> >>>>>=20
> >>>>> echo "qom-set vm1 requested-size 100M" | sudo nc -U $MON
> >>>>> echo 'system_reset' | sudo nc -U $MON
> >>>>>=20
> >>>>>=20
> >>>>> Placing these at the right spots during a migration allows to test =
this
> >>>>> very reliably.
> >>>>=20
> >>>> I see, thanks for the context.  The question was majorly about when
> >>>> you say "during postcopy migration (when syncing RAM blocks), while
> >>>> not yet running on the target" - it's not easy to do so imho, becaus=
e:
> >>>=20
> >>> This case is very easy to trigger, even with acpi. Simply have a ram
> >>> block on the source be bigger than one on the target. The sync code
> >>> (migration/ram.c:qemu_ram_resize()) will perform the resize during

[1]

> >>> precopy. Postcopy misses to discard the additional memory.
> >=20
> > But when resizing happens during precopy, we should cancel this
> > migration directly?  Hmm?...
>=20
> ?
>=20
> We are talking about the migration target, not the source. Please have a =
look at the RAM block size sync code I mentioned. That=E2=80=98s probably f=
aster than me having to explain it (and obviously failing to do so :) ).

OK finally I noticed you meant migration/ram.c:ram_load_precopy() [1]
not qemu_ram_resize().  And at [2] I think you meant during precopy
migration, not postcopy.  Those are probably the things that made me
confused.  And yes we need to consider this case.  Thanks,

--=20
Peter Xu


