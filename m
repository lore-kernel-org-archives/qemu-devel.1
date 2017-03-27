Received: from eggs.gnu.org ([2001:4830:134:3::10]:38801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1csL0I-0005zi-Eq
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 23:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1csL0G-000510-RG
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 23:07:34 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:34488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1csL0G-00050w-Ku
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 23:07:32 -0400
Received: by mail-it0-x244.google.com with SMTP id e75so1785152itd.1
	for <qemu-devel@nongnu.org>; Sun, 26 Mar 2017 20:07:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAAo6VWOEzopqUw_vPuZ39VncvYZXD43oGLQbLPgnAd1c4ayAPw@mail.gmail.com>
References: <CAAo6VWPyQrjSp2qjvxqXRPS8=5N85i0-DJdkWhiGaXmND_8+qA@mail.gmail.com>
	<20170227092207.GA18219@redhat.com>
	<CAAo6VWO6zAijMMjHOkefO22wh+6dXigZ6a+g-pMNBcM0MN1HHw@mail.gmail.com>
	<20170301091851.GD17125@redhat.com>
	<CAAo6VWNRhK6zvc+CferSd9wYQZNNoXDqCEW_G62crqsamyEC9Q@mail.gmail.com>
	<20170306092305.GA9866@redhat.com>
	<CAAo6VWMo-wYwkOAENk4swYk3dkbxaJObXrj85yDRLAUofK2qtw@mail.gmail.com>
	<20170313095723.GC4799@redhat.com>
	<CAAo6VWPd0NrvzxAsYrnRrOhs8+31RYCLFvXG6ak-b3uVZFKxyg@mail.gmail.com>
	<CAAo6VWO7rpDPwP_iFGHNTo3zJqoZZXHAnfPbtkq+FZSSAWAjHw@mail.gmail.com>
	<20170320125528.GM3792@redhat.com>
	<CAAo6VWOEzopqUw_vPuZ39VncvYZXD43oGLQbLPgnAd1c4ayAPw@mail.gmail.com>
From: ashish mittal <ashmit602@gmail.com>
Date: Sun, 26 Mar 2017 20:07:31 -0700
Message-ID: <CAAo6VWMqWguH5mFk2gtJ3r_5UU2ndQpBntVZHdGxQDU2O1qvMA@mail.gmail.com>
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

On Wed, Mar 22, 2017 at 5:03 PM, ashish mittal <ashmit602@gmail.com> wrote:
> On Mon, Mar 20, 2017 at 5:55 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
>> On Fri, Mar 17, 2017 at 06:44:56PM -0700, ashish mittal wrote:
>>> On Thu, Mar 16, 2017 at 5:29 PM, ashish mittal <ashmit602@gmail.com> wrote:
>>> > On Mon, Mar 13, 2017 at 2:57 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
>>> >> On Tue, Mar 07, 2017 at 05:27:55PM -0800, ashish mittal wrote:
>>> >>> Thanks! There is one more input I need some help with!
>>> >>>
>>> >>> VxHS network library opens a fixed number of connection channels to a
>>> >>> given host, and all the vdisks (that connect to the same host) share
>>> >>> these connection channels.
>>> >>>
>>> >>> Therefore, we need to open secure channels to a specific target host
>>> >>> only once for the first vdisk that connects to that host. All the
>>> >>> other vdisks that connect to the same target host will share the same
>>> >>> set of secure communication channels.
>>> >>>
>>> >>> I hope the above scheme is acceptable?
>>> >>>
>>> >>> If yes, then we have a couple of options to implement this:
>>> >>>
>>> >>> (1) Accept the TLS credentials per vdisk using the previously
>>> >>> discussed --object tls-creds-x509 mechanism. In this case, if more
>>> >>> than one vdisk have the same host info, then we will use only the
>>> >>> first one's creds to set up the secure connection, and ignore the
>>> >>> others. vdisks that connect to different target hosts will use their
>>> >>> individual tls-creds-x509 to set up the secure channels. This is, of
>>> >>> course, not relevant for qemu-img/qemu-io as they can open only one
>>> >>> vdisk at a time.
>>> >>
>>> >> It looks like option 1 here is the way to go. Just report an error if
>>> >> there are multiple creds provided for the same host and they don't
>>> >> match.
>>> >>
>>> >
>>> > I have made changes to implement option 1 in the library (branch
>>> > per_channel_ssl).
>>> > Can you please help review it?
>>> > https://github.com/VeritasHyperScale/libqnio/compare/per_channel_ssl
>>> >
>>> > Here's the changelog:
>>> > (1) Changed code to not use instance UUID for setting up SSL context.
>>> > (2) User is supposed to pass the cacert, client_key and client_cert
>>> >     files to iio_open(). These will be used to set up a per-channel secure SSL
>>> >     connection to the server. All three values are needed to set up a
>>> >     secure connection.
>>> > (3) If the secure channel to a particular host is already open, other
>>> >     block device connections to the same host will have to provide
>>> >     TLS/SSL credentials that match the original one.
>>> > (4) Set default locations for trusted client CA certificates
>>> >      based on user specified cacert file.
>>> >
>>> > NB - I have given steps to test SSL communication (using the supplied
>>> > test client/server programs) in the commit log. I have not tested
>>> > using qemu binary yet. Will run more tests in the days to come.
>>> >
>>> > qemu vxhs patch changes should be pretty straightforward, given that
>>> > we have already discussed how to implement passing --object
>>> > tls-creds-x509 per block device.
>>> >
>>> > Thanks!
>>> >
>>>
>>> Update -
>>> (1) Successfully tested SSL communication using qemu-io and the test server.
>>> (2) Minor changes to per_channel_ssl branch.
>>> (3) Created a pull request.
>>>
>>> Please review per convenience. Thanks!
>>
>> IIUC, on that branch the 'is_secure()' method is still looking for the
>> directory /var/lib/libvxhs/secure to exist on the host. If that is not
>> present, then it appears to be silently ignoring the SSL certs passed
>> in from QEMU.
>>
>> IMHO it should enable TLS when 'cacert' passed to iio_open is not NULL,
>> not relying on a magic directory to exist.
>>
>
> I have made changes per above to the library. Please see commits -
>
> https://github.com/VeritasHyperScale/libqnio/commit/6c3261e9c9bb1350f4433a1ae4fcd98f7692cf39
> https://github.com/VeritasHyperScale/libqnio/commit/502c74278457e6ac86a4ee4ad9102e56ff3be5d4
>
> Commit log: Enable secure mode based on the SSL/TLS args passed in iio_open()
>
> (1) Do not use /var/lib/libvxhs/secure to enable secure SSL mode on
>     the client side.
> (2) Instead, enable SSL mode if the user passes TLS/SSL creds for
>     the block device on the qemu CLI.
>
> Will be posting v10 qemu vxhs patch soon. v10 will work with the
> latest library changes, and will support passing tls-creds-x509 creds
> for every vxhs block device.
>

I have posted v10 patches today. I've had to make one change in
addition to what has been discussed. Basically I cannot use
qcrypto_tls_creds_get_path() because its definition is under a #ifdef
CONFIG_GNUTLS. Therefore my builds were failing whenever "gnutls" was
not configured. I've replaced it as below -


diff --git a/block/vxhs.c b/block/vxhs.c
index 0aa7849..44c0ecd 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -19,7 +19,6 @@
 #include "qemu/uuid.h"
 #include "crypto/secret.h"
 #include "crypto/tlscredsx509.h"
-#include "crypto/tlscredspriv.h"

 #define VXHS_OPT_FILENAME           "filename"
 #define VXHS_OPT_VDISK_ID           "vdisk-id"
@@ -288,17 +287,17 @@ static void vxhs_get_tls_creds(const char *id,
char **cacert,
     /*
      * Get the cacert, client_cert and client_key file names.
      */
-    if (qcrypto_tls_creds_get_path(creds, QCRYPTO_TLS_CREDS_X509_CA_CERT,
-                                   true, cacert, errp) < 0 ||
-        qcrypto_tls_creds_get_path(&creds_x509->parent_obj,
-                                   QCRYPTO_TLS_CREDS_X509_CLIENT_CERT,
-                                   false, cert, errp) < 0 ||
-        qcrypto_tls_creds_get_path(&creds_x509->parent_obj,
-                                   QCRYPTO_TLS_CREDS_X509_CLIENT_KEY,
-                                   false, key, errp) < 0) {
-        error_setg(errp,
-                   "Error retrieving information from  TLS object");
+    if (!creds->dir) {
+        error_setg(errp, "TLS object missing 'dir' property value");
+        return;
     }
+
+    *cacert = g_strdup_printf("%s/%s", creds->dir,
+                              QCRYPTO_TLS_CREDS_X509_CA_CERT);
+    *cert = g_strdup_printf("%s/%s", creds->dir,
+                            QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
+    *key = g_strdup_printf("%s/%s", creds->dir,
+                           QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
 }

 static int vxhs_open(BlockDriverState *bs, QDict *options,

Regards,
Ashish

>
>> Regards,
>> Daniel
>> --
>> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
>> |: http://libvirt.org              -o-             http://virt-manager.org :|
>> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
