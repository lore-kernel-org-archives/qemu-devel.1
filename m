Received: from eggs.gnu.org ([2001:4830:134:3::10]:43566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1ckgTb-0001AW-8P
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 19:26:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1ckgTY-0002eV-Sw
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 19:26:11 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:35114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1ckgTY-0002eD-MO
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 19:26:08 -0500
Received: by mail-it0-x244.google.com with SMTP id 203so7975290ith.2
	for <qemu-devel@nongnu.org>; Sun, 05 Mar 2017 16:26:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170301091851.GD17125@redhat.com>
References: <20170221105918.GA22731@stefanha-x1.localdomain>
	<20170221113353.GC17041@redhat.com>
	<20170222140920.GA10201@stefanha-x1.localdomain>
	<20170222142230.GR28937@redhat.com>
	<20170222144407.GS19045@localhost.localdomain>
	<CAAo6VWPWjRTE3t9myt7Q6gTnZcvP72ypTE03PCFfJkvb2UWLTA@mail.gmail.com>
	<20170224091916.GD3702@redhat.com>
	<CAAo6VWPyQrjSp2qjvxqXRPS8=5N85i0-DJdkWhiGaXmND_8+qA@mail.gmail.com>
	<20170227092207.GA18219@redhat.com>
	<CAAo6VWO6zAijMMjHOkefO22wh+6dXigZ6a+g-pMNBcM0MN1HHw@mail.gmail.com>
	<20170301091851.GD17125@redhat.com>
From: ashish mittal <ashmit602@gmail.com>
Date: Sun, 5 Mar 2017 16:26:05 -0800
Message-ID: <CAAo6VWNRhK6zvc+CferSd9wYQZNNoXDqCEW_G62crqsamyEC9Q@mail.gmail.com>
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

On Wed, Mar 1, 2017 at 1:18 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Tue, Feb 28, 2017 at 02:51:39PM -0800, ashish mittal wrote:
>> On Mon, Feb 27, 2017 at 1:22 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
>
>> >> +        ret = -EINVAL;
>> >> +        goto out;
>> >> +    }
>> >> +
>> >> +    secretid = qemu_opt_get(opts, VXHS_OPT_SECRETID);
>> >> +    if (!secretid) {
>> >> +        error_setg(&local_err, "please specify the ID of the secret to be "
>> >> +                   "used for authenticating to target");
>> >> +        qdict_del(backing_options, str);
>> >> +        ret = -EINVAL;
>> >> +        goto out;
>> >> +    }
>> >> +
>> >> +    /* check if we got password via the --object argument */
>> >> +    password = qcrypto_secret_lookup_as_utf8(secretid, &local_err);
>> >> +    if (local_err != NULL) {
>> >> +        trace_vxhs_get_creds(user, secretid, password);
>> >> +        qdict_del(backing_options, str);
>> >> +        ret = -EINVAL;
>> >> +        goto out;
>> >> +    }
>> >> +    trace_vxhs_get_creds(user, secretid, password);
>> >> +
>> >>      s->vdisk_hostinfo.host = g_strdup(server_host_opt);
>> >>
>> >>      s->vdisk_hostinfo.port = g_ascii_strtoll(qemu_opt_get(tcp_opts,
>>
>> The next thing we need consensus on, is to decide exactly what
>> additional information to pass.
>>
>> (1) Current security implementation in VxHS uses the SSL key and
>> certificate files. Do you think we can achieve all the intended
>> security goals if we pass these two files paths (and names?) from the
>> command line?
>
> Yes, that's how other parts of QEMU deal with SSL
>
> NB, QEMU needs to pass 3 paths to libqnoio - the client cert, the
> client key, and the certificate authority certlist
>

I see that the QEMU TLS code internally does expect to find cacert,
and errors out if this is missing. I did have to create one and place
it in the dir path where we are keeping the client key,cert files. The
code diff below requires all the three files.

Here are the files I had to create -
$ ll /etc/pki/qemu/vxhs
total 12
-r--r--r--. 1 root root 2094 Mar  4 18:02 ca-cert.pem
-r--r--r--. 1 root root 1899 Mar  4 18:00 client-cert.pem
-r--r--r--. 1 root root 1679 Mar  4 17:59 client-key.pem

>> (2) If we are OK to continue with the present security scheme (using
>> key and cert), then the only additional change needed might be to
>> accept these files on the command line.
>
> Yep, I think that's the minimum required change to make this mergable.
>
>> (3) If we decide to rely on file permissions and SELinux policy to
>> protect these key/cert files, then we don't need to pass the file
>> names as a secret, instead, passing them as regular qemu_opt_get()
>> options might be enough.
>
> That's correct - you can assume file permissions protect the cert
> files. I would expect the syntax to work as follows
>
>   $QEMU  -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu/vxhs,endpoint=client \
>          -drive  driver=vxhs,...other..opts...,tls-creds=tls0
>
> When you see the 'tls-creds' flag, you can lookup the corresponding
> QCryptoTLSCredsX509 object and extract the 'dir' property from it.
>

The code diff below works as above. Please verify.

> The include/crypto/tlscredsx509.h file has constants defined for the
> standard filenames - eg you would concatenate the directory with
> the constants QCRYPTO_TLS_CREDS_X509_CLIENT_KEY.
>
> This gives the filenames you can then pass to libqnio
>

I am using function qcrypto_tls_creds_get_path() to achieve the same.
Hope this is OK.

> Regards,
> Daniel
> --
> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
> |: http://libvirt.org              -o-             http://virt-manager.org :|
> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|


Example CLI accepting the new TLS credentials:

[amittal2@camshaft qemu] 2017-03-05 15:54:55$ ./qemu-io --trace
enable=vxhs* --object
tls-creds-x509,id=tls0,dir=/etc/pki/qemu/vxhs,endpoint=client -c 'read
66000 128k' 'json:{"server.host": "127.0.0.1", "server.port": "9999",
"vdisk-id": "/test.raw", "driver": "vxhs", "tls-creds":"tls0"}'
15116@1488758101.084355:vxhs_open_vdiskid Opening vdisk-id /test.raw
15116@1488758101.084396:vxhs_get_creds cacert
/etc/pki/qemu/vxhs/ca-cert.pem, client_key
/etc/pki/qemu/vxhs/client-key.pem, client_cert
/etc/pki/qemu/vxhs/client-cert.pem   <===== !!!! NOTE !!!!
15116@1488758101.084402:vxhs_open_hostinfo Adding host 127.0.0.1:9999
to BDRVVXHSState
15116@1488758101.092060:vxhs_get_vdisk_stat vDisk /test.raw stat ioctl
returned size 1048576
read 131072/131072 bytes at offset 66000
128 KiB, 1 ops; 0.0006 sec (188.537 MiB/sec and 1508.2956 ops/sec)
15116@1488758101.094643:vxhs_close Closing vdisk /test.raw
[amittal2@camshaft qemu] 2017-03-05 15:55:01$

NB - I am passing client-key and client-cert to iio_open() here.
libqnio changes to work with these new args via iio_open() will
follow.

diff --git a/block/trace-events b/block/trace-events
index f193079..7758ec3 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -126,3 +126,4 @@ vxhs_open_hostinfo(char *of_vsa_addr, int port)
"Adding host %s:%d to BDRVVXHSSt
 vxhs_open_iio_open(const char *host) "Failed to connect to storage
agent on host %s"
 vxhs_parse_uri_hostinfo(char *host, int port) "Host: IP %s, Port %d"
 vxhs_close(char *vdisk_guid) "Closing vdisk %s"
+vxhs_get_creds(const char *cacert, const char *client_key, const char
*client_cert) "cacert %s, client_key %s, client_cert %s"
diff --git a/block/vxhs.c b/block/vxhs.c
index 4f0633e..3e429e2 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -17,6 +17,9 @@
 #include "qemu/uri.h"
 #include "qapi/error.h"
 #include "qemu/uuid.h"
+#include "crypto/secret.h"
+#include "crypto/tlscredsx509.h"
+#include "crypto/tlscredspriv.h"

 #define VXHS_OPT_FILENAME           "filename"
 #define VXHS_OPT_VDISK_ID           "vdisk-id"
@@ -55,6 +58,7 @@ typedef struct VXHSvDiskHostsInfo {
 typedef struct BDRVVXHSState {
     VXHSvDiskHostsInfo vdisk_hostinfo; /* Per host info */
     char *vdisk_guid;
+    char *tlscredsid; /* tlscredsid */
 } BDRVVXHSState;

 static void vxhs_complete_aio_bh(void *opaque)
@@ -136,6 +140,11 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "UUID of the VxHS vdisk",
         },
+        {
+            .name = "tls-creds",
+            .type = QEMU_OPT_STRING,
+            .help = "ID of the TLS/SSL credentials to use",
+        },
         { /* end of list */ }
     },
 };
@@ -244,6 +253,55 @@ static void vxhs_unref(void)
     }
 }

+static void vxhs_get_tls_creds(const char *id, char **cacert,
+                               char **key, char **cert, Error **errp)
+{
+    Object *obj;
+    QCryptoTLSCreds *creds = NULL;
+    QCryptoTLSCredsX509 *creds_x509 = NULL;
+
+    obj = object_resolve_path_component(
+        object_get_objects_root(), id);
+
+    if (!obj) {
+        error_setg(errp, "No TLS credentials with id '%s'",
+                   id);
+        return;
+    }
+
+    creds_x509 = (QCryptoTLSCredsX509 *)
+        object_dynamic_cast(obj, TYPE_QCRYPTO_TLS_CREDS_X509);
+
+    if (!creds_x509) {
+        error_setg(errp, "Object with id '%s' is not TLS credentials",
+                   id);
+        return;
+    }
+
+    creds = &creds_x509->parent_obj;
+
+    if (creds->endpoint != QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT) {
+        error_setg(errp,
+                   "Expecting TLS credentials with a client endpoint");
+        return;
+    }
+
+    /*
+     * Get the cacert, client_cert and client_key file names.
+     */
+    if (qcrypto_tls_creds_get_path(creds, QCRYPTO_TLS_CREDS_X509_CA_CERT,
+                                   true, cacert, errp) < 0 ||
+        qcrypto_tls_creds_get_path(&creds_x509->parent_obj,
+                                   QCRYPTO_TLS_CREDS_X509_CLIENT_CERT,
+                                   false, cert, errp) < 0 ||
+        qcrypto_tls_creds_get_path(&creds_x509->parent_obj,
+                                   QCRYPTO_TLS_CREDS_X509_CLIENT_KEY,
+                                   false, key, errp) < 0) {
+        error_setg(errp,
+                   "Error retrieving information from  TLS object");
+    }
+}
+
 static int vxhs_open(BlockDriverState *bs, QDict *options,
                      int bdrv_flags, Error **errp)
 {
@@ -257,6 +315,9 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
     const char *server_host_opt;
     char *str = NULL;
     int ret = 0;
+    char *cacert = NULL;
+    char *client_key = NULL;
+    char *client_cert = NULL;

     ret = vxhs_init_and_ref();
     if (ret < 0) {
@@ -297,8 +358,7 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
     qdict_extract_subqdict(options, &backing_options, str);

     qemu_opts_absorb_qdict(tcp_opts, backing_options, &local_err);
-    if (local_err) {
-        qdict_del(backing_options, str);
+    if (local_err != NULL) {
         ret = -EINVAL;
         goto out;
     }
@@ -307,7 +367,6 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
     if (!server_host_opt) {
         error_setg(&local_err, QERR_MISSING_PARAMETER,
                    VXHS_OPT_SERVER"."VXHS_OPT_HOST);
-        qdict_del(backing_options, str);
         ret = -EINVAL;
         goto out;
     }
@@ -315,33 +374,39 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
     if (strlen(server_host_opt) > MAXHOSTNAMELEN) {
         error_setg(&local_err, "server.host cannot be more than %d characters",
                    MAXHOSTNAMELEN);
-        qdict_del(backing_options, str);
         ret = -EINVAL;
         goto out;
     }

-    s->vdisk_hostinfo.host = g_strdup(server_host_opt);
+    /* check if we got tls-creds via the --object argument */
+    s->tlscredsid = g_strdup(qemu_opt_get(opts, "tls-creds"));
+    if (s->tlscredsid) {
+        vxhs_get_tls_creds(s->tlscredsid, &cacert, &client_key,
+                           &client_cert, &local_err);
+        if (local_err != NULL) {
+            ret = -EINVAL;
+            goto out;
+        }
+        trace_vxhs_get_creds(cacert, client_key, client_cert);
+    }

+    s->vdisk_hostinfo.host = g_strdup(server_host_opt);
     s->vdisk_hostinfo.port = g_ascii_strtoll(qemu_opt_get(tcp_opts,
                                                           VXHS_OPT_PORT),
                                                           NULL, 0);

     trace_vxhs_open_hostinfo(s->vdisk_hostinfo.host,
-                         s->vdisk_hostinfo.port);
-
-    /* free the 'server.' entries allocated by previous call to
-     * qdict_extract_subqdict()
-     */
-    qdict_del(backing_options, str);
+                             s->vdisk_hostinfo.port);

     of_vsa_addr = g_strdup_printf("of://%s:%d",
-                                s->vdisk_hostinfo.host,
-                                s->vdisk_hostinfo.port);
+                                  s->vdisk_hostinfo.host,
+                                  s->vdisk_hostinfo.port);

     /*
      * Open qnio channel to storage agent if not opened before.
      */
-    dev_handlep = iio_open(of_vsa_addr, s->vdisk_guid, 0);
+    dev_handlep = iio_open(of_vsa_addr, s->vdisk_guid, 0,
+                           client_key, client_cert);
    <===== !!!! NOTE !!!!
     if (dev_handlep == NULL) {
         trace_vxhs_open_iio_open(of_vsa_addr);
         ret = -ENODEV;
@@ -355,12 +420,16 @@ out:
     QDECREF(backing_options);
     qemu_opts_del(tcp_opts);
     qemu_opts_del(opts);
+    g_free(cacert);
+    g_free(client_key);
+    g_free(client_cert);

     if (ret < 0) {
         vxhs_unref();
         error_propagate(errp, local_err);
         g_free(s->vdisk_hostinfo.host);
         g_free(s->vdisk_guid);
+        g_free(s->tlscredsid);
         s->vdisk_guid = NULL;
         errno = -ret;
     }
@@ -466,9 +535,11 @@ static void vxhs_close(BlockDriverState *bs)
     vxhs_unref();

     /*
-     * Free the dynamically allocated host string
+     * Free the dynamically allocated host string etc
      */
     g_free(s->vdisk_hostinfo.host);
+    g_free(s->tlscredsid);
+    s->tlscredsid = NULL;


Regards,
Ashish
