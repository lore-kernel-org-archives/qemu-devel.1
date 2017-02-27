Received: from eggs.gnu.org ([2001:4830:134:3::10]:58981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciLvb-0004Zr-Jb
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:05:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciLvY-00080K-El
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:05:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ciLvY-000806-8u
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:05:24 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 676AA80473
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 14:05:24 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-20-marcandre.lureau@redhat.com>
Date: Mon, 27 Feb 2017 15:05:21 +0100
In-Reply-To: <20170221141451.28305-20-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 21 Feb 2017
	18:14:40 +0400")
Message-ID: <87o9xnenku.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 19/30] tests: fix i440fx-test leaks
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
>  tests/i440fx-test.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tests/i440fx-test.c b/tests/i440fx-test.c
> index da2d5a53f0..e9d05c87d1 100644
> --- a/tests/i440fx-test.c
> +++ b/tests/i440fx-test.c
> @@ -134,6 +134,8 @@ static void test_i440fx_defaults(gconstpointer opaque)
>      /* 3.2.26 */
>      g_assert_cmpint(qpci_config_readb(dev, 0x93), =3D=3D, 0x00); /* TRC =
*/
>=20=20
> +    g_free(dev);
> +    qpci_free_pc(bus);
>      qtest_end();
>  }
>=20=20
> @@ -270,6 +272,9 @@ static void test_i440fx_pam(gconstpointer opaque)
>          /* Verify the area is not our new mask */
>          g_assert(!verify_area(pam_area[i].start, pam_area[i].end, 0x82));
>      }
> +
> +    g_free(dev);
> +    qpci_free_pc(bus);
>      qtest_end();
>  }

Reviewed-by: Markus Armbruster <armbru@redhat.com>
