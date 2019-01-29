Received: from eggs.gnu.org ([209.51.188.92]:52737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1goQZ0-0001kD-Ab
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:24:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1goQYy-0005gV-C1
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:24:18 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 29 Jan 2019 10:24:08 +0000
Message-ID: <fa3cc31b-937c-a22c-4079-2ad7d968aac5@virtuozzo.com>
References: <20190125164601.130556-1-vsementsov@virtuozzo.com>
	<20190129033155.GD3264@stefanha-x1.localdomain>
In-Reply-To: <20190129033155.GD3264@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <1F37B6EFC2D508499A1B72CEDC5BE647@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH] block: local qiov helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>

29.01.2019 6:31, Stefan Hajnoczi wrote:
> On Fri, Jan 25, 2019 at 07:46:01PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> Hi all.
>>
>> What about such a simple helper for a very often patter around
>> qemu_iovec_init_external ?
>=20
> Sounds good, qemu_iovec_init() has 55 references vs
> qemu_iovec_init_external() with 51.  It's worth making
> qemu_iovec_init_external() nicer to use.
>=20
>> If we like it, I'll update other callers of qemu_iovec_init_external.
>>
>> Possible interface change would be
>> LOCAL_QIOV(lc, buf, len);
>> instead of
>> LocalQiov lc =3D LOCAL_QIOV(lc, buf, len);
>>
>> or, may be, someone has a better idea?
>=20
> Bike-shedding territory, but I prefer LocalQiov lc =3D LOCAL_QIOV(lc, buf=
,
> len) because it reveals the type.  This makes the code easier to read
> than just LOCAL_QIOV(lc, buf, len) by itself - the reader is forced to
> look up the macro definition to figure out what magic happens.
>=20
>> diff --git a/block/io.c b/block/io.c
>> index bd9d688f8b..c7d7b199c1 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -949,18 +949,13 @@ int bdrv_preadv(BdrvChild *child, int64_t offset, =
QEMUIOVector *qiov)
>>  =20
>>   int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes)
>>   {
>> -    QEMUIOVector qiov;
>> -    struct iovec iov =3D {
>> -        .iov_base =3D (void *)buf,
>> -        .iov_len =3D bytes,
>> -    };
>> +    LocalQiov lq =3D LOCAL_QIOV(lq, buf, bytes);
>>  =20
>>       if (bytes < 0) {
>>           return -EINVAL;
>>       }
>>  =20
>> -    qemu_iovec_init_external(&qiov, &iov, 1);
>> -    return bdrv_preadv(child, offset, &qiov);
>> +    return bdrv_preadv(child, offset, &lq.qiov);
>=20
> I think it's unfortunate that LocalQiov is necessary since the caller
> only needs the qiov.  Can we afford to embed the struct iovec into
> QEMUIOVector?
>=20
> That way callers don't need a separate LocalQiov type:
>=20
>    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
>    ...
>    return bdrv_preadv(child, offset, &qiov);
>=20


Hmm. In this case we definitely will have tiny extra memory usage, but we g=
ain beautiful
readability.

So, like this:

diff --git a/include/qemu/iov.h b/include/qemu/iov.h
index 5f433c7768..53de1b38bb 100644
--- a/include/qemu/iov.h
+++ b/include/qemu/iov.h
@@ -134,9 +134,31 @@ typedef struct QEMUIOVector {
      struct iovec *iov;
      int niov;
      int nalloc;
-    size_t size;
+    union {
+        struct {
+            void *__unused_iov_base;
+            size_t size;
+        };
+        struct iovec local_iov;
+    };
  } QEMUIOVector;

+G_STATIC_ASSERT(offsetof(QEMUIOVector, size) =3D=3D
+                offsetof(QEMUIOVector, local_iov.iov_len));
+G_STATIC_ASSERT(sizeof(((QEMUIOVector *)NULL)->size) =3D=3D
+                sizeof(((QEMUIOVector *)NULL)->local_iov.iov_len));
+
+#define QEMU_IOVEC_INIT_BUF(self, buf, len) \
+{                                           \
+    .iov =3D &self.local_iov,                 \
+    .niov =3D 1,                              \
+    .nalloc =3D -1,                           \
+    .local_iov =3D {                          \
+        .iov_base =3D (void *)(buf),          \
+        .iov_len =3D len                      \
+    }                                       \
+}
+
  void qemu_iovec_init(QEMUIOVector *qiov, int alloc_hint);
  void qemu_iovec_init_external(QEMUIOVector *qiov, struct iovec *iov, int =
niov);
  void qemu_iovec_add(QEMUIOVector *qiov, void *base, size_t len);
diff --git a/block/io.c b/block/io.c
index bd9d688f8b..39a1a848af 100644
--- a/block/io.c
+++ b/block/io.c
@@ -949,17 +949,12 @@ int bdrv_preadv(BdrvChild *child, int64_t offset, QEM=
UIOVector *qiov)

  int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes)
  {
-    QEMUIOVector qiov;
-    struct iovec iov =3D {
-        .iov_base =3D (void *)buf,
-        .iov_len =3D bytes,
-    };
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);

      if (bytes < 0) {
          return -EINVAL;
      }

-    qemu_iovec_init_external(&qiov, &iov, 1);
      return bdrv_preadv(child, offset, &qiov);
  }



Ok?


It's also possible to unite nalloc and local_iov.iov_base, to save 4 bytes,=
 and we'll have to add

  void qemu_iovec_add(QEMUIOVector *qiov, void *base, size_t len)
  {
-    assert(qiov->nalloc !=3D -1);
+    assert(qiov->iov !=3D &qiov->local_iov && qiov->nalloc !=3D -1);

But I think it's not worth it.

--=20
Best regards,
Vladimir
