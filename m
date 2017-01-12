Received: from eggs.gnu.org ([2001:4830:134:3::10]:54270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cRmKp-0002qo-1D
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cRmKn-00035r-MK
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:50:59 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nirsof@gmail.com>) id 1cRmKn-00035b-HY
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:50:57 -0500
Received: by mail-oi0-x244.google.com with SMTP id w144so89513oiw.1
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 12:50:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <750c2d41-dac2-61f7-29c3-82d8d13a0de6@redhat.com>
References: <20170111182455.15160-1-nirsof@gmail.com>
	<750c2d41-dac2-61f7-29c3-82d8d13a0de6@redhat.com>
From: Nir Soffer <nirsof@gmail.com>
Date: Thu, 12 Jan 2017 21:56:45 +0200
Message-ID: <CAMr-obuMJya4nufXNxDU8Axqw9VRWk3t2fPE6thVvStvq1QM-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] qemu-io: Return non-zero exit code on
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Nir Soffer <nsoffer@redhat.com>

On Wed, Jan 11, 2017 at 11:51 PM, Eric Blake <eblake@redhat.com> wrote:
> On 01/11/2017 12:24 PM, Nir Soffer wrote:
>> From: Nir Soffer <nsoffer@redhat.com>
>>
>> The result of openfile was not checked, leading to failure deep in the
>> actual command with confusing error message, and exiting with exit code 0.
>>
>> Here is one example - trying to read a pattern from an invalid chain:
>>
>>     $ qemu-io -c 'read -P 1 0 1024' top.qcow2; echo $?
>
> As written, you have to guess some context about how top.qcow2 was
> created.  The example can be made a bit more reproducible with:
>
> $ : > file
> $ qemu-io -f qcow2 -c ... file

Right, I'll refine it in the next version.

>
>>     can't open device top.qcow2: Could not open backing file: Image is not in qcow2 format
>>     no file open, try 'help open'
>>     0
>>
>> With this patch, we fail earlier with exit code 1:
>>
>>     $ ./qemu-io -c 'read -P 1 0 1024' top.qcow2; echo $?
>>     can't open device top.qcow2: Could not open backing file: Image is not
>>     in qcow2 format
>>     1
>>
>> Signed-off-by: Nir Soffer <nirsof@gmail.com>
>> ---
>>  qemu-io.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> Whether or not the commit message is improved,
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>
