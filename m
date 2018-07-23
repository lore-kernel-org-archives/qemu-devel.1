Received: from eggs.gnu.org ([2001:4830:134:3::10]:42837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1fhbxN-0005Tl-Ig
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1fhbxK-0005Xe-EZ
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:37:01 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2401 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liujunjie23@huawei.com>)
	id 1fhbxJ-0005Uu-6h
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:36:58 -0400
From: "liujunjie (A)" <liujunjie23@huawei.com>
Date: Mon, 23 Jul 2018 14:36:39 +0000
Message-ID: <B526101FCAB4654DB0892B650DEFC555086C7F48@dggemm521-mbx.china.huawei.com>
References: <20180720130928.6696-1-liujunjie23@huawei.com>
	<87h8kq86f8.fsf@dusky.pond.sub.org>
In-Reply-To: <87h8kq86f8.fsf@dusky.pond.sub.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] qstring: Fix integer overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Thanks for your reply.
> Really?  How exactly can this happen?  Please explain step by step.
There exist a qemu core related to this. You have mention that "The convers=
ion truncates when strlen(str) - 1 exceeds INT_MAX".
Later in function qstring_from_substr, this truncated "end" will be assigne=
d to "qstring->length" again, which is size_t. This is the key point why qe=
mu coredumped.
Because when "end" is truncated, it can be negative number. If we assign a =
negative number to a size_t variable, this size_t variable can become very =
large.
At last, we call g_malloc to try to alloc a large number of member which ca=
nnot success. So qemu coredump.
In my example, use gdb to debug function qstring_from_substr, I can get the=
 following message.
(gdb) p	qstring->length
$4 =3D 18446744072383980732  (too large to allocate)
(gdb) p	(int) (qstring->length)
$5 =3D -1325570884
(gdb) p/x (int)	qstring->length
$6 =3D 0xb0fd64bc
(gdb) p/x qstring->length
$7 =3D 0xffffffffb0fd64bc
(gdb) p	end
$8 =3D <optimized out>

> -----Original Message-----
> From: Markus Armbruster [mailto:armbru@redhat.com]
> Sent: Monday, July 23, 2018 8:48 PM
> To: liujunjie (A) <liujunjie23@huawei.com>
> Cc: wangxin (U) <wangxinxin.wang@huawei.com>; Gonglei (Arei)
> <arei.gonglei@huawei.com>; Huangweidong (C)
> <weidong.huang@huawei.com>; qemu-devel@nongnu.org
> Subject: Re: [Qemu-devel] [PATCH] qstring: Fix integer overflow
>=20
> liujunjie <liujunjie23@huawei.com> writes:
>=20
> > From: l00425170 <liujunjie23@huawei.com>
> >
> > The incoming parameters "start" and "end" is int type in
> > qstring_from_substr(), but this function can be called by
> > qstring_from_str, which is size_t type in strlen(str).
>=20
> Yes, there's a conversion from size_t to int in
>=20
>     return qstring_from_substr(str, 0, strlen(str) - 1);
>=20
> The conversion truncates when strlen(str) - 1 exceeds INT_MAX.
>=20
> strlen(str) - 1 wraps around to SIZE_MAX when @str is empty.
>=20
> > It may result in coredump when called g_malloc later.
> > One scene to triger is to call hmp "into tlb", which may have too long
> > length of string.
>=20
> Really?  How exactly can this happen?  Please explain step by step.
>=20
> Aside: @end is only used as @end + 1, and all callers pass some X - 1.
> Both the addition and the subtraction can overflow.  Changing the functio=
n to
> take the index behind the last character instead of the index of the last
> character would almost certainly simplify things.  Not this patch's probl=
em.
>=20
> >
> > Signed-off-by: l00425170 <liujunjie23@huawei.com>
> > ---
> >  include/qapi/qmp/qstring.h | 2 +-
> >  qobject/qstring.c          | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/qapi/qmp/qstring.h b/include/qapi/qmp/qstring.h
> > index b3b3d44..3e83e3a 100644
> > --- a/include/qapi/qmp/qstring.h
> > +++ b/include/qapi/qmp/qstring.h
> > @@ -24,7 +24,7 @@ struct QString {
> >
> >  QString *qstring_new(void);
> >  QString *qstring_from_str(const char *str); -QString
> > *qstring_from_substr(const char *str, int start, int end);
> > +QString *qstring_from_substr(const char *str, size_t start, size_t
> > +end);
> >  size_t qstring_get_length(const QString *qstring);  const char
> > *qstring_get_str(const QString *qstring);  const char
> > *qstring_get_try_str(const QString *qstring); diff --git
> > a/qobject/qstring.c b/qobject/qstring.c index afca54b..18b8eb8 100644
> > --- a/qobject/qstring.c
> > +++ b/qobject/qstring.c
> > @@ -37,7 +37,7 @@ size_t qstring_get_length(const QString *qstring)
> >   *
> >   * Return string reference
> >   */
> > -QString *qstring_from_substr(const char *str, int start, int end)
> > +QString *qstring_from_substr(const char *str, size_t start, size_t
> > +end)
> >  {
> >      QString *qstring;
>=20
> The patch makes sense, but the commit message makes claims that need to b=
e
> substantiated.
