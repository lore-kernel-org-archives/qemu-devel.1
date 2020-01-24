Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C2EC35242
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E04120709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGfg1E2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E04120709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvi1-0001dL-Ru
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 04:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rjones@redhat.com>) id 1iuvh5-0000qR-OM
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rjones@redhat.com>) id 1iuvh3-0000cY-Iu
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:56:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47815
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rjones@redhat.com>) id 1iuvh3-0000bt-Eb
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579859761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+vQFqpr+xBkrcDUeVlHqCtrHpJGluniM6RkatB9+Vo=;
 b=JGfg1E2cRzWqJZ0XFAGlHQDa8OV3gYV3m1axcd3NejP5ejE46MPcS5Gb24T5oSRCFkheJX
 s5jtQV6JrS1vFzNq7RNtpOmE+2UiSmixT0NYWbR1ylnLQy62SVCZ4KC6ikpBEeURJS/ctS
 2Gp2q0rUrEYpaVS/HzZUUq2LDvgSJ2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-Ka2crGZEPmmHcSQYsICe9w-1; Fri, 24 Jan 2020 04:55:57 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72FAD800D48;
 Fri, 24 Jan 2020 09:55:56 +0000 (UTC)
Received: from localhost (ovpn-117-237.ams2.redhat.com [10.36.117.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D8F985784;
 Fri, 24 Jan 2020 09:55:55 +0000 (UTC)
Date: Fri, 24 Jan 2020 09:55:55 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: qemu-img convert vs writing another copy tool
Message-ID: <20200124095555.GR3888@redhat.com>
References: <20200123183500.GA27166@redhat.com>
 <bbcbb67f-74ad-b491-e988-09a380ac8068@redhat.com>
MIME-Version: 1.0
In-Reply-To: <bbcbb67f-74ad-b491-e988-09a380ac8068@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Ka2crGZEPmmHcSQYsICe9w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: berrange@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 ptoscano@redhat.com, marnold@redhat.com, mkletzan@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 23, 2020 at 01:21:28PM -0600, Eric Blake wrote:
> On 1/23/20 12:35 PM, Richard W.M. Jones wrote:
> >  - Hint that the target already contains zeroes.  It's almost always
> >    the case that we know this, but we cannot tell qemu.  This was the
> >    cause of a big performance regression last year.
>=20
> This has just recently been proposed:
> https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg03617.html

Oh indeed, this is good.

> >  - NBD multi-conn.  In my tests this makes a really massive
> >    performance difference in certain situations.  Again, virt-v2v has
> >    a lot of information that we cannot pass to qemu: we know, for
> >    example, exactly if the server supports the feature, how many
> >    threads are available, in some situations even have information
> >    about the network and backing disks that the data will travel over
> >    / be stored on.
>=20
> Multi-conn for reading the source allows better parallelism.
> Multi-conn for writing is a bit trickier - it should be safe if the
> different connections are only touching distinct segments of the
> export (no overlaps), but as qemu does not advertise multiconn in
> such situations, you may still need a command-line switch to force
> multiple writers in spite of the server not advertising it.  Here,
> I'm not aware of anyone with patches underway, but I also think it
> would be a good ground for exploring.

But in the qemu-img convert case specifically, multi-conn should
be safe for writing?

One additional problem with multi-conn is that NBD servers only
advertise that the feature is present, not the best possible degree of
parallelism to use.  (It's possible that the server cannot or doesn't
know this.)

> >  - External block lists.  This is a rather obscure requirement, but
> >    it's necessary in the case where we can get the allocated block map
> >    from another source (eg. pyvmomi) and then want to use that with an
> >    NBD source that does not support extents (eg. nbdkit-ssh-plugin /
> >    libssh / sftp).  [Having said that, it may be possible to implement
> >    this as an nbdkit filter, so maybe this is not a blocking feature.]
>=20
> How are you intending to use this? I'm guessing you have some way of
> feeding in information to qemu-img of which portions of the source
> image you want to copy, and ignore remaining portions.

I should say first that I've nearly finished an nbdkit filter
implementation of this, so feel free to ignore this for qemu.

The background to this feature is that some block device backends do
not have support for determining extents / disk block allocation
status.  The one that is most frequently used is ssh (sftp).  Note
that adding this support to sftp, while possible, doesn't really solve
the problem because the proprietary hypervisors we are pulling from
don't use recent SSH servers.

So copying from SSH is slow because you have no choice except to read
vast amounts of zeroes or deleted data.  (This doesn't affect virt-v2v
because it has another strategy to avoid this, but it does affect
other scenarios such as "warm" conversions and any migration that
doesn't involve using virt-v2v.)

However you can get the extent information by other means.  For VMware
you can use VMOMI to read this.  Or you can ssh in and run commands
like xfs_bmap.

So in theory at least it's possible to assemble the required data
from multiple sources and thus avoid wasteful copying.

With nbdkit you'll be able to do something like:

  # fetch the extents list over VMOMI > extents.txt, then
  nbdkit -U /tmp/sock --filter=3Dextentlist ssh \
                   host=3Dserver /vmfs/.../file-flat.vmdk \
                   extentlist=3Dextents.txt
  qemu-img convert nbd:unix:/tmp/sock ...

> Note that it IS already possible to use qemu's copy-on-read feature
> as a way to copy only a subset of a source file over to a
> destination file. When demonstrating incremental backup, I wrote
> this shell function:
>=20
> copyif() {
> if test $# -lt 2 || test $# -gt 3; then
>   echo 'usage: copyif src dst [bitmap]'
>   return 1
> fi
> if test -z "$3"; then
>   map_from=3D"-f raw nbd://localhost:10809/$1"
>   state=3Dtrue
> else
>   map_from=3D"--image-opts driver=3Dnbd,export=3D$1,server.type=3Dinet"
>   map_from+=3D",server.host=3Dlocalhost,server.port=3D10809"
>   map_from+=3D",x-dirty-bitmap=3Dqemu:dirty-bitmap:$3"
>   state=3Dfalse
> fi
> $qemu_img info -f raw nbd://localhost:10809/$1 || return
> $qemu_img info -f qcow2 $2 || return
> ret=3D0
> $qemu_img rebase -u -f qcow2 -F raw -b nbd://localhost:10809/$1 $2
> while read line; do
>   [[ $line =3D~ .*start.:.([0-9]*).*length.:.([0-9]*).*data.:.$state.*
> ]] || continue
>   start=3D${BASH_REMATCH[1]} len=3D${BASH_REMATCH[2]}
>   echo
>   echo " $start $len:"
>   qemu-io -C -c "r $start $len" -f qcow2 $2
> done < <($qemu_img map --output=3Djson $map_from)
> $qemu_img rebase -u -f qcow2 -b '' $2
> if test $ret =3D 0; then echo 'Success!'; fi
> return $ret
> }
>=20
> The key lines here are 'qemu-io -C -c "r $start $len" -f qcow2 $2',
> which is performed in a loop to read just targetted portions of the
> destination qcow2 file with copy-on-read set to pull in that portion
> from its backing file, and '<($qemu_img map --output=3Djson
> $map_from)' which was used to derive the extent map driving which
> portions of the file to read.
>=20
> We also have 'qemu-img dd' that can copy subsets of a file, although
> it is not currently the ideal interface, and probably needs to be
> enhanced (I have a branch where I had tried working on patches for
> it, but where the feedback was that we want the improvements to be
> more generic, or even teach 'qemu-img convert' to support offsets
> the way 'qemu-img dd' tries to; I'd need to revisit that branch...)
>=20
> >
> >One thing which qemu-img convert can do which nbdcp could not:
> >
> >  - Read or write from qcow2 files.
>=20
> Although you could still couple things together: nbdcp for new
> features plus qemu-nbd to drive an NBD wrapper around qcow2 (as
> source or as destination).
>=20
> >
> >So instead of splitting the ecosystem and writing a new tool that
> >doesn't do as much as qemu-img convert, I wonder what qemu developers
> >think about the above missing features?  For example, are they in
> >scope for qemu-img convert?
> >
>=20
> I could see all of these being viable additions to qemu-img, but
> also wonder if writing nbdcp would get those features available in a
> faster manner.
>=20
>=20
> >
> >SYNOPSIS
> >         nbdcp [-a|--target-allocation allocated|sparse]
> >               [-b|--block-list <blocksfile>]
>=20
> These make sense for any qemu-img format.
>=20
> >               [-m|--multi-conn <n>] [-M|--multi-conn-target <n>]
>=20
> These might make more sense as tunables for how to set up NBD client
> (destination) or server (source), rather than directly as qemu-img
> options.  That is, I could imagine that we'd use qemu-img
> --image-format, and then expose new blockdev-style knobs for setting
> up the NBD endpoint to enable multiconn usage of that endpoint.

Yes this makes sense.

> >               [-p|--progress-bar] [-S|--sparse-detect <n>]
> >               [-T|--threads <n>] [-z|--target-is-zero]
> >               'nbd://...'|DISK.IMG 'nbd://...'|DISK.IMG
>=20
> And these options also seem like they are useful to qemu-img proper.
>=20
> >
> >        This program cannot: copy from file to file (use cp(1) or dd(1))=
, copy
> >        to or from formats other than raw (use qemu-img(1) convert), or =
access
> >        servers other than NBD servers (also use qemu-img(1)).
>=20
> Again, depending on how we want to mix-and-match things, using
> qemu-nbd to create the NBD endpoint for the nbdcp source or
> destination may be worthwhile (which is different than directly
> using qemu-img); we'd want some decent examples of building such
> chains between tools.  Or it could help us decide whether we can cut
> out some overhead by consolidating typical uses into one tool rather
> than requiring convoluted chains.
>=20
>=20
> >
> >        -b BLOCKSFILE
> >        --block-list=3DBLOCKSFILE
> >            Load the list of extents from an external file.  nbdcp consi=
ders
> >            this to be the truth for source extents.  The file should co=
ntain
> >            one record per line in the same format as nbdkit-sh-plugin(1=
), ie:
> >
> >             offset length type
> >
> >            with "offset" and "length" in bytes, and the "type" field be=
ing a
> >            comma-separated list of the words "hole" and "zero".  For ex=
ample:
> >
> >             0  1M
> >             1M 9M  hole,zero
>=20
> Could we also teach this to parse 'qemu-img map --output=3Djson'
> format? And/or add 'qemu-img map --output=3DXYZ' (different from the
> current --output=3Dhuman') that gives sufficient information?  (Note:
> --output=3Dhuman is NOT suitable for extent lists - it intentionally
> outputs only the data portions, and in so doing coalesces 'hole' and
> 'hole,zero' segments to be indistinguishable).

If qemu-img doesn't have the data (we have to get it from
another source), is the output of qemu-img map relevant?

Rich.

> >
> >        -p
> >        --progress-bar
> >            Display a progress bar during copying.
> >
> >        -p machine:FD
> >        --progress-bar=3Dmachine:FD
> >            Write a machine-readable progress bar to file descriptor "FD=
".
> >            This progress bar prints lines with the format "COPIED/TOTAL=
"
> >            (where "COPIED" and "TOTAL" are 64 bit unsigned integers).
>=20
> Supporting optional arguments to long options is okay, but
> supporting optional arguments to short options gets tricky when
> using getopt.  I would recommend two separate options, '-p' with no
> argument as shorthand for progress to stderr, and '-P description'
> with mandatory option for where to send progress, rather than trying
> to let '-p' have optional argument.
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjon=
es
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html


