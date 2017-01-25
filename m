Received: from eggs.gnu.org ([2001:4830:134:3::10]:53417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cWNXQ-0003yE-SZ
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:23:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cWNXP-00073F-SC
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:23:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cWNXP-00072p-KN
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:22:59 -0500
Date: Wed, 25 Jan 2017 13:22:55 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170125132254.GB2096@work-vm>
References: <20170124184742.1639-1-dgilbert@redhat.com>
	<20170124184742.1639-3-dgilbert@redhat.com>
	<20170125114620.GA9699@lemon.Home> <20170125120053.GA2096@work-vm>
	<20170125131917.32df62ef.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170125131917.32df62ef.cornelia.huck@de.ibm.com>
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
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Jianjun Duan <duanj@linux.vnet.ibm.com>

* Cornelia Huck (cornelia.huck@de.ibm.com) wrote:
> On Wed, 25 Jan 2017 12:00:53 +0000
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>=20
> > * Fam Zheng (famz@redhat.com) wrote:
> > > On Tue, 01/24 18:47, Dr. David Alan Gilbert (git) wrote:
> > > > diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> > > > index c313166..da8e4df 100644
> > > > --- a/hw/intc/s390_flic_kvm.c
> > > > +++ b/hw/intc/s390_flic_kvm.c
> > > > @@ -286,7 +286,8 @@ static void kvm_s390_release_adapter_routes(S=
390FLICState *fs,
> > > >   * increase until buffer is sufficient or maxium size is
> > > >   * reached
> > > >   */
> > > > -static void kvm_flic_save(QEMUFile *f, void *opaque, size_t size=
)
> > > > +static int kvm_flic_save(QEMUFile *f, void *opaque, size_t size,
> > > > +                         VMStateField *field, QJSON *vmdesc)
> > > >  {
> > > >      KVMS390FLICState *flic =3D opaque;
> > > >      int len =3D FLIC_SAVE_INITIAL_SIZE;
> > > > @@ -319,6 +320,8 @@ static void kvm_flic_save(QEMUFile *f, void *=
opaque, size_t size)
> > > >                          count * sizeof(struct kvm_s390_irq));
> > > >      }
> > > >      g_free(buf);
> > > > +
> > > > +    return 0;
> > > >  }
> > >=20
> > > This hunk left one 'return' behind in the function, which should ha=
ve been
> > > changed to 'return 0' as well, and now the compiler is not happy:
> > >=20
> > > /var/tmp/patchew-tester-tmp-itftfkl9/src/hw/intc/s390_flic_kvm.c: I=
n function =E2=80=98kvm_flic_save=E2=80=99:
> > > /var/tmp/patchew-tester-tmp-itftfkl9/src/hw/intc/s390_flic_kvm.c:30=
6:9: error: =E2=80=98return=E2=80=99 with no value, in function returning=
 non-void [-Werror]
> > >          return;
> > >          ^~~~~~
> > > /var/tmp/patchew-tester-tmp-itftfkl9/src/hw/intc/s390_flic_kvm.c:28=
9:12: note: declared here
> > >  static int kvm_flic_save(QEMUFile *f, void *opaque, size_t size,
> > >             ^~~~~~~~~~~~~
> > > cc1: all warnings being treated as errors
> >=20
> > OK, so it looks like that's a failure path, adding a return -ENOMEM w=
ould seem to make
> > sense there.
>=20
> Just saw this. I don't think we want -ENOMEM, as that would change the
> actual state being saved, no?

But isn't that the intention of this function?

    buf =3D g_try_malloc0(len);
    if (!buf) {
        /* Storing FLIC_FAILED into the count field here will cause the
         * target system to fail when attempting to load irqs from the
         * migration state */
        error_report("flic: couldn't allocate memory");
        qemu_put_be64(f, FLIC_FAILED);
        return;
    }

What should happen on the destination - should the migration fail?
If we want the migration to fail then we should now return an error
status rather than 0, and then we see a failed migration on the source
as well.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
