Received: from eggs.gnu.org ([2001:4830:134:3::10]:55283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gKPGU-0002Ai-3r
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 09:57:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gKPGQ-0002AD-NT
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 09:57:05 -0500
Received: from mail-vk1-f178.google.com ([209.85.221.178]:44378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1gKPGQ-00028k-F6
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 09:57:02 -0500
Received: by mail-vk1-f178.google.com with SMTP id h128so3751284vkg.11
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 06:57:01 -0800 (PST)
MIME-Version: 1.0
References: <20181107121319.GC14842@redhat.com>
	<20181107143628.GG8125@redhat.com>
In-Reply-To: <20181107143628.GG8125@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Wed, 7 Nov 2018 16:56:48 +0200
Message-ID: <CAMRbyyuFGVtNWF9LKoi0n6_r5Gr4j8LetbAMd0L_5cKMif9LjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Change in qemu 2.12 causes qemu-img convert to NBD
 to write more data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, qemu-block <qemu-block@nongnu.org>, edgar.kaziakhmedov@virtuozzo.com

Wed, Nov 7, 2018 at 4:36 PM Richard W.M. Jones <rjones@redhat.com> wrote:

> Another thing I tried was to change the NBD server (nbdkit) so that it
> doesn't advertise zero support to the client:
>
>   $ nbdkit --filter=log --filter=nozero memory size=6G logfile=/tmp/log \
>       --run './qemu-img convert ./fedora-28.img -n $nbd'
>   $ grep '\.\.\.$' /tmp/log | sed 's/.*\([A-Z][a-z]*\).*/\1/' | uniq -c
>    2154 Write
>
> Not surprisingly no zero commands are issued.  The size of the write
> commands is very uneven -- it appears to be send one command per block
> of zeroes or data.
>
> Nir: If we could get information from imageio about whether zeroing is
> implemented efficiently or not by the backend, we could change
> virt-v2v / nbdkit to advertise this back to qemu.
>

There is no way to detect the capability, ioctl(BLKZEROOUT) always
succeeds, falling back to manual zeroing in the kernel silently

Even if we could, sending zero on the wire from qemu may be even
slower, and it looks like qemu send even more requests in this case
(2154 vs ~1300).

Looks like this optimization in qemu side leads to worse performance,
so it should not be enabled by default.

Nir
