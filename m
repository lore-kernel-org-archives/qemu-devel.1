Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4CFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A875206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUx3/ka5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A875206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWkr-0006zq-QI
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:42:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iwVjW-0006OP-0L
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iwVjT-0007ez-FT
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:37:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56353
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iwVjT-0007cL-8a
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:37:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580236620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RBa/N6CLUvkTgoymHNbFYoT9+rFiGOIqvSnIJ1hi3cQ=;
 b=EUx3/ka5bhj9bBT77WjqigwJV2Upo/dXcT6aUmW+fw6i11XdzvpfxxkcdImI6KrExidUgC
 /92Iokig9htzCPUCFjyoGjW5zvQZ/g03irYxY5CMjp0b4I+I+kCuU8ldAIOj2+/wZsblfB
 71wyRFIKZ2KvuHpQxepPMuQX3uqzC80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-hz7X8TDKNW-liJqeD7781A-1; Tue, 28 Jan 2020 13:36:56 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55FF313E4
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 18:36:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-65.gru2.redhat.com
 [10.97.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED1F53DA3;
 Tue, 28 Jan 2020 18:36:53 +0000 (UTC)
Subject: Re: [PATCH] Acceptance test: provides to use different transport for
 migration
To: Oksana Vohchana <ovoshcha@redhat.com>, qemu-devel@nongnu.org
References: <20200123123004.28156-1-ovoshcha@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <0882f704-5631-9088-92a1-a27638b523cb@redhat.com>
Date: Tue, 28 Jan 2020 16:36:51 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200123123004.28156-1-ovoshcha@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: hz7X8TDKNW-liJqeD7781A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Oksana,

Thanks for your first contribution to QEMU. Some comments below.

On 1/23/20 10:30 AM, Oksana Vohchana wrote:
> Along with VM migration via TCP, we can use migration through EXEC
> and UNIX transport protocol
>
> Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
> ---
>   tests/acceptance/migration.py | 50 ++++++++++++++++++++++++-----------
>   1 file changed, 35 insertions(+), 15 deletions(-)
>
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
> index a44c1ae58f..8bbe28d52d 100644
> --- a/tests/acceptance/migration.py
> +++ b/tests/acceptance/migration.py
> @@ -10,10 +10,13 @@
>   # later.  See the COPYING file in the top-level directory.
>   
>   
> +import tempfile
>   from avocado_qemu import Test
> +from avocado import skipUnless\

Remove the trailing '\'.

>   
>   from avocado.utils import network
>   from avocado.utils import wait
> +from avocado.utils.path import find_command, CmdNotFoundError

CmdNotFoundError is never used.

>   
>   
>   class Migration(Test):
> @@ -24,6 +27,26 @@ class Migration(Test):
>       def migration_finished(vm):
>           return vm.command('query-migrate')['status'] in ('completed', 'failed')
>   
> +    def do_migrate(self, dest_uri, src_uri=None):
> +        source_vm = self.get_vm()
> +        dest_vm = self.get_vm('-incoming', dest_uri)
> +        dest_vm.launch()
> +        if src_uri is None:
> +            src_uri = dest_uri
> +        source_vm.launch()
> +        source_vm.qmp('migrate', uri=src_uri)
> +        self.assert_migration(source_vm, dest_vm)
> +
> +    def assert_migration(self, source_vm, dest_vm):
> +        wait.wait_for(self.migration_finished,
> +                      timeout=self.timeout,
> +                      step=0.1,
> +                      args=(source_vm,))
> +        self.assertEqual(source_vm.command('query-migrate')['status'], 'completed')
> +        self.assertEqual(dest_vm.command('query-migrate')['status'], 'completed')
> +        self.assertEqual(dest_vm.command('query-status')['status'], 'running')
> +        self.assertEqual(source_vm.command('query-status')['status'], 'postmigrate')
> +
>       def _get_free_port(self):
>           port = network.find_free_port()
>           if port is None:
> @@ -32,19 +55,16 @@ class Migration(Test):
>   
>   
>       def test_migration_with_tcp_localhost(self):
> -        source_vm = self.get_vm()
>           dest_uri = 'tcp:localhost:%u' % self._get_free_port()
> -        dest_vm = self.get_vm('-incoming', dest_uri)
> -        dest_vm.launch()
> -        source_vm.launch()
> -        source_vm.qmp('migrate', uri=dest_uri)
> -        wait.wait_for(
> -            self.migration_finished,
> -            timeout=self.timeout,
> -            step=0.1,
> -            args=(source_vm,)
> -        )
> -        self.assertEqual(dest_vm.command('query-migrate')['status'], 'completed')
> -        self.assertEqual(source_vm.command('query-migrate')['status'], 'completed')
> -        self.assertEqual(dest_vm.command('query-status')['status'], 'running')
> -        self.assertEqual(source_vm.command('query-status')['status'], 'postmigrate')
> +        self.do_migrate(dest_uri)
> +
> +    def test_migration_with_unix(self):
> +        with tempfile.TemporaryDirectory(prefix='socket_') as socket_path:
> +            dest_uri = 'unix:%s/qemu-test.sock' % socket_path
> +            self.do_migrate(dest_uri)
> +    @skipUnless(find_command('nc', default=False), "nc command not found on the system")
> +    def test_migration_with_exec(self):

Please add a blank line between the two methods.

> +        free_port = self._get_free_port()
> +        dest_uri = 'exec:nc -l localhost %u' % free_port
> +        src_uri = 'exec:nc localhost %u' % free_port
> +        self.do_migrate(dest_uri, src_uri)


