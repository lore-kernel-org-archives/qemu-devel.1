Received: from eggs.gnu.org ([2001:4830:134:3::10]:52373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKEJ0-0007AY-W1
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 21:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKEIx-00073n-Rs
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 21:38:10 -0400
Received: from [59.151.112.132] (port=16656 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKEIx-00073T-GC
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 21:38:07 -0400
References: <cover.1496924675.git.maozy.fnst@cn.fujitsu.com>
	<92b1a896753cc1b2a1200f5a525bad314152cdd9.1496924675.git.maozy.fnst@cn.fujitsu.com>
	<87shj9i9du.fsf@dusky.pond.sub.org>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <d805d523-603c-d096-0dc1-b250c94d318f@cn.fujitsu.com>
Date: Mon, 12 Jun 2017 09:36:46 +0800
MIME-Version: 1.0
In-Reply-To: <87shj9i9du.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/4] net/socket: Drop the odd 'default'
 case and comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com

Hi, Markus

On 06/09/2017 09:22 PM, Markus Armbruster wrote:
> Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:
>
>> In the net_socket_fd_init(), the 'default' case and comment is odd.
>> If @fd really was a pty, getsockopt() would fail with ENOTSOCK. If
>> @fd was a socket, but neither SOCK_DGRAM nor SOCK_STREAM. It should
>> not be treated as if it was SOCK_STREAM.
>>
>> If there is a genuine reason to support something like SOCK_RAW, it
>> should be explicitly handled.
>>
>> So, drop the 'default' case since it is broken already.
>>
>> Cc: jasowang@redhat.com
>> Cc: armbru@redhat.com
>> Cc: berrange@redhat.com
>> Cc: armbru@redhat.com
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> ---
>>  net/socket.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/socket.c b/net/socket.c
>> index dcae1ae..a503cfe 100644
>> --- a/net/socket.c
>> +++ b/net/socket.c
>> @@ -449,9 +449,9 @@ static NetSocketState *net_socket_fd_init(NetClientState *peer,
>>      case SOCK_STREAM:
>>          return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
>>      default:
>> -        /* who knows ... this could be a eg. a pty, do warn and continue as stream */
>> -        fprintf(stderr, "qemu: warning: socket type=%d for fd=%d is not SOCK_DGRAM or SOCK_STREAM\n", so_type, fd);
>> -        return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
>> +        fprintf(stderr, "qemu: error: socket type=%d for fd=%d is not"
>> +                " SOCK_DGRAM or SOCK_STREAM\n", so_type, fd);
>> +        closesocket(fd);
>>      }
>>      return NULL;
>>  }
>
> Please use error_report() here.

OK, I see, will fix it in v4.

Thanks
Mao
