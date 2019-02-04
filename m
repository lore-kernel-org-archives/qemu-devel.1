Received: from eggs.gnu.org ([209.51.188.92]:51758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1gqZHI-0000Rp-Qp
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1gqZHI-00076T-0A
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:06:52 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1gqZHH-0006yc-KP
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:06:51 -0500
Received: by mail-ot1-x343.google.com with SMTP id v23so11522214otk.9
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 00:06:45 -0800 (PST)
MIME-Version: 1.0
References: <20190204075023.GA15322@stefanha-x1.localdomain>
In-Reply-To: <20190204075023.GA15322@stefanha-x1.localdomain>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 4 Feb 2019 00:06:32 -0800
Message-ID: <CAPcyv4huSKQueADyF5wJPWxMdLAn6yvEqWyMZfWPVQ4vQ_X0RA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Querying the size of devdax devices from userspace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Yi <yi.z.zhang@linux.intel.com>, Jeff Moyer <jmoyer@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, linux-nvdimm <linux-nvdimm@lists.01.org>

On Sun, Feb 3, 2019 at 11:56 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> How can userspace applications query the size of devdax character
> devices?
>
> stat(1) doesn't know how large the device is:
>
>   # stat /dev/dax0.0
>     File: /dev/dax0.0
>     Size: 0             Blocks: 0          IO Block: 4096   character special file
>   Device: 6h/6d Inode: 56764       Links: 1     Device type: fa,d
>
> ndctl(1) finds out by digging in /sys:
>
>   # ndctl list
>   [
>     {
>       "dev":"namespace0.0",
>       "mode":"devdax",
>       "map":"dev",
>       "size":2111832064,
>       "uuid":"235acf4d-503f-46be-bf64-f26faf9777ef",
>       "chardev":"dax0.0"
>     }
>   ]
>
> I'm not sure how to do it without enumerating all nvdimms in /sys.  Is
> there a mapping from devdax major/minor number to a /sys path?
>
> The use case I have in mind is that QEMU currently takes the size as a
> command-line parameter.  The failure mode is ugly when users get this
> value wrong: the guest gets a softlockup and there is no error message
> on the host side.
>
> I'd like QEMU to detect the size or at least reject size values that are
> too large.  In order to do that userspace needs a convenient way of
> querying the size.  Any ideas?

You're looking for /sys/dev/char. That will wake you from major:minor
to sysfs. Perhaps borrow fio's implementation for the same:

   http://git.kernel.dk/cgit/fio/tree/engines/dev-dax.c#n258
