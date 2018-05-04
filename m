Received: from eggs.gnu.org ([2001:4830:134:3::10]:54327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <renyime@gmail.com>) id 1fEd5r-00011v-Hn
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <renyime@gmail.com>) id 1fEd5q-0000Ph-EB
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:57:59 -0400
MIME-Version: 1.0
References: <1525268093-531-1-git-send-email-ivanren@tencent.com>
	<bc77a1b2-27f3-21a0-8d82-b930bdf033a5@redhat.com>
	<CA+6E1=kp+xYKEc0Xz8tj8M0r4nGb8PG+vxvxm=cDTEGCEsDTPg@mail.gmail.com>
	<325f0743-7fca-0aab-c0f2-1ab46f94864b@redhat.com>
In-Reply-To: <325f0743-7fca-0aab-c0f2-1ab46f94864b@redhat.com>
From: Ivan Ren <renyime@gmail.com>
Date: Fri, 04 May 2018 15:57:45 +0000
Message-ID: <CA+6E1==3AYrwy2zu=caUM6hWKqgfXB-qnTf9u6TX0rcCtiS4JQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-img: return allocated size for block
 device with qcow2 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mreitz@redhat.com
Cc: eblake@redhat.com, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org

> Yeah, well, then you use qemu-img check to repair it.  The refcount
> structure is there to know which clusters are allocated, so we should
> use it when we want to know that and not assume it's broken.  If the
> user thinks it may be broken, they are free to run qemu-img check to
check.

Yea, it is right. It makes things easy.


> Oh, I've just seen that your patch doesn't even get the allocated size,
> it actually determines the highest allocated offset.  Well, those are
> two different things.  You should not return this value via
> qcow2_get_allocated_file_size().  I'm not sure where it should go
> (probably wr_highest_offset?) and how it should be presented in
> qemu-img, though.
>
> Also note that bdrv_get_allocated_file_size() is called by QMP's
> query-named-block-nodes and query-block, both of which are online
> synchronous functions.  It should not take a long time, specifically it
> should not scan the whole qcow2 file.

Yes, My original idea was to get the highest allocated offset on the block
device and regard it as currently max allocated size(ignore the hole lower
than it).
Through the discuss, I think it is better to count how many clusters with
non-0 refcount as the real allocated size.
I'll try to get a new version patch to implement this.

On Fri, May 4, 2018 at 10:35 PM Max Reitz <mreitz@redhat.com> wrote:

> On 2018-05-03 15:06, =E5=8F=B6=E6=AE=8B=E9=A3=8E wrote:
> >
> > Thanks for your review, Eric.
> > Yes, the wr_highest_offset can tell the end offset at runtime, and
> > write_threshold similar to it. But in my situation, I need to know
> > the allocated end without a vm running.
>
> Oh, I've just seen that your patch doesn't even get the allocated size,
> it actually determines the highest allocated offset.  Well, those are
> two different things.  You should not return this value via
> qcow2_get_allocated_file_size().  I'm not sure where it should go
> (probably wr_highest_offset?) and how it should be presented in
> qemu-img, though.
>
> Also note that bdrv_get_allocated_file_size() is called by QMP's
> query-named-block-nodes and query-block, both of which are online
> synchronous functions.  It should not take a long time, specifically it
> should not scan the whole qcow2 file.
>
> Max
>
>
