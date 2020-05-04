Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A98C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B69B2078C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eba4/IOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B69B2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcEZ-0003xS-O4
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6Y-00060c-Lj
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28209
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6X-0006JY-Cv
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eToXLQiELi/OqolKT7hKDbv8PBLrjpjtRA8gmXCmZKQ=;
 b=Eba4/IOXUCfhF/49F6dlOKZr9bJP2vnoMQx4B0SfkU+onzqWEAc29+g/bk3eNCrUGkn/2b
 dPqCxMYtpxuZzpppNDCJET2lImwsrzmNXqzdpVVOlg6jrccCcZA8Pl+xZywcg1T/nRmqYQ
 lng8FfV6q3b9A+DNXFnF5AGofr6Zud4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-Dm-xTX_CPC-Gq2w4wp_P5Q-1; Mon, 04 May 2020 10:29:52 -0400
X-MC-Unique: Dm-xTX_CPC-Gq2w4wp_P5Q-1
Received: by mail-wr1-f72.google.com with SMTP id r11so10842992wrx.21
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DGleufk736LANkC6r/eufWZtid2misO75KfvqBBNzzY=;
 b=Aky5itMvwSszfnzGbOUaXocF77kc7Keb7QhViEAmGC8MoYCtdCkgBKRHtUuX48ohWp
 y3YsYmmgZ502rAPfXny9B6iMkDrbKXwbFLjeSv8vJpaZG3pDZ6gsc4uzvFdjsSNGRTzM
 gx/jvf0QnM7JYzETLG7yV4gE+P/+slMJgRNBBwwq9QPiFaJAe7hAAU9VoZ8FhHYwrPRC
 vIVe4yDWKOlKoNusebPeME45utjICNM06aCzNmWcuvfEuIQUg2ZgMn5i3hG+shmtfRG2
 6pwB8gTdF4UahwQJGAxencgns0U4EgDn7/HmKP7NnF4BOi0PAEaFS3d2LxgHE8eg59/L
 B8+g==
X-Gm-Message-State: AGi0PuYNGLK58+1L2sFv0x66sJRH87olF8CyuJ796rC0JdPshNaC4/b0
 mwpMOy9jxuItfoAmm1msxv2eLrxt3IRWlxtv8X3IuK6P2OBlO83Ij0W5Uf5oCujGR7Dy0saXU8v
 vk5pQ4GrN6UX0mcU=
X-Received: by 2002:a05:6000:192:: with SMTP id
 p18mr12476878wrx.126.1588602591511; 
 Mon, 04 May 2020 07:29:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypI0T51o0KXqcaFSF/yiI1Gdpg6kzab/lIIn7u8MGd8prWsfQJVwydS+5TG5IbwCVV2JF4pqoQ==
X-Received: by 2002:a05:6000:192:: with SMTP id
 p18mr12476847wrx.126.1588602591193; 
 Mon, 04 May 2020 07:29:51 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 f7sm17778746wrt.10.2020.05.04.07.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:29:50 -0700 (PDT)
Date: Mon, 4 May 2020 10:29:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/29] hw/acpi/nvdimm: Fix for NVDIMM incorrect DSM output
 buffer length
Message-ID: <20200504142814.157589-16-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

As per ACPI spec 6.3, Table 19-419 Object Conversion Rules, if
the Buffer Field <=3D to the size of an Integer (in bits), it will
be treated as an integer. Moreover, the integer size depends on
DSDT tables revision number. If revision number is < 2, integer
size is 32 bits, otherwise it is 64 bits. Current NVDIMM common
DSM aml code (NCAL) uses CreateField() for creating DSM output
buffer. This creates an issue in arm/virt platform where DSDT
revision number is 2 and results in DSM buffer with a wrong
size(8 bytes) gets returned when actual length is < 8 bytes.
This causes guest kernel to report,

"nfit ACPI0012:00: found a zero length table '0' parsing nfit"

In order to fix this, aml code is now modified such that it builds
the DSM output buffer in a byte by byte fashion when length is
smaller than Integer size.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200421125934.14952-2-shameerali.kolothum.thodi@huawei.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |  2 ++
 hw/acpi/nvdimm.c                            | 40 +++++++++++++++++++--
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios=
-tables-test-allowed-diff.h
index dfb8523c8b..eb8bae1407 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/SSDT.dimmpxm",
+"tests/data/acpi/q35/SSDT.dimmpxm",
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index eb6a37b14e..df0790719a 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -938,6 +938,7 @@ static void nvdimm_build_common_dsm(Aml *dev)
     Aml *method, *ifctx, *function, *handle, *uuid, *dsm_mem, *elsectx2;
     Aml *elsectx, *unsupport, *unpatched, *expected_uuid, *uuid_invalid;
     Aml *pckg, *pckg_index, *pckg_buf, *field, *dsm_out_buf, *dsm_out_buf_=
size;
+    Aml *whilectx, *offset;
     uint8_t byte_list[1];
=20
     method =3D aml_method(NVDIMM_COMMON_DSM, 5, AML_SERIALIZED);
@@ -1091,13 +1092,46 @@ static void nvdimm_build_common_dsm(Aml *dev)
     /* RLEN is not included in the payload returned to guest. */
     aml_append(method, aml_subtract(aml_name(NVDIMM_DSM_OUT_BUF_SIZE),
                aml_int(4), dsm_out_buf_size));
+
+    /*
+     * As per ACPI spec 6.3, Table 19-419 Object Conversion Rules, if
+     * the Buffer Field <=3D to the size of an Integer (in bits), it will
+     * be treated as an integer. Moreover, the integer size depends on
+     * DSDT tables revision number. If revision number is < 2, integer
+     * size is 32 bits, otherwise it is 64 bits.
+     * Because of this CreateField() canot be used if RLEN < Integer Size.
+     *
+     * Also please note that APCI ASL operator SizeOf() doesn't support
+     * Integer and there isn't any other way to figure out the Integer
+     * size. Hence we assume 8 byte as Integer size and if RLEN < 8 bytes,
+     * build dsm_out_buf byte by byte.
+     */
+    ifctx =3D aml_if(aml_lless(dsm_out_buf_size, aml_int(8)));
+    offset =3D aml_local(2);
+    aml_append(ifctx, aml_store(aml_int(0), offset));
+    aml_append(ifctx, aml_name_decl("TBUF", aml_buffer(1, NULL)));
+    aml_append(ifctx, aml_store(aml_buffer(0, NULL), dsm_out_buf));
+
+    whilectx =3D aml_while(aml_lless(offset, dsm_out_buf_size));
+    /* Copy 1 byte at offset from ODAT to temporary buffer(TBUF). */
+    aml_append(whilectx, aml_store(aml_derefof(aml_index(
+                                   aml_name(NVDIMM_DSM_OUT_BUF), offset)),
+                                   aml_index(aml_name("TBUF"), aml_int(0))=
));
+    aml_append(whilectx, aml_concatenate(dsm_out_buf, aml_name("TBUF"),
+                                         dsm_out_buf));
+    aml_append(whilectx, aml_increment(offset));
+    aml_append(ifctx, whilectx);
+
+    aml_append(ifctx, aml_return(dsm_out_buf));
+    aml_append(method, ifctx);
+
+    /* If RLEN >=3D Integer size, just use CreateField() operator */
     aml_append(method, aml_store(aml_shiftleft(dsm_out_buf_size, aml_int(3=
)),
                                  dsm_out_buf_size));
     aml_append(method, aml_create_field(aml_name(NVDIMM_DSM_OUT_BUF),
                aml_int(0), dsm_out_buf_size, "OBUF"));
-    aml_append(method, aml_concatenate(aml_buffer(0, NULL), aml_name("OBUF=
"),
-                                       dsm_out_buf));
-    aml_append(method, aml_return(dsm_out_buf));
+    aml_append(method, aml_return(aml_name("OBUF")));
+
     aml_append(dev, method);
 }
=20
--=20
MST


