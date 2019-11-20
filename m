Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14469C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:42:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D414620715
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqANFnMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D414620715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXU08-0004qv-GP
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 12:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iXTyH-0002Vz-TI
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:40:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iXTyG-0006Hj-T4
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:40:53 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55058
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iXTyG-0006Hb-Pw
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574271652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1x1vITYcH+j4amC61VFFXDoc8FVGMgkZiRQkm5tYDRI=;
 b=LqANFnMj2ZESjcm3IpMb/lcD3UHRQlzH+AmfP/vtxA5/VseIzQh2DQY3ZOBfXloPAfxj+g
 pv7RMhmSGfh/3q4oq0AJHg0tSyoTrlOY2mg+TNVs/s1cR1SWI8JqGJN+AQFbqaqlOHZWLb
 eGHJMaST1NO2Uw5tIYyOXpUu0CEGZ5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-C_Ohe3utNbWEPbU09THACg-1; Wed, 20 Nov 2019 12:40:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8299107ACC4;
 Wed, 20 Nov 2019 17:40:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-122.ams2.redhat.com
 [10.36.116.122])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C37F65F78;
 Wed, 20 Nov 2019 17:40:47 +0000 (UTC)
Subject: Re: [PATCH] pseries: disable migration-test if /dev/kvm cannot be used
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20191120170955.242900-1-lvivier@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e4cde90e-155e-d408-b34e-b50c137e6fad@redhat.com>
Date: Wed, 20 Nov 2019 18:40:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191120170955.242900-1-lvivier@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: C_Ohe3utNbWEPbU09THACg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Cole Robinson <crobinso@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/11/2019 18.09, Laurent Vivier wrote:
> On ppc64, migration-test only works with kvm_hv, and we already
> have a check to verify the module is loaded.
>=20
> kvm_hv module can be loaded in memory and /sys/module/kvm_hv exists,
> but on some systems (like build systems) /dev/kvm can be missing
> (by administrators choice).
>=20
> And as kvm_hv exists test-migration is started but QEMU falls back to
> TCG because it cannot be used:
>=20
>     Could not access KVM kernel module: No such file or directory
>     failed to initialize KVM: No such file or directory
>     Back to tcg accelerator
>=20
> And as the test is done with TCG, it fails.
>=20
> As for s390x, we must check for the existence and the access rights
> of /dev/kvm.
>=20
> Reported-by: Cole Robinson <crobinso@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  tests/migration-test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index ac780dffdaad..2b25ba6d77f6 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -1349,7 +1349,8 @@ int main(int argc, char **argv)
>       * some reason)
>       */
>      if (g_str_equal(qtest_get_arch(), "ppc64") &&
> -        access("/sys/module/kvm_hv", F_OK)) {
> +        (access("/sys/module/kvm_hv", F_OK) ||
> +         access("/dev/kvm", R_OK | W_OK))) {
>          g_test_message("Skipping test: kvm_hv not available");
>          return g_test_run();
>      }
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>


