Received: from eggs.gnu.org ([2001:4830:134:3::10]:54299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1clQOX-0001QW-6J
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 20:28:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1clQOV-0001M0-NP
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 20:28:01 -0500
Received: from mail-it0-x22f.google.com ([2607:f8b0:4001:c0b::22f]:35315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1clQOV-0001Lu-GZ
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 20:27:59 -0500
Received: by mail-it0-x22f.google.com with SMTP id m27so25638405iti.0
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 17:27:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170306092305.GA9866@redhat.com>
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
	<20170306092305.GA9866@redhat.com>
From: ashish mittal <ashmit602@gmail.com>
Date: Tue, 7 Mar 2017 17:27:55 -0800
Message-ID: <CAAo6VWMo-wYwkOAENk4swYk3dkbxaJObXrj85yDRLAUofK2qtw@mail.gmail.com>
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

Thanks! There is one more input I need some help with!

VxHS network library opens a fixed number of connection channels to a
given host, and all the vdisks (that connect to the same host) share
these connection channels.

Therefore, we need to open secure channels to a specific target host
only once for the first vdisk that connects to that host. All the
other vdisks that connect to the same target host will share the same
set of secure communication channels.

I hope the above scheme is acceptable?

If yes, then we have a couple of options to implement this:

(1) Accept the TLS credentials per vdisk using the previously
discussed --object tls-creds-x509 mechanism. In this case, if more
than one vdisk have the same host info, then we will use only the
first one's creds to set up the secure connection, and ignore the
others. vdisks that connect to different target hosts will use their
individual tls-creds-x509 to set up the secure channels. This is, of
course, not relevant for qemu-img/qemu-io as they can open only one
vdisk at a time.

(2) Instead of having a per-vdisk --object tls-creds-x509, have a
single such argument on the command line for vxhs block device code to
consume - if that is possible! One way to achieve this could be the
user/password authentication we discussed earlier, which we could use
to pass the directory where cert/keys are kept.

(3) Use the instance UUID, when available, to lookup the cert files
per instance (i.e. for qemu-kvm), and use the --object tls-creds-x509
mechanism, when instance UUID is NULL (i.e. qemu-io, qemu-img etc).
The cert/key files are anyway protected by file permissions in either
case, so I guess there is no additional security provided by either
method.

Regards,
Ashish

On Mon, Mar 6, 2017 at 1:23 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Sun, Mar 05, 2017 at 04:26:05PM -0800, ashish mittal wrote:
>> On Wed, Mar 1, 2017 at 1:18 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
>> >
>> > Yes, that's how other parts of QEMU deal with SSL
>> >
>> > NB, QEMU needs to pass 3 paths to libqnoio - the client cert, the
>> > client key, and the certificate authority certlist
>> >
>>
>> I see that the QEMU TLS code internally does expect to find cacert,
>> and errors out if this is missing. I did have to create one and place
>> it in the dir path where we are keeping the client key,cert files. The
>> code diff below requires all the three files.
>
> Yes, the client cert/key have to be paired with the correct CA cert. We cannot
> assume that the default CA cert bundle contains the right CA, for use with the
> cert/key. The default CA bundle contains all the public commercial CAs, and in
> general a QEMU deployment will never use any of those - the site will use a
> private internal only CA. While you could add the private CA to the global CA
> bundle, that is not desirable from a security POV, as it opens the deployment
> to risk from a rogue CA.
>
>> > The include/crypto/tlscredsx509.h file has constants defined for the
>> > standard filenames - eg you would concatenate the directory with
>> > the constants QCRYPTO_TLS_CREDS_X509_CLIENT_KEY.
>> >
>> > This gives the filenames you can then pass to libqnio
>> >
>>
>> I am using function qcrypto_tls_creds_get_path() to achieve the same.
>> Hope this is OK.
>
> Yep, that's fine.
>
>> Example CLI accepting the new TLS credentials:
>>
>> [amittal2@camshaft qemu] 2017-03-05 15:54:55$ ./qemu-io --trace
>> enable=vxhs* --object
>> tls-creds-x509,id=tls0,dir=/etc/pki/qemu/vxhs,endpoint=client -c 'read
>> 66000 128k' 'json:{"server.host": "127.0.0.1", "server.port": "9999",
>> "vdisk-id": "/test.raw", "driver": "vxhs", "tls-creds":"tls0"}'
>> 15116@1488758101.084355:vxhs_open_vdiskid Opening vdisk-id /test.raw
>> 15116@1488758101.084396:vxhs_get_creds cacert
>> /etc/pki/qemu/vxhs/ca-cert.pem, client_key
>> /etc/pki/qemu/vxhs/client-key.pem, client_cert
>> /etc/pki/qemu/vxhs/client-cert.pem   <===== !!!! NOTE !!!!
>> 15116@1488758101.084402:vxhs_open_hostinfo Adding host 127.0.0.1:9999
>> to BDRVVXHSState
>> 15116@1488758101.092060:vxhs_get_vdisk_stat vDisk /test.raw stat ioctl
>> returned size 1048576
>> read 131072/131072 bytes at offset 66000
>> 128 KiB, 1 ops; 0.0006 sec (188.537 MiB/sec and 1508.2956 ops/sec)
>> 15116@1488758101.094643:vxhs_close Closing vdisk /test.raw
>> [amittal2@camshaft qemu] 2017-03-05 15:55:01$
>
> That looks ok.
>
>> @@ -315,33 +374,39 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
>>      if (strlen(server_host_opt) > MAXHOSTNAMELEN) {
>>          error_setg(&local_err, "server.host cannot be more than %d characters",
>>                     MAXHOSTNAMELEN);
>> -        qdict_del(backing_options, str);
>>          ret = -EINVAL;
>>          goto out;
>>      }
>>
>> -    s->vdisk_hostinfo.host = g_strdup(server_host_opt);
>> +    /* check if we got tls-creds via the --object argument */
>> +    s->tlscredsid = g_strdup(qemu_opt_get(opts, "tls-creds"));
>> +    if (s->tlscredsid) {
>> +        vxhs_get_tls_creds(s->tlscredsid, &cacert, &client_key,
>> +                           &client_cert, &local_err);
>> +        if (local_err != NULL) {
>> +            ret = -EINVAL;
>> +            goto out;
>> +        }
>> +        trace_vxhs_get_creds(cacert, client_key, client_cert);
>> +    }
>>
>> +    s->vdisk_hostinfo.host = g_strdup(server_host_opt);
>>      s->vdisk_hostinfo.port = g_ascii_strtoll(qemu_opt_get(tcp_opts,
>>                                                            VXHS_OPT_PORT),
>>                                                            NULL, 0);
>>
>>      trace_vxhs_open_hostinfo(s->vdisk_hostinfo.host,
>> -                         s->vdisk_hostinfo.port);
>> -
>> -    /* free the 'server.' entries allocated by previous call to
>> -     * qdict_extract_subqdict()
>> -     */
>> -    qdict_del(backing_options, str);
>> +                             s->vdisk_hostinfo.port);
>>
>>      of_vsa_addr = g_strdup_printf("of://%s:%d",
>> -                                s->vdisk_hostinfo.host,
>> -                                s->vdisk_hostinfo.port);
>> +                                  s->vdisk_hostinfo.host,
>> +                                  s->vdisk_hostinfo.port);
>>
>>      /*
>>       * Open qnio channel to storage agent if not opened before.
>>       */
>> -    dev_handlep = iio_open(of_vsa_addr, s->vdisk_guid, 0);
>> +    dev_handlep = iio_open(of_vsa_addr, s->vdisk_guid, 0,
>> +                           client_key, client_cert);
>
> You need to pass  ca_cert into this method too.
>
>
> Regards,
> Daniel
> --
> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
> |: http://libvirt.org              -o-             http://virt-manager.org :|
> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
