Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248DEC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 06:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9CCB20791
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 06:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQ9uSIdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CCB20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBXeW-0002RM-3n
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 02:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kBXdv-0001xs-7c
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 02:13:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kBXdt-0007Bq-Nm
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 02:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598595220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ojOXNWSETtKjEqSNpt/pOg5KIFCkVcLNAZp++JKh0Os=;
 b=iQ9uSIdpZrRPH0x4nkIbn7lNK4zQ4ONqc8XnuTr0yLUZR+kbkpVi5iO/eonshIC0ian4Y8
 SVQsw2ZGSuvtsNu0trzyGWOwWDl3wbYPuLnqlTjdLQdLAdSVX4c/BwR8NTpq9uti8Vd9Ad
 B6sw4cqluy/YU0YnnTXZh34Xcxu21hU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-WxmQcPzENoe0C49xSKwf8A-1; Fri, 28 Aug 2020 02:13:36 -0400
X-MC-Unique: WxmQcPzENoe0C49xSKwf8A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 017001074650;
 Fri, 28 Aug 2020 06:13:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-74.ams2.redhat.com
 [10.36.112.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 695D85D9F1;
 Fri, 28 Aug 2020 06:13:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E4C20112D737; Fri, 28 Aug 2020 08:13:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 4/6] block, migration: add bdrv_finalize_vmstate helper
References: <20200709132644.28470-1-den@openvz.org>
 <20200709132644.28470-5-den@openvz.org>
 <20200827125846.GA1429165@redhat.com>
 <a5e7f90b-629a-69d1-d9f2-4d57802ba617@openvz.org>
 <20200827130645.GT192458@redhat.com>
Date: Fri, 28 Aug 2020 08:13:29 +0200
In-Reply-To: <20200827130645.GT192458@redhat.com> ("Daniel P. =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9=22's?=
 message of "Thu, 27 Aug 2020 14:06:45 +0100")
Message-ID: <87wo1j47sm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 02:09:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Aug 27, 2020 at 04:02:38PM +0300, Denis V. Lunev wrote:
>> On 8/27/20 3:58 PM, Daniel P. Berrang=C3=A9 wrote:
>> > On Thu, Jul 09, 2020 at 04:26:42PM +0300, Denis V. Lunev wrote:
>> >> Right now bdrv_fclose() is just calling bdrv_flush().
>> >>
>> >> The problem is that migration code is working inefficiently from bloc=
k
>> >> layer terms and are frequently called for very small pieces of
>> >> unaligned data. Block layer is capable to work this way, but this is =
very
>> >> slow.
>> >>
>> >> This patch is a preparation for the introduction of the intermediate
>> >> buffer at block driver state. It would be beneficial to separate
>> >> conventional bdrv_flush() from closing QEMU file from migration code.
>> >>
>> >> The patch also forces bdrv_finalize_vmstate() operation inside
>> >> synchronous blk_save_vmstate() operation. This helper is used from
>> >> qemu-io only.
>> >>
>> >> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> >> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> >> CC: Kevin Wolf <kwolf@redhat.com>
>> >> CC: Max Reitz <mreitz@redhat.com>
>> >> CC: Stefan Hajnoczi <stefanha@redhat.com>
>> >> CC: Fam Zheng <fam@euphon.net>
>> >> CC: Juan Quintela <quintela@redhat.com>
>> >> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> >> CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> >> ---
>> >>  block/block-backend.c |  6 +++++-
>> >>  block/io.c            | 15 +++++++++++++++
>> >>  include/block/block.h |  5 +++++
>> >>  migration/savevm.c    |  4 ++++
>> >>  4 files changed, 29 insertions(+), 1 deletion(-)
>> >> diff --git a/migration/savevm.c b/migration/savevm.c
>> >> index 45c9dd9d8a..d8a94e312c 100644
>> >> --- a/migration/savevm.c
>> >> +++ b/migration/savevm.c
>> >> @@ -150,6 +150,10 @@ static ssize_t block_get_buffer(void *opaque, ui=
nt8_t *buf, int64_t pos,
>> >> =20
>> >>  static int bdrv_fclose(void *opaque, Error **errp)
>> >>  {
>> >> +    int err =3D bdrv_finalize_vmstate(opaque);
>> >> +    if (err < 0) {
>> >> +        return err;
>> > This is returning an error without having populating 'errp' which mean=
s
>> > the caller will be missing error diagnosis
>>=20
>> but this behaves exactly like the branch below,
>> bdrv_flush() could return error too and errp
>> is not filled in the same way.
>
> Doh, it seems the only caller passes NULL for the errp too,
> so it is a redundant parameter. So nothing wrong with your
> patch after all.

Not setting an error on failure is plainly wrong.

If it works because all callers pass NULL, then the obvious fix is to
drop the @errp parameter.

I agree it's not this patch's fault.  It needs fixing anyway.  If you
have to respin for some other reason, including a fix would be nice.


