Received: from eggs.gnu.org ([2001:4830:134:3::10]:32925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gJhEK-0000RB-Cv
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:56:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gJhEJ-0000sa-F7
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:55:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gJhEJ-0000nj-69
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:55:55 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1541069086-167036-1-git-send-email-imammedo@redhat.com>
	<CAJ+F1CKE56kB+RokaNBwy1zB=xEeo-UaXgqp2-poMsprzY9Osw@mail.gmail.com>
	<20181101133313.533f7834@redhat.com>
Date: Mon, 05 Nov 2018 16:55:50 +0100
In-Reply-To: <20181101133313.533f7834@redhat.com> (Igor Mammedov's message of
	"Thu, 1 Nov 2018 13:33:13 +0100")
Message-ID: <875zxb5xix.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ivshmem: fix memory backend leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>

Igor Mammedov <imammedo@redhat.com> writes:

> On Thu, 1 Nov 2018 15:02:04 +0400
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
>
>> On Thu, Nov 1, 2018 at 2:53 PM Igor Mammedov <imammedo@redhat.com> wrote:
>> >
>> > object_new() returns a new backend with refcount =3D=3D 1 and
>> > then later object_property_add_child() increases refcount to 2
>> > So when ivshmem is desroyed, the backend it has created isn't
>> > destroyed along with it as children cleanup will bring
>> > backend's refcount only to 1, which leaks backend including
>> > resources it is using.
>> >
>> > Drop the original reference from object_new() once backend
>> > is attached to its parent.
>> >

I believe
Fixes: 5503e285041979dd29698ecb41729b3b22622e8d

>> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>=20=20
>>=20
>> I would rather have the unref in finalize, but that is ok too.
> I followed the pattern we use else where, i.e. drop reference
> as soon as we set the parent (virtio-rng/cpus) within the same
> scope as object_new().
>
> There is no point in keeping reference until finalize time since
> backend is kept alive as child and is destroyed well after all
> nonexistent ivshmem::unrealize/finilize() are finished when generic
> Object is being destroyed.

Concur.

>>  Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

With Philippe's spelling fix:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
