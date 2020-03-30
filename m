Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FE6C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3979A20780
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmKN30W0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3979A20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIw0q-0002vq-Do
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 11:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jIvzr-0001ua-GE
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jIvzp-0001TC-S9
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:06:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:38355)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jIvzp-0001Ry-Ko
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585580797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l20BNSDxCZM9aTXBRnhjQjhapWSLJ0wNI/x7m+lVJj8=;
 b=CmKN30W0j6p/oECA1qM8TLB4xGE6fzDCdksWpgBXdYxwNpvy8wntl0stGK7lBWCoatc/5v
 uo+qY+Ne0bF/cFHUooaF2YMN2HRDIKgWRcaGtmgq8YTvUvYWFN3WPp+db/bNjSIi/u4oOQ
 nqwHgvqF47iphIuzDHm04qY6p7IqFDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-qZI2txV_PGG1haaIkvob-w-1; Mon, 30 Mar 2020 11:06:34 -0400
X-MC-Unique: qZI2txV_PGG1haaIkvob-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4674018C35C8;
 Mon, 30 Mar 2020 15:06:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0BDF5C1A2;
 Mon, 30 Mar 2020 15:06:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6FAC111385E2; Mon, 30 Mar 2020 17:06:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v9 1/4] qcow2: introduce compression type feature
References: <20200323142558.15473-1-dplotnikov@virtuozzo.com>
 <20200323142558.15473-2-dplotnikov@virtuozzo.com>
Date: Mon, 30 Mar 2020 17:06:30 +0200
In-Reply-To: <20200323142558.15473-2-dplotnikov@virtuozzo.com> (Denis
 Plotnikov's message of "Mon, 23 Mar 2020 17:25:55 +0300")
Message-ID: <87imilubk9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Denis Plotnikov <dplotnikov@virtuozzo.com> writes:

> The patch adds some preparation parts for incompatible compression type
> feature to qcow2 allowing the use different compression methods for
> image clusters (de)compressing.
>
> It is implied that the compression type is set on the image creation and
> can be changed only later by image conversion, thus compression type
> defines the only compression algorithm used for the image, and thus,
> for all image clusters.
>
> The goal of the feature is to add support of other compression methods
> to qcow2. For example, ZSTD which is more effective on compression than Z=
LIB.
>
> The default compression is ZLIB. Images created with ZLIB compression typ=
e
> are backward compatible with older qemu versions.
>
> Adding of the compression type breaks a number of tests because now the
> compression type is reported on image creation and there are some changes
> in the qcow2 header in size and offsets.
>
> The tests are fixed in the following ways:
>     * filter out compression_type for many tests
>     * fix header size, feature table size and backing file offset
>       affected tests: 031, 036, 061, 080
>       header_size +=3D8: 1 byte compression type
>                        7 bytes padding
>       feature_table +=3D 48: incompatible feature compression type
>       backing_file_offset +=3D 56 (8 + 48 -> header_change + feature_tabl=
e_change)
>     * add "compression type" for test output matching when it isn't filte=
red
>       affected tests: 049, 060, 061, 065, 144, 182, 242, 255
>
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>

Hmm, haven't I've seen this before?  ...  Yes, I provided my QAPI part:
Acked-by for v5, and the QAPI part hasn't changed since.  You can save
me a bit of labor by carrying my Acked-by forward.

Once again, QAPI part:
Acked-by: Markus Armbruster <armbru@redhat.com>


