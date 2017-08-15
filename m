Received: from eggs.gnu.org ([2001:4830:134:3::10]:46235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dhRvQ-0007WP-6q
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 22:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dhRvN-0000DI-3J
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 22:49:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dhRvM-0000D1-Qu
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 22:49:45 -0400
Date: Tue, 15 Aug 2017 05:49:42 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170815054903-mutt-send-email-mst@kernel.org>
References: <20170814084838.12233-1-wei.yang@ucloud.cn>
	<20170814185545-mutt-send-email-mst@kernel.org>
	<59925A94.4070502@ucloud.cn>
	<20170815053445-mutt-send-email-mst@kernel.org>
	<59926083.4030708@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59926083.4030708@ucloud.cn>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] bios-tables-test: delete a assert about
 block name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wyang <wei.yang@ucloud.cn>
Cc: imammedo@redhat.com, qemu-devel@nongnu.org

On Tue, Aug 15, 2017 at 10:46:27AM +0800, wyang wrote:
>=20
>=20
> On 2017=E5=B9=B408=E6=9C=8815=E6=97=A5 10:39, Michael S. Tsirkin wrote:
> > On Tue, Aug 15, 2017 at 10:21:08AM +0800, wyang wrote:
> > > On 2017=E5=B9=B408=E6=9C=8814=E6=97=A5 23:58, Michael S. Tsirkin wr=
ote:
> > > > On Mon, Aug 14, 2017 at 04:48:38PM +0800, wei.yang@ucloud.cn wrot=
e:
> > > > > From: Wei Yang <wei.yang@ucloud.cn>
> > > > >=20
> > > > > The assert would be touched when the version of acpica is great=
er than or
> > > > > equal to 20160318. its reason is that "Disasembler: Update a co=
uple
> > > > > output items(commit id: 1ecbb3d)" is introduced by Robert, the =
patch
> > > > > emits the AML filename as a zero-length string, and allows the =
compiler
> > > > > to create the name later.
> > > > So how does the output look then? Do you mean there's no comma th=
en?
> > > sorry for confusion, more clearly,  since the AML filename is a zer=
o-length
> > > string, so the output of dsl file looks like this after
> > > executing iasl command to disassemble AML file to DSL file
> > >=20
> > >=20
> > > DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPCDSDT", 0x00000001)
> > >=20
> > > the block name is NULL string.
> > It's an empty string, sure, but is it NULL?
> > I see:
> > block_name =3D g_strstr_len(asl->str, asl->len, BLOCK_NAME_END);
> >=20
> > which looks for "," and assigns a pointer to it to block_name.
> >=20
> > Is it actually NULL in your testing?
> Hmm, as I touched the assert, so I thought it is NULL, seems I SHOULD g=
o on
> deeply digging into it. Thank MST  for your review.
>=20
> Wei
> > > If the version of iasl command is less than 20160318, the output lo=
oks like
> > >=20
> > > DefinitionBlock ("/tmp/xxxx.aml", "DSDT", 1, "BOCHS ", "BXPCDSDT",
> > > 0x00000001)
> > >=20
> > > >=20
> > > > > Signed-off-by: Yang, Wei <wei.yang@ucloud.com>
> > > > > CC: Michael S. Tsirkin <mst@redhat.com>
> > > > > CC: Igor Mammedov <imammedo@redhat.com>
> > > > > CC: qemu-devel@nongnu.org
> > > > > ---
> > > > >    tests/bios-tables-test.c | 1 -
> > > > >    1 file changed, 1 deletion(-)
> > > > >=20
> > > > > diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.=
c
> > > > > index 88dbf97853..d2ab073848 100644
> > > > > --- a/tests/bios-tables-test.c
> > > > > +++ b/tests/bios-tables-test.c
> > > > > @@ -350,7 +350,6 @@ static GString *normalize_asl(gchar *asl_co=
de)
> > > > >        /* strip def block name (it has file path in it) */
> > > > >        if (g_str_has_prefix(asl->str, DEF_BLOCK)) {
> > > > >            block_name =3D g_strstr_len(asl->str, asl->len, BLOC=
K_NAME_END);
> > > > > -        g_assert(block_name);
> > > > >            asl =3D g_string_erase(asl, 0,
> > > > >                                 block_name + sizeof(BLOCK_NAME_=
END) - asl->str);
> > > > The pointer math here won't do the right thing then, will it?
> > > Yes, I will fix it.
> > >=20
> > > Thanks
> > > Wei

BTW sizeof(BLOCK_NAME_END) is actually 2. I think it works
because there's a space after ,. It is better to replace it with
strlen so it will work without a space too.

> > > > >        }
> > > > > --=20
> > > > > 2.11.0
> > > > >=20
> > > --=20
> > > Wei Yang(=E6=9D=A8=E4=BC=9F)
> > > Mobile: +86-13436682065
> > > Email: wei.yang@ucloud.cn
> > >=20
>=20
> --=20
> Wei Yang(=E6=9D=A8=E4=BC=9F)
> Mobile: +86-13436682065
> Email: wei.yang@ucloud.cn
>=20
