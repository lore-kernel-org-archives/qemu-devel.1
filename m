Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B529C33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBDC42464B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="G4tc5O51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBDC42464B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is8OD-0001Lt-1A
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 11:53:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1is8Mc-0007db-K1
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1is8MY-00077j-LK
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:51:22 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:40577)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1is8MY-00076T-46
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=gOf05fYM51+BEY5BgOPdJbAqbo/DiHVfIwPIrJAlRDA=; b=G4tc5O51J6i5rehav4IOaz5iXE
 V4KeZs2qtWTx8AWyYBt65xePmFWXXF4obzSkjarwO8orNO6kgIwRf+hwGKbsJBdXuXBjTDU1MDvRw
 QW9rIDEcXbeOCb1XougAAZr7Bm469wwfelyvuPtb/c4ty8KPW3201wVoakQWb+EjZKDki78sIIJLg
 KfwzPGKu52auQHhSRfO1XnuvduCgZN3gCk3Jk5bJNE/fHvqgcPZnQPQ0Nj6PL/7B7FmTujtbs/dog
 lT62l5S/tbOW65V3g425ydcn9O7A6FbMsn8IeCbHIcCwngZPz2ZicAWEqklV0xCFTpyvP+ok81FPf
 HNkSBRjc9hwOE1XO6ODmLAmO5D0rvBERCNT9bLhfJjBsRns+6clQaYrjINHZ2rIyKquPWN8cmHyG+
 buNruOqwD/PAPSg3ks0s8324vfF0uYSRu+EWlKTG7lFT5n4lEbUnYjpoOZLn7mBxfNUb6ditfnPu5
 q1V4D234TPiWNte0wN191BDkxSX8DUjHkvDA/0seVWM8GWQ58l94cJCZJ9L8t5b6MO/0hFK7+LgJC
 zXv+3Vvp8uZQ0IEMNE7aCZLcjd5W3XCk2hTXjx+0jgbQsjAtfviuUQoGohZwGQIzCHTJFcH+BapZo
 ADkPHCXDIi8bO7InYSvy1uBsy7bL85EiAz8ilbV50=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v3 03/11] 9pfs: validate count sent by client with
 T_readdir
Date: Thu, 16 Jan 2020 17:51:10 +0100
Message-ID: <5915926.WqdOhGH810@silver>
In-Reply-To: <20200116143342.4d518b30@bahia.lan>
References: <cover.1578957500.git.qemu_oss@crudebyte.com>
 <0edf21d2cb2a6cf22ba1065bf451b44ad5962cbd.1578957500.git.qemu_oss@crudebyte.com>
 <20200116143342.4d518b30@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.189.157.229
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 16. Januar 2020 14:33:42 CET Greg Kurz wrote:
> On Mon, 13 Jan 2020 23:22:08 +0100
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > A good 9p client sends T_readdir with "count" parameter that's
> > sufficiently smaller than client's initially negotiated msize
> > (maximum message size). We perform a check for that though to
> > avoid the server to be interrupted with a "Failed to encode
> > VirtFS reply type 41" error message by bad clients.
> > 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> > 
> >  hw/9pfs/9p.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index a5fbe821d4..30da2fedf3 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -2426,6 +2426,7 @@ static void coroutine_fn v9fs_readdir(void *opaque)
> > 
> >      int32_t count;
> >      uint32_t max_count;
> >      V9fsPDU *pdu = opaque;
> > 
> > +    V9fsState *s = pdu->s;
> > 
> >      retval = pdu_unmarshal(pdu, offset, "dqd", &fid,
> >      
> >                             &initial_offset, &max_count);
> > 
> > @@ -2434,6 +2435,13 @@ static void coroutine_fn v9fs_readdir(void *opaque)
> > 
> >      }
> >      trace_v9fs_readdir(pdu->tag, pdu->id, fid, initial_offset,
> >      max_count);
> > 
> > +    if (max_count > s->msize - P9_IOHDRSZ) {
> 
> P9_IOHDRSZ relates to Twrite. The Rreaddir message has a smaller header
> of size 11:
> 
> size[4] Rreaddir tag[2] count[4]

Right, looks like I have falsely picked P9_IOHDRSZ after looking at:

static size_t v9fs_readdir_data_size(V9fsString *name)
{
    /*
     * Size of each dirent on the wire: size of qid (13) + size of offset (8)
     * size of type (1) + size of name.size (2) + strlen(name.data)
     */
    return 24 + v9fs_string_size(name);
}

I'll have to correct that in the test cases as well. So no need to comment on 
them for now.

But if you have an idea about the issue mentioned in cover letter (patch 7), 
let me know. I have a feeling that there is some problem with the test 
environment, because I also get strange error messages when I just add some 
more e.g. noop 9pfs test cases (empty test cases doing nothing) or by copy 
pasting existing tests and then running 

tests/qos-test -l

which obviously should just list the test cases, but not executing any of 
them. I'd end up with "cannot push stack" error messages for some reason.

> > +        max_count = s->msize - P9_IOHDRSZ;
> > +        warn_report_once(
> > +            "9p: bad client: T_readdir with count > msize - P9_IOHDRSZ"
> > +        );
> > +    }
> > +
> > 
> >      fidp = get_fid(pdu, fid);
> >      if (fidp == NULL) {
> >      
> >          retval = -EINVAL;

Best regards,
Christian Schoenebeck



