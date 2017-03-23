Received: from eggs.gnu.org ([2001:4830:134:3::10]:50380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cr6Tj-0001OB-O3
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:24:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cr6Ti-0006SK-Vm
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:24:51 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:35518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cr6Ti-0006S2-PV
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:24:50 -0400
Received: by mail-wm0-x22a.google.com with SMTP id u132so67408302wmg.0
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 10:24:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPww8bjxSY3M+bXa9vchBdvhMe+u0CJHZxh4nxe40+N=DAWmkA@mail.gmail.com>
References: <CAPww8bgFdJpx=_JKu+zgCiSGwzC2jcVweP13QsRUZtUp_eu0Zg@mail.gmail.com>
	<20170323151437.GE12560@stefanha-x1.localdomain>
	<CAPww8bjxSY3M+bXa9vchBdvhMe+u0CJHZxh4nxe40+N=DAWmkA@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 23 Mar 2017 17:24:49 +0000
Message-ID: <CAJSP0QUX9V2S7WzmaUbG1wzO5r8bVtTogcy0B5AXzoM4=y+Hvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Qemu socket address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashish Gahlot <dreamashish21@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Thu, Mar 23, 2017 at 4:11 PM, Ashish Gahlot <dreamashish21@gmail.com> wrote:
> Actually, I'm trying to run two separate Qemu processes and the command line argument is "qemu-system-x86_64 -kernel kernel -S -s" and the error which I get on second invocation is
> > qemu-system-x86_64: -s: Failed to bind socket: Address already in use

Please keep qemu-devel@nongnu.org CCed so that the conversation stays
on the mailing list.

This is expected behavior.  The man page says:

  -s  Shorthand for -gdb tcp::1234, i.e. open a gdbserver on TCP port 1234.

Two processes cannot listen on the same port*, even with SO_REUSEADDR.

Please specify unique port numbers using the longer syntax from the man page:

  $ qemu-system-x86_64 -kernel kernel -S -gdb tcp::1234
  $ qemu-system-x86_64 -kernel kernel -S -gdb tcp::1235

Now you can tell gdb which QEMU instance to connect to.

Stefan

* There is a Linux-specific socket option for allowing multiple
processes to listen on the same port but it's meant for load balancing
and wouldn't help in this case.
