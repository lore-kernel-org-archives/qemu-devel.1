Received: from eggs.gnu.org ([2001:4830:134:3::10]:36114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOmvI-0002Dd-7L
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOmvG-0000bv-F9
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:01:20 -0500
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-7-berrange@redhat.com>
	<5508fd21-b2e6-26d3-78f0-9ea89db10ccc@redhat.com>
	<08baf15a-7205-7a47-c806-dccadcaca291@redhat.com>
	<20181119103752.GH19532@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1f7459ea-00bc-21ec-b941-d5b12fb7badc@redhat.com>
Date: Mon, 19 Nov 2018 11:00:38 -0600
MIME-Version: 1.0
In-Reply-To: <20181119103752.GH19532@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] tests: exercise NBD server in TLS mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 11/19/18 4:37 AM, Daniel P. Berrang=C3=A9 wrote:

>> Actually, I tracked this message down to using socat (which actually
>> connects and then abruptly exits) when probing whether the socket is u=
p and
>> listening.  That is, the message is being produced as a side effect of
>> nbd_server_wait_for_tcp_socket rather than during the actual $QEMU_IMG
>> command we are interested in testing.

>>> This is the first use of socat in iotests.=C2=A0 Might not be the mos=
t
>>> portable, but I don't know if I have better ideas.
>>> nbdkit.git/tests/test-ip.sh greps the output of 'ss -ltn' to locate f=
ree
>>> ports, but I don't know if ss is any better than socat.
>>
>> So, I'm planning to squash this in, to use ss instead of socat, as fol=
lows:
>=20
> Personally I prefer socat since it is more portable, per my previous
> message.

socat is indeed probably more portable, but since tests 233 uses=20
'_supported_os Linux', ss availability isn't a problem until a future=20
user ports this test to non-Linux.  I'd like to patch qemu-nbd to NOT=20
warn about a user that connects but does not consume data (the socat=20
case, as well as port probes), but as that patch does not exist yet and=20
-rc2 is getting close, I'll go ahead and send the pull request with ss=20
instead of socat.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
