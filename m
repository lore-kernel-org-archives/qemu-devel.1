Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033A7C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49E0C20708
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPn/+5pY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E0C20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFw8d-0005Rv-6x
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFw7v-0004sd-Jv
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 05:10:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49585
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFw7t-0003Hq-A8
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 05:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599642647;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZoaBmQuq3e1glWPV4O7HDAB04OT4Z6WPDaR+P4B/4Nk=;
 b=FPn/+5pYlnNuXL4H6fV/HYRfAEY8aYLm1y/bLmjFrtOuHN9ncO0XhbIo4BExocxhuC8kO/
 Ntm+l3fC1D56a/ZErXy2rpN8fPesfsXL/hdTLbj7xfXiXrJZ2dR4IhfVmC0hsn5URdpS2i
 XbRnA8nzly7Mjf9lmQ5gpbS4XYmiqk8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-cOgMueI5NX6ftvv3qcJfnQ-1; Wed, 09 Sep 2020 05:10:44 -0400
X-MC-Unique: cOgMueI5NX6ftvv3qcJfnQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4622F18BA285;
 Wed,  9 Sep 2020 09:10:43 +0000 (UTC)
Received: from redhat.com (ovpn-115-8.ams2.redhat.com [10.36.115.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78E8C838AE;
 Wed,  9 Sep 2020 09:10:37 +0000 (UTC)
Date: Wed, 9 Sep 2020 10:10:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH 1/5] hw/smbios: support loading OEM strings values from a
 file
Message-ID: <20200909091034.GL1011023@redhat.com>
References: <20200908165438.1008942-1-berrange@redhat.com>
 <20200908165438.1008942-2-berrange@redhat.com>
 <c7ecee55-64a3-5a46-26d9-6a1cc4c7889c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c7ecee55-64a3-5a46-26d9-6a1cc4c7889c@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Sep 09, 2020 at 10:18:47AM +0200, Laszlo Ersek wrote:
> On 09/08/20 18:54, Daniel P. Berrangé wrote:
> > Some applications want to pass quite large values for the OEM strings
> > entries. Rather than having huge strings on the command line, it would
> > be better to load them from a file, as supported with -fw_cfg.
> > 
> > This introduces the "valuefile" parameter allowing for:
> > 
> >   $ echo -n "thisthing" > mydata.txt
> >   $ qemu-system-x86_64 \
> >     -smbios type=11,value=something \
> >     -smbios type=11,valuefile=mydata.txt \
> >     -smbios type=11,value=somemore \
> >     ...other args...
> > 
> > Now in the guest
> > 
> > $ dmidecide -t 11
> > Getting SMBIOS data from sysfs.
> > SMBIOS 2.8 present.
> > 
> > Handle 0x0E00, DMI type 11, 5 bytes
> > OEM Strings
> > 	String 1: something
> > 	String 2: thisthing
> > 	String 3: somemore
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  hw/smbios/smbios.c | 72 +++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 59 insertions(+), 13 deletions(-)
> 
> (gearing up to test this / look into the edk2 problem, just one question
> in passing: could we / would we simplify this with g_file_get_contents()?)

BTW, to test this, I'm doing the following.

See the attached 'make-tiny-initrd.py' script. It expects "busybox" on
the host OS and builds a tiny initrd containing busybox.

It can optionally copy in arbitrary other commands, and shared libraries
they link to.  By default it will launch an interactive shell in the
guest, but you can tell it to run a specific command, after which it
will poweroff.

I want to run dmidecode, so I'm using

 $ make-tiny-image.py --run "dmidecode" dmidecode

which both copies dmidecode into the initrd, and also runs it by
default.

It creates 'tiny-initrd.img'

Then I simply boot the host OS kernel using this initrd.


  ./build/qemu-system-x86_64  \
      -kernel /boot/vmlinuz-5.7.14-200.fc32.x86_64 \
      -initrd tiny-initrd.img
      -append 'console=ttyS0'
      -m 1000
      -serial stdio
      -display none
      -blockdev '{"driver":"file","filename":"/usr/share/OVMF/OVMF_CODE.fd","node-name":"libvirt-pflash0-storage","auto-read-only":true,"discard":"unmap"}'
      -blockdev '{"node-name":"libvirt-pflash0-format","read-only":true,"driver":"raw","file":"libvirt-pflash0-storage"}'
      -blockdev '{"driver":"file","filename":"/home/berrange/src/virt/qemu/OVMF_VARS.fd","node-name":"libvirt-pflash1-storage","auto-read-only":true,"discard":"unmap"}'
      -blockdev '{"node-name":"libvirt-pflash1-format","read-only":false,"driver":"raw","file":"libvirt-pflash1-storage"}'
      -machine pc-q35-4.0,accel=kvm,usb=off,smm=on,dump-guest-core=off,pflash0=libvirt-pflash0-format,pflash1=libvirt-pflash1-format,smbios-ep=3_0
      -chardev file,path=firmware.log,id=firmwarelog
      -device isa-debugcon,iobase=0x402,chardev=firmwarelog
      -smbios type=11,path=smallfile.txt


I have a file 'bigfile.txt' that contains 14 MB of plain text.

I then create 'smallfile.txt' from this

  $ dd if=bigfile.txt of=littlefile.txt bs=1 count=130863

If count=130863 or smaller than EDK2 succesfully boots the guest.

If count=130864 or larger then AFAICT it gets stuck in EDK2 or
very early boot - the guest OS never runs.

If smbios-ep=2_1 (or is omitted), then the size limit is smaller of course
but QEMU validates that for you.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="make-tiny-image.py"

#!/usr/bin/env python3

import re
import sys
import glob
import argparse
import os
import os.path
import stat
import subprocess
from tempfile import TemporaryDirectory
from shutil import copy

def make_busybox(tmpdir, runcmd):
    usrsbin = os.path.join(tmpdir, "usr/sbin")
    bin = os.path.join(tmpdir, "bin")
    os.makedirs(usrsbin, exist_ok=True)
    os.makedirs(bin, exist_ok=True)

    busyboxin = "/usr/sbin/busybox"
    busyboxout = os.path.join(tmpdir, usrsbin, "busybox")
    copy(busyboxin, busyboxout)
    subprocess.check_call([busyboxin, "--install", "-s", bin])

    init = os.path.join(tmpdir, "init")
    with open(init, "w") as fh:
        print("""#!/bin/sh

mkdir /proc /sys
mount -t proc none /proc
mount -t sysfs none /sys

mount -n -t tmpfs none /dev
mknod -m 622 /dev/console c 5 1
mknod -m 666 /dev/null c 1 3
mknod -m 666 /dev/zero c 1 5
mknod -m 666 /dev/ptmx c 5 2
mknod -m 666 /dev/tty c 5 0
mknod -m 666 /dev/ttyS0 c 4 64
mknod -m 444 /dev/random c 1 8
mknod -m 444 /dev/urandom c 1 9

%s
poweroff -f
""" % runcmd, file=fh)
    os.chmod(init, stat.S_IRWXU)

def get_deps(binary):
    out = subprocess.check_output(["ldd", binary]).decode("utf8")
    deps = []
    for line in out.split("\n"):
        m = re.search("=> (/[^ ]+)", line)
        if m is not None:
            deps.append(m.group(1))
        else:
            m = re.match("\s*(/[^ ]+)\s+\(.*\)\s*$", line)
            if m is not None:
                deps.append(m.group(1))
    return deps
    
def make_binaries(tmpdir, binaries):
    bindir = os.path.join(tmpdir, "bin")

    seen = {}
    libs = []
    for binary in binaries:
        if binary[0] == '/':
            src = binary
            dst = os.path.join(tmpdir, binary[1:])
        else:
            src = os.path.join("/usr/bin", binary)
            if not os.path.exists(src):
                src = os.path.join("/usr/sbin", binary)
            dst = os.path.join(bindir, binary)
        if os.path.exists(dst):
            os.unlink(dst)
        copy(src, dst)

        libs.extend(get_deps(src))

    while len(libs):
        print("Pass libs")
        todo = libs
        libs = []
        for lib in todo:
            if lib in seen:
                continue

            dir = os.path.dirname(lib)
            libdir = os.path.join(tmpdir, dir[1:])
            os.makedirs(libdir, exist_ok=True)
            dst = os.path.join(tmpdir, lib[1:])
            copy(lib, dst)
            print(lib)
            seen[lib] = True
            libs.extend(get_deps(lib))

                              

def make_image(tmpdir, output, binaries, runcmd):
    make_busybox(tmpdir, runcmd)
    make_binaries(tmpdir, binaries)

    files = glob.iglob(tmpdir + "/**", recursive=True)
    prefix=len(tmpdir) + 1
    files = [f[prefix:] for f in files]
    files = files[1:]
    filelist = "\n".join(files).encode("utf8")

    with open(output, "w") as fh:
        subprocess.run(["cpio", "--quiet", "-o", "-H", "newc"],
                       cwd=tmpdir, input=filelist, stdout=fh)

parser = argparse.ArgumentParser(description='Build a tiny initrd image')
parser.add_argument('--output', default="tiny-initrd.img",
                    help='Filename of output file')
parser.add_argument('--run', default="exec setsid cttyhack /bin/sh",
                    help='Command to execute in guest (default: "exec setsid cttyhack /bin/sh")')
parser.add_argument('binary', nargs="*",
                    help='List of binaries to include')

args = parser.parse_args()

print (args.output)

with TemporaryDirectory(prefix="make-tiny-image") as tmpdir:
    make_image(tmpdir, args.output, args.binary, args.run)

--UlVJffcvxoiEqYs2--


