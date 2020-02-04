Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CED1C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:12:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0800520661
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cd+6OBNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0800520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyyvt-0004MX-Rx
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 09:12:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iyytu-0002fM-Q2
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:10:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iyyts-0005jR-Le
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:10:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26065
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iyyts-0005WI-FQ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580825399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XhFvY/d9RGzMkCS1ZnjSvRY/TsulWyn0WzMNun3rIQk=;
 b=cd+6OBNNqV/57CtKnBWkxKB8jcR01+zSm5ZrfB0aXVAJcoY6r85d/OmMvhjbtVk3DZmszl
 GgTlRwlhGpG6chcvhILUU1x27DJgE/TnGs5yXLY9hqE58IKPju0ogK5+fnTTU86P01rj9B
 9n5UhbtPbm/fYAIqB45Z+BPIeJGsrVA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-V7NmI2v3PyCq0QEwfBqGzQ-1; Tue, 04 Feb 2020 09:09:57 -0500
Received: by mail-wm1-f69.google.com with SMTP id o193so1390466wme.8
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 06:09:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oMHhLntIOzNpL++qY18PVuef0q6WtaIdCfxJHESAXHk=;
 b=PJfYf/o44ShWEmOvKufq5E0j6t8kFy9gmLyIp5jRdprgxNHTFkTWwqR0XWDmW35DC9
 hlUqfzeKeXbLU4njsnh4M4i5h8vueUXbDhMOqUOtS+T50F/aCoT6OzIbbuqgkv6dJHy6
 5HXcz+QrnRnQXNDHZgrRSB4wn2qsB6lWnY4GPYar/w0kikr89jzUY2mP8J1cpwzz7Idt
 /M+Io2WDkenQrvNcuaCQ4NjhdWmbGP9WOl8ni/V1MSBqLpa6rx5AeBvjiZr9xbpOw1iN
 9ygugFiOdWAE9Vjp/+lw0pEbjeHSpitZYopYjx9yFedCCFHO3l87VSHmRhOUWGaev5eg
 8A6Q==
X-Gm-Message-State: APjAAAWxJ1BLD4O18WP03w1uYIPqPXZFHg3HATE4tamnnQuQYPXGYTwT
 F0nfj9NvsygRjyHuivXQ/6Be/RCePrLNE81B4BK4eU6ppglsCmQqi7JWgzJ9cMwlTz/HgD1SLIQ
 MIunzSGuUfzLqDVg=
X-Received: by 2002:a5d:640d:: with SMTP id z13mr21366011wru.181.1580825396441; 
 Tue, 04 Feb 2020 06:09:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqwE8SNBK5thyDhuugHReQ/uk///q8wzXzigRrRNOW5M8dgtzQrWDJPMGVmYkpqUoeGKWQVWhw==
X-Received: by 2002:a5d:640d:: with SMTP id z13mr21365985wru.181.1580825396221; 
 Tue, 04 Feb 2020 06:09:56 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id f14sm10943766wrt.7.2020.02.04.06.09.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 06:09:55 -0800 (PST)
Subject: Re: [PATCH v3 1/2] Acceptance test: provides to use different
 transport for migration
To: Oksana Vohchana <ovoshcha@redhat.com>, qemu-devel@nongnu.org
References: <20200203111631.18796-1-ovoshcha@redhat.com>
 <20200203111631.18796-2-ovoshcha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <de189681-bf7b-be83-ee0a-1a0bb0302a3f@redhat.com>
Date: Tue, 4 Feb 2020 15:09:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203111631.18796-2-ovoshcha@redhat.com>
Content-Language: en-US
X-MC-Unique: V7NmI2v3PyCq0QEwfBqGzQ-1
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

On 2/3/20 12:16 PM, Oksana Vohchana wrote:
> Along with VM migration via TCP, we can use migration through EXEC
> and UNIX transport protocol
>=20
> Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
>=20
> ---
> v2:
>    - Removes unnecessary symbols and unused method
>=20
> v3:
>   - Makes refactoring and split into 2 patches
> Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
> ---
>   tests/acceptance/migration.py | 36 ++++++++++++++++++++---------------
>   1 file changed, 21 insertions(+), 15 deletions(-)
>=20
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.p=
y
> index a44c1ae58f..34263d8eeb 100644
> --- a/tests/acceptance/migration.py
> +++ b/tests/acceptance/migration.py
> @@ -24,6 +24,26 @@ class Migration(Test):
>       def migration_finished(vm):
>           return vm.command('query-migrate')['status'] in ('completed', '=
failed')
>  =20
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

Do you mind if I split this patch in 2 when applying to python-next, and=20
change the subjects as "Extract Migration::assert_migration" and=20
"Extract Migration::do_migrate"?

Meanwhile:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>       def _get_free_port(self):
>           port =3D network.find_free_port()
>           if port is None:
> @@ -32,19 +52,5 @@ class Migration(Test):
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
>=20


