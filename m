Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC7CC433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:02:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9593C208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzmILDvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9593C208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwQ04-0005y4-P9
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 09:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jwPts-0004zZ-St
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:55:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29233
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jwPtp-0008O2-4Q
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594990536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nUSRD1b1ARuFNDiZ762GHEYCKCvpovMoSmKMFBm7z5o=;
 b=CzmILDvs1vPmlGsxQ6Lf6R5psJ5yvBVvXZaoQMSmEXbp2UhBPPHw4+N2b4ZhhrVCDCryi9
 iIUPOGomXJXkf0v67wS1SEdYYAoZoB4X58cgf4HWj0nj0ndbRJzuDHI/RCCZQTjQyLVEwF
 cV91XsRruU1lS3voASQfBpj05kPJv+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-LntpcqW-PEOiF_-v1UY8Bw-1; Fri, 17 Jul 2020 08:55:26 -0400
X-MC-Unique: LntpcqW-PEOiF_-v1UY8Bw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 781D21005280;
 Fri, 17 Jul 2020 12:55:22 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-80.ams2.redhat.com [10.36.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86F4112563;
 Fri, 17 Jul 2020 12:55:21 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 04/12] crypto: use a stronger private key for tests
Date: Fri, 17 Jul 2020 14:55:02 +0200
Message-Id: <20200717125510.238374-5-kwolf@redhat.com>
In-Reply-To: <20200717125510.238374-1-kwolf@redhat.com>
References: <20200717125510.238374-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 05:27:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_BTC_ID=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

The unit tests using the x509 crypto functionality have started
failing in Fedora 33 rawhide with a message like

      The certificate uses an insecure algorithm

This is result of Fedora changes to support strong crypto [1]. RSA
with 1024 bit key is viewed as legacy and thus insecure. Generate
a new private key which is 3072 bits long and reasonable future
proof.

[1] https://fedoraproject.org/wiki/Changes/StrongCryptoSettings2

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200715154701.1041325-1-berrange@redhat.com>
Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/crypto-tls-x509-helpers.c | 59 ++++++++++++++++++++++-----------
 tests/qemu-iotests/common.tls   | 57 +++++++++++++++++++++----------
 2 files changed, 79 insertions(+), 37 deletions(-)

diff --git a/tests/crypto-tls-x509-helpers.c b/tests/crypto-tls-x509-helpers.c
index 9b669c2a4b..01b3daf358 100644
--- a/tests/crypto-tls-x509-helpers.c
+++ b/tests/crypto-tls-x509-helpers.c
@@ -37,25 +37,46 @@ ASN1_TYPE pkix_asn1;
  * here's one we prepared earlier :-)
  */
 gnutls_x509_privkey_t privkey;
-# define PRIVATE_KEY                                              \
-    "-----BEGIN PRIVATE KEY-----\n"                               \
-    "MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBALVcr\n"     \
-    "BL40Tm6yq88FBhJNw1aaoCjmtg0l4dWQZ/e9Fimx4ARxFpT+ji4FE\n"     \
-    "Cgl9s/SGqC+1nvlkm9ViSo0j7MKDbnDB+VRHDvMAzQhA2X7e8M0n9\n"     \
-    "rPolUY2lIVC83q0BBaOBkCj2RSmT2xTEbbC2xLukSrg2WP/ihVOxc\n"     \
-    "kXRuyFtzAgMBAAECgYB7slBexDwXrtItAMIH6m/U+LUpNe0Xx48OL\n"     \
-    "IOn4a4whNgO/o84uIwygUK27ZGFZT0kAGAk8CdF9hA6ArcbQ62s1H\n"     \
-    "myxrUbF9/mrLsQw1NEqpuUk9Ay2Tx5U/wPx35S3W/X2AvR/ZpTnCn\n"     \
-    "2q/7ym9fyiSoj86drD7BTvmKXlOnOwQJBAPOFMp4mMa9NGpGuEssO\n"     \
-    "m3Uwbp6lhcP0cA9MK+iOmeANpoKWfBdk5O34VbmeXnGYWEkrnX+9J\n"     \
-    "bM4wVhnnBWtgBMCQQC+qAEmvwcfhauERKYznMVUVksyeuhxhCe7EK\n"     \
-    "mPh+U2+g0WwdKvGDgO0PPt1gq0ILEjspMDeMHVdTwkaVBo/uMhAkA\n"     \
-    "Z5SsZyCP2aTOPFDypXRdI4eqRcjaEPOUBq27r3uYb/jeboVb2weLa\n"     \
-    "L1MmVuHiIHoa5clswPdWVI2y0em2IGoDAkBPSp/v9VKJEZabk9Frd\n"     \
-    "a+7u4fanrM9QrEjY3KhduslSilXZZSxrWjjAJPyPiqFb3M8XXA26W\n"     \
-    "nz1KYGnqYKhLcBAkB7dt57n9xfrhDpuyVEv+Uv1D3VVAhZlsaZ5Pp\n"     \
-    "dcrhrkJn2sa/+O8OKvdrPSeeu/N5WwYhJf61+CPoenMp7IFci\n"         \
-    "-----END PRIVATE KEY-----\n"
+# define PRIVATE_KEY \
+    "-----BEGIN RSA PRIVATE KEY-----\n" \
+    "MIIG5AIBAAKCAYEAyjWyLSNm5PZvYUKUcDWGqbLX10b2ood+YaFjWSnJrqx/q3qh\n" \
+    "rVGBJglD25AJENJsmZF3zPP1oMhfIxsXu63Hdkb6Rdlc2RUoUP34x9VC1izH25mR\n" \
+    "6c8DPDp1d6IraZ/llDMI1HsBFz0qGWtvOHgm815XG4PAr/N8rDsuqfv/cJ01KlnO\n" \
+    "0OdO5QRXCJf9g/dYd41MPu7wOXk9FqjQlmRoP59HgtJ+zUpE4z+Keruw9cMT9VJj\n" \
+    "0oT+pQ9ysenqeZ3gbT224T1khrEhT5kifhtFLNyDssRchUUWH0hiqoOO1vgb+850\n" \
+    "W6/1VdxvuPam48py4diSPi1Vip8NITCOBaX9FIpVp4Ruw4rTPVMNMjq9Cpx/DwMP\n" \
+    "9MbfXfnaVaZaMrmq67/zPhl0eVbUrecH2hQ3ZB9oIF4GkNskzlWF5+yPy6zqk304\n" \
+    "AKaiFR6jRyh3YfHo2XFqV8x/hxdsIEXOtEUGhSIcpynsW+ckUCartzu7xbhXjd4b\n" \
+    "kxJT89+riPFYij09AgMBAAECggGBAKyFkaZXXROeejrmHlV6JZGlp+fhgM38gkRz\n" \
+    "+Jp7P7rLLAY3E7gXIPQ91WqAAmwazFNdvHPd9USfkCQYmnAi/VoZhrCPmlsQZRxt\n" \
+    "A5QjjOnEvSPMa6SrXZxGWDCg6R8uMCb4P+FhrPWR1thnRDZOtRTQ+crc50p3mHgt\n" \
+    "6ktXWIJRbqnag8zSfQqCYGtRmhe8sfsWT+Yl4El4+jjaAVU/B364u7+PLmaiphGp\n" \
+    "BdJfTsTwEpgtGkPj+osDmhzXcZkfq3V+fz5JLkemsCiQKmn4VJRpg8c3ZmE8NPNt\n" \
+    "gRtGWZ4W3WKDvhotT65WpQx4+6R8Duux/blNPBmH1Upmwd7kj7GYFBArbCjgd9PT\n" \
+    "xgfCSUZpgOZHHkcgSB+022a8XncXna7WYYij28SLtwImFyu0nNtqECFQHH5u+k6C\n" \
+    "LRYBSN+3t3At8dQuk01NVrJBndmjmXRfxpqUtTdeaNgVpdUYRY98s30G68NYGSra\n" \
+    "aEvhhRSghkcLNetkobpY9pUgeqW/tQKBwQDZHHK9nDMt/zk1TxtILeUSitPXcv1/\n" \
+    "8ufXqO0miHdH23XuXhIEA6Ef26RRVGDGgpjkveDJK/1w5feJ4H/ni4Vclil/cm38\n" \
+    "OwRqjjd7ElHJX6JQbsxEx/gNTk5/QW1iAL9TXUalgepsSXYT6AJ0/CJv0jmJSJ36\n" \
+    "YoKMOM8uqzb2KhN6i+RlJRi5iY53kUhWTJq5ArWvNhUzQNSYODI4bNxlsKSBL2Ik\n" \
+    "LZ5QKHuaEjQet0IlPlfIb4PzMm8CHa/urOcCgcEA7m3zW/lL5bIFoKPjWig5Lbn1\n" \
+    "aHfrG2ngqzWtgWtfZqMH8OkZc1Mdhhmvd46titjiLjeI+UP/uHXR0068PnrNngzl\n" \
+    "tTgwlakzu+bWzqhBm1F+3/341st/FEk07r0P/3/PhezVjwfO8c8Exj7pLxH4wrH0\n" \
+    "ROHgDbClmlJRu6OO78wk1+Vapf5DWa8YfA+q+fdvr7KvgGyytheKMT/b/dsqOq7y\n" \
+    "qZPjmaJKWAvV3RWG8lWHFSdHx2IAHMHfGr17Y/w7AoHBALzwZeYebeekiVucGSjq\n" \
+    "T8SgLhT7zCIx+JMUPjVfYzaUhP/Iu7Lkma6IzWm9nW6Drpy5pUpMzwUWDCLfzU9q\n" \
+    "eseFIl337kEn9wLn+t5OpgAyCqYmlftxbqvdrrBN9uvnrJjWvqk/8wsDrw9JxAGc\n" \
+    "fjeD4nBXUqvYWLXApoR9mZoGKedmoH9pFig4zlO9ig8YITnKYuQ0k6SD0b8agJHc\n" \
+    "Ir0YSUDnRGgpjvFBGbeOCe+FGbohk/EpItJc3IAh5740lwKBwAdXd2DjokSmYKn7\n" \
+    "oeqKxofz6+yVlLW5YuOiuX78sWlVp87xPolgi84vSEnkKM/Xsc8+goc6YstpRVa+\n" \
+    "W+mImoA9YW1dF5HkLeWhTAf9AlgoAEIhbeIfTgBv6KNZSv7RDrDPBBxtXx/vAfSg\n" \
+    "x0ldwk0scZsVYXLKd67yzfV7KdGUdaX4N/xYgfZm/9gCG3+q8NN2KxVHQ5F71BOE\n" \
+    "JeABOaGo9WvnU+DNMIDZjHJMUWVw4MHz/a/UArDf/2CxaPVBNQKBwASg6j4ohSTk\n" \
+    "J7aE6RQ3OBmmDDpixcoCJt9u9SjHVYMlbs5CEJGVSczk0SG3y8P1lOWNDSRnMksZ\n" \
+    "xWnHdP/ogcuYMuvK7UACNAF0zNddtzOhzcpNmejFj+WCHYY/UmPr2/Kf6t7Cxk2K\n" \
+    "3cZ4tqWsiTmBT8Bknmah7L5DrhS+ZBJliDeFAA8fZHdMH0Xjr4UBp9kF90EMTdW1\n" \
+    "Xr5uz7ZrMsYpYQI7mmyqV9SSjUg4iBXwVSoag1iDJ1K8Qg/L7Semgg==\n" \
+    "-----END RSA PRIVATE KEY-----\n"
 
 /*
  * This loads the private key we defined earlier
diff --git a/tests/qemu-iotests/common.tls b/tests/qemu-iotests/common.tls
index 54c331d7a5..6ba28a78d3 100644
--- a/tests/qemu-iotests/common.tls
+++ b/tests/qemu-iotests/common.tls
@@ -50,24 +50,45 @@ tls_x509_init()
     # use a fixed key so we don't waste system entropy on
     # each test run
     cat > "${tls_dir}/key.pem" <<EOF
------BEGIN PRIVATE KEY-----
-MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBALVcr
-BL40Tm6yq88FBhJNw1aaoCjmtg0l4dWQZ/e9Fimx4ARxFpT+ji4FE
-Cgl9s/SGqC+1nvlkm9ViSo0j7MKDbnDB+VRHDvMAzQhA2X7e8M0n9
-rPolUY2lIVC83q0BBaOBkCj2RSmT2xTEbbC2xLukSrg2WP/ihVOxc
-kXRuyFtzAgMBAAECgYB7slBexDwXrtItAMIH6m/U+LUpNe0Xx48OL
-IOn4a4whNgO/o84uIwygUK27ZGFZT0kAGAk8CdF9hA6ArcbQ62s1H
-myxrUbF9/mrLsQw1NEqpuUk9Ay2Tx5U/wPx35S3W/X2AvR/ZpTnCn
-2q/7ym9fyiSoj86drD7BTvmKXlOnOwQJBAPOFMp4mMa9NGpGuEssO
-m3Uwbp6lhcP0cA9MK+iOmeANpoKWfBdk5O34VbmeXnGYWEkrnX+9J
-bM4wVhnnBWtgBMCQQC+qAEmvwcfhauERKYznMVUVksyeuhxhCe7EK
-mPh+U2+g0WwdKvGDgO0PPt1gq0ILEjspMDeMHVdTwkaVBo/uMhAkA
-Z5SsZyCP2aTOPFDypXRdI4eqRcjaEPOUBq27r3uYb/jeboVb2weLa
-L1MmVuHiIHoa5clswPdWVI2y0em2IGoDAkBPSp/v9VKJEZabk9Frd
-a+7u4fanrM9QrEjY3KhduslSilXZZSxrWjjAJPyPiqFb3M8XXA26W
-nz1KYGnqYKhLcBAkB7dt57n9xfrhDpuyVEv+Uv1D3VVAhZlsaZ5Pp
-dcrhrkJn2sa/+O8OKvdrPSeeu/N5WwYhJf61+CPoenMp7IFci
------END PRIVATE KEY-----
+-----BEGIN RSA PRIVATE KEY-----
+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
+-----END RSA PRIVATE KEY-----
 EOF
 }
 
-- 
2.25.4


