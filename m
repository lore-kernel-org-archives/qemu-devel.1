Received: from eggs.gnu.org ([209.51.188.92]:46082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1goYJS-0000Ew-F1
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:40:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1goYJP-0005fT-KN
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:40:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1goYJO-0005ez-7j
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:40:43 -0500
Date: Tue, 29 Jan 2019 18:40:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190129184008.GM30796@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190118093935.GA1142@beluga.usersys.redhat.com>
	<65f933a2-f63c-962f-c503-43c7e84ab5e8@amd.com>
	<20190123125506.GA2376@beluga.usersys.redhat.com>
	<20190123131042.GF27270@redhat.com>
	<20190123132212.GA20002@beluga.usersys.redhat.com>
	<20190123132413.GG27270@redhat.com>
	<20190123133301.GB20002@beluga.usersys.redhat.com>
	<20190123133614.GH27270@redhat.com>
	<25dd3d83-dbf9-5b8d-59d4-79501fe03f3c@amd.com>
	<20190129161542.GG5315@beluga.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190129161542.GG5315@beluga.usersys.redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] AMD SEV's /dev/sev permissions and probing QEMU
 for capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Erik Skultety <eskultet@redhat.com>
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dinechin@redhat.com" <dinechin@redhat.com>, "mkletzan@redhat.com" <mkletzan@redhat.com>

On Tue, Jan 29, 2019 at 05:15:42PM +0100, Erik Skultety wrote:
> On Wed, Jan 23, 2019 at 03:02:28PM +0000, Singh, Brijesh wrote:
> >
> >
> > On 1/23/19 7:36 AM, Daniel P. Berrang=C3=A9 wrote:
> > > On Wed, Jan 23, 2019 at 02:33:01PM +0100, Erik Skultety wrote:
> > >> On Wed, Jan 23, 2019 at 01:24:13PM +0000, Daniel P. Berrang=C3=A9 =
wrote:
> > >>> On Wed, Jan 23, 2019 at 02:22:12PM +0100, Erik Skultety wrote:
> > >>>> On Wed, Jan 23, 2019 at 01:10:42PM +0000, Daniel P. Berrang=C3=A9=
 wrote:
> > >>>>>
> > >>>>> It still looks like we can solve this entirely in libvirt by ju=
st giving
> > >>>>> the libvirt capabilities probing code CAP_DAC_OVERRIDE. This wo=
uld make
> > >>>>> libvirt work for all currently released SEV support in kernel/q=
emu.
> > >>>>
> > >>>> Sure we can, but that would make libvirt the only legitimate use=
r of /dev/sev
> > >>>> and everything else would require the admin to change the permis=
sions
> > >>>> explicitly so that other apps could at least retrieve the platfo=
rm info, if
> > >>>> it was intended to be for public use?
> > >>>> Additionally, we'll still get shot down by SELinux because svirt=
_t wouldn't be
> > >>>> able to access /dev/sev by default.
> > >>>
> > >>> That's separate form probing and just needs SELinux policy to def=
ine
> > >>> a new  sev_device_t type and grant svirt_t access to it.
> > >>
> > >> I know, I misread "we can solve this entirely in libvirt" then, I =
thought you
> > >> the SELinux part was included in the statement, my bad then. Still=
, back to the
> > >> original issue, we could technically do both, libvirt would have r=
un qemu with
> > >> CAP_DAC_OVERRIDE and we keep working with everything's been releas=
ed for
> > >> SEV in kernel/qemu and for everyone else, systemd might add 0644 f=
or /dev/sev,
> > >> that way, everyone's happy, not that I'd be a fan of libvirt often=
 having
> > >> to work around something because projects underneath wouldn't back=
port fixes to
> > >> all the distros we support, thus leaving the dirty work to us.
> > >
> > > Setting 0644 for /dev/sev looks unsafe to me unless someone can sho=
w
> > > where the permissions checks take place for the many ioctls that
> > > /dev/sev allows, such that only SEV_PDH_CERT_EXPORT or SEV_PLATFORM=
_STATUS
> > > is allowed when /dev/sev is opened by a user who doesn't have write
> > > permissions.
> > >
> >
> > Agree its not safe to do 0644.
> >
> > Currently, anyone who has access to /dev/sev (read or write) will be
> > able to execute SEV platform command. In other words there is no
> > permission check per command basis. I must admit that while developin=
g
> > the driver I was under assumption that only root will ever access the
> > /dev/sev device hence overlooked it. But now knowing that others may
> > also need to access the /dev/sev, I can submit patch in kernel to do
> > per command access control.
> >
> > Until then, can we follow Daniel's recommendation to elevate privileg=
e
> > of the probing code?
>=20
> So, sorry for not coming back earlier, but I'm still fighting a permiss=
ion
> issue when opening the /dev/sev device and I honestly don't know what's
> happening. If you apply the patch bellow (or attachment) and you run li=
bvirtd
> with LIBVIRT_LOG_OUTPUTS=3D1:file:<your_log_file> env, you should see s=
omething
> like this in the logs:
>=20
> warning : virExec:778 : INHERITABLE CAPS: 'dac_override'
> warning : virExec:781 : EFFECTIVE CAPS: 'dac_override'
> warning : virExec:784 : PERMITTED CAPS: 'dac_override'
> warning : virExec:787 : BOUNDING CAPS: 'dac_override'
>=20
> ...and that is right before we issue execve. Yet, if you debug further =
into the
> QEMU process right after execve, it doesn't report any capabilities at =
all, so
> naturally it'll still get permission denied. Is there something I'm mis=
sing
> here?

Arrrrggghh.  We're missing the painful thing that I re-learn the hard way
every time we play with capabilities in libvirt.....

*Even* if you have set INHERITABLE capabilities, they are discarded
on execve(), unless the binary you are exec'ing has file capabilities
set that match those you are trying to give it. Of course QEMU binaries
(and almost all binaries) lack such file capabilities.

The capabilities man page does in fact explain this

[quote]
        P=E2=80=99(permitted) =3D (P(inheritable) & F(inheritable)) |
                        (F(permitted) & cap_bset)

        P=E2=80=99(effective) =3D F(effective) ? P=E2=80=99(permitted) : =
0

where

        P         denotes the value of a thread capability set before the=
 execve(2)

        P'        denotes the value of a thread capability set after the =
execve(2)

        F         denotes a file capability set

If ... real user ID of the process is 0 (root) then the file inheritable
and permitted sets are defined to be all ones
[/quote]

So this means your code works perfectly *if*  we are executing
QEMU as root, but if we are executing QEMU as non-root then
all our work is for nothing.

Now I have actually intentionally mis-quoted from an old man
page here. In Linux 4.3 the kernel devs invented a new set of
"ambient" capabilities [1] which allow programs to deal with this
insanely annoying behaviour.

[quote]
        P'(ambient)     =3D (file is privileged) ? 0 : P(ambient)

        P'(permitted)   =3D (P(inheritable) & F(inheritable)) |
                          (F(permitted) & cap_bset) | P'(ambient)

        P'(effective)   =3D F(effective) ? P'(permitted) : P'(ambient)
[/quote]

so if we added CAP_DAC_OVERRIDE to the ambient capabilities set,
then your patch would work.

We can do that with this patch:

diff --git a/src/util/virutil.c b/src/util/virutil.c
index 5251b66454..be83e91fee 100644
--- a/src/util/virutil.c
+++ b/src/util/virutil.c
@@ -1601,6 +1601,12 @@ virSetUIDGIDWithCaps(uid_t uid, gid_t gid, gid_t *=
groups, int ngroups,
         goto cleanup;
     }
=20
+    for (i =3D 0; i <=3D CAP_LAST_CAP; i++) {
+        if (capBits & (1ULL << i)) {
+            prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_RAISE, i, 0, 0);
+        }
+    }
+
     ret =3D 0;
  cleanup:
     return ret;


though, we need a #ifdef check for existance of PR_CAP_AMBIENT=20

> An alternative question I've been playing ever since we exchanged the l=
ast few
> emails is that can't we wait until the ioctls are compared against perm=
issions
> in kernel so that upstream libvirt (and downstream too for that matter)=
 doesn't
> have to work around it and stick with that workaround for eternity?

IIUC, the SEV feature has already shipped with distros, so we'd effective=
ly
be saying that what we already shipped is unusable to libvirt. This doesn=
't
feel like a desirable story to me.


Regards,
Daniel

[1] https://s3hh.wordpress.com/2015/07/25/ambient-capabilities/
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
