Received: from eggs.gnu.org ([209.51.188.92]:42357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gwTk0-0008M5-Er
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:24:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gwTjp-0007fh-JW
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:24:47 -0500
References: <20190220010232.18731-1-philmd@redhat.com>
	<CAMxuvazRLabuNiGdKb9HSxyqJ+9NhxJkqkv824BTFj95j5u9rA@mail.gmail.com>
	<20190220113016.GD21870@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2917cc10-3382-b4ce-061f-5ab8e45ea3f7@redhat.com>
Date: Wed, 20 Feb 2019 08:20:04 -0600
MIME-Version: 1.0
In-Reply-To: <20190220113016.GD21870@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/25] chardev: Convert qemu_chr_write()
 to take a size_t argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangckid@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, qemu-s390x@nongnu.org, Paul Durrant <paul.durrant@citrix.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Samuel Thibault <samuel.thibault@ens-lyon.org>, David Gibson <david@gibson.dropbear.id.au>, Prasad J Pandit <pjp@fedoraproject.org>, Cornelia Huck <cohuck@redhat.com>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>

On 2/20/19 5:30 AM, Daniel P. Berrang=C3=A9 wrote:

>> Since Paolo you suggested the change, could you give some convincing
>> arguments that it's worth taking the plunge?
>=20
> The chardev write/read methods will end up calling libc read/write
> methods, whose parameters are "size_t count".

In my mind, that's the convincing reason. We should model our read/write
after the libc read/write, which means size_t input and ssize_t returns.

>=20
> Thus if there is QEMU code that could currently (mistakenly) pass a
> negative value for length to qemu_chr_write, unless something stops
> it, this is going to be cast to a size_t when we finally call read/
> write on the FD, leading to a large positive value & array out of
> bounds read/write.=20
>=20
> IOW we already have inconsistent use of signed vs unsigned in our code
> which has potential to cause bugs. Converting chardev to use size_t
> we get rid fo the mismatch with the underlying libc APIs we call,
> which ultimately eliminates an area of risk longer term. There is a
> chance it could uncover some pre-existing dormant bugs, but provided
> we do due diligence to check callers I think its a win to be consistent
> with libc APIs in size_t usage for read/write.

And hopefully this exercise of making the conversion serves as a good
audit to help us gain confidence in our code and/or fix bugs it uncovers.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
