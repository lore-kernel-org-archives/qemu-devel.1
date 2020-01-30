Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A316C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3CB72083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+FvP8vE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3CB72083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixItU-0003aW-7u
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 18:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixIsg-00037t-1d
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:05:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixIsd-0005Rm-M4
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:05:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40532
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixIsd-0005Pi-Cn
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580425546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U/JDRoMbGek0RCwAK8Pd/m/Ev9S+PgWpxfc3qhLKI10=;
 b=D+FvP8vEsQ1Zv1LtC1JqYLqCoWOFNC1+1LEBNsJD4ZeL0W9w2CTYZu8ertSvSK0zT8MJrQ
 Q8Uu1g2CBBJZ0BgpX48/nKMrjW9HqeK+AIsllRwpYL7YWMYXOBBwAbWmsFd0uRtb10d+Ed
 E68FRkrKQetLV6bmZMSgrmd3QVL/GxI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-C44y9arsPDSto8Gzc_kVVw-1; Thu, 30 Jan 2020 18:05:42 -0500
Received: by mail-wm1-f72.google.com with SMTP id g26so1989270wmk.6
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 15:05:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ur+w0jUopoIunxAKwBr76Kpn1lCXiiboEj0g9srd5SE=;
 b=Txkp8muh2Jype0E7VnKlDh/kTxCcAJTeefpwtSLcwPLC5ZYgfxULk5S7VqCYUauN4h
 Xox5QTXvP3ZShvhJ3SvwRHfDltNYKrvAM+gipnCGOClotpzYz2DyfDXL+8Srm7aip4ot
 x60cdolHAxsmi6CpvKUfjWs86TPf21l/b+LZ8+O/r+rO1joYUsbzYMEqlJ2x0yr87uYv
 fd3LeG/vFdmnS9sD3rT9rTvzdlN+ZgIw10aQg3y66bI0/rQ1QQnDBGCAu7iIHnILeh5R
 5P2n/ALQPiYnvBQE+AthsJ8tKPaSR3HmHJGvPTC26HIvtV9CMVU1VjYFq4WjKVxmdWbf
 4aOg==
X-Gm-Message-State: APjAAAXq8cS+gPVL834aDTxwA0BatDHQWFdvj20s2+V4MUBqDsFKACaY
 x8Ds6gFhCUJGst3nY8Jrjc4y9feddonxh7bQX3wrAJVUMbWtK+896CRzNW39aJXseRbsTjxOYhW
 NlVtY1snZVRESriI=
X-Received: by 2002:a05:600c:291d:: with SMTP id
 i29mr8312931wmd.39.1580425541008; 
 Thu, 30 Jan 2020 15:05:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqwPi2/hw++uYxSilPY8vwDc3HdMU/t0+Pb0Yvob7YE7gsf+ag4y9UvbPKhbYIGL/IrFLeFPOQ==
X-Received: by 2002:a05:600c:291d:: with SMTP id
 i29mr8312906wmd.39.1580425540767; 
 Thu, 30 Jan 2020 15:05:40 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id w20sm8194560wmk.34.2020.01.30.15.05.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 15:05:40 -0800 (PST)
Subject: Re: [PATCH v2 REPOST] Acceptance test: provides to use different
 transport for migration
To: Oksana Vohchana <ovoshcha@redhat.com>, qemu-devel@nongnu.org
References: <20200130164235.12306-1-ovoshcha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e06902f6-e8ba-c7e7-e11b-c59acee11966@redhat.com>
Date: Fri, 31 Jan 2020 00:05:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200130164235.12306-1-ovoshcha@redhat.com>
Content-Language: en-US
X-MC-Unique: C44y9arsPDSto8Gzc_kVVw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: wainersm@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Oksana,

On 1/30/20 5:42 PM, Oksana Vohchana wrote:
> Along with VM migration via TCP, we can use migration through EXEC
> and UNIX transport protocol
>=20
> Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
> ---
> v2:
>    - Removes unnecessary symbols and unused method
> ---
>   tests/acceptance/migration.py | 51 ++++++++++++++++++++++++-----------
>   1 file changed, 36 insertions(+), 15 deletions(-)
>=20
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.p=
y
> index a44c1ae58f..1f6a674843 100644
> --- a/tests/acceptance/migration.py
> +++ b/tests/acceptance/migration.py
> @@ -10,10 +10,13 @@
>   # later.  See the COPYING file in the top-level directory.
>  =20
>  =20
> +import tempfile
>   from avocado_qemu import Test
> +from avocado import skipUnless
>  =20
>   from avocado.utils import network
>   from avocado.utils import wait
> +from avocado.utils.path import find_command
>  =20
>  =20
>   class Migration(Test):
> @@ -24,6 +27,26 @@ class Migration(Test):
>       def migration_finished(vm):
>           return vm.command('query-migrate')['status'] in ('completed', '=
failed')
>  =20

It is easier to read if you declare assert_migration() before do_migrate().

> +    def do_migrate(self, dest_uri, src_uri=3DNone):
> +        source_vm =3D self.get_vm()
> +        dest_vm =3D self.get_vm('-incoming', dest_uri)
> +        dest_vm.launch()
> +        if src_uri is None:
> +            src_uri =3D dest_uri
> +        source_vm.launch()
> +        source_vm.qmp('migrate', uri=3Dsrc_uri)
> +        self.assert_migration(source_vm, dest_vm)
> +
> +    def assert_migration(self, source_vm, dest_vm):
> +        wait.wait_for(self.migration_finished,
> +                      timeout=3Dself.timeout,
> +                      step=3D0.1,
> +                      args=3D(source_vm,))
> +        self.assertEqual(source_vm.command('query-migrate')['status'], '=
completed')
> +        self.assertEqual(dest_vm.command('query-migrate')['status'], 'co=
mpleted')
> +        self.assertEqual(dest_vm.command('query-status')['status'], 'run=
ning')
> +        self.assertEqual(source_vm.command('query-status')['status'], 'p=
ostmigrate')
> +
>       def _get_free_port(self):
>           port =3D network.find_free_port()
>           if port is None:
> @@ -32,19 +55,17 @@ class Migration(Test):
>  =20
>  =20
>       def test_migration_with_tcp_localhost(self):
> -        source_vm =3D self.get_vm()
>           dest_uri =3D 'tcp:localhost:%u' % self._get_free_port()
> -        dest_vm =3D self.get_vm('-incoming', dest_uri)
> -        dest_vm.launch()
> -        source_vm.launch()
> -        source_vm.qmp('migrate', uri=3Ddest_uri)
> -        wait.wait_for(
> -            self.migration_finished,
> -            timeout=3Dself.timeout,
> -            step=3D0.1,
> -            args=3D(source_vm,)
> -        )
> -        self.assertEqual(dest_vm.command('query-migrate')['status'], 'co=
mpleted')
> -        self.assertEqual(source_vm.command('query-migrate')['status'], '=
completed')
> -        self.assertEqual(dest_vm.command('query-status')['status'], 'run=
ning')
> -        self.assertEqual(source_vm.command('query-status')['status'], 'p=
ostmigrate')
> +        self.do_migrate(dest_uri)

I would split this patch in 2:
- Extract assert_migration() and do_migrate(),
- Add 'unix' socket test
- Add 'exec' test

> +
> +    def test_migration_with_unix(self):
> +        with tempfile.TemporaryDirectory(prefix=3D'socket_') as socket_p=
ath:
> +            dest_uri =3D 'unix:%s/qemu-test.sock' % socket_path
> +            self.do_migrate(dest_uri)
> +
> +    @skipUnless(find_command('nc', default=3DFalse), "nc command not fou=
nd on the system")
> +    def test_migration_with_exec(self):
> +        free_port =3D self._get_free_port()
> +        dest_uri =3D 'exec:nc -l localhost %u' % free_port

Can you check and add a comment that the argument used is handled=20
similarly by both netcat-traditional / netcat-openbsd packages?

> +        src_uri =3D 'exec:nc localhost %u' % free_port
> +        self.do_migrate(dest_uri, src_uri)
>=20

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


