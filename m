Received: from eggs.gnu.org ([2001:4830:134:3::10]:38101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1em1qm-0006H6-Uz
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:32:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1em1qm-0000Xa-2P
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:32:12 -0500
References: <1518624560-38060-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1518624560-38060-2-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <188eaa75-9562-0492-6fb6-4b45cadc0a28@redhat.com>
Date: Wed, 14 Feb 2018 12:31:55 -0600
MIME-Version: 1.0
In-Reply-To: <1518624560-38060-2-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] iotest 033: add misaligned
 write-zeroes test via truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, berto@igalia.com

On 02/14/2018 10:09 AM, Anton Nefedov wrote:
> This new test case only makes sense for qcow2 while iotest 033 is generic;
> however it matches the test purpose perfectly and also 033 contains those
> do_test() tricks to pass the alignment, which won't look nice being
> duplicated in other tests or moved to the common code.
> 
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>   tests/qemu-iotests/033     | 29 +++++++++++++++++++++++++++++
>   tests/qemu-iotests/033.out | 13 +++++++++++++
>   2 files changed, 42 insertions(+)
> 

> +# only interested in qcow2 here; also other formats might respond with
> +#  "not supported" error message
> +if [ $IMGFMT = "qcow2" ]; then
> +    do_test 512 "truncate $L2_COVERAGE" "$TEST_IMG" | _filter_qemu_io
> +fi

But without an else branch that echoes the same text as the if branch 
generates, your .out file is now broken for other image formats.  Or 
does 'qemu-io -c truncate' not produce output?

/me goes and tests...

Okay, looks like truncate is silent; and that the truncation (or 
skipping of the truncation) doesn't affect things.

Tested-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
