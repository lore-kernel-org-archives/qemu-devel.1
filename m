Received: from eggs.gnu.org ([2001:4830:134:3::10]:51883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ckorP-0002p8-IW
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:23:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ckorM-0004Hg-BU
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:23:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ckorM-0004Gq-3d
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:23:16 -0500
Date: Mon, 6 Mar 2017 09:23:05 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170306092305.GA9866@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170222140920.GA10201@stefanha-x1.localdomain>
	<20170222142230.GR28937@redhat.com>
	<20170222144407.GS19045@localhost.localdomain>
	<CAAo6VWPWjRTE3t9myt7Q6gTnZcvP72ypTE03PCFfJkvb2UWLTA@mail.gmail.com>
	<20170224091916.GD3702@redhat.com>
	<CAAo6VWPyQrjSp2qjvxqXRPS8=5N85i0-DJdkWhiGaXmND_8+qA@mail.gmail.com>
	<20170227092207.GA18219@redhat.com>
	<CAAo6VWO6zAijMMjHOkefO22wh+6dXigZ6a+g-pMNBcM0MN1HHw@mail.gmail.com>
	<20170301091851.GD17125@redhat.com>
	<CAAo6VWNRhK6zvc+CferSd9wYQZNNoXDqCEW_G62crqsamyEC9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAo6VWNRhK6zvc+CferSd9wYQZNNoXDqCEW_G62crqsamyEC9Q@mail.gmail.com>
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

On Sun, Mar 05, 2017 at 04:26:05PM -0800, ashish mittal wrote:
> On Wed, Mar 1, 2017 at 1:18 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> >
> > Yes, that's how other parts of QEMU deal with SSL
> >
> > NB, QEMU needs to pass 3 paths to libqnoio - the client cert, the
> > client key, and the certificate authority certlist
> >
> 
> I see that the QEMU TLS code internally does expect to find cacert,
> and errors out if this is missing. I did have to create one and place
> it in the dir path where we are keeping the client key,cert files. The
> code diff below requires all the three files.

Yes, the client cert/key have to be paired with the correct CA cert. We cannot
assume that the default CA cert bundle contains the right CA, for use with the
cert/key. The default CA bundle contains all the public commercial CAs, and in
general a QEMU deployment will never use any of those - the site will use a
private internal only CA. While you could add the private CA to the global CA
bundle, that is not desirable from a security POV, as it opens the deployment
to risk from a rogue CA.

> > The include/crypto/tlscredsx509.h file has constants defined for the
> > standard filenames - eg you would concatenate the directory with
> > the constants QCRYPTO_TLS_CREDS_X509_CLIENT_KEY.
> >
> > This gives the filenames you can then pass to libqnio
> >
> 
> I am using function qcrypto_tls_creds_get_path() to achieve the same.
> Hope this is OK.

Yep, that's fine.

> Example CLI accepting the new TLS credentials:
> 
> [amittal2@camshaft qemu] 2017-03-05 15:54:55$ ./qemu-io --trace
> enable=vxhs* --object
> tls-creds-x509,id=tls0,dir=/etc/pki/qemu/vxhs,endpoint=client -c 'read
> 66000 128k' 'json:{"server.host": "127.0.0.1", "server.port": "9999",
> "vdisk-id": "/test.raw", "driver": "vxhs", "tls-creds":"tls0"}'
> 15116@1488758101.084355:vxhs_open_vdiskid Opening vdisk-id /test.raw
> 15116@1488758101.084396:vxhs_get_creds cacert
> /etc/pki/qemu/vxhs/ca-cert.pem, client_key
> /etc/pki/qemu/vxhs/client-key.pem, client_cert
> /etc/pki/qemu/vxhs/client-cert.pem   <===== !!!! NOTE !!!!
> 15116@1488758101.084402:vxhs_open_hostinfo Adding host 127.0.0.1:9999
> to BDRVVXHSState
> 15116@1488758101.092060:vxhs_get_vdisk_stat vDisk /test.raw stat ioctl
> returned size 1048576
> read 131072/131072 bytes at offset 66000
> 128 KiB, 1 ops; 0.0006 sec (188.537 MiB/sec and 1508.2956 ops/sec)
> 15116@1488758101.094643:vxhs_close Closing vdisk /test.raw
> [amittal2@camshaft qemu] 2017-03-05 15:55:01$

That looks ok.

> @@ -315,33 +374,39 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
>      if (strlen(server_host_opt) > MAXHOSTNAMELEN) {
>          error_setg(&local_err, "server.host cannot be more than %d characters",
>                     MAXHOSTNAMELEN);
> -        qdict_del(backing_options, str);
>          ret = -EINVAL;
>          goto out;
>      }
> 
> -    s->vdisk_hostinfo.host = g_strdup(server_host_opt);
> +    /* check if we got tls-creds via the --object argument */
> +    s->tlscredsid = g_strdup(qemu_opt_get(opts, "tls-creds"));
> +    if (s->tlscredsid) {
> +        vxhs_get_tls_creds(s->tlscredsid, &cacert, &client_key,
> +                           &client_cert, &local_err);
> +        if (local_err != NULL) {
> +            ret = -EINVAL;
> +            goto out;
> +        }
> +        trace_vxhs_get_creds(cacert, client_key, client_cert);
> +    }
> 
> +    s->vdisk_hostinfo.host = g_strdup(server_host_opt);
>      s->vdisk_hostinfo.port = g_ascii_strtoll(qemu_opt_get(tcp_opts,
>                                                            VXHS_OPT_PORT),
>                                                            NULL, 0);
> 
>      trace_vxhs_open_hostinfo(s->vdisk_hostinfo.host,
> -                         s->vdisk_hostinfo.port);
> -
> -    /* free the 'server.' entries allocated by previous call to
> -     * qdict_extract_subqdict()
> -     */
> -    qdict_del(backing_options, str);
> +                             s->vdisk_hostinfo.port);
> 
>      of_vsa_addr = g_strdup_printf("of://%s:%d",
> -                                s->vdisk_hostinfo.host,
> -                                s->vdisk_hostinfo.port);
> +                                  s->vdisk_hostinfo.host,
> +                                  s->vdisk_hostinfo.port);
> 
>      /*
>       * Open qnio channel to storage agent if not opened before.
>       */
> -    dev_handlep = iio_open(of_vsa_addr, s->vdisk_guid, 0);
> +    dev_handlep = iio_open(of_vsa_addr, s->vdisk_guid, 0,
> +                           client_key, client_cert);

You need to pass  ca_cert into this method too.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
