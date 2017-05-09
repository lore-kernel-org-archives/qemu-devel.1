Received: from eggs.gnu.org ([2001:4830:134:3::10]:39667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d7u1d-00064G-U4
	for qemu-devel@nongnu.org; Mon, 08 May 2017 21:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d7u1Z-0004Lt-UI
	for qemu-devel@nongnu.org; Mon, 08 May 2017 21:33:17 -0400
Received: from [59.151.112.132] (port=21909 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d7u1Z-00040D-Ho
	for qemu-devel@nongnu.org; Mon, 08 May 2017 21:33:13 -0400
References: <cover.1493191677.git.maozy.fnst@cn.fujitsu.com>
	<20170505163912.GN12773@redhat.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <c459b7ff-edc5-eac7-253c-52f80dbfc639@cn.fujitsu.com>
Date: Tue, 9 May 2017 09:26:07 +0800
MIME-Version: 1.0
In-Reply-To: <20170505163912.GN12773@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Convert non-blocking connect and
 fix its error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: pbonzini@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, kraxel@redhat.com



On 05/06/2017 12:39 AM, Daniel P. Berrange wrote:
> On Wed, Apr 26, 2017 at 04:04:14PM +0800, Mao Zhongyi wrote:
>> v2:
>> * PATCH 02 reworking of patch 2 following Markus's suggestion that convert error_report()
>>   in the function called by net_socket_*_init() to Error. Also add many error handling
>>   information.
>> * PATCH 03 net_socket_mcast_create(), net_socket_fd_init_dgram() and net_socket_fd_init()
>>   use the function such as fprintf, perror to report an error message. Convert it to Error.
>> * PATCH 04 parse_host_port() may fail without reporting an error. Now, fix it to set an
>>   error when it fails.
>
> FYI, I discovered that previous change
>
>   commit 883e4f7624e10b98d16d9adaffb8b1795664d899
>   Author: Marc-André Lureau <marcandre.lureau@redhat.com>
>   Date:   Sat Jun 18 13:24:02 2016 +0530
>
>     Change net/socket.c to use socket_*() functions
>
> has seriously broken the current code because net_socket_fd_init()
> was not called from the right place. Fixing the current code is
> somewhat painful, so I've sent a revert of that broken patch.
>
> To demo the problem first run:
>
>   $ ./x86_64-softmmu/qemu-system-x86_64  \
>       -device e1000,id=e0,netdev=user.0,mac=DE:AD:BE:EF:AF:04 \
>       -netdev socket,id=user.0,listen=:1234
>
> and then run:
>
>    $ ./x86_64-softmmu/qemu-system-x86_64 \
>            -device e1000,id=e0,netdev=hn0,mac=DE:AD:BE:EF:AF:05 \
>            -netdev socket,id=hn0,connect=localhost:1234
>
> currently the second command fails with
>
>   qemu-system-x86_64: -device e1000,id=e0,netdev=hn0,mac=DE:AD:BE:EF:AF:05: Property 'e1000.netdev' can't find value 'hn0'
>
> and my revert fixes that. Just something for you to test with your
> new patch series...
>
> Regards,
> Daniel

Hi, Daniel

According to your latest advice, run these two commands in my new
patch, the second command reported the same error.

Now, you sent a revert of that broken patch to avoid this problem.
It also means that my first patch based on socket_*() is disabled.
Currently, there is no good way to convert it use QIOchannel. So I
have an idea to use the reverted patch instead of the first of my
series, and then based on the first to fix the rest. Latter I will
convert it to QIOchannel in a separated patch. Do you think that's
ok?

Looking forward to your opinion.

Thanks
Mao
