Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750AEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79900207EA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVKO2+kn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79900207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYtHj-0006Zf-Ck
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 11:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jYtGx-0005Pr-8j
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:26:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25711
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jYtGv-0000rk-BT
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589383570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/mxlJAfRQaF0/P+l5GO3Ba+10rHV0bDJNpWLKlYyi4E=;
 b=CVKO2+kntqXFT72rq5t5rX5X9Y2egth/O+vCXewVzwXvTSj05PaMTyx1N+GqLwjeKPF9xi
 QI27X0DRcF+nrzHSgLfV5DpL2MBBikoc40cmXKdMjkZKg2Cjj3VVT6QNqOBw9ld4f7RPxs
 gH0q642LfkKxaJEITjnO2yqrrsgAmxA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-bvxPqg_4Mkiso2Cdud2vrg-1; Wed, 13 May 2020 11:26:07 -0400
X-MC-Unique: bvxPqg_4Mkiso2Cdud2vrg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A8F41005510;
 Wed, 13 May 2020 15:26:05 +0000 (UTC)
Received: from localhost (unknown [10.40.208.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EDB961541;
 Wed, 13 May 2020 15:25:49 +0000 (UTC)
Date: Wed, 13 May 2020 17:25:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RESEND v6 01/36] memory: alloc RAM from file at offset
Message-ID: <20200513172547.48d87447@redhat.com>
In-Reply-To: <20200513084042.GA317907@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <cb792b8d6f93d00c10790de8698c468b6ff4ab69.1587614626.git.elena.ufimtseva@oracle.com>
 <20200512084855.GC1191162@redhat.com>
 <B4DB4B9E-E7E3-4F1F-917C-898F9B150EFB@oracle.com>
 <20200513084042.GA317907@stefanha-x1.localdomain>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:17:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 swapnil.ingle@nutanix.com, john.g.johnson@oracle.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, Jag Raman <jag.raman@oracle.com>, quintela@redhat.com,
 mst@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 Daniel Berrange <berrange@redhat.com>, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 13 May 2020 09:40:42 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Tue, May 12, 2020 at 07:56:33AM -0400, Jag Raman wrote:
> >=20
> >  =20
> > > On May 12, 2020, at 4:48 AM, Daniel P. Berrang=C3=A9 <berrange@redhat=
.com> wrote:
> > >=20
> > > On Wed, Apr 22, 2020 at 09:13:36PM -0700, elena.ufimtseva@oracle.com =
wrote: =20
> > >> From: Jagannathan Raman <jag.raman@oracle.com>
> > >>=20
> > >> Allow RAM MemoryRegion to be created from an offset in a file, inste=
ad
> > >> of allocating at offset of 0 by default. This is needed to synchroni=
ze
> > >> RAM between QEMU & remote process. =20
> > >=20
> > > Can you elaborate on why remote processes require the RAM to be offse=
t
> > > from zero ? =20
> >=20
> > Hi Daniel,
> >=20
> > As it turns out, the RAM is scattered across the physical address space
> > (system_memory) of QEMU. Therefore, the system memory is composed
> > of multiple sections of RAM, and some sections start at a non-zero RAM
> > offset.
> >=20
> > As a result, the remote process needs the ability to map these RAM
> > sections into system_memory. =20
>=20
> To explain a bit more, my understanding is that the offset is
> specifically for mmap(2). As Jag alluded to, multiple sections can use a
> single backing RAM file. These sections have different offsets in the
> file.
>=20
> Jag, maybe you can include a concrete explanation like the following in
> the commit description:
>=20
> Launch QEMU like this:
>=20
>   qemu-system-x86_64 -mem-path /dev/shm -m 8G
>=20
> There is only one RAM file descriptor:
>=20
>   $ cat /proc/$(pidof qemu)/fd
>   ...
>   lrwx------. 1 stefanha stefanha 64 May 13 09:34 19 -> '/dev/shm/qemu_ba=
ck_mem.pc.ram.7YAlqn (deleted)'
>=20
> But the memory tree shows that single file is split into multiple ranges
> of guest physical address space:
>=20
>   (qemu) info mtree
>   memory-region: system
>   0000000000000000-ffffffffffffffff (prio 0, i/o): system
>     0000000000000000-00000000bfffffff (prio 0, i/o): alias ram-below-4g @=
pc.ram 0000000000000000-00000000bfffffff
>     ...
>     0000000100000000-000000023fffffff (prio 0, i/o): alias ram-above-4g @=
pc.ram 00000000c0000000-00000001ffffffff
>=20
> This means QEMU needs to send two regions to the remote device process.
> They both mmap the same file but from different starting file offsets.

are we talking here about GPA offests her or about host offsets in mmaped h=
ost file?
If it's the later then above mtree doesn't show true picture (those entries=
 are just aliases),
main guest RAM is allocated as a single continuous chunk (so far) which bel=
ongs
to a memory-backend.

> Stefan


