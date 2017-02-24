Received: from eggs.gnu.org ([2001:4830:134:3::10]:48077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1chC2K-0008DD-03
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:19:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1chC2G-0003ZG-5R
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:19:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1chC2F-0003Z7-T5
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:19:32 -0500
Date: Fri, 24 Feb 2017 09:19:16 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170224091916.GD3702@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAo6VWPWjRTE3t9myt7Q6gTnZcvP72ypTE03PCFfJkvb2UWLTA@mail.gmail.com>
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
To: ashish mittal <ashmit602@gmail.com>
Cc: Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

On Thu, Feb 23, 2017 at 08:19:29PM -0800, ashish mittal wrote:
> Hi,
> 
> Just want to check if the following mechanism for accepting the secret
> password looks OK?
> 
> We have yet to internally discuss the semantics of how we plan to use
> the user-ID/password for authentication. This diff is just to
> understand how I am expected to accept the secret from the command
> line.
> 
> Example specifying the username and password:
> 
> $ ./qemu-io --trace enable=vxhs* --object
> secret,id=ashish,data=asd888d989s  -c 'read 66000 128k'
> 'json:{"server.host": "127.0.0.1", "server.port": "9999", "vdisk-id":
> "/test.raw", "driver": "vxhs", "user": "ashish"}'
> 17396@1487908905.546890:vxhs_open_vdiskid Opening vdisk-id /test.raw
> 17396@1487908905.546969:vxhs_get_creds SecretID ashish, Password
> asd888d989s   <==== NOTE!!!!!
> 17396@1487908905.546994:vxhs_open_hostinfo Adding host 127.0.0.1:9999
> to BDRVVXHSState
> 17396@1487908905.568370:vxhs_get_vdisk_stat vDisk /test.raw stat ioctl
> returned size 196616
> read 131072/131072 bytes at offset 66000
> 128 KiB, 1 ops; 0.0017 sec (72.844 MiB/sec and 582.7506 ops/sec)
> 17396@1487908905.570917:vxhs_close Closing vdisk /test.raw
> [root@rhel72ga-build-upstream qemu] 2017-02-23 20:01:45$
> 
> Example where username and password are missing:
> 
> [root@rhel72ga-build-upstream qemu] 2017-02-23 19:30:16$ ./qemu-io
> --trace enable=vxhs* -c 'read 66000 128k' 'json:{"server.host":
> "127.0.0.1", "server.port": "9999", "vdisk-id": "/test.raw", "driver":
> "vxhs"}'
> 16120@1487907025.251167:vxhs_open_vdiskid Opening vdisk-id /test.raw
> 16120@1487907025.251245:vxhs_get_creds SecretID user, Password (null)
> can't open device json:{"server.host": "127.0.0.1", "server.port":
> "9999", "vdisk-id": "/test.raw", "driver": "vxhs"}: No secret with id
> 'user'      <==== NOTE!!!!!
> [root@rhel72ga-build-upstream qemu] 2017-02-23 19:30:25$

It is close but not quite correct approach. You're overloading a
single property to provide two different things - the username
and as a key to lookup the password secret - you want different
properties.


The 'secret' object only needs to be used for data that must be
kept private. By convention the block drivers try to use a property
'password-secret' to reference the ID of the secret object.

So, as an example, if you had a username "fred" and passwd "letmein"
then a suitable syntax would be

 $ ./qemu-io \
    --object secret,id=vxhspasswd,data=letmein
    -c 'read 66000 128k'
    'json:{"server.host": "127.0.0.1", "server.port": "9999",
           "vdisk-id": "/test.raw", "driver": "vxhs",
           "user": "fred", "password-secret": "xvxhspasswd"}'

(obviously in real world, we'd not send across the password
in clear text in the data= parameter of the secret - we'd
use the file= parameter instead, but its fine for dev testing.

> diff --git a/block/vxhs.c b/block/vxhs.c
> index 4f0633e..f3e70ce 100644
> --- a/block/vxhs.c
> +++ b/block/vxhs.c
> @@ -17,6 +17,7 @@
>  #include "qemu/uri.h"
>  #include "qapi/error.h"
>  #include "qemu/uuid.h"
> +#include "crypto/secret.h"
> 
>  #define VXHS_OPT_FILENAME           "filename"
>  #define VXHS_OPT_VDISK_ID           "vdisk-id"
> @@ -136,6 +137,14 @@ static QemuOptsList runtime_opts = {
>              .type = QEMU_OPT_STRING,
>              .help = "UUID of the VxHS vdisk",
>          },
> +        {
> +            .name = "user",
> +            .type = QEMU_OPT_STRING,
> +        },
> +        {
> +            .name = "password",
> +            .type = QEMU_OPT_STRING,
> +        },
>          { /* end of list */ }
>      },
>  };
> @@ -257,6 +266,8 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
>      const char *server_host_opt;
>      char *str = NULL;
>      int ret = 0;
> +    const char *user = NULL;
> +    const char *password = NULL;
> 
>      ret = vxhs_init_and_ref();
>      if (ret < 0) {
> @@ -320,6 +331,23 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
>          goto out;
>      }
> 
> +    /* check if we got username via the options */
> +    user = qemu_opt_get(opts, "user");
> +    if (!user) {
> +        //trace_vxhs_get_creds(user, password);
> +        user = "user";

We should not default any login credentials - if no username was
provided we should simply not use any username - if the server
mandates a username this obviously means connection would fail
and that's ok.

> +        //return;
> +    }
> +
> +    password = qcrypto_secret_lookup_as_utf8(user, &local_err);

Instead of passing 'user' into this method, you need to call
qemu_opt_get(opts, "password-secret") and use that result

> +    if (local_err != NULL) {
> +        trace_vxhs_get_creds(user, password);
> +        qdict_del(backing_options, str);
> +        ret = -EINVAL;
> +        goto out;
> +    }
> +    trace_vxhs_get_creds(user, password);
> +

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
