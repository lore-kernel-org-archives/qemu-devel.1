Received: from eggs.gnu.org ([209.51.188.92]:60506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ggmx9-0004EK-Ci
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 03:41:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ggmx6-00088v-OK
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 03:41:39 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1ggmx6-0007wH-Dr
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 03:41:36 -0500
Received: by mail-wm1-x342.google.com with SMTP id b11so3254937wmj.1
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 00:41:33 -0800 (PST)
References: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
	<20181222095036.29743-3-marcel.apfelbaum@gmail.com>
	<20190103113414.503eed8b.cohuck@redhat.com>
	<bed8bcb6-67ca-b8c5-ffbe-684241fe2b70@gmail.com>
	<20190107185417.6d6dbe59.cohuck@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <3857c98f-66ff-0c7f-e588-b5e098626267@gmail.com>
Date: Tue, 8 Jan 2019 10:41:38 +0200
MIME-Version: 1.0
In-Reply-To: <20190107185417.6d6dbe59.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 1/7/19 7:54 PM, Cornelia Huck wrote:
> On Mon, 7 Jan 2019 19:28:10 +0200
> Marcel Apfelbaum <marcel.apfelbaum@gmail.com> wrote:
>
>> On 1/3/19 12:34 PM, Cornelia Huck wrote:
>>> On Sat, 22 Dec 2018 11:50:07 +0200
>>> Marcel Apfelbaum <marcel.apfelbaum@gmail.com> wrote:
>>>   
>>>> From: Yuval Shaia <yuval.shaia@oracle.com>
>>>>
>>>> RDMA MAD kernel module (ibcm) disallow more than one MAD-agent for a
>>>> given MAD class.
>>>> This does not go hand-by-hand with qemu pvrdma device's requirements
>>>> where each VM is MAD agent.
>>>> Fix it by adding implementation of RDMA MAD multiplexer service which on
>>>> one hand register as a sole MAD agent with the kernel module and on the
>>>> other hand gives service to more than one VM.
>>>>
>>>> Design Overview:
>>>> Reviewed-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
>>>> ----------------
>>>> A server process is registered to UMAD framework (for this to work the
>>>> rdma_cm kernel module needs to be unloaded) and creates a unix socket to
>>>> listen to incoming request from clients.
>>>> A client process (such as QEMU) connects to this unix socket and
>>>> registers with its own GID.
>>>>
>>>> TX:
>>>> ----
>>>> When client needs to send rdma_cm MAD message it construct it the same
>>>> way as without this multiplexer, i.e. creates a umad packet but this
>>>> time it writes its content to the socket instead of calling umad_send().
>>>> The server, upon receiving such a message fetch local_comm_id from it so
>>>> a context for this session can be maintain and relay the message to UMAD
>>>> layer by calling umad_send().
>>>>
>>>> RX:
>>>> ----
>>>> The server creates a worker thread to process incoming rdma_cm MAD
>>>> messages. When an incoming message arrived (umad_recv()) the server,
>>>> depending on the message type (attr_id) looks for target client by
>>>> either searching in gid->fd table or in local_comm_id->fd table. With
>>>> the extracted fd the server relays to incoming message to the client.
>>>>
>>>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>>>> Reviewed-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
>>>> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>>>
>>>> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>>> ---
>>>>    MAINTAINERS                      |   1 +
>>>>    Makefile                         |   3 +
>>>>    Makefile.objs                    |   1 +
>>>>    contrib/rdmacm-mux/Makefile.objs |   4 +
>>>>    contrib/rdmacm-mux/main.c        | 798 +++++++++++++++++++++++++++++++
>>>>    contrib/rdmacm-mux/rdmacm-mux.h  |  61 +++
>>>>    6 files changed, 868 insertions(+)
>>>>    create mode 100644 contrib/rdmacm-mux/Makefile.objs
>>>>    create mode 100644 contrib/rdmacm-mux/main.c
>>>>    create mode 100644 contrib/rdmacm-mux/rdmacm-mux.h
>>> This commit breaks building with clang on Fedora 28 for me; I get a
>>> bunch of
>>>   
>> Hi Cornelia,
>> Thanks for spotting the issue.
>>
>>> clang-6.0: error: -libumad: 'linker' input unused [-Werror,-Wunused-command-line-argument]
>> Is really strange, the rdma-mux is part of the contrib directory
>> and is not even compiled by default.
>>
>>> Explicitly passing --disable-pvrdma to configure disables the offending
>>> code.
>>>
>>> Let me know if you need more information.
>> Can you please send the exact steps you are using to configure and
>> compile QEMU,
>> are you compiling on a x86 machine?
> Yes, this is on my laptop (up-to-date F28). I can reproduce on current
> master, configured with
>
> ../configure --target-list="s390x-softmmu s390x-linux-user i386-softmmu x86_64-softmmu cris-softmmu arm-softmmu ppc64-softmmu" --enable-linux-aio --enable-virtfs --enable-trace-backends=simple --cc=clang --enable-rdma --enable-pvrdma
>
> It compiles if I pass --disable-pvrdma instead. It also compiles if I
> drop --cc=clang.
>
> I'm building in a build subdirectory; I have already tried purging it
> before rebuilding, without luck.
>
> clang --version says
>
> clang version 6.0.1 (tags/RELEASE_601/final)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin

Thanks for the information, I will look into it.
Marcel
