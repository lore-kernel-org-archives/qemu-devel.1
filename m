Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AF3C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:31:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5D5206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRq2NoKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5D5206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVd47-00068u-AO
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVd2J-00044h-Q0
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:29:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56989
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVd2J-0003tb-5L
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588606178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ei7SOVVuE+0viBbYO1EoWop8dzPwWo/vHebFwwQKvZQ=;
 b=CRq2NoKUNfEwf4JbFOdz+kvYHRVmAsl+FmVTeUcJqK/vZrXRYbqn0cUugcKyKrsFU5Lz4D
 P9DCURS+dPbiBZZip0Ar7iRDp9Miawpmuabe9u9Mx945hZb9E4wDdBHhnMYjdRIHjwNfbU
 vmz5C3IUKiATHojugGi2+LDek4jdO6U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-fj2m4o4AMIaD_yYA8HekNQ-1; Mon, 04 May 2020 11:29:35 -0400
X-MC-Unique: fj2m4o4AMIaD_yYA8HekNQ-1
Received: by mail-wr1-f72.google.com with SMTP id o8so10911240wrm.11
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 08:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vZCuoZiD4IRNnZTiI2MM/hCx+AjU6u4qhG4CWjbwLPo=;
 b=XKWZuK0n/CEYZ49JOQeplvkqbp+PJz4uvPh+qeA59q4IkSH3zL6WQPgMAJqjiVbIUL
 +7PizaV0B6Spq38Cehb8WEYeE35fVROiVu6cJfLmUtuhNfFTuDcK8C2CMumYaqT09ykT
 5Xh5XMmh8fNzfmDKbCi+UHB/IE3AmGS8RBOSy2ozjRDiOSri+ns3/ttoJgwm9r9BxSdl
 aHcC6Upk0czbIQjMxx4QdcWjZXgv5hiYOzl9kPj3KlIKifiAdYdNHg2ypCV98tv8Rt03
 E4yuq8p4ydUxY+wT7vDTm7Zaqc+U44AUi3XlNRgX+O43UBecV2w5rB7tOTU0BjLqhQnr
 d5zg==
X-Gm-Message-State: AGi0PubxfqQlFCQ5hnmPZx6Qa+0r84ydryEKGHaSE8/L1U3pxGyL3lue
 VNx1hC3PCobbvvsAMzVOPIqTwhiU5gOa48B7QPWEYK8JFzmDyGaPLmkPYxUk8HXqXIKEKPchGpi
 VueQVGlP4rfnGNWE=
X-Received: by 2002:adf:c508:: with SMTP id q8mr2250074wrf.4.1588606173995;
 Mon, 04 May 2020 08:29:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypLaNr/8MxdS7YNFnI5jOm0Afaw6PoxYBhkkpOR8c3/79C9lMVjKU9C7uf6saK9m0gIDn8/psQ==
X-Received: by 2002:adf:c508:: with SMTP id q8mr2250050wrf.4.1588606173846;
 Mon, 04 May 2020 08:29:33 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id a187sm14023946wmh.40.2020.05.04.08.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 08:29:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/12] configure: Avoid building TCG when not needed
Date: Mon,  4 May 2020 17:29:12 +0200
Message-Id: <20200504152922.21365-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504152922.21365-1-philmd@redhat.com>
References: <20200504152922.21365-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid building TCG when building only tools:

  ./configure --enable-tools --disable-system --disable-user

This saves us from running the soft-float tests enabled since
commit 76170102508.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 configure | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure b/configure
index 23b5e93752..e3b4afbb60 100755
--- a/configure
+++ b/configure
@@ -1663,6 +1663,10 @@ if [ "$ARCH" =3D "unknown" ]; then
   linux_user=3D"no"
 fi
=20
+if [ "$bsd_user" =3D "no" -a "$linux_user" =3D "no" -a "$softmmu" =3D "no"=
 ] ; then
+  tcg=3D"no"
+fi
+
 default_target_list=3D""
=20
 mak_wilds=3D""
--=20
2.21.3


