Received: from eggs.gnu.org ([2001:4830:134:3::10]:60594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <renyime@gmail.com>) id 1fH9EF-0004p4-EI
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <renyime@gmail.com>) id 1fH9EE-0006zw-8G
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:41:03 -0400
MIME-Version: 1.0
References: <1526042271-11983-1-git-send-email-ivanren@tencent.com>
	<d1f20f1e-69c7-bb11-3053-60bc89d06a84@redhat.com>
In-Reply-To: <d1f20f1e-69c7-bb11-3053-60bc89d06a84@redhat.com>
From: Ivan Ren <renyime@gmail.com>
Date: Fri, 11 May 2018 22:40:48 +0800
Message-ID: <CA+6E1=ku56=v=rGQt8=JArhA516afp94jDjmwwOc4A3dJdABcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] qcow2: fix preallocation with metadata
 on bare block device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com
Cc: mreitz@redhat.com, kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

>> Create a qcow2 directly on bare block device with
>> "-o preallocation=metadata" option. When read this qcow2, it will
>> return pre-existing data on block device, and this may lead to
>> data leakage. This patch add QCOW_OFLAG_ZERO for all preallocated
>> l2 entry to avoid this problem.
>
> This is a semantic change; are we okay making it?

> Does your code properly check for qcow2v2 files, which don't support
> QCOW_OFLAG_ZERO (only qcow2v3 supports it)?

Sorry for this mistake.
Current solution can only be used with s->qcow_version >= 3.
I'll fix it.

On Fri, May 11, 2018 at 9:41 PM Eric Blake <eblake@redhat.com> wrote:

> On 05/11/2018 07:37 AM, Ivan Ren wrote:
> > Create a qcow2 directly on bare block device with
> > "-o preallocation=metadata" option. When read this qcow2, it will
> > return pre-existing data on block device, and this may lead to
> > data leakage. This patch add QCOW_OFLAG_ZERO for all preallocated
> > l2 entry to avoid this problem.
>
> This is a semantic change; are we okay making it?
>
> Does your code properly check for qcow2v2 files, which don't support
> QCOW_OFLAG_ZERO (only qcow2v3 supports it)?
>
> >
> > Signed-off-by: Ivan Ren <ivanren@tencent.com>
> > ---
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
