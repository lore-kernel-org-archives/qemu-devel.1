Received: from eggs.gnu.org ([2001:4830:134:3::10]:37952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eFGz8-0003np-7R
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:01:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eFGz2-0002w2-At
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:01:26 -0500
Date: Thu, 16 Nov 2017 10:01:03 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171116100102.GE2450@redhat.com>
References: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
	<c2ecae32-f999-9f1e-46a6-37cdab2a62e3@redhat.com>
	<CAJH6TXhBAaBE9gBSxksWZqNywWmencRaGyeY-oN3jbKdgUettQ@mail.gmail.com>
	<0e6cc220-814a-17fd-4fd7-7b0665d34e81@redhat.com>
	<CAJH6TXh2v-F=yqxQbUUawk_Ctq-sgFefGp1XvMsC=syX_5jEqA@mail.gmail.com>
	<30b54865-2255-d13d-a054-afcf5bbd06b2@redhat.com>
	<20171115202440.GJ19514@redhat.com>
	<7b11bb2b-b93d-e8ff-f396-703c93549d0d@redhat.com>
	<20171115202938.GN2787@redhat.com>
	<CAJH6TXiPuLu62-+o2+PrUGpstrks_5pLotFEe1bAOmsbn20otw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <CAJH6TXiPuLu62-+o2+PrUGpstrks_5pLotFEe1bAOmsbn20otw@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Libguestfs]  [qemu-img] support for XVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: libguestfs <libguestfs@redhat.com>, qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's my solution, as a nbdkit plugin written in Perl.

As with Max's solution I don't bother to parse the virtual size out of
the XML file, so you need to specify that on the command line
otherwise the disk will be truncated to the largest extent stored in
the file.  Also the =E2=80=98.xva=E2=80=99 file must not be compressed.

  $ nbdkit perl script=3D./xva-reader.pl file=3D./debian8cloud.xva size=3D=
4294967296

  $ guestfish --ro --format=3Draw -a nbd://localhost -i
 =20
  Welcome to guestfish, the guest filesystem shell for
  editing virtual machine filesystems and disk images.
 =20
  Type: 'help' for help on commands
        'man' to read the manual
        'quit' to quit the shell
 =20
  Operating system: 8.2
  /dev/sda1 mounted on /
 =20
  ><fs> ll /
  total 100
  drwxr-xr-x 22 root root  4096 Jan  8  2016 .
  drwxr-xr-x 19 root root  4096 Nov 16 09:50 ..
  drwxrwxr-x  2 root root  4096 Jan  8  2016 bin
  drwxr-xr-x  3 root root  4096 Jan  8  2016 boot
  drwxr-xr-x  4 root root  4096 Jan  8  2016 dev
  drwxr-xr-x 87 root root  4096 Jan  8  2016 etc
  drwxr-xr-x  3 root root  4096 Jan  8  2016 home
  lrwxrwxrwx  1 root root    31 Jan  8  2016 initrd.img -> /boot/initrd.i=
mg-3.16.0-4-amd64
  drwxr-xr-x 14 root root  4096 Jan  8  2016 lib
  drwxr-xr-x  2 root root  4096 Jan  8  2016 lib64
  drwx------  2 root root 16384 Jan  8  2016 lost+found
  drwxr-xr-x  3 root root  4096 Jan  8  2016 media
  drwxr-xr-x  2 root root  4096 Jan  8  2016 mnt
  drwxr-xr-x  2 root root  4096 Jan  8  2016 opt
  drwxr-xr-x  2 root root  4096 May  4  2015 proc
  drwx------  2 root root  4096 Jan  8  2016 root
  drwxr-xr-x  2 root root  4096 Jan  8  2016 run
  drwxr-xr-x  2 root root  4096 Jan  8  2016 sbin
  drwxr-xr-x  2 root root  4096 Jan  8  2016 srv
  drwxr-xr-x  2 root root  4096 Apr  6  2015 sys
  drwxrwxrwt  7 root root  4096 Jan  8  2016 tmp
  drwxr-xr-x 10 root root  4096 Jan  8  2016 usr
  drwxr-xr-x 11 root root  4096 Jan  8  2016 var
  lrwxrwxrwx  1 root root    27 Jan  8  2016 vmlinuz -> boot/vmlinuz-3.16=
.0-4-amd64

I even managed to boot the Debian 8 guest from the sample .xva file:

  $ qemu-system-x86_64 -cpu host -machine accel=3Dkvm:tcg -m 2048 -drive =
file=3Dnbd:localhost:10809,format=3Draw,if=3Dvirtio,snapshot=3Don

although it was pretty slow ...

As mentioned before you can use this to do a qemu-img convert using
captive nbdkit:

  $ nbdkit -U - \
      perl script=3D./xva-reader.pl file=3D./debian8cloud.xva size=3D4294=
967296 \
      --run 'qemu-img convert -f raw $nbd -O qcow2 /var/tmp/output.qcow2 =
-p'

HTH,

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html

--7AUc2qLy4jB3hD7Z
Content-Type: application/x-perl
Content-Disposition: attachment; filename="xva-reader.pl"
Content-Transfer-Encoding: quoted-printable

use strict;=0A=0Amy %config =3D ();=0Amy %block =3D ();=0A=0A# XXX Should p=
arse the virtual size from size from the XML document.=0A# Instead we estim=
ate the size here, and the user can override=0A# it by setting the optional=
 size=3D... parameter.=0Amy $estimated_size;=0A=0A# Does XVA define this?  =
We might need to read it from the file=0A# somehow.=0Amy $block_size =3D 10=
48576;=0A=0Asub config=0A{=0A    my $key =3D shift;=0A    my $value =3D shi=
ft;=0A    $config{$key} =3D $value;=0A}=0A=0Asub config_complete=0A{=0A    =
die "no file=3D... parameter given" unless exists $config{file};=0A=0A    m=
y $file =3D $config{file};=0A    $estimated_size =3D 0;=0A=0A    # Parse th=
e XVA file for offsets.=0A    # XXX Does not work if the XVA contains multi=
ple disk images.  We=0A    # should parse the 'Ref:NN' field too.=0A    ope=
n FILE, "tar tRvf $file |" or die "$file: $!";=0A    while (<FILE>) {=0A   =
     if (m{^block (\d+): \S+ \d+/\d+\s+(\d+)\s.*/0*(\d+)$}) {=0A           =
 my $offset =3D $1;    # block offset in tar file=0A            my $size =
=3D $2;      # size in bytes in tar file=0A            my $filename =3D $3;=
  # filename in tar file, without leading 0s=0A            my $byte_offset =
=3D (1 + $offset) * 512; # byte offset in tar file=0A            $block{$fi=
lename} =3D { size =3D> $size, offset =3D> $byte_offset };=0A            #p=
rintf ("%s %d %d\n", $filename, $byte_offset, $size);=0A=0A            if (=
$byte_offset + $size > $estimated_size) {=0A                $estimated_size=
 =3D $byte_offset + $size;=0A            }=0A        }=0A    }=0A    close =
FILE;=0A}=0A=0Asub open=0A{=0A    my $readonly =3D shift;=0A    my $file =
=3D $config{file};=0A    open (my $fh, "<", $file) or die "$file: $!";=0A  =
  my $h =3D { fh =3D> $fh };=0A    return $h;=0A}=0A=0Asub close=0A{=0A    =
my $h =3D shift;=0A    close ($h->{fh});=0A}=0A=0Asub get_size=0A{=0A    my=
 $h =3D shift;=0A    my $i =3D $estimated_size;=0A    # Allow user to overr=
ide the estimate by setting size=3D parameter.=0A    $i =3D $config{size} i=
f exists $config{size};=0A    return $i;=0A}=0A=0Asub read_block=0A{=0A    =
my $h =3D shift;=0A    my $bnum =3D shift;=0A    my $offset =3D $block{$bnu=
m}{offset};=0A    my $size =3D $block{$bnum}{size};=0A    seek ($h->{fh}, $=
offset, 0);=0A    my $ret =3D "";=0A    my $i =3D 0;=0A    while ($size > 0=
) {=0A        my $n =3D read ($h->{fh}, $ret, $size, $i);=0A        if ($n =
=3D=3D 0) {=0A            die "unexpected end of file: block number $bnum (=
offset $offset, size $size)"=0A        }=0A        $i +=3D $n;=0A        $s=
ize -=3D $n;=0A    }=0A    return $ret;=0A}=0A=0Asub pread=0A{=0A    my $h =
=3D shift;=0A    my $count =3D shift;=0A    my $offset =3D shift;=0A=0A    =
my $buf =3D "";=0A    my $bufi =3D 0;=0A=0A    while ($count > 0) {=0A     =
   # Which block, if any, contains $offset?=0A        my $bnum =3D int ($of=
fset / $block_size);=0A        my $boffs =3D $offset % $block_size;=0A     =
   #print "offset =3D $offset, bnum =3D $bnum, boffs =3D $boffs\n";=0A=0A  =
      # n =3D number of bytes that can be read from this block.=0A        m=
y $n =3D $block_size - $boffs;=0A        $n =3D $count if $n > $count;=0A=
=0A        if (exists $block{$bnum}) {=0A            my $bdata =3D read_blo=
ck ($h, $bnum);=0A            $buf .=3D substr $bdata, $boffs, $n;=0A      =
  }=0A        else {=0A            # Virtual zero block.=0A            $buf=
 .=3D "\0" x $n;=0A        }=0A=0A        $count -=3D $n;=0A    }=0A=0A    =
return $buf;=0A}=0A
--7AUc2qLy4jB3hD7Z--
