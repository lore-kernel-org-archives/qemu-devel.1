Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6166EC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 07:58:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC032073E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 07:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGcn/7oa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC032073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jysbV-0006Uo-Fj
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 03:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jysax-00064v-RY
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 03:58:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36162
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jysaw-0002BN-Ck
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 03:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595577497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u7p2+1Qaac5EyueagJuWdmbxjqUbYV4FvNp0i0clZrA=;
 b=HGcn/7oatIyDlg/wzKOvMv8iunDI1ixMI6YMcEzaE76PtHhm2/iEWJOSh9Hc6uVdPxArDh
 DnJN8q4148GnbzZYhbA4TGiBRioSFa2tDruLZscZ/iw9BUddbFEFz1378M6uVXghzjYxWi
 xIJPWx2xd8fAI8KOiZb4IC+r25YxroE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-qyx4u1Z6NNCF3TchSA977A-1; Fri, 24 Jul 2020 03:58:15 -0400
X-MC-Unique: qyx4u1Z6NNCF3TchSA977A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 358D0800460;
 Fri, 24 Jul 2020 07:58:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0909071D28;
 Fri, 24 Jul 2020 07:58:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9C648111CA26; Fri, 24 Jul 2020 09:58:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2] qapi: enable use of g_autoptr with QAPI types
References: <20200723153845.2934357-1-berrange@redhat.com>
Date: Fri, 24 Jul 2020 09:58:12 +0200
In-Reply-To: <20200723153845.2934357-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 23 Jul 2020 16:38:45
 +0100")
Message-ID: <87wo2tcpkb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:01:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Currently QAPI generates a type and function for free'ing it:
>
>   typedef struct QCryptoBlockCreateOptions QCryptoBlockCreateOptions;
>   void qapi_free_QCryptoBlockCreateOptions(QCryptoBlockCreateOptions *obj=
);
>
> This is used in the traditional manner:
>
>   QCryptoBlockCreateOptions *opts =3D NULL;
>
>   opts =3D g_new0(QCryptoBlockCreateOptions, 1);
>
>   ....do stuff with opts...
>
>   qapi_free_QCryptoBlockCreateOptions(opts);
>
> Since bumping the min glib to 2.48, QEMU has incrementally adopted the
> use of g_auto/g_autoptr. This allows the compiler to run a function to
> free a variable when it goes out of scope, the benefit being the
> compiler can guarantee it is freed in all possible code ptahs.
>
> This benefit is applicable to QAPI types too, and given the seriously
> long method names for some qapi_free_XXXX() functions, is much less
> typing. This change thus makes the code generator emit:
>
>  G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoBlockCreateOptions,
>                               qapi_free_QCryptoBlockCreateOptions)
>
> The above code example now becomes
>
>   g_autoptr(QCryptoBlockCreateOptions) opts =3D NULL;
>
>   opts =3D g_new0(QCryptoBlockCreateOptions, 1);
>
>   ....do stuff with opts...
>
> Note, if the local pointer needs to live beyond the scope holding the
> variable, then g_steal_pointer can be used. This is useful to return the
> pointer to the caller in the success codepath, while letting it be freed
> in all error codepaths.
>
>   return g_steal_pointer(&opts);
>
> The crypto/block.h header needs updating to avoid symbol clash now that
> the g_autoptr support is a standard QAPI feature.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Queued for 5.2, thanks!


