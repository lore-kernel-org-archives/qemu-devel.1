Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70C1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 977052077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSP8HHMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977052077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuigb-0002Yc-Ot
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 15:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iui2p-0001a9-C6
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:21:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iui2n-0004EP-Cf
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:21:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59564
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iui2n-0004CD-7F
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579807292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1gVAWVgQpwkEmeG33X1+kxDV6bm93Ydg9v0gnYb134w=;
 b=HSP8HHMINrA5sWMEk9CYKkqBjawmksHVtRI+ZRgoedSbpv/oEYzTfzyzGlyxOnbhgfpGF2
 c7MS7MRcE35gIba30B3Igb0NlhgeDjrTgbsOMukIFZuT7azgNwxTSnz6QW+Q2Oz/9VvIMs
 O8R6hG2Gf38GDsoDfl1C+1stVnZVvFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-kaUPUglqO0KyBPGyvQb2-w-1; Thu, 23 Jan 2020 14:21:31 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAD78DB20;
 Thu, 23 Jan 2020 19:21:29 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F30184BBD;
 Thu, 23 Jan 2020 19:21:28 +0000 (UTC)
Subject: Re: qemu-img convert vs writing another copy tool
To: "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com, berrange@redhat.com,
 mkletzan@redhat.com, ptoscano@redhat.com
References: <20200123183500.GA27166@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <bbcbb67f-74ad-b491-e988-09a380ac8068@redhat.com>
Date: Thu, 23 Jan 2020 13:21:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123183500.GA27166@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: kaUPUglqO0KyBPGyvQb2-w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: marnold@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/23/20 12:35 PM, Richard W.M. Jones wrote:
> I guess some people are aware that virt-v2v, which is a tool which
> converts guests from VMware to run on KVM, and some other
> OpenStack-OpenStack migration tools we have, use "qemu-img convert" to
> copy the data around.
> 
> Historically we've had bugs here.  The most recent was discussed in
> the thread on this list called "Bug? qemu-img convert to preallocated
> image makes it sparse"
> (https://www.mail-archive.com/qemu-block@nongnu.org/msg60479.html)
> 
> We've been kicking around the idea of writing some alternate tool.  My
> proposal would be a tool (not yet written, maybe it will never be
> written) called nbdcp for copying between NBD servers and local files.
> An outline manual page for this proposed tool is attached.
> 
> Some of the things which this tool might do which qemu-img convert
> cannot do right now:
> 
>   - Hint that the target already contains zeroes.  It's almost always
>     the case that we know this, but we cannot tell qemu.  This was the
>     cause of a big performance regression last year.

This has just recently been proposed:
https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg03617.html

I'm also working on a patch that I will post soon that extends the NBD 
protocol to advertise this information (it will help the situation where 
the destination is NBD, but as that requires a new enough server to 
advertise the information, having the feature as a command-line option 
allows the same speedup even without the server supporting the extension).

> 
>   - Declare that we want the target to be either sparse or
>     preallocated.  qemu-img convert can sort of do this in a
>     round-about way (create the target in advance and use the -n
>     option), but also it's broken at the moment.
> 
>   - NBD multi-conn.  In my tests this makes a really massive
>     performance difference in certain situations.  Again, virt-v2v has
>     a lot of information that we cannot pass to qemu: we know, for
>     example, exactly if the server supports the feature, how many
>     threads are available, in some situations even have information
>     about the network and backing disks that the data will travel over
>     / be stored on.

Multi-conn for reading the source allows better parallelism.  Multi-conn 
for writing is a bit trickier - it should be safe if the different 
connections are only touching distinct segments of the export (no 
overlaps), but as qemu does not advertise multiconn in such situations, 
you may still need a command-line switch to force multiple writers in 
spite of the server not advertising it.  Here, I'm not aware of anyone 
with patches underway, but I also think it would be a good ground for 
exploring.

> 
>   - Machine-parsable progress bars.  You can, sort of, parse the
>     progress bar from qemu-img convert, but it's not as easy as it
>     could be.  In particular it would be nice if the format was treated
>     as ABI, and if there was a way to have the tool write the progress
>     bar info to a precreated file descriptor.

Would be nice, but I'm not aware of anyone currently planning to add it.

> 
>   - External block lists.  This is a rather obscure requirement, but
>     it's necessary in the case where we can get the allocated block map
>     from another source (eg. pyvmomi) and then want to use that with an
>     NBD source that does not support extents (eg. nbdkit-ssh-plugin /
>     libssh / sftp).  [Having said that, it may be possible to implement
>     this as an nbdkit filter, so maybe this is not a blocking feature.]

How are you intending to use this? I'm guessing you have some way of 
feeding in information to qemu-img of which portions of the source image 
you want to copy, and ignore remaining portions.

Note that it IS already possible to use qemu's copy-on-read feature as a 
way to copy only a subset of a source file over to a destination file. 
When demonstrating incremental backup, I wrote this shell function:

copyif() {
if test $# -lt 2 || test $# -gt 3; then
   echo 'usage: copyif src dst [bitmap]'
   return 1
fi
if test -z "$3"; then
   map_from="-f raw nbd://localhost:10809/$1"
   state=true
else
   map_from="--image-opts driver=nbd,export=$1,server.type=inet"
   map_from+=",server.host=localhost,server.port=10809"
   map_from+=",x-dirty-bitmap=qemu:dirty-bitmap:$3"
   state=false
fi
$qemu_img info -f raw nbd://localhost:10809/$1 || return
$qemu_img info -f qcow2 $2 || return
ret=0
$qemu_img rebase -u -f qcow2 -F raw -b nbd://localhost:10809/$1 $2
while read line; do
   [[ $line =~ .*start.:.([0-9]*).*length.:.([0-9]*).*data.:.$state.* ]] 
|| continue
   start=${BASH_REMATCH[1]} len=${BASH_REMATCH[2]}
   echo
   echo " $start $len:"
   qemu-io -C -c "r $start $len" -f qcow2 $2
done < <($qemu_img map --output=json $map_from)
$qemu_img rebase -u -f qcow2 -b '' $2
if test $ret = 0; then echo 'Success!'; fi
return $ret
}

The key lines here are 'qemu-io -C -c "r $start $len" -f qcow2 $2', 
which is performed in a loop to read just targetted portions of the 
destination qcow2 file with copy-on-read set to pull in that portion 
from its backing file, and '<($qemu_img map --output=json $map_from)' 
which was used to derive the extent map driving which portions of the 
file to read.

We also have 'qemu-img dd' that can copy subsets of a file, although it 
is not currently the ideal interface, and probably needs to be enhanced 
(I have a branch where I had tried working on patches for it, but where 
the feedback was that we want the improvements to be more generic, or 
even teach 'qemu-img convert' to support offsets the way 'qemu-img dd' 
tries to; I'd need to revisit that branch...)

> 
> One thing which qemu-img convert can do which nbdcp could not:
> 
>   - Read or write from qcow2 files.

Although you could still couple things together: nbdcp for new features 
plus qemu-nbd to drive an NBD wrapper around qcow2 (as source or as 
destination).

> 
> So instead of splitting the ecosystem and writing a new tool that
> doesn't do as much as qemu-img convert, I wonder what qemu developers
> think about the above missing features?  For example, are they in
> scope for qemu-img convert?
> 

I could see all of these being viable additions to qemu-img, but also 
wonder if writing nbdcp would get those features available in a faster 
manner.


> 
> SYNOPSIS
>          nbdcp [-a|--target-allocation allocated|sparse]
>                [-b|--block-list <blocksfile>]

These make sense for any qemu-img format.

>                [-m|--multi-conn <n>] [-M|--multi-conn-target <n>]

These might make more sense as tunables for how to set up NBD client 
(destination) or server (source), rather than directly as qemu-img 
options.  That is, I could imagine that we'd use qemu-img 
--image-format, and then expose new blockdev-style knobs for setting up 
the NBD endpoint to enable multiconn usage of that endpoint.

>                [-p|--progress-bar] [-S|--sparse-detect <n>]
>                [-T|--threads <n>] [-z|--target-is-zero]
>                'nbd://...'|DISK.IMG 'nbd://...'|DISK.IMG

And these options also seem like they are useful to qemu-img proper.

> 
>         This program cannot: copy from file to file (use cp(1) or dd(1)), copy
>         to or from formats other than raw (use qemu-img(1) convert), or access
>         servers other than NBD servers (also use qemu-img(1)).

Again, depending on how we want to mix-and-match things, using qemu-nbd 
to create the NBD endpoint for the nbdcp source or destination may be 
worthwhile (which is different than directly using qemu-img); we'd want 
some decent examples of building such chains between tools.  Or it could 
help us decide whether we can cut out some overhead by consolidating 
typical uses into one tool rather than requiring convoluted chains.


> 
>         -b BLOCKSFILE
>         --block-list=BLOCKSFILE
>             Load the list of extents from an external file.  nbdcp considers
>             this to be the truth for source extents.  The file should contain
>             one record per line in the same format as nbdkit-sh-plugin(1), ie:
> 
>              offset length type
> 
>             with "offset" and "length" in bytes, and the "type" field being a
>             comma-separated list of the words "hole" and "zero".  For example:
> 
>              0  1M
>              1M 9M  hole,zero

Could we also teach this to parse 'qemu-img map --output=json' format? 
And/or add 'qemu-img map --output=XYZ' (different from the current 
--output=human') that gives sufficient information?  (Note: 
--output=human is NOT suitable for extent lists - it intentionally 
outputs only the data portions, and in so doing coalesces 'hole' and 
'hole,zero' segments to be indistinguishable).

> 
>         -p
>         --progress-bar
>             Display a progress bar during copying.
> 
>         -p machine:FD
>         --progress-bar=machine:FD
>             Write a machine-readable progress bar to file descriptor "FD".
>             This progress bar prints lines with the format "COPIED/TOTAL"
>             (where "COPIED" and "TOTAL" are 64 bit unsigned integers).

Supporting optional arguments to long options is okay, but supporting 
optional arguments to short options gets tricky when using getopt.  I 
would recommend two separate options, '-p' with no argument as shorthand 
for progress to stderr, and '-P description' with mandatory option for 
where to send progress, rather than trying to let '-p' have optional 
argument.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


