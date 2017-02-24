Received: from eggs.gnu.org ([2001:4830:134:3::10]:49074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1ch7Ly-0001k0-FD
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 23:19:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1ch7Lw-00056x-Ko
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 23:19:34 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:34507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1ch7Lw-00056e-Dg
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 23:19:32 -0500
Received: by mail-it0-x244.google.com with SMTP id r141so1540599ita.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 20:19:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170222144407.GS19045@localhost.localdomain>
References: <CAAo6VWOAnGQeDwc_bJ4M=FQsu7rOhAv=1Qk6PdzG+0pcVnku=A@mail.gmail.com>
	<20170217214215.GK19045@localhost.localdomain>
	<F23F188C-DAF9-49EA-9C0E-54F57945267A@veritas.com>
	<20170220110235.GD21255@stefanha-x1.localdomain>
	<CAAo6VWNwHbsQRxU18dNCjWaNfNrZNAV9FfOKW8=JeZCND2vHnQ@mail.gmail.com>
	<20170221105918.GA22731@stefanha-x1.localdomain>
	<20170221113353.GC17041@redhat.com>
	<20170222140920.GA10201@stefanha-x1.localdomain>
	<20170222142230.GR28937@redhat.com>
	<20170222144407.GS19045@localhost.localdomain>
From: ashish mittal <ashmit602@gmail.com>
Date: Thu, 23 Feb 2017 20:19:29 -0800
Message-ID: <CAAo6VWPWjRTE3t9myt7Q6gTnZcvP72ypTE03PCFfJkvb2UWLTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v8 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

Hi,

Just want to check if the following mechanism for accepting the secret
password looks OK?

We have yet to internally discuss the semantics of how we plan to use
the user-ID/password for authentication. This diff is just to
understand how I am expected to accept the secret from the command
line.

Example specifying the username and password:

$ ./qemu-io --trace enable=vxhs* --object
secret,id=ashish,data=asd888d989s  -c 'read 66000 128k'
'json:{"server.host": "127.0.0.1", "server.port": "9999", "vdisk-id":
"/test.raw", "driver": "vxhs", "user": "ashish"}'
17396@1487908905.546890:vxhs_open_vdiskid Opening vdisk-id /test.raw
17396@1487908905.546969:vxhs_get_creds SecretID ashish, Password
asd888d989s   <==== NOTE!!!!!
17396@1487908905.546994:vxhs_open_hostinfo Adding host 127.0.0.1:9999
to BDRVVXHSState
17396@1487908905.568370:vxhs_get_vdisk_stat vDisk /test.raw stat ioctl
returned size 196616
read 131072/131072 bytes at offset 66000
128 KiB, 1 ops; 0.0017 sec (72.844 MiB/sec and 582.7506 ops/sec)
17396@1487908905.570917:vxhs_close Closing vdisk /test.raw
[root@rhel72ga-build-upstream qemu] 2017-02-23 20:01:45$

Example where username and password are missing:

[root@rhel72ga-build-upstream qemu] 2017-02-23 19:30:16$ ./qemu-io
--trace enable=vxhs* -c 'read 66000 128k' 'json:{"server.host":
"127.0.0.1", "server.port": "9999", "vdisk-id": "/test.raw", "driver":
"vxhs"}'
16120@1487907025.251167:vxhs_open_vdiskid Opening vdisk-id /test.raw
16120@1487907025.251245:vxhs_get_creds SecretID user, Password (null)
can't open device json:{"server.host": "127.0.0.1", "server.port":
"9999", "vdisk-id": "/test.raw", "driver": "vxhs"}: No secret with id
'user'      <==== NOTE!!!!!
[root@rhel72ga-build-upstream qemu] 2017-02-23 19:30:25$


diff --git a/block/vxhs.c b/block/vxhs.c
index 4f0633e..f3e70ce 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -17,6 +17,7 @@
 #include "qemu/uri.h"
 #include "qapi/error.h"
 #include "qemu/uuid.h"
+#include "crypto/secret.h"

 #define VXHS_OPT_FILENAME           "filename"
 #define VXHS_OPT_VDISK_ID           "vdisk-id"
@@ -136,6 +137,14 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "UUID of the VxHS vdisk",
         },
+        {
+            .name = "user",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "password",
+            .type = QEMU_OPT_STRING,
+        },
         { /* end of list */ }
     },
 };
@@ -257,6 +266,8 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
     const char *server_host_opt;
     char *str = NULL;
     int ret = 0;
+    const char *user = NULL;
+    const char *password = NULL;

     ret = vxhs_init_and_ref();
     if (ret < 0) {
@@ -320,6 +331,23 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
         goto out;
     }

+    /* check if we got username via the options */
+    user = qemu_opt_get(opts, "user");
+    if (!user) {
+        //trace_vxhs_get_creds(user, password);
+        user = "user";
+        //return;
+    }
+
+    password = qcrypto_secret_lookup_as_utf8(user, &local_err);
+    if (local_err != NULL) {
+        trace_vxhs_get_creds(user, password);
+        qdict_del(backing_options, str);
+        ret = -EINVAL;
+        goto out;
+    }
+    trace_vxhs_get_creds(user, password);
+
     s->vdisk_hostinfo.host = g_strdup(server_host_opt);

     s->vdisk_hostinfo.port = g_ascii_strtoll(qemu_opt_get(tcp_opts,

Thanks,
Ashish

On Wed, Feb 22, 2017 at 6:44 AM, Jeff Cody <jcody@redhat.com> wrote:
> On Wed, Feb 22, 2017 at 02:22:30PM +0000, Daniel P. Berrange wrote:
>> On Wed, Feb 22, 2017 at 02:09:20PM +0000, Stefan Hajnoczi wrote:
>> > On Tue, Feb 21, 2017 at 11:33:53AM +0000, Daniel P. Berrange wrote:
>> > > On Tue, Feb 21, 2017 at 10:59:18AM +0000, Stefan Hajnoczi wrote:
>> > > > On Mon, Feb 20, 2017 at 03:34:57AM -0800, ashish mittal wrote:
>> > > > > On Mon, Feb 20, 2017 at 3:02 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> > > > > > On Sat, Feb 18, 2017 at 12:30:31AM +0000, Ketan Nilangekar wrote:
>> > > > > >> On 2/17/17, 1:42 PM, "Jeff Cody" <jcody@redhat.com> wrote:
>> > > > > >>
>> > > > > >>     On Thu, Feb 16, 2017 at 02:24:19PM -0800, ashish mittal wrote:
>> > > > > >>     > Hi,
>> > > > > >>     >
>> > > > > >>     > I am getting the following error with checkpatch.pl
>> > > > > >>     >
>> > > > > >>     > ERROR: externs should be avoided in .c files
>> > > > > >>     > #78: FILE: block/vxhs.c:28:
>> > > > > >>     > +QemuUUID qemu_uuid __attribute__ ((weak));
>> > > > > >>     >
>> > > > > >>     > Is there any way to get around this, or does it mean that I would have
>> > > > > >>     > to add a vxhs.h just for this one entry?
>> > > > > >>     >
>> > > > > >>
>> > > > > >>     I remain skeptical on the use of the qemu_uuid as a way to select the TLS
>> > > > > >>     cert.
>> > > > > >>
>> > > > > >> [ketan]
>> > > > > >> Is there another identity that can be used for uniquely identifying instances?
>> > > > > >> The requirement was to enforce vdisk access to owner instances.
>> > > > > >
>> > > > > > The qemu_uuid weak attribute looks suspect.  What is going to provide a
>> > > > > > strong qemu_uuid symbol?
>> > > > > >
>> > > > > > Why aren't configuration parameters like the UUID coming from the QEMU
>> > > > > > command-line?
>> > > > > >
>> > > > > > Stefan
>> > > > >
>> > > > > UUID will in fact come from the QEMU command line. VxHS is not doing
>> > > > > anything special here. It will just use the value already available to
>> > > > > qemu-kvm process.
>> > > > >
>> > > > > QemuUUID qemu_uuid;
>> > > > > bool qemu_uuid_set;
>> > > > >
>> > > > > Both the above are defined in vl.c. vl.c will provide the strong
>> > > > > symbol when available. There are certain binaries that do not get
>> > > > > linked with vl.c (e.g. qemu-img). The weak symbol will come into
>> > > > > affect for such binaries, and in this case, the default VXHS UUID will
>> > > > > get picked up. I had, in a previous email, explained how we plan to
>> > > > > use the default UUID. In the regular case, the VxHS controller will
>> > > > > not allow access to the default UUID (non qemu-kvm) binaries, but it
>> > > > > may choose to grant temporary access to specific vdisks for these
>> > > > > binaries depending on the workflow.
>> > > >
>> > > > That idea sounds like a security problem.  During this time window
>> > > > anyone could use the default UUID to access the data?
>> > >
>> > > Any use of the VM UUID as a means to control authorization on the
>> > > server side is a security flaw, as this is a public value which
>> > > cannot be trusted on its own.
>> > >
>> > > There needs to be some kind of authentication step to verify the
>> > > reported identity, eg a password associated with the VM UUID that
>> > > is validated before trusting the VM UUID.
>> > >
>> > > Alternatively there needs to be a completely separate UUID, unrelated
>> > > to the VM UUID, which is treated as a private value (eg uses the
>> > > '-object secret' framework in QEMU)
>> >
>> > I thought the UUID is used to select the TLS client certificate and
>> > associated private key.  So the UUID provides authorization although
>> > what really matters is the client certificate, not the actual value of
>> > the UUID.
>>
>> The message shown a few replies earlier said:
>>
>>   "VxHS controller will not allow access to the default UUID (non qemu-kvm)
>>    binaries, but it may choose to grant temporary access to specific
>>    vdisks"
>>
>> which suggests the VxHS server is making authorization decisions based
>> on UUID, but perhaps this is incorrect interpretation and it really is
>> making decisions based on the x509 cert identity or something else ?
>>
>>
>> In any case hardcoding a policy of using the UUID to select a cert path
>> is a flawed design. We can't assume that everyone deploying QEMU is going
>> to be willing to configure a separate certificate per QEMU VM instance
>> launched. People's CA management policies are often so burdensome that
>> it will be impractical to generate a new cert for VMs on the fly. So we
>> should expect that many people will just deploy one cert per host, with
>> the cert being statically created at the time they setup the host. Thus
>> we need to just be able to specify certs used explicitly when adding a
>> disk to QEMU, so we can support different deployment models for cert
>> usage
>>
>
> I do believe it is using the UUID to select the cert/key files; from
> libqnio:
>
> https://github.com/VeritasHyperScale/libqnio/blob/securify/src/lib/qnio/utils.c#L81
>
> That instanceid is the UUID passed in during the initial call to iio_init().
>
> Also, does QEMU make any promises about qemu_uuid either being 0 or
> undefined for qemu-img and qemu-io in the future?  If that assumption
> changes in the future, it would also break the scheme in the these patches.
>
> -Jeff
