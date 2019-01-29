Received: from eggs.gnu.org ([209.51.188.92]:42811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1goWD4-0007Jq-I9
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 11:26:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1goWCz-0004yC-Pr
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 11:26:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1goWCv-0004f8-Il
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 11:25:54 -0500
Date: Tue, 29 Jan 2019 17:15:42 +0100
From: Erik Skultety <eskultet@redhat.com>
Message-ID: <20190129161542.GG5315@beluga.usersys.redhat.com>
References: <20190118093935.GA1142@beluga.usersys.redhat.com>
	<65f933a2-f63c-962f-c503-43c7e84ab5e8@amd.com>
	<20190123125506.GA2376@beluga.usersys.redhat.com>
	<20190123131042.GF27270@redhat.com>
	<20190123132212.GA20002@beluga.usersys.redhat.com>
	<20190123132413.GG27270@redhat.com>
	<20190123133301.GB20002@beluga.usersys.redhat.com>
	<20190123133614.GH27270@redhat.com>
	<25dd3d83-dbf9-5b8d-59d4-79501fe03f3c@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <25dd3d83-dbf9-5b8d-59d4-79501fe03f3c@amd.com>
Content-Transfer-Encoding: 7bit
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
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dinechin@redhat.com" <dinechin@redhat.com>, "mkletzan@redhat.com" <mkletzan@redhat.com>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 23, 2019 at 03:02:28PM +0000, Singh, Brijesh wrote:
>
>
> On 1/23/19 7:36 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Jan 23, 2019 at 02:33:01PM +0100, Erik Skultety wrote:
> >> On Wed, Jan 23, 2019 at 01:24:13PM +0000, Daniel P. Berrang=C3=A9 wr=
ote:
> >>> On Wed, Jan 23, 2019 at 02:22:12PM +0100, Erik Skultety wrote:
> >>>> On Wed, Jan 23, 2019 at 01:10:42PM +0000, Daniel P. Berrang=C3=A9 =
wrote:
> >>>>> On Wed, Jan 23, 2019 at 01:55:06PM +0100, Erik Skultety wrote:
> >>>>>> On Fri, Jan 18, 2019 at 12:51:50PM +0000, Singh, Brijesh wrote:
> >>>>>>>
> >>>>>>> On 1/18/19 3:39 AM, Erik Skultety wrote:
> >>>>>>>> Hi,
> >>>>>>>> this is a summary of a private discussion I've had with guys C=
C'd on this email
> >>>>>>>> about finding a solution to [1] - basically, the default permi=
ssions on
> >>>>>>>> /dev/sev (below) make it impossible to query for SEV platform =
capabilities,
> >>>>>>>> since by default we run QEMU as qemu:qemu when probing for cap=
abilities. It's
> >>>>>>>> worth noting is that this is only relevant to probing, since f=
or a proper QEMU
> >>>>>>>> VM we create a mount namespace for the process and chown all t=
he nodes (needs a
> >>>>>>>> SEV fix though).
> >>>>>>>>
> >>>>>>>> # ll /dev/sev
> >>>>>>>> crw-------. 1 root root
> >>>>>>>>
> >>>>>>>> I suggested either force running QEMU as root for probing (des=
pite the obvious
> >>>>>>>> security implications) or using namespaces for probing too. Da=
n argued that
> >>>>>>>> this would have a significant perf impact and suggested we ask=
 systemd to add a
> >>>>>>>> global udev rule.
> >>>>>>>>
> >>>>>>>> I proceeded with cloning [1] to systemd and creating an udev r=
ule that I planned
> >>>>>>>> on submitting to systemd upstream - the initial idea was to mi=
mic /dev/kvm and
> >>>>>>>> make it world accessible to which Brijesh from AMD expressed a=
 concern that
> >>>>>>>> regular users might deplete the resources (limit on the number=
 of guests
> >>>>>>>> allowed by the platform).
> >>>>>>>
> >>>>>>>
> >>>>>>> During private discussion I didn't realized that we are discuss=
ing a
> >>>>>>> probe issue hence things I have said earlier may not be applica=
ble
> >>>>>>> during the probe. The /dev/sev is managed by the CCP (aka PSP) =
driver.
> >>>>>>> The /dev/sev is used for communicating with the SEV FW running =
inside
> >>>>>>> the PSP. The SEV FW offers platform and guest specific services=
. The
> >>>>>>> guest specific services are used during the guest launch, these=
 services
> >>>>>>> are available through KVM driver only. Whereas the platform ser=
vices can
> >>>>>>> be invoked at anytime. A typical platform specific services are=
:
> >>>>>>>
> >>>>>>> - importing certificates
> >>>>>>>
> >>>>>>> - exporting certificates
> >>>>>>>
> >>>>>>> - querying the SEV FW version etc etc
> >>>>>>>
> >>>>>>> In case of the probe we are not launch SEV guest hence we shoul=
d not be
> >>>>>>> worried about depleting the SEV ASID resources.
> >>>>>>>
> >>>>>>> IIRC, libvirt uses QEMP query-sev-capabilities to probe the SEV=
 support.
> >>>>>>> QEMU executes the below sequence to complete the request:
> >>>>>>>
> >>>>>>> 1. Exports the platform certificates=C2=A0 (this is when /dev/s=
ev is accessed).
> >>>>>>>
> >>>>>>> 2. Read the host MSR to determine the C-bit and reduced phys-bi=
t position
> >>>>>>>
> >>>>>>> I don't see any reason why we can't give world a 'read' permiss=
ion to
> >>>>>>> /dev/sev. Anyone should be able to export the certificates and =
query
> >>>>>>
> >>>>>> Okay, makes sense to me. The problem I see is the sev_platform_i=
octl function
> >>>>>> in QEMU which makes an _IOWR request, therefore the file descrip=
tor being
> >>>>>> opened in sev_get_capabilities is O_RDWR. Now, I only understand=
 ioctl from
> >>>>>> what I've read in the man page, so I don't quite understand the =
need for IOWR
> >>>>>> here - but my honest guess would be that it's because the comman=
ds like
> >>>>>> SEV_PDH_CERT_EXPORT or SEV_PLATFORM_STATUS need to be copied fro=
m userspace to
> >>>>>> kernel to instruct kernel which services we want, ergo _IOWR, is=
 that right?
> >>>>>
> >>>>> I'm not seeing any permissions checks in the sev_ioctl() function=
 in the
> >>>>> kernel, so IIUC, that means any permissions are entirely based on=
 whether
> >>>>> you can open the /dev/sev, once open you can run any ioctl.  What=
, if anything,
> >>>>> enforces which ioctls you can run when the device is only O_RDONL=
Y vs O_RDWR ?
> >>>>
> >>>> I don't know, that's why I'm asking, because the manual didn't mak=
e it any
> >>>> clear for me whether there's a connection between the device permi=
ssions and
> >>>> ioctls that you're allowed to run.
> >>>>
> >>>>>
> >>>>>> In any case, a fix of some sort needs to land in QEMU first, bec=
ause no udev
> >>>>>> rule would fix the current situation. Afterwards, I expect that =
having a rule
> >>>>>> like this:
> >>>>>>
> >>>>>> KERNEL=3D=3D"sev", GROUP=3D"kvm", MODE=3D"0644"
> >>>>>>
> >>>>>> and a selinux policy rule adding the kvm_device_t label, we shou=
ld be fine, do
> >>>>>> we agree on that?
> >>>>>
> >>>>> Based on what I think I see above, this looks like a bad idea.
> >>>>>
> >>>>> It still looks like we can solve this entirely in libvirt by just=
 giving
> >>>>> the libvirt capabilities probing code CAP_DAC_OVERRIDE. This woul=
d make
> >>>>> libvirt work for all currently released SEV support in kernel/qem=
u.
> >>>>
> >>>> Sure we can, but that would make libvirt the only legitimate user =
of /dev/sev
> >>>> and everything else would require the admin to change the permissi=
ons
> >>>> explicitly so that other apps could at least retrieve the platform=
 info, if
> >>>> it was intended to be for public use?
> >>>> Additionally, we'll still get shot down by SELinux because svirt_t=
 wouldn't be
> >>>> able to access /dev/sev by default.
> >>>
> >>> That's separate form probing and just needs SELinux policy to defin=
e
> >>> a new  sev_device_t type and grant svirt_t access to it.
> >>
> >> I know, I misread "we can solve this entirely in libvirt" then, I th=
ought you
> >> the SELinux part was included in the statement, my bad then. Still, =
back to the
> >> original issue, we could technically do both, libvirt would have run=
 qemu with
> >> CAP_DAC_OVERRIDE and we keep working with everything's been released=
 for
> >> SEV in kernel/qemu and for everyone else, systemd might add 0644 for=
 /dev/sev,
> >> that way, everyone's happy, not that I'd be a fan of libvirt often h=
aving
> >> to work around something because projects underneath wouldn't backpo=
rt fixes to
> >> all the distros we support, thus leaving the dirty work to us.
> >
> > Setting 0644 for /dev/sev looks unsafe to me unless someone can show
> > where the permissions checks take place for the many ioctls that
> > /dev/sev allows, such that only SEV_PDH_CERT_EXPORT or SEV_PLATFORM_S=
TATUS
> > is allowed when /dev/sev is opened by a user who doesn't have write
> > permissions.
> >
>
> Agree its not safe to do 0644.
>
> Currently, anyone who has access to /dev/sev (read or write) will be
> able to execute SEV platform command. In other words there is no
> permission check per command basis. I must admit that while developing
> the driver I was under assumption that only root will ever access the
> /dev/sev device hence overlooked it. But now knowing that others may
> also need to access the /dev/sev, I can submit patch in kernel to do
> per command access control.
>
> Until then, can we follow Daniel's recommendation to elevate privilege
> of the probing code?

So, sorry for not coming back earlier, but I'm still fighting a permissio=
n
issue when opening the /dev/sev device and I honestly don't know what's
happening. If you apply the patch bellow (or attachment) and you run libv=
irtd
with LIBVIRT_LOG_OUTPUTS=3D1:file:<your_log_file> env, you should see som=
ething
like this in the logs:

warning : virExec:778 : INHERITABLE CAPS: 'dac_override'
warning : virExec:781 : EFFECTIVE CAPS: 'dac_override'
warning : virExec:784 : PERMITTED CAPS: 'dac_override'
warning : virExec:787 : BOUNDING CAPS: 'dac_override'

...and that is right before we issue execve. Yet, if you debug further in=
to the
QEMU process right after execve, it doesn't report any capabilities at al=
l, so
naturally it'll still get permission denied. Is there something I'm missi=
ng
here?

An alternative question I've been playing ever since we exchanged the las=
t few
emails is that can't we wait until the ioctls are compared against permis=
sions
in kernel so that upstream libvirt (and downstream too for that matter) d=
oesn't
have to work around it and stick with that workaround for eternity?

diff --git a/src/qemu/qemu_capabilities.c b/src/qemu/qemu_capabilities.c
index f504db7d05..4d7ec2781a 100644
--- a/src/qemu/qemu_capabilities.c
+++ b/src/qemu/qemu_capabilities.c
@@ -53,6 +53,10 @@
 #include <stdarg.h>
 #include <sys/utsname.h>

+#if WITH_CAPNG
+# include <cap-ng.h>
+#endif
+
 #define VIR_FROM_THIS VIR_FROM_QEMU

 VIR_LOG_INIT("qemu.qemu_capabilities");
@@ -4521,6 +4525,12 @@ virQEMUCapsInitQMPCommandRun(virQEMUCapsInitQMPCom=
mandPtr cmd,
                                     NULL);
     virCommandAddEnvPassCommon(cmd->cmd);
     virCommandClearCaps(cmd->cmd);
+#if WITH_CAPNG
+    /* QEMU might run into permission issues, e.g. /dev/sev (0600), over=
riding
+     * it just for probing is okay from security POV */
+    virCommandAllowCap(cmd->cmd, CAP_DAC_OVERRIDE);
+#endif
+
     virCommandSetGID(cmd->cmd, cmd->runGid);
     virCommandSetUID(cmd->cmd, cmd->runUid);

diff --git a/src/util/vircommand.c b/src/util/vircommand.c
index d965068369..6d49416704 100644
--- a/src/util/vircommand.c
+++ b/src/util/vircommand.c
@@ -771,6 +771,23 @@ virExec(virCommandPtr cmd)
             goto fork_error;
     }

+#if WITH_CAPNG
+    if (strstr(cmd->args[0], "qemu")) {
+        VIR_WARN("INHERITABLE CAPS: '%s'",
+                 capng_print_caps_text(CAPNG_PRINT_BUFFER,
+                                       CAPNG_INHERITABLE));
+        VIR_WARN("EFFECTIVE CAPS: '%s'",
+                 capng_print_caps_text(CAPNG_PRINT_BUFFER,
+                                       CAPNG_EFFECTIVE));
+        VIR_WARN("PERMITTED CAPS: '%s'",
+                 capng_print_caps_text(CAPNG_PRINT_BUFFER,
+                                       CAPNG_PERMITTED));
+        VIR_WARN("BOUNDING CAPS: '%s'",
+                 capng_print_caps_text(CAPNG_PRINT_BUFFER,
+                                       CAPNG_BOUNDING_SET));
+    }
+#endif
+
     /* Close logging again to ensure no FDs leak to child */
     virLogReset();



Thanks,
Erik



--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="dac_override.patch"

diff --git a/src/qemu/qemu_capabilities.c b/src/qemu/qemu_capabilities.c
index f504db7d05..4d7ec2781a 100644
--- a/src/qemu/qemu_capabilities.c
+++ b/src/qemu/qemu_capabilities.c
@@ -53,6 +53,10 @@
 #include <stdarg.h>
 #include <sys/utsname.h>
 
+#if WITH_CAPNG
+# include <cap-ng.h>
+#endif
+
 #define VIR_FROM_THIS VIR_FROM_QEMU
 
 VIR_LOG_INIT("qemu.qemu_capabilities");
@@ -4521,6 +4525,12 @@ virQEMUCapsInitQMPCommandRun(virQEMUCapsInitQMPCommandPtr cmd,
                                     NULL);
     virCommandAddEnvPassCommon(cmd->cmd);
     virCommandClearCaps(cmd->cmd);
+#if WITH_CAPNG
+    /* QEMU might run into permission issues, e.g. /dev/sev (0600), overriding
+     * it just for probing is okay from security POV */
+    virCommandAllowCap(cmd->cmd, CAP_DAC_OVERRIDE);
+#endif
+
     virCommandSetGID(cmd->cmd, cmd->runGid);
     virCommandSetUID(cmd->cmd, cmd->runUid);
 
diff --git a/src/util/vircommand.c b/src/util/vircommand.c
index d965068369..6d49416704 100644
--- a/src/util/vircommand.c
+++ b/src/util/vircommand.c
@@ -771,6 +771,23 @@ virExec(virCommandPtr cmd)
             goto fork_error;
     }
 
+#if WITH_CAPNG
+    if (strstr(cmd->args[0], "qemu")) {
+        VIR_WARN("INHERITABLE CAPS: '%s'",
+                 capng_print_caps_text(CAPNG_PRINT_BUFFER,
+                                       CAPNG_INHERITABLE));
+        VIR_WARN("EFFECTIVE CAPS: '%s'",
+                 capng_print_caps_text(CAPNG_PRINT_BUFFER,
+                                       CAPNG_EFFECTIVE));
+        VIR_WARN("PERMITTED CAPS: '%s'",
+                 capng_print_caps_text(CAPNG_PRINT_BUFFER,
+                                       CAPNG_PERMITTED));
+        VIR_WARN("BOUNDING CAPS: '%s'",
+                 capng_print_caps_text(CAPNG_PRINT_BUFFER,
+                                       CAPNG_BOUNDING_SET));
+    }
+#endif
+
     /* Close logging again to ensure no FDs leak to child */
     virLogReset();
 

--EeQfGwPcQSOJBaQU--
