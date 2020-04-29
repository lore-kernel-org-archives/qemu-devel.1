Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8416C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:01:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A2E2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGvrYrbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A2E2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTkTG-00047K-Rh
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 07:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jTkS8-0003S8-G1
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jTkS7-0000r5-Qf
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:00:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59046
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jTkS7-0000qu-4q
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588158030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Yti0IDRjXVuwNHxoFxvXmxHbfHFZQM0sCUb+gc/pDo=;
 b=CGvrYrbCeYePjdEEGChORY93t34gJr68IYrKCRTToTa4dQwXqsbEi5Ol8bpH/sgq7mzPY1
 xSbdoOJahSnxonqzi95xxeZmryvrS6pIDtfH70dwCPOTwdk9aE+Agz7i/eR+vW0PPUEfCg
 f0288My7qrh4SqPJoFvfrHvYAgDWCC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-7xARnlmzPWel-FOmaAYM4g-1; Wed, 29 Apr 2020 07:00:26 -0400
X-MC-Unique: 7xARnlmzPWel-FOmaAYM4g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F19E107ACCA;
 Wed, 29 Apr 2020 11:00:25 +0000 (UTC)
Received: from work-vm (ovpn-114-192.ams2.redhat.com [10.36.114.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E3DE1000079;
 Wed, 29 Apr 2020 11:00:20 +0000 (UTC)
Date: Wed, 29 Apr 2020 12:00:18 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v2] migration/xbzrle: add encoding rate
Message-ID: <20200429110018.GH2834@work-vm>
References: <1587974511-14953-1-git-send-email-wei.w.wang@intel.com>
 <20200428145110.GH2794@work-vm> <5EA8D1C9.5000209@intel.com>
MIME-Version: 1.0
In-Reply-To: <5EA8D1C9.5000209@intel.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kevin.tian@intel.com, berrange@redhat.com, quintela@redhat.com,
 qemu-devel@nongnu.org, peterx@redhat.com, gloryxiao@tencent.com,
 yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Wang (wei.w.wang@intel.com) wrote:
> On 04/28/2020 10:51 PM, Dr. David Alan Gilbert wrote:
> > * Wei Wang (wei.w.wang@intel.com) wrote:
> > > Users may need to check the xbzrle encoding rate to know if the guest
> > > memory is xbzrle encoding-friendly, and dynamically turn off the
> > > encoding if the encoding rate is low.
> > >=20
> > > Signed-off-by: Yi Sun <yi.y.sun@intel.com>
> > > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > > ---
> > >   migration/migration.c |  1 +
> > >   migration/ram.c       | 38 ++++++++++++++++++++++++++++++++++++--
> > >   monitor/hmp-cmds.c    |  2 ++
> > >   qapi/migration.json   |  5 ++++-
> > >   4 files changed, 43 insertions(+), 3 deletions(-)
> > >=20
> > > ChangeLog:
> > > - include the 3 bytes (ENCODING_FLAG_XBZRLE flag and encoded_len) whe=
n
> > >    calculating the encoding rate. Similar to the compress rate
> > >    calculation, the 8 byte RAM_SAVE_FLAG_CONTINUE flag isn't included=
 in
> > >    the calculation.
> > >=20
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index 187ac04..e404213 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -930,6 +930,7 @@ static void populate_ram_info(MigrationInfo *info=
, MigrationState *s)
> > >           info->xbzrle_cache->pages =3D xbzrle_counters.pages;
> > >           info->xbzrle_cache->cache_miss =3D xbzrle_counters.cache_mi=
ss;
> > >           info->xbzrle_cache->cache_miss_rate =3D xbzrle_counters.cac=
he_miss_rate;
> > > +        info->xbzrle_cache->encoding_rate =3D xbzrle_counters.encodi=
ng_rate;
> > >           info->xbzrle_cache->overflow =3D xbzrle_counters.overflow;
> > >       }
> > > diff --git a/migration/ram.c b/migration/ram.c
> > > index 04f13fe..f46ab96 100644
> > > --- a/migration/ram.c
> > > +++ b/migration/ram.c
> > > @@ -327,6 +327,10 @@ struct RAMState {
> > >       uint64_t num_dirty_pages_period;
> > >       /* xbzrle misses since the beginning of the period */
> > >       uint64_t xbzrle_cache_miss_prev;
> > > +    /* Amount of xbzrle pages since the beginning of the period */
> > > +    uint64_t xbzrle_pages_prev;
> > > +    /* Amount of xbzrle encoded bytes since the beginning of the per=
iod */
> > > +    uint64_t xbzrle_bytes_prev;
> > >       /* compression statistics since the beginning of the period */
> > >       /* amount of count that no free thread to compress data */
> > > @@ -696,6 +700,18 @@ static int save_xbzrle_page(RAMState *rs, uint8_=
t **current_data,
> > >           return -1;
> > >       }
> > > +    /*
> > > +     * Reaching here means the page has hit the xbzrle cache, no mat=
ter what
> > > +     * encoding result it is (normal encoding, overflow or skipping =
the page),
> > > +     * count the page as encoded. This is used to caculate the encod=
ing rate.
> > > +     *
> > > +     * Example: 2 pages (8KB) being encoded, first page encoding gen=
erates 2KB,
> > > +     * 2nd page turns out to be skipped (i.e. no new bytes written t=
o the
> > > +     * page), the overall encoding rate will be 8KB / 2KB =3D 4, whi=
ch has the
> > > +     * skipped page included. In this way, the encoding rate can tel=
l if the
> > > +     * guest page is good for xbzrle encoding.
> > > +     */
> > > +    xbzrle_counters.pages++;
> > Can you explain how that works with overflow?  Doesn't overflow return
> > -1 here, not increment the bytes, so it looks like you've xbzrle'd a
> > page, but the encoding rate hasn't incremented.
>=20
> OK. How about adding below before returning -1 (for the overflow case):
>=20
> ...
> xbzrle_counters.bytes +=3D TARGET_PAGE_SIZE;
> return -1;

Yes, I think that feels better.

Dave

> Example: if we have 2 pages encoded as below:
> 4KB--> after normal encoding: 2KB
> 4KB--> after overflow: 4KB (will be sent as non-encoded page)
> then the encoding rate is 8KB / 6KB =3D ~1.3
> (if we skip the counting of the overflow case,
> the encoding rate will be 4KB/ 2KB=3D2. Users may think that's
> good to go with xbzrle, unless they do another calculation with
> checking the overflow numbers themselves)
>=20
> Best,
> Wei
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


