Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F5BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3AAF2076B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GMcGuyt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3AAF2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY5xQ-0003HX-T5
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 07:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1kY5vf-0002Ln-Bl; Thu, 29 Oct 2020 07:17:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20410)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1kY5vY-0001xp-2l; Thu, 29 Oct 2020 07:17:14 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09TB2jTn169369; Thu, 29 Oct 2020 07:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=JMTNi6KknCcfOZzyTaiqBFfdIkzBtz1dQzGWh0vG+ek=;
 b=GMcGuyt67TYMxmBaTp24DaSnaZbVyJYUFOTDHKPtaYi4qlco0UArldKhAwpeL7ohKScZ
 8z6Ysgy1eBeaBG11VL7CaPqT5S+6bDCdlAUc3hgMCos5FAOeNzecDs2Y9g5pUYg51IXG
 oKCTrLO2Ch3GwDLTi635bC1XNwbpwxJFsPZCxATseUd2LuTAjszzSnQsvMdYhQ7ZXthV
 o3BEr5GwBOgPX+HhmKAyzOXbcCLIGVXdl1Pk61Kmvk14KfCAFvrdW5ZDgBqhzdP+weAM
 QWjr0ovSJwXRfMGwpZ4Z+saQzFyTM2VjBNE3/L8Lg+cr1H+lIIebNPl5iamAJ6NBtiMd xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34dcqghf97-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2020 07:17:03 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09TB41C2171458;
 Thu, 29 Oct 2020 07:17:03 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34dcqghf73-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2020 07:17:02 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09TBD21k010919;
 Thu, 29 Oct 2020 11:16:59 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma06fra.de.ibm.com with ESMTP id 34ejqe94vn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2020 11:16:58 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09TBGu9V31457680
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Oct 2020 11:16:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFAF3AE051;
 Thu, 29 Oct 2020 11:16:56 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49AC8AE04D;
 Thu, 29 Oct 2020 11:16:56 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.20])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 29 Oct 2020 11:16:56 +0000 (GMT)
Subject: Re: [PATCH 4/4] iotests: rewrite iotest 240 in python
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20201019163702.471239-1-mlevitsk@redhat.com>
 <20201019163702.471239-5-mlevitsk@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Message-ID: <214647b0-c745-0941-ba66-8248d915a156@de.ibm.com>
Date: Thu, 29 Oct 2020 12:16:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201019163702.471239-5-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-10-29_03:2020-10-29,
 2020-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010290081
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@de.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 07:17:04
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.261,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19.10.20 18:37, Maxim Levitsky wrote:
> The recent changes that brought RCU delayed device deletion,
> broke few tests and this test breakage went unnoticed.
> 
> Fix this test by rewriting it in python
> (which allows to wait for DEVICE_DELETED events before continuing).

While this is now fine for x86, this seems to not cover the s390 specific ccw bus:


--- /home/cborntra/REPOS/qemu/tests/qemu-iotests/240.out	2020-10-29 12:14:42.409233949 +0100
+++ /home/cborntra/REPOS/qemu/build/240.out.bad	2020-10-29 12:15:29.309233949 +0100
@@ -3,7 +3,7 @@
 {"return": {}}
 {"execute": "object-add", "arguments": {"id": "iothread0", "qom-type": "iothread"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"driver": "virtio-scsi-pci", "id": "scsi0", "iothread": "iothread0"}}
+{"execute": "device_add", "arguments": {"driver": "virtio-scsi-ccw", "id": "scsi0", "iothread": "iothread0"}}
 {"return": {}}
 {"execute": "device_add", "arguments": {"drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
 {"return": {}}
@@ -22,7 +22,7 @@
 {"return": {}}
 {"execute": "object-add", "arguments": {"id": "iothread0", "qom-type": "iothread"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"driver": "virtio-scsi-pci", "id": "scsi0", "iothread": "iothread0"}}
+{"execute": "device_add", "arguments": {"driver": "virtio-scsi-ccw", "id": "scsi0", "iothread": "iothread0"}}
 {"return": {}}
 {"execute": "device_add", "arguments": {"drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
 {"return": {}}
@@ -43,9 +43,9 @@
 {"return": {}}
 {"execute": "object-add", "arguments": {"id": "iothread1", "qom-type": "iothread"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"driver": "virtio-scsi-pci", "id": "scsi0", "iothread": "iothread0"}}
+{"execute": "device_add", "arguments": {"driver": "virtio-scsi-ccw", "id": "scsi0", "iothread": "iothread0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"driver": "virtio-scsi-pci", "id": "scsi1", "iothread": "iothread1"}}
+{"execute": "device_add", "arguments": {"driver": "virtio-scsi-ccw", "id": "scsi1", "iothread": "iothread1"}}
 {"return": {}}
 {"execute": "device_add", "arguments": {"bus": "scsi0.0", "drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
 {"return": {}}
@@ -72,7 +72,7 @@
 {"return": {}}
 {"execute": "object-add", "arguments": {"id": "iothread0", "qom-type": "iothread"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"driver": "virtio-scsi-pci", "id": "scsi0", "iothread": "iothread0"}}
+{"execute": "device_add", "arguments": {"driver": "virtio-scsi-ccw", "id": "scsi0", "iothread": "iothread0"}}
 {"return": {}}
 {"execute": "device_add", "arguments": {"drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
 {"return": {}}
Failures: 240
Failed 1 of 1 iotests

> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  tests/qemu-iotests/240     | 228 ++++++++++++++++---------------------
>  tests/qemu-iotests/240.out |  76 ++++++++-----
>  2 files changed, 143 insertions(+), 161 deletions(-)
> 
> diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
> index 8b4337b58d..a739de6769 100755
> --- a/tests/qemu-iotests/240
> +++ b/tests/qemu-iotests/240
> @@ -1,5 +1,5 @@
> -#!/usr/bin/env bash
> -#
> +#!/usr/bin/env python3
> +
>  # Test hot plugging and unplugging with iothreads
>  #
>  # Copyright (C) 2019 Igalia, S.L.
> @@ -17,133 +17,99 @@
>  #
>  # You should have received a copy of the GNU General Public License
>  # along with this program.  If not, see <http://www.gnu.org/licenses/>.
> -#
>  
> -# creator
> -owner=berto@igalia.com
> -
> -seq=`basename $0`
> -echo "QA output created by $seq"
> -
> -status=1	# failure is the default!
> -
> -_cleanup()
> -{
> -    rm -f "$SOCK_DIR/nbd"
> -}
> -trap "_cleanup; exit \$status" 0 1 2 3 15
> -
> -# get standard environment, filters and checks
> -. ./common.rc
> -. ./common.filter
> -
> -_supported_fmt generic
> -_supported_proto generic
> -
> -do_run_qemu()
> -{
> -    echo Testing: "$@"
> -    $QEMU -nographic -qmp stdio -serial none "$@"
> -    echo
> -}
> -
> -# Remove QMP events from (pretty-printed) output. Doesn't handle
> -# nested dicts correctly, but we don't get any of those in this test.
> -_filter_qmp_events()
> -{
> -    tr '\n' '\t' | sed -e \
> -	's/{\s*"timestamp":\s*{[^}]*},\s*"event":[^,}]*\(,\s*"data":\s*{[^}]*}\)\?\s*}\s*//g' \
> -	| tr '\t' '\n'
> -}
> -
> -run_qemu()
> -{
> -    do_run_qemu "$@" 2>&1 | _filter_qmp | _filter_qmp_events
> -}
> -
> -case "$QEMU_DEFAULT_MACHINE" in
> -  s390-ccw-virtio)
> -      virtio_scsi=virtio-scsi-ccw
> -      ;;
> -  *)
> -      virtio_scsi=virtio-scsi-pci
> -      ;;
> -esac
> -
> -echo
> -echo === Unplug a SCSI disk and then plug it again ===
> -echo
> -
> -run_qemu <<EOF
> -{ "execute": "qmp_capabilities" }
> -{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-zeroes": true, "node-name": "hd0"}}
> -{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
> -{ "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${virtio_scsi}", "iothread": "iothread0"}}
> -{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0"}}
> -{ "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
> -{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0"}}
> -{ "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
> -{ "execute": "device_del", "arguments": {"id": "scsi0"}}
> -{ "execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
> -{ "execute": "quit"}
> -EOF
> -
> -echo
> -echo === Attach two SCSI disks using the same block device and the same iothread ===
> -echo
> -
> -run_qemu <<EOF
> -{ "execute": "qmp_capabilities" }
> -{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-zeroes": true, "node-name": "hd0", "read-only": true}}
> -{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
> -{ "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${virtio_scsi}", "iothread": "iothread0"}}
> -{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0"}}
> -{ "execute": "device_add", "arguments": {"id": "scsi-hd1", "driver": "scsi-hd", "drive": "hd0"}}
> -{ "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
> -{ "execute": "device_del", "arguments": {"id": "scsi-hd1"}}
> -{ "execute": "device_del", "arguments": {"id": "scsi0"}}
> -{ "execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
> -{ "execute": "quit"}
> -EOF
> -
> -echo
> -echo === Attach two SCSI disks using the same block device but different iothreads ===
> -echo
> -
> -run_qemu <<EOF
> -{ "execute": "qmp_capabilities" }
> -{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-zeroes": true, "node-name": "hd0", "read-only": true}}
> -{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
> -{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread1"}}
> -{ "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${virtio_scsi}", "iothread": "iothread0"}}
> -{ "execute": "device_add", "arguments": {"id": "scsi1", "driver": "${virtio_scsi}", "iothread": "iothread1"}}
> -{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0", "bus": "scsi0.0"}}
> -{ "execute": "device_add", "arguments": {"id": "scsi-hd1", "driver": "scsi-hd", "drive": "hd0", "bus": "scsi1.0"}}
> -{ "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
> -{ "execute": "device_add", "arguments": {"id": "scsi-hd1", "driver": "scsi-hd", "drive": "hd0", "bus": "scsi1.0"}}
> -{ "execute": "device_del", "arguments": {"id": "scsi-hd1"}}
> -{ "execute": "device_del", "arguments": {"id": "scsi0"}}
> -{ "execute": "device_del", "arguments": {"id": "scsi1"}}
> -{ "execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
> -{ "execute": "quit"}
> -EOF
> -
> -echo
> -echo === Attach a SCSI disks using the same block device as a NBD server ===
> -echo
> -
> -run_qemu <<EOF
> -{ "execute": "qmp_capabilities" }
> -{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-zeroes": true, "node-name": "hd0", "read-only": true}}
> -{ "execute": "nbd-server-start", "arguments": {"addr":{"type":"unix","data":{"path":"$SOCK_DIR/nbd"}}}}
> -{ "execute": "nbd-server-add", "arguments": {"device":"hd0"}}
> -{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
> -{ "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${virtio_scsi}", "iothread": "iothread0"}}
> -{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0", "bus": "scsi0.0"}}
> -{ "execute": "quit"}
> -EOF
> -
> -# success, all done
> -echo "*** done"
> -rm -f $seq.full
> -status=0
> +import iotests
> +import os
> +
> +nbd_sock = iotests.file_path('nbd.sock', base_dir=iotests.sock_dir)
> +
> +class TestCase(iotests.QMPTestCase):
> +    test_driver = "null-co"
> +
> +    def required_drivers(self):
> +        return [self.test_driver]
> +
> +    @iotests.skip_if_unsupported(required_drivers)
> +    def setUp(self):
> +        self.vm = iotests.VM()
> +        self.vm.launch()
> +
> +    def tearDown(self):
> +        self.vm.shutdown()
> +
> +    def test1(self):
> +        iotests.log('==Unplug a SCSI disk and then plug it again==')
> +        self.vm.qmp_log('blockdev-add', driver='null-co', read_zeroes=True, node_name='hd0')
> +        self.vm.qmp_log('object-add', qom_type='iothread', id="iothread0")
> +        self.vm.qmp_log('device_add', id='scsi0', driver=iotests.get_virtio_scsi_device(), iothread='iothread0')
> +        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0')
> +        self.vm.qmp_log('device_del', id='scsi-hd0')
> +        self.vm.event_wait('DEVICE_DELETED')
> +        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0')
> +        self.vm.qmp_log('device_del', id='scsi-hd0')
> +        self.vm.event_wait('DEVICE_DELETED')
> +        self.vm.qmp_log('device_del', id='scsi0')
> +        self.vm.qmp_log('blockdev-del', node_name='hd0')
> +
> +    def test2(self):
> +        iotests.log('==Attach two SCSI disks using the same block device and the same iothread==')
> +        self.vm.qmp_log('blockdev-add', driver='null-co', read_zeroes=True, node_name='hd0', read_only=True)
> +        self.vm.qmp_log('object-add', qom_type='iothread', id="iothread0")
> +        self.vm.qmp_log('device_add', id='scsi0', driver=iotests.get_virtio_scsi_device(), iothread='iothread0')
> +
> +        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0')
> +        self.vm.qmp_log('device_add', id='scsi-hd1', driver='scsi-hd', drive='hd0')
> +        self.vm.qmp_log('device_del', id='scsi-hd1')
> +        self.vm.event_wait('DEVICE_DELETED')
> +        self.vm.qmp_log('device_del', id='scsi-hd0')
> +        self.vm.event_wait('DEVICE_DELETED')
> +        self.vm.qmp_log('device_del', id='scsi0')
> +        self.vm.qmp_log('blockdev-del', node_name='hd0')
> +
> +    def test3(self):
> +        iotests.log('==Attach two SCSI disks using the same block device but different iothreads==')
> +
> +        self.vm.qmp_log('blockdev-add', driver='null-co', read_zeroes=True, node_name='hd0', read_only=True)
> +
> +        self.vm.qmp_log('object-add', qom_type='iothread', id="iothread0")
> +        self.vm.qmp_log('object-add', qom_type='iothread', id="iothread1")
> +
> +        self.vm.qmp_log('device_add', id='scsi0', driver=iotests.get_virtio_scsi_device(), iothread='iothread0')
> +        self.vm.qmp_log('device_add', id='scsi1', driver=iotests.get_virtio_scsi_device(), iothread='iothread1')
> +
> +        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0', bus="scsi0.0")
> +        self.vm.qmp_log('device_add', id='scsi-hd1', driver='scsi-hd', drive='hd0', bus="scsi1.0")
> +
> +        self.vm.qmp_log('device_del', id='scsi-hd0')
> +        self.vm.event_wait('DEVICE_DELETED')
> +        self.vm.qmp_log('device_add', id='scsi-hd1', driver='scsi-hd', drive='hd0', bus="scsi1.0")
> +
> +        self.vm.qmp_log('device_del', id='scsi-hd1')
> +        self.vm.event_wait('DEVICE_DELETED')
> +
> +        self.vm.qmp_log('device_del', id='scsi1')
> +        self.vm.qmp_log('device_del', id='scsi0')
> +
> +        self.vm.qmp_log('blockdev-del', node_name='hd0')
> +
> +    def test4(self):
> +        iotests.log('==Attach a SCSI disks using the same block device as a NBD server==')
> +
> +        self.vm.qmp_log('blockdev-add', driver='null-co', read_zeroes=True, node_name='hd0', read_only=True)
> +
> +        self.vm.qmp_log('nbd-server-start',
> +                        filters=[iotests.filter_qmp_testfiles],
> +                        addr={'type':'unix', 'data':{'path':nbd_sock}})
> +
> +        self.vm.qmp_log('nbd-server-add', device='hd0')
> +
> +        self.vm.qmp_log('object-add', qom_type='iothread', id="iothread0")
> +        self.vm.qmp_log('device_add', id='scsi0', driver=iotests.get_virtio_scsi_device(), iothread='iothread0')
> +        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0')
> +
> +
> +if __name__ == '__main__':
> +    if 'null-co' not in iotests.supported_formats():
> +        iotests.notrun('null-co driver support missing')
> +    iotests.activate_logging()
> +    iotests.main()
> diff --git a/tests/qemu-iotests/240.out b/tests/qemu-iotests/240.out
> index d00df50297..24847be6b3 100644
> --- a/tests/qemu-iotests/240.out
> +++ b/tests/qemu-iotests/240.out
> @@ -1,67 +1,83 @@
> -QA output created by 240
> -
> -=== Unplug a SCSI disk and then plug it again ===
> -
> -Testing:
> -QMP_VERSION
> -{"return": {}}
> +==Unplug a SCSI disk and then plug it again==
> +{"execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0", "read-zeroes": true}}
>  {"return": {}}
> +{"execute": "object-add", "arguments": {"id": "iothread0", "qom-type": "iothread"}}
>  {"return": {}}
> +{"execute": "device_add", "arguments": {"driver": "virtio-scsi-pci", "id": "scsi0", "iothread": "iothread0"}}
>  {"return": {}}
> +{"execute": "device_add", "arguments": {"drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
>  {"return": {}}
> +{"execute": "device_del", "arguments": {"id": "scsi-hd0"}}
>  {"return": {}}
> +{"execute": "device_add", "arguments": {"drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
>  {"return": {}}
> +{"execute": "device_del", "arguments": {"id": "scsi-hd0"}}
>  {"return": {}}
> +{"execute": "device_del", "arguments": {"id": "scsi0"}}
>  {"return": {}}
> +{"execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
>  {"return": {}}
> +==Attach two SCSI disks using the same block device and the same iothread==
> +{"execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0", "read-only": true, "read-zeroes": true}}
>  {"return": {}}
> -
> -=== Attach two SCSI disks using the same block device and the same iothread ===
> -
> -Testing:
> -QMP_VERSION
> +{"execute": "object-add", "arguments": {"id": "iothread0", "qom-type": "iothread"}}
>  {"return": {}}
> +{"execute": "device_add", "arguments": {"driver": "virtio-scsi-pci", "id": "scsi0", "iothread": "iothread0"}}
>  {"return": {}}
> +{"execute": "device_add", "arguments": {"drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
>  {"return": {}}
> +{"execute": "device_add", "arguments": {"drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd1"}}
>  {"return": {}}
> +{"execute": "device_del", "arguments": {"id": "scsi-hd1"}}
>  {"return": {}}
> +{"execute": "device_del", "arguments": {"id": "scsi-hd0"}}
>  {"return": {}}
> +{"execute": "device_del", "arguments": {"id": "scsi0"}}
>  {"return": {}}
> +{"execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
>  {"return": {}}
> +==Attach two SCSI disks using the same block device but different iothreads==
> +{"execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0", "read-only": true, "read-zeroes": true}}
>  {"return": {}}
> +{"execute": "object-add", "arguments": {"id": "iothread0", "qom-type": "iothread"}}
>  {"return": {}}
> +{"execute": "object-add", "arguments": {"id": "iothread1", "qom-type": "iothread"}}
>  {"return": {}}
> -
> -=== Attach two SCSI disks using the same block device but different iothreads ===
> -
> -Testing:
> -QMP_VERSION
> -{"return": {}}
> -{"return": {}}
> -{"return": {}}
> -{"return": {}}
> +{"execute": "device_add", "arguments": {"driver": "virtio-scsi-pci", "id": "scsi0", "iothread": "iothread0"}}
>  {"return": {}}
> +{"execute": "device_add", "arguments": {"driver": "virtio-scsi-pci", "id": "scsi1", "iothread": "iothread1"}}
>  {"return": {}}
> +{"execute": "device_add", "arguments": {"bus": "scsi0.0", "drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
>  {"return": {}}
> +{"execute": "device_add", "arguments": {"bus": "scsi1.0", "drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd1"}}
>  {"error": {"class": "GenericError", "desc": "Cannot change iothread of active block backend"}}
> +{"execute": "device_del", "arguments": {"id": "scsi-hd0"}}
>  {"return": {}}
> +{"execute": "device_add", "arguments": {"bus": "scsi1.0", "drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd1"}}
>  {"return": {}}
> +{"execute": "device_del", "arguments": {"id": "scsi-hd1"}}
>  {"return": {}}
> +{"execute": "device_del", "arguments": {"id": "scsi1"}}
>  {"return": {}}
> +{"execute": "device_del", "arguments": {"id": "scsi0"}}
>  {"return": {}}
> +{"execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
>  {"return": {}}
> +==Attach a SCSI disks using the same block device as a NBD server==
> +{"execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0", "read-only": true, "read-zeroes": true}}
>  {"return": {}}
> -
> -=== Attach a SCSI disks using the same block device as a NBD server ===
> -
> -Testing:
> -QMP_VERSION
> -{"return": {}}
> -{"return": {}}
> +{"execute": "nbd-server-start", "arguments": {"addr": {"data": {"path": "SOCK_DIR/PID-nbd.sock"}, "type": "unix"}}}
>  {"return": {}}
> +{"execute": "nbd-server-add", "arguments": {"device": "hd0"}}
>  {"return": {}}
> +{"execute": "object-add", "arguments": {"id": "iothread0", "qom-type": "iothread"}}
>  {"return": {}}
> +{"execute": "device_add", "arguments": {"driver": "virtio-scsi-pci", "id": "scsi0", "iothread": "iothread0"}}
>  {"return": {}}
> +{"execute": "device_add", "arguments": {"drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
>  {"return": {}}
> -{"return": {}}
> -*** done
> +....
> +----------------------------------------------------------------------
> +Ran 4 tests
> +
> +OK
> 

