Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCB0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25BE2076C
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHbOP4em"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25BE2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Uui-0008PL-Or
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 10:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5UtK-0007gi-D8
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:04:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27076
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5UtH-0008Oc-Jk
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597154674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=373tXi6BgM2eT+WfXFomKbGoYckt44JdH9aYg+3AQw8=;
 b=PHbOP4emyHVqCzD97NHAhzJT4/6WMzWOx73X+OK67hzgq1NoYFeL+qMunZ/W8SSSOBQtL7
 gzL55ZO397HJ1DtX3FFbJOqpE4ITDZYkZ9wAomg6MnKdqZ2Xi8iWZPKLPVGUF/uoDBxCWE
 OFTjPUbC82fZ7yOvKu/oSVbMjyjENK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-kNX2jZg-NH2zJr-vG4uEGA-1; Tue, 11 Aug 2020 10:04:31 -0400
X-MC-Unique: kNX2jZg-NH2zJr-vG4uEGA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7312102C803;
 Tue, 11 Aug 2020 14:04:24 +0000 (UTC)
Received: from localhost (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23DB865C6E;
 Tue, 11 Aug 2020 14:04:23 +0000 (UTC)
Date: Tue, 11 Aug 2020 15:04:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v8 13/20] multi-process: PCI BAR read/write handling for
 proxy & remote endpoints
Message-ID: <20200811140423.GB18223@stefanha-x1.localdomain>
References: <cover.1596217462.git.jag.raman@oracle.com>
 <3588624b278c97cb3c9d1eeda109ad36af39effc.1596217462.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <3588624b278c97cb3c9d1eeda109ad36af39effc.1596217462.git.jag.raman@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 06:40:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 31, 2020 at 02:20:20PM -0400, Jagannathan Raman wrote:
> +static void process_bar_write(QIOChannel *ioc, MPQemuMsg *msg, Error **errp)
> +{
> +    BarAccessMsg *bar_access = &msg->data1.bar_access;
> +    AddressSpace *as =
> +        bar_access->memory ? &address_space_memory : &address_space_io;
> +    MPQemuMsg ret = { 0 };
> +    MemTxResult res;
> +    uint64_t val;
> +    Error *local_err = NULL;
> +
> +    if (!is_power_of_2(bar_access->size) ||
> +       (bar_access->size > sizeof(uint64_t))) {
> +        ret.data1.u64 = UINT64_MAX;
> +        goto fail;
> +    }
> +
> +    val = cpu_to_le64(bar_access->val);
> +
> +    res = address_space_rw(as, bar_access->addr, MEMTXATTRS_UNSPECIFIED,
> +                           (void *)&val, bar_access->size, true);
> +
> +    if (res != MEMTX_OK) {
> +        error_setg(errp, "Could not perform address space write operation,"
> +                   " inaccessible address: %lx in pid %d.",
> +                   bar_access->addr, getpid());
> +        ret.data1.u64 = -1;
> +    }
> +
> +fail:
> +    ret.cmd = RET_MSG;
> +    ret.size = sizeof(ret.data1);
> +
> +    mpqemu_msg_send(&ret, ioc, &local_err);
> +    if (local_err) {
> +        error_setg(errp, "Error while sending message to proxy "
> +                   "in remote process pid=%d", getpid());

There is an assertion failure if res != MEMTX_OK because errp was
already set. error_setg() must not be called on an Error pointer that
has already been set.

It is simplest to do:

  mpqemu_msg_send(&ret, ioc, (errp && *errp) ? NULL : &local_err);

> +    }
> +}
> +
> +static void process_bar_read(QIOChannel *ioc, MPQemuMsg *msg, Error **errp)
> +{
> +    BarAccessMsg *bar_access = &msg->data1.bar_access;
> +    MPQemuMsg ret = { 0 };
> +    AddressSpace *as;
> +    MemTxResult res;
> +    uint64_t val = 0;
> +    Error *local_err = NULL;
> +
> +    as = bar_access->memory ? &address_space_memory : &address_space_io;
> +
> +    if (!is_power_of_2(bar_access->size) ||
> +       (bar_access->size > sizeof(uint64_t))) {
> +        val = UINT64_MAX;
> +        goto fail;
> +    }
> +
> +    res = address_space_rw(as, bar_access->addr, MEMTXATTRS_UNSPECIFIED,
> +                           (void *)&val, bar_access->size, false);
> +
> +    if (res != MEMTX_OK) {
> +        error_setg(errp, "Could not perform address space read operation,"
> +                   " inaccessible address: %lx in pid %d.",
> +                   bar_access->addr, getpid());
> +        val = UINT64_MAX;
> +        goto fail;
> +    }
> +
> +fail:
> +    ret.cmd = RET_MSG;
> +    ret.data1.u64 = le64_to_cpu(val);
> +    ret.size = sizeof(ret.data1);
> +
> +    mpqemu_msg_send(&ret, ioc, &local_err);
> +    if (local_err) {
> +        error_setg(errp, "Error while sending message to proxy "

Same here.

> +static void send_bar_access_msg(PCIProxyDev *pdev, MemoryRegion *mr,
> +                                bool write, hwaddr addr, uint64_t *val,
> +                                unsigned size, bool memory)
> +{
> +    MPQemuMsg msg = { 0 };
> +    long ret = -EINVAL;

long is not guaranteed to be 64-bit. This function supports 64-bit
accesses to BARs so uint64_t is needed here.

> +    Error *local_err = NULL;
> +
> +    msg.bytestream = 0;
> +    msg.size = sizeof(msg.data1);
> +    msg.data1.bar_access.addr = mr->addr + addr;
> +    msg.data1.bar_access.size = size;
> +    msg.data1.bar_access.memory = memory;
> +
> +    if (write) {
> +        msg.cmd = BAR_WRITE;
> +        msg.data1.bar_access.val = *val;
> +    } else {
> +        msg.cmd = BAR_READ;
> +    }
> +
> +    ret = mpqemu_msg_send_and_await_reply(&msg, pdev->ioc, &local_err);
> +    if (local_err) {
> +        error_report("Failed to send BAR command to the remote process.");

Leaks local_err. Please report the error message from local_err and then
free it.

> +const MemoryRegionOps proxy_mr_ops = {
> +    .read = proxy_bar_read,
> +    .write = proxy_bar_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 1,

Should this be .max_access_size = 8?

> diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
> index 5d04b81..82b8465 100644
> --- a/io/mpqemu-link.c
> +++ b/io/mpqemu-link.c
> @@ -269,6 +269,12 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
>              return false;
>          }
>          break;
> +    case BAR_WRITE:
> +    case BAR_READ:
> +        if ((msg->size != sizeof(msg->data1)) || (msg->num_fds != 0)) {

What about bytestream? It would be cleanest not to send bytestream over
the wire. Since it is sent today the receiver can be confused if it has
the wrong value and some mpqemu_msg_valid() cases validate bytestream.
It is not validate here for some reason.

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8ypWYACgkQnKSrs4Gr
c8jPiAgAsHhx7soBe6DpVXNGl4Se9K2+pjKcCF4RMcoIT6xKUMRDn7LMlWopW2wF
91a5M7khO+Q+VdNZMydc927cjB/hbveO0XbJjf+CEOLhXOWj2RORKVTatm87F81w
8Hex486RCVERrF5BeGNjKTiPIPKEt9hJOUD7231dbns6sYnde3qEC1SpXBccCBh7
tUA/0q29sTKMoVRwCS+cYMUDMnmF94XauhjNRym8uJdiw53n+N2OEVasQd32A6Ss
fWCURPVbT1aoW1joDoROk2u/oDpVadgcavGAMByrrDgCVzBXYYju4FkB/34/zXGq
iD9AxcAf26LVr9wsYF+nRBK/vsJp5g==
=YcVy
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--


