Received: from eggs.gnu.org ([209.51.188.92]:59884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3GNO-0001v7-UE
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3GJP-0004G5-0B
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:29:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h3GJO-0004Fb-NY
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:29:30 -0400
References: <20190310131205.75856-1-liq3ea@163.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2f636abc-34be-97a4-8375-3c4e0cdbabff@redhat.com>
Date: Mon, 11 Mar 2019 09:29:23 +0100
MIME-Version: 1.0
In-Reply-To: <20190310131205.75856-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: test-announce-self: fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, vyasevic@redhat.com, dgilbert@redhat.com, mst@redhat.com, jasowang@redhat.com
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org

On 10/03/2019 14.12, Li Qiang wrote:
> Spotted by ASAN when 'make check'.
>=20
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  tests/test-announce-self.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>=20
> diff --git a/tests/test-announce-self.c b/tests/test-announce-self.c
> index 1644d34a3f..3f370d8bf5 100644
> --- a/tests/test-announce-self.c
> +++ b/tests/test-announce-self.c
> @@ -21,17 +21,6 @@
>  #define ETH_P_RARP 0x8035
>  #endif
> =20
> -static QTestState *test_init(int socket)
> -{
> -    char *args;
> -
> -    args =3D g_strdup_printf("-netdev socket,fd=3D%d,id=3Dhs0 -device =
"
> -                           "virtio-net-pci,netdev=3Dhs0", socket);
> -
> -    return qtest_start(args);
> -}
> -
> -
>  static void test_announce(int socket)
>  {
>      char buffer[60];
> @@ -58,19 +47,22 @@ static void test_announce(int socket)
> =20
>  static void setup(gconstpointer data)
>  {
> -    QTestState *qs;
>      void (*func) (int socket) =3D data;
>      int sv[2], ret;
> +    char *args;
> =20
>      ret =3D socketpair(PF_UNIX, SOCK_STREAM, 0, sv);
>      g_assert_cmpint(ret, !=3D, -1);
> =20
> -    qs =3D test_init(sv[1]);
> +    args =3D g_strdup_printf("-netdev socket,fd=3D%d,id=3Dhs0 -device =
"
> +                           "virtio-net-pci,netdev=3Dhs0", sv[1]);
> +    qtest_start(args);

Actually, we don't need the g_strdup_printf and the args variable here
at all - it's cleaner and easier to use qtest_initf() here. Could you to
change your patch to look something like this:

diff a/tests/test-announce-self.c b/tests/test-announce-self.c
--- a/tests/test-announce-self.c
+++ b/tests/test-announce-self.c
@@ -21,18 +21,8 @@
 #define ETH_P_RARP 0x8035
 #endif

-static QTestState *test_init(int socket)
-{
-    char *args;
-
-    args =3D g_strdup_printf("-netdev socket,fd=3D%d,id=3Dhs0 -device "
-                           "virtio-net-pci,netdev=3Dhs0", socket);
-
-    return qtest_start(args);
-}
-

-static void test_announce(int socket)
+static void test_announce(QTestState *qs, int socket)
 {
     char buffer[60];
     int len;
@@ -40,7 +30,7 @@ static void test_announce(int socket)
     int ret;
     uint16_t *proto =3D (uint16_t *)&buffer[12];

-    rsp =3D qmp("{ 'execute' : 'announce-self', "
+    rsp =3D qtest_qmp(qs, "{ 'execute' : 'announce-self', "
                   " 'arguments': {"
                       " 'initial': 50, 'max': 550,"
                       " 'rounds': 10, 'step': 50 } }");
@@ -59,14 +49,15 @@ static void test_announce(int socket)
 static void setup(gconstpointer data)
 {
     QTestState *qs;
-    void (*func) (int socket) =3D data;
+    void (*func) (QTestState *qs, int socket) =3D data;
     int sv[2], ret;

     ret =3D socketpair(PF_UNIX, SOCK_STREAM, 0, sv);
     g_assert_cmpint(ret, !=3D, -1);

-    qs =3D test_init(sv[1]);
-    func(sv[0]);
+    qs =3D qtest_initf("-netdev socket,fd=3D%d,id=3Dhs0 -device "
+                           "virtio-net-pci,netdev=3Dhs0", sv[1]);
+    func(qs, sv[0]);

     /* End test */
     close(sv[0]);

 Thanks,
  Thomas
