Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE24BC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93E5820787
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5bCVlp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E5820787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJCJk-0005A2-MD
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 04:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jJCIY-00044Z-Pi
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jJCIV-0007hr-Cd
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:31:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57683
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jJCIV-0007hE-7H
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585643458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7vd2fEBmGKNRU5kQxKpiGmRS1+qHtoTD1GGNAElR40=;
 b=I5bCVlp4dennZ+1PP0PJ6wemQSvR4+EptsHwevGDy7pXo2ngUSlPKKhBaB3OFwpxmXT2on
 wzg+lnxIQ+/2dss5S+vmWO8GzCLiTMh/15AYeCHKCDREQxsnzfVUNr6cNUmp0kFLTubh3v
 wBl1gzTO4WdMzPPiVla9CFeAcJedzuo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-Er4lQUjZMEKLdAzH7_bAug-1; Tue, 31 Mar 2020 04:30:56 -0400
X-MC-Unique: Er4lQUjZMEKLdAzH7_bAug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 047728017DF;
 Tue, 31 Mar 2020 08:30:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F9D0A0A91;
 Tue, 31 Mar 2020 08:30:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1CF4B11385E2; Tue, 31 Mar 2020 10:30:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 1/3] crypto: Add qcrypto_tls_shutdown()
References: <20200327161936.2225989-1-eblake@redhat.com>
 <20200327161936.2225989-2-eblake@redhat.com>
Date: Tue, 31 Mar 2020 10:30:54 +0200
In-Reply-To: <20200327161936.2225989-2-eblake@redhat.com> (Eric Blake's
 message of "Fri, 27 Mar 2020 11:19:34 -0500")
Message-ID: <87ftdp3ozl.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> Gnutls documents that applications that want to distinguish between a
> clean end-of-communication and a malicious client abruptly tearing the
> underlying transport out of under our feet need to use gnutls_bye().
> Our channel code is already set up to allow shutdown requests, but we
> weren't forwarding those to gnutls.  To make that work, we first need
> a new entry point that can isolate the rest of our code from the
> gnutls interface.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi/crypto.json            | 15 +++++++++++++++
>  include/crypto/tlssession.h | 24 ++++++++++++++++++++++++
>  crypto/tlssession.c         | 27 +++++++++++++++++++++++++++
>  3 files changed, 66 insertions(+)
>
> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index b2a4cff683ff..1df0f4502885 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -119,6 +119,21 @@
>    'prefix': 'QCRYPTO_IVGEN_ALG',
>    'data': ['plain', 'plain64', 'essiv']}
>
> +##
> +# @QCryptoShutdownMode:
> +#
> +# The supported modes for requesting shutdown of a crypto
> +# communication channel.
> +#
> +# @shut-wr: No more writes will be sent, but the remote end can still se=
nd
> +#           data to be read.
> +# @shut-rdwr: No more reads or writes should occur.
> +# Since: 5.1
> +##
> +{ 'enum': 'QCryptoShutdownMode',
> +  'prefix': 'QCRYPTO',
> +  'data': ['shut-wr', 'shut-rdwr']}
> +
>  ##
>  # @QCryptoBlockFormat:
>  #
> diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
> index 15b9cef086cc..10c670e3b6a2 100644
> --- a/include/crypto/tlssession.h
> +++ b/include/crypto/tlssession.h
> @@ -321,4 +321,28 @@ int qcrypto_tls_session_get_key_size(QCryptoTLSSessi=
on *sess,
>   */
>  char *qcrypto_tls_session_get_peer_name(QCryptoTLSSession *sess);
>
> +/**
> + * qcrypto_tls_shutdown:
> + * @sess: the TLS session object
> + * @how: the desired shutdown mode
> + *
> + * Prepare to terminate the session.  If @how is QCRYPTO_SHUT_WR, this
> + * side will no longer write data, but should still process reads
> + * until EOF; if @how is QCRYPTO_SHUT_RDWR, then the entire session
> + * should shut down.  Use of this function is optional, since closing
> + * the session implies QCRYPTO_SHUT_RDWR.  However, using this
> + * function prior to terminating the underlying transport layer makes
> + * it possible for the remote endpoint to distinguish between a
> + * malicious party prematurely terminating the the connection and
> + * normal termination.
> + *
> + * This function should only be used after a successful
> + * qcrypto_tls_session_handshake().
> + *
> + * Returns: 0 for success, or -EAGAIN if more underlying I/O is
> + * required to finish proper session shutdown.
> + */
> +int qcrypto_tls_session_shutdown(QCryptoTLSSession *sess,
> +                                 QCryptoShutdownMode how);
> +
>  #endif /* QCRYPTO_TLSSESSION_H */
> diff --git a/crypto/tlssession.c b/crypto/tlssession.c
> index 33203e8ca711..903301189069 100644
> --- a/crypto/tlssession.c
> +++ b/crypto/tlssession.c
> @@ -521,6 +521,33 @@ qcrypto_tls_session_get_handshake_status(QCryptoTLSS=
ession *session)
>  }
>
>
> +int qcrypto_tls_session_shutdown(QCryptoTLSSession *session,
> +                                 QCryptoShutdownMode how)
> +{
> +    gnutls_close_request_t mode;
> +    int ret;
> +
> +    assert(session->handshakeComplete);

Suggest a blank line here.

> +    switch (how) {
> +    case QCRYPTO_SHUT_WR:
> +        mode =3D GNUTLS_SHUT_WR;
> +        break;
> +    case QCRYPTO_SHUT_RDWR:
> +        mode =3D GNUTLS_SHUT_RDWR;
> +        break;
> +    default:
> +        abort();
> +    }
> +
> +    ret =3D gnutls_bye(session->handle, mode);
> +    if (ret =3D=3D GNUTLS_E_INTERRUPTED ||
> +        ret =3D=3D GNUTLS_E_AGAIN) {
> +        return -EAGAIN;
> +    }
> +    return 0;
> +}
> +
> +
>  int
>  qcrypto_tls_session_get_key_size(QCryptoTLSSession *session,
>                                   Error **errp)

This is a thin wrapper around gnutls_bye().  I understand this is an
abstraction layer backed by GnuTLS.  Not sure abstracting from just one
concrete thing is a good idea, but that's way out of scope here.

In scope: why do you need QCryptoShutdownMode be a QAPI type?


