Received: from eggs.gnu.org ([2001:4830:134:3::10]:57509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1fhxJI-0002rR-S0
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 09:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1fhxJE-000317-Pv
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 09:25:04 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2279 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liujunjie23@huawei.com>)
	id 1fhxJE-00030T-A4
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 09:25:00 -0400
From: "liujunjie (A)" <liujunjie23@huawei.com>
Date: Tue, 24 Jul 2018 13:24:44 +0000
Message-ID: <B526101FCAB4654DB0892B650DEFC555086C8EF4@dggemm521-mbx.china.huawei.com>
References: <20180720130928.6696-1-liujunjie23@huawei.com>
	<87h8kq86f8.fsf@dusky.pond.sub.org>
	<B526101FCAB4654DB0892B650DEFC555086C7F48@dggemm521-mbx.china.huawei.com>
	<87k1pm551g.fsf@dusky.pond.sub.org>
	<B526101FCAB4654DB0892B650DEFC555086C8382@dggemm521-mbx.china.huawei.com>
	<87r2jt40g1.fsf@dusky.pond.sub.org>	<87zhyh2f7v.fsf@dusky.pond.sub.org>
	<B526101FCAB4654DB0892B650DEFC555086C86D6@dggemm521-mbx.china.huawei.com>
	<87sh4825x1.fsf@dusky.pond.sub.org>
In-Reply-To: <87sh4825x1.fsf@dusky.pond.sub.org>
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

Thanks for your polish. I will update the patch as soon as possible.

I have tested the patch in my environment. What I use before is : virsh qem=
u-monitor-command xxxx --hmp "info tlb"
With this patch, when I query tlb, after some time, the console only print:=
 "error: No complete monitor response found in 10485760 bytes: Numerical re=
sult out of range".
It is because libvirt have noticed this scene and try to avoid memory denia=
l-of-service.

Besides, I login in the corresponding guestos which is win10 with 29G memor=
y and find that a test tool called "BurnLnTest" is running busily.=20
Maybe this test tool enlarge the size of tlb.

> -----Original Message-----
> From: Markus Armbruster [mailto:armbru@redhat.com]
> Sent: Tuesday, July 24, 2018 8:08 PM
> To: liujunjie (A) <liujunjie23@huawei.com>
> Cc: wangxin (U) <wangxinxin.wang@huawei.com>; Gonglei (Arei)
> <arei.gonglei@huawei.com>; Huangweidong (C)
> <weidong.huang@huawei.com>; qemu-devel@nongnu.org
> Subject: Re: [Qemu-devel] [PATCH] qstring: Fix integer overflow
>=20
> "liujunjie (A)" <liujunjie23@huawei.com> writes:
>=20
> > Even using gdb command: set print elements 0, is still too large to pri=
nt the
> whole string.
> > So I try to obtain the string in another way.
> > After several attempts(not easy in fact), I finally obtain the real len=
gth. The
> way is as follows:
> > (gdb) p (int *)str
> > $1 =3D (int *) 0x7f13a2e67010
> > (gdb) p *(char*) (0x7f13a2e67010 + 0x8B0FD63FF)@192
> > $2 =3D "--W\r\nffffffffffd17000: 00000000fec00000
> XG-DACT-W\r\nffffffffffd18000: ", '0' <repeats 11 times>, "77000
> XG-DA---W\r\nffffffffffd19000: ", '0 "78000 XG-DA---W\r\nffffffffffd1a000=
: ", '0'
> <repeats 11 times>, "79000 XG-DA---W\r\n\000\000"
> > With \000 at the end, we can find out the length is 0x8B0FD63FF + 192 -=
 2,
> that is 37329134781.
>=20
> Awesome, thanks!
>=20
> 37329134781 is 0x8B0FD64BD.  That's almost 35 GiB.  How on earth can
> "info tlb" print several Gigabytes?  That's a not a sane use of QMP!  No
> excuse for crashing, of course.
>=20
> > With this length, we can write a simple c code demo to reproduce the re=
sult
> we obtain before. Such as:
> > -----------------------------
> > #include<stdio.h>
> > int main()
> > {
> >     char * tmp =3D "";
> >     size_t a =3D  37329134781;
> >     int end =3D a;
> >     size_t b =3D end;
> >     printf("%zu", b)
> >     return 0;
> > }
> > -----------------------------
>=20
> Yes.
>=20
> When strlen(str) exceeds INT_MAX - 1 in qstring_from_str(), the @end
> argument for qstring_from_substr() gets truncated.  This is what appeared=
 to
> happen in your case: it got truncated to -1325570883.
>=20
> qstring_from_substr() has an (unstated) precondition: start >=3D 0 && end
> >=3D 0 && end - start >=3D -1.  This precondition is violated.  end - sta=
rt
> + 1 gets sign-extended to a huge value, and g_malloc() duly fails.
>=20
> All callers of qstring_from_substr() outside tests pass arguments of type=
 size_t
> or ptrdiff_t.  They'd fail just like qstring_from_str() for sub-strings e=
xceeding 2
> GiB.  Your patch fixes them all.  Good, I'll take your patch, but the com=
mit
> message needs a bit of polish.  Here's my attempt:
>=20
>     qstring: Fix qstring_from_substr() not to provoke int overflow
>=20
>     qstring_from_substr() parameters @start and @end are of type int.
>     blkdebug_parse_filename(), blkverify_parse_filename(), nbd_parse_uri(=
),
>     and qstring_from_str() pass @end values of type size_t or ptrdiff_t.
>     Values exceeding INT_MAX get truncated, with possibly disastrous
>     results.
>=20
>     Such huge substrings seem unlikely, but we found one in a core dump,
>     where "info tlb" executed via QMP's human-monitor-command apparently
>     produced 35 GiB of output.
>=20
>     Fix by changing the parameters size_t.
>=20
> If this works for you, please reply with your corrected Signed-off-by.
>=20
> However, please note that allocating the correct 35 GiB may not behave mu=
ch
> better for you than allocating 16 EiB.  I doubt it'll succeed, and if it =
does, then
> memcpy() will dirty 35 GiB of virtual memory, which is unlikely to end we=
ll.
>=20
> Are you sure "info tlb" is supposed to print that much?  Or is there anot=
her
> bug still in hiding that somehow enlarged this string?
