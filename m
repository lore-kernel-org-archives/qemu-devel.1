Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5835C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACCB320674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDBgL7xd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCB320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyz1h-0003Up-TJ
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 09:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iyywQ-0005nY-Lc
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:12:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iyywO-0007PQ-Ha
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:12:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48628
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iyywO-0007Mb-CZ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:12:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580825556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FVOq0G8+hEWWCawWmgO7+spbV4DKIs+mjr373gJK9mg=;
 b=CDBgL7xdm8NisDtiB4/72/0Pr2Pzjgxu5C0Gx2INCk615MHs6fKXa5oTUtUwQGfCydgXhC
 aSEAyO/7wO4k2ULVEcHcDVW4h1grgZheXJ1eEElaN53eUdkKVeRWarEYYTkkvyh5CkY6SD
 BYxxgzMOsRuiQE8wyDYCH5eNtxP30Qs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-ZCLkebS7Mrq-kU8HBLfgNQ-1; Tue, 04 Feb 2020 09:12:33 -0500
Received: by mail-wr1-f70.google.com with SMTP id w6so10224441wrm.16
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 06:12:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YuBQbFJe987UMcDDg2yFM4pIvmeUoVbcBodt+prr6PQ=;
 b=bByFlfKurGLzWf58tOF9LdS1OW8IHCatosulx+sq4v5On/xW/SozqQiwquOvmqJ4Mu
 EoOeLlJbnTcWsBRGMULTx27k1raSZbaTd6/9QsaDVlLaEuJVKvZNct4wQGc7eeMErtrG
 duhCuO3xKv6BiBHNNC7LZxPGS73iU11TWiQf9updJSXOlweplvakolV7ZiZ43gamkjWu
 9OwF+rRUDWpgCjxFqWpTFQ/8jAJbzRQMdrXPr8stVKv8Wg6Xh0TNFaClygEdYIQlo4xE
 wBQgjboJ2l2i9w4ijatV4veIgeT5DdYvjApNhWGpqprVlDwqz9ZVOqnbrCAAfXESXS0f
 fQOQ==
X-Gm-Message-State: APjAAAVTZiYt7mUwa5h/6mS/lczqzi70g8hOR0vlQYybwxausiMQBFgz
 xLZeKyggWgJ/Rcobn11oE6/pNa7P5BUg6DLjIHmGOIeuGKf+S39/YGu2Q1dTZc3u7aYBHOVcCPP
 Zlt5T07MwBA9oF3M=
X-Received: by 2002:a05:600c:2409:: with SMTP id
 9mr5994021wmp.109.1580825552512; 
 Tue, 04 Feb 2020 06:12:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqwhkVL5re3fF9tM44zjilF8uaQdDh8SprGAguoyvZRhmF0XsaDF500XRgkYZuHpztsR1mXHCQ==
X-Received: by 2002:a05:600c:2409:: with SMTP id
 9mr5993981wmp.109.1580825551991; 
 Tue, 04 Feb 2020 06:12:31 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id x10sm30356732wrp.58.2020.02.04.06.12.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 06:12:31 -0800 (PST)
Subject: Re: [PATCH v3 2/2] Acceptance test: provides to use different
 transport for migration
To: Oksana Vohchana <ovoshcha@redhat.com>, qemu-devel@nongnu.org
References: <20200203111631.18796-1-ovoshcha@redhat.com>
 <20200203111631.18796-3-ovoshcha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <45078d7a-d934-5238-511e-876e0eb56858@redhat.com>
Date: Tue, 4 Feb 2020 15:12:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203111631.18796-3-ovoshcha@redhat.com>
Content-Language: en-US
X-MC-Unique: ZCLkebS7Mrq-kU8HBLfgNQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On 2/3/20 12:16 PM, Oksana Vohchana wrote:
> Along with VM migration via TCP, we can use migration through EXEC
> and UNIX transport protocol
>=20
> Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
> ---
> v2:
>    - Removes unnecessary symbols and unused method
>=20
> v3:
>   - Makes refactoring and split into 2 patches
>   - Provides TCP and EXEC migration
> Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
> ---
>   tests/acceptance/migration.py | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>=20
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.p=
y
> index 34263d8eeb..4419e38384 100644
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
> @@ -54,3 +57,16 @@ class Migration(Test):
>       def test_migration_with_tcp_localhost(self):
>           dest_uri =3D 'tcp:localhost:%u' % self._get_free_port()
>           self.do_migrate(dest_uri)
> +
> +    def test_migration_with_unix(self):
> +        with tempfile.TemporaryDirectory(prefix=3D'socket_') as socket_p=
ath:
> +            dest_uri =3D 'unix:%s/qemu-test.sock' % socket_path
> +            self.do_migrate(dest_uri)

Similarly, do you mind if I split and update subjects to "Test the UNIX=20
transport when migrating" and "Test the TCP transport when migrating"?

Meanwhile:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +
> +    @skipUnless(find_command('nc', default=3DFalse), "nc command not fou=
nd on the system")
> +    def test_migration_with_exec(self):
> +        """
> +        The test works for both netcat-traditional and netcat-openbsd pa=
ckages
> +        """
> +        free_port =3D self._get_free_port()
> +        dest_uri =3D 'exec:nc -l localhost %u' % free_port
> +        src_uri =3D 'exec:nc localhost %u' % free_port
> +        self.do_migrate(dest_uri, src_uri)
>=20


