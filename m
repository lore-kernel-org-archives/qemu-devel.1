Received: from eggs.gnu.org ([2001:4830:134:3::10]:55094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dLk47-00026H-OL
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 01:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dLk46-0002B0-K7
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 01:45:03 -0400
References: <20170615030801.6260-1-maozy.fnst@cn.fujitsu.com>
	<20170616002125.GC21807@lemon.lan>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <023d87dd-4cf8-a18e-72cc-a3e94157c305@cn.fujitsu.com>
Date: Fri, 16 Jun 2017 13:43:07 +0800
MIME-Version: 1.0
In-Reply-To: <20170616002125.GC21807@lemon.lan>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] util: remove the obsolete non-blocking
 connect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, mreitz@redhat.com, sheepdog@lists.wpkg.org, Cao jin <caoj.fnst@cn.fujitsu.com>, kraxel@redhat.com, pbonzini@redhat.com, namei.unix@gmail.com



On 06/16/2017 08:21 AM, Fam Zheng wrote:
> On Thu, 06/15 11:08, Mao Zhongyi wrote:
>> From: Cao jin <caoj.fnst@cn.fujitsu.com>
>>
>> The non-blocking connect mechanism is obsolete, and it doesn't
>> work well in inet connection, because it will call getaddrinfo
>> first and getaddrinfo will blocks on DNS lookups. Since commit
>> e65c67e4 & d984464e, the non-blocking connect of migration goes
>> through QIOChannel in a different manner(using a thread), and
>> nobody use this old non-blocking connect anymore.
>>
>> Any newly written code which needs a non-blocking connect should
>> use the QIOChannel code, so we can drop NonBlockingConnectHandler
>> as a concept entirely.
>>
>> Cc: mitake.hitoshi@lab.ntt.co.jp
>> Cc: namei.unix@gmail.com
>> Cc: jcody@redhat.com
>> Cc: kwolf@redhat.com
>> Cc: mreitz@redhat.com
>> Cc: berrange@redhat.com
>> Cc: kraxel@redhat.com
>> Cc: pbonzini@redhat.com
>> Cc: qemu-block@nongnu.org
>> Cc: sheepdog@lists.wpkg.org
>> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> ---
>> This patch was reviewed by Daniel about a years ago, but it has never
>> been merged just since socket_connect() called by net_socket_connect_init()
>> where NonBlockingConnectHandler was passed to socket_connect(). it's broken.
>>
>> Now this problem was worked around by Daniel's patch(commit 6701e551 'Revert
>> "Change net/socket.c to use socket_*() functions" again'). Therefore, resend
>> it, of course, part of related code has changed over the years, so changed
>> the patch accordingly.
>>
>> The reviewed patch listed on:
>> https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg06373.html
>>
>>  block/sheepdog.c       |   2 +-
>>  include/qemu/sockets.h |   9 +--
>>  io/channel-socket.c    |   2 +-
>>  util/qemu-sockets.c    | 198 ++++++-------------------------------------------
>
> As pointed out by patchew, looks like you forgot to update block/ssh.c.
>
> Fam

Hi, Fam

Yes, I have noticed that, but only because the package libssh2-devel missed
in my system which leads to no error reported when I run make & make check.
Now find the reason, so it will be fixed in next version.

Thanks
Mao
