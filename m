Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1412CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C463E20869
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZO4vk7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C463E20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRgMq-0003Tp-TG
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 12:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iRgLr-0002W4-Na
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iRgLp-0004u1-1v
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:41:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34604
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iRgLo-0004to-Ql
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572889271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iFWLeQ87s6lX6o+HnOAE0ThJig2W85EWe9Iaa3SOoxM=;
 b=TZO4vk7IUG821ew97lztXK6NVG40cL78MjbxghZIS/AZS88ONz32ZybUgv1bEUjSnivCvg
 rxirSulHvBDxP5bD4RBnJDG857HsmCyEvLTUS925dG7tHZPqJyzRu9teiIJTHGFu8FXR8A
 P2kVwBXf7rsYL+PQ8S1HLlqgb+4f080=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-GBnH1mGyNM2q0dUlu5v8rg-1; Mon, 04 Nov 2019 12:41:10 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20D54477;
 Mon,  4 Nov 2019 17:41:09 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A1DA60BF3;
 Mon,  4 Nov 2019 17:41:07 +0000 (UTC)
Message-ID: <acd59579bf8750646fa918beaf5208d8b206ba45.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] nbd: Don't send oversize strings
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eric Blake
 <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Date: Mon, 04 Nov 2019 19:41:06 +0200
In-Reply-To: <dcdeae8f-6cb7-4f93-5fa8-aa02eb03bed7@virtuozzo.com>
References: <20191010210018.22000-1-eblake@redhat.com>
 <20191010210018.22000-2-eblake@redhat.com>
 <e777bd6b-525d-99e1-2584-a31f3609d5cd@virtuozzo.com>
 <c7ed4149-8cef-7897-ae95-9b24a3d4f378@redhat.com>
 <dcdeae8f-6cb7-4f93-5fa8-aa02eb03bed7@virtuozzo.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: GBnH1mGyNM2q0dUlu5v8rg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-10-15 at 16:16 +0000, Vladimir Sementsov-Ogievskiy wrote:
> 15.10.2019 18:07, Eric Blake wrote:
> > On 10/11/19 2:32 AM, Vladimir Sementsov-Ogievskiy wrote:
> > > 11.10.2019 0:00, Eric Blake wrote:
> > > > Qemu as server currently won't accept export names larger than 256
> > > > bytes, nor create dirty bitmap names longer than 1023 bytes, so mos=
t
> > > > uses of qemu as client or server have no reason to get anywhere nea=
r
> > > > the NBD spec maximum of a 4k limit per string.
> > > >=20
> > > > However, we weren't actually enforcing things, ignoring when the
> > > > remote side violates the protocol on input, and also having several
> > > > code paths where we send oversize strings on output (for example,
> > > > qemu-nbd --description could easily send more than 4k).  Tighten
> > > > things up as follows:
> > > >=20
> > > > client:
> > > > - Perform bounds check on export name and dirty bitmap request prio=
r
> > > >     to handing it to server
> > > > - Validate that copied server replies are not too long (ignoring
> > > >     NBD_INFO_* replies that are not copied is not too bad)
> > > > server:
> > > > - Perform bounds check on export name and description prior to
> > > >     advertising it to client
> > > > - Reject client name or metadata query that is too long
> > > >=20
> > > > Signed-off-by: Eric Blake <eblake@redhat.com>
> > > > ---
> > > > +++ b/include/block/nbd.h
> > > > @@ -232,6 +232,7 @@ enum {
> > > >     * going larger would require an audit of more code to make sure=
 we
> > > >     * aren't overflowing some other buffer. */
> > >=20
> > > This comment says, that we restrict export name to 256...
> >=20
> > Yes, because we still stack-allocate the name in places, but 4k is too =
large for stack allocation.  But we're inconsistent on where we use the sma=
ller 256-limit; the server won't serve an image
> > that large, but doesn't prevent a client from requesting a 4k name expo=
rt (even though that export will not be present).
> >=20
> >=20
> > > > +++ b/blockdev-nbd.c
> > > > @@ -162,6 +162,11 @@ void qmp_nbd_server_add(const char *device, bo=
ol has_name, const char *name,
> > > >            name =3D device;
> > > >        }
> > > >=20
> > > > +    if (strlen(name) > NBD_MAX_STRING_SIZE) {
> > > > +        error_setg(errp, "export name '%s' too long", name);
> > > > +        return;
> > > > +    }
> > >=20
> > > Hmmm, no, so here we restrict to 4096, but, we will not allow client =
to request more than
> > > 256. Seems, to correctly update server-part, we should drop NBD_MAX_N=
AME_SIZE and do the
> > > audit mentioned in the comment above its definition.
> >=20
> > Yeah, I guess it's time to just get rid of NBD_MAX_NAME_SIZE, and move =
away from stack allocations.  Should I do that as a followup to this patch,=
 or spin a v3?
>=20
> Hmm. It's OK too.
>=20
> With
>   - fixed mem-leak in nbd_process_options
>   - s/x_dirty_bitmap/x-dirty-bitmap in nbd_process_options in error messa=
ge
>   - following yours new wordings
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> However, this patch introduces possible crash point, asserting on bitmap =
name below, so it would better
> be fixed before this patch or immediately after it.. Still, it's unlikely=
 to have a bitmap with name
> longer than 4k..
>=20
> >=20
> > > > +++ b/nbd/client.c
> > > > @@ -289,8 +289,8 @@ static int nbd_receive_list(QIOChannel *ioc, ch=
ar **name, char **description,
> > > >            return -1;
> > > >        }
> > > >        len -=3D sizeof(namelen);
> > > > -    if (len < namelen) {
> > > > -        error_setg(errp, "incorrect option name length");
> > > > +    if (len < namelen || namelen > NBD_MAX_STRING_SIZE) {
> > > > +        error_setg(errp, "incorrect list name length");
> > >=20
> > > New wording made me go above and read the comment, what functions doe=
s. Comment is good, but without
> > > it, it sounds like name of the list for me...
> >=20
> > Maybe:
> >=20
> > incorrect name length in server's list response
>=20
> Yes, this is better, thanks
>=20
> >=20
> > >=20
> > > >            nbd_send_opt_abort(ioc);
> > > >            return -1;
> > > >        }
> > > > @@ -303,6 +303,11 @@ static int nbd_receive_list(QIOChannel *ioc, c=
har **name, char **description,
> > > >        local_name[namelen] =3D '\0';
> > > >        len -=3D namelen;
> > > >        if (len) {
> > > > +        if (len > NBD_MAX_STRING_SIZE) {
> > > > +            error_setg(errp, "incorrect list description length");
> >=20
> > and
> >=20
> > incorrect description length in server's list response
> >=20
> >=20
> > > > @@ -648,6 +657,7 @@ static int nbd_send_meta_query(QIOChannel *ioc,=
 uint32_t opt,
> > > >        if (query) {
> > > >            query_len =3D strlen(query);
> > > >            data_len +=3D sizeof(query_len) + query_len;
> > > > +        assert(query_len <=3D NBD_MAX_STRING_SIZE);
> > > >        } else {
> > > >            assert(opt =3D=3D NBD_OPT_LIST_META_CONTEXT);
> > > >        }
> > >=20
> > > you may assert export_len as well..
> >=20
> > It was asserted earlier, but doing it again might not hurt, especially =
if I do the followup patch getting rid of NBD_MAX_NAME_SIZE
> >=20
> >=20
> > > > @@ -1561,6 +1569,8 @@ NBDExport *nbd_export_new(BlockDriverState *b=
s, uint64_t dev_offset,
> > > >            exp->export_bitmap =3D bm;
> > > >            exp->export_bitmap_context =3D g_strdup_printf("qemu:dir=
ty-bitmap:%s",
> > > >                                                         bitmap);
> > > > +        /* See BME_MAX_NAME_SIZE in block/qcow2-bitmap.c */
> > >=20
> > > Hmm. BME_MAX_NAME_SIZE is checked only when creating persistent bitma=
ps. But for non-persistent
> > > name length is actually unlimited. So, we should either limit all bit=
map names to 1023 (hope,
> > > this will not break existing scenarios) or error out here (or earlier=
) instead of assertion.
> >=20
> > I'm leaning towards limiting ALL bitmaps to the same length (as we've a=
lready debated the idea of being able to convert an existing bitmap from tr=
ansient to persistent).
>=20
> Agreed, but ..
>=20
> >=20
> > >=20
> > > We also may want QEMU_BUILD_BUG_ON(NBD_MAX_STRING_SIZE < BME_MAX_NAME=
_SIZE + sizeof("qemu:dirty-bitmap:") - 1)
> >=20
> > Except that BME_MAX_NAME_SIZE is not (currently) in a public .h file.
> >=20
>=20
> .. I think, than it should be new BLOCK_DIRTY_BITMAP_MAX_NAME_SIZE.. And =
we'll have to note it in qapi doc..
> Should this change go through deprecation? Or we consider non-persistent =
bitmaps as something not really useful?
>=20
> --=20
> Best regards,
> Vladimir

I followed upon the new patch and the comments, and it seems ok now to me, =
(including the comments that were already made) but I haven't
checked if there are more cases of missing length checks.

Best regards,
=09Maxim Levitsky



