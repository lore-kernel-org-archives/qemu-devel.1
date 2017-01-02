Received: from eggs.gnu.org ([2001:4830:134:3::10]:33944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cNy10-0000kA-Ba
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 03:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cNy0v-0003Ve-9t
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 03:30:46 -0500
Received: from mail-wj0-x241.google.com ([2a00:1450:400c:c01::241]:33261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cNy0u-0003Uf-VU
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 03:30:41 -0500
Received: by mail-wj0-x241.google.com with SMTP id kp2so67678703wjc.0
	for <qemu-devel@nongnu.org>; Mon, 02 Jan 2017 00:30:40 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1482869621-24808-1-git-send-email-nutarojj@ornl.gov>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fe8b67b8-d430-a334-cd65-3528b6a9e74f@redhat.com>
Date: Mon, 2 Jan 2017 09:30:38 +0100
MIME-Version: 1.0
In-Reply-To: <1482869621-24808-1-git-send-email-nutarojj@ornl.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4] qqq: module for synchronizing with a
 simulation clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "James J. Nutaro" <nutarojj@ornl.gov>, qemu-devel@nongnu.org



On 27/12/2016 21:13, James J. Nutaro wrote:
> +(1) Create two pairs of pipes with the Linux pipe function.
> +    The code segment that does this might look like
> +
> +       int pipefd1[2];
> +       int pipefd2[2];
> +       pipe(pipefd1);
> +       pipe(pipefd2);
> +
> +(2) Fork QEMU with the appropriate command line arguments.
> +    The -qqq part of the argument will look something like
> +
> +       -qqq write=pipefd1[1],read=pipefd2[0]

If you need a pair of pipes, you might as well use a Unix socket or even
a generic chardev.  This would give something like

	-chardev socket,path=extclock.socket \
	-icount 1,extclock=chardev

> +The synchronization protocol is very simple. To start, the
> +external simulator writes an integer to its write pipe with
> +the amount of time in microseconds that QEMU is allowed to
> +advance. The code segment that does this might look like:
> +
> +    int ta = 1000; // Advance by 1 millisecond
> +    write(pipefd2[1],&ta,sizeof(int));

This makes the protocol depend on system endianness.  Please make it
endian independent.

Regarding the implementation, note that the "frozen clock" is already
implemented by cpu_disable_ticks() and cpu_enable_ticks(), so it would
be (much) better if you can reuse that.

These are not small details, granted, but the concept looks interesting.
 I'm sorry I didn't notice the first 3 versions.  I look forward to
review the next iteration of the patch!

Paolo

> +The external simulator can then advance its clock by this
> +same amount. During this time, QEMU and the external simulator
> +will be executing in parallel. When the external simulator
> +completes its time advance, it waits for QEMU by reading from
> +its read pipe. The value read will be the actual number of
> +virtual microseconds by which QEMU has advanced its virtual clock.
> +This will be greater than or equal to the requested advance.
> +The code that does this might look like:
> +
> +   read(pipefd1[0],&ta,sizeof(int));
> +
