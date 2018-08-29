Received: from eggs.gnu.org ([2001:4830:134:3::10]:60643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fuzpm-0006f9-5n
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fuzen-00076M-Ic
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:33:14 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <8530786e-50b2-3dc2-2f1c-834ccd163b3a@redhat.com>
References: <cover.1535291602.git.berto@igalia.com>
	<599f98e81407a82d8b05764eeac7dbcf5f52142d.1535291602.git.berto@igalia.com>
	<8530786e-50b2-3dc2-2f1c-834ccd163b3a@redhat.com>
Date: Wed, 29 Aug 2018 14:33:08 +0200
Message-ID: <w51o9dl2vzv.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 6/9] file-posix: Forbid trying to change
 unsupported options during reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Wed 29 Aug 2018 01:33:13 PM CEST, Max Reitz wrote:
> On 2018-08-26 16:09, Alberto Garcia wrote:
>> The file-posix code is used for the "file", "host_device" and
>> "host_cdrom" drivers, and it allows reopening images. However the only
>> option that is actually processed is "x-check-cache-dropped", and
>> changes in all other options (e.g. "filename") are silently ignored:
>> 
>>    (qemu) qemu-io virtio0 "reopen -o file.filename=no-such-file"
>> 
>> While we could allow changing some of the other options, let's keep
>> things as they are for now but return an error if the user tries to
>> change any of them.
>> 
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> ---
>>  block/file-posix.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> Looks OK, but the same question from the last patch arises.  If
> unspecified options mean using the default, shouldn't the user have to
> re-specify all mandatory options, so at least @filename in this case?

This is the old (existing) reopen command, which takes the current
options and applies the user-specified changes on top. In this one we
can leave options out because the old values are kept.

It's in the new QMP blockdev-reopen command (not in this series yet)
that you need to specify all options (among other things because it
takes a BlockdevOptions struct, so there's no choice not to specify the
mandatory ones).

Berto
