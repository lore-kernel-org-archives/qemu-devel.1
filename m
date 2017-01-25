Received: from eggs.gnu.org ([2001:4830:134:3::10]:36431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cWMGB-0001oW-FQ
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 07:01:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cWMG5-0007pe-Vh
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 07:01:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cWMG5-0007p1-Qd
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 07:01:01 -0500
Date: Wed, 25 Jan 2017 12:00:53 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170125120053.GA2096@work-vm>
References: <20170124184742.1639-1-dgilbert@redhat.com>
	<20170124184742.1639-3-dgilbert@redhat.com>
	<20170125114620.GA9699@lemon.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170125114620.GA9699@lemon.Home>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 02/15] migration: extend VMStateInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, cornelia.huck@de.ibm.com
Cc: qemu-devel@nongnu.org, Jianjun Duan <duanj@linux.vnet.ibm.com>

* Fam Zheng (famz@redhat.com) wrote:
> On Tue, 01/24 18:47, Dr. David Alan Gilbert (git) wrote:
> > diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> > index c313166..da8e4df 100644
> > --- a/hw/intc/s390_flic_kvm.c
> > +++ b/hw/intc/s390_flic_kvm.c
> > @@ -286,7 +286,8 @@ static void kvm_s390_release_adapter_routes(S390F=
LICState *fs,
> >   * increase until buffer is sufficient or maxium size is
> >   * reached
> >   */
> > -static void kvm_flic_save(QEMUFile *f, void *opaque, size_t size)
> > +static int kvm_flic_save(QEMUFile *f, void *opaque, size_t size,
> > +                         VMStateField *field, QJSON *vmdesc)
> >  {
> >      KVMS390FLICState *flic =3D opaque;
> >      int len =3D FLIC_SAVE_INITIAL_SIZE;
> > @@ -319,6 +320,8 @@ static void kvm_flic_save(QEMUFile *f, void *opaq=
ue, size_t size)
> >                          count * sizeof(struct kvm_s390_irq));
> >      }
> >      g_free(buf);
> > +
> > +    return 0;
> >  }
>=20
> This hunk left one 'return' behind in the function, which should have b=
een
> changed to 'return 0' as well, and now the compiler is not happy:
>=20
> /var/tmp/patchew-tester-tmp-itftfkl9/src/hw/intc/s390_flic_kvm.c: In fu=
nction =E2=80=98kvm_flic_save=E2=80=99:
> /var/tmp/patchew-tester-tmp-itftfkl9/src/hw/intc/s390_flic_kvm.c:306:9:=
 error: =E2=80=98return=E2=80=99 with no value, in function returning non=
-void [-Werror]
>          return;
>          ^~~~~~
> /var/tmp/patchew-tester-tmp-itftfkl9/src/hw/intc/s390_flic_kvm.c:289:12=
: note: declared here
>  static int kvm_flic_save(QEMUFile *f, void *opaque, size_t size,
>             ^~~~~~~~~~~~~
> cc1: all warnings being treated as errors

OK, so it looks like that's a failure path, adding a return -ENOMEM would=
 seem to make
sense there.

Do you have a way of build testing that on x86, or can it only be build
tested on s390?
(My build test included an s390x-softmmu build on x86-64).

Dave
> Fam
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
