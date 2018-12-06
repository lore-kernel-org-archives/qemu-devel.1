Received: from eggs.gnu.org ([2001:4830:134:3::10]:40860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUwUR-0001hY-E4
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:27:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUwUO-0006Ak-6v
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:27:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gUwUN-00062z-TB
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:27:00 -0500
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
	<1543851204-41186-11-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <df1c9b60-9ad1-7820-cee7-3daf4816b130@redhat.com>
Date: Thu, 6 Dec 2018 17:26:57 +0100
MIME-Version: 1.0
In-Reply-To: <1543851204-41186-11-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/71] vhost-user-test: skip if there is no
 memory at address 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>

On 2018-12-03 16:32, Paolo Bonzini wrote:
> The virt machine cannot run the vhost-user qtests because they hardcode
> the presence of memory at address 0.  Report the tests as a skip so tha=
t
> they can be converted to use qgraph.
>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/vhost-user-test.c | 58 ++++++++++++++++++++++++++++++++++++++---=
--------
>  1 file changed, 45 insertions(+), 13 deletions(-)
>=20
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index 82fc6c5..59e1aec 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -228,9 +228,11 @@ static void uninit_virtio_dev(TestServer *s)
>      qvirtio_pci_device_free(s->dev);
>  }
> =20
> -static void wait_for_fds(TestServer *s)
> +static bool wait_for_fds(TestServer *s)
>  {
>      gint64 end_time;
> +    bool got_region;
> +    int i;
> =20
>      g_mutex_lock(&s->data_mutex);
> =20
> @@ -248,6 +250,19 @@ static void wait_for_fds(TestServer *s)
>      g_assert_cmpint(s->fds_num, =3D=3D, s->memory.nregions);
> =20
>      g_mutex_unlock(&s->data_mutex);
> +
> +    got_region =3D false;
> +    for (i =3D 0; i < s->memory.nregions; ++i) {
> +        VhostUserMemoryRegion *reg =3D &s->memory.regions[i];
> +        if (reg->guest_phys_addr =3D=3D 0) {
> +            got_region =3D true;
> +            break;
> +        }
> +    }
> +    if (!got_region) {
> +        g_test_skip("No memory at address 0x0");
> +    }

g_test_skip does not work with older versions of the gtester ... so this
patch series depends on your gtester replacement patches first?

 Thomas
