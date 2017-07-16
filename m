Received: from eggs.gnu.org ([2001:4830:134:3::10]:43013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWpK0-0004bh-4l
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 15:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWpJx-00083D-31
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 15:35:16 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:35698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWpJw-00082y-US
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 15:35:13 -0400
Received: by mail-io0-x243.google.com with SMTP id 84so6050315iop.2
	for <qemu-devel@nongnu.org>; Sun, 16 Jul 2017 12:35:12 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-7-rth@twiddle.net>
	<20170715221412.3yprwf5i3te4gdxa@aurel32.net>
	<65cb9165-42a1-9648-7519-0bd893c1ac13@twiddle.net>
	<20170716151802.cmaz3zhucqlgaq5r@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e19112df-a491-2e34-61a7-3a514622df3e@twiddle.net>
Date: Sun, 16 Jul 2017 09:35:05 -1000
MIME-Version: 1.0
In-Reply-To: <20170716151802.cmaz3zhucqlgaq5r@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/27] target/sh4: Handle user-space
 atomics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

On 07/16/2017 05:18 AM, Aurelien Jarno wrote:
> That said for further improvements did you consider decoding the gUSA
> section in a helper. It might avoid having to emulate the atomic
> sequence with 3 TBs in the worst case (the original one, the one to
> decode the sequence and the one holding the exclusive lock). The helper
> should directly have access to the r0 value, can decode the atomic
> sequence and translate it into a call to the corresponding atomic
> helpers. In the best case that means the sequence can be done in the
> same TB. In the worst case, where the gUSA sequence is not recognized
> it means two TB.

I did not consider decoding the sequence in a helper.

I do want to cache the result in a TB, so that when we execute the atomic 
sequence for a second time we do not have to re-interpret it.  And I don't see 
how to do that with a helper.

I *could* remember a mova into R0 earlier within the same block that performs 
the mov #imm,r15.  It's not guaranteed to be in the same TB, but looking 
through dumps from debian unstable it's highly likely.

That could end up with the atomic sequence in the same TB that set SP, or with 
the EXCP_ATOMIC exception in the same TB.

If it's ok with you, I'd prefer to handle that as a follow up.  We would still 
have to have the current setup as a backup just in case the mova isn't visible.


r~
