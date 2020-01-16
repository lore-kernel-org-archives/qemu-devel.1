Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7003C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FACB207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RheeNQJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FACB207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is7av-0004Gr-2r
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 11:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1is7Z2-0003GE-CX
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:00:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1is7Yy-00053P-FO
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:00:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30756
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1is7Yy-00052k-At
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579190403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=QWgV6uO6oFNTRR76lYateq6VTk8GZzNAnTDdOKK1pe0=;
 b=RheeNQJPpS3nJapDj0ThDR52XWTYK0kG7rB5TgLi0swUjX/xWin/FS9lbBxfU2fNLH7Qt6
 9UxWeTSsSUso8nqAdTVrJQW8TO4/ZjtHPiRai6QA3n8Ye/NIkmIufoDgocZh3JoEE8dcoO
 kQqHToT2UHwRwmI/STuYrnY8abMUIRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-zMmd9YL0PbWV4AuJPNVQiA-1; Thu, 16 Jan 2020 11:00:01 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE5A4800D48
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 16:00:00 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-204-105.brq.redhat.com [10.40.204.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 227BD100194E;
 Thu, 16 Jan 2020 15:59:58 +0000 (UTC)
Subject: Re: [PATCH v3 5/5] migration-test: Make sure that multifd and cancel
 works
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
References: <20200116154616.11569-1-quintela@redhat.com>
 <20200116154616.11569-6-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f6946359-28ca-7761-3a0b-9dc4385d3693@redhat.com>
Date: Thu, 16 Jan 2020 16:59:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200116154616.11569-6-quintela@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: zMmd9YL0PbWV4AuJPNVQiA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/01/2020 16.46, Juan Quintela wrote:
> Test that this sequerce works:
> 
> - launch source
> - launch target
> - start migration
> - cancel migration
> - relaunch target
> - do migration again
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
[...]
> +static void test_multifd_tcp_cancel(void)
> +{
> +    MigrateStart *args = migrate_start_new();
> +    QTestState *from, *to, *to2;
> +    QDict *rsp;
> +    char *uri;
> +
> +    args->hide_stderr = true;
> +
> +    if (test_migrate_start(&from, &to, "defer", args)) {
> +        return;
> +    }
> +
> +    /*
> +     * We want to pick a speed slow enough that the test completes
> +     * quickly, but that it doesn't complete precopy even on a slow
> +     * machine, so also set the downtime.
> +     */
> +    /* 1 ms should make it not converge*/
> +    migrate_set_parameter_int(from, "downtime-limit", 1);
> +    /* 300MB/s */
> +    migrate_set_parameter_int(from, "max-bandwidth", 30000000);
> +
> +    migrate_set_parameter_int(from, "multifd-channels", 16);
> +    migrate_set_parameter_int(to, "multifd-channels", 16);
> +
> +    migrate_set_capability(from, "multifd", "true");
> +    migrate_set_capability(to, "multifd", "true");
> +
> +    /* Start incoming migration from the 1st socket */
> +    rsp = wait_command(to, "{ 'execute': 'migrate-incoming',"
> +                           "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
> +    qobject_unref(rsp);
> +
> +    /* Wait for the first serial output from the source */
> +    wait_for_serial("src_serial");
> +
> +    uri = migrate_get_socket_address(to, "socket-address");
> +
> +    migrate_qmp(from, uri, "{}");
> +
> +    wait_for_migration_pass(from);
> +
> +    migrate_cancel(from);
> +
> +    args = migrate_start_new();
> +    args->only_target = true;
> +
> +    if (test_migrate_start(&from, &to2, "defer", args)) {
> +        return;
> +    }
> +
> +    migrate_set_parameter_int(to2, "multifd-channels", 16);
> +
> +    migrate_set_capability(to2, "multifd", "true");
> +
> +    /* Start incoming migration from the 1st socket */
> +    rsp = wait_command(to2, "{ 'execute': 'migrate-incoming',"
> +                            "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
> +    qobject_unref(rsp);
> +
> +    uri = migrate_get_socket_address(to2, "socket-address");
> +
> +    wait_for_migration_status(from, "cancelled", NULL);
> +
> +    /* 300ms it should converge */
> +    migrate_set_parameter_int(from, "downtime-limit", 300);
> +    /* 1GB/s */
> +    migrate_set_parameter_int(from, "max-bandwidth", 1000000000);
> +
> +    migrate_qmp(from, uri, "{}");
> +
> +    wait_for_migration_pass(from);
> +
> +    if (!got_stop) {
> +        qtest_qmp_eventwait(from, "STOP");
> +    }
> +    qtest_qmp_eventwait(to2, "RESUME");
> +
> +    wait_for_serial("dest_serial");
> +    wait_for_migration_complete(from);
> +    test_migrate_end(from, to2, true);
> +    free(uri);

That should be g_free(uri) instead, shouldn't it?

 Thomas

> +}
> +
>  int main(int argc, char **argv)
>  {
>      char template[] = "/tmp/migration-test-XXXXXX";
> @@ -1359,6 +1468,7 @@ int main(int argc, char **argv)
>  
>      qtest_add_func("/migration/auto_converge", test_migrate_auto_converge);
>      qtest_add_func("/migration/multifd/tcp", test_multifd_tcp);
> +    qtest_add_func("/migration/multifd/tcp/cancel", test_multifd_tcp_cancel);
>  
>      ret = g_test_run();
>  
> 


