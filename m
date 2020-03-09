Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE9DC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 17:26:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A4020848
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 17:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fk6LmaD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A4020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBMAR-0006Mt-EZ
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 13:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sameid@google.com>) id 1jBM9o-0005sY-Fl
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 13:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sameid@google.com>) id 1jBM9m-00023A-Vk
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 13:25:36 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730]:34527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sameid@google.com>) id 1jBM9m-00021u-OI
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 13:25:34 -0400
Received: by mail-qk1-x730.google.com with SMTP id f3so10047509qkh.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 10:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=auMLp3vEObUuzn0+kasqcyh9o2Yhz7WHrAe+TY06ISs=;
 b=fk6LmaD4JkunzM2+A83/WqU2f8j2bjD4IwrKpkUMnzwBTs50LEz3pWwzpPazDnwG3a
 rkd8RQXVRUvkdNK0xV68TZrubxGoQD1eSWliZ7/hlzBArT4Y3hBtunBoTY+/NbwAMqJU
 N9cj9uVbNgCFNkRYxRk3sdValTU8c9MKXVu3h5CZmyfzjBihDlNJGHY36GUpi3tgzyiY
 16eEezzDJT2uiEFqZUXVcjJYAcEEyOq5kPDjncFWt3DTzAXzy3jbd9dm3V4xmqMLeYi/
 lIrjdu1rySrm5paiRLXBTpajj4kfq7BtmuZ/rwFdNFQUDPjWwoaKNkoO2d5gfh1mtC0t
 yFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=auMLp3vEObUuzn0+kasqcyh9o2Yhz7WHrAe+TY06ISs=;
 b=NjE0UNUwxAzmShvejGZmQ38ijg5w8ejNOSbuzygg11jfZ9JKouOyC20e0oqTNIJYlg
 BquqSRqTe6XNz4pNVyd9qjeglma4XKhvlcfr7j31aUlWix1O3V7SbbmwiIhUyYD3z27g
 B9GPQvjO4mfzMMNDGSsVl0S4QYM9OupbRXFumja+rJSdUoxz8qeuSiEnA4RrM7O6k7Sa
 4iSLThTQUEeD9WV1i7yYzzxM4nehYdlTZn5ch6ddiPZ3Nx08CmcdAF48UvqWbFk5VVkl
 ormr6hi4AjjkM4NcxvIREGkA6+mUZzdtwM53+FiCtjD7QBfNykhhByKfYgybEQmLrKYA
 meKA==
X-Gm-Message-State: ANhLgQ079oBhA0Y+OtkQGAgoOvj+EsWWCpulmSSKfkJl5MHzRg5gip1S
 eA+BSc9SOGvFh+6MoSr+oojG1Vo2T/6ddezkLq9VGQ==
X-Google-Smtp-Source: ADFU+vuGU4H6699D4cG4I23YBh3nIQEXo8+E9EwxDagmgtULdetaR6u/YcY/pM4TQGRUDEWYWLbpHhwo0MZdXNQMwI0=
X-Received: by 2002:a05:620a:a0d:: with SMTP id
 i13mr16170302qka.333.1583774733291; 
 Mon, 09 Mar 2020 10:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAPohS2SoTcyb-MCex7MxC59oB_VTp6F0GjvU-7xauv7ffJi6-Q@mail.gmail.com>
In-Reply-To: <CAPohS2SoTcyb-MCex7MxC59oB_VTp6F0GjvU-7xauv7ffJi6-Q@mail.gmail.com>
From: Sam Eiderman <sameid@google.com>
Date: Mon, 9 Mar 2020 19:25:21 +0200
Message-ID: <CAFr6bU=b-kpxgCsSCHEybbOm-VrQ-7T2Ov+ZXxzhHGyQjmhK_g@mail.gmail.com>
Subject: Re: Regarding SESparse support in QEMU
To: Tirthankar Saha <tirthankar.saha@gmail.com>
Cc: Max Reitz <mreitz@redhat.com>, kwolf@redhat.com, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::730
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

Hi,

This is regarding the new VMDK format of SESparse snapshots which is
available since ESXi 6.5 (for disks > 2TB) and is default since ESXi
6.7 (for all disks).
Unlike the previous format (VMFSSparse), SESparse's format is not
disclosed by VMware.

Even though, I believe that the format itself is not too complicated
and I'll try to give out pointers on how it is possible to implement a
read-write support for it.

In commit 98eb9733f (vmdk: Add read-only support for seSparse
snapshots) I have added a read-only support. As stated in the commit
message - I did not implement the following features which are
implemented in VMware:
    * read-write
    * journal replay
    * space reclamation
    * unmap support

I don't fully understand what you're trying to implement when you say
"read-write" since there are some scenarios for which you will not
need to implement a fully compatible SESparse image.

----

After creating an SESparse snapshot (by invoking "Take Snapshot" in
VMware), the following file:

    /var/log/hostd.log

Contains messages of the like:

[...] Const Header:
[...]  constMagic     = 0xcafebabe
[...]  version        = 2.1
[...]  capacity       = 204800
[...]  grainSize      = 8
[...]  grainTableSize = 64
[...]  flags          = 0
[...] Extents:
[...]  Header         : <1 : 1>
[...]  JournalHdr     : <2 : 2>
[...]  Journal        : <2048 : 2048>
[...]  GrainDirectory : <4096 : 2048>
[...]  GrainTables    : <6144 : 2048>
[...]  FreeBitmap     : <8192 : 2048>
[...]  BackMap        : <10240 : 2048>
[...]  Grain          : <12288 : 204800>
[...] Volatile Header:
[...] volatileMagic     = 0xcafecafe
[...] FreeGTNumber      = 0
[...] nextTxnSeqNumber  = 0
[...] replayJournal     = 0

The sizes that are seen in the log file are in sectors.
Extents are of the following format: <offset : size>

Just from the strings in this message and by information publicly
disclosed by VMware it is obvious how SESparse is implemented:

The problem with VMFSSparse (previous format) is that given an offset
to a grain in the file - you don't know if that grain is allocated or
not - you must scan all grain tables to perform space reclamation, and
even if somehow you know that the grain is not allocated - you don't
have the offset to the grain table that references it - to unmap it
from there.
This was obviously solved using the structures "FreeBitmap" and "BackMap".

FreeBitmap is simply a very big bitmap that tells you if the grain at
the offset of the bit is allocated.
Meaning:
If bit X is set to 1 then Grain[X] is allocated (Notice that each
grain is of the size "grainSize" sectors - usually 4K bytes).

Now, we can simply iterate through FreeBitmap to find grains we can reclaim.

Problem - we don't know where is the grain table to update, scanning
all grain tables is slow.

Solution: BackMap:

For Grain[X] look at BackMap[X] - BackMap[X] contains an index to
GrainTables at which the grain table resides (Multiply by the size of
a grain table in order to get the real offset).
(Notice that BackMap scales with the size of the VMDK - but only 8
bytes per entry instead 4K bytes)

Problem - when we now write to BackMap & FreeBitmap structures too -
we might experience data corruption of the SESparse format.

Solution: Journal

Write data (write what where) to the journal, mark journal dirty,
execute instructions in journal, clean dirty mark - if you crash in
the middle - you will reexecute the instructions when opening the VMDK
file.
(Notice this was not a problem in VMFSSprase since we could first
write the data in the grain, then update the grain table to the grain,
then update the grain directory to the grain table - so the data is
actually written on the last operation and the format structure is not
corrupted)

In any case, now we need to implement the following:

When opening the file:
* Execute journal (not implemented)

When reading
* Follow Grain Directory -> Grain Table -> Grain (This is implemented now)

For writing (not implemented, probably something like this)
* Follow Grain Directory
  * If grain table allocated -> get it
  * Otherwise, allocate new grain table (this probably uses
FreeGTNumber in the volatile header to know where to do so)
    * Extend the file by the size needed to store all the grains in
the grain table (I think this is 16MB by default)
  * Follow Grain Table
    * If grain allocated, get it
    * Otherwise, allocate it
* Write to grain (you may need to read it if you write only to some of
it, since now grains are 4K - it is possible to read/write half a
grain)
* Update BackMap and FreeBitmap accordingly.
* All of the above writes should go through the Journal for consistency.

When unmapping:
* Update bits in FreeBitmap (1 -> 0)

When reclaiming space:
Go through FreeBitmaps, decide if should perform cleaning (must have a
complete empty grain table), if so, reclaim
(You can only clean when a full Grain table is unmapped, copy another
grain table in its stead, you'll have to update Grains, and the Grain
directories, all operations should go through journal)

----

I'm not sure about how the journal is implemented or how does its
structures look like (write what where) but from what I understand the
size of the journal is constant (2048 sectors) it doesn't change
depending on the size of the disk, this makes sense - the size of the
journal is simply a buffer of writes and its size only affects "how
fast" you write. (2048 sectors was probably enough for VMware)

Notice that your implementation matters - you can totally conform to
the specs of SESparse but your performance may not be that good - if
you execute the journal for every sector you write - performance will
be bad. So you'll need to write to the journal until it's full or some
time has passed and then flush it.
----

In the end it really depends on what you're trying to achieve.

If you want to have a "read-write" VM working on top of an SESparse
snapshot - you can always use an overlay of a qcow2 image.
If you want to support "read-only" but to support "dirty journal" you
don't need to care much about performance and just focus on the "write
what where" format of the journal.
If you want to support a "read-write" on top of SESparse and then
expect a VM on ESXi to run with it - you only need to understand the
format of the journal if you want to support a dirty journal when
opening it or if your changes to the VMDK are not crash consistent
(You will have to implement BackMap and FreeBitmap though).

Hope this helps,
Sam


On Sun, Mar 8, 2020 at 6:52 PM Tirthankar Saha
<tirthankar.saha@gmail.com> wrote:
>
> Hi Sam,
>
> Can you please share any notes that you have regarding the structure of the SESparse journal? This will help in adding "read-write" support for SESparse snapshots.
>
> Thanks,
>
> Tirthankar

