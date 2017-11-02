Received: from eggs.gnu.org ([2001:4830:134:3::10]:52868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eAE77-0004rO-3w
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eAE74-0006m0-0w
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:56:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eAE73-0006ha-S5
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:56:45 -0400
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112633.10516.44062.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b413bf64-d0ff-b99b-28c5-fc39d0e2b327@redhat.com>
Date: Thu, 2 Nov 2017 12:56:36 +0100
MIME-Version: 1.0
In-Reply-To: <20171031112633.10516.44062.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 17/26] replay: push replay_mutex_lock
 up the call tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

On 31/10/2017 12:26, Pavel Dovgalyuk wrote:
>=20
> +
>      if (timeout) {
>          spin_counter =3D 0;
> -        qemu_mutex_unlock_iothread();

This was done on purpose because it improved performance.  It's probably
pointless now that TCG runs outside the iothread, but it should be a
separate patch.

>      } else {
>          spin_counter++;
>      }
> +    qemu_mutex_unlock_iothread();
> +
> +    if (replay_mode !=3D REPLAY_MODE_NONE) {
> +        replay_mutex_unlock();
> +    }

This is quite ugly.  Perhaps you can push the "if" down inside the
functions?

Paolo

>      ret =3D qemu_poll_ns((GPollFD *)gpollfds->data, gpollfds->len, tim=
eout);
> =20
> -    if (timeout) {
> -        qemu_mutex_lock_iothread();
> +    if (replay_mode !=3D REPLAY_MODE_NONE) {
> +        replay_mutex_lock();
>      }
> =20
> +    qemu_mutex_lock_iothread();
> +
