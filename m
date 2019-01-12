Received: from eggs.gnu.org ([209.51.188.92]:60236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1giG2G-0001kb-Ms
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 04:57:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1giFrT-00062h-3P
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 04:45:51 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1giFrS-00061L-TJ
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 04:45:51 -0500
Received: by mail-wr1-x442.google.com with SMTP id t6so17622776wrr.12
	for <qemu-devel@nongnu.org>; Sat, 12 Jan 2019 01:45:50 -0800 (PST)
References: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
	<20181222095036.29743-3-marcel.apfelbaum@gmail.com>
	<20190103113414.503eed8b.cohuck@redhat.com>
	<bed8bcb6-67ca-b8c5-ffbe-684241fe2b70@gmail.com>
	<20190107185417.6d6dbe59.cohuck@redhat.com>
	<3857c98f-66ff-0c7f-e588-b5e098626267@gmail.com>
	<20190108101836.48313b3e.cohuck@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <deb41c8a-759d-1ce4-39e6-017158074e66@gmail.com>
Date: Sat, 12 Jan 2019 11:46:00 +0200
MIME-Version: 1.0
In-Reply-To: <20190108101836.48313b3e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH PULL 02/31] contrib/rdmacm-mux: Add
 implementation of RDMA User MAD multiplexer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, yuval.shaia@oracle.com, pjp@fedoraproject.org



On 1/8/19 11:18 AM, Cornelia Huck wrote:
> On Tue, 8 Jan 2019 10:41:38 +0200
> Marcel Apfelbaum <marcel.apfelbaum@gmail.com> wrote:
>
>> On 1/7/19 7:54 PM, Cornelia Huck wrote:
>>> On Mon, 7 Jan 2019 19:28:10 +0200
>>> Marcel Apfelbaum <marcel.apfelbaum@gmail.com> wrote:
>>>   
>>>> On 1/3/19 12:34 PM, Cornelia Huck wrote:
>>>>> clang-6.0: error: -libumad: 'linker' input unused [-Werror,-Wunused-command-line-argument]
>>>> Is really strange, the rdma-mux is part of the contrib directory
>>>> and is not even compiled by default.
>>>>   
>>>>> Explicitly passing --disable-pvrdma to configure disables the offending
>>>>> code.
>>>>>
>>>>> Let me know if you need more information.
>>>> Can you please send the exact steps you are using to configure and
>>>> compile QEMU,
>>>> are you compiling on a x86 machine?
>>> Yes, this is on my laptop (up-to-date F28). I can reproduce on current
>>> master, configured with
>>>
>>> ../configure --target-list="s390x-softmmu s390x-linux-user i386-softmmu x86_64-softmmu cris-softmmu arm-softmmu ppc64-softmmu" --enable-linux-aio --enable-virtfs --enable-trace-backends=simple --cc=clang --enable-rdma --enable-pvrdma
>>>
>>> It compiles if I pass --disable-pvrdma instead. It also compiles if I
>>> drop --cc=clang.
>>>
>>> I'm building in a build subdirectory; I have already tried purging it
>>> before rebuilding, without luck.
>>>
>>> clang --version says
>>>
>>> clang version 6.0.1 (tags/RELEASE_601/final)
>>> Target: x86_64-unknown-linux-gnu
>>> Thread model: posix
>>> InstalledDir: /usr/bin
>> Thanks for the information, I will look into it.
>> Marcel
> Thanks.
>
> Another data point: I see the same on a Fedora 29 on s390x, so this
> does not seem to be a broken local setup (unless I managed to mess up
> both systems in the same way...) clang --version says
>
> clang version 7.0.0 (Fedora 7.0.0-2.fc29)
> Target: s390x-ibm-linux
> Thread model: posix
> InstalledDir: /usr/bin

Hi Cornelia,
I reproduced the issue and found the root cause:
    contrib/rdmacm-mux/Makefile.objs:
        ifdef CONFIG_PVRDMA
        CFLAGS += -libumad -Wno-format-truncation
        rdmacm-mux-obj-y = main.o
        endif

The above file adds libumad dependency for all project targets even if 
not needed.
Gcc allows that while clang forbids it. (is strange it passed patchew tests)

I will come up with a fix soon.

Thanks,
Marcel
