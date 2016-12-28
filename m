Received: from eggs.gnu.org ([2001:4830:134:3::10]:45608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kripper@imatronix.cl>) id 1cMJLc-0005Pb-2m
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 13:53:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kripper@imatronix.cl>) id 1cMJLY-0005Qu-VL
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 13:53:12 -0500
Received: from ip35.imatronix.com ([200.73.112.45]:43603)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kripper@imatronix.cl>)
	id 1cMJLY-0005GN-HE
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 13:53:08 -0500
References: <53e52412-cd32-cb9e-2261-882a7b5b84ea@imatronix.cl>
	<20161219010743.GA2719@lemon>
	<20161219135529.GE17374@stefanha-x1.localdomain>
	<aee6f019-7d2f-5b4a-3679-35a909af6d6d@imatronix.cl>
	<4fb58e00-63bf-ce50-677d-cec2ed5684a9@redhat.com>
	<f8f625d2-fd0d-f152-7521-6ef2b3d74309@imatronix.cl>
From: Christopher Pereira <kripper@imatronix.cl>
Message-ID: <a982da67-2971-3134-de18-7d470b1fb4d2@imatronix.cl>
Date: Wed, 28 Dec 2016 15:51:58 -0300
MIME-Version: 1.0
In-Reply-To: <f8f625d2-fd0d-f152-7521-6ef2b3d74309@imatronix.cl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Can qemu reopen image files?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

Hi Eric,

There is something I don't understand.

We are doing: "virsh save", "qemu-img convert", "qemu-img rebase" and 
"virsh restore".
We only touch the backing chain by doing the rebase while the VM is down.
Is there any chance this procedure can destroy data?
If so, is there any difference between shutting down and just 
saving/restoring the VM?
Maybe save/restore keeps a cache?

Best regards,
Christopher.

On 19-Dec-16 13:24, Christopher Pereira wrote:
> Hi Eric,
>
> Thanks for your great answer.
>
> On 19-Dec-16 12:48, Eric Blake wrote:
>
>>
>>> Then we do the rebase while the VM is suspended to make sure the image
>>> files are reopened.
>> That part is where you are liable to break things.  Qemu does NOT have a
>> graceful way to reopen the backing chain, so rebasing snap3 to point to
>> snap2' behind qemu's back is asking for problems.  Since qemu may be
>> caching things it has already learned about snap2, you have invalidated
>> that cached data by making snap3 point to snap2', but have no way to
>> force qemu to reread the backing chain to start reading from snap2'.
> We are actually doing a save, rebase and restore to reopen the backing 
> chain.
> We only touch files (rebase) while the VM is down.
> Can you please confirm this is 100% safe?
>
>> Or, if you don't want to merge into "base'", you can use block-stream to
>> merge the other direction, so that "base <- snap1 <- snap2" is converted
>> into "snap2'" - but that depends on patches that were only barely added
>> in qemu 2.8 (intermediate block-commit has existed a lot longer than
>> intermediate block-stream).  But the point remains that you are still
>> using qemu to do the work, and therefore with no external qemu-img
>> process interfering with the chain, you don't need any guest downtime or
>> any risk of breaking qemu operation by invalidating data it may have 
>> cached.
> Right. Since images are backed up remotely, we don't want to merge 
> into base nor touch the backing chain at all (only the active snapshot 
> should be modified). This is to keep things simple and avoid to 
> re-syncs of images (remote backups).
>
> Besides, we don't want to merge the whole backing chain, but an 
> intermediate point, so it seems that the clean way is to use the 
> "intermediate block-stream" feature.
>
> We didn't try it, because when we researched we got the impression 
> that the patches were not stable yet or not included in the qemu 
> versions shipped with CentOS, so we went with 'qemu-img convert' 
> because we needed something known, simple and stable (we are dealing 
> with critical information for gov. orgs.).
>
>> If block-commit and block-stream don't have enough power to do what you
>> want, then we should patch them to expose that power, rather than
>> worrying about how to use qemu-img to modify the backing chain behind
>> qemu's back.
> "intermediate block-stream" seems to be the right solution for our use 
> case.
> Does it also allow QCOW2 compression?
> Compression is interesting, especially when files are sync'ed via 
> network.
>
