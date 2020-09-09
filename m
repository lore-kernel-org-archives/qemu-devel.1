Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69943C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F41215A4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDjsnLXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F41215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFvig-0002yW-Rw
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 04:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFvfP-0004vQ-2I
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:41:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60354
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFvfM-0007WX-UL
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599640879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/j+2hB4V9Vveviuwy7lOS9bHrvp1WFDGjHt52J0cmhs=;
 b=SDjsnLXpqfzqFixCdGzONRANTHmh9P4YmRcSh7fmfaG/SROKweCJNdpU8DsBJfy/ISstq+
 GJOPFxb3JQdsBq5DwlOhTjENPie9bagmt+YXDXrEToULTj3NcmUJ10hwAbEFVA7ZKAIYFt
 Cz/VjHSPNvKl0ykKKx+Z9lYlfiPaSMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-qVHo4bboMNyheVMArf1LNw-1; Wed, 09 Sep 2020 04:41:14 -0400
X-MC-Unique: qVHo4bboMNyheVMArf1LNw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C6C98015F6;
 Wed,  9 Sep 2020 08:41:13 +0000 (UTC)
Received: from localhost (ovpn-114-244.ams2.redhat.com [10.36.114.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B16AA5C1C4;
 Wed,  9 Sep 2020 08:41:10 +0000 (UTC)
Date: Wed, 9 Sep 2020 09:41:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v4 2/2] rcu: add uninit destructor for rcu
Message-ID: <20200909084107.GE12090@stefanha-x1.localdomain>
References: <20200908151052.713-1-luoyonggang@gmail.com>
 <20200908151052.713-3-luoyonggang@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200908151052.713-3-luoyonggang@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:13:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Juan Quintela <quintela@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Daniel Brodsky <dnbrdsky@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2020 at 11:10:52PM +0800, Yonggang Luo wrote:
> This is necessary if the pending  rcu calls are closing and removing
> temp files. This also provide a function
> void rcu_wait_finished(void);
> to fixes test-logging.c test failure on msys2/mingw.
> On windows if the file doesn't closed, you can not remove it.
>=20
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  include/qemu/rcu.h   |  5 +++++
>  tests/test-logging.c |  2 ++
>  util/rcu.c           | 37 ++++++++++++++++++++++++++++++++++++-
>  3 files changed, 43 insertions(+), 1 deletion(-)

Can the new drain_call_rcu() function be used? Maxim recently posted the
following patch:
https://patchew.org/QEMU/20200831150124.206267-1-mlevitsk@redhat.com/202008=
31150124.206267-3-mlevitsk@redhat.com/

Whether drain_call_rcu() or rcu_wait_finished() is used, please include
a comment in the code that documents why the wait is necessary. For
example, "qemu_log_close() uses RCU for its FILE pointer but Windows
cannot remove open files, so we need to wait for RCU here".

Another option is to wait for RCU inside qemu_log_close() so that
callers don't need to worry about this implementation detail:

  #ifdef _WIN32
  /* Windows cannot remove open files so we need to wait for RCU here */
  drain_call_rcu();
  #endif

> diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
> index 570aa603eb..dd0a92c1d0 100644
> --- a/include/qemu/rcu.h
> +++ b/include/qemu/rcu.h
> @@ -124,6 +124,11 @@ extern void rcu_unregister_thread(void);
>  extern void rcu_enable_atfork(void);
>  extern void rcu_disable_atfork(void);
> =20
> +/*
> + * Wait all rcu call executed and exit the rcu thread.
> + */
> +extern void rcu_wait_finished(void);
> +
>  struct rcu_head;
>  typedef void RCUCBFunc(struct rcu_head *head);
> =20
> diff --git a/tests/test-logging.c b/tests/test-logging.c
> index 957f6c08cd..7a5b59f4a5 100644
> --- a/tests/test-logging.c
> +++ b/tests/test-logging.c
> @@ -210,6 +210,8 @@ int main(int argc, char **argv)
>                           tmp_path, test_logfile_lock);
> =20
>      rc =3D g_test_run();
> +    qemu_log_close();
> +    rcu_wait_finished();
> =20
>      rmdir_full(tmp_path);
>      g_free(tmp_path);
> diff --git a/util/rcu.c b/util/rcu.c
> index 60a37f72c3..43367988b9 100644
> --- a/util/rcu.c
> +++ b/util/rcu.c
> @@ -308,10 +308,20 @@ void rcu_unregister_thread(void)
>      qemu_mutex_unlock(&rcu_registry_lock);
>  }
> =20
> +typedef struct QemuRcuMessage {
> +    struct rcu_head rcu;
> +    void *message;
> +} QemuRcuMessage;
> +
> +static int rcu_thread_exit_called =3D 0;
> +static int rcu_thread_exited =3D 0;
> +static QemuRcuMessage rcu_thread_message;
> +
>  static void rcu_init_complete(void)
>  {
>      QemuThread thread;
> -
> +    atomic_mb_set(&rcu_thread_exit_called, 0);
> +    atomic_mb_set(&rcu_thread_exited, 0);
>      qemu_mutex_init(&rcu_registry_lock);
>      qemu_mutex_init(&rcu_sync_lock);
>      qemu_event_init(&rcu_gp_event, true);
> @@ -327,6 +337,26 @@ static void rcu_init_complete(void)
>      rcu_register_thread();
>  }
> =20
> +static void rcu_thread_exit(QemuRcuMessage *param)
> +{
> +    atomic_mb_set((int*)param->message, 1);
> +    qemu_thread_exit(NULL);
> +}
> +
> +void rcu_wait_finished(void)
> +{
> +    if (atomic_xchg(&rcu_thread_exit_called, 1) =3D=3D 0)
> +    {
> +        rcu_thread_message.message =3D &rcu_thread_exited;
> +        call_rcu(&rcu_thread_message, rcu_thread_exit, rcu);
> +    }
> +
> +    while (atomic_mb_read(&rcu_thread_exited) =3D=3D 0)
> +    {
> +        g_usleep(10000);
> +    }
> +}
> +
>  static int atfork_depth =3D 1;
> =20
>  void rcu_enable_atfork(void)
> @@ -379,3 +409,8 @@ static void __attribute__((__constructor__)) rcu_init=
(void)
>  #endif
>      rcu_init_complete();
>  }
> +
> +static void __attribute__((__destructor__)) rcu_uninit(void)
> +{
> +    rcu_wait_finished();
> +}
> --=20
> 2.28.0.windows.1
>=20

--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9YlSMACgkQnKSrs4Gr
c8jBOwgAyFO0KBTSwz5l8t+09b8r1kFUszlfmIKTJjK7VRwYHNsuySF0UiBjqjcd
C5YhRu9WwQTLo/AX5z8Ok2Xvb6bukgH1KiE1jZNeo66eUm+3wiAEnXJ4ttXqYAxh
tBnuOJHQwt6WOpqpgsWE1BQTo6UUCdWk+asjQ+FHsTs3NRgvLFURycPIsfNFQ7LN
esSpi2gXo7313fXthBKX2niPbMLOnSj8/o3QjQKTTbnbd2Gb5R9FUf1ri7S/P4lo
MnNkFU1KOIjkAibpSKtq0Z+hmw0tu9qzYkotMrJ7jqCEVmVgt8Z+WaG6uoMjC/ca
ZjyTiztmovitvium6DeBGWeP6xsWgw==
=Ea6Q
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--


