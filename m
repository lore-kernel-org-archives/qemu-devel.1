Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86098C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE9F20842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE9F20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOFN-0003ca-Ne
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 15:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iFO54-0001uC-Sh
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iFO53-0005Pl-Dx
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:45:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iFO4t-0005Cc-GU; Tue, 01 Oct 2019 15:44:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 448C6300CB28;
 Tue,  1 Oct 2019 19:44:54 +0000 (UTC)
Received: from [10.3.116.201] (ovpn-116-201.phx2.redhat.com [10.3.116.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21D765D9CC;
 Tue,  1 Oct 2019 19:44:51 +0000 (UTC)
Subject: Re: [PATCH v4 23/31] block: Fix error_append_hint/error_prepend usage
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-24-vsementsov@virtuozzo.com>
 <f6456405-3128-a530-7039-45671d8f2508@redhat.com>
 <e626f8ca-e0f6-ef0d-1d09-3b7fcbde8cb3@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b934b470-9858-7a33-991a-3d25ff8ecc30@redhat.com>
Date: Tue, 1 Oct 2019 14:44:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <e626f8ca-e0f6-ef0d-1d09-3b7fcbde8cb3@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 01 Oct 2019 19:44:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 "integration@gluster.org" <integration@gluster.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 1:55 PM, Vladimir Sementsov-Ogievskiy wrote:

>> Your patch is missing a patch to qcow2_store_persistent_dirty_bitmaps(=
), which calls error_prepend(errp, ...).=C2=A0 However, when I manually r=
an the same spatch command line, I also got the same failure to include a=
 fix in that function.
>>
>> I'm not sure what's wrong with the .cocci script to miss that instance=
; I've tried fiddling around with the .cocci file to see if I can spot an=
y change to make (for example, using ... instead of <+...), but so far, w=
ith no success at getting the second function patched.
>>
>=20
>=20
> Hmm, interesting. Actually I think that coccinelle is something that ju=
st works bad from the beginning of these series. And here:
>=20

> but failes with:
>=20
> void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error *=
*errp)
> {
>       QSIMPLEQ_HEAD(, Qcow2BitmapTable) drop_tables;
>=20
>       error_prepend(errp, "Bitmap '%s' doesn't satisfy the constraints:=
 ",
>                     name);
> }
>=20
> So, it can't parse "QSIMPLEQ_HEAD(, Qcow2BitmapTable) drop_tables" thin=
g..

Generally, when running spatch, you want to include --macro-file=20
scripts/cocci-macro-file.h to help coccinelle get past the worst of the=20
preprocessor macros it can't otherwise handle.  But that is rather sad=20
that it ignores the entire function body as soon as it encounters a=20
parse problem, and also sad that scripts/cocci-macro-file.h isn't yet=20
complete enough to help coccinelle past the QSIMPLEQ_HEAD() uses in our=20
sources.  (I wonder how many other false negatives we have where we=20
missed a code cleanup because Coccinelle silently gave up on parsing a=20
function or file)


> adding --recursive-includes parameter to spatch leads to error:
>=20
> [.. a lot of failures]
> failed on sys/shm.h
> failed on sys/uio.h
> failed on qapi/qapi-types-error.h
> failed on qapi/qapi-types-crypto.h
> failed on sys/endian.h
> failed on machine/bswap.h
> failed on byteswap.h
> failed on pthread.h
> failed on semaphore.h
> failed on qapi/qapi-builtin-types.h
> failed on qapi/qapi-types-block-core.h
> failed on qapi/qapi-types-job.h
> failed on qcow2.h
> Impossible: How can diff be null and have not Correct in compare_c? Tag=
1 ("diff token: QEMU_PACKED VS QEMU_PACKED\nFile \"block/qcow2-bitmap.c\"=
, line 59, column 15, charpos =3D 2334\n  around =3D 'QEMU_PACKED',\n  wh=
ole content =3D typedef struct QEMU_PACKED Qcow2BitmapDirEntry {\nFile \"=
/tmp/cocci-output-10311-cc4e45-qcow2-bitmap.c\", line 59, column 15, char=
pos =3D 2334\n  around =3D 'QEMU_PACKED',\n  whole content =3D typedef st=
ruct QEMU_PACKED Qcow2BitmapDirEntry {\n")

Eww - that sounds like a Coccinelle bug that we should report to their=20
upstream.

>=20
> Aha, we need -I option. Something like
>=20
> spatch --verbose-parsing --verbose-includes -I include -I '.' -I block =
--recursive-includes --sp-file scripts/coccinelle/fix-error-add-info.cocc=
i block/qcow2-bitmap.c 2>&1
>=20
>=20
> And it just can't parse our includes, queue.h for example.. So many par=
sing errors.

We may not need to parse all our headers, if the --macro-file=20
scripts/cocci-macro-file.h is sufficient.

In fact, now that I found that (by reading through git log history of=20
previous Coccinelle scripts we've run), and adding the proper=20
--macro-file command line argument, I didn't have to add a=20
--recursive-includes, but Coccinelle was finally able to fix that last=20
spot in block/qcow2-bitmap.c.


> So, it seems like coccinelle just don't work. At least it don't allow t=
o define initializer macro.
>=20
> Any ideas? The series is still meaningful. Not all bugs are fixed, but =
at least some bugs are fixed.
>=20

Using --macro-file sscripts/cocci-macro-file.h should get it a lot=20
further.  The sad part is I don't have a quantitative way to tell how=20
many functions/files are being silently skipped when Coccinelle runs up=20
against something it doesn't know how to parse.

> I'm afraid I can't put more effort on this topic, it already ate a lot =
of time.
>=20
> As an alternative I can suggest Greg to rebase his series on my patch 0=
4 and forget about error_append
> and so on.
>=20
> Hmm or may be try some simple regex instead of coccinelle?
>=20
>=20
> Something as simple as substitute
> (^[^{}]+\([^{}]*Error \*\*errp[^{}]*\)\s*^\{)(([^}]|(?<!^)})*error_(pre=
pend|append_hint)\(errp)
>=20
> by
>=20
> \1\n    ERRP_AUTO_PROPAGATE();\2
>=20
> seems work

A little more blunt (and as written, not idempotent), but as long as we=20
document whatever pattern we use (whether coccinelle or regex) and the=20
patch is repeatable, that's less of a concern.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

