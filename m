Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23F6C388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB0D208B6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRQ5TiBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB0D208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZvpg-0006Yb-5p
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:54:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kZvoN-0005WH-Ry
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:53:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kZvoL-0002nT-BX
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:53:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604407996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WxeRgbplkRVU2pHLy2Jvm2HeI+ABnVdTCG4ffvtD3dw=;
 b=XRQ5TiBaHfv8Yvdfamrjxi7R1o5uL0lINxo8ycB08Eo8TTOgP2FelHJBXUzqlQz+9zCLJT
 LCTXKeiogjpeqaTTZoNXxP/Wd+B52cKetYZQ2pPmwdSCitPEYwq5lbIdyp7d7XQwQ8R7/h
 bdJPfyIh/esXbKIGTHx7Zr8NOa1cQ7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-p9EYLA9JOhK2Luylu25ZZA-1; Tue, 03 Nov 2020 07:53:14 -0500
X-MC-Unique: p9EYLA9JOhK2Luylu25ZZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CCC3188C135;
 Tue,  3 Nov 2020 12:53:13 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.195.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BB3C19C4F;
 Tue,  3 Nov 2020 12:53:07 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] iotests: rewrite iotest 240 in python
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20201101161532.259609-1-mlevitsk@redhat.com>
 <20201101161532.259609-3-mlevitsk@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <be54a033-9672-052f-e45a-9d3322dd60a0@redhat.com>
Date: Tue, 3 Nov 2020 13:53:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201101161532.259609-3-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01.11.20 17:15, Maxim Levitsky wrote:
> The recent changes that brought RCU delayed device deletion,
> broke few tests and this test breakage went unnoticed.
> 
> Fix this test by rewriting it in python
> (which allows to wait for DEVICE_DELETED events before continuing).
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  tests/qemu-iotests/240     | 228 ++++++++++++++++---------------------
>  tests/qemu-iotests/240.out |  76 ++++++++-----
>  2 files changed, 143 insertions(+), 161 deletions(-)
> 
> diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
> index 8b4337b58d..bfc9b72f36 100755
> --- a/tests/qemu-iotests/240
> +++ b/tests/qemu-iotests/240

[...]

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

It seems to me like all tests create a null-co block device.  The only
difference is that test1() creates an R/W node, whereas all others
create an RO node.  I don’t think that matters though, so maybe we can
replace code duplication by creating the (RO) null-co node here.

Furthermore, we could also create two I/O threads and two accompanying
virtio-scsi devices here (tests that don’t use them shouldn’t care)...

> +
> +    def tearDown(self):

...and clean all of those up here.

> +        self.vm.shutdown()
> +
> +    def test1(self):
> +        iotests.log('==Unplug a SCSI disk and then plug it again==')
> +        self.vm.qmp_log('blockdev-add', driver='null-co', read_zeroes=True, node_name='hd0')
> +        self.vm.qmp_log('object-add', qom_type='iothread', id="iothread0")
> +        self.vm.qmp_log('device_add', id='scsi0', driver=iotests.get_virtio_scsi_device(), iothread='iothread0', filters = [iotests.filter_qmp_virtio_scsi])

A bit weird that you change your coding style for the @filters parameter
(i.e., putting spaces around '='), and pylint thinks so, too.

> +        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0')
> +        self.vm.qmp_log('device_del', id='scsi-hd0')
> +        self.vm.event_wait('DEVICE_DELETED')
> +        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0')
> +        self.vm.qmp_log('device_del', id='scsi-hd0')
> +        self.vm.event_wait('DEVICE_DELETED')
> +        self.vm.qmp_log('device_del', id='scsi0')

I don’t think it makes a difference for this test, but perhaps it would
be cleaner to wait for the DEVICE_DELETED event even for the virtio-scsi
devices?

> +        self.vm.qmp_log('blockdev-del', node_name='hd0')
> +
> +    def test2(self):
> +        iotests.log('==Attach two SCSI disks using the same block device and the same iothread==')
> +        self.vm.qmp_log('blockdev-add', driver='null-co', read_zeroes=True, node_name='hd0', read_only=True)
> +        self.vm.qmp_log('object-add', qom_type='iothread', id="iothread0")
> +        self.vm.qmp_log('device_add', id='scsi0', driver=iotests.get_virtio_scsi_device(), iothread='iothread0', filters = [iotests.filter_qmp_virtio_scsi])
> +
> +        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0')
> +        self.vm.qmp_log('device_add', id='scsi-hd1', driver='scsi-hd', drive='hd0')
> +        self.vm.qmp_log('device_del', id='scsi-hd1')
> +        self.vm.event_wait('DEVICE_DELETED')
> +        self.vm.qmp_log('device_del', id='scsi-hd0')
> +        self.vm.event_wait('DEVICE_DELETED')

The bash version deleted them the other way around, but I suppose it
doesn’t matter.  (It just made me wonder why you changed the order.)

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
> +        self.vm.qmp_log('device_add', id='scsi0', driver=iotests.get_virtio_scsi_device(), iothread='iothread0', filters = [iotests.filter_qmp_virtio_scsi])
> +        self.vm.qmp_log('device_add', id='scsi1', driver=iotests.get_virtio_scsi_device(), iothread='iothread1', filters = [iotests.filter_qmp_virtio_scsi])
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
> +        self.vm.qmp_log('device_add', id='scsi0', driver=iotests.get_virtio_scsi_device(), iothread='iothread0', filters = [iotests.filter_qmp_virtio_scsi])
> +        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0')
> +
> +
> +if __name__ == '__main__':
> +    if 'null-co' not in iotests.supported_formats():
> +        iotests.notrun('null-co driver support missing')

I suppose it isn’t wrong to check this in two places (in the setUp()
decorator, and then here again), but it doesn’t seem necessary either.

Max

> +    iotests.activate_logging()
> +    iotests.main()


