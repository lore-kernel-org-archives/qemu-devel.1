Received: from eggs.gnu.org ([2001:4830:134:3::10]:59015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cbOP8-0006wF-Hd
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 04:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cbOP7-000663-2W
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 04:19:10 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170126123530.GB23095@lemon.Home>
	<20170126132708.GB29127@redhat.com>
	<6a9aeec8-d4ee-a0aa-7e04-0ee4295fef80@redhat.com>
	<8a13c995-c094-2704-c770-214132b2d6cf@redhat.com>
	<20170201121658.GF3232@redhat.com>
	<c4d38998-b862-90e6-6c4b-4b96a8d17bb4@redhat.com>
	<20170201122854.GG3232@redhat.com>
	<37f445c0-c174-bca4-7073-7aa6c64046b0@redhat.com>
	<87bmul9hfc.fsf@dusky.pond.sub.org>
	<d03de140-db6b-26ed-6cc9-958591843483@redhat.com>
	<20170206103104.GD3029@redhat.com>
	<c7b5df9b-f235-ee36-4ab1-3023245b9cd1@redhat.com>
Date: Wed, 08 Feb 2017 10:19:00 +0100
In-Reply-To: <c7b5df9b-f235-ee36-4ab1-3023245b9cd1@redhat.com> (Max Reitz's
	message of "Tue, 7 Feb 2017 23:15:06 +0100")
Message-ID: <87inolujjv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v1 3/6] qemu-img: add support for -n arg to
 dd command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

Max Reitz <mreitz@redhat.com> writes:

> First, because this is perhaps the most important thing: I think I
> remembered what the original proposal to solve all this mess, or at
> least move it to a later point:
>
> We wanted to just disallow overwriting existing files without
> conv=notrunc. I think.
>
> The thing is that it's pretty much impossible with the qemu block layer
> to determine whether a file exists or not. Maybe you cannot open it but
> it would be possible to overwrite it. This is the reason the patches for
> this did not make it into 2.8.

The only sane way to do "create unless it already exists" is
O_CREAT|O_EXCL.  Either you can do that, or you can't.

> On 06.02.2017 11:31, Daniel P. Berrange wrote:
>> On Fri, Feb 03, 2017 at 07:56:11PM +0100, Max Reitz wrote:
>>>> In case you say that's inconvenient: pretty much everything about dd's
>>>> archaic user interface is inconvenient.  If you want convenient, roll
>>>> your own.  If you want familiar, stick to the original.
>>>
>>> I agree. But qemu-img dd already is not dd. It interprets disk image
>>> files as virtual disks instead of as plain files. The question is
>>> whether virtual disks are to be treated as block devices or as files.
>>>
>>> I don't have a strong opinion on the matter. Either way will surprise
>>> some people. The original issue was whether to make nocreat/notrunc a
>>> mandatory option, so if we didn't have any backwards compatibility
>>> issues, it would be the following two surprises:
>>>
>>> (1) Don't make nocreat/notrunc mandatory (as it is now). Then people
>>>     who expect qemu-img dd to treat image files as block devices will
>>>     be surprised that all their data is gone. Bad.
>> 
>> I don't think people really expect qemu-img to treat image file as if
>> they were block devices when operating on the host.
>> 
>> It is like saying people expect /usr/bin/dd to treat a plain file
>> as a block device, because they might use it with losetup later.
>
> That's not a good comparison. Disk images are meant to be used with qemu
> (or some other VMM, or, yes, with losetup if it's a raw image). Plain
> files can be anything. No, dd does not look into the file to determine
> whether it may be a raw disk image or not, but it does execute fstat()
> to find out whether it's a plain file or a block device.

Actually, it doesn't.  coreutils-8.26/src/dd.c:

      mode_t perms = MODE_RW_UGO;
      int opts
        = (output_flags
           | (conversions_mask & C_NOCREAT ? 0 : O_CREAT)
           | (conversions_mask & C_EXCL ? O_EXCL : 0)
           | (seek_records || (conversions_mask & C_NOTRUNC) ? 0 : O_TRUNC));

      /* Open the output file with *read* access only if we might
         need to read to satisfy a 'seek=' request.  If we can't read
         the file, go ahead with write-only access; it might work.  */
      if ((! seek_records
           || ifd_reopen (STDOUT_FILENO, output_file, O_RDWR | opts, perms) < 0)
          && (ifd_reopen (STDOUT_FILENO, output_file, O_WRONLY | opts, perms)
              < 0))
        die (EXIT_FAILURE, errno, _("failed to open %s"),
             quoteaf (output_file));

ifd_reopen() is a wrapper around open() that forces the file descriptor
to a desired value (here: STDOUT_FILENO) and protects against EINTR.

If this doesn't truncate block special for you, it's simply because your
OS interprets it that way, under license from POSIX:

    O_TRUNC
        If the file exists and is a regular file, and the file is
        successfully opened O_RDWR or O_WRONLY, its length is truncated
        to 0 and the mode and owner are unchanged.  It will have no
        effect on FIFO special files or terminal device files.  Its
        effect on other file types is implementation-dependent.  The
        result of using O_TRUNC with O_RDONLY is undefined.

    http://pubs.opengroup.org/onlinepubs/7990989775/xsh/open.html

Ignoring O_TRUNC is the traditional behavior.  But the OS is free to
surprise its applications and users with non-traditional behavior.

[...]
