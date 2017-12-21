Received: from eggs.gnu.org ([2001:4830:134:3::10]:38778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eRreM-00066Y-Fz
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 22:36:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eRreJ-0003uz-7X
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 22:36:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eRreJ-0003uB-2A
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 22:35:59 -0500
References: <D9DE8DBB19F2A24080482022C1DE758302C51EF0@dggemm509-mbx.china.huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0da086fe-8ba2-7e31-f9d4-f9e4422eedb8@redhat.com>
Date: Wed, 20 Dec 2017 21:35:52 -0600
MIME-Version: 1.0
In-Reply-To: <D9DE8DBB19F2A24080482022C1DE758302C51EF0@dggemm509-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 02/46] qemu-thread: fix races on threads
 that exit very quickly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "famz@redhat.com" <famz@redhat.com>
Cc: "wangxin (U)" <wangxinxin.wang@huawei.com>

On 12/20/2017 09:29 PM, linzhecheng wrote:

>> +} QemuThreadArgs;
>> +
>> +static void *qemu_thread_start(void *args) {
>> +    QemuThreadArgs *qemu_thread_args = args;
>> +    void *(*start_routine)(void *) = qemu_thread_args->start_routine;
>> +    void *arg = qemu_thread_args->arg;
>> +
>> +    /* Attempt to set the threads name; note that this is for debug, so
>> +     * we're not going to fail if we can't set it.
>> +     */
>> +    pthread_setname_np(pthread_self(), qemu_thread_args->name);
>> +    g_free(qemu_thread_args->name);
>> +    g_free(qemu_thread_args);
> If qemu_thread_args is freed here, start_routine(arg) will lead to use after free because arg equals to qemu_thread_args

No, we explicitly copied qemu_thread_args->arg into a local variable 
prior to freeing qemu_thread_args, so that we do not have to dereference 
the freed variable.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
