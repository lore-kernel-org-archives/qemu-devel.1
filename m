Received: from eggs.gnu.org ([209.51.188.92]:51982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1Eja-0007Bl-7f
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:24:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1EjZ-0001LK-EX
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:24:10 -0500
References: <w51y35tb8ul.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f2fab5f3-9321-9dac-450c-429caf9e55fb@redhat.com>
Date: Tue, 5 Mar 2019 12:24:02 -0600
MIME-Version: 1.0
In-Reply-To: <w51y35tb8ul.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] iotest 223 is flaky
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

On 3/5/19 10:10 AM, Alberto Garcia wrote:
> I can make it fail by running it a few times:
> 
> 223 1s ... - output mismatch (see 223.out.bad)
> --- tests/qemu-iotests/223.out       2019-02-08 17:25:15.584387100 +0200
> +++ tests/qemu-iotests/223.out.bad     2019-03-05 18:05:16.855223976 +0200
> @@ -92,9 +92,10 @@
>   
>   === Use qemu-nbd as server ===
>   
> -[{ "start": 0, "length": 65536, "depth": 0, "zero": false, "data": false},
> -{ "start": 65536, "length": 2031616, "depth": 0, "zero": false, "data": true},
> -{ "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data": false}]
> +qemu-nbd: Failed to blk_new_open 'tests/qemu-iotests/scratch/t.qcow2': Failed to get shared "write" lock
> +Is another process using the image [tests/qemu-iotests/scratch/t.qcow2]?

I haven't been able to reproduce it yet, but see what might be the problem:

_send_qemu_cmd $QEMU_HANDLE '{"execute":"quit"}' "return"

echo
echo "=== Use qemu-nbd as server ==="
echo

nbd_server_start_unix_socket -r -f $IMGFMT -B b "$TEST_IMG"

There was nothing in the qemu process to let go of t.qcow2 prior to the 
quit request. And although the quit command may have had time to reply 
over the socket that the command was accepted, there may still be a 
delay before the process actually dies, where under sufficient load, the 
qemu-nbd process can start up during that window.

Patch coming up; since I couldn't reproduce the failure, I'd appreciate 
if you could confirm if it seems to help in your setup.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
