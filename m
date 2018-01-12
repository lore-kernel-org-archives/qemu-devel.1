Received: from eggs.gnu.org ([2001:4830:134:3::10]:60112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ea0Ix-0003NG-DI
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ea0Iu-00086m-8m
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:27:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ea0It-00085S-Vj
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:27:32 -0500
Date: Fri, 12 Jan 2018 14:27:22 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180112142722.GG17392@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <081955e1-84ec-4877-72d4-f4e8b46be350@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <081955e1-84ec-4877-72d4-f4e8b46be350@huawei.com>
Subject: Re: [Qemu-devel] [RFC] qid path collision issues in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Antonios Motakis <antonios.motakis@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, "zhangwei (CR)" <zhangwei555@huawei.com>, Veaceslav Falico <veaceslav.falico@huawei.com>, Eduard Shishkin <Eduard.Shishkin@huawei.com>, "Wangguoli (Andy)" <andy.wangguoli@huawei.com>, Jiangyiwen <jiangyiwen@huawei.com>, "vfalico@gmail.com" <vfalico@gmail.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>

On Fri, Jan 12, 2018 at 07:32:10PM +0800, Antonios Motakis wrote:
> Hello all,
> 
> We have found an issue in the 9p implementation of QEMU, with how qid paths
> are generated, which can cause qid path collisions and several issues caused
> by them. In our use case (running containers under VMs) these have proven to
> be critical.
> 
> In particular, stat_to_qid in hw/9pfs/9p.c generates a qid path using the
> inode number of the file as input. According to the 9p spec the path should
> be able to uniquely identify a file, distinct files should not share a path
> value.
> 
> The current implementation that defines qid.path = inode nr works fine as long as there are not files from multiple partitions visible under the 9p share. In that case, distinct files from different devices are allowed to have the same inode number. So with multiple partitions, we have a very high probability of qid path collisions.
> 
> How to demonstrate the issue:
> 1) Prepare a problematic share:
>  - mount one partition under share/p1/ with some files inside
>  - mount another one *with identical contents* under share/p2/
>  - confirm that both partitions have files with same inode nr, size, etc
> 2) Demonstrate breakage:
>  - start a VM with a virtio-9p pointing to the share
>  - mount 9p share with FSCACHE on
>  - keep open share/p1/file
>  - open and write to share/p2/file
> 
> What should happen is, the guest will consider share/p1/file and
> share/p2/file to be the same file, and since we are using the cache it will
> not reopen it. We intended to write to partition 2, but we just wrote to
> partition 1. This is just one example on how the guest may rely on qid paths
> being unique.

Ouch, this is a serious security bug. The guest user who has p1/file open may
have different privilege level to the guest user who tried to access p2/file.
So this flaw can be used for privilege escalation and/or confinement escape
by a malicious guest user.

> We have thought of a few approaches, but we would definitely like to hear
> what the upstream maintainers and community think:
> 
> * Full fix: Change the 9p protocol
> 
> We would need to support a longer qid path, based on a virtio feature flag.
> This would take reworking of host and guest parts of virtio-9p, so both QEMU
> and Linux for most users.

Requiring updated guest feels unpleasant because of the co-ordination required
to get the security fix applied. So even if we do that, IMHO, we must also
have a fix in QEMU that does not require guest update.

> 
> * Fallback and/or interim solutions
> 
> A virtio feature flag may be refused by the guest, so we think we still need
> to make collisions less likely even with 64 bit paths. E.g.
> 1. XOR the device id with inode nr to produce the qid path (we attach a proof
> of concept patch)

That just makes collision less likely, but doesnt guarantee its eliminated
and its probably practical for guests to bruteforce collisions depending on
how many different FS are passed through & number of files that can be
opened concurrently

> 2. 64 bit hash of device id and inode nr

This is probably better than (1), but a 64-bit hash algorithm is fairly weak
wrt collision resistance when you have a large number of files.

> 3. other ideas, such as allocating new qid paths and keep a look up table of
> some sorts (possibly too expensive)

I think QEMU will have to maintain a lookup table of files that are currently
open, and their associated qids, in order to provide a real guarantee that
the security flaw is addressed.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
