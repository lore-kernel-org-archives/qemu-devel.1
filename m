Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF807C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 12:50:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 950982075A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 12:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwddJSJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950982075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2wP3-00032Z-Qw
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 08:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2wOQ-0002Ss-PT
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 08:50:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23669
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2wOO-0000cF-GT
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 08:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596545407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RE1Vx0m7B9gews2LJrlNt0Qxlu7aJ7TNn1gz806bm9U=;
 b=LwddJSJ3CgqExCNuIu/yyv1NGcmRQ4Ujr1jRR5g7i/n4LDgX0FEQbmlw52hXKBxKGZYBys
 zXgD4/LVDrupNtU7xEoQu618Mn0J5wme5ctP5TKQOufOANEiVJ07P88Q4ZcODJtzgdpq56
 YDpE6ZBfU6g4BRUnQHlXeU5Tx8sUFRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-6ncL7L-0PgOYW-gScmhUCg-1; Tue, 04 Aug 2020 08:50:03 -0400
X-MC-Unique: 6ncL7L-0PgOYW-gScmhUCg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEDB6107BEF7;
 Tue,  4 Aug 2020 12:50:01 +0000 (UTC)
Received: from localhost (ovpn-112-116.ams2.redhat.com [10.36.112.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FE857B904;
 Tue,  4 Aug 2020 12:49:50 +0000 (UTC)
Date: Tue, 4 Aug 2020 13:49:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v8 06/20] multi-process: define MPQemuMsg format and
 transmission functions
Message-ID: <20200804124949.GB1284674@stefanha-x1.localdomain>
References: <cover.1596217462.git.jag.raman@oracle.com>
 <50f84ecac23889920aeed397adb9317b8ea5a54b.1596217462.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <50f84ecac23889920aeed397adb9317b8ea5a54b.1596217462.git.jag.raman@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:01:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 31, 2020 at 02:20:13PM -0400, Jagannathan Raman wrote:
> +static int mpqemu_readv(QIOChannel *ioc, struct iovec *iov, int **fds,
> +                        size_t *nfds, Error **errp)

readv(2) and similar functions take an int iovcnt argument while
mpqemu_readv() takes just a single struct iovec. The name mpqemu_read()
seems more appopriate and iov argument could be replaced by void *buf,
size_t len. That is cleaner because this function modifies the iov
argument (callers need to be be careful!).

> +{
> +    struct iovec *l_iov = iov;
> +    size_t *l_nfds = nfds;
> +    unsigned int niov = 1;
> +    int **l_fds = fds;
> +    size_t size, len;
> +    Error *local_err = NULL;
> +
> +    size = iov->iov_len;
> +
> +    while (size > 0) {
> +        len = qio_channel_readv_full(ioc, l_iov, niov, l_fds, l_nfds,
> +                                     &local_err);
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

size_t is unsigned so this does not detect negative values. Please use
qio_channel_readv_full()'s return type (ssize_t) instead.

> +            error_propagate(errp, local_err);
> +            return -EIO;
> +        }
> +
> +        l_fds = NULL;
> +        l_nfds = NULL;
> +
> +        size -= len;
> +
> +        (void)iov_discard_front(&l_iov, &niov, len);
> +    }
> +
> +    return iov->iov_len;

read()-style functions return the number of bytes read. mpqemu_readv()
returns the number of unread bytes remaining. Maintaining consistency
with read() function conventions will reduce the chance of bugs, so I
suggest returning the number of bytes read instead.

> +}
> +
> +void mpqemu_msg_recv(MPQemuMsg *msg, QIOChannel *ioc, Error **errp)
> +{
> +    Error *local_err = NULL;
> +    int *fds = NULL;
> +    struct iovec hdr, data;
> +    size_t nfds = 0;
> +
> +    hdr.iov_base = msg;
> +    hdr.iov_len = MPQEMU_MSG_HDR_SIZE;
> +
> +    if (mpqemu_readv(ioc, &hdr, &fds, &nfds, &local_err) < 0) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }

Can we read less than MPQEMU_MSG_HDR_SIZE if the peer closes the socket?
That case probably needs to be handled.

> +void mpqemu_msg_cleanup(MPQemuMsg *msg)
> +{
> +    if (msg->data2) {
> +        free(msg->data2);

The buffer was allocated with g_malloc0() so g_free() should be used to
free it.

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8pWW0ACgkQnKSrs4Gr
c8jxYQf/ZcOxxZC9olljiHU+zLeRrF5KS5Ntn5e4JxJzFMcBXzgVpvWZVEIWleW9
24s9KaiGv3m4Ge28AKzQh4YadIT++uwfEFeI2kvvn95As2KGimzCb5rLM6B7KwRJ
0emMaS0ivmQnbHpmIKlpckg9x7Kle2ti+p10kVkg/SkrayNfs/T0vK9ylQDZ9cwC
8gMCcu2aJZp6tT2ydphRRlyoGNEnbaQel2B9MGVV/8TpclAmFNCjuVMJhzP2VOfN
L5ckbsCzIwgxQY13R8WEHU1jgc3GXvqsM4DGBKqP5KRRKiuhDodG/rlsVQSSbQsZ
3/3G5qxG7iYnMvfPZS7B1D48gme4Jg==
=x3oI
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--


