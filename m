Received: from eggs.gnu.org ([2001:4830:134:3::10]:33355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dQQ4e-0005AN-Qt
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 23:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dQQ4b-0005WH-Lp
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 23:24:56 -0400
Received: from [59.151.112.132] (port=10917 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dQQ4b-0005VC-91
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 23:24:53 -0400
References: <cover.1498654240.git.maozy.fnst@cn.fujitsu.com>
	<d9660b46628b52aa8c63c21fe20618b5bc33bb4c.1498654240.git.maozy.fnst@cn.fujitsu.com>
	<20170628131852.GH29134@redhat.com>
	<66fab3ea-5033-851c-ec8e-5740c7108ab7@redhat.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <5183dcbe-9320-f03b-0e45-97e1b6799997@cn.fujitsu.com>
Date: Thu, 29 Jun 2017 11:24:39 +0800
MIME-Version: 1.0
In-Reply-To: <66fab3ea-5033-851c-ec8e-5740c7108ab7@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 1/4] net/socket: Don't treat odd socket
 type as SOCK_STREAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com

Hi, Eric

On 06/28/2017 10:23 PM, Eric Blake wrote:
> On 06/28/2017 08:18 AM, Daniel P. Berrange wrote:
>> On Wed, Jun 28, 2017 at 09:08:47PM +0800, Mao Zhongyi wrote:
>>> In net_socket_fd_init(), the 'default' case is odd: it warns,
>>> then continues as if the socket type was SOCK_STREAM. The
>>> comment explains "this could be a eg. a pty", but that makes
>>> no sense. If @fd really was a pty, getsockopt() would fail
>>> with ENOTSOCK. If @fd was a socket, but neither SOCK_DGRAM nor
>>> SOCK_STREAM. It should not be treated as if it was SOCK_STREAM.
>>>
>>> Turn this case into an Error. If there is a genuine reason to
>>> support something like SOCK_RAW, it should be explicitly
>>> handled.
>>>
>
>>>      default:
>>> -        /* who knows ... this could be a eg. a pty, do warn and continue as stream */
>>> -        fprintf(stderr, "qemu: warning: socket type=%d for fd=%d is not SOCK_DGRAM or SOCK_STREAM\n", so_type, fd);
>>> -        return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
>>> +        error_report("qemu: error: socket type=%d for fd=%d is not"
>>> +                " SOCK_DGRAM or SOCK_STREAM", so_type, fd);
>>
>> Please drop the 'qemu: error: ' prefix on the message
>>
>> Also, rather than 'is not' I suggest 'must be either'
>
> Indentation is also off; we prefer that the second line starts right
> after the ( of the first line, as in:
>
> error_report("part 1"
>              "part 2")

OK, I will. :)

Thanks,
Mao

>
>
