Received: from eggs.gnu.org ([2001:4830:134:3::10]:50878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCjwc-0005nV-DI
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCjwY-00085U-Qp
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:24:52 -0400
References: <cover.1539764043.git.artem.k.pisarenko@gmail.com>
	<f47b81dbce734e9806f9516eba8ca588e6321c2f.1539764043.git.artem.k.pisarenko@gmail.com>
	<20181017091204.GC22755@stefanha-x1.localdomain>
	<5a83aab6-1277-cc0e-7913-964a8fea5265@redhat.com>
	<CANzW0mvPxvDsCURzXjOdjR-8uLjXpyAouH80ik6asb0awwX+VA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c9cfbdff-f713-b49d-4ac8-33ed79b08502@redhat.com>
Date: Wed, 17 Oct 2018 13:24:28 +0200
MIME-Version: 1.0
In-Reply-To: <CANzW0mvPxvDsCURzXjOdjR-8uLjXpyAouH80ik6asb0awwX+VA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 2/4] Introduce attributes
 to qemu timer subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, "open list:Block I/O path" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 17/10/2018 12:57, Artem Pisarenko wrote:
>> Further down in this patch the notation is QEMU_TIMER_ATTR_<id>, which=
 I
>> think is clearer because QEMU_TIMER_ATTR(id) looks like a (non-existen=
t)
>> macro.=C2=A0 Please use the QEMU_TIMER_ATTR_<id> notation consistently=
.
>=20
> Yes, I've just forgot to update comments after previous patch version,
> where it actually was macro.
>=20
>> What is the purpose of this bit?=C2=A0 I guess it's just here as a
>> placeholder because no real bits have been defined yet.=C2=A0 Hopefull=
y the
>> next patch removes it (/* This placeholder is removed in the next patc=
h
>> */ would be a nice way to document this for reviewers).
>=20
> It's just to prevent compilation errors, as required by
> https://wiki.qemu.org/Contribute/SubmitAPatch#Split_up_long_patches
>=20
>> The enum isn't needed and makes debugging harder since the bit number =
is
>> implicit in the enum ordering.=C2=A0 This alternative is clearer and m=
ore
>> concise:
>>=C2=A0
>>=C2=A0 =C2=A0#define QEMU_TIMER_ATTR_foo BIT(n)
>=20
> Agree.

Like this?

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 86ce70f20e..ef7526e389 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -55,25 +55,13 @@ typedef enum {
 /**
  * QEMU Timer attributes:
  *
- * An individual timer may be assigned with one or multiple attributes w=
hen
- * initialized.
- * Attribute is a static flag, meaning that timer has corresponding
property.
- * Attributes are defined in QEMUTimerAttrBit enum and encoded to bit se=
t,
- * which used to initialize timer, stored to 'attributes' member and can=
 be
- * retrieved externally with timer_get_attributes() call.
- * Values of QEMUTimerAttrBit aren't used directly,
- * instead each attribute in bit set accessed with QEMU_TIMER_ATTR_<id>
macro,
- * where <id> is a unique part of attribute identifier.
+ * An individual timer may be given one or multiple attributes when
initialized.
+ * Each attribute corresponds to one bit.  Attributes modify the process=
ing
+ * of timers when they fire.
  *
  * No attributes defined currently.
  */

-typedef enum {
-    QEMU_TIMER_ATTRBIT__NONE
-} QEMUTimerAttrBit;
-
-#define QEMU_TIMER_ATTR__NONE (1 << QEMU_TIMER_ATTRBIT__NONE)
-
 typedef struct QEMUTimerList QEMUTimerList;

 struct QEMUTimerListGroup {
@@ -640,14 +628,6 @@ static inline QEMUTimer *timer_new_ms(QEMUClockType
type, QEMUTimerCB *cb,
     return timer_new(type, SCALE_MS, cb, opaque);
 }

-/**
- * timer_get_attributes:
- * @ts: the timer
- *
- * Return 0, or one to multiple OR'ed QEMU_TIMER_ATTR(id) values
- */
-int timer_get_attributes(QEMUTimer *ts);
-
 /**
  * timer_deinit:
  * @ts: the timer to be de-initialised
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 2046b68c15..04527a343f 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -355,11 +355,6 @@ void timer_init_full(QEMUTimer *ts,
     ts->expire_time =3D -1;
 }

-int timer_get_attributes(QEMUTimer *ts)
-{
-    return ts->attributes;
-}
-
 void timer_deinit(QEMUTimer *ts)
 {
     assert(ts->expire_time =3D=3D -1);
