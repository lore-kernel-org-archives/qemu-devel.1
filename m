Received: from eggs.gnu.org ([2001:4830:134:3::10]:58224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqfcH-0000cB-M0
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqfcD-0003jg-NE
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:20:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57346 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqfcD-0003jW-IU
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:20:37 -0400
References: <CAB3eZfsv+JDr+C=BaKEmZvW9meTwNub2HfwXO5DX7mf+BJqO0A@mail.gmail.com>
	<20180816082200.GD8612@redhat.com>
	<90d7f44b-03ad-c075-e344-3c52c4268965@redhat.com>
	<CAB3eZfvdT22SKvcqXtEHFfHhvDvWWFzXa+nvDRYag852TotZUA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <15521427-c38a-0e95-ad03-05e81016e846@redhat.com>
Date: Fri, 17 Aug 2018 09:20:36 -0500
MIME-Version: 1.0
In-Reply-To: <CAB3eZfvdT22SKvcqXtEHFfHhvDvWWFzXa+nvDRYag852TotZUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] How do you do when write more than 16TB data to
 qcow2 on ext4?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lampahome <pahome.chen@mirlab.org>
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 08/17/2018 03:05 AM, lampahome wrote:
> Really? How to mount a blk device to /dev/nbdN?
> I always find tips to mount from file-like image to /dev/nbdN

Please don't top-post on technical lists, it makes the conversation 
harder to follow.

I'm not sure how your question about /dev/nbdN relates to your setup of 
trying to produce a large guest image. You can export ANYTHING that qemu 
can recognize to /dev/nbdN, via:

qemu-nbd -c /dev/nbd$n $image_that_qemu_recognizes

This is true for raw images:
qemu-nbd -c /dev/nbd$n -f raw /path/to/file

for block devices such as LVM storing qcow2 format:
qemu-nbd -c /dev/nbd$n -f qcow2 /dev/mapper/vg_$whatever

for remote access to another NBD server:
qemu-nbd -c /dev/nbd$n -f raw nbd://remote:10809/export

again, but this time with only a 1M subset exported:
qemu-nbd -c /dev/nbd$n --image-opts 
driver=raw,offset=1M,size=1M,file.driver=nbd,\
file.server.type=inet,file.server.host=remote,\
file.server.port=10809,file.export=export

and so on.

Basically, if qemu can access storage, it can also export that storage 
as NBD, and you can then hook up the kernel's NBD client to expose that 
storage as a local block device for inspecting what the guest image 
contains (word of caution: don't mount untrusted guest images in this 
manner, as the guest could have planted a malicious file system bug that 
will crash the host. Instead, use libguestfs for mounting guest images 
in a safe VM environment where at most you crash the VM instead of the 
host).  And there's no requirement that you have to involve the kernel 
via /dev/nbdN - you can instead access NBD servers via userspace 
(qemu-img is one such userspace client, and Nir Soffer recently posted 
to this list about a client being written in python).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
