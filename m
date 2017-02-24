Received: from eggs.gnu.org ([2001:4830:134:3::10]:37840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1chPJh-0004jN-GM
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 18:30:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1chPJf-0004Mu-Os
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 18:30:25 -0500
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:34867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1chPJf-0004Mi-JG
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 18:30:23 -0500
Received: by mail-io0-x241.google.com with SMTP id v13so517253iov.2
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 15:30:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170224091916.GD3702@redhat.com>
References: <20170217214215.GK19045@localhost.localdomain>
	<F23F188C-DAF9-49EA-9C0E-54F57945267A@veritas.com>
	<20170220110235.GD21255@stefanha-x1.localdomain>
	<CAAo6VWNwHbsQRxU18dNCjWaNfNrZNAV9FfOKW8=JeZCND2vHnQ@mail.gmail.com>
	<20170221105918.GA22731@stefanha-x1.localdomain>
	<20170221113353.GC17041@redhat.com>
	<20170222140920.GA10201@stefanha-x1.localdomain>
	<20170222142230.GR28937@redhat.com>
	<20170222144407.GS19045@localhost.localdomain>
	<CAAo6VWPWjRTE3t9myt7Q6gTnZcvP72ypTE03PCFfJkvb2UWLTA@mail.gmail.com>
	<20170224091916.GD3702@redhat.com>
From: ashish mittal <ashmit602@gmail.com>
Date: Fri, 24 Feb 2017 15:30:21 -0800
Message-ID: <CAAo6VWPyQrjSp2qjvxqXRPS8=5N85i0-DJdkWhiGaXmND_8+qA@mail.gmail.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

Thanks!

I hope the following is in line with what you suggested -

We will error out in case either of username, secret-id, or password
are missing.

Good case, passing password via a file -
$ ./qemu-io --trace enable=vxhs* --object
secret,id=xvxhspasswd,file=/tmp/some/file/path  -c 'read 66000 128k'
'json:{"server.host": "127.0.0.1", "server.port": "9999", "vdisk-id":
"/test.raw", "driver": "vxhs", "user": "ashish",  "password-secret":
"xvxhspasswd"}'
1132@1487977829.151064:vxhs_open_vdiskid Opening vdisk-id /test.raw

1132@1487977829.151141:vxhs_get_creds User ashish, SecretID
xvxhspasswd, Password Str0ngP@ssw0rd   <=== ****  NOTE WILL NOT PRINT
PASSWORD IN FINAL CODE ****

1132@1487977829.151168:vxhs_open_hostinfo Adding host 127.0.0.1:9999
to BDRVVXHSState
1132@1487977829.173062:vxhs_get_vdisk_stat vDisk /test.raw stat ioctl
returned size 196616
read 131072/131072 bytes at offset 66000
128 KiB, 1 ops; 0.0012 sec (99.049 MiB/sec and 792.3930 ops/sec)
1132@1487977829.175141:vxhs_close Closing vdisk /test.raw


Bad case, missing user -
$ ./qemu-io --trace enable=vxhs* --object
secret,id=xvxhspasswd,data=/tmp/some/file/path  -c 'read 66000 128k'
'json:{"server.host": "127.0.0.1", "server.port": "9999", "vdisk-id":
"/test.raw", "driver": "vxhs"}'
1310@1487978547.771234:vxhs_open_vdiskid Opening vdisk-id /test.raw
can't open device json:{"server.host": "127.0.0.1", "server.port":
"9999", "vdisk-id": "/test.raw", "driver": "vxhs"}: please specify the
user for authenticating to target

diff --git a/block/vxhs.c b/block/vxhs.c
index 4f0633e..9b60ddf 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -17,12 +17,16 @@
 #include "qemu/uri.h"
 #include "qapi/error.h"
 #include "qemu/uuid.h"
+#include "crypto/secret.h"

 #define VXHS_OPT_FILENAME           "filename"
 #define VXHS_OPT_VDISK_ID           "vdisk-id"
 #define VXHS_OPT_SERVER             "server"
 #define VXHS_OPT_HOST               "host"
 #define VXHS_OPT_PORT               "port"
+#define VXHS_OPT_USER               "user"
+#define VXHS_OPT_PASSWORD           "password"
+#define VXHS_OPT_SECRETID           "password-secret"
 #define VXHS_UUID_DEF "12345678-1234-1234-1234-123456789012"

 QemuUUID qemu_uuid __attribute__ ((weak));
@@ -136,6 +140,22 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "UUID of the VxHS vdisk",
         },
+        {
+            .name = VXHS_OPT_USER,
+            .type = QEMU_OPT_STRING,
+            .help = "username for authentication to target",
+        },
+        {
+            .name = VXHS_OPT_PASSWORD,
+            .type = QEMU_OPT_STRING,
+            .help = "password for authentication to target",
+        },
+        {
+            .name = VXHS_OPT_SECRETID,
+            .type = QEMU_OPT_STRING,
+            .help = "ID of the secret providing password for"
+                    "authentication to target",
+        },
         { /* end of list */ }
     },
 };
@@ -257,6 +277,9 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
     const char *server_host_opt;
     char *str = NULL;
     int ret = 0;
+    const char *user = NULL;
+    const char *secretid = NULL;
+    const char *password = NULL;

     ret = vxhs_init_and_ref();
     if (ret < 0) {
@@ -320,6 +343,35 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
         goto out;
     }

+    /* check if we got username and secretid via the options */
+    user = qemu_opt_get(opts, VXHS_OPT_USER);
+    if (!user) {
+        error_setg(&local_err, "please specify the user for authenticating to "
+                   "target");
+        qdict_del(backing_options, str);
+        ret = -EINVAL;
+        goto out;
+    }
+
+    secretid = qemu_opt_get(opts, VXHS_OPT_SECRETID);
+    if (!secretid) {
+        error_setg(&local_err, "please specify the ID of the secret to be "
+                   "used for authenticating to target");
+        qdict_del(backing_options, str);
+        ret = -EINVAL;
+        goto out;
+    }
+
+    /* check if we got password via the --object argument */
+    password = qcrypto_secret_lookup_as_utf8(secretid, &local_err);
+    if (local_err != NULL) {
+        trace_vxhs_get_creds(user, secretid, password);
+        qdict_del(backing_options, str);
+        ret = -EINVAL;
+        goto out;
+    }
+    trace_vxhs_get_creds(user, secretid, password);
+
     s->vdisk_hostinfo.host = g_strdup(server_host_opt);

     s->vdisk_hostinfo.port = g_ascii_strtoll(qemu_opt_get(tcp_opts,

Regards,
Ashish


On Fri, Feb 24, 2017 at 1:19 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Thu, Feb 23, 2017 at 08:19:29PM -0800, ashish mittal wrote:
>> Hi,
>>
>> Just want to check if the following mechanism for accepting the secret
>> password looks OK?
>>
>> We have yet to internally discuss the semantics of how we plan to use
>> the user-ID/password for authentication. This diff is just to
>> understand how I am expected to accept the secret from the command
>> line.
>>
>> Example specifying the username and password:
>>
>> $ ./qemu-io --trace enable=vxhs* --object
>> secret,id=ashish,data=asd888d989s  -c 'read 66000 128k'
>> 'json:{"server.host": "127.0.0.1", "server.port": "9999", "vdisk-id":
>> "/test.raw", "driver": "vxhs", "user": "ashish"}'
>> 17396@1487908905.546890:vxhs_open_vdiskid Opening vdisk-id /test.raw
>> 17396@1487908905.546969:vxhs_get_creds SecretID ashish, Password
>> asd888d989s   <==== NOTE!!!!!
>> 17396@1487908905.546994:vxhs_open_hostinfo Adding host 127.0.0.1:9999
>> to BDRVVXHSState
>> 17396@1487908905.568370:vxhs_get_vdisk_stat vDisk /test.raw stat ioctl
>> returned size 196616
>> read 131072/131072 bytes at offset 66000
>> 128 KiB, 1 ops; 0.0017 sec (72.844 MiB/sec and 582.7506 ops/sec)
>> 17396@1487908905.570917:vxhs_close Closing vdisk /test.raw
>> [root@rhel72ga-build-upstream qemu] 2017-02-23 20:01:45$
>>
>> Example where username and password are missing:
>>
>> [root@rhel72ga-build-upstream qemu] 2017-02-23 19:30:16$ ./qemu-io
>> --trace enable=vxhs* -c 'read 66000 128k' 'json:{"server.host":
>> "127.0.0.1", "server.port": "9999", "vdisk-id": "/test.raw", "driver":
>> "vxhs"}'
>> 16120@1487907025.251167:vxhs_open_vdiskid Opening vdisk-id /test.raw
>> 16120@1487907025.251245:vxhs_get_creds SecretID user, Password (null)
>> can't open device json:{"server.host": "127.0.0.1", "server.port":
>> "9999", "vdisk-id": "/test.raw", "driver": "vxhs"}: No secret with id
>> 'user'      <==== NOTE!!!!!
>> [root@rhel72ga-build-upstream qemu] 2017-02-23 19:30:25$
>
> It is close but not quite correct approach. You're overloading a
> single property to provide two different things - the username
> and as a key to lookup the password secret - you want different
> properties.
>
>
> The 'secret' object only needs to be used for data that must be
> kept private. By convention the block drivers try to use a property
> 'password-secret' to reference the ID of the secret object.
>
> So, as an example, if you had a username "fred" and passwd "letmein"
> then a suitable syntax would be
>
>  $ ./qemu-io \
>     --object secret,id=vxhspasswd,data=letmein
>     -c 'read 66000 128k'
>     'json:{"server.host": "127.0.0.1", "server.port": "9999",
>            "vdisk-id": "/test.raw", "driver": "vxhs",
>            "user": "fred", "password-secret": "xvxhspasswd"}'
>
> (obviously in real world, we'd not send across the password
> in clear text in the data= parameter of the secret - we'd
> use the file= parameter instead, but its fine for dev testing.
>
>> diff --git a/block/vxhs.c b/block/vxhs.c
>> index 4f0633e..f3e70ce 100644
>> --- a/block/vxhs.c
>> +++ b/block/vxhs.c
>> @@ -17,6 +17,7 @@
>>  #include "qemu/uri.h"
>>  #include "qapi/error.h"
>>  #include "qemu/uuid.h"
>> +#include "crypto/secret.h"
>>
>>  #define VXHS_OPT_FILENAME           "filename"
>>  #define VXHS_OPT_VDISK_ID           "vdisk-id"
>> @@ -136,6 +137,14 @@ static QemuOptsList runtime_opts = {
>>              .type = QEMU_OPT_STRING,
>>              .help = "UUID of the VxHS vdisk",
>>          },
>> +        {
>> +            .name = "user",
>> +            .type = QEMU_OPT_STRING,
>> +        },
>> +        {
>> +            .name = "password",
>> +            .type = QEMU_OPT_STRING,
>> +        },
>>          { /* end of list */ }
>>      },
>>  };
>> @@ -257,6 +266,8 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
>>      const char *server_host_opt;
>>      char *str = NULL;
>>      int ret = 0;
>> +    const char *user = NULL;
>> +    const char *password = NULL;
>>
>>      ret = vxhs_init_and_ref();
>>      if (ret < 0) {
>> @@ -320,6 +331,23 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
>>          goto out;
>>      }
>>
>> +    /* check if we got username via the options */
>> +    user = qemu_opt_get(opts, "user");
>> +    if (!user) {
>> +        //trace_vxhs_get_creds(user, password);
>> +        user = "user";
>
> We should not default any login credentials - if no username was
> provided we should simply not use any username - if the server
> mandates a username this obviously means connection would fail
> and that's ok.
>
>> +        //return;
>> +    }
>> +
>> +    password = qcrypto_secret_lookup_as_utf8(user, &local_err);
>
> Instead of passing 'user' into this method, you need to call
> qemu_opt_get(opts, "password-secret") and use that result
>
>> +    if (local_err != NULL) {
>> +        trace_vxhs_get_creds(user, password);
>> +        qdict_del(backing_options, str);
>> +        ret = -EINVAL;
>> +        goto out;
>> +    }
>> +    trace_vxhs_get_creds(user, password);
>> +
>
> Regards,
> Daniel
> --
> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
> |: http://libvirt.org              -o-             http://virt-manager.org :|
> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
