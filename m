Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E05CC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 18:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE07820714
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 18:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWKBa8Uj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE07820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAI2n-0005CP-5u
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 13:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jAI1w-0004jW-A2
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 13:49:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jAI1v-0003pn-5G
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 13:49:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27780
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jAI1v-0003pT-1e
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 13:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583520542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CdidsCkIJO2OUMwXxxRvZjywtFPfPePLlpG3CuJSDQo=;
 b=BWKBa8UjG1eahv+zboFJSEgPxntXBRvznKZaQloP6svhkUp0B9bkxrrSwTUeEriYU+nrUL
 l8hllcUprVykWsxfmybpy1jxTtcxmfid9ZAxZ4UEWOQllF5bMAK8xFtETCbJOY6A7xkBM2
 TGX6To6OtdFKaozMQoJoPTSTM3NDfJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-CLif1jY3MS-EXG0KxXy2Lw-1; Fri, 06 Mar 2020 13:48:58 -0500
X-MC-Unique: CLif1jY3MS-EXG0KxXy2Lw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADE331007279;
 Fri,  6 Mar 2020 18:48:57 +0000 (UTC)
Received: from work-vm (ovpn-116-247.ams2.redhat.com [10.36.116.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AEB5A28980;
 Fri,  6 Mar 2020 18:48:51 +0000 (UTC)
Date: Fri, 6 Mar 2020 18:48:48 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 08/13] migration/ram: Simplify host page handling in
 ram_load_postcopy()
Message-ID: <20200306184848.GK3033@work-vm>
References: <20200226155304.60219-1-david@redhat.com>
 <20200226155304.60219-9-david@redhat.com>
 <20200306160538.GE3033@work-vm>
 <29ffaf0b-55e6-53c4-2fd7-b3f0676c1412@redhat.com>
 <bfc208f7-bf3c-f7d0-33e0-b864163b61fd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <bfc208f7-bf3c-f7d0-33e0-b864163b61fd@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
> On 06.03.20 17:20, David Hildenbrand wrote:
> > On 06.03.20 17:05, Dr. David Alan Gilbert wrote:
> >> * David Hildenbrand (david@redhat.com) wrote:
> >>> Add two new helper functions. This will in come handy once we want to
> >>> handle ram block resizes while postcopy is active.
> >>>
> >>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >>> Cc: Juan Quintela <quintela@redhat.com>
> >>> Cc: Peter Xu <peterx@redhat.com>
> >>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>> ---
> >>>  migration/ram.c | 54 ++++++++++++++++++++++++++++-------------------=
--
> >>>  1 file changed, 31 insertions(+), 23 deletions(-)
> >>>
> >>> diff --git a/migration/ram.c b/migration/ram.c
> >>> index d5a4d69e1c..f815f4e532 100644
> >>> --- a/migration/ram.c
> >>> +++ b/migration/ram.c
> >>> @@ -2734,6 +2734,20 @@ static inline void *host_from_ram_block_offset=
(RAMBlock *block,
> >>>      return block->host + offset;
> >>>  }
> >>> =20
> >>> +static void *host_page_from_ram_block_offset(RAMBlock *block,
> >>> +                                             ram_addr_t offset)
> >>> +{
> >>> +    /* Note: Explicitly no check against offset_in_ramblock(). */
> >>> +    return (void *)QEMU_ALIGN_DOWN((uintptr_t)block->host + offset,
> >>> +                                   block->page_size);
> >>> +}
> >>> +
> >>> +static ram_addr_t host_page_offset_from_ram_block_offset(RAMBlock *b=
lock,
> >>> +                                                         ram_addr_t =
offset)
> >>> +{
> >>> +    return ((uintptr_t)block->host + offset) & (block->page_size - 1=
);
> >>> +}
> >>> +
> >>>  static inline void *colo_cache_from_block_offset(RAMBlock *block,
> >>>                                                   ram_addr_t offset)
> >>>  {
> >>> @@ -3111,13 +3125,12 @@ static int ram_load_postcopy(QEMUFile *f)
> >>>      MigrationIncomingState *mis =3D migration_incoming_get_current()=
;
> >>>      /* Temporary page that is later 'placed' */
> >>>      void *postcopy_host_page =3D mis->postcopy_tmp_page;
> >>> -    void *this_host =3D NULL;
> >>> +    void *host_page =3D NULL;
> >>>      bool all_zero =3D false;
> >>>      int target_pages =3D 0;
> >>> =20
> >>>      while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
> >>>          ram_addr_t addr;
> >>> -        void *host =3D NULL;
> >>>          void *page_buffer =3D NULL;
> >>>          void *place_source =3D NULL;
> >>>          RAMBlock *block =3D NULL;
> >>> @@ -3143,9 +3156,12 @@ static int ram_load_postcopy(QEMUFile *f)
> >>>          if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
> >>>                       RAM_SAVE_FLAG_COMPRESS_PAGE)) {
> >>>              block =3D ram_block_from_stream(f, flags);
> >>> +            if (!block) {
> >>> +                ret =3D -EINVAL;
> >>
> >> Could we have an error_report there, at the moment it would trigger
> >> the one below.
> >=20
> > Makes sense, I'll add one!
>=20
> My memory kicks in: This was dropped on purpose. ram_block_from_stream()
> will print proper errors already.

OK!

Dave

> Cheers!
>=20
>=20
> --=20
> Thanks,
>=20
> David / dhildenb
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


