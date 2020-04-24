Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B6FC54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8064F2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ST+OtcgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8064F2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRvsk-0005VH-Lj
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 06:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jRvs4-0004xb-RD
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jRvs4-0003du-91
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:47:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38702
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jRvs3-0003dS-P6
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587725266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ivIfhWcXKj/Xxc39QgkuwrS8TEn+drSg3k77MfYdsN8=;
 b=ST+OtcgXcjgpJsbZF3NGqSwarm+RY+DQoLZaZPDbiyUpYWcrxx9l8lEd+fWlWfDYmS3kab
 aBDCnReXVEz79YlkQzbcSwlam3uJXJ7VwIvq0l+9UxEyFoygkVdZkmMl1ssNouWvj3uifI
 CBxxyK4gnwMmvQrX9rRm6ieufuv7HvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-JqgLsKAsNqm77WCEge1j-A-1; Fri, 24 Apr 2020 06:47:43 -0400
X-MC-Unique: JqgLsKAsNqm77WCEge1j-A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A47E7800C78;
 Fri, 24 Apr 2020 10:47:41 +0000 (UTC)
Received: from work-vm (ovpn-113-179.ams2.redhat.com [10.36.113.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0826C99CD;
 Fri, 24 Apr 2020 10:47:36 +0000 (UTC)
Date: Fri, 24 Apr 2020 11:47:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1 1/2] migration/xbzrle: replace transferred xbzrle
 bytes with encoded bytes
Message-ID: <20200424104734.GE3106@work-vm>
References: <1587352003-3312-1-git-send-email-wei.w.wang@intel.com>
 <1587352003-3312-2-git-send-email-wei.w.wang@intel.com>
 <20200421192106.GM3029@work-vm> <5E9FB148.3060906@intel.com>
MIME-Version: 1.0
In-Reply-To: <5E9FB148.3060906@intel.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 02:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kevin.tian@intel.com, quintela@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com, gloryxiao@tencent.com, yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Wang (wei.w.wang@intel.com) wrote:
> On 04/22/2020 03:21 AM, Dr. David Alan Gilbert wrote:
> > * Wei Wang (wei.w.wang@intel.com) wrote:
> > > Like compressed_size which indicates how many bytes are compressed, w=
e
> > > need encoded_size to understand how many bytes are encoded with xbzrl=
e
> > > during migration.
> > >=20
> > > Replace the old xbzrle_counter.bytes, instead of adding a new counter=
,
> > > because we don't find a usage of xbzrle_counter.bytes currently, whic=
h
> > > includes 3 more bytes of the migration transfer protocol header (in
> > > addition to the encoding header). The encoded_size will further be us=
ed
> > > to calculate the encoding rate.
> > >=20
> > > Signed-off-by: Yi Sun <yi.y.sun@intel.com>
> > > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > Can you explain why these 3 bytes matter?  Certainly the 2 bytes of the
> > encoded_len are an overhead that's a cost of using XBZRLE; so if you're
> > trying to figure out whether xbzrle is worth it, then you should includ=
e
> > those 2 bytes in the cost.
> > That other byte, that holds ENCODING_FLAG_XBZRLE also seems to be pure
> > oerhead of XBZRLE; so your cost of using XBZRLE really does include
> > those 3 bytes.
> >=20
> > SO to me it makes sense to include the 3 bytes as it currently does.
> >=20
> > Dave
>=20
> Thanks Dave for sharing your thoughts.
>=20
> We hope to do a fair comparison of compression rate and xbzrle encoding
> rate.
> The current compression_rate doesn't include the migration flag overhead
> (please see
> update_compress thread_counts() ). So for xbzrle encoding rate, we wanted=
 it
> not include the migration
> protocol flags as well (but the 2 bytes xbzrle encoding overhead is kept
> there, as the compression rate
> includes the compression header overhead).
>=20
> Or would you think it is necessary to add the migration flag (8 bytes) fo=
r
> compression
> when calculating the compression rate?

I don't think the migration flag (8 bytes) matters, because everyone has
that; but isn't this patch about the 3 bytes (1 byte
ENCONDING_FLAG_XBZRLE) (2 byte encoded_len) ?

The 2 byte encoded_len in this code, corresponds to the 4 byte blen in
qemu_put_compression_data;  I'm not sure but I think that 4 bytes is
included in the length update_compress_thread_counts() sees - if so
that makes it equivalent including the length.

Dave


> Best,
> Wei
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


