Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94B1C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A09BE2087E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9NyaUV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09BE2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTmke-0004Lr-PN
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 09:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jTmjt-0003tp-AD
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:27:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jTmjJ-0005T4-Vm
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:27:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47211
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jTmjJ-0005DP-Eh
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588166783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rlzG3nw1xjRFpaj3z9ilKoW5qYC50883EMouLQRjr5s=;
 b=J9NyaUV+Ofb5KHKXYkZaOpaSgluNbrt2mgJA9b8KkwlsREOEWKTiYWSbtGmFlbTaGt8YCg
 kutM/YS00Aueothm95j9jQgJ75Ba7pT2g+JgB3kL7i0zt8qfc6ZIxi1F3RyKpUl+fi4uP0
 QQIrHColJ3aLaemMvaI5J47zVoO0zY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-V1UZGjMoPEORCPc4r1jgJw-1; Wed, 29 Apr 2020 09:26:20 -0400
X-MC-Unique: V1UZGjMoPEORCPc4r1jgJw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDAA88AB388;
 Wed, 29 Apr 2020 13:26:19 +0000 (UTC)
Received: from work-vm (ovpn-114-192.ams2.redhat.com [10.36.114.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A0FE5D70B;
 Wed, 29 Apr 2020 13:26:10 +0000 (UTC)
Date: Wed, 29 Apr 2020 14:26:07 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH RFC 0/4] vl: Sync dirty bitmap when system resets
Message-ID: <20200429132607.GJ2834@work-vm>
References: <20200428194219.10963-1-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200428194219.10963-1-peterx@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tian Kevin <kevin.tian@intel.com>,
 qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (peterx@redhat.com) wrote:
> This RFC series starts from the fact that we will sync dirty bitmap when
> removing a memslot for KVM.  IIUC that was majorly to maintain the dirty =
bitmap
> even across a system reboot.
>=20
> This series wants to move that sync from kvm memslot removal to system re=
set.
>=20
> (I still don't know why the reset system will still need to keep the RAM =
status
>  before the reset.  I thought things like kdump might use this to retriev=
e info
>  from previous kernel panic, however IIUC that's not what kdump is doing =
now.
>  Anyway, I'd be more than glad if anyone knows the real scenario behind
>  this...)

Aren't there pages written by the BIOS that are read by the system as it
comes up through reset - so you need those pages intact?
(But I don't think that slot gets removed? Or does it - the bios has
some weird aliasing)

> The current solution (sync at kvm memslot removal) works in most cases, b=
ut:
>=20
>   - it will be merely impossible to work for dirty ring, and,

Why doesn't that work with dirty ring?

>   - it has an existing flaw on race condition. [1]
>=20
> So if system reset is the only thing we care here, I'm thinking whether w=
e can
> move this sync explicitly to system reset so we do a global sync there in=
stead
> of sync every time when memory layout changed and caused memory removals.=
  I
> think it can be more explict to sync during system reset, and also with t=
hat
> context it will be far easier for kvm dirty ring to provide the same logi=
c.
>=20
> This is totally RFC because I'm still trying to find whether there will b=
e
> other cases besides system reset that we want to keep the dirty bits for =
a
> to-be-removed memslot (real memory removals like unplugging memory should=
n't
> matter, because we won't care about the dirty bits if it's never going to=
 be
> there anymore, not to mention we won't allow such things during a migrati=
on).
> So far I don't see any.

I'm still unusure when slot removal happens for real; but if it's
happening for RAM on PCI devices, then that would make sense as
something you might want to keep.

Dave

> I've run some tests either using the old dirty log or dirty ring, with ei=
ther
> some memory load or reboots on the source, and I see no issues so far.
>=20
> Comments greatly welcomed.  Thanks.
>=20
> [1] https://lore.kernel.org/qemu-devel/20200327150425.GJ422390@xz-x1/
>=20
> Peter Xu (4):
>   migration: Export migration_bitmap_sync_precopy()
>   migration: Introduce migrate_is_precopy()
>   vl: Sync dirty bits for system resets during precopy
>   kvm: No need to sync dirty bitmap before memslot removal any more
>=20
>  accel/kvm/kvm-all.c      |  3 ---
>  include/migration/misc.h |  2 ++
>  migration/migration.c    |  7 +++++++
>  migration/ram.c          | 10 +++++-----
>  softmmu/vl.c             | 16 ++++++++++++++++
>  5 files changed, 30 insertions(+), 8 deletions(-)
>=20
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


