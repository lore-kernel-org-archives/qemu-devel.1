Received: from eggs.gnu.org ([2001:4830:134:3::10]:50588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dn4IZ-0007vk-4l
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dn4IW-0000WP-GM
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:48:55 -0400
References: <1504100343-26607-1-git-send-email-thuth@redhat.com>
	<20170830161327.4b199e9a.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9ce5a57f-a2b9-a7d0-fd88-639fb8f2e062@redhat.com>
Date: Wed, 30 Aug 2017 16:48:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170830161327.4b199e9a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] hw/misc/ivshmem: Fix
 ivshmem_recv_msg() to also work on big endian systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 30.08.2017 16:13, Cornelia Huck wrote:
> On Wed, 30 Aug 2017 15:39:03 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> The "slow" ivshmem-tests currently fail when they are running on a
>> big endian host:
>>
>> $ uname -m
>> ppc64
>> $ V=1 QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 tests/ivshmem-test -m slow
>> /x86_64/ivshmem/single: OK
>> /x86_64/ivshmem/hotplug: OK
>> /x86_64/ivshmem/memdev: OK
>> /x86_64/ivshmem/pair: OK
>> /x86_64/ivshmem/server-msi: qemu-system-x86_64:
>>  -device ivshmem-doorbell,chardev=chr0,vectors=2: server sent invalid ID message
>> Broken pipe
>>
>> The problem is that the server side code in ivshmem_server_send_one_msg()
>> correctly translates all messages IDs into little endian 64-bit values,
>> but the client side code in the ivshmem_recv_msg() function does not swap
>> the byte order back. Fix it by passing the value through le64_to_cpu().
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
[...]
> This fixes the "invalid ID message" problem on s390x for me as well,
> and I run now into the same error as on x86 (which you also have a fix
> for IIRC)
Yes, you also need my other patch, look for "tests: Fix broken
ivshmem-server-msi/-irq tests" on the list.

 Thomas
