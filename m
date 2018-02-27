Received: from eggs.gnu.org ([2001:4830:134:3::10]:58689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqbJn-0004mw-Cz
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:13:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqbJi-0008QM-Dd
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:13:03 -0500
Date: Tue, 27 Feb 2018 10:12:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180227101240.761cc93f.cohuck@redhat.com>
In-Reply-To: <dcfd4bf5-fd36-52cc-8b66-87a68e80cc48@linux.vnet.ibm.com>
References: <1519641757-12396-1-git-send-email-thuth@redhat.com>
	<1519641757-12396-7-git-send-email-thuth@redhat.com>
	<20180226194857.01ce4a8c.cohuck@redhat.com>
	<b6664df2-eec4-7e35-1498-be27b5cc3e79@linux.vnet.ibm.com>
	<dcfd4bf5-fd36-52cc-8b66-87a68e80cc48@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PULL-for-s390x 06/14] s390-ccw:
 parse and set boot menu options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Mon, 26 Feb 2018 14:44:45 -0500
"Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:

> On 02/26/2018 02:29 PM, Collin L. Walling wrote:
> > On 02/26/2018 01:48 PM, Cornelia Huck wrote: =20
> >> On Mon, 26 Feb 2018 11:42:29 +0100
> >> Thomas Huth <thuth@redhat.com> wrote:
> >>
> >> [...]
> >> =20
> >>> =C2=A0 3 files changed, 66 insertions(+), 4 deletions(-)
> >>> +static void s390_ipl_set_boot_menu(S390IPLState *ipl)
> >>> +{
> >>> +=C2=A0=C2=A0=C2=A0 QemuOptsList *plist =3D qemu_find_opts("boot-opts=
");
> >>> +=C2=A0=C2=A0=C2=A0 QemuOpts *opts =3D QTAILQ_FIRST(&plist->head);
> >>> +=C2=A0=C2=A0=C2=A0 uint8_t *flags =3D &ipl->qipl.qipl_flags;
> >>> +=C2=A0=C2=A0=C2=A0 uint32_t *timeout =3D &ipl->qipl.boot_menu_timeou=
t;
> >>> +=C2=A0=C2=A0=C2=A0 const char *tmp;
> >>> +=C2=A0=C2=A0=C2=A0 unsigned long splash_time =3D 0;
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 if (!get_boot_device(0)) {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (boot_menu) {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_report("boot menu requires a bootindex to be=20
> >>> specified for "
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "the IPL device.");
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> >>> +=C2=A0=C2=A0=C2=A0 }
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 switch (ipl->iplb.pbt) {
> >>> +=C2=A0=C2=A0=C2=A0 case S390_IPL_TYPE_CCW:
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >>> +=C2=A0=C2=A0=C2=A0 default:
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("boot menu i=
s not supported for this device=20
> >>> type."); =20
> >> If I specify both a bootindex for a device and a -kernel parameter, I
> >> get this error message. Looks a tad odd, but not sure how to avoid it.=
 =20
> >
> > Hmm... perhaps an additional check if no IPLB, then skip trying to set
> > any boot menu data?
> > =20
> >> [...] =20
> >
> > =20
> Something like:
>=20
>  =C2=A0=C2=A0=C2=A0 if (!ipl->iplb.len) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>  =C2=A0=C2=A0=C2=A0 }
>=20
> placed just below the if (!get_boot_device(0)) chunk fixed it for me.If=20
> no IPLB was set,
> then the IPLB fields should just all be zeros.=C2=A0 Why not just check i=
f=20
> the length is 0 to
> determine that we did not set an IPLB at all?


Yes, that makes the message go away for me.

>=20
> also:
>=20
>  =C2=A0=C2=A0=C2=A0 if (!ipl->iplb.len) {
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (boot_menu) {
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 error_report("b=
oot menu requires an IPLB to function");
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>  =C2=A0=C2=A0=C2=A0 }
>=20
> if you think an error message is needed (use a better message, mine is=20
> not helpful but I
> just wanted to demonstrate that the if (boot_menu) check should be=20
> nested first).

I'm not sure we want an error message for a command line that booted
without any message previously. It's not like I'd expect a boot menu
when I pass in a kernel anyway...

>=20
> Thanks for reporting this.=C2=A0 Seems to be a few cases that I missed on=
 my end.

The usual result of different people trying things :)

How shall we proceed? I'd be willing to pull this now and then apply
fixups on top, or we can have a respin. Thomas?
