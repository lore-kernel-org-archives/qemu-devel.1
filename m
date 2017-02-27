Received: from eggs.gnu.org ([2001:4830:134:3::10]:32867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciM2P-0002LI-5e
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:12:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciM2K-00018N-7D
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:12:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ciM2K-00017n-29
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:12:24 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40F58D59A8
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 14:12:24 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-21-marcandre.lureau@redhat.com>
Date: Mon, 27 Feb 2017 15:12:21 +0100
In-Reply-To: <20170221141451.28305-21-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 21 Feb 2017
	18:14:41 +0400")
Message-ID: <87k28ben96.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 20/30] tests: fix e1000e leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Spotted by ASAN.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/e1000e-test.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tests/e1000e-test.c b/tests/e1000e-test.c
> index 8c42ca919f..c612dc64ec 100644
> --- a/tests/e1000e-test.c
> +++ b/tests/e1000e-test.c
> @@ -99,7 +99,10 @@ static QPCIBus *test_bus;
>=20=20
>  static void e1000e_pci_foreach_callback(QPCIDevice *dev, int devfn, void=
 *data)
>  {
> -    *(QPCIDevice **) data =3D dev;
> +    QPCIDevice **res =3D data;
> +
> +    g_assert_null(*res);
> +    *res =3D dev;
>  }
>=20=20
>  static QPCIDevice *e1000e_device_find(QPCIBus *bus)
   {
       static const int e1000e_vendor_id =3D 0x8086;
       static const int e1000e_dev_id =3D 0x10D3;

       QPCIDevice *e1000e_dev =3D NULL;

       qpci_device_foreach(bus, e1000e_vendor_id, e1000e_dev_id,
           e1000e_pci_foreach_callback, &e1000e_dev);

This hunk adds an assertion.  I guess it checks that we're finding no
more than one e1000e device.  The connection to the stated purpose of
this patch isn't obvious, but I think I got it: each hit allocates, but
you have only one g_free(), below.  Okay, but explaining this briefly
the commit message wouldn't hurt.

> @@ -403,6 +406,7 @@ static void data_test_clear(e1000e_device *d)
>      e1000e_device_clear(test_bus, d);
>      close(test_sockets[0]);
>      pc_alloc_uninit(test_alloc);
> +    g_free(d->pci_dev);
>      qpci_free_pc(test_bus);
>      qtest_end();
>  }

Reviewed-by: Markus Armbruster <armbru@redhat.com>
