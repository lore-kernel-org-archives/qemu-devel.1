Received: from eggs.gnu.org ([2001:4830:134:3::10]:46239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jannh@google.com>) id 1chIdp-0006qg-Fo
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:22:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jannh@google.com>) id 1chIdo-0001xp-GJ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:22:45 -0500
Received: from mail-it0-x22d.google.com ([2607:f8b0:4001:c0b::22d]:37360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jannh@google.com>) id 1chIdo-0001wK-C0
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:22:44 -0500
Received: by mail-it0-x22d.google.com with SMTP id 203so27263002ith.0
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 08:22:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b3f08f09-9678-2142-c4d7-5a66f49b173d@redhat.com>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760173919.31154.7555675803159581620.stgit@bahia.lan>
	<20170223151042.GW30636@stefanha-x1.localdomain>
	<20170224113402.07a0fb44@bahia.lan>
	<b3f08f09-9678-2142-c4d7-5a66f49b173d@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 24 Feb 2017 17:22:19 +0100
Message-ID: <CAG48ez2Qgje31AN=MszVtHXoNQj-LGpRfaVZ0iV1kw+_vnq0gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 23/29] 9pfs: local: chmod: don't follow
 symlinks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Feb 24, 2017 at 4:23 PM, Eric Blake <eblake@redhat.com> wrote:
> On 02/24/2017 04:34 AM, Greg Kurz wrote:
>> On Thu, 23 Feb 2017 15:10:42 +0000
>> Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>
>>> On Mon, Feb 20, 2017 at 03:42:19PM +0100, Greg Kurz wrote:
>>>> The local_chmod() callback is vulnerable to symlink attacks because it
>>>> calls:
>>>>
>>>> (1) chmod() which follows symbolic links for all path elements
>>>> (2) local_set_xattr()->setxattr() which follows symbolic links for all
>>>>     path elements
>>>> (3) local_set_mapped_file_attr() which calls in turn local_fopen() and
>>>>     mkdir(), both functions following symbolic links for all path
>>>>     elements but the rightmost one
>>>>
>
>>>> +        fd = local_open_nofollow(fs_ctx, fs_path->data, O_RDONLY, 0);
>>>> +        if (fd == -1) {
>>>> +            return -1;
>>>> +        }
>>>> +        ret = fchmod(fd, credp->fc_mode);
>>>> +        close_preserve_errno(fd);
>>>
>>> As mentioned on IRC, not sure this is workable since chmod(2) must not
>>> require read permission on the file.  This patch introduces failures
>>> when the file isn't readable.
>>>
>>
>> Yeah :-\ This one is the more painful issue to address. I need a
>> chmod() variant that would fail on symlinks instead of following
>> them... and I'm kinda suffering to implement this in a race-free
>> manner.
>
> BSD has lchmod(), but Linux does not.  And Linux does not yet properly
> implement AT_SYMLINK_NOFOLLOW.  (The BSD semantics are pretty cool:
> restricting mode bits on a symlink can create scenarios where some users
> can dereference the symlink but others get ENOENT failures - but I don't
> know of any effort to add those semantics to the Linux kernel)
>
> POSIX says support for AT_SYMLINK_NOFOLLOW is optional, precisely
> because POSIX does not require permissions on symlinks to matter, but
> the way it requires it is that AT_SYMLINK_NOFOLLOW is supposed to be a
> no-op for regular files, and cause an EOPNOTSUPP failure for symlinks.
>
> Unfortunately, the Linux man page says that Linux fails with ENOTSUP
> (which is identical to EOPNOTSUPP) any time AT_SYMLINK_NOFOLLOW is set,
> and not just if it is attempted on a symlink.

And unfortunately, that flags argument is not actually present in the
real syscall.
See this glibc code:

int
fchmodat (int fd, const char *file, mode_t mode, int flag)
{
  if (flag & ~AT_SYMLINK_NOFOLLOW)
    return INLINE_SYSCALL_ERROR_RETURN_VALUE (EINVAL);
#ifndef __NR_lchmod /* Linux so far has no lchmod syscall.  */
  if (flag & AT_SYMLINK_NOFOLLOW)
    return INLINE_SYSCALL_ERROR_RETURN_VALUE (ENOTSUP);
#endif

  return INLINE_SYSCALL (fchmodat, 3, fd, file, mode);
}

and this kernel code:

SYSCALL_DEFINE3(fchmodat, int, dfd, const char __user *, filename,
umode_t, mode)
{
  [...]
}

So to fix this, you'll probably have to add a new syscall fchmodat2()
to the kernel,
wire it up for all the architectures and get the various libc
implementations to adopt
that. That's going to be quite tedious. :(
