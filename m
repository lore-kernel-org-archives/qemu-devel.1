Received: from eggs.gnu.org ([2001:4830:134:3::10]:44120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jannh@google.com>) id 1cguxY-0004n8-62
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jannh@google.com>) id 1cguxU-0002Oc-0N
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:05:32 -0500
Received: from mail-it0-x231.google.com ([2607:f8b0:4001:c0b::231]:37335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jannh@google.com>) id 1cguxT-0002O6-PS
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:05:27 -0500
Received: by mail-it0-x231.google.com with SMTP id 203so2356165ith.0
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 07:05:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2e9357a4-34ad-9cc1-db39-5ed00bdc015d@redhat.com>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760161575.31154.505252736798591155.stgit@bahia.lan>
	<2e9357a4-34ad-9cc1-db39-5ed00bdc015d@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 23 Feb 2017 16:05:02 +0100
Message-ID: <CAG48ez1wh--=vP+XqSNigwf32d-pGs_-JoFw5P77Em00YmJ9+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 07/29] 9pfs: local: introduce
 symlink-attack safe xattr helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Feb 23, 2017 at 4:02 PM, Eric Blake <eblake@redhat.com> wrote:
> On 02/20/2017 08:40 AM, Greg Kurz wrote:
>> All operations dealing with extended attributes are vulnerable to symlink
>> attacks because they use path-based syscalls which can traverse symbolic
>> links while walking through the dirname part of the path.
>>
>> The solution is to introduce helpers based on opendir_nofollow(). This
>> calls for "at" versions of the extended attribute syscalls, which don't
>> exist unfortunately. This patch implement them by simulating the "at"
>> behavior with fchdir(). Since the current working directory is process
>> wide, and we don't want to confuse another thread in QEMU, all the work
>> is done in a separate process.
>
> Can you emulate *at using /proc/fd/nnn/xyz?

I don't know much about QEMU internals, but QEMU supports running in a
chroot using the -chroot option, right? Does that already require procfs to be
mounted inside the chroot?
