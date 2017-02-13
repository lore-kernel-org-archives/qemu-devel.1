Received: from eggs.gnu.org ([2001:4830:134:3::10]:57418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlipchuk@redhat.com>) id 1cdIpd-0002FV-6v
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 10:46:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlipchuk@redhat.com>) id 1cdIpZ-0001fr-Qi
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 10:46:25 -0500
Received: from mail-oi0-f46.google.com ([209.85.218.46]:36421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlipchuk@redhat.com>) id 1cdIpZ-0001fS-L9
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 10:46:21 -0500
Received: by mail-oi0-f46.google.com with SMTP id u143so51973325oif.3
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 07:46:20 -0800 (PST)
MIME-Version: 1.0
From: Maor Lipchuk <mlipchuk@redhat.com>
Date: Mon, 13 Feb 2017 17:46:19 +0200
Message-ID: <CAJ1JNOd5cZ3RWUAkY=uo7+wwSwQrBWrN6GF_QZFjdVfx49VtGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Estimation of qcow2 image size converted from raw image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-discuss@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Allon Mureinik <amureini@redhat.com>

Hi all,

I was wondering if that is possible to provide a new API that
estimates the size of
qcow2 image converted from a raw image. We could use this new API to
allocate the
size more precisely before the convert operation.

What are we trying to do:
- Convert raw sparse image from NFS or from block device to qcow2 image
  on thin provisioned block device

- In ovirt thin provisioned block device is a regular lv, and we like
  allocate only the required size for the the qcow file.

Our current (stupid) solution is to allocate the entire LV using the
size of the raw image.

Here is an example flow:

    $ truncate -s 10G test.raw

We don't know what will be the size of the qcow on the block storage,
so we allocate the entire LV:

    $ lvcreate --size 10G vg/lv

Then we convert the file to the new LV:

    $ qemu-img convert -f raw -O qcow2 test.raw /dev/vg/lv

After the copy we can check the actual size:

    $ qemu-img check /dev/vg/lv

And reduce the LV:

    $ lvreduce -L128m vg/lv

But we like to avoid the allocation, and allocate only the needed size
before we convert the image.

We found that if we create a file with one byte for each cluster (64K),
qcow2 file will be bigger than the raw file:

Creating worst case raw file:

    with open("worst.raw", "wb") as f:
        for offset in range(64 * 1024 - 1, 10 * 1024**3, 64 * 1024):
            f.seek(offset)
            f.write("x")

$ ls -lh worst.raw
-rw-rw-r--. 1 user user 10G Feb 13 16:43 worst.raw

$ du -sh worst.raw
642M worst.raw

$ ls -lh worst.qcow2
-rw-r--r--. 1 user user 11G Feb 13 17:10 worst.qcow2

Now compare that to the best case:

    with open("best.raw", "wb") as f:
        for i in range(10 * 1024**3 / (64*1024)):
            f.write("x" * 4096)

$ ls -lh best.raw
-rw-rw-r--. 1 user user 10G Feb 13 17:18 best.raw

$ du -sh best.raw
641M best.raw

$ qemu-img convert -p -f raw -O qcow2 best.raw best.qcow2

$ ls -lh best.qcow2
-rw-r--r--. 1 user user 641M Feb 13 17:21 best.qcow2

$ du -sh best.qcow2
641M best.qcow2

So it seems that to estimate the size of the qcow2 file, we need
to check not only the number of blocks but the location of the blocks.

We can probably use qemu-img map to estimate:

$ qemu-img map worst.raw --output json
[{ "start": 0, "length": 61440, "depth": 0, "zero": true, "data":
false, "offset": 0},
{ "start": 61440, "length": 4096, "depth": 0, "zero": false, "data":
true, "offset": 61440},
{ "start": 65536, "length": 61440, "depth": 0, "zero": true, "data":
false, "offset": 65536},
{ "start": 126976, "length": 4096, "depth": 0, "zero": false, "data":
true, "offset": 126976},
{ "start": 131072, "length": 61440, "depth": 0, "zero": true, "data":
false, "offset": 131072},
...

$ qemu-img map best.raw --output json
[{ "start": 0, "length": 671088640, "depth": 0, "zero": false, "data":
true, "offset": 0},
{ "start": 671088640, "length": 10066325504, "depth": 0, "zero": true,
"data": false, "offset": 671088640},
{ "start": 10737414144, "length": 4096, "depth": 0, "zero": false,
"data": true, "offset": 10737414144}]

But this means we have to include qcow2 allocation logic in our code, and
the calculation will break when qcow2 changes the format.

We think that the best way to solve this issue is to return this info
from qemu-img, maybe as a flag to qemu-img convert that will
calculate the size of the converted image without doing any writes.


See also:
https://bugzilla.redhat.com/1358717 - Export of vm with thin provision
disk from NFS Data domain and Import to Block Data domain makes
virtual and Actual size of disk same.

https://bugzilla.redhat.com/1419240 - Creating a Clone vm from
template with Format "QCOW2" and Target "block based storage" has a
disk with same actual and virtual size.


Regards,
Maor
