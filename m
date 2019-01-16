Received: from eggs.gnu.org ([209.51.188.92]:55811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjeVh-0007sf-U7
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 01:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjeH2-0004gX-9p
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 01:02:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjeH1-0004dr-Ug
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 01:02:00 -0500
References: <20190115145256.9593-1-berrange@redhat.com>
	<20190115145256.9593-7-berrange@redhat.com>
	<7aa007ec-126d-2a97-aa45-91468f7f8ad4@redhat.com>
	<20190116054735.GA29461@xz-x1>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3abfeb16-2fee-8b34-df16-ea6bf28c2132@redhat.com>
Date: Wed, 16 Jan 2019 07:01:46 +0100
MIME-Version: 1.0
In-Reply-To: <20190116054735.GA29461@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/12] chardev: remove unused 'sioc'
 variable & cleanup paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Yongji Xie <elohimes@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 2019-01-16 06:47, Peter Xu wrote:
> On Wed, Jan 16, 2019 at 06:24:49AM +0100, Thomas Huth wrote:
>> On 2019-01-15 15:52, Daniel P. Berrang=C3=A9 wrote:
>>> The 'sioc' variable in qmp_chardev_open_socket was unused since
>>>
>>>   commit 3e7d4d20d3a528b1ed10b1dc3d83119bfb0c5f24
>>>   Author: Peter Xu <peterx@redhat.com>
>>>   Date:   Tue Mar 6 13:33:17 2018 +0800
>>>
>>>     chardev: use chardev's gcontext for async connect
>> [...]
>>> -error:
>>> -    if (sioc) {
>>> -        object_unref(OBJECT(sioc));
>>> -    }
>>
>> So who is doing the object_unref() now in case of errors? That commit
>> did not take care of it ... so it sounds like we could be leaving
>> references behind in case of errors here?
>=20
> IMHO it'll be done finally in qemu_chr_socket_connected() no matter
> whether it's succeeded or not:
>=20
>     cleanup:
>         object_unref(OBJECT(sioc));
>=20
> In other words, I think the old error path is not valid even before
> commit 3e7d4d20d3 because IIUC when reaching the error label the sioc
> should never be set (and if it tries to do an object_unref here it
> would be a real bug).

Right, looking at the qmp_chardev_open_socket() function again (before
the rework in 3e7d4d20d3a5), I see now that all locations that use "goto
error" should have sioc =3D NULL. So this patch here is fine:

Reviewed-by: Thomas Huth <thuth@redhat.com>
