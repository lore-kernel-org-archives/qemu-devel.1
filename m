Received: from eggs.gnu.org ([2001:4830:134:3::10]:43084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fpWwN-0000tf-Mf
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fpWwI-0006C2-Un
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:52:43 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180814091750.GF5025@dhcp-200-186.str.redhat.com>
References: <cover.1530270904.git.berto@igalia.com>
	<0ac388e86dec1afbff4b5e4e6ade1f1fb7b2d7ff.1530270904.git.berto@igalia.com>
	<20180814091750.GF5025@dhcp-200-186.str.redhat.com>
Date: Tue, 14 Aug 2018 12:52:35 +0200
Message-ID: <w51zhxpnrt8.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 5/5] block: Simplify append_open_options()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue 14 Aug 2018 11:17:50 AM CEST, Kevin Wolf wrote:
> Am 29.06.2018 um 13:37 hat Alberto Garcia geschrieben:
>> This function returns a BDS's driver-specific options, excluding also
>> those from its children. Since we have just removed all children
>> options from bs->options there's no need to do this last step.
>> 
>> We allow references to children, though ("backing": "node0"), so those
>> we still have to remove.
>> 
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>
> Hmm, yes, but if I compare this with the example you gave in an earlier
> patch:
>
>       $ qemu-img create -f qcow2 hd0.qcow2 10M
>       $ qemu-img create -f qcow2 -b hd0.qcow2 hd1.qcow2
>       $ qemu-img create -f qcow2 -b hd1.qcow2 hd2.qcow2
>
>       $ $QEMU -drive file=hd2.qcow2,node-name=hd2,backing.node-name=hd1
>
>     This opens a chain of images hd0 <- hd1 <- hd2. Now let's remove hd1
>     using block_stream:
>
>       (qemu) block_stream hd2 0 hd0.qcow2
>
>     After this hd2 contains backing.node-name=hd1, which is no longer
>     correct because hd1 doesn't exist anymore.
>
> Doesn't backing=hd1 actually result in the same kind of inconsistency?
> That is, bs->option will still have backing=hd1, but in reality we
> reference hd0 now?
>
> Should we get rid of child references in bs->(explicit_)options as
> well?

I don't think so, at least not in general.

The main difference is that if you set backing.node-name=foo then it
means that 'node-name=foo' is an option of the child, the option doesn't
belong in the parent at all. So once it's transferred to the child
there's no reason why it shoud remain in the parent. It's redundant and
can interfere with the reopen operation (e.g. you change the option in
the child but when you reopen the parent it will try to revert the child
option to the previous value).

In the case of 'backing=foo' that's clearly an option of the parent,
there's no other place to put it. We could probably remove it as well,
but we have to see carefully that no parent needs to keep that
information. I think we want to keep child references because in general
we don't allow them to be changed in reopen.

Example: you cannot pass 'file=bar' on reopen unless 'bar' was already
the existing value of 'file' (i.e. you're not changing anything). We
need to look for the previous value in bs->options in order to know
that.

After x-blockdev-reopen is ready, 'backing' will perhaps be the
first/only exception, because we'll be able to change it and the
previous value doesn't matter.

But that's part of the patches I'm working on.

Berto
