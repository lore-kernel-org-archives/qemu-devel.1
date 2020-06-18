Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1857CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:33:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F6E217A0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VP7/9ALh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F6E217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlnAf-0002wN-2d
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jln9y-00026X-B4
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 01:32:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45968
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jln9w-00055d-9w
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 01:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592458338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=gMWit5Zj3aMCNVXCfz6MLJOlM8SKGRZhGGghM6uid28=;
 b=VP7/9ALhvkU+uXBAvC284nZeYndM5YjkpUy1Dc+1JM8dA9bHhu8yOiqbGseovLIQhidk1B
 xmrBJ/EtRe2UjbhIcBeVEl599xpnEUb6TiqSEfav5WN3mnWpTyayyn/VT06QauwEocT/vB
 cEZOdz+LwxyR+qmkA/pdtbgq8pWlTEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-KHav1pHIMsaXX5WoMyl9iQ-1; Thu, 18 Jun 2020 01:32:11 -0400
X-MC-Unique: KHav1pHIMsaXX5WoMyl9iQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 838F3A0C00
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 05:32:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 541BC5D9D3;
 Thu, 18 Jun 2020 05:32:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B3B6B1132BD7; Thu, 18 Jun 2020 07:32:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: qemu-pr-helper -v suppresses errors, isn't that weird?
Date: Thu, 18 Jun 2020 07:32:08 +0200
Message-ID: <87imfpszvr.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:32:18
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

prh_co_entry() reports reports errors reading requests / writing
responses only when @verbose (command line -v); relevant code appended
for you convenience.

Sure these are *errors*?  The program recovers and continues, and this
is deemed normal enough to inform the user only when he specifically
asks for it.  Yet when we inform, we format it as an error.  Should we
tune it down to warnings?


static void coroutine_fn prh_co_entry(void *opaque)
{
    [...]
    while (atomic_read(&state) == RUNNING) {
        [...]
        sz = prh_read_request(client, &req, &resp, &local_err);
        if (sz < 0) {
            break;
        }
        [...]
        if (prh_write_response(client, &req, &resp, &local_err) < 0) {
            break;
        }
    }
    if (local_err) {
        if (verbose == 0) {
            error_free(local_err);
        } else {
            error_report_err(local_err);
        }
    }

out:
    qio_channel_detach_aio_context(QIO_CHANNEL(client->ioc));
    object_unref(OBJECT(client->ioc));
    g_free(client);
}


