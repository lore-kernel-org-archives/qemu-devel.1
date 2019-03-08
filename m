Received: from eggs.gnu.org ([209.51.188.92]:36809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1h2Bem-0005YI-7k
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1h2Bej-0008Nm-BH
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1h2Bei-0008Ks-H8
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:05 -0500
References: <20181109195653.11867-1-marcandre.lureau@redhat.com>
	<dcc8d960-e970-b8b9-f17c-8cba0c871d0b@redhat.com>
	<CAMxuvaz5mM6hVR=HknCLO27+zQsuxij1F2Jzgr7yVuLAP52Jog@mail.gmail.com>
	<760d978d-2edb-9576-455f-120ca689493c@redhat.com>
	<CAJ+F1C+jfoirwxzh8ERGxpbwwCHZTtCLk+-_eq2G+42YRmiHDQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0c80c7cb-49c0-e631-6ad4-13e6f2149c64@redhat.com>
Date: Fri, 8 Mar 2019 17:18:59 +0800
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+jfoirwxzh8ERGxpbwwCHZTtCLk+-_eq2G+42YRmiHDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] RFC: net/socket: learn to talk with a unix
 dgram socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Richard Jones <rjones@redhat.com>


On 2019/3/8 =E4=B8=8A=E5=8D=8812:18, Marc-Andr=C3=A9 Lureau wrote:
> Hi Jason
>
> On Thu, Nov 15, 2018 at 3:39 AM Jason Wang<jasowang@redhat.com>  wrote:
>> On 2018/11/14 =E4=B8=8B=E5=8D=889:01, Marc-Andr=C3=A9 Lureau wrote:
>>> Hi
>>>
>>> On Wed, Nov 14, 2018 at 7:46 AM Jason Wang<jasowang@redhat.com>  wrot=
e:
>>>> On 2018/11/10 =E4=B8=8A=E5=8D=883:56, Marc-Andr=C3=A9 Lureau wrote:
>>>>> -net socket has a fd argument, and may be passed pre-opened sockets=
.
>>>>>
>>>>> TCP sockets use framing.
>>>>> UDP sockets have datagram boundaries.
>>>>>
>>>>> When given a unix dgram socket, it will be able to read from it, bu=
t
>>>>> will attempt to send on the dgram_dst, which is unset. The other en=
d
>>>>> will not receive the data.
>>>>>
>>>>> Let's teach -net socket to recognize a UNIX DGRAM socket, and use t=
he
>>>>> regular send() command (without dgram_dst).
>>>>>
>>>>> This makes running slirp out-of-process possible that
>>>>> way (python pseudo-code):
>>>>>
>>>>> a, b =3D socket.socketpair(socket.AF_UNIX, socket.SOCK_DGRAM)
>>>>>
>>>>> subprocess.Popen('qemu -net socket,fd=3D%d -net user' % a.fileno(),=
 shell=3DTrue)
>>>>> subprocess.Popen('qemu ... -net nic -net socket,fd=3D%d' % b.fileno=
(), shell=3DTrue)
>>>>>
>>>>> (to make slirp a seperate project altogether, we would have to have
>>>>> some compatibility code and/or deprecate various options & HMP
>>>>> commands for dynamic port forwarding etc - but this looks like a
>>>>> reachable goal)
>>>>>
>>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau<marcandre.lureau@redhat.com>
>>>> I believe instead of supporting unnamed sockets, we should also supp=
ort
>>>> named one through cli?
>>> This could be a later patch, I have no need for it yet. Perhaps it
>>> should be a chardev then?
>> I mean something like: -socket id=3Dud0,path=3D/tmp/XXX
>>
> Why not, but I have no need for it. If somebody has, he can make a patc=
h.
>
>>>>> ---
>>>>>     net/socket.c | 25 +++++++++++++++++++++----
>>>>>     1 file changed, 21 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/net/socket.c b/net/socket.c
>>>>> index 7095eb749f..8a9c30892d 100644
>>>>> --- a/net/socket.c
>>>>> +++ b/net/socket.c
>>>>> @@ -119,9 +119,13 @@ static ssize_t net_socket_receive_dgram(NetCli=
entState *nc, const uint8_t *buf,
>>>>>         ssize_t ret;
>>>>>
>>>>>         do {
>>>>> -        ret =3D qemu_sendto(s->fd, buf, size, 0,
>>>>> -                          (struct sockaddr *)&s->dgram_dst,
>>>>> -                          sizeof(s->dgram_dst));
>>>>> +        if (s->dgram_dst.sin_family !=3D AF_UNIX) {
>>>>> +            ret =3D qemu_sendto(s->fd, buf, size, 0,
>>>>> +                              (struct sockaddr *)&s->dgram_dst,
>>>>> +                              sizeof(s->dgram_dst));
>>>>> +        } else {
>>>>> +            ret =3D send(s->fd, buf, size, 0);
>>>>> +        }
>>>> Any reason that send is a must here? send(2) said:
>>>>           call
>>>>
>>>>               send(sockfd, buf, len, flags);
>>>>
>>>>           is equivalent to
>>>>
>>>>               sendto(sockfd, buf, len, flags, NULL, 0);
>>> Yes they should be equivalent, but then we need to add ?: operators
>>> for the dest arguments. I preferred to have an if() instead.
>>>
>>> thanks
>> One possible issue here is I'm not sure there's a equivalent send() in
>> e.g non POSIX system.
> send() should be as common as sendto().
>
> Should I resend the patch without RFC?


Yes please.


> no other changes needed?


No.

Thanks


>
> thanks!
>
