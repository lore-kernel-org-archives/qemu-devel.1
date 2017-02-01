Received: from eggs.gnu.org ([2001:4830:134:3::10]:48714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cYx4B-0000fm-9h
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 10:43:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cYx46-0001x4-F0
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 10:43:27 -0500
Received: from mail-ua0-f177.google.com ([209.85.217.177]:35417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1cYx46-0001vx-AB
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 10:43:22 -0500
Received: by mail-ua0-f177.google.com with SMTP id y9so300442866uae.2
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 07:43:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <15e45a8d-852e-97da-65c5-3f69258dd59b@redhat.com>
References: <1485943606-13998-1-git-send-email-lprosek@redhat.com>
	<20170201102013.GC3232@redhat.com>
	<CABdb735fGM9r4tirfOTyK1Jv8oC868nW5rCsNk_X5acoiav1iA@mail.gmail.com>
	<20170201110320.GD3232@redhat.com>
	<CABdb737yd8ookNxet=Rp7b6-fux6iiBiS7KrrddtZ2EZVPFKqg@mail.gmail.com>
	<15e45a8d-852e-97da-65c5-3f69258dd59b@redhat.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Wed, 1 Feb 2017 16:43:20 +0100
Message-ID: <CABdb734L84bLriTvuE3FY7HHcSZ+sZ+C=CGpWnxonH-4kDivfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] qga: implement guest-file-ioctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, mdroth@linux.vnet.ibm.com

On Wed, Feb 1, 2017 at 3:43 PM, Eric Blake <eblake@redhat.com> wrote:
> On 02/01/2017 07:41 AM, Ladi Prosek wrote:
>
>>
>> Ok, so there are two different aspects that should probably be
>> separated. The actual semantics of IOCTL calls is equivalent to the
>> semantics of files in general. For files it's stream in, stream out
>> (and seeking and such). For IOCTL it's a buffer in, buffer out (and a
>> return code). The content is file specific, IOCTL code specific,
>> whatever. Definitely not guest agent's business to interpret it. Here
>> I think my analogy holds.
>
> I don't.  ioctl() is a leaky abstraction - it exists as the blanket
> catch-all do-anything-else-that-doesn't-have-a-dedicated-API.  It is, by
> its very nature, non-portable and VERY hard to abstract - because there
> is no one abstraction for every possible ioctl code.  I strongly agree
> with Dan here that you are going to get nowhere by adding a qga-ioctl
> command, because there is no SANE way that you can specify it in QAPI.
> Rather, add specific commands for the specific actions you want to
> expose, and if the implementation of those specific commands uses a
> particular ioctl() under the hood, fine.  But don't directly expose
> ioctl() over the wire.

If I wasn't outnumbered and didn't have a feeling that I already lost
:) I would ask you to show me a couple of real-world IOCTLs that don't
fit the abstraction proposed in this patch. And trade it off against
enabling all the rest that would fit. And I would maybe also say that
done is better than perfect but that might mean crossing the line and
getting muself into trouble :p

But yeah, whoever thought that having ... in a syscall signature is a
good idea should be shamed forever.

>>> It would be possible to design a ioctl API that is more usable if you
>>> didn't try to do generic passthrough of arbitrary ioctl commands. Instead
>>> provide a QAPI schema that uses a union to provide strongly typed arguments
>>> for the ioctl commands you care about using. Or completely separate QAPI
>>> commands instead of multiplexing everything into an ioctl command.
>>
>> I can add a QAPI command for my specific use case if it's acceptable,
>
> Certainly more palatable, and more likely to gain my acceptance.

I'll look into it. Thanks!

>> that's not a problem. Although at that point I would probably just go
>> back to my plan b and use regular file I/O and guest-file-read. I just
>> wanted to be as generic as possible to benefit other use cases as well
>> and I ended up with what's basically my stab at RPC ioctl.
>
> The problem is that RPC ioctl is not sanely possible.
>
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>
