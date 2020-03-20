Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AC1C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDDC20754
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MieCgLVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDDC20754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFG1M-0005t4-MA
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 07:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jFG0l-0005Ms-NS
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:40:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jFG0k-0004ff-Kj
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:40:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:57149)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jFG0k-0004cm-GP
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584704421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ND0qPYJLMXrwNIQ1/dhGuQgfg+2baR8mMcRQ6CsiIko=;
 b=MieCgLVp7ANHu34o30+hQTRUDfWlYgG75cwxKVsCPAqo7xlFKSKsvWrCUX61VYA/PGny7N
 i4DImu6sTQPC7H5vPrJKTEc9k/eDQiJflpI+r1rp4vc+rU+Xs5e07ob2JJ4KtYbPFeluUU
 l09ZTDRRqznFhEsqoILuPC9RzkyH5IA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-BwWZ43giOZSmUjvd09-KPQ-1; Fri, 20 Mar 2020 07:40:20 -0400
X-MC-Unique: BwWZ43giOZSmUjvd09-KPQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06B06149DB;
 Fri, 20 Mar 2020 11:40:19 +0000 (UTC)
Received: from gondolin (ovpn-113-89.ams2.redhat.com [10.36.113.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAFD010016EB;
 Fri, 20 Mar 2020 11:40:01 +0000 (UTC)
Date: Fri, 20 Mar 2020 12:39:58 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 v2 2/4] tests/test-util-sockets: Skip test on
 non-x86 Travis containers
Message-ID: <20200320123958.354e6cbb.cohuck@redhat.com>
In-Reply-To: <20200318222717.24676-3-philmd@redhat.com>
References: <20200318222717.24676-1-philmd@redhat.com>
 <20200318222717.24676-3-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 23:27:15 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Similarly to commit 4f370b1098, test-util-sockets fails in
> restricted non-x86 Travis containers since they apparently
> blacklisted some required system calls there.

Is "they" =3D=3D "Travis admins"? Can we get them to remove those calls
from the blacklist?

(I'm wondering why x86 allows those calls. Probably just because it has
been around for longer.)

> Let's simply skip the test if we detect such an environment.
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/test-util-sockets.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
> index 5fd947c7bf..046ebec8ba 100644
> --- a/tests/test-util-sockets.c
> +++ b/tests/test-util-sockets.c
> @@ -231,11 +231,18 @@ static void test_socket_fd_pass_num_nocli(void)
>  int main(int argc, char **argv)
>  {
>      bool has_ipv4, has_ipv6;
> +    char *travis_arch;
> =20
>      socket_init();
> =20
>      g_test_init(&argc, &argv, NULL);
> =20
> +    travis_arch =3D getenv("TRAVIS_CPU_ARCH");
> +    if (travis_arch && !g_str_equal(travis_arch, "x86_64")) {
> +        g_printerr("Test does not work on non-x86 Travis containers.");
> +        goto end;
> +    }
> +
>      /* We're creating actual IPv4/6 sockets, so we should
>       * check if the host running tests actually supports
>       * each protocol to avoid breaking tests on machines


