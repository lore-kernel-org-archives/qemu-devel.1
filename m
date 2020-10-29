Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCA7C55178
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 12:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 215082076A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 12:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/rbxIEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215082076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY78s-0000KS-2y
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 08:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kY76o-0007Y7-7r
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 08:32:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kY76k-0005ka-6m
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 08:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603974764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qLjd5P/dHaWNDKc5e6d5BQsAKbU6p09h9W2bi3xRtKI=;
 b=d/rbxIEwGHjTzDlXiagyB9slIGwQHmfAG7FLK8yzDpVEhWNQDNjMnbuO8Onu5eWN2M6QnQ
 mpX3TAuZMlMNb8FJWbrIPx0naIuPRjXbsPljh24oRmrTHwRXHRG4ETSbseLYUVbWxa0prB
 ykmFnaEHe0g2Ka3cqjPmcph5RHvW3Ik=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-rM8nT00yPe66ClAgNctK-w-1; Thu, 29 Oct 2020 08:32:42 -0400
X-MC-Unique: rM8nT00yPe66ClAgNctK-w-1
Received: by mail-wr1-f70.google.com with SMTP id i6so1211857wrx.11
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 05:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qLjd5P/dHaWNDKc5e6d5BQsAKbU6p09h9W2bi3xRtKI=;
 b=VGJwGNE/2oVLowbTwO8RFX4+kU5P0EvlksuTWci96X9pI9QG8igUeOPjm6/5ryWUli
 sLqUUtO/JyaPp0Yx/ocdpHI8+mG+mxLfaWDXoUnnOGR27U0VBZ0cFwv32vVdQH3B6maX
 37UqKL38jzLTvdQ3znzn6C+SA06UCEKuZHvEXmluRa+elL6HZYoljdmlB8cSUDZ1fhRo
 FynXILh7lrHac/i43sSKxz236E+d1bwsK0kfkJ+BPYtCuQNcmq3lT47BaztmLVpKzycR
 ldv7a8MfPlgveQT5TYz6rViKjJ/OpXomHkLvPwvltXFm7YsZoBZUK7MWMXfVuQNUVD7Y
 ybAg==
X-Gm-Message-State: AOAM530j+fLFc6w82R4j/aOgFTJ3bRNneZ7s9mPt7N+WZimAZTEIf4+Z
 KFXJfjaV6Kuy9Y6Qgvg+DuOfEK/jr3nx21pQwnF4hKKhM+U/hT2IUFRbR3GdrfMP8ZU6BVJf1NJ
 QY1jyss0aiqWBD+s=
X-Received: by 2002:adf:c3c2:: with SMTP id d2mr5504075wrg.191.1603974760993; 
 Thu, 29 Oct 2020 05:32:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrRNnXbhhIVWyRvF7qLNgSXwfJikdCWwVkewdNVr+oMbKVXUmQmGnJQFEl9bbXsp66rcmZHA==
X-Received: by 2002:adf:c3c2:: with SMTP id d2mr5504030wrg.191.1603974760683; 
 Thu, 29 Oct 2020 05:32:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id p1sm4754839wrx.3.2020.10.29.05.32.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 05:32:40 -0700 (PDT)
Subject: Re: [PATCH 4/4] iotests: rewrite iotest 240 in python
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20201019163702.471239-1-mlevitsk@redhat.com>
 <20201019163702.471239-5-mlevitsk@redhat.com>
 <214647b0-c745-0941-ba66-8248d915a156@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f0eb66e3-f9bb-abd4-bf68-268245a43577@redhat.com>
Date: Thu, 29 Oct 2020 13:32:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <214647b0-c745-0941-ba66-8248d915a156@de.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/10/20 12:16, Christian Borntraeger wrote:
> On 19.10.20 18:37, Maxim Levitsky wrote:
>> The recent changes that brought RCU delayed device deletion,
>> broke few tests and this test breakage went unnoticed.
>>
>> Fix this test by rewriting it in python
>> (which allows to wait for DEVICE_DELETED events before continuing).
> 
> While this is now fine for x86, this seems to not cover the s390 specific ccw bus:

You can add a filter to qmp_log calls that do device_add, for example

  filters=((lambda x: x.replace("virtio-scsi-ccw", "virtio-scsi-pci")),)

Paolo

> --- /home/cborntra/REPOS/qemu/tests/qemu-iotests/240.out	2020-10-29 12:14:42.409233949 +0100
> +++ /home/cborntra/REPOS/qemu/build/240.out.bad	2020-10-29 12:15:29.309233949 +0100
> @@ -3,7 +3,7 @@
>  {"return": {}}
>  {"execute": "object-add", "arguments": {"id": "iothread0", "qom-type": "iothread"}}
>  {"return": {}}
> -{"execute": "device_add", "arguments": {"driver": "virtio-scsi-pci", "id": "scsi0", "iothread": "iothread0"}}
> +{"execute": "device_add", "arguments": {"driver": "virtio-scsi-ccw", "id": "scsi0", "iothread": "iothread0"}}
>  {"return": {}}
>  {"execute": "device_add", "arguments": {"drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
>  {"return": {}}
> @@ -22,7 +22,7 @@
>  {"return": {}}
>  {"execute": "object-add", "arguments": {"id": "iothread0", "qom-type": "iothread"}}
>  {"return": {}}
> -{"execute": "device_add", "arguments": {"driver": "virtio-scsi-pci", "id": "scsi0", "iothread": "iothread0"}}
> +{"execute": "device_add", "arguments": {"driver": "virtio-scsi-ccw", "id": "scsi0", "iothread": "iothread0"}}
>  {"return": {}}
>  {"execute": "device_add", "arguments": {"drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
>  {"return": {}}
> @@ -43,9 +43,9 @@
>  {"return": {}}
>  {"execute": "object-add", "arguments": {"id": "iothread1", "qom-type": "iothread"}}
>  {"return": {}}
> -{"execute": "device_add", "arguments": {"driver": "virtio-scsi-pci", "id": "scsi0", "iothread": "iothread0"}}
> +{"execute": "device_add", "arguments": {"driver": "virtio-scsi-ccw", "id": "scsi0", "iothread": "iothread0"}}
>  {"return": {}}
> -{"execute": "device_add", "arguments": {"driver": "virtio-scsi-pci", "id": "scsi1", "iothread": "iothread1"}}
> +{"execute": "device_add", "arguments": {"driver": "virtio-scsi-ccw", "id": "scsi1", "iothread": "iothread1"}}
>  {"return": {}}
>  {"execute": "device_add", "arguments": {"bus": "scsi0.0", "drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
>  {"return": {}}
> @@ -72,7 +72,7 @@
>  {"return": {}}
>  {"execute": "object-add", "arguments": {"id": "iothread0", "qom-type": "iothread"}}
>  {"return": {}}
> -{"execute": "device_add", "arguments": {"driver": "virtio-scsi-pci", "id": "scsi0", "iothread": "iothread0"}}
> +{"execute": "device_add", "arguments": {"driver": "virtio-scsi-ccw", "id": "scsi0", "iothread": "iothread0"}}
>  {"return": {}}
>  {"execute": "device_add", "arguments": {"drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
>  {"return": {}}
> Failures: 240
> Failed 1 of 1 iotests
> 
>>
>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>> ---
>>  tests/qemu-iotests/240     | 228 ++++++++++++++++---------------------
>>  tests/qemu-iotests/240.out |  76 ++++++++-----
>>  2 files changed, 143 insertions(+), 161 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
>> index 8b4337b58d..a739de6769 100755
>> --- a/tests/qemu-iotests/240
>> +++ b/tests/qemu-iotests/240
>> @@ -1,5 +1,5 @@
>> -#!/usr/bin/env bash
>> -#
>> +#!/usr/bin/env python3
>> +
>>  # Test hot plugging and unplugging with iothreads
>>  #
>>  # Copyright (C) 2019 Igalia, S.L.
>> @@ -17,133 +17,99 @@
>>  #
>>  # You should have received a copy of the GNU General Public License
>>  # along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> -#
>>  
>> -# creator
>> -owner=berto@igalia.com
>> -
>> -seq=`basename $0`
>> -echo "QA output created by $seq"
>> -
>> -status=1	# failure is the default!
>> -
>> -_cleanup()
>> -{
>> -    rm -f "$SOCK_DIR/nbd"
>> -}
>> -trap "_cleanup; exit \$status" 0 1 2 3 15
>> -
>> -# get standard environment, filters and checks
>> -. ./common.rc
>> -. ./common.filter
>> -
>> -_supported_fmt generic
>> -_supported_proto generic
>> -
>> -do_run_qemu()
>> -{
>> -    echo Testing: "$@"
>> -    $QEMU -nographic -qmp stdio -serial none "$@"
>> -    echo
>> -}
>> -
>> -# Remove QMP events from (pretty-printed) output. Doesn't handle
>> -# nested dicts correctly, but we don't get any of those in this test.
>> -_filter_qmp_events()
>> -{
>> -    tr '\n' '\t' | sed -e \
>> -	's/{\s*"timestamp":\s*{[^}]*},\s*"event":[^,}]*\(,\s*"data":\s*{[^}]*}\)\?\s*}\s*//g' \
>> -	| tr '\t' '\n'
>> -}
>> -
>> -run_qemu()
>> -{
>> -    do_run_qemu "$@" 2>&1 | _filter_qmp | _filter_qmp_events
>> -}
>> -
>> -case "$QEMU_DEFAULT_MACHINE" in
>> -  s390-ccw-virtio)
>> -      virtio_scsi=virtio-scsi-ccw
>> -      ;;
>> -  *)
>> -      virtio_scsi=virtio-scsi-pci
>> -      ;;
>> -esac
>> -
>> -echo
>> -echo === Unplug a SCSI disk and then plug it again ===
>> -echo
>> -
>> -run_qemu <<EOF
>> -{ "execute": "qmp_capabilities" }
>> -{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-zeroes": true, "node-name": "hd0"}}
>> -{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
>> -{ "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${virtio_scsi}", "iothread": "iothread0"}}
>> -{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0"}}
>> -{ "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
>> -{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0"}}
>> -{ "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
>> -{ "execute": "device_del", "arguments": {"id": "scsi0"}}
>> -{ "execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
>> -{ "execute": "quit"}
>> -EOF
>> -
>> -echo
>> -echo === Attach two SCSI disks using the same block device and the same iothread ===
>> -echo
>> -
>> -run_qemu <<EOF
>> -{ "execute": "qmp_capabilities" }
>> -{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-zeroes": true, "node-name": "hd0", "read-only": true}}
>> -{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
>> -{ "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${virtio_scsi}", "iothread": "iothread0"}}
>> -{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0"}}
>> -{ "execute": "device_add", "arguments": {"id": "scsi-hd1", "driver": "scsi-hd", "drive": "hd0"}}
>> -{ "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
>> -{ "execute": "device_del", "arguments": {"id": "scsi-hd1"}}
>> -{ "execute": "device_del", "arguments": {"id": "scsi0"}}
>> -{ "execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
>> -{ "execute": "quit"}
>> -EOF
>> -
>> -echo
>> -echo === Attach two SCSI disks using the same block device but different iothreads ===
>> -echo
>> -
>> -run_qemu <<EOF
>> -{ "execute": "qmp_capabilities" }
>> -{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-zeroes": true, "node-name": "hd0", "read-only": true}}
>> -{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
>> -{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread1"}}
>> -{ "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${virtio_scsi}", "iothread": "iothread0"}}
>> -{ "execute": "device_add", "arguments": {"id": "scsi1", "driver": "${virtio_scsi}", "iothread": "iothread1"}}
>> -{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0", "bus": "scsi0.0"}}
>> -{ "execute": "device_add", "arguments": {"id": "scsi-hd1", "driver": "scsi-hd", "drive": "hd0", "bus": "scsi1.0"}}
>> -{ "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
>> -{ "execute": "device_add", "arguments": {"id": "scsi-hd1", "driver": "scsi-hd", "drive": "hd0", "bus": "scsi1.0"}}
>> -{ "execute": "device_del", "arguments": {"id": "scsi-hd1"}}
>> -{ "execute": "device_del", "arguments": {"id": "scsi0"}}
>> -{ "execute": "device_del", "arguments": {"id": "scsi1"}}
>> -{ "execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
>> -{ "execute": "quit"}
>> -EOF
>> -
>> -echo
>> -echo === Attach a SCSI disks using the same block device as a NBD server ===
>> -echo
>> -
>> -run_qemu <<EOF
>> -{ "execute": "qmp_capabilities" }
>> -{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-zeroes": true, "node-name": "hd0", "read-only": true}}
>> -{ "execute": "nbd-server-start", "arguments": {"addr":{"type":"unix","data":{"path":"$SOCK_DIR/nbd"}}}}
>> -{ "execute": "nbd-server-add", "arguments": {"device":"hd0"}}
>> -{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
>> -{ "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${virtio_scsi}", "iothread": "iothread0"}}
>> -{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0", "bus": "scsi0.0"}}
>> -{ "execute": "quit"}
>> -EOF
>> -
>> -# success, all done
>> -echo "*** done"
>> -rm -f $seq.full
>> -status=0
>> +import iotests
>> +import os
>> +
>> +nbd_sock = iotests.file_path('nbd.sock', base_dir=iotests.sock_dir)
>> +
>> +class TestCase(iotests.QMPTestCase):
>> +    test_driver = "null-co"
>> +
>> +    def required_drivers(self):
>> +        return [self.test_driver]
>> +
>> +    @iotests.skip_if_unsupported(required_drivers)
>> +    def setUp(self):
>> +        self.vm = iotests.VM()
>> +        self.vm.launch()
>> +
>> +    def tearDown(self):
>> +        self.vm.shutdown()
>> +
>> +    def test1(self):
>> +        iotests.log('==Unplug a SCSI disk and then plug it again==')
>> +        self.vm.qmp_log('blockdev-add', driver='null-co', read_zeroes=True, node_name='hd0')
>> +        self.vm.qmp_log('object-add', qom_type='iothread', id="iothread0")
>> +        self.vm.qmp_log('device_add', id='scsi0', driver=iotests.get_virtio_scsi_device(), iothread='iothread0')
>> +        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0')
>> +        self.vm.qmp_log('device_del', id='scsi-hd0')
>> +        self.vm.event_wait('DEVICE_DELETED')
>> +        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0')
>> +        self.vm.qmp_log('device_del', id='scsi-hd0')
>> +        self.vm.event_wait('DEVICE_DELETED')
>> +        self.vm.qmp_log('device_del', id='scsi0')
>> +        self.vm.qmp_log('blockdev-del', node_name='hd0')
>> +
>> +    def test2(self):
>> +        iotests.log('==Attach two SCSI disks using the same block device and the same iothread==')
>> +        self.vm.qmp_log('blockdev-add', driver='null-co', read_zeroes=True, node_name='hd0', read_only=True)
>> +        self.vm.qmp_log('object-add', qom_type='iothread', id="iothread0")
>> +        self.vm.qmp_log('device_add', id='scsi0', driver=iotests.get_virtio_scsi_device(), iothread='iothread0')
>> +
>> +        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0')
>> +        self.vm.qmp_log('device_add', id='scsi-hd1', driver='scsi-hd', drive='hd0')
>> +        self.vm.qmp_log('device_del', id='scsi-hd1')
>> +        self.vm.event_wait('DEVICE_DELETED')
>> +        self.vm.qmp_log('device_del', id='scsi-hd0')
>> +        self.vm.event_wait('DEVICE_DELETED')
>> +        self.vm.qmp_log('device_del', id='scsi0')
>> +        self.vm.qmp_log('blockdev-del', node_name='hd0')
>> +
>> +    def test3(self):
>> +        iotests.log('==Attach two SCSI disks using the same block device but different iothreads==')
>> +
>> +        self.vm.qmp_log('blockdev-add', driver='null-co', read_zeroes=True, node_name='hd0', read_only=True)
>> +
>> +        self.vm.qmp_log('object-add', qom_type='iothread', id="iothread0")
>> +        self.vm.qmp_log('object-add', qom_type='iothread', id="iothread1")
>> +
>> +        self.vm.qmp_log('device_add', id='scsi0', driver=iotests.get_virtio_scsi_device(), iothread='iothread0')
>> +        self.vm.qmp_log('device_add', id='scsi1', driver=iotests.get_virtio_scsi_device(), iothread='iothread1')
>> +
>> +        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0', bus="scsi0.0")
>> +        self.vm.qmp_log('device_add', id='scsi-hd1', driver='scsi-hd', drive='hd0', bus="scsi1.0")
>> +
>> +        self.vm.qmp_log('device_del', id='scsi-hd0')
>> +        self.vm.event_wait('DEVICE_DELETED')
>> +        self.vm.qmp_log('device_add', id='scsi-hd1', driver='scsi-hd', drive='hd0', bus="scsi1.0")
>> +
>> +        self.vm.qmp_log('device_del', id='scsi-hd1')
>> +        self.vm.event_wait('DEVICE_DELETED')
>> +
>> +        self.vm.qmp_log('device_del', id='scsi1')
>> +        self.vm.qmp_log('device_del', id='scsi0')
>> +
>> +        self.vm.qmp_log('blockdev-del', node_name='hd0')
>> +
>> +    def test4(self):
>> +        iotests.log('==Attach a SCSI disks using the same block device as a NBD server==')
>> +
>> +        self.vm.qmp_log('blockdev-add', driver='null-co', read_zeroes=True, node_name='hd0', read_only=True)
>> +
>> +        self.vm.qmp_log('nbd-server-start',
>> +                        filters=[iotests.filter_qmp_testfiles],
>> +                        addr={'type':'unix', 'data':{'path':nbd_sock}})
>> +
>> +        self.vm.qmp_log('nbd-server-add', device='hd0')
>> +
>> +        self.vm.qmp_log('object-add', qom_type='iothread', id="iothread0")
>> +        self.vm.qmp_log('device_add', id='scsi0', driver=iotests.get_virtio_scsi_device(), iothread='iothread0')
>> +        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0')
>> +
>> +
>> +if __name__ == '__main__':
>> +    if 'null-co' not in iotests.supported_formats():
>> +        iotests.notrun('null-co driver support missing')
>> +    iotests.activate_logging()
>> +    iotests.main()
>> diff --git a/tests/qemu-iotests/240.out b/tests/qemu-iotests/240.out
>> index d00df50297..24847be6b3 100644
>> --- a/tests/qemu-iotests/240.out
>> +++ b/tests/qemu-iotests/240.out
>> @@ -1,67 +1,83 @@
>> -QA output created by 240
>> -
>> -=== Unplug a SCSI disk and then plug it again ===
>> -
>> -Testing:
>> -QMP_VERSION
>> -{"return": {}}
>> +==Unplug a SCSI disk and then plug it again==
>> +{"execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0", "read-zeroes": true}}
>>  {"return": {}}
>> +{"execute": "object-add", "arguments": {"id": "iothread0", "qom-type": "iothread"}}
>>  {"return": {}}
>> +{"execute": "device_add", "arguments": {"driver": "virtio-scsi-pci", "id": "scsi0", "iothread": "iothread0"}}
>>  {"return": {}}
>> +{"execute": "device_add", "arguments": {"drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
>>  {"return": {}}
>> +{"execute": "device_del", "arguments": {"id": "scsi-hd0"}}
>>  {"return": {}}
>> +{"execute": "device_add", "arguments": {"drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
>>  {"return": {}}
>> +{"execute": "device_del", "arguments": {"id": "scsi-hd0"}}
>>  {"return": {}}
>> +{"execute": "device_del", "arguments": {"id": "scsi0"}}
>>  {"return": {}}
>> +{"execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
>>  {"return": {}}
>> +==Attach two SCSI disks using the same block device and the same iothread==
>> +{"execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0", "read-only": true, "read-zeroes": true}}
>>  {"return": {}}
>> -
>> -=== Attach two SCSI disks using the same block device and the same iothread ===
>> -
>> -Testing:
>> -QMP_VERSION
>> +{"execute": "object-add", "arguments": {"id": "iothread0", "qom-type": "iothread"}}
>>  {"return": {}}
>> +{"execute": "device_add", "arguments": {"driver": "virtio-scsi-pci", "id": "scsi0", "iothread": "iothread0"}}
>>  {"return": {}}
>> +{"execute": "device_add", "arguments": {"drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
>>  {"return": {}}
>> +{"execute": "device_add", "arguments": {"drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd1"}}
>>  {"return": {}}
>> +{"execute": "device_del", "arguments": {"id": "scsi-hd1"}}
>>  {"return": {}}
>> +{"execute": "device_del", "arguments": {"id": "scsi-hd0"}}
>>  {"return": {}}
>> +{"execute": "device_del", "arguments": {"id": "scsi0"}}
>>  {"return": {}}
>> +{"execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
>>  {"return": {}}
>> +==Attach two SCSI disks using the same block device but different iothreads==
>> +{"execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0", "read-only": true, "read-zeroes": true}}
>>  {"return": {}}
>> +{"execute": "object-add", "arguments": {"id": "iothread0", "qom-type": "iothread"}}
>>  {"return": {}}
>> +{"execute": "object-add", "arguments": {"id": "iothread1", "qom-type": "iothread"}}
>>  {"return": {}}
>> -
>> -=== Attach two SCSI disks using the same block device but different iothreads ===
>> -
>> -Testing:
>> -QMP_VERSION
>> -{"return": {}}
>> -{"return": {}}
>> -{"return": {}}
>> -{"return": {}}
>> +{"execute": "device_add", "arguments": {"driver": "virtio-scsi-pci", "id": "scsi0", "iothread": "iothread0"}}
>>  {"return": {}}
>> +{"execute": "device_add", "arguments": {"driver": "virtio-scsi-pci", "id": "scsi1", "iothread": "iothread1"}}
>>  {"return": {}}
>> +{"execute": "device_add", "arguments": {"bus": "scsi0.0", "drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
>>  {"return": {}}
>> +{"execute": "device_add", "arguments": {"bus": "scsi1.0", "drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd1"}}
>>  {"error": {"class": "GenericError", "desc": "Cannot change iothread of active block backend"}}
>> +{"execute": "device_del", "arguments": {"id": "scsi-hd0"}}
>>  {"return": {}}
>> +{"execute": "device_add", "arguments": {"bus": "scsi1.0", "drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd1"}}
>>  {"return": {}}
>> +{"execute": "device_del", "arguments": {"id": "scsi-hd1"}}
>>  {"return": {}}
>> +{"execute": "device_del", "arguments": {"id": "scsi1"}}
>>  {"return": {}}
>> +{"execute": "device_del", "arguments": {"id": "scsi0"}}
>>  {"return": {}}
>> +{"execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
>>  {"return": {}}
>> +==Attach a SCSI disks using the same block device as a NBD server==
>> +{"execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0", "read-only": true, "read-zeroes": true}}
>>  {"return": {}}
>> -
>> -=== Attach a SCSI disks using the same block device as a NBD server ===
>> -
>> -Testing:
>> -QMP_VERSION
>> -{"return": {}}
>> -{"return": {}}
>> +{"execute": "nbd-server-start", "arguments": {"addr": {"data": {"path": "SOCK_DIR/PID-nbd.sock"}, "type": "unix"}}}
>>  {"return": {}}
>> +{"execute": "nbd-server-add", "arguments": {"device": "hd0"}}
>>  {"return": {}}
>> +{"execute": "object-add", "arguments": {"id": "iothread0", "qom-type": "iothread"}}
>>  {"return": {}}
>> +{"execute": "device_add", "arguments": {"driver": "virtio-scsi-pci", "id": "scsi0", "iothread": "iothread0"}}
>>  {"return": {}}
>> +{"execute": "device_add", "arguments": {"drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
>>  {"return": {}}
>> -{"return": {}}
>> -*** done
>> +....
>> +----------------------------------------------------------------------
>> +Ran 4 tests
>> +
>> +OK
>>
> 


