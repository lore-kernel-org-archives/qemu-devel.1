Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F71C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7606E2077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GoasGwIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7606E2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiXR-00019p-Jp
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:53:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rjones@redhat.com>) id 1iuhJz-0004r5-4g
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:35:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rjones@redhat.com>) id 1iuhJv-0002Lm-On
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:35:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31228
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rjones@redhat.com>) id 1iuhJv-0002LI-IK
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579804511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=21k2w/bX7i0w5bWfAhJanCdlWncLqAQw8b0rDVEZnDA=;
 b=GoasGwINVfLCG1naKZq8sgsUt3eYv74/XNG0wuD71cfYJO/22BJu0NNt5FBcXiIrpFkJcO
 NE50KP5Ru2oqMTqMTpPsTxoKgp14FfX1bDALS0/NevtN+46sPisAV7Umf7k74d9nXz5Zq/
 /nUH8wB30oUyp/D4tHVtBQKg6z9skX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-6BSpRgGROeqRNZITX3MVSw-1; Thu, 23 Jan 2020 13:35:03 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57E071005510;
 Thu, 23 Jan 2020 18:35:02 +0000 (UTC)
Received: from localhost (ovpn-117-237.ams2.redhat.com [10.36.117.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E35AB7EF65;
 Thu, 23 Jan 2020 18:35:01 +0000 (UTC)
Date: Thu, 23 Jan 2020 18:35:00 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com,
 eblake@redhat.com, berrange@redhat.com, mkletzan@redhat.com,
 ptoscano@redhat.com
Subject: qemu-img convert vs writing another copy tool
Message-ID: <20200123183500.GA27166@redhat.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 6BSpRgGROeqRNZITX3MVSw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
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
Cc: marnold@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I guess some people are aware that virt-v2v, which is a tool which
converts guests from VMware to run on KVM, and some other
OpenStack-OpenStack migration tools we have, use "qemu-img convert" to
copy the data around.

Historically we've had bugs here.  The most recent was discussed in
the thread on this list called "Bug? qemu-img convert to preallocated
image makes it sparse"
(https://www.mail-archive.com/qemu-block@nongnu.org/msg60479.html)

We've been kicking around the idea of writing some alternate tool.  My
proposal would be a tool (not yet written, maybe it will never be
written) called nbdcp for copying between NBD servers and local files.
An outline manual page for this proposed tool is attached.

Some of the things which this tool might do which qemu-img convert
cannot do right now:

 - Hint that the target already contains zeroes.  It's almost always
   the case that we know this, but we cannot tell qemu.  This was the
   cause of a big performance regression last year.

 - Declare that we want the target to be either sparse or
   preallocated.  qemu-img convert can sort of do this in a
   round-about way (create the target in advance and use the -n
   option), but also it's broken at the moment.

 - NBD multi-conn.  In my tests this makes a really massive
   performance difference in certain situations.  Again, virt-v2v has
   a lot of information that we cannot pass to qemu: we know, for
   example, exactly if the server supports the feature, how many
   threads are available, in some situations even have information
   about the network and backing disks that the data will travel over
   / be stored on.

 - Machine-parsable progress bars.  You can, sort of, parse the
   progress bar from qemu-img convert, but it's not as easy as it
   could be.  In particular it would be nice if the format was treated
   as ABI, and if there was a way to have the tool write the progress
   bar info to a precreated file descriptor.

 - External block lists.  This is a rather obscure requirement, but
   it's necessary in the case where we can get the allocated block map
   from another source (eg. pyvmomi) and then want to use that with an
   NBD source that does not support extents (eg. nbdkit-ssh-plugin /
   libssh / sftp).  [Having said that, it may be possible to implement
   this as an nbdkit filter, so maybe this is not a blocking feature.]

One thing which qemu-img convert can do which nbdcp could not:

 - Read or write from qcow2 files.

So instead of splitting the ecosystem and writing a new tool that
doesn't do as much as qemu-img convert, I wonder what qemu developers
think about the above missing features?  For example, are they in
scope for qemu-img convert?

Rich.



----------------------------------------------------------------------

nbdcp(1)                            LIBNBD                            nbdcp=
(1)

NAME
       nbdcp - copy between NBD servers and local files

SYNOPSIS
        nbdcp [-a|--target-allocation allocated|sparse]
              [-b|--block-list <blocksfile>]
              [-m|--multi-conn <n>] [-M|--multi-conn-target <n>]
              [-p|--progress-bar] [-S|--sparse-detect <n>]
              [-T|--threads <n>] [-z|--target-is-zero]
              'nbd://...'|DISK.IMG 'nbd://...'|DISK.IMG

DESCRIPTION
       nbdcp is a utility that can copy quickly between NBD servers and loc=
al
       raw format files (or block devices).  It can copy:

       from NBD server to file (or block device)
           For example, this command copies from the NBD server listening o=
n
           port 10809 on "example.com" to a local file called disk.img:

            nbdcp nbd://example.com disk.img

       from file (or block device) to NBD server
           For example, this command copies from a local block device /dev/=
sda
           to the NBD server listening on Unix domain socket /tmp/socket:

            nbdcp /dev/sda 'nbd+unix:///?socket=3D/tmp/socket'

       from NBD server to NBD server
           For example this copies between two different exports on the sam=
e
           NBD server:

            nbdcp nbd://example.com/export1 nbd://example.com/export2

       This program cannot: copy from file to file (use cp(1) or dd(1)), co=
py
       to or from formats other than raw (use qemu-img(1) convert), or acce=
ss
       servers other than NBD servers (also use qemu-img(1)).

       NBD servers are specified by their URI, following the NBD URI standa=
rd
       at https://github.com/NetworkBlockDevice/nbd/blob/master/doc/uri.md

   Controlling sparseness or preallocation in the target
       The options -a (--target-allocation), -S (--sparse-detect) and -z
       (--target-is-zero) together control sparseness in the target file.

       By default nbdcp tries to both preserve sparseness from the source a=
nd
       will detect runs of allocated zeroes and turn them into sparseness. =
 To
       turn off detection of sparseness use "-S=A00".

       The -z option should be used if and only if you know that the target
       block device is zeroed already.  This allows an important optimizati=
on
       where nbdcp can skip zeroing or trimming parts of the disk that are
       already zero.

       The -a option is used to control the desired final preallocation sta=
te
       of the target.  The default is "-a=A0sparse" which makes the target =
as
       sparse as possible.  "-a=A0allocated" makes the target fully allocat=
ed.

OPTIONS
       --help
           Display brief command line help and exit.

       -a allocated
       --target-allocation=3Dallocated
           Make the target fully allocated.

       -a sparse
       --target-allocation=3Dsparse
           Make the target as sparse as possible.  This is the default.  Se=
e
           also "Controlling sparseness or preallocation in the target".

       -b BLOCKSFILE
       --block-list=3DBLOCKSFILE
           Load the list of extents from an external file.  nbdcp considers
           this to be the truth for source extents.  The file should contai=
n
           one record per line in the same format as nbdkit-sh-plugin(1), i=
e:

            offset length type

           with "offset" and "length" in bytes, and the "type" field being =
a
           comma-separated list of the words "hole" and "zero".  For exampl=
e:

            0  1M
            1M 9M  hole,zero

           Any parts of the source which don't have descriptions are assume=
d
           to be of type "hole,zero".

       -m N
       --multi-conn=3DN
           Enable NBD multi-conn with up to "N" connections.  Only some NBD
           servers support this but it can greatly improve performance.

           The default is to enable multi-conn if we detect that the server
           supports it, with up to 4 connections.

       -M N
       --multi-conn-target=3DN
           If you are copying between NBD servers, use -m to control the
           multi-conn setting for the source server, and this option (-M) t=
o
           control the multi-conn setting for the target server.

       -p
       --progress-bar
           Display a progress bar during copying.

       -p machine:FD
       --progress-bar=3Dmachine:FD
           Write a machine-readable progress bar to file descriptor "FD".
           This progress bar prints lines with the format "COPIED/TOTAL"
           (where "COPIED" and "TOTAL" are 64 bit unsigned integers).

       -S 0
       --sparse-detect=3D0
           Turn off sparseness detection.

       -S N
       --sparse-detect=3DN
           Detect runs of zero bytes of at least size "N" bytes and turn th=
em
           into sparse blocks on the target (if "-a=A0sparse" is used).  Th=
is is
           the default, with a 512 byte block size.

       -T N
       --threads N
           Use at most "N" threads when copying.  Usually more threads lead=
s
           to better performance, up to the limit of the number of cores on
           your machine and the parallelism of the underlying disk or netwo=
rk.
           The default is to use the number of online processors.

       -z
       --target-is-zero
           Declare that the target block device contains only zero bytes (o=
r
           sparseness that reads back as zeroes).  You must only use this
           option if you are sure that this is true, since it means that nb=
dcp
           will enable an optimization where it skips zeroing parts of the
           disk that are zero on the source.

       -V
       --version
           Display the package name and version and exit.

SEE ALSO
       qemu-img(1), libnbd(3), nbdsh(1).

AUTHORS
       Richard W.M. Jones

COPYRIGHT
       Copyright (C) 2020 Red Hat Inc.

LICENSE
       This library is free software; you can redistribute it and/or modify=
 it
       under the terms of the GNU Lesser General Public License as publishe=
d
       by the Free Software Foundation; either version 2 of the License, or
       (at your option) any later version.

       This library is distributed in the hope that it will be useful, but
       WITHOUT ANY WARRANTY; without even the implied warranty of
       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
       Lesser General Public License for more details.

       You should have received a copy of the GNU Lesser General Public
       License along with this library; if not, write to the Free Software
       Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
       02110-1301 USA

libnbd-1.3.1                      2020-01-23                          nbdcp=
(1)


--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjon=
es
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW


