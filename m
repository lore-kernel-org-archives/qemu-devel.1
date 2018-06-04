Received: from eggs.gnu.org ([2001:4830:134:3::10]:52276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fPkY3-0005Jg-Ea
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:09:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fPkXz-0004o3-BQ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:09:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48676 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fPkXz-0004nn-5q
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:08:59 -0400
References: <CANzW0mv3x1Hxje9fPEAExOb_kmCg2HU9jE_nwpLMqQk2Wh+KQQ@mail.gmail.com>
	<20180601123016.GP8687@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6095a332-009e-182e-543d-743ba339f581@redhat.com>
Date: Mon, 4 Jun 2018 16:08:53 +0800
MIME-Version: 1.0
In-Reply-To: <20180601123016.GP8687@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] "socket" host network backend: suggested
 improvements and fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Artem Pisarenko <artem.k.pisarenko@gmail.com>
Cc: qemu-devel@nongnu.org



On 2018=E5=B9=B406=E6=9C=8801=E6=97=A5 20:30, Stefan Hajnoczi wrote:
> On Wed, May 30, 2018 at 04:34:03PM +0600, Artem Pisarenko wrote:
>> Hi to all.
> Hi Artem,
> I have CCed Jason Wang, the QEMU networking maintainer, so your email
> gets attention.  QEMU is a high-traffic mailing list and you may not ge=
t
> responses unless you CC relevant people (use scripts/get_maintainer.pl
> -f path/to/source.c to look up maintainers).
>
>> I'm working on integrating QEMU networking to simulation environment a=
nd
>> found socket backend very convenient: it's simple, easy to use (i.e no
>> intermediate things required, such as tap/tun adapter, vde switch, etc=
.)
>> and transparent to host environment (i.e. it doesn't pollutes system w=
ith
>> bunch of virtual devices, etc.).
>>
>> Although, it have some problems, closely related to each other. I've
>> investigated source code and played with it a little, but I'm not read=
y
>> submit a complete patch. So, here are my thoughts...

You're very welcome to send patches. If you think it's not ready to be=20
merged, you can send RFC for early discussion.

>>
>> 1. Internal protocol (only qemu instances can join its network devices
>> between).

You mean the simple protocol on top of TCP? We probably need at least a=20
version for socket backend. (We change the protocol recently for vnet=20
header support).

For UDP, I believe external program could join?

>> I suggest to make it available to plug with external software,
>> i.e freeze communication protocol at current state and document it in
>> docs/interop/ directory.

Any pointer to freeze communication protocol?

>>
>> 2. Transport options wrongly documented. Section "2.3.6 Network option=
s"
>> lists "-netdev socket,..." entries. It gives very different basic
>> understanding of how it works from actual one.
>>   2.1. It has two entries: listen/connect (TCP connecton) and mcast
>> (multicast UDP), but 'qemu --help' outputs additional one - udp (UDP
>> tunnel), which is undocumented, but looks like working.

Yes.

>>   2.2. Each entry has fd=3Dh parameter, which looks like it's an optio=
nal
>> parameter, but code analysis (net/socket.c) shows that, in fact, it's =
a
>> separate transport option exclusive to listed ones. It used as follows=
:
>> user creates/opens whatever (almost) custom socket/file it wants, conn=
ects
>> it with other endpoint and passes file descriptor (handle) to qemu, wh=
ich
>> just recv/send over it and nothing more.

Right.

>>   2.3. As a consequence, if you try to invoke any transport/variant op=
tion
>> with "fd=3D", you'll get an error: "exactly one of listen=3D, connect=3D=
, mcast=3D
>> or udp=3D is required". And again, error message is incomplete - it mi=
sses
>> "fd=3D" option.

This needs to be fixed.

>>
>> 3. "fd=3D" transport doesn't work with SOCK_DGRAM type sockets. It's d=
ue to
>> an implementation error in net/socket.c. Function
>> net_socket_receive_dgram() uses sendo() call with s->dgram_dst value w=
hich
>> is undefined for this case (and, of course, cannot be defined).

I think maybe we need a new qmp method for setting the destination for=20
socket backend.

>> Although net_socket_fd_init() execution branch is smart enough to dete=
ct
>> type of socket passed with "fd=3D", but its "connected" state forgotte=
n
>> afterwards. Suggested fix: replace sendto() with send(), which correct=
ly
>> assumes already connected socket, and add corresponding connect() call=
s for
>> "mcast=3D" and "udp=3D" init sequences.

Appreciated if you could send the aboves fixes. Some unit tests are even=20
better.

>>
>> (For those, who interested, currently I've got working network
>> communication with unmodified qemu 2.12.0 in Linux using UNIX domain
>> sockets created by socketpair(AF_LOCAL, SOCK_STREAM, ...), one of whic=
h
>> passed to spawned child qemu process via -netdev socket,fd=3D... and o=
ther
>> one, used in parent application process to send/receive packets. Proto=
col,
>> used by qemu, is simple and implements only data plane: it just transf=
ers
>> raw ethernet frames in binary form, for datagram-type sockets it's
>> straightforward, and for stream-type sockets each frame prepended with
>> uint32 length in network byte order, without any delimiters and escapi=
ng.)
>> --=20
>>
>> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
>>    =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=
=D0=BD=D0=BA=D0=BE

Thanks
