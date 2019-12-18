Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1696CC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 15:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D93DF2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 15:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCozZ/bI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93DF2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihaxy-00059h-Vu
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 10:10:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1ihawP-0003bX-4m
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1ihawL-0004G9-QG
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:08:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31413
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1ihawL-0004C3-LD
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576681721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+zU9605pqX7Wzajiu1iFSoByg/A8JpvEG85wsowDPnM=;
 b=UCozZ/bIP0p0qxLWuRRlyj+vOtThm42SbkSJzpq7WCyF1myec56vNCAOMpcDlo/266Djnx
 3vaHKeGZgz911CId9ltFFxSgpc2xl/AYtoJTk4D9JWiAQEoHADxKkIva9NvjzT5MAAJi0C
 N8rmMD4j8NkirdpR8wjhfp5nZj/PQ5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-fa92d3CPMU2EOoqtyedibQ-1; Wed, 18 Dec 2019 10:08:37 -0500
X-MC-Unique: fa92d3CPMU2EOoqtyedibQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1D7F10752AB;
 Wed, 18 Dec 2019 15:08:36 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1EE21001281;
 Wed, 18 Dec 2019 15:08:34 +0000 (UTC)
References: <20191128104129.250206-1-slp@redhat.com>
 <20191128104129.250206-5-slp@redhat.com>
 <20191209160601.GB6715@linux.fritz.box>
 <7ea304ab-0a4b-8c0a-ae9f-2f6501198840@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 4/4] blockdev: honor bdrv_try_set_aio_context() context
 requirements
In-reply-to: <7ea304ab-0a4b-8c0a-ae9f-2f6501198840@redhat.com>
Date: Wed, 18 Dec 2019 16:08:29 +0100
Message-ID: <87bls5zn6a.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Eric Blake <eblake@redhat.com> writes:

> On 12/9/19 10:06 AM, Kevin Wolf wrote:
>> Am 28.11.2019 um 11:41 hat Sergio Lopez geschrieben:
>>> bdrv_try_set_aio_context() requires that the old context is held, and
>>> the new context is not held. Fix all the occurrences where it's not
>>> done this way.
>>>
>>> Suggested-by: Max Reitz <mreitz@redhat.com>
>>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>>> ---
>
>> Or in fact, I think you need to hold the AioContext of a bs to
>> bdrv_unref() it, so maybe 'goto out' is right, but you need to unref
>> target_bs while you still hold old_context.
>
> I suspect https://bugzilla.redhat.com/show_bug.cgi?id=3D1779036 is also
> a symptom of this.  The v5 patch did not fix this simple test case:
>
>
> $ qemu-img create -f qcow2 f1 100m
> $ qemu-img create -f qcow2 f2 100m
> $ ./qemu-kvm -nodefaults -nographic -qmp stdio -object iothread,id=3Dio0 =
\
>  -drive driver=3Dqcow2,id=3Ddrive1,file=3Df1,if=3Dnone -device
> virtio-scsi-pci,id=3Dscsi0,iothread=3Dio0 -device
> scsi-hd,id=3Dimage1,drive=3Ddrive1 \
>  -drive driver=3Dqcow2,id=3Ddrive2,file=3Df2,if=3Dnone -device
> virtio-blk-pci,id=3Dimage2,drive=3Ddrive2,iothread=3Dio0
>
> {'execute':'qmp_capabilities'}
>
> {'execute':'transaction','arguments':{'actions':[
> {'type':'blockdev-snapshot-sync','data':{'device':'drive1',
> 'snapshot-file':'sn1','mode':'absolute-paths','format':'qcow2'}},
> {'type':'blockdev-snapshot-sync','data':{'device':'drive2',
> 'snapshot-file':'/aa/sn1','mode':'absolute-paths','format':'qcow2'}}]}}
>
> which is an aio context bug somewhere on the error path of
> blockdev-snapshot-sync (the first one has to be rolled back because
> the second part of the transaction fails early on a nonexistent
> directory)

This is slightly different. The problem resides in
external_snapshot_abort():

   1717 static void external_snapshot_abort(BlkActionState *common)
   1718 {
   1719     ExternalSnapshotState *state =3D
   1720                              DO_UPCAST(ExternalSnapshotState, commo=
n, common);
   1721     if (state->new_bs) {
   1722         if (state->overlay_appended) {
   1723             AioContext *aio_context;
   1724=20
   1725             aio_context =3D bdrv_get_aio_context(state->old_bs);
   1726             aio_context_acquire(aio_context);
   1727=20
   1728             bdrv_ref(state->old_bs);   /* we can't let bdrv_set_bac=
kind_hd()
   1729                                           close state->old_bs; we n=
eed it */
   1730             bdrv_set_backing_hd(state->new_bs, NULL, &error_abort);
   1731             bdrv_replace_node(state->new_bs, state->old_bs, &error_=
abort);
   1732             bdrv_unref(state->old_bs); /* bdrv_replace_node() ref'e=
d old_bs */
   1733=20
   1734             aio_context_release(aio_context);
   1735         }
   1736     }
   1737 }

bdrv_set_backing_hd() returns state->old_bs to the main AioContext,
while bdrv_replace_node() expects state->new_bs and state->old_bs to be
using the same AioContext.

I'm thinking sending this as a separate patch:

diff --git a/blockdev.c b/blockdev.c
index e33abd7fd2..6c73ac4e32 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1731,6 +1731,8 @@ static void external_snapshot_abort(BlkActionState *c=
ommon)
     if (state->new_bs) {
         if (state->overlay_appended) {
             AioContext *aio_context;
+            AioContext *tmp_context;
+            int ret;
=20
             aio_context =3D bdrv_get_aio_context(state->old_bs);
             aio_context_acquire(aio_context);
@@ -1738,6 +1740,25 @@ static void external_snapshot_abort(BlkActionState *=
common)
             bdrv_ref(state->old_bs);   /* we can't let bdrv_set_backind_hd=
()
                                           close state->old_bs; we need it =
*/
             bdrv_set_backing_hd(state->new_bs, NULL, &error_abort);
+
+            /*
+             * The call to bdrv_set_backing_hd() above returns state->old_=
bs to
+             * the main AioContext. As we're still going to be using it, r=
eturn
+             * it to the AioContext it was before.
+             */
+            tmp_context =3D bdrv_get_aio_context(state->old_bs);
+            if (aio_context !=3D tmp_context) {
+                aio_context_release(aio_context);
+                aio_context_acquire(tmp_context);
+
+                ret =3D bdrv_try_set_aio_context(state->old_bs,
+                                               aio_context, NULL);
+                assert(ret =3D=3D 0);
+
+                aio_context_release(tmp_context);
+                aio_context_acquire(aio_context);
+            }
+
             bdrv_replace_node(state->new_bs, state->old_bs, &error_abort);
             bdrv_unref(state->old_bs); /* bdrv_replace_node() ref'ed old_b=
s */

What do you think?

Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl36QO4ACgkQ9GknjS8M
AjXPdQ//cROvK+82M1K2QyOHzMyEwIdGVwf9fHhfRB1ZElcEqvPXbMx1lVHRYz7S
MF+EQNkwbJUs/1rdFPNWZHHrLlPmffZVDMx6vXSATgL/j+sUqxou1AJLGz5OYbJF
tNJ8SxUAG2EFwNcWQcdJRThzbqy/alXw9PTZP3DPGib8+5paW2fr6IMsfolJGi7R
qXrmeap369n6tVSv4unBA/zBIgZtpb2Ul414eat+j+rct5gbiJjAZhjhzXLW3KCe
bs1UP2f+qIWzCaTDP8KZ7Atm0fkF4FQcxktcfguUllJ4xbteL9nc254c26iajdaa
S5qDoyVazBQhzh87ei93fSqdWG+Zzu8orFQwzuSISzj6K7CdBk8bvBEpy2OQZbRs
jCZiQE3YfXTRtRpyrouSWoSe6/lL4vZx5kDX1IW6ZY4BrrZ0w5hJgMucqsGzT0E8
DQ2UmZ+fejDwpAl3kDGyX5LPm1oy8CKA1PaPs/ThoZNzzSqV1QHqA7jSb4ALSU8D
bOL5htCl0aWtZdbpVQk5lvWRZYlqIpSWLJxVlP/ZH5NLUgaQJfER2YA43jUmM5dy
5nSptaHeUx/8AI2MIe8bdDHrNwK6xYoop6xONbb9sltm3XtHDP9AJKbi504pbZ8F
j1PWxcA27OOJ77Z8zOhjXwRE6vXVFSYpgF2q1ianHWBPuI/kTzw=
=x3vk
-----END PGP SIGNATURE-----
--=-=-=--


