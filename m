Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0370BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:54:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C675720663
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBdQ8FIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C675720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqIau-0006HJ-2k
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqIZc-0003Yn-KS
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:53:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31124
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqIZa-0006a4-RQ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593532406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BoZjZl1efbg68on61JAxXlx7C+HWblxiHixB9xMGOss=;
 b=KBdQ8FIJRd9HNMQayW+jOGjidX96sEoL00ur6Th/D9FMD6ShzvxG0C+lrPtqERitLYECek
 KvoysfIJ76by7FgecCP2LkWcho/N85CFJal6L6TADcT6oIjQr4Tuc2NKCxLlsMSNR1qGH2
 5F303ajSEfN+iIaLqFUnYkVjpXiURkk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-R8NMHr8WNLmfhlo96PrO1Q-1; Tue, 30 Jun 2020 11:53:21 -0400
X-MC-Unique: R8NMHr8WNLmfhlo96PrO1Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E4A9EC1B7;
 Tue, 30 Jun 2020 15:53:19 +0000 (UTC)
Received: from localhost (ovpn-115-106.ams2.redhat.com [10.36.115.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53F915C1B0;
 Tue, 30 Jun 2020 15:53:10 +0000 (UTC)
Date: Tue, 30 Jun 2020 16:53:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v7 06/21] multi-process: define MPQemuMsg format and
 transmission functions
Message-ID: <20200630155308.GF109906@stefanha-x1.localdomain>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <f3e8c0b53e9ee337f2551f7326562cba1fffb908.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <f3e8c0b53e9ee337f2551f7326562cba1fffb908.1593273671.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WlEyl6ow+jlIgNUh"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--WlEyl6ow+jlIgNUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 27, 2020 at 10:09:28AM -0700, elena.ufimtseva@oracle.com wrote:
> +void mpqemu_msg_send(MPQemuMsg *msg, QIOChannel *ioc)
> +{
> +    Error *local_err = NULL;
> +    struct iovec send[2];
> +    int *fds = NULL;
> +    size_t nfds = 0;
> +
> +    send[0].iov_base = msg;
> +    send[0].iov_len = MPQEMU_MSG_HDR_SIZE;
> +
> +    send[1].iov_base = msg->bytestream ? msg->data2 : (void *)&msg->data1;
> +    send[1].iov_len = msg->size;
> +
> +    if (msg->num_fds) {
> +        nfds = msg->num_fds;
> +        fds = msg->fds;
> +    }
> +
> +    (void)qio_channel_writev_full_all(ioc, send, G_N_ELEMENTS(send), fds, nfds,
> +                                      &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +    }

Error propagation is missing. Is this by design, i.e. errors only need
to be handled in the read path, or is the patch incomplete?

> +}
> +
> +static int mpqemu_readv(QIOChannel *ioc, struct iovec *iov, int **fds,
> +                        size_t *nfds, Error **errp)
> +{
> +    size_t size, len;
> +
> +    size = iov->iov_len;
> +
> +    while (size > 0) {
> +        len = qio_channel_readv_full(ioc, iov, 1, fds, nfds, errp);

iovec buffers are overwritten when this loop iterates because iov is
not updated after reading some data.

fds is leaked when this loop iterates multiple times and there are fds
each time. fds/nfds should probably be set to 0 after the first
iteration.

> +
> +        if (len == QIO_CHANNEL_ERR_BLOCK) {
> +            if (qemu_in_coroutine()) {
> +                qio_channel_yield(ioc, G_IO_IN);
> +            } else {
> +                qio_channel_wait(ioc, G_IO_IN);
> +            }
> +            continue;
> +        }
> +
> +        if (len <= 0) {
> +            return -EIO;
> +        }
> +
> +        size -= len;
> +    }
> +
> +    return iov->iov_len;
> +}
> +
> +int mpqemu_msg_recv(MPQemuMsg *msg, QIOChannel *ioc)
> +{
> +    Error *local_err = NULL;
> +    int *fds = NULL;
> +    struct iovec hdr, data;
> +    size_t nfds = 0;
> +
> +    hdr.iov_base = g_malloc0(MPQEMU_MSG_HDR_SIZE);
> +    hdr.iov_len = MPQEMU_MSG_HDR_SIZE;
> +
> +    if (mpqemu_readv(ioc, &hdr, &fds, &nfds, &local_err) < 0) {
> +        return -EIO;

hdr.iov_base is leaked.

Why is hdr.iov_base allocated on the heap? Can you read directly into
msg instead of using an extra variable?

> +    }
> +
> +    memcpy(msg, hdr.iov_base, hdr.iov_len);
> +
> +    free(hdr.iov_base);
> +    if (msg->size > MPQEMU_MSG_DATA_MAX) {
> +        error_report("The message size is more than MPQEMU_MSG_DATA_MAX %d",
> +                     MPQEMU_MSG_DATA_MAX);
> +        return -EINVAL;
> +    }
> +
> +    data.iov_base = g_malloc0(msg->size);
> +    data.iov_len = msg->size;
> +
> +    if (mpqemu_readv(ioc, &data, NULL, NULL, &local_err) < 0) {
> +        return -EIO;

data.iov_base is leaked.

> +    }
> +
> +    if (msg->bytestream) {
> +        msg->data2 = calloc(1, msg->size);

QEMU uses glib memory allocation functions when possible. Please use
g_malloc0().

The calloc() and memcpy() can be avoided like this:

  msg->data2 = data.iov_base;
  data.iov_base = NULL; /* the pointer has been moved, don't free it */

> +        memcpy(msg->data2, data.iov_base, msg->size);
> +    } else {
> +        memcpy((void *)&msg->data1, data.iov_base, msg->size);

Buffer overflow when msg->size > sizeof(msg->data1). There should be a
check:

  if (msg->bytestream) {
      ...
  } else {
      if (msg->size > sizeof(msg->data1)) {
          ...handle invalid size...
	  return -EIO;
      }
      memcpy(&msg->data1, data.iov_base, msg->size);
  }

> +    }
> +
> +    free(data.iov_base);

Should be g_free() since the allocation was made with g_malloc0().

> +
> +    if (nfds) {
> +        msg->num_fds = nfds;
> +        memcpy(msg->fds, fds, nfds * sizeof(int));
> +    }

It's safer to move the msg->num_fds = nfds outside the if statement so
that it always happens. That way num_fds is set to 0 and we don't depend
on the caller initializing it to 0.

--WlEyl6ow+jlIgNUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl77X+QACgkQnKSrs4Gr
c8iuyQgAxc2b30cPLf/CLDHwZ68E4dW0gtGQeHplJkguNVJlBithL+Ib5SkC23aR
S+CkqW636ieSnUdZQ8lNUJ3oODWyJD+P0Rsd0phof1bxRModZie5nWjd4CF2r2Uc
gWBTTY5a5h8MHQm9uncoqQaP1fhMEqOQG8LVb30sjYT84nQW6kQoSYcxpCQ65XxB
RTJ4VM7kEkB0fjha21+tJKOPwiZXBH6VoatNdsXRkEgiC5fv1+30vNHf+C59nj0Z
Kc0Zdf8pvkdLUFS/3AWuCqWEfymv62fFqQDTUmR9/HXlVzNAxituzf1lXh0OVX60
vffNHWhzZLCrlmWIUOKa/IejGLcwTg==
=ushO
-----END PGP SIGNATURE-----

--WlEyl6ow+jlIgNUh--


