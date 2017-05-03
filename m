Received: from eggs.gnu.org ([2001:4830:134:3::10]:46525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d5sky-0005kr-A9
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d5skv-0008VF-7N
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:47:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d5sku-0008U0-UN
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:47:41 -0400
References: <cover.1493191677.git.maozy.fnst@cn.fujitsu.com>
	<2bc05de0edd61cdcdd3d2b894378a874d1e12327.1493191677.git.maozy.fnst@cn.fujitsu.com>
	<87shktu8cu.fsf@dusky.pond.sub.org> <20170427163025.GD30599@redhat.com>
	<87lgqlnenh.fsf@dusky.pond.sub.org>
	<23e5dc02-3e69-2166-c18b-786fc75172ff@cn.fujitsu.com>
	<87efw648x9.fsf@dusky.pond.sub.org>
	<d997f3b8-9cb9-09d8-14de-71c848cf18c2@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ea3f29d7-a769-d6fb-7331-6a90aff94e8e@redhat.com>
Date: Wed, 3 May 2017 19:47:33 +0800
MIME-Version: 1.0
In-Reply-To: <d997f3b8-9cb9-09d8-14de-71c848cf18c2@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/4] net/socket: Convert error report
 message to Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, Markus Armbruster <armbru@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org



On 2017=E5=B9=B405=E6=9C=8803=E6=97=A5 16:59, Mao Zhongyi wrote:
>
>
> On 05/03/2017 04:54 PM, Markus Armbruster wrote:
>> Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:
>>
>>> Hi, Markus,Daniel
>>>
>>> On 04/28/2017 04:02 PM, Markus Armbruster wrote:
>>>> "Daniel P. Berrange" <berrange@redhat.com> writes:
>>>>
>>>>> On Thu, Apr 27, 2017 at 06:24:17PM +0200, Markus Armbruster wrote:
>>>>>> No review, just an observation.
>>>>>>
>>>>>> Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:
>>>>>>
>>>>>>> Currently, net_socket_mcast_create(), net_socket_fd_init_dgram()=20
>>>>>>> and
>>>>>>> net_socket_fd_init() use the function such as fprintf(),=20
>>>>>>> perror() to
>>>>>>> report an error message.
>>>>>>>
>>>>>>> Now, convert these functions to Error.
>>>>>>>
>>>>>>> CC: jasowang@redhat.com, armbru@redhat.com
>>>>>>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>>>>>>> ---
>>>>>>>  net/socket.c | 66=20
>>>>>>> +++++++++++++++++++++++++++++++++++++-----------------------
>>>>>>>  1 file changed, 41 insertions(+), 25 deletions(-)
>>>>>>>
>>>>>>> diff --git a/net/socket.c b/net/socket.c
>>>>>>> index b0decbe..559e09a 100644
>>>>>>> --- a/net/socket.c
>>>>>>> +++ b/net/socket.c
>>>>>> [...]
>>>>>>> @@ -433,25 +437,27 @@ static NetSocketState=20
>>>>>>> *net_socket_fd_init_stream(NetClientState *peer,
>>>>>>>
>>>>>>>  static NetSocketState *net_socket_fd_init(NetClientState *peer,
>>>>>>>                                            const char *model,=20
>>>>>>> const char *name,
>>>>>>> -                                          int fd, int=20
>>>>>>> is_connected)
>>>>>>> +                                          int fd, int=20
>>>>>>> is_connected,
>>>>>>> +                                          Error **errp)
>>>>>>>  {
>>>>>>>      int so_type =3D -1, optlen=3Dsizeof(so_type);
>>>>>>>
>>>>>>>      if(getsockopt(fd, SOL_SOCKET, SO_TYPE, (char *)&so_type,
>>>>>>>          (socklen_t *)&optlen)< 0) {
>>>>>>> -        fprintf(stderr, "qemu: error: getsockopt(SO_TYPE) for=20
>>>>>>> fd=3D%d failed\n",
>>>>>>> +        error_setg(errp, "qemu: error: getsockopt(SO_TYPE) for=20
>>>>>>> fd=3D%d failed",
>>>>>>>                  fd);
>>>>>>>          closesocket(fd);
>>>>>>>          return NULL;
>>>>>>>      }
>>>>>>>      switch(so_type) {
>>>>>>>      case SOCK_DGRAM:
>>>>>>> -        return net_socket_fd_init_dgram(peer, model, name, fd,=20
>>>>>>> is_connected);
>>>>>>> +        return net_socket_fd_init_dgram(peer, model, name, fd,=20
>>>>>>> is_connected, errp);
>>>>>>>      case SOCK_STREAM:
>>>>>>>          return net_socket_fd_init_stream(peer, model, name, fd,=20
>>>>>>> is_connected);
>>>>>>>      default:
>>>>>>>          /* who knows ... this could be a eg. a pty, do warn and=20
>>>>>>> continue as stream */
>>>>>>> -        fprintf(stderr, "qemu: warning: socket type=3D%d for=20
>>>>>>> fd=3D%d is not SOCK_DGRAM or SOCK_STREAM\n", so_type, fd);
>>>>>>> +        error_setg(errp, "qemu: warning: socket type=3D%d for=20
>>>>>>> fd=3D%d is not SOCK_DGRAM"
>>>>>>> +                   " or SOCK_STREAM", so_type, fd);
>>>>>>
>>>>>> Not this patches problem: this case is odd, and the comment is=20
>>>>>> bogus.
>>>>>> If @fd really was a pty, getsockopt() would fail with ENOTSOCK,=20
>>>>>> wouldn't
>>>>>> it?  If @fd is a socket, but neither SOCK_DGRAM nor SOCK_STREAM (s=
ay
>>>>>> SOCK_RAW), why is it safe to continue as if it was SOCK_STREAM? =20
>>>>>> Jason?
>>>>>
>>>>> IMHO it is a problem with this patch. Previously we merely printed
>>>>> a warning & carried on, which is conceptually ok in general, though
>>>>> dubious here for the reason you say.
>>>>>
>>>>> Now we are filling an Error **errp object, and carrying on - this i=
s
>>>>> conceptually broken anywhere. If an Error ** is filled, we must=20
>>>>> return.
>>>>> If we want to carry on, we shouldn't fill Error **.
>>>>
>>>> You're right.
>>>>
>>>>>>>          return net_socket_fd_init_stream(peer, model, name, fd,=20
>>>>>>> is_connected);
>>>>>
>>>>> IMHO, we just kill this and put return NULL here. If there is a=20
>>>>> genuine
>>>>> reason to support something like SOCK_RAW, it should be explicitly
>>>>> handled, because this default: case will certainly break=20
>>>>> SOCK_SEQPACKET
>>>>> and SOCK_RDM which can't be treated as streams.
>>>>
>>>> It's either magic or misguided defensive programming. Probably the
>>>> latter, but I'd like to hear Jason's opinion.
>>>>
>>>> If it's *necessary* magic, we can't use error_setg().  Else, we shou=
ld
>>>> drop the default, and insert a closesocket(fd) before the final retu=
rn
>>>> NULL.
>>>
>>> As Daniel said, although the previous printed warning message is
>>> dubious, but it is conceptually ok in general. Simply filling it to
>>> Error ** is problematic. Of course, as you said drop the default case=
,
>>> there will be no problem. But really to do that?
>>
>> Since Jason hasn't spoken up, I suggest you follow Dan's recommendatio=
n
>> and insert a patch to drop the default case before your error rework.
>>
>>
>>
>
> I see, will drop the 'default' case in a separated patch.
>
> Thanks.

Sorry for the late. I agree to drop the default. Even SOCK_RAW could not=20
work as stream and any type should be supported explicitly.

Thanks
